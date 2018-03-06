Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-vk0-f66.google.com ([209.85.213.66]:36021 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750897AbeCFMZa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Mar 2018 07:25:30 -0500
Date: Tue, 6 Mar 2018 09:25:26 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: daniel.baluta@nxp.com, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] staging:iio:meter: Checkpatch cleanup for meter
Message-ID: <cover.1520338980.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patchset fixes errors and checks found by checkpatch.pl in the
staging/iio/meter. These series fixes:

* Removes the use of 4 digit octal by replaces IIO_DEV_ATTR_CH_OFF by
	IIO_DEVICE_ATTR;
* Removes unnecessary macro;
* Aligns open parenthesis;

After apply this patch series, meter going to be checkpatch 

Rodrigo Siqueira (3):
  staging:iio:meter: Replaces IIO_DEV_ATTR_CH_OFF by IIO_DEVICE_ATTR
  staging:iio:meter: Remove unused macro IIO_DEV_ATTR_CH_OFF
  staging:iio:meter: Aligns open parenthesis

 drivers/staging/iio/meter/ade7753.c         | 18 +++++++------
 drivers/staging/iio/meter/ade7758_trigger.c |  4 +--
 drivers/staging/iio/meter/ade7759.c         | 18 +++++++------
 drivers/staging/iio/meter/ade7854-spi.c     | 40 ++++++++++++++---------------
 drivers/staging/iio/meter/meter.h           |  3 ---
 5 files changed, 42 insertions(+), 41 deletions(-)

-- 
2.16.2

