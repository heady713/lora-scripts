FROM pytorch/pytorch:2.0.1-cuda11.7-cudnn8-runtime

LABEL author="NemoSailing"

WORKDIR /lora

RUN set -eux \
    && apt-get update \
    && apt-get install -y git

COPY . .

ENV venv_dir="-" NO_TCMALLOC=1

CMD [ "bash", "webui.sh", "-f" ]