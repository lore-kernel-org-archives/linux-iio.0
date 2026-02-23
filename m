Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E3832A3DA;
	Mon, 23 Feb 2026 17:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771866615; cv=none; b=TCCe+9o3zumTLX7gg5UMimeCv6VTSikfyeHrqZmY54X3U0mUdprFwcjqrkZQYn2ugwCvoWzW8GWc/7zo2cB0lHACavMBYl7Wj6ZZG8sDcJXgGOKyVr67by+egzP6rKBAXMv5Fz3/4Vt3yNk8Sal9fuBxSdZoaqHnjWuvxNDTwOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771866615; c=relaxed/simple;
	bh=G/TOvnCBVj9j5sG5h3tgweM9VTk7L557sUJ6nr4WIBA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kHEFsgQct3W5mlCQS73TE1yOpVXjUnM4BXktxc0jSYlFBtxk9uX4n3IOuhVvAoYtZ8y3Yo8uc/dyxSq9UzFTs65rQaj7mvTYyK2fSalyDKKezd2JrrCtIbX89sPgFza56Dj45TI6ZLU31jcPQUlFH7K4jb9DewFgejg9Yhlpncc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=1zfOQnIu; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="1zfOQnIu"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NEbNOU818309;
	Mon, 23 Feb 2026 12:10:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=CTXO8
	N5ICqgTycp6X6MiNn0SOdcCprBV0D+urN53jik=; b=1zfOQnIu7glZcJFhIqn+R
	yfRPvK3KjZgEO7ePsIY0yaFbintrzgv5LOEsA4jezPC7Y9T3I/f7qOXY6qrP2GFv
	VGrotwrATk2jhI4J5gEgLbvlBDEBrm98EtmP6pZer1GpyWC9RrekjOGadQaYt3oA
	NCIvGzTJj99Lsijx486v/DZczJuITbDYyHcRPTSvwG9UVQBDE38mm7LrqvhdIe9l
	J377CklpD8VBBtn1AxXv5RmyNJUQlKkbZFgkj3R8vm0we00IupBdC9Bd4wdWHcg1
	dHtDTXkjyUuKKizb66JDHgUTDtFE2esHp1OC4ugTcCKFxls9HvjcmJCbYPoaW4YB
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cg7p03rkc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 12:10:03 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61NHA2U5036402
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 23 Feb 2026 12:10:02 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 23 Feb
 2026 12:10:02 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 23 Feb 2026 12:10:02 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61NH9mK3017814;
	Mon, 23 Feb 2026 12:09:50 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <michael.hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>,
        Trevor Gamblin
	<tgamblin@baylibre.com>,
        Axel Haslam <ahaslam@baylibre.com>
Subject: [PATCH v10 3/6] iio: adc: ad4030: Add SPI offload support
Date: Mon, 23 Feb 2026 14:09:47 -0300
Message-ID: <002cef9a5afcd517faf5f40caf6308989842e336.1771865684.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1771865684.git.marcelo.schmitt@analog.com>
References: <cover.1771865684.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: VJiMnjxIg7xbZbuJg3zzUi7lbtEFwhUQ
X-Proofpoint-GUID: VJiMnjxIg7xbZbuJg3zzUi7lbtEFwhUQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDE0NiBTYWx0ZWRfX8CvvtbfhJIT0
 Dl7W3moma36SbmKpvzW7Gh5LBAkHjMtjPjhkG3GoC7432rezPGZzpWGcgH7r0jgCi4/Ov/WfGqm
 6ugs+ZSNPvuZReyxd2fdqUe9JfcoX0cJsSHZ+ViaALoVfcAJ6L1X4riuvvZ2S+r49WRRVHikCEX
 yovddxT0Z50GDHE+2jSHVjtEeCmdFDe9s082twLvliUziqJjHiwSEZTyMSTc7q9wofUXjueXg/n
 jqbR2Vs+xlglwjY/XH0pfv5OtQJksWuS8YBI0ibQ9HVn20tMb7KzzKOo//+e4sFU5sPLEWD52qA
 nx0q/T6cqUtV1FFjUfdcTIgnc5WdVsjUSkkCFIXhFyhXtNqb12EaD1jBXe/afLzrmmihhw1ncz2
 2+HP//MqKiRJUwrEjR22BrpnEuhd+LDpruou0Vr2Fe+PVR6jPXCVlVrNheA6rngBknlzZIUX+qC
 5Jq6GfQfgARMp/G8UFA==
