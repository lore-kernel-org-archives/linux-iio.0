Return-Path: <SRS0=Wg2O=MN=poczta.fm=sst@kernel.org>
Date: Mon, 1 Oct 2018 21:32:23 +0200
From: Slawomir Stepien <sst@poczta.fm>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
	devel@driverdev.osuosl.org
Subject: [PATCH 0/2] Fix style problems in ad7150 driver
Message-ID: <20181001193223.GD24866@x220.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

This series will fix simple style problem inside the ad7150 driver.

Slawomir Stepien (2):
  staging: iio: cdc: ad7150: use pointer to shorten the line length
  staging: iio: cdc: ad7150: fix misaligned lines

 drivers/staging/iio/cdc/ad7150.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

-- 
2.19.0
