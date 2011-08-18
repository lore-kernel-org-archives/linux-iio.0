Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: michael.hennerich@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH] IIO: Scrap the _DIFF types in favour of a flag in chan spec.
Date: Thu, 18 Aug 2011 13:29:41 +0100
Message-Id: <1313670582-31970-1-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <4E4D00ED.4080106@analog.com>
References: <4E4D00ED.4080106@analog.com>
List-ID: <linux-iio@vger.kernel.org>

This also resorts in a small change to the event codes.

Sits on the capfun branch (because it effects some stuff there).

If people are happy I'll back port it to before the introduction of
the capacitance version thus cleaning the series up.

Jonathan

Jonathan Cameron (1):
  staging:iio: Differential channel handling - use explicit flag rather
    than types.

 drivers/staging/iio/adc/ad7152.c        |    8 +-
 drivers/staging/iio/adc/ad7192.c        |    8 +-
 drivers/staging/iio/adc/ad7793.c        |  176 ++++++++++++++++++++--------
 drivers/staging/iio/adc/max1363_core.c  |  198 ++++++++++++++-----------------
 drivers/staging/iio/iio.h               |    4 +-
 drivers/staging/iio/industrialio-core.c |   40 ++++---
 drivers/staging/iio/sysfs.h             |    8 +-
 7 files changed, 253 insertions(+), 189 deletions(-)

-- 
1.7.3.4