X-Authority-Analysis: v=2.4 cv=Fq4IPmrq c=1 sm=1 tr=0 ts=699c89eb cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8
 a=IvjRRIT8uyO-NJnUH0kA:9 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_04,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 impostorscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602230146

AD4030 and similar ADCs can capture data at sample rates up to 2 mega
samples per second (MSPS). Not all SPI controllers are able to achieve such
high throughputs and even when the controller is fast enough to run
transfers at the required speed, it may be costly to the CPU to handle
transfer data at such high sample rates. Add SPI offload support for AD4030
and similar ADCs to enable data capture at maximum sample rates.

Note that a pair of PWM devices are used for the supported setup. One of
the PWM goes to the ADC CNV pin to initiate conversions while the other PWM
is connected to the SPI offload trigger to signal when to fetch data from
the peripheral. Note also that the PWMs must be somewhat synchronized such
to make the controller run transfers only when ADC sample data is
available. See Documentation/iio/ad4030.rst for details.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Co-developed-by: Trevor Gamblin <tgamblin@baylibre.com>
Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
Co-developed-by: Axel Haslam <ahaslam@baylibre.com>
Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v9 -> v10
- Explained the need of PWM in commint message.
- Fixed off-by-one bug.
- Initialize iio_scan_type struct fields on same order they are on structure definition.

 drivers/iio/adc/Kconfig  |   5 +
 drivers/iio/adc/ad4030.c | 409 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 396 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 60038ae8dfc4..c1e55bc70ff4 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -60,9 +60,14 @@ config AD4030
 	tristate "Analog Devices AD4030 ADC Driver"
 	depends on SPI
 	depends on GPIOLIB
+	depends on PWM
 	select REGMAP
 	select IIO_BUFFER
+	select IIO_BUFFER_DMA
+	select IIO_BUFFER_DMAENGINE
 	select IIO_TRIGGERED_BUFFER
+	select SPI_OFFLOAD
+	select SPI_OFFLOAD_TRIGGER_PWM
 	help
 	  Say yes here to build support for Analog Devices AD4030 and AD4630 high speed
 	  SPI analog to digital converters (ADC).
diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
index def3e1d01ceb..9540ff8c49df 100644
--- a/drivers/iio/adc/ad4030.c
+++ b/drivers/iio/adc/ad4030.c
@@ -14,15 +14,26 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
-#include <linux/iio/iio.h>
-#include <linux/iio/trigger_consumer.h>
-#include <linux/iio/triggered_buffer.h>
+#include <linux/dmaengine.h>
+#include <linux/limits.h>
+#include <linux/log2.h>
+#include <linux/math64.h>
+#include <linux/minmax.h>
+#include <linux/pwm.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
+#include <linux/spi/offload/consumer.h>
 #include <linux/spi/spi.h>
 #include <linux/unaligned.h>
 #include <linux/units.h>
+#include <linux/types.h>
+
+#include <linux/iio/buffer-dmaengine.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
 
 #define AD4030_REG_INTERFACE_CONFIG_A			0x00
 #define     AD4030_REG_INTERFACE_CONFIG_A_SW_RESET	(BIT(0) | BIT(7))
@@ -111,6 +122,8 @@
 #define AD4632_TCYC_NS			2000
 #define AD4632_TCYC_ADJUSTED_NS		(AD4632_TCYC_NS - AD4030_TCNVL_NS)
 #define AD4030_TRESET_COM_DELAY_MS	750
