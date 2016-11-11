Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36752 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932806AbcKKGfo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Nov 2016 01:35:44 -0500
From: Eva Rachel Retuya <eraretuya@gmail.com>
To: linux-iio@vger.kernel.org, devel@driverdev.usuosl.org,
        linux-kernel@vger.kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        Eva Rachel Retuya <eraretuya@gmail.com>
Subject: [PATCH 0/2] staging: iio: ad7606: move driver out of staging
Date: Fri, 11 Nov 2016 14:34:36 +0800
Message-Id: <1478846078-22207-1-git-send-email-eraretuya@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Address the last remaining TODO [1] for this driver and move it from staging
into mainline.

[1] https://marc.info/?l=linux-iio&m=147689684332118&w=2 

Eva Rachel Retuya (2):
  staging: iio: ad7606: replace range/range_available with corresponding
    scale
  staging: iio: ad7606: move out of staging

 drivers/iio/adc/Kconfig              |  34 +++
 drivers/iio/adc/Makefile             |   3 +
 drivers/iio/adc/ad7606.c             | 519 +++++++++++++++++++++++++++++++++
 drivers/iio/adc/ad7606.h             |  78 +++++
 drivers/iio/adc/ad7606_par.c         | 112 ++++++++
 drivers/iio/adc/ad7606_spi.c         |  78 +++++
 drivers/staging/iio/adc/Kconfig      |  34 ---
 drivers/staging/iio/adc/Makefile     |   4 -
 drivers/staging/iio/adc/ad7606.c     | 543 -----------------------------------
 drivers/staging/iio/adc/ad7606.h     |  78 -----
 drivers/staging/iio/adc/ad7606_par.c | 112 --------
 drivers/staging/iio/adc/ad7606_spi.c |  78 -----
 12 files changed, 824 insertions(+), 849 deletions(-)
 create mode 100644 drivers/iio/adc/ad7606.c
 create mode 100644 drivers/iio/adc/ad7606.h
 create mode 100644 drivers/iio/adc/ad7606_par.c
 create mode 100644 drivers/iio/adc/ad7606_spi.c
 delete mode 100644 drivers/staging/iio/adc/ad7606.c
 delete mode 100644 drivers/staging/iio/adc/ad7606.h
 delete mode 100644 drivers/staging/iio/adc/ad7606_par.c
 delete mode 100644 drivers/staging/iio/adc/ad7606_spi.c

-- 
2.7.4

