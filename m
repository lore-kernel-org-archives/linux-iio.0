Return-Path: <SRS0=bFjq=GD=st.com=fabrice.gasnier@kernel.org>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <fabrice.gasnier@st.com>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <benjamin.gaignard@linaro.org>, <arnaud.pouliquen@st.com>
Subject: [PATCH 2/2] iio: adc: stm32-dfsdm: fix sample rate for div2 spi clock
Date: Tue, 13 Mar 2018 15:23:06 +0100
Message-ID: <1520950986-23116-3-git-send-email-fabrice.gasnier@st.com>
In-Reply-To: <1520950986-23116-1-git-send-email-fabrice.gasnier@st.com>
References: <1520950986-23116-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

When channel clk source is set to "CLKOUT_F" or "CLKOUT_R" (e.g. div2),
sample rate is currently set to half the requested value.

Fixes: eca949800d2d ("IIO: ADC: add stm32 DFSDM support for PDM
microphone")

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/iio/adc/stm32-dfsdm-adc.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index dc911b6..b28a716 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -771,7 +771,7 @@ static int stm32_dfsdm_write_raw(struct iio_dev *indio_dev,
 	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
 	struct stm32_dfsdm_filter *fl = &adc->dfsdm->fl_list[adc->fl_id];
 	struct stm32_dfsdm_channel *ch = &adc->dfsdm->ch_list[chan->channel];
-	unsigned int spi_freq = adc->spi_freq;
+	unsigned int spi_freq;
 	int ret = -EINVAL;
 
 	switch (mask) {
@@ -785,8 +785,18 @@ static int stm32_dfsdm_write_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		if (!val)
 			return -EINVAL;
-		if (ch->src != DFSDM_CHANNEL_SPI_CLOCK_EXTERNAL)
+
+		switch (ch->src) {
+		case DFSDM_CHANNEL_SPI_CLOCK_INTERNAL:
 			spi_freq = adc->dfsdm->spi_master_freq;
+			break;
+		case DFSDM_CHANNEL_SPI_CLOCK_INTERNAL_DIV2_FALLING:
+		case DFSDM_CHANNEL_SPI_CLOCK_INTERNAL_DIV2_RISING:
+			spi_freq = adc->dfsdm->spi_master_freq / 2;
+			break;
+		default:
+			spi_freq = adc->spi_freq;
+		}
 
 		if (spi_freq % val)
 			dev_warn(&indio_dev->dev,
-- 
1.9.1