+/* Datasheet says 9.8ns, so use the closest integer value */
+#define AD4030_TQUIET_CNV_DELAY_NS	10
 
 enum ad4030_out_mode {
 	AD4030_OUT_DATA_MD_DIFF,
@@ -136,11 +149,13 @@ struct ad4030_chip_info {
 	const char *name;
 	const unsigned long *available_masks;
 	const struct iio_chan_spec channels[AD4030_MAX_IIO_CHANNEL_NB];
+	const struct iio_chan_spec offload_channels[AD4030_MAX_IIO_CHANNEL_NB];
 	u8 grade;
 	u8 precision_bits;
 	/* Number of hardware channels */
 	int num_voltage_inputs;
 	unsigned int tcyc_ns;
+	unsigned int max_sample_rate_hz;
 };
 
 struct ad4030_state {
@@ -153,6 +168,14 @@ struct ad4030_state {
 	int offset_avail[3];
 	unsigned int avg_log2;
 	enum ad4030_out_mode mode;
+	/* Offload sampling */
+	struct spi_transfer offload_xfer;
+	struct spi_message offload_msg;
+	struct spi_offload *offload;
+	struct spi_offload_trigger *offload_trigger;
+	struct spi_offload_trigger_config offload_trigger_config;
+	struct pwm_device *cnv_trigger;
+	struct pwm_waveform cnv_wf;
 
 	/*
 	 * DMA (thus cache coherency maintenance) requires the transfer buffers
@@ -209,8 +232,9 @@ struct ad4030_state {
  * - voltage0-voltage1
  * - voltage2-voltage3
  */
-#define AD4030_CHAN_DIFF(_idx, _scan_type) {				\
+#define __AD4030_CHAN_DIFF(_idx, _scan_type, _offload) {		\
 	.info_mask_shared_by_all =					\
+		(_offload ? BIT(IIO_CHAN_INFO_SAMP_FREQ) : 0) |		\
 		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),			\
 	.info_mask_shared_by_all_available =				\
 		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),			\
@@ -232,6 +256,12 @@ struct ad4030_state {
 	.num_ext_scan_type = ARRAY_SIZE(_scan_type),			\
 }
 
+#define AD4030_CHAN_DIFF(_idx, _scan_type)				\
+	__AD4030_CHAN_DIFF(_idx, _scan_type, 0)
+
+#define AD4030_OFFLOAD_CHAN_DIFF(_idx, _scan_type)			\
+	__AD4030_CHAN_DIFF(_idx, _scan_type, 1)
+
 /*
  * AD4030 can average over 2^N samples, where N = 1, 2, 3, ..., 16.
  * We use N = 0 to mean no sample averaging.
@@ -244,6 +274,11 @@ static const int ad4030_average_modes[] = {
 	BIT(13), BIT(14), BIT(15), BIT(16),
 };
 
+static const struct spi_offload_config ad4030_offload_config = {
+	.capability_flags = SPI_OFFLOAD_CAP_TRIGGER |
+			    SPI_OFFLOAD_CAP_RX_STREAM_DMA,
+};
+
 static int ad4030_enter_config_mode(struct ad4030_state *st)
 {
 	st->tx_data[0] = AD4030_REG_ACCESS;
@@ -457,6 +492,102 @@ static int ad4030_get_chan_calibbias(struct iio_dev *indio_dev,
 	}
 }
 
+static void ad4030_get_sampling_freq(struct ad4030_state *st, int *freq)
+{
+	struct spi_offload_trigger_config *config = &st->offload_trigger_config;
+
+	/*
+	 * Conversion data is fetched from the device when the offload transfer
+	 * is triggered. Thus, provide the SPI offload trigger frequency as the
+	 * sampling frequency.
+	 */
+	*freq = config->periodic.frequency_hz;
+}
+
+static int ad4030_update_conversion_rate(struct ad4030_state *st,
+					 unsigned int freq_hz, unsigned int avg_log2)
+{
+	struct spi_offload_trigger_config *config = &st->offload_trigger_config;
+	unsigned int offload_period_ns, cnv_rate_hz;
+	struct pwm_waveform cnv_wf = { };
+	u64 target = AD4030_TCNVH_NS;
+	u64 offload_offset_ns;
+	int ret;
+
+	/*
+	 * When averaging/oversampling over N samples, we fire the offload
+	 * trigger once at every N pulses of the CNV signal. Conversely, the CNV
+	 * signal needs to be N times faster than the offload trigger. Take that
+	 * into account to correctly re-evaluate both the PWM waveform connected
+	 * to CNV and the SPI offload trigger.
+	 */
+	cnv_rate_hz = freq_hz << avg_log2;
+
+	cnv_wf.period_length_ns = DIV_ROUND_CLOSEST(NSEC_PER_SEC, cnv_rate_hz);
+	/*
+	 * The datasheet lists a minimum time of 9.8 ns, but no maximum. If the
+	 * rounded PWM's value is less than 10, increase the target value by 10
+	 * and attempt to round the waveform again, until the value is at least
+	 * 10 ns. Use a separate variable to represent the target in case the
+	 * rounding is severe enough to keep putting the first few results under
+	 * the minimum 10ns condition checked by the while loop.
+	 */
+	do {
+		cnv_wf.duty_length_ns = target;
+		ret = pwm_round_waveform_might_sleep(st->cnv_trigger, &cnv_wf);
+		if (ret)
+			return ret;
+		target += AD4030_TCNVH_NS;
+	} while (cnv_wf.duty_length_ns < AD4030_TCNVH_NS);
+
+	/*
+	 * The CNV waveform period (period_length_ns) might get rounded down by
+	 * pwm_round_waveform_might_sleep(). Check the resultant PWM period
+	 * is not smaller than the minimum data conversion cycle time.
+	 */
+	if (!in_range(cnv_wf.period_length_ns, AD4030_TCYC_NS, INT_MAX))
+		return -EINVAL;
+
+	offload_period_ns = DIV_ROUND_CLOSEST(NSEC_PER_SEC, freq_hz);
+
+	config->periodic.frequency_hz = DIV_ROUND_UP(HZ_PER_GHZ, offload_period_ns);
+
+	/*
+	 * The hardware does the capture on zone 2 (when SPI trigger PWM
+	 * is used). This means that the SPI trigger signal should happen at
+	 * tsync + tquiet_con_delay being tsync the conversion signal period
+	 * and tquiet_con_delay 9.8ns. Hence set the PWM phase accordingly.
+	 *
+	 * The PWM waveform API only supports nanosecond resolution right now,
+	 * so round this setting to the closest available value.
+	 */
+	offload_offset_ns = AD4030_TQUIET_CNV_DELAY_NS;
+	do {
+		config->periodic.offset_ns = offload_offset_ns;
+		ret = spi_offload_trigger_validate(st->offload_trigger, config);
+		if (ret)
+			return ret;
+		offload_offset_ns += AD4030_TQUIET_CNV_DELAY_NS;
+	} while (config->periodic.offset_ns < AD4030_TQUIET_CNV_DELAY_NS);
+
+	st->cnv_wf = cnv_wf;
+
+	return 0;
+}
+
+static int ad4030_set_sampling_freq(struct iio_dev *indio_dev, int freq_hz)
+{
+	struct ad4030_state *st = iio_priv(indio_dev);
+
+	if (freq_hz == 0)
+		return -EINVAL;
+
+	if (!in_range(freq_hz, 0, st->chip->max_sample_rate_hz))
+		return -ERANGE;
+
+	return ad4030_update_conversion_rate(st, freq_hz, st->avg_log2);
+}
+
 static int ad4030_set_chan_calibscale(struct iio_dev *indio_dev,
 				      struct iio_chan_spec const *chan,
 				      int gain_int,
@@ -516,11 +647,30 @@ static int ad4030_set_avg_frame_len(struct iio_dev *dev, int avg_val)
 	struct ad4030_state *st = iio_priv(dev);
 	unsigned int avg_log2 = ilog2(avg_val);
 	unsigned int last_avg_idx = ARRAY_SIZE(ad4030_average_modes) - 1;
+	int freq_hz;
 	int ret;
 
 	if (avg_val < 0 || avg_val > ad4030_average_modes[last_avg_idx])
 		return -EINVAL;
 
+	if (st->offload_trigger) {
+		/*
+		 * The sample averaging and sampling frequency configurations
+		 * are mutually dependent on each other. That's because the
+		 * effective data sample rate is fCNV / 2^N, where N is the
+		 * number of samples being averaged.
+		 *
+		 * When SPI offload is supported and we have control over the
+		 * sample rate, the conversion start signal (CNV) and the SPI
+		 * offload trigger frequencies must be re-evaluated so data is
+		 * fetched only after 'avg_val' conversions.
+		 */
+		ad4030_get_sampling_freq(st, &freq_hz);
+		ret = ad4030_update_conversion_rate(st, freq_hz, avg_log2);
+		if (ret)
+			return ret;
+	}
+
 	ret = regmap_write(st->regmap, AD4030_REG_AVG,
 			   AD4030_REG_AVG_MASK_AVG_SYNC |
 			   FIELD_PREP(AD4030_REG_AVG_MASK_AVG_VAL, avg_log2));
@@ -773,6 +923,10 @@ static int ad4030_read_raw_dispatch(struct iio_dev *indio_dev,
 		*val = BIT(st->avg_log2);
 		return IIO_VAL_INT;
 
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		ad4030_get_sampling_freq(st, val);
+		return IIO_VAL_INT;
+
 	default:
 		return -EINVAL;
 	}
@@ -813,6 +967,9 @@ static int ad4030_write_raw_dispatch(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		return ad4030_set_avg_frame_len(indio_dev, val);
 
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return ad4030_set_sampling_freq(indio_dev, val);
+
 	default:
 		return -EINVAL;
 	}
@@ -902,6 +1059,86 @@ static const struct iio_buffer_setup_ops ad4030_buffer_setup_ops = {
 	.validate_scan_mask = ad4030_validate_scan_mask,
 };
 
+static void ad4030_prepare_offload_msg(struct iio_dev *indio_dev)
+{
+	struct ad4030_state *st = iio_priv(indio_dev);
+	u8 offload_bpw;
+
+	if (st->mode == AD4030_OUT_DATA_MD_30_AVERAGED_DIFF)
+		offload_bpw = 32;
+	else
+		offload_bpw = st->chip->precision_bits;
+
+	st->offload_xfer.bits_per_word = offload_bpw;
+	st->offload_xfer.len = spi_bpw_to_bytes(offload_bpw);
+	st->offload_xfer.offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
+	spi_message_init_with_transfers(&st->offload_msg, &st->offload_xfer, 1);
+}
+
+static int ad4030_offload_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct ad4030_state *st = iio_priv(indio_dev);
+	unsigned int reg_modes;
+	int ret;
+
+	/*
+	 * When data from 2 analog input channels is output through a single
+	 * bus line (interleaved mode (LANE_MD == 0b11)) and gets pushed through
+	 * DMA, extra hardware is required to do the de-interleaving. While we
+	 * don't support such hardware configurations, disallow interleaved mode
+	 * when using SPI offload.
+	 */
+	ret = regmap_read(st->regmap, AD4030_REG_MODES, &reg_modes);
+	if (ret)
+		return ret;
+
+	if (st->chip->num_voltage_inputs > 1 &&
+	    FIELD_GET(AD4030_REG_MODES_MASK_LANE_MODE, reg_modes) == AD4030_LANE_MD_INTERLEAVED)
+		return -EINVAL;
+
+	ad4030_prepare_offload_msg(indio_dev);
+	st->offload_msg.offload = st->offload;
+	ret = spi_optimize_message(st->spi, &st->offload_msg);
+	if (ret)
+		return ret;
+
+	ret = pwm_set_waveform_might_sleep(st->cnv_trigger, &st->cnv_wf, false);
+	if (ret)
+		goto out_unoptimize;
+
+	ret = spi_offload_trigger_enable(st->offload, st->offload_trigger,
+					 &st->offload_trigger_config);
+	if (ret)
+		goto out_pwm_disable;
+
+	return 0;
+
+out_pwm_disable:
+	pwm_disable(st->cnv_trigger);
+out_unoptimize:
+	spi_unoptimize_message(&st->offload_msg);
+
+	return ret;
+}
+
+static int ad4030_offload_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct ad4030_state *st = iio_priv(indio_dev);
+
+	spi_offload_trigger_disable(st->offload, st->offload_trigger);
+
+	pwm_disable(st->cnv_trigger);
+
+	spi_unoptimize_message(&st->offload_msg);
+
+	return 0;
+}
+
+static const struct iio_buffer_setup_ops ad4030_offload_buffer_setup_ops = {
+	.postenable = &ad4030_offload_buffer_postenable,
+	.predisable = &ad4030_offload_buffer_predisable,
+};
+
 static int ad4030_regulators_get(struct ad4030_state *st)
 {
 	struct device *dev = &st->spi->dev;
@@ -971,6 +1208,24 @@ static int ad4030_detect_chip_info(const struct ad4030_state *st)
 	return 0;
 }
 
