Return-Path: <SRS0=TtCr=MR=poczta.fm=sst@kernel.org>
Date: Fri, 5 Oct 2018 10:04:00 +0200
From: Slawomir Stepien <sst@poczta.fm>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
	devel@driverdev.osuosl.org
Subject: [PATCH v2 0/2] Fix style problems in ad7150 driver
Message-ID: <20181005080400.GA2984@x220.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

This series will fix simple style problems inside the ad7150 driver.

---
Changes since v1:
- Use channel value copy rather than pointer - for better readability
- Change "problem" -> "problems" in cover letter description
---
Slawomir Stepien (2):
  staging: iio: cdc: ad7150: use value copy to shorten the line length
  staging: iio: cdc: ad7150: fix misaligned lines

 drivers/staging/iio/cdc/ad7150.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

-- 
2.19.0
