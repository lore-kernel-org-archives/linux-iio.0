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
Subject: [PATCH 0/2] Fix checkpatch warnings
Date: Tue, 30 Dec 2014 20:48:48 +0200
Message-Id: <1419965330-4102-1-git-send-email-roberta.dobrescu@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This patchset fixes warnings detected using checkpatch.pl,
such as: incomplete config symbol description, prohibited
space before ','.

Roberta Dobrescu (2):
  iio: light: Annotate Kconfig entry with module name information
  iio: light: lm3533-als: Remove space before ','

 drivers/iio/light/Kconfig      | 3 +++
 drivers/iio/light/lm3533-als.c | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
1.9.1
