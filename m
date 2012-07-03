Return-Path: <sha@pengutronix.de>
From: Sascha Hauer <s.hauer@pengutronix.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>,
	Sonic Zhang <sonic.zhang@analog.com>
Subject: [PATCH] staging iio adt7410: some improvements
Date: Tue,  3 Jul 2012 11:21:25 +0200
Message-Id: <1341307288-1926-1-git-send-email-s.hauer@pengutronix.de>
List-ID: <linux-iio@vger.kernel.org>

Hi All,

The following contains some fixes/improvements to the adt7410
digital temperature sensor.

Sascha

----------------------------------------------------------------
Sascha Hauer (3):
      staging iio adt7410: sysfs store function must return length
      staging iio adt7410: fix 13bit mode
      staging iio adt7410: make 16bit mode default

 drivers/staging/iio/adc/adt7410.c |   55 ++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 31 deletions(-)
