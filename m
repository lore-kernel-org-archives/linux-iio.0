Return-Path: <jic23@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Roland Stigge <stigge@antcom.de>,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 0/3] staging:iio:adc:lpc32xx cleanup and staging graduation
Date: Sun,  5 Feb 2017 13:06:57 +0000
Message-Id: <20170205130700.5063-1-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

There wasn't a whole lot wrong with this driver.  I suspect we simply
forgot about it.

Anyhow, simple boring cleanups and a move out of staging.

I've dissabled rename detection for the last patch to give an easy way
for people to directly review the code.

Jonathan Cameron (3):
  staging:iio:adc:lpc32xx Apply consistent prefix to local defines
  staging:iio:adc:lpc32xx rename local state structure to _state
  staging:iio:adc:lpc32xx Move out of staging.

 drivers/iio/adc/Kconfig               |  12 ++
 drivers/iio/adc/Makefile              |   1 +
 drivers/iio/adc/lpc32xx_adc.c         | 219 ++++++++++++++++++++++++++++++++++
 drivers/staging/iio/adc/Kconfig       |  12 --
 drivers/staging/iio/adc/Makefile      |   1 -
 drivers/staging/iio/adc/lpc32xx_adc.c | 215 ---------------------------------
 6 files changed, 232 insertions(+), 228 deletions(-)
 create mode 100644 drivers/iio/adc/lpc32xx_adc.c
 delete mode 100644 drivers/staging/iio/adc/lpc32xx_adc.c

-- 
2.11.1
