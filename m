Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:44602 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751120AbdBLKzj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 12 Feb 2017 05:55:39 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, ldewangan@nvidia.com
Subject: [PATCH v2 0/2] staging: iio: isl29028: move out of staging
Date: Sun, 12 Feb 2017 05:55:32 -0500
Message-Id: <20170212105534.5648-1-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is hopefully the last of the changes that are needed to move
this driver out of staging.

Datasheet:

http://www.intersil.com/content/dam/Intersil/documents/isl2/isl29028.pdf

Changes since v1:
- in_proximity_sampling_frequency_available sysfs attribute now shows
  decimals.

Brian Masney (2):
  staging: iio: isl29028: change sampling frequencies available to use
    decimals
  staging: iio: isl29028: move out of staging

 drivers/iio/light/Kconfig                  | 10 ++++++++++
 drivers/iio/light/Makefile                 |  1 +
 drivers/{staging => }/iio/light/isl29028.c |  2 +-
 drivers/staging/iio/light/Kconfig          | 10 ----------
 drivers/staging/iio/light/Makefile         |  1 -
 5 files changed, 12 insertions(+), 12 deletions(-)
 rename drivers/{staging => }/iio/light/isl29028.c (99%)

-- 
2.9.3

