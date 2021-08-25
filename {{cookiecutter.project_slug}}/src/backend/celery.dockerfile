# Dockerfile
# pull official base image
FROM python:3.9.6
# accept arguments
ARG PIP_REQUIREMENTS=production.txt
ARG USER

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1


# install dependencies
RUN pip install --upgrade pip setuptools wheel
# create user for the Django project

# Add user that will be used in the container.
# RUN useradd ${USER}
RUN useradd -ms /bin/bash ${USER}

# Use user ${DATABASE_USER} to run the build commands below and the server itself.
USER ${USER}

# Use /home/${DATABASE_USER} folder as a directory where the source code is stored.
WORKDIR /home/${USER}

# create and activate virtual environment
RUN python3 -m venv venv

RUN ./venv/bin/python3 -m pip install pip setuptools wheel --upgrade

# copy and install pip requirements
COPY --chown=${USER} ./requirements /home/${USER}/requirements/
RUN ./venv/bin/pip3 install -r /home/${USER}/requirements/${PIP_REQUIREMENTS}


# copy Django project files
COPY --chown=${USER} ./ /home/${USER}/