+static int ad4030_pwm_get(struct ad4030_state *st)
+{
+	struct device *dev = &st->spi->dev;
+
+	st->cnv_trigger = devm_pwm_get(dev, NULL);
+	if (IS_ERR(st->cnv_trigger))
+		return dev_err_probe(dev, PTR_ERR(st->cnv_trigger),
+				     "Failed to get CNV PWM\n");
+
+	/*
+	 * Preemptively disable the PWM, since we only want to enable it with
+	 * the buffer.
+	 */
+	pwm_disable(st->cnv_trigger);
+
+	return 0;
+}
+
 static int ad4030_config(struct ad4030_state *st)
 {
 	int ret;
@@ -998,6 +1253,31 @@ static int ad4030_config(struct ad4030_state *st)
 	return 0;
 }
 
+static int ad4030_spi_offload_setup(struct iio_dev *indio_dev,
+				    struct ad4030_state *st)
+{
+	struct device *dev = &st->spi->dev;
+	struct dma_chan *rx_dma;
+
+	indio_dev->setup_ops = &ad4030_offload_buffer_setup_ops;
+
+	st->offload_trigger = devm_spi_offload_trigger_get(dev, st->offload,
+							   SPI_OFFLOAD_TRIGGER_PERIODIC);
+	if (IS_ERR(st->offload_trigger))
+		return dev_err_probe(dev, PTR_ERR(st->offload_trigger),
+				     "failed to get offload trigger\n");
+
+	st->offload_trigger_config.type = SPI_OFFLOAD_TRIGGER_PERIODIC;
+
+	rx_dma = devm_spi_offload_rx_stream_request_dma_chan(dev, st->offload);
+	if (IS_ERR(rx_dma))
+		return dev_err_probe(dev, PTR_ERR(rx_dma),
+				     "failed to get offload RX DMA\n");
+
+	return devm_iio_dmaengine_buffer_setup_with_handle(dev, indio_dev, rx_dma,
+							   IIO_BUFFER_DIRECTION_IN);
+}
+
 static int ad4030_probe(struct spi_device *spi)
 {
 	struct device *dev = &spi->dev;
@@ -1049,24 +1329,58 @@ static int ad4030_probe(struct spi_device *spi)
 		return dev_err_probe(dev, PTR_ERR(st->cnv_gpio),
 				     "Failed to get cnv gpio\n");
 
-	/*
-	 * One hardware channel is split in two software channels when using
-	 * common byte mode. Add one more channel for the timestamp.
-	 */
-	indio_dev->num_channels = 2 * st->chip->num_voltage_inputs + 1;
 	indio_dev->name = st->chip->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &ad4030_iio_info;
-	indio_dev->channels = st->chip->channels;
 	indio_dev->available_scan_masks = st->chip->available_masks;
 
-	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
-					      iio_pollfunc_store_time,
-					      ad4030_trigger_handler,
-					      &ad4030_buffer_setup_ops);
-	if (ret)
-		return dev_err_probe(dev, ret,
-				     "Failed to setup triggered buffer\n");
+	st->offload = devm_spi_offload_get(dev, spi, &ad4030_offload_config);
+	ret = PTR_ERR_OR_ZERO(st->offload);
+	/* Fall back to low speed usage when no SPI offload is available. */
+	if (ret == -ENODEV) {
+		/*
+		 * One hardware channel is split in two software channels when
+		 * using common byte mode. Add one more channel for the timestamp.
+		 */
+		indio_dev->num_channels = 2 * st->chip->num_voltage_inputs + 1;
+		indio_dev->channels = st->chip->channels;
+
+		ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
+						      iio_pollfunc_store_time,
+						      ad4030_trigger_handler,
+						      &ad4030_buffer_setup_ops);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to setup triggered buffer\n");
+	} else if (ret) {
+		return dev_err_probe(dev, ret, "failed to get offload\n");
+	} else {
+		/*
+		 * Offloaded SPI transfers can't support software timestamp so
+		 * no additional timestamp channel is added.
+		 */
+		indio_dev->num_channels = st->chip->num_voltage_inputs;
+		indio_dev->channels = st->chip->offload_channels;
+		ret = ad4030_spi_offload_setup(indio_dev, st);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to setup SPI offload\n");
+
+		ret = ad4030_pwm_get(st);
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to get PWM\n");
+
+		/*
+		 * Start with a slower sampling rate so there is some room for
+		 * adjusting the sample averaging and the sampling frequency
+		 * without hitting the maximum conversion rate.
+		 */
+		ret = ad4030_update_conversion_rate(st, st->chip->max_sample_rate_hz >> 4,
+						    st->avg_log2);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to set offload samp freq\n");
+	}
 
 	return devm_iio_device_register(dev, indio_dev);
 }
