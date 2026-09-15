Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A3D44684C;
	Tue, 15 Sep 2026 19:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789499758; cv=none; b=L+9R9HjlsKCBcREf95ht3Iocf7h3bQqZCnmJVPWseR6wrmBTn77y50d61PWmcV6y8asGJdukB3e7lFmV2QCiXbOzvzsgl7dWhAW5Lof7g2ZqIkQPyFijQae3VomH3YERh4p8bLYxeb9TJIrO3pa96LhnBr9DUKffWmzdpbzhNbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789499758; c=relaxed/simple;
	bh=DpPA2UXhDCgzQ+tlDo5Ul0TrVdoA1iDobhVAgjHSZqQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lf4MrhdxKCtvIoJuLLdH+7m9AfeIgNmBJMkYMx5NQqhcUS2wgPuLQPsuebZ4g8rSp0J756+uDh68PVpiMY3CbmCOrrvtx1pPUvay7jhXDRSrI1k+Or6qfK+d1AvU7TqcqOaJXvmOdJ/1vE5v2AudAM4w9v0YawNX6dntC+Noggo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=HV4GwP/o; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="HV4GwP/o"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FItfTj685697;
	Tue, 15 Sep 2026 15:15:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=OqCCW
	CzazshvfBLFOD3ISL8ZHhBuCg9sXGN3+qyY7sQ=; b=HV4GwP/o6UTTVzsUQqjw4
	ncDbc0eBUcviuCbt0YXuvG/aWZ99VYymcR4wgOT3vLkgGnrQ3EnRdK4OX826Vqh6
	hIs4y+jBo0tHLw8jExD3FH7AFwprm6zAL5TKZtqVN1s1P4XT4hHjt3zhJM+qWcOn
	Vf+d1ObbuYbRWL7EgItFTaFcwnq8R5XcAgp4katS3Lxt5OyzP9Rkzxiw6ZRDqSG/
	zh9CFQI4PaLdfh91GeROxaVW9se2JUC0lMUSBpGDeekOE6pFr9tY5JegxWTc0Mzi
	Dd7r/ah404FrxjvDk45TWpX2JyO9FYtezRFoHricb1o+yVIh2ofmcKamyXSPaVYb
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gq4v9jgh8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2026 15:15:47 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 68FJFk51019540
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 15 Sep 2026 15:15:46 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 15 Sep
 2026 15:15:46 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 15 Sep 2026 15:15:46 -0400
Received: from work.maxim-ic.internal ([10.66.6.190])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68FJFWS2028215;
	Tue, 15 Sep 2026 15:15:35 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 11/15] iio: adc: ad4134: Support SPI 4-wire mode
Date: Tue, 15 Sep 2026 16:15:27 -0300
Message-ID: <db5578ed11d5ad9f5abb9569d893065dbf79fb13.1789494473.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1789494473.git.marcelo.schmitt@analog.com>
References: <cover.1789494473.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=JekpPkKV c=1 sm=1 tr=0 ts=6aa99963 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8
 a=nUXYPE43oIPXbmalCEMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDI4MCBTYWx0ZWRfX/8e+wtgJ1JSR
 vs3DnKNZxr7DXAv0MmKmCQSXjVTL6xVmdDaN+hntIFp04HBR/8PgVMuA96rN9HMpQy7FQZwJRjh
 T8kzOwZK7UthByPNYOs35KXMbQJnD722DP1TTrTMvwVDxLp34ZffTx8RXjQVVe2qlI2KqqL0x/q
 u12izSdRdqHZj2zRmRkfZq3QNJtDPScF5Inx/kuFm38Xoao9CrH0QmCTy9NiG7+tkFqSXeVhJ4k
 f7GFt6KZm1SnappxVijP8YqVHYul4zMw12EK1aIlLBdDKnpsZuv8P1H9561epyBbn4utDsAH5wt
 /sc4asiz8pt6N9jhpnlHJuccWpP54xYec3Gf8wyLmel16k2X//wDnRxqHtklLj0zHeeTIew7q1G
 wGOGea9uXdB4GATNPEXGnZ5o1ZDhjs1F3daf0qDn662Lk9e3ebSofDaSH0zr82zZosLB6A5xEMu
 clL+zVN1zyzpasLxnHg==
