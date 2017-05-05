Return-Path: <SRS0=kdpb=4L=onstation.org=masneyb@kernel.org>
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	devel@driverdev.osuosl.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	linux-kernel@vger.kernel.org,
	Jon.Brenner@ams.com
Subject: [PATCH 0/2] staging: iio: tsl2x7x: staging cleanups
Date: Thu,  4 May 2017 20:38:21 -0400
Message-Id: <20170505003823.12133-1-masneyb@onstation.org>
List-ID: <linux-iio@vger.kernel.org>

The two patches in this series begin my work to move this driver out
of staging. Before I start working on the meat of the changes that
are necessary for a staging graduation, I want to get these two
trivial patches out and merged first in case there are any concerns
with these changes.

Brian Masney (2):
  staging: iio: tsl2x7x: rename driver for consistency with other IIO
    light drivers
  staging: iio: tsl2x7x: remove header file

 drivers/staging/iio/light/Makefile                 |   2 +-
 .../iio/light/{tsl2x7x_core.c => tsl2x7x.c}        |  76 +++++++++++++++-
 drivers/staging/iio/light/tsl2x7x.h                | 100 ---------------------
 3 files changed, 76 insertions(+), 102 deletions(-)
 rename drivers/staging/iio/light/{tsl2x7x_core.c => tsl2x7x.c} (95%)
 delete mode 100644 drivers/staging/iio/light/tsl2x7x.h

-- 
2.9.3
