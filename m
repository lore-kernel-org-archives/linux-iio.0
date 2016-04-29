Return-Path: <ksenija.stanojevic@gmail.com>
From: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: lee.jones@linaro.org,
	dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	marex@denx.de,
	linux-iio@vger.kernel.org,
	harald@ccbib.org,
	Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Subject: [PATCH 0/3] mxs-lradc: Split driver into MFD
Date: Fri, 29 Apr 2016 13:46:14 +0200
Message-Id: <cover.1461930102.git.ksenija.stanojevic@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Split existing driver mxs-lradc into MFD with touchscreen and
IIO part.

Tested on I.MX28.

Ksenija Stanojevic (3):
  mfd: mxs-lradc: Add support for mxs-lradc MFD
  iio: adc: mxs-lradc: Add support for adc driver
  input: touchscreen: mxs-lradc: Add support for touchscreen

 drivers/iio/adc/Kconfig                  |  37 +-
 drivers/iio/adc/Makefile                 |   1 +
 drivers/iio/adc/mxs-lradc-adc.c          | 832 +++++++++++++++++++++++++++++++
 drivers/input/touchscreen/Kconfig        |  14 +-
 drivers/input/touchscreen/Makefile       |   1 +
 drivers/input/touchscreen/mxs-lradc-ts.c | 729 +++++++++++++++++++++++++++
 drivers/mfd/Kconfig                      |  33 +-
 drivers/mfd/Makefile                     |   1 +
 drivers/mfd/mxs-lradc.c                  | 213 ++++++++
 include/linux/mfd/mxs-lradc.h            | 210 ++++++++
 10 files changed, 2049 insertions(+), 22 deletions(-)
 create mode 100644 drivers/iio/adc/mxs-lradc-adc.c
 create mode 100644 drivers/input/touchscreen/mxs-lradc-ts.c
 create mode 100644 drivers/mfd/mxs-lradc.c
 create mode 100644 include/linux/mfd/mxs-lradc.h

-- 
1.9.1
