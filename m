Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from vern.gendns.com ([206.190.152.46]:51313 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730140AbeIRWnD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 18 Sep 2018 18:43:03 -0400
From: David Lechner <david@lechnology.com>
To: linux-spi@vger.kernel.org, linux-iio@vger.kernel.org
Cc: David Lechner <david@lechnology.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] spi: SPI_CS_WORD followup
Date: Tue, 18 Sep 2018 12:08:47 -0500
Message-Id: <20180918170850.2749-1-david@lechnology.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is a followup to the series "spi: introduce SPI_CS_WORD mode flag" [1] to
address some review comments.

- The first two patches handle the case for GPIO CS
- The last patch is the IIO patch from the previous series with an expanded
  commit message.


[1]: https://lore.kernel.org/lkml/20180913003920.30600-1-david@lechnology.com/

David Lechner (3):
  spi: always use software fallback for SPI_CS_WORD when using cs_gio
  spi: spi-davinci: Don't error when SPI_CS_WORD and cs_gpio
  iio: adc: ti-ads7950: use SPI_CS_WORD to reduce CPU usage

 drivers/iio/adc/ti-ads7950.c | 53 +++++++++++++++++++++---------------
 drivers/spi/spi-davinci.c    |  3 --
 drivers/spi/spi.c            |  6 ++--
 3 files changed, 35 insertions(+), 27 deletions(-)

-- 
2.17.1
