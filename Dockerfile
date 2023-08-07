FROM pytorch/pytorch:2.0.1-cuda11.7-cudnn8-runtime

LABEL author="NemoSailing" app_name="LoRA Server"

EXPOSE 28000
ENV HF_HOME=huggingface PYTHONUTF8=1

RUN set -eux \
    && apt-get update \
    && apt-get install --no-install-recommends -y libgl1 libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*


WORKDIR /lora
VOLUME [ "/lora/data", "/lora/sd-models" ]
COPY . .

RUN set -eux \
    && pip install --no-cache-dir xformers==0.0.20 --index-url https://pypi.tuna.tsinghua.edu.cn/simple \
    && pip install --no-cache-dir -r requirements.txt --index-url https://pypi.tuna.tsinghua.edu.cn/simple \
    && cd sd-scripts && pip install --no-cache-dir --upgrade -r requirements.txt --index-url https://pypi.tuna.tsinghua.edu.cn/simple \
    && pip install --no-cache-dir --upgrade lion-pytorch lycoris-lora dadaptation prodigyopt fastapi uvicorn wandb onnxruntime-gpu --index-url https://pypi.tuna.tsinghua.edu.cn/simple

CMD ["bash", "run.sh"]


# sudo docker build -t lora:1.0 .
# sudo docker run -d --gpus=all -v ./data:/lora/data -v ./sd-models:/lora/sd-models -p 28000:28000 lora:1.0