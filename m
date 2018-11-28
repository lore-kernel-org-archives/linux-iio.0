Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43849 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725266AbeK2FSD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Nov 2018 00:18:03 -0500
From: Giuliano Belinassi <giuliano.belinassi@gmail.com>
Date: Wed, 28 Nov 2018 16:15:25 -0200
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com,
        renatogeh@gmail.com
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH 0/2] staging: iio: ad7780: move out of staging
Message-ID: <cover.1543428366.git.giuliano.belinassi@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This series of patches add user input to ad7780 'gain' & 'filter' gpio
pins. Also, it moves the ad7780 out of staging to the main tree.

Giuliano Belinassi (2):
  staging: iio: ad7780: Add gain & filter gpio support
  staging: iio: ad7780: Moving ad7780 out of staging

 drivers/iio/adc/Kconfig                |  13 +
 drivers/iio/adc/Makefile               |   1 +
 drivers/iio/adc/ad7780.c               | 347 +++++++++++++++++++++++++
 drivers/staging/iio/adc/Kconfig        |  13 -
 drivers/staging/iio/adc/Makefile       |   1 -
 drivers/staging/iio/adc/ad7780.c       | 277 --------------------
 include/linux/iio/adc/ad_sigma_delta.h |   5 +
 7 files changed, 366 insertions(+), 291 deletions(-)
 create mode 100644 drivers/iio/adc/ad7780.c
 delete mode 100644 drivers/staging/iio/adc/ad7780.c

-- 
2.19.1