X-Proofpoint-GUID: iCIGWbefCtVKAAV6HLtJJZfaTsNaT1xq
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDI4MCBTYWx0ZWRfXyu+M11UTFybD
 OqDVMvlEIjYWUrUpAi8itSg302qb+ylHlK0v9fTtTDn6+eoT0LAMujxwU5tgw4OsLovb+ak0QKr
 kv/Pq4MN/GoE8U+k9d6YRV24bMyPkvCn+3ekGEp4EoWI/+nKa09X
X-Proofpoint-ORIG-GUID: iCIGWbefCtVKAAV6HLtJJZfaTsNaT1xq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150280

AD4134 devices can be wired in a few different ways. So far, only minimum
I/O mode was supported. While minimum I/O mode allows interfacing with
AD4134 with a reduced number of wires, that wiring configuration is not
optimal for high-throughput data acquisition.

Extend AD4134 support to enable interfacing in SPI 4-wire configuration.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v1 -> v2:
- Fail on unsupported adi,spi-mode.
- Now properly initializing access mode mutex.
- Highlighted usage of hardware external to AD4134 chip.
- Added comment about mux state switch logic.
- Suggestive name for auxiliary local variables.
- Updated preparation flow for ad4134_data_read().
- Used pahole to reduce memory holes in ad4134_state struct.

Detailed reasoning for the external multiplexer usage.

Before coming to the current solution, the following configuration was tried.

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
line, causing register reads to fail. 

Alternatively, we could have something like

  +-----------------------+                           +-----------------+
  |       AD4134          |                           | SPI Controller  |
  |                       |                           |                 |
  | SPI interface         |                           |                 |
  | for register     SCLK |<--------------------------| SCLK            |
  | access             CS |<--------------------------| CS              |
  |                   SDI |<--------------------------| SDO             |
  |                   SDO |-------------------------->| SDI0            |
  |                       |                           |                 |
  | Data interface  DOUT0 |-------------------------->| SDI1            |
  | for ADC data    DOUT1 |-------------------------->| SDI2            |
  | read back       DOUT2 |-------------------------->| SDI3            |
  |                 DOUT3 |-------------------------->| SDI4            |
  |                 DCLK  |<--------------------------| DCLK
  |                 ODR   |<------------------+    +->| Offload Trigger |
  +-----------------------+                   |    |  +-----------------+
                                              |    +--| PWM1            |
                                              +-------| PWM0            |
                                              +-------| GPIO            |
                                                      +-----------------+

The downside of the above is the peripheral would need fine-grained config of
controller SDI lines to only read SDI0 for register access, and only read SDI1,
SDI2, SDI3, SDI4 for ADC sample data (currently available
SPI_MULTI_LANE_MODE_STRIPE reads from all SDI lines).

The currently proposed solution looks like the following

  +-----------------------+                         +-----------------+
  |         AD4134        |                         | SPI Controller  |
  |                       |                         |                 |
  | SPI interface    SCLK |<------------------------| SCLK            |
  | for register       CS |<------------------------| CS              |
  | access            SDI |<------------------------| SDO             |
  |                   SDO |------->|¯¯¯¯\           |                 |
  |                       |        |MUX  >--------->| SDI0            |
  | Data interface  DOUT0 |------->|____/           |                 |
  | for ADC sample        |          ^              |                 |
  | data read       DOUT1 |------------------------>| SDI1            |
  |                 DOUT2 |------------------------>| SDI2            |
  |                 DOUT3 |------------------------>| SDI3            |
  |                  DCLK |<------------------------| DCLK            |
  |                   ODR |<----------------+    +->| Offload Trigger |
  +-----------------------+          |      |    |  +-----------------+
                                     |      |    +--| PWM1            |
                                     |      +-------| PWM0            |
                                     |      +-------| GPIO0           |
                                     +--------------| GPIO1           |
                                                    +-----------------+

By being able to mux between AD4134 SDO and AD4134 DOUT0, the peripheral can be
connected to a single bus such that controllers able to read from multiple lines
will be able to gather ADC sample data from all SDI lines (SPI_MULTI_LANE_MODE_STRIPE).
With that, AD4134 maximum data throughput can be supported with what is already
available from the SPI core. See additional details on the AD4134 IIO
documentation (patch 15).

