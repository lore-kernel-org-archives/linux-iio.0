Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:43284 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753878AbeCGAnW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Mar 2018 19:43:22 -0500
Date: Tue, 6 Mar 2018 21:43:17 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: daniel.baluta@nxp.com, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] staging:iio:meter: Checkpatch cleanup for meter
Message-ID: <cover.1520382753.git.rodrigosiqueiramelo@gmail.com>
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

Changes v2:
- Aligns one extra open parenthesis in Patch 3.

After apply this patch series, meter going to be checkpatch

Rodrigo Siqueira (3):
  staging:iio:meter: Replaces IIO_DEV_ATTR_CH_OFF by IIO_DEVICE_ATTR
  staging:iio:meter: Remove unused macro IIO_DEV_ATTR_CH_OFF
  staging:iio:meter: Aligns open parenthesis

 drivers/staging/iio/meter/ade7753.c         | 18 +++++++------
 drivers/staging/iio/meter/ade7758_trigger.c |  6 ++---
 drivers/staging/iio/meter/ade7759.c         | 18 +++++++------
 drivers/staging/iio/meter/ade7854-spi.c     | 40 ++++++++++++++---------------
 drivers/staging/iio/meter/meter.h           |  3 ---
 5 files changed, 43 insertions(+), 42 deletions(-)

-- 
2.16.2

