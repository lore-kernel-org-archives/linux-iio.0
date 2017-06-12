Return-Path: <SRS0=facI=5R=gmail.com=akinobu.mita@kernel.org>
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 0/2] iio: light: tcs3472: bug fix and iio event handling support
Date: Tue, 13 Jun 2017 00:05:07 +0900
Message-Id: <1497279909-11197-1-git-send-email-akinobu.mita@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This contains a single bug fix and support iio event handling for
tcs3472 driver.

Akinobu Mita (2):
  iio: light: tcs3472: fix ATIME register write
  iio: light: tcs3472: support out-of-threshold events

 drivers/iio/light/tcs3472.c | 271 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 262 insertions(+), 9 deletions(-)

Cc: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Jonathan Cameron <jic23@kernel.org>
-- 
2.7.4
