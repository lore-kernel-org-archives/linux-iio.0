Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36278 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbeKHEVC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Nov 2018 23:21:02 -0500
From: Giuliano Belinassi <giuliano.belinassi@gmail.com>
Date: Wed, 7 Nov 2018 16:49:16 -0200
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        renatogeh@gmail.com
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH 0/3] staging: iio: ad7780: pattern generation and gain update
Message-ID: <cover.1541615978.git.giuliano.belinassi@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This series of patches fixes a bug in ad717x chips where the PAT2 bit
was wrongly read as a GAIN bit. It also refactors the pattern_mask
generation with the PAT bits.

Giuliano Belinassi (3):
  staging: iio: ad7780: Add is_ad778x flag chip info
  staging: iio: ad7780: check if ad778x before gain update
  staging: iio: ad7780: generates pattern_mask from PAT bits

 drivers/staging/iio/adc/ad7780.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

-- 
2.19.1
