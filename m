Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:59993 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757122AbcJSRHU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 Oct 2016 13:07:20 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 00/13] staging:iio:ad7606: Towards moving out of staging
Date: Wed, 19 Oct 2016 19:06:55 +0200
Message-Id: <1476896828-10544-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Sorry, if you received this twice, forgot the list on the first try.

This patch series contains a few cleanups for the ad7606 driver that
prepares it for moving out of staging. There are still a few small things
left to do after this series though, but hopefully we can get to them
within this developement window so the driver can be moved for the final
v4.10 IIO pull request.

Among the things that still need to be addressed:
	* Replace range/range_available with the standard scale/scale_available
	* Cleanup the regulator handling so it matches the standard behavior
	  established by the framework

- Lars

Lars-Peter Clausen (13):
  staging:iio:ad7606: Remove unused int_vref_mv field
  staging:iio:ad7606: Remove redundant name field from ad7606_chip_info
  staging:iio:ad7606: Remove default device configuration from platform
    data
  staging:iio:ad7606: Remove out-of-band error reporting
  staging:iio:ad7606: Use oversampling ratio of 1 for no oversampling
  staging:iio:ad7606: Avoid allocating buffer for each data capture
  staging:iio:ad7606: Factor out common code between periodic and
    one-shot capture
  staging:iio:ad7606: Move set_drvdata() into common code
  staging:iio:ad7606: Let the common probe function return int
  staging:iio:ad7606: Let common remove function take a struct device *
  staging:iio:ad7606: Run trigger handler only once per trigger event
  staging:iio:ad7606: Use GPIO descriptor API
  staging:iio:ad7606: Move buffer code to main source file

 drivers/staging/iio/adc/Makefile      |   1 -
 drivers/staging/iio/adc/ad7606.c      | 545 +++++++++++++++++++++++++++++++
 drivers/staging/iio/adc/ad7606.h      |  58 +---
 drivers/staging/iio/adc/ad7606_core.c | 598 ----------------------------------
 drivers/staging/iio/adc/ad7606_par.c  |  23 +-
 drivers/staging/iio/adc/ad7606_ring.c | 102 ------
 drivers/staging/iio/adc/ad7606_spi.c  |  19 +-
 7 files changed, 569 insertions(+), 777 deletions(-)
 create mode 100644 drivers/staging/iio/adc/ad7606.c
 delete mode 100644 drivers/staging/iio/adc/ad7606_core.c
 delete mode 100644 drivers/staging/iio/adc/ad7606_ring.c

-- 
2.1.4

