Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 0/2] iio:kxsd9 basic driver move out of staging
Date: Sun,  6 Jan 2013 15:10:15 +0000
Message-Id: <1357485017-27916-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

This is a simple driver I wrote as a proof of concept a long
time ago.  Whilst it only supports the basics, it might as
well move out of staging as there is nothing particularly
interesting or controversial in it!

The first patch does a bit of trivial cleanup and avoids
a theoretical race condition.

Jonathan Cameron (2):
  staging:iio:accel:kxsd9
  iio:accel:kxsd9 move out of staging

 drivers/iio/accel/Kconfig               |  7 +++++++
 drivers/iio/accel/Makefile              |  1 +
 drivers/{staging => }/iio/accel/kxsd9.c | 10 +++++-----
 drivers/staging/iio/accel/Kconfig       |  7 -------
 drivers/staging/iio/accel/Makefile      |  2 --
 5 files changed, 13 insertions(+), 14 deletions(-)
 rename drivers/{staging => }/iio/accel/kxsd9.c (99%)

-- 
1.8.1
