Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44099 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbeKHWic (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 8 Nov 2018 17:38:32 -0500
From: Giuliano Belinassi <giuliano.belinassi@gmail.com>
Date: Thu, 8 Nov 2018 11:03:02 -0200
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        renatogeh@gmail.com
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH v2 0/2] pattern generation and gain update
Message-ID: <cover.1541681371.git.giuliano.belinassi@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This series of patches fixes a bug in ad717x chips where the PAT2 bit
was wrongly read as a GAIN bit. It also refactors the pattern_mask
generation with the PAT bits.

Changelog:
* v2
	- Squashed is_add778x flag commit with the gain update fix
	- Changed u8 is_add778x to bool is_add778x
	- Set pattern and pattern_mask as macros
	- Aligned identation of macros

Giuliano Belinassi (2):
  staging: iio: ad7780: check if ad778x before gain update
  staging: iio: ad7780: generates pattern_mask from PAT bits

 drivers/staging/iio/adc/ad7780.c | 55 ++++++++++++++++++++------------
 1 file changed, 35 insertions(+), 20 deletions(-)

-- 
2.19.1
