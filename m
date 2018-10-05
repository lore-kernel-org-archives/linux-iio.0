Return-Path: <SRS0=TtCr=MR=poczta.fm=sst@kernel.org>
Date: Fri, 5 Oct 2018 10:04:44 +0200
From: Slawomir Stepien <sst@poczta.fm>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
	devel@driverdev.osuosl.org
Subject: [PATCH v2 1/2] staging: iio: cdc: ad7150: use value copy to shorten
 the line length
Message-ID: <20181005080444.GB2984@x220.localdomain>
References: <20181005080400.GA2984@x220.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181005080400.GA2984@x220.localdomain>
List-ID: <linux-iio@vger.kernel.org>

By using the copy of channel attribute, we can now make the lines short
enough to eliminate the checkpatch.pl problem:

    CHECK: Alignment should match open parenthesis

Signed-off-by: Slawomir Stepien <sst@poczta.fm>
---
 drivers/staging/iio/cdc/ad7150.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index d16084d7068c..e2c70063fa0f 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -102,18 +102,19 @@ static int ad7150_read_raw(struct iio_dev *indio_dev,
 {
 	int ret;
 	struct ad7150_chip_info *chip = iio_priv(indio_dev);
+	int channel = chan->channel;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		ret = i2c_smbus_read_word_data(chip->client,
-					ad7150_addresses[chan->channel][0]);
+					       ad7150_addresses[channel][0]);
 		if (ret < 0)
 			return ret;
 		*val = swab16(ret);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_AVERAGE_RAW:
 		ret = i2c_smbus_read_word_data(chip->client,
-					ad7150_addresses[chan->channel][1]);
+					       ad7150_addresses[channel][1]);
 		if (ret < 0)
 			return ret;
 		*val = swab16(ret);
-- 
2.19.0