Yet another possibility would be to have the peripheral connecting to two buses.

  +-----------------------+                           +-----------------+
  |       AD4134          |                           | SPI Controller A|
  |                       |                           |                 |
  | SPI interface    SCLK |<--------------------------| SCLK            |
  | for register       CS |<--------------------------| CS              |
  | access            SDI |<--------------------------| SDO             |
  |                   SDO |-------------------------->| SDI             |
  |                       |                           +-----------------+
  |                       |                           | SPI Controller B|
  |                       |                           |                 |
  | Data interface  DOUT0 |-------------------------->| SDI0            |
  | for ADC sample  DOUT1 |-------------------------->| SDI1            |
  | data read       DOUT2 |-------------------------->| SDI2            |
  |                 DOUT3 |-------------------------->| SDI3            |
  |                 DCLK  |<--------------------------| DCLK            |
  |                 ODR   |<------------------+    +->| Offload Trigger |
  +-----------------------+                   |    |  +-----------------+
                                              |    +--| PWM1            |
                                              +-------| PWM0            |
                                              +-------| GPIO            |
                                                      +-----------------+

That may be a fallback option if what's currently being proposed fails to comply
to Linux code standards.


 drivers/iio/adc/Kconfig  |   1 +
 drivers/iio/adc/ad4134.c | 194 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 190 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 8787b2339f2c..3b0216e75678 100644
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
index 0b6843bf8a9e..cc6bc325f6ee 100644
--- a/drivers/iio/adc/ad4134.c
+++ b/drivers/iio/adc/ad4134.c
@@ -17,6 +17,8 @@
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/mux/consumer.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
@@ -72,6 +74,9 @@
 #define AD4134_CH3_OFFSET_MSB_REG		0x3E
 #define AD4134_AIN_OR_ERROR_REG			0x48
 
+#define AD4134_SDO_INPUT			0
+#define AD4134_DOUT0_INPUT			1
+
 /*
  * AD4134 register map ends at address 0x48 and there is no register for
  * retrieving ADC sample data. Though, to make use of Linux regmap API both
@@ -86,6 +91,17 @@
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
@@ -155,6 +171,12 @@ struct ad4134_state {
 	 * atomicity of consecutive register access operations.
 	 */
 	struct mutex lock;
