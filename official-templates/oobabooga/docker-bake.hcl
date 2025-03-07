variable "RELEASE" {
    default = "1.2.2"
}

variable "PUBLISHER" {
    default = "kethertiphereth"
}

target "default" {
    dockerfile = "Dockerfile"
    tags = ["${PUBLISHER}/oobabooga:${RELEASE}"]
    contexts = {
        scripts = "../../container-template"
        proxy = "../../container-template/proxy"
    }
    args = {
        BASE_IMAGE = "runpod/pytorch:3.10-1.13.1-116"
        OOBABOOGA_REQUIREMENTS_FILE = "requirements.txt"
    }
}

target "default-rocm" {
    dockerfile = "Dockerfile"
    tags = ["${PUBLISHER}/oobabooga:${RELEASE}-rocm"]
    contexts = {
        scripts = "../../container-template"
        proxy = "../../container-template/proxy"
    }
    args = {
        BASE_IMAGE = "kethertiphereth/pytorch:2.4.0-py3.10-rocm6.3.3-ubuntu22.04"
        OOBABOOGA_REQUIREMENTS_FILE = "requirements_amd.txt"
    }
}
