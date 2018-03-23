Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33336 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751661AbeCWOVk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Mar 2018 10:21:40 -0400
Date: Fri, 23 Mar 2018 11:21:34 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: John Syne <john3909@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Barry Song <21cnbao@gmail.com>
Cc: daniel.baluta@nxp.com, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/8] Cleanup on I2C/SPI code
Message-ID: <cover.1521813782.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patchset reworks the I2C/SPI code from meter module. The set of
patches try to reduce the code duplication and make the communication
reliable. The current version of the module had many code duplications,
which make the code more error-prone and hard to read. Jonh Syne
identified some wrong error handling and fixed it in his patches; in
this series of patches I analyzed Jonh's fixes, and use it in the new
code.

It is important to highlight that meter module is under observation, due
to the lack of hardware and the old design of the chip. However, John
has the hardware for testing and interest to help to update the code
[1]. As a result, this patchset represents the first work effort to
update the meter module in the staging.

1 - https://marc.info/?l=linux-iio&m=152046885922153&w=2

Changes in V2:
 - Reorganize the patchset to make easier to backport fixes.
 - Adds two commits at the beginning of the patchset. First, fixes bugs
   related to wrong verification in read/write I2C operations. Second,
   adjust the incorrect amount of data read.
 - Removes unnecessary code in read/write functions for SPI and I2C
   during the rework.

Changes in V3:
 - Adds clarifications related to authorship.
 - Adds 'fixes' tag on the first two patches message.
 - Removes unnecessary defines.
 - Updates commit messages to better describe changes.

John Syne (2):
  staging:iio:ade7854: Fix error handling on read/write
  staging:iio:ade7854: Fix the wrong number of bits to read

Rodrigo Siqueira (6):
  staging:iio:ade7854: Rework I2C write function
  staging:iio:ade7854: Rework SPI write function
  staging:iio:ade7854: Remove write_reg_* duplications
  staging:iio:ade7854: Rework I2C read function
  staging:iio:ade7854: Rework SPI read function
  staging:iio:ade7854: Remove read_reg_* duplications

 drivers/staging/iio/meter/ade7854-i2c.c | 238 +++++++++-------------------
 drivers/staging/iio/meter/ade7854-spi.c | 268 +++++++-------------------------
 drivers/staging/iio/meter/ade7854.c     |  40 ++---
 drivers/staging/iio/meter/ade7854.h     |  16 +-
 4 files changed, 152 insertions(+), 410 deletions(-)

-- 
2.16.2

