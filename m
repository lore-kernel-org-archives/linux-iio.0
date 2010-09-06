Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: m_brugger@web.de,
	Michael.Hennerich@analog.com,
	Robin.Getz@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 0/2 V2] Adding support for adis16250/5 to adis16260 driver.
Date: Mon,  6 Sep 2010 16:16:16 +0100
Message-Id: <1283786178-6466-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Mainly a rebase, but a couple of attribute naming fixes as well.

Note I don't have one of these so if anyone could test that would
be great!

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>

Jonathan Cameron (2):
  staging:iio:adis16260 add id table support
  staging:iio:adis16260 add suppport for adis16255 and adis16250.

 drivers/staging/iio/gyro/Kconfig                   |    8 +-
 drivers/staging/iio/gyro/adis16260.h               |    3 +
 drivers/staging/iio/gyro/adis16260_core.c          |  139 ++++++++++++++------
 drivers/staging/iio/gyro/adis16260_platform_data.h |   19 +++
 drivers/staging/iio/gyro/gyro.h                    |    9 ++
 5 files changed, 136 insertions(+), 42 deletions(-)
 create mode 100644 drivers/staging/iio/gyro/adis16260_platform_data.h
