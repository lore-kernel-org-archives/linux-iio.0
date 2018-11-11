Return-Path: <SRS0=Twn5=NW=poczta.fm=sst@kernel.org>
From: Slawomir Stepien <sst@poczta.fm>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: [PATCH v6 1/2] staging: iio: adc: ad7280a: power down the device on error in probe
Date: Sun, 11 Nov 2018 16:59:10 +0100
Message-Id: <20181111155911.3604-2-sst@poczta.fm>
In-Reply-To: <20181111155911.3604-1-sst@poczta.fm>
References: <20181111155911.3604-1-sst@poczta.fm>
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Power down the device if anything goes wrong after the SPI has been
setup correctly in the probe function.

Existing code that toggles the AD7280A_CTRL_LB_SWRST bit inside
ad7280_chain_setup function is responsible for powering up the device.

Signed-off-by: Slawomir Stepien <sst@poczta.fm>
---
 drivers/staging/iio/adc/ad7280a.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index 58420dcb406d..3ab06fd87675 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -870,7 +870,7 @@ static int ad7280_probe(struct spi_device *spi)
 
 	ret = ad7280_chain_setup(st);
 	if (ret < 0)
-		return ret;
+		goto error_power_down;
 
 	st->slave_num = ret;
 	st->scan_cnt = (st->slave_num + 1) * AD7280A_NUM_CH;
@@ -901,7 +901,7 @@ static int ad7280_probe(struct spi_device *spi)
 
 	ret = ad7280_channel_init(st);
 	if (ret < 0)
-		return ret;
+		goto error_power_down;
 
 	indio_dev->num_channels = ret;
 	indio_dev->channels = st->channels;
@@ -950,6 +950,9 @@ static int ad7280_probe(struct spi_device *spi)
 error_free_channels:
 	kfree(st->channels);
 
+error_power_down:
+	ad7280_write(st, AD7280A_DEVADDR_MASTER, AD7280A_CONTROL_HB, 1,
+		     AD7280A_CTRL_HB_PWRDN_SW | st->ctrl_hb);
 	return ret;
 }
 
-- 
2.19.1
