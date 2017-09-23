Return-Path: <SRS0=MmtQ=AY=wanadoo.fr=christophe.jaillet@kernel.org>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	sre@kernel.org,
	wsa@the-dreams.de,
	kishon@ti.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 0/3] iio: adc: twl4030: Fix some  error handling issues in 'twl4030_madc_probe()'
Date: Sat, 23 Sep 2017 08:03:34 +0200
Message-Id: <cover.1506146101.git.christophe.jaillet@wanadoo.fr>
List-ID: <linux-iio@vger.kernel.org>

These 3 patches are all related to error hangling in 'twl4030_madc_probe()'.
They are also all related to commit 7cc97d77ee8a
("iio: adc: twl4030: Fix ADC[3:6] readings")

The semantic of the patches behing slighly different:
   - direct return instead of going through the error handling path
   - missing function in the error handling path
   - spurious pattern (IMO) if unable to enable a regulator
I have splitted them in 3 parts.

Christophe JAILLET (3):
  iio: adc: twl4030: Fix an error handling path in
    'twl4030_madc_probe()'
  iio: adc: twl4030: Disable the vusb3v1 rugulator in the error handling
    path of 'twl4030_madc_probe()'
  iio: adc: twl4030: Return an error if we can not enable the vusb3v1
    regulator in 'twl4030_madc_probe()'

 drivers/iio/adc/twl4030-madc.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

-- 
2.11.0