@@ -1104,11 +1418,28 @@ static const struct iio_scan_type ad4030_24_scan_types[] = {
 	},
 };
 
+static const struct iio_scan_type ad4030_24_offload_scan_types[] = {
+	[AD4030_SCAN_TYPE_NORMAL] = {
+		.sign = 's',
+		.realbits = 24,
+		.storagebits = 32,
+		.shift = 0,
+		.endianness = IIO_CPU,
+	},
+	[AD4030_SCAN_TYPE_AVG] = {
+		.sign = 's',
+		.realbits = 30,
+		.storagebits = 32,
+		.shift = 2,
+		.endianness = IIO_CPU,
+	},
+};
+
 static const struct iio_scan_type ad4030_16_scan_types[] = {
 	[AD4030_SCAN_TYPE_NORMAL] = {
 		.sign = 's',
-		.storagebits = 32,
 		.realbits = 16,
+		.storagebits = 32,
 		.shift = 16,
 		.endianness = IIO_BE,
 	},
@@ -1121,6 +1452,23 @@ static const struct iio_scan_type ad4030_16_scan_types[] = {
 	}
 };
 
+static const struct iio_scan_type ad4030_16_offload_scan_types[] = {
+	[AD4030_SCAN_TYPE_NORMAL] = {
+		.sign = 's',
+		.realbits = 16,
+		.storagebits = 32,
+		.shift = 0,
+		.endianness = IIO_CPU,
+	},
+	[AD4030_SCAN_TYPE_AVG] = {
+		.sign = 's',
+		.realbits = 30,
+		.storagebits = 32,
+		.shift = 2,
+		.endianness = IIO_CPU,
+	},
+};
+
 static const struct ad4030_chip_info ad4030_24_chip_info = {
 	.name = "ad4030-24",
 	.available_masks = ad4030_channel_masks,
@@ -1129,10 +1477,14 @@ static const struct ad4030_chip_info ad4030_24_chip_info = {
 		AD4030_CHAN_CMO(1, 0),
 		IIO_CHAN_SOFT_TIMESTAMP(2),
 	},
+	.offload_channels = {
+		AD4030_OFFLOAD_CHAN_DIFF(0, ad4030_24_offload_scan_types),
+	},
 	.grade = AD4030_REG_CHIP_GRADE_AD4030_24_GRADE,
 	.precision_bits = 24,
 	.num_voltage_inputs = 1,
 	.tcyc_ns = AD4030_TCYC_ADJUSTED_NS,
+	.max_sample_rate_hz = 2 * HZ_PER_MHZ,
 };
 
 static const struct ad4030_chip_info ad4630_16_chip_info = {
@@ -1145,10 +1497,15 @@ static const struct ad4030_chip_info ad4630_16_chip_info = {
 		AD4030_CHAN_CMO(3, 1),
 		IIO_CHAN_SOFT_TIMESTAMP(4),
 	},
+	.offload_channels = {
+		AD4030_OFFLOAD_CHAN_DIFF(0, ad4030_16_offload_scan_types),
+		AD4030_OFFLOAD_CHAN_DIFF(1, ad4030_16_offload_scan_types),
+	},
 	.grade = AD4030_REG_CHIP_GRADE_AD4630_16_GRADE,
 	.precision_bits = 16,
 	.num_voltage_inputs = 2,
 	.tcyc_ns = AD4030_TCYC_ADJUSTED_NS,
+	.max_sample_rate_hz = 2 * HZ_PER_MHZ,
 };
 
 static const struct ad4030_chip_info ad4630_24_chip_info = {
@@ -1161,10 +1518,15 @@ static const struct ad4030_chip_info ad4630_24_chip_info = {
 		AD4030_CHAN_CMO(3, 1),
 		IIO_CHAN_SOFT_TIMESTAMP(4),
 	},
+	.offload_channels = {
+		AD4030_OFFLOAD_CHAN_DIFF(0, ad4030_24_offload_scan_types),
+		AD4030_OFFLOAD_CHAN_DIFF(1, ad4030_24_offload_scan_types),
+	},
 	.grade = AD4030_REG_CHIP_GRADE_AD4630_24_GRADE,
 	.precision_bits = 24,
 	.num_voltage_inputs = 2,
 	.tcyc_ns = AD4030_TCYC_ADJUSTED_NS,
+	.max_sample_rate_hz = 2 * HZ_PER_MHZ,
 };
 
 static const struct ad4030_chip_info ad4632_16_chip_info = {
@@ -1177,10 +1539,15 @@ static const struct ad4030_chip_info ad4632_16_chip_info = {
 		AD4030_CHAN_CMO(3, 1),
 		IIO_CHAN_SOFT_TIMESTAMP(4),
 	},
+	.offload_channels = {
+		AD4030_OFFLOAD_CHAN_DIFF(0, ad4030_16_offload_scan_types),
+		AD4030_OFFLOAD_CHAN_DIFF(1, ad4030_16_offload_scan_types),
+	},
 	.grade = AD4030_REG_CHIP_GRADE_AD4632_16_GRADE,
 	.precision_bits = 16,
 	.num_voltage_inputs = 2,
 	.tcyc_ns = AD4632_TCYC_ADJUSTED_NS,
+	.max_sample_rate_hz = 500 * HZ_PER_KHZ,
 };
 
 static const struct ad4030_chip_info ad4632_24_chip_info = {
@@ -1193,10 +1560,15 @@ static const struct ad4030_chip_info ad4632_24_chip_info = {
 		AD4030_CHAN_CMO(3, 1),
 		IIO_CHAN_SOFT_TIMESTAMP(4),
 	},
+	.offload_channels = {
+		AD4030_OFFLOAD_CHAN_DIFF(0, ad4030_24_offload_scan_types),
+		AD4030_OFFLOAD_CHAN_DIFF(1, ad4030_24_offload_scan_types),
+	},
 	.grade = AD4030_REG_CHIP_GRADE_AD4632_24_GRADE,
 	.precision_bits = 24,
 	.num_voltage_inputs = 2,
 	.tcyc_ns = AD4632_TCYC_ADJUSTED_NS,
+	.max_sample_rate_hz = 500 * HZ_PER_KHZ,
 };
 
 static const struct spi_device_id ad4030_id_table[] = {
@@ -1232,3 +1604,4 @@ module_spi_driver(ad4030_driver);
 MODULE_AUTHOR("Esteban Blanc <eblanc@baylibre.com>");
 MODULE_DESCRIPTION("Analog Devices AD4630 ADC family driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_DMAENGINE_BUFFER");
-- 
2.39.2

