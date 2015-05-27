Return-Path: <dan.carpenter@oracle.com>
Date: Wed, 27 May 2015 11:20:52 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Daniel Baluta <daniel.baluta@intel.com>, linux-iio@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [patch] iio: magnetometer: correct a harmless off by one check
Message-ID: <20150527082052.GA19423@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

The line before limits i to 0-3 so the existing code works fine but the
check is still off by one and >= is intended instead of >.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/iio/magnetometer/mmc35240.c b/drivers/iio/magnetometer/mmc35240.c
index aa6e25d..c71392c 100644
--- a/drivers/iio/magnetometer/mmc35240.c
+++ b/drivers/iio/magnetometer/mmc35240.c
@@ -308,7 +308,7 @@ static int mmc35240_read_raw(struct iio_dev *indio_dev,
 			return ret;
 
 		i = (reg & MMC35240_CTRL1_BW_MASK) >> MMC35240_CTRL1_BW_SHIFT;
-		if (i < 0 || i > ARRAY_SIZE(mmc35240_samp_freq))
+		if (i < 0 || i >= ARRAY_SIZE(mmc35240_samp_freq))
 			return -EINVAL;
 
 		*val = mmc35240_samp_freq[i];
