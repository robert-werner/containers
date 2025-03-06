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
        BASE_IMAGE = "rocm/pytorch:rocm6.3.3_ubuntu22.04_py3.10_pytorch_release_2.4.0"
        OOBABOOGA_REQUIREMENTS_FILE = "requirements_amd.txt"
    }
}
