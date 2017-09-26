Return-Path: <SRS0=kJiR=A3=gmail.com=aastha.gupta4104@kernel.org>
From: Aastha Gupta <aastha.gupta4104@gmail.com>
To: outreachy-kernel@googlegroups.com,
	hennerich@blackfin.uclinux.org,
	jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org
Cc: Aastha Gupta <aastha.gupta4104@gmail.com>
Subject: [PATCH v2 0/2] staging: iio: adc: ad7192: use private driver lock to protect hardware changes
Date: Tue, 26 Sep 2017 21:11:06 +0530
Message-Id: <1506440468-5081-1-git-send-email-aastha.gupta4104@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

The IIO subsystem is redefining iio_dev->mlock to be used by
the IIO core only for protecting device operating mode changes.
ie. Changes between INDIO_DIRECT_MODE, INDIO_BUFFER_* modes.

These patches 
- replace mlock with private driver lock 
- add lock where there are hardware state changes 

Changes in v2:
	- more descriptive commit messages

Aastha Gupta (2):
  staging: iio: adc: ad7192: Replace mlock with driver private lock
  staging: iio: adc: ad7192: add lock to protect hardware state changes

 drivers/staging/iio/adc/ad7192.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

-- 
2.7.4
