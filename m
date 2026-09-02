Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9364AC17D;
	Wed,  2 Sep 2026 17:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788369894; cv=none; b=nVNumX1/Dm6LK6SwGgarVD7NwI5HHxEpsnTiJxuT5YbOfRehpRDU9gGMelfNl6k3o42bloVNJe9NJ57MsP6nQ9yfzryorvicGdn3UmK5DbJ6RrsI4p87e7NwT1TjGLWREoRGkJdyiDfCdOYeEGXYiXGGJDApLn0MXF9/qlOUEy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788369894; c=relaxed/simple;
	bh=dOek6q+XsuzJv6ptBx73vw3J916TEwuMkXbYSpiaQDY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lrVr2+K3eeAK8PmY786abmk6Eni4ytEpVzGoXyodHVlmz3EtiHLmH47OnZzRyWwmHyDnNN7Hs6AP3oZQ3wu+mbZLjzvyDZDDGcbhIIBRbb9fpcYfiQIEqHnoK8sr2d9ehGoN+vv+1FjZrwsoLZ/rKqCSqh+ekOBrf0ABm3Fw1gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=CWdW87k1; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="CWdW87k1"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682HDOfE2569950;
	Wed, 2 Sep 2026 13:24:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=sxFlj
	iKao84lPZsdumffxtK+EKGOoHqz5JTadSi2dE8=; b=CWdW87k1Pau22i83bsWXr
	HOWoavOYgGBHIvfV52MP66WxDLMZCECljQ9qKo1lRsfPFc+DrmmYrzG4m1Jqpaok
	J7rRkzV1+urGXfWB4avcuJy5CTMMgUn8XpC5bGQvYurs8nO4dWHF4z4cslMDR5yK
	zjPyDJGTY3rP0wpllWMoXGuWBjUm6404tHlbnMeNib/Y8Jnn856LQl/YqEsRUU45
	vHRM9takP32rGbvksItQwPIVtrmBOaEIsdH6zj2fZ38/TzlT0cFYGX2ALJAlsYft
	Nm8k9TMtvFQ/g1tC1FY1h/DTs81+tG0zkCIt/q1ydKJ7uaDhOByjfyaLk5UQjHDe
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4ge3v1n81c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 13:24:45 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 682HOiKE041412
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 2 Sep 2026 13:24:44 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 2 Sep 2026 13:24:44 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 2 Sep 2026 13:24:44 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 2 Sep 2026 13:24:44 -0400
Received: from work.maxim-ic.internal ([10.66.6.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 682HOU0w004253;
	Wed, 2 Sep 2026 13:24:33 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v1 09/13] iio: adc: ad4134: Support SPI 4-wire mode
Date: Wed, 2 Sep 2026 14:24:25 -0300
Message-ID: <b7639db1c5f9b13f74d0c4f04edc8d9c11ac4727.1788368334.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1788368334.git.marcelo.schmitt@analog.com>
References: <cover.1788368334.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=bql8wkai c=1 sm=1 tr=0 ts=6a985bdd cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=t_B16g2kS5QVYGaRjl4A:9
X-Proofpoint-GUID: 8wuIv-XZJPArG0F0tkUnGTlpe_2FXzni
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE1MyBTYWx0ZWRfX3i2TBGdZjDnq
 v3uJw287kegQTJw7M94HtJiSsSl1PWdQ/H9CXXP6/iMLioS1UrKXCX5G4QYlGKKrsx5/DzLkUV9
 CssVOZzu5CGQb+w2YSOI/jYmA+RK7TZOLlXmyPKBD9eMAoj4KwYw
X-Proofpoint-ORIG-GUID: 8wuIv-XZJPArG0F0tkUnGTlpe_2FXzni
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE1MyBTYWx0ZWRfXz4I3nsLyd0TB
 bS1x5rJ++6NkgoOex7j0my3ptFQzTptT8NqcBcntJnqn3sYgstIyOSC0wc2R4s3i4v4HY1M/E3k
 rtkjo+SFexbzck2h7j8Qbzj2MBCw3alMDif3Co12PgDRJ/LlYeyo/Nvm5+28xYGkuyrL3X53hJm
 xi9ld9Xf6FFq07Kt/q4q5SAML+R/vpwsdfBxqgit8qo0HeI8Hk6MvkloG/kqX6h/y0Dymm293Ld
 gDQCTrgYgIU0rKgWOSXum4rwq64l8NBwlXZJgCCTAUfLq0WalP5emcfDNYHAm4rC1eG+el05C0j
 oDnm7ruIAiwHONOTRHy2KiJ1UBUBsiIYDw2qDhD7Y3t4jId0nUmJeyJ/gGHF/1QpjvNLF9xL+jt
 IEJIbzjrHFwH6J/o2hrM85Gc5uHcDlO2sVsAsy7mso4Q/l2+n/c64XQsABo63B4NakPfmNs1Vw1
 Ijbh5niV7p6Nj22Mruw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_04,2026-09-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 adultscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020153

AD4134 devices can be wired in a few different ways. So far, only minimum
I/O mode was supported. While minimum I/O mode allows interfacing with
AD4134 with a reduced number of wires, that wiring configuration is not
optimal for high-throughput data acquisition.

Extend AD4134 support to enable interfacing in SPI 4-wire configuration.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
The reason for the input multiplexer is enable both register access and
multi-lane read. Before coming to the current solution, we tried the following
configuration.

  +-----------------------+                           +-----------------+
  |       AD4134          |                           | SPI Controller  |
  |                       |                           |                 |
  | SPI interface         |                           |                 |
  | for register     SCLK |<--------------------------| SCLK            |
  | access             CS |<--------------------------| CS              |
  |                   SDI |<--------------------------| SDO             |
  |                   SDO |---+                       |                 |
  |                       |   |                       |                 |
  | Data interface  DOUT0 |---+---------------------->| SDI0            |
  | for ADC data    DOUT1 |-------------------------->| SDI1            |
  | read back       DOUT2 |-------------------------->| SDI2            |
  |                 DOUT3 |-------------------------->| SDI3            |
  |                 DCLK  |<--------------------------| DCLK
  |                 ODR   |<------------------+    +->| Offload Trigger |
  +-----------------------+                   |    |  +-----------------+
                                              |    +--| PWM1            |
                                              +-------| PWM0            |
                                              +-------| GPIO            |
                                                      +-----------------+

Though, because DOUT0 never goes high-Z, the DOUT0 pin keeps driving the data
line, causing register read to fail (always get 0xFF). Another solution would be
to connect SDO to SDI0 and DOUT pins to SDI1, SDI2, SDI3, SDI4. That would then
require a special multi-lane mode.

Please, see patch 13 for a better view of how the proposed setup works.

 drivers/iio/adc/Kconfig  |   1 +
 drivers/iio/adc/ad4134.c | 162 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 158 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 584251a3f45c..ef77ee60df4e 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -127,6 +127,7 @@ config AD4134
 	select CRC8
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
+	select MULTIPLEXER
 	help
 	  Say yes here to build support for Analog Devices AD4134 SPI analog to
 	  digital converters (ADC).
diff --git a/drivers/iio/adc/ad4134.c b/drivers/iio/adc/ad4134.c
index 0751b89dec8f..8453b44ef368 100644
--- a/drivers/iio/adc/ad4134.c
+++ b/drivers/iio/adc/ad4134.c
@@ -18,6 +18,8 @@
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/mux/consumer.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
@@ -73,6 +75,9 @@
 #define AD4134_CH3_OFFSET_MSB_REG		0x3E
 #define AD4134_AIN_OR_ERROR_REG			0x48
 
+#define AD4134_SDO_INPUT			0
+#define AD4134_DOUT0_INPUT			1
+
 /*
  * AD4134 register map ends at address 0x48 and there is no register for
  * retrieving ADC sample data. Though, to make use of Linux regmap API both
@@ -87,6 +92,17 @@
 #define AD4134_SPI_CRC_INIT_VALUE		0xA5
 static unsigned char ad4134_spi_crc_table[CRC8_TABLE_SIZE];
 
+enum ad4134_spi_mode {
+	AD4134_SPI_MODE_NO_CS, /* datasheet calls this "minimum I/O mode" */
+	AD4134_SPI_MODE_4_WIRE,
+};
+
+/* maps adi,spi-mode property value to enum */
+static const char * const ad4134_spi_modes[] = {
+	[AD4134_SPI_MODE_NO_CS] = "no-cs",
+	[AD4134_SPI_MODE_4_WIRE] = "4-wire",
+};
+
 enum ad4134_filter_type {
 	AD4134_WIDEBAND,
 	AD4134_SINC6,
@@ -154,11 +170,17 @@ struct ad4134_state {
 	struct gpio_desc *odr_gpio;
 	int refin_mv;
 	bool crc_en;
+	enum ad4134_spi_mode spi_mode;
+	struct mux_state *mux_st[2];
 	/*
 	 * Synchronize access to members the of driver state, and ensure
 	 * atomicity of consecutive register access operations.
 	 */
 	struct mutex lock;
+	/*
+	 * Ensure atomicity of access mode switch operations.
+	 */
+	struct mutex access_mode_lock;
 	/*
 	 * DMA (thus cache coherency maintenance) requires the transfer buffers
 	 * to live in their own cache lines.
@@ -233,6 +255,73 @@ static const struct regmap_access_table ad4134_regmap_wr_table = {
 	.n_yes_ranges = ARRAY_SIZE(ad4134_regmap_wr_range),
 };
 
+/*
+ * When AD4134 SDO and DOUT0 pins are multiplexed, this function changes the
+ * multiplexer state to route SDO to the SPI controller.
+ */
+static int ad4134_set_register_access(struct ad4134_state *st)
+{
+	int ret;
+
+	guard(mutex)(&st->access_mode_lock);
+	st->spi->mode = SPI_MODE_0;
+	ret = spi_setup(st->spi);
+	if (ret)
+		return ret;
+
+	ret = mux_state_deselect(st->mux_st[AD4134_DOUT0_INPUT]);
+	if (ret)
+		dev_err(&st->spi->dev, "error on DOUT0 deselect: %d\n", ret);
+
+	ret = mux_state_try_select(st->mux_st[AD4134_SDO_INPUT]);
+	if (ret && ret != -EBUSY)
+		return ret;
+
+	return 0;
+}
+
+/*
+ * When AD4134 SDO and DOUT0 pins are multiplexed, this function changes the
+ * multiplexer state to route DOUT0 to the SPI controller. On failure, fall
+ * back to routing SDO to the controller and return an errno.
+ */
+static int ad4134_set_sample_access(struct ad4134_state *st)
+{
+	int ret, ret2;
+
+	guard(mutex)(&st->access_mode_lock);
+	ret = mux_state_deselect(st->mux_st[AD4134_SDO_INPUT]);
+	if (ret)
+		dev_err(&st->spi->dev, "error on SDO deselect: %d\n", ret);
+
+	ret = mux_state_try_select(st->mux_st[AD4134_DOUT0_INPUT]);
+	if (ret) {
+		dev_err(&st->spi->dev, "error on DOUT0 select: %d\n", ret);
+		return mux_state_select(st->mux_st[AD4134_SDO_INPUT]);
+	}
+
+	/*
+	 * Data output on the DOUT lines is sampled on the falling edge
+	 * (SPI mode 1).
+	 */
+	st->spi->mode = SPI_MODE_1;
+	ret = spi_setup(st->spi);
+	if (ret) {
+		dev_err(&st->spi->dev, "failed to setup SPI mode 1: %d\n", ret);
+		ret2 = mux_state_deselect(st->mux_st[AD4134_DOUT0_INPUT]);
+		if (ret2)
+			dev_err(&st->spi->dev, "error on DOUT0 deselect: %d\n", ret2);
+
+		ret2 = mux_state_select(st->mux_st[AD4134_SDO_INPUT]);
+		if (ret2)
+			dev_err(&st->spi->dev, "error on SDO select: %d\n", ret2);
+
+		return ret;
+	}
+
+	return 0;
+}
+
 static int ad4134_calc_spi_crc(u8 inst, u8 data)
 {
 	u8 buf[] = { inst, data };
@@ -334,9 +423,25 @@ static int ad4134_register_read(struct ad4134_state *st, unsigned int reg,
 static int ad4134_reg_read(void *context, unsigned int reg, unsigned int *val)
 {
 	struct ad4134_state *st = context;
+	int ret, ret2;
 
-	if (reg >= AD4134_CH_VREG(0))
-		return ad4134_data_read(st, reg, val);
+	if (reg >= AD4134_CH_VREG(0)) {
+		if (st->spi_mode == AD4134_SPI_MODE_4_WIRE) {
+			ret = ad4134_set_sample_access(st);
+			if (ret)
+				return ret;
+		}
+
+		ret = ad4134_data_read(st, reg, val);
+
+		if (st->spi_mode == AD4134_SPI_MODE_4_WIRE) {
+			ret2 = ad4134_set_register_access(st);
+			if (ret2)
+				dev_err(&st->spi->dev, "access mode error: %d\n", ret2);
+		}
+
+		return ret;
+	}
 
 	return ad4134_register_read(st, reg, val);
 }
@@ -379,6 +484,21 @@ static irqreturn_t ad4134_trigger_handler(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
+static int ad4134_buffer_postenable(struct iio_dev *indio_dev)
+{
+	return ad4134_set_sample_access(iio_priv(indio_dev));
+}
+
+static int ad4134_buffer_predisable(struct iio_dev *indio_dev)
+{
+	return ad4134_set_register_access(iio_priv(indio_dev));
+}
+
+static const struct iio_buffer_setup_ops ad4134_buffer_setup_ops = {
+	.postenable = &ad4134_buffer_postenable,
+	.predisable = &ad4134_buffer_predisable,
+};
+
 static int ad4134_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val, int *val2, long info)
@@ -590,10 +710,42 @@ static int ad4134_probe(struct spi_device *spi)
 		return dev_err_probe(dev, PTR_ERR(st->regmap),
 				     "failed to initialize regmap");
 
-	ret = ad4134_min_io_mode_setup(st);
-	if (ret)
+	ret = device_property_match_property_string(dev, "adi,spi-mode",
+						    ad4134_spi_modes,
+						    ARRAY_SIZE(ad4134_spi_modes));
+	/* Default to "no-cs" mode if adi,spi-mode is not specified */
+	if (ret == -EINVAL)
+		st->spi_mode = AD4134_SPI_MODE_NO_CS;
+	else if (ret < 0)
 		return dev_err_probe(dev, ret,
-				     "failed to setup minimum I/O mode\n");
+				     "getting adi,spi-mode property failed\n");
+	else
+		st->spi_mode = ret;
+
+	if (st->spi_mode == AD4134_SPI_MODE_NO_CS) {
+		st->mux_st[AD4134_SDO_INPUT] =
+			devm_mux_state_get_optional_selected(dev, "reg_access");
+		if (IS_ERR(st->mux_st[AD4134_SDO_INPUT]))
+			return dev_err_probe(dev, PTR_ERR(st->mux_st[AD4134_SDO_INPUT]),
+					     "failed to get reg_access mux-state\n");
+
+		ret = ad4134_min_io_mode_setup(st);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "failed to setup minimum I/O mode\n");
+	} else {
+		st->mux_st[AD4134_SDO_INPUT] = devm_mux_state_get_selected(dev, "reg_access");
+		if (IS_ERR(st->mux_st[AD4134_SDO_INPUT]))
+			return dev_err_probe(dev, PTR_ERR(st->mux_st[AD4134_SDO_INPUT]),
+					     "failed to get reg_access mux-state\n");
+
+		st->mux_st[AD4134_DOUT0_INPUT] = devm_mux_state_get(dev, "data_read");
+		if (IS_ERR(st->mux_st[AD4134_DOUT0_INPUT]))
+			return dev_err_probe(dev, PTR_ERR(st->mux_st[AD4134_DOUT0_INPUT]),
+					     "failed to get data_read mux-state\n");
+
+		indio_dev->setup_ops = &ad4134_buffer_setup_ops;
+	}
 
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
 					      iio_pollfunc_store_time,
-- 
2.53.0

