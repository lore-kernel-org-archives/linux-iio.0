Return-Path: <roberta.dobrescu@gmail.com>
From: Roberta Dobrescu <roberta.dobrescu@gmail.com>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: octavian.purdila@intel.com,
	daniel.baluta@intel.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>
Subject: [PATCH 0/2] iio: amplifiers: Fix checkpatch.pl warnings
Date: Tue, 30 Dec 2014 20:45:42 +0200
Message-Id: <1419965144-3988-1-git-send-email-roberta.dobrescu@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This patchset fixes warnings detected using checkpatch.pl,
such as: prohibited space before ',' and wrong order for type specification.

Roberta Dobrescu (2):
  iio: amplifiers: ad8366: Remove space before ','
  iio: amplifiers: ad8366: Use right order for type specification

 drivers/iio/amplifiers/ad8366.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
1.9.1
