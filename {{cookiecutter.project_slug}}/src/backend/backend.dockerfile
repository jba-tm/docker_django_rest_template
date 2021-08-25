# Dockerfile
# pull official base image
FROM python:3.9.6
# accept arguments
ARG USER

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1


# install dependencies
RUN pip install --upgrade pip setuptools wheel
RUN pip install pipenv

# Add user that will be used in the container.
# RUN useradd ${USER}
RUN useradd -ms /bin/bash ${USER}

# Use user ${DATABASE_USER} to run the build commands below and the server itself.
USER ${USER}

# Use /home/${DATABASE_USER} folder as a directory where the source code is stored.
WORKDIR /home/${USER}

# copy Django project files
COPY --chown=${USER} . .

# Allow installing dev dependencies to run tests
ARG INSTALL_DEV=false

# create and activate virtual environment
RUN bash -c "if [ $INSTALL_DEV == 'true' ] ; then pipenv install --system --deploy -e . ; else pipenv install --dev -e . ; fi"
RUN pipenv shell


COPY ./server-start.sh ./server-start.sh

RUN chmod +x ./server-start.sh

CMD ["bash", "./worker-start.sh"]