+	/*
+	 * Ensure atomicity of access mode switch operations.
+	 */
+	struct mutex access_mode_lock;
+	struct mux_state *mux_st[2]; /* For external multiplexer control */
+	enum ad4134_spi_mode spi_mode;
 	int refin_mv;
 	bool crc_en;
 	/*
@@ -230,6 +252,85 @@ static const struct regmap_access_table ad4134_regmap_wr_table = {
 	.n_yes_ranges = ARRAY_SIZE(ad4134_regmap_wr_range),
 };
 
+/*
+ * This function controls a multiplexer OUTSIDE OF AD4134 SILICON.
+ * When AD4134 SDO and DOUT0 pins are multiplexed, this function changes the
+ * multiplexer state to route SDO to the SPI controller. See AD4134 IIO
+ * documentation for details.
+ */
+static int ad4134_set_register_access(struct ad4134_state *st)
+{
+	int ret;
+
+	guard(mutex)(&st->access_mode_lock);
+
+	st->spi->mode = SPI_MODE_0;
+	ret = spi_setup(st->spi);
+	if (ret)
+		return ret;
+
+	ret = mux_state_deselect(st->mux_st[AD4134_DOUT0_INPUT]);
+	if (ret)
+		dev_err(&st->spi->dev, "error on DOUT0 deselect: %d\n", ret);
+
+	/*
+	 * Try to update the multiplexer state to route SDO to the SPI
+	 * controller. If the SDO mux state is BUSY (i.e. locked), that means
+	 * the desired state is already selected and we should not block here.
+	 */
+	ret = mux_state_try_select(st->mux_st[AD4134_SDO_INPUT]);
+	if (ret && ret != -EBUSY)
+		return ret;
+
+	return 0;
+}
+
+/*
+ * This function controls a multiplexer OUTSIDE OF AD4134 SILICON.
+ * When AD4134 SDO and DOUT0 pins are multiplexed, this function changes the
+ * multiplexer state to route DOUT0 to the SPI controller. On failure, fall
+ * back to routing SDO to the controller and return an errno. See AD4134 IIO
+ * documentation for details.
+ */
+static int ad4134_set_sample_access(struct ad4134_state *st)
+{
+	struct device *dev = &st->spi->dev;
+	int mux_state_ret, ret;
+
+	guard(mutex)(&st->access_mode_lock);
+
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
+		mux_state_ret = mux_state_deselect(st->mux_st[AD4134_DOUT0_INPUT]);
+		if (mux_state_ret)
+			dev_err(dev, "error on DOUT0 deselect: %d\n", mux_state_ret);
+
+		mux_state_ret = mux_state_select(st->mux_st[AD4134_SDO_INPUT]);
+		if (mux_state_ret)
+			dev_err(dev, "error on SDO select: %d\n", mux_state_ret);
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
@@ -333,9 +434,24 @@ static int ad4134_register_read(struct ad4134_state *st, unsigned int reg,
 static int ad4134_reg_read(void *context, unsigned int reg, unsigned int *val)
 {
 	struct ad4134_state *st = context;
+	int ret, access_ret;
 
-	if (reg >= AD4134_CH_VREG(0))
-		return ad4134_data_read(st, reg, val);
+	if (reg >= AD4134_CH_VREG(0)) {
+		if (st->spi_mode == AD4134_SPI_MODE_NO_CS)
+			return ad4134_data_read(st, reg, val);
+
+		ret = ad4134_set_sample_access(st);
+		if (ret)
+			return ret;
+
+		ret = ad4134_data_read(st, reg, val);
+
+		access_ret = ad4134_set_register_access(st);
+		if (access_ret)
+			dev_err(&st->spi->dev, "access mode error: %d\n", access_ret);
+
+		return ret;
+	}
 
 	return ad4134_register_read(st, reg, val);
 }
@@ -379,6 +495,21 @@ static irqreturn_t ad4134_trigger_handler(int irq, void *p)
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
@@ -586,15 +717,68 @@ static int ad4134_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
+	ret = devm_mutex_init(dev, &st->access_mode_lock);
+	if (ret)
+		return ret;
+
 	st->regmap = devm_regmap_init(dev, NULL, st, &ad4134_regmap_config);
 	if (IS_ERR(st->regmap))
 		return dev_err_probe(dev, PTR_ERR(st->regmap),
 				     "failed to initialize regmap");
 
-	ret = ad4134_min_io_mode_setup(st);
-	if (ret)
+	ret = device_property_match_property_string(dev, "adi,spi-mode",
+						    ad4134_spi_modes,
+						    ARRAY_SIZE(ad4134_spi_modes));
+	if (ret == -EINVAL) {
+		/* Default to no-cs mode if adi,spi-mode is not specified */
+		if (!device_property_present(dev, "adi,spi-mode"))
+			st->spi_mode = AD4134_SPI_MODE_NO_CS;
+		else
+			return dev_err_probe(dev, ret,
+					     "unsupported adi,spi-mode\n");
+	} else if (ret < 0) {
 		return dev_err_probe(dev, ret,
-				     "failed to setup minimum I/O mode\n");
+				     "getting adi,spi-mode property failed\n");
+	} else {
+		st->spi_mode = ret;
+	}
+
+	if (st->spi_mode == AD4134_SPI_MODE_NO_CS) {
+		/*
+		 * The support hardware for AD4134 may have a multiplexer for
+		 * selecting between AD4134 SDO and AD4134 DOUT0. If that mux
+		 * is set but the user still wants to run AD4134 in minimum I/O
+		 * mode, then DOUT0 is not used and the multiplexer OUTSIDE OF
+		 * AD4134 SILICON must be set to select AD4134 SDO. See AD4134
+		 * IIO documentation for details.
+		 */
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
+		/*
+		 * This controls a multiplexer OUTSIDE OF AD4134 SILICON.
+		 * See AD4134 IIO documentation for details.
+		 */
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

