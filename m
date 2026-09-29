Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA4435E1BA;
	Tue, 29 Sep 2026 22:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790721930; cv=none; b=YhRShJHymRthm+bG7pi8OAzuCPILlXYL/Z9U+PTa6PgCZV5zcc4deFh6X7nst1/MpBzMaVb7nVVCEalb+RCzBpomGexUVYRkSX9eaJ0E4TDLNhbisukPOclu0Jr5/N9wwBUGRUUU5/EYwOyk+17Ix5/Lvsdxoi+uBIJX8jDuX98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790721930; c=relaxed/simple;
	bh=doAD4wjjkkVyvF6Q/zm9jnYHcrBzfC++a7McOrpNBn0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lnyycJfOkfdHYwIYU4Ey6ko2mm45BigbMSG49GWbRxmgQQ+rLDfSuLn2IEqUONFLsRxkFUWUu8amHVP/x959hsB2Xie8PlM4q2pfPDJJjT3JjymgZxxb5qfvPi4oViZiCTa8H/KFLtUT/ygA3aWqgtz//ZjV3wx4R/b8qNYNIHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ULzpl1Bv; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ULzpl1Bv"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TKNA3r2453160;
	Tue, 29 Sep 2026 18:45:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=mTvrv
	D3UuQfbFPnMYeiO+FiaMrwTKOYYb17IoMrj7wY=; b=ULzpl1BvN40k+ZmKPZxKw
	RYEV6/uWigwGAYy+xsjphjFBKKhkMuRr3e9IEwBMauBgi8R5yhQ+snpU4H44dAkm
	V+RBBFMx5NfsrmZ2QWbaC4duBMD0OOtk4BuANJ9ovPQmVdCjwc6lHI9m3WoapAnY
	+jU/sG7nFbXIrfobODFEdai/mKbDF31hzjFZmoqvXfzoNtGYa8iyjaiSueLwxAlS
	ItP0JzFGfRr5z7ExtqSGdhnlUaEOIojoAJhmVZI+j74hvgMY0pzI8Zo57Xa/tgO/
	CMPesRrWhvwtKnm0peSs/7QMgNB6S8SG3PCFvuqfckSt5+GQMuztme+mJ2aulPNw
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gyt4g9d8c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 18:45:22 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 68TMjLUV041629
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 29 Sep 2026 18:45:21 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 29 Sep 2026 18:45:21 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 29 Sep 2026 18:45:21 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 29 Sep 2026 18:45:21 -0400
Received: from work.maxim-ic.internal ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68TMj7Ap008256;
	Tue, 29 Sep 2026 18:45:09 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v3 10/13] iio: adc: ad4134: Support SPI 4-wire mode
Date: Tue, 29 Sep 2026 19:45:01 -0300
Message-ID: <c066072441fdba492c18c71d5332d84224379410.1790719425.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1790719424.git.marcelo.schmitt@analog.com>
References: <cover.1790719424.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: X9Tmw1X399W25-SWOOVbpaKdSokoWPUs
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA5MCBTYWx0ZWRfX0FTKqnKwWxFQ
 jlYeX4/PAuzrBwn2KjpzY+38Mpjl923OxYwYCfnF6TPp+gAn9FKVJ0+7q9h36N6lj/j4A4zfqjr
 Yls3hx0+12CEMg1NgrjL2Z65JhW1qRUfWEcaSMPrlEvJLYym0dpD
X-Proofpoint-ORIG-GUID: X9Tmw1X399W25-SWOOVbpaKdSokoWPUs
X-Authority-Analysis: v=2.4 cv=YMkKWhGx c=1 sm=1 tr=0 ts=6abc3f82 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8
 a=0vHLTGWTiGmMnCMvpP8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA5MCBTYWx0ZWRfX04mHl8DOh/yx
 kCEBpDGTM/PTh8F2TyhJmVDs8BNdS/b3EnP2pMX7yprtePdJ5JT5PDSYd5Qg7UlIxbbEB7xn9a4
 r2VPIhCPlFobaIF1eqxahJo2BV1Ah9JIB9TBIiqaUq9xgdOTH0kjy8l+hNCDi+dEEo5QIdeVhAo
 NsxUCG581DS+z1Vl8BQ68N9PjK+eUjPwFCn8ziPUQrNkB80+ZcmOg4X4AUmGGsNVaUL5TkSVQM9
 u+zzi8hhSOzhUJHtPpsnH1/RgG5ihqEoXT1S9jhs1Zt8Y1al8CJq2CPeeaarutjMh077QHPwufX
 c1XC+UnNQNAWWJTHUTSrzs1sWHb2LItI6QU1HvUuMJxxichMQFQ5qtExmDFUTfQJ51pqZw20C8Q
 RuhxGIlc/0OCvz5nuFdkQ2zFS/j14BOqTxCoT2CyPXty0zBCN884fw5cZO0O0pjhDxFqvpPEd7R
 Skfooq6GxyrI9rbs2DQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0 impostorscore=0
 bulkscore=0 malwarescore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290090

AD4134 devices can be wired in a few different ways. So far, only minimum
I/O mode was supported. While minimum I/O mode allows interfacing with
AD4134 with a reduced number of wires, that wiring configuration is not
suitable for high-throughput data acquisition.

Extend AD4134 support to enable interfacing in SPI 4-wire configuration.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v2 -> v3:
- Now using SPI_MODE_X_MASK to update CPOL/CPHA bits.
- Refactored access mode locking to avoid umpaired calls to
  mux_state_select()/deselect().

Currently, SPI offloading is only supported in 4 wire mode. So, offloading
wouldn't be usable if added before the 4-wire patch.

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
                                     +--------------| GPIO            |
                                                    +-----------------+

By being able to mux between AD4134 SDO and AD4134 DOUT0, the peripheral can be
connected to a single bus such that controllers able to read from multiple lines
will be able to gather ADC sample data from all SDI lines (SPI_MULTI_LANE_MODE_STRIPE).
With that, AD4134 maximum data throughput can be supported with what is already
available from the SPI core. See additional details on the AD4134 IIO
documentation (patch 13).

Yet another possibility would be to have the peripheral sitting in two buses.

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
                                                      +-----------------+

That may be a fallback option if what's currently being proposed fails to comply
to Linux code standards.

 drivers/iio/adc/Kconfig  |   1 +
 drivers/iio/adc/ad4134.c | 260 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 248 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index fc7de0bb400a..21bb16f66bc9 100644
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
index f0196126515e..50021001b374 100644
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
@@ -154,6 +170,10 @@ struct ad4134_state {
 	 * atomicity of consecutive register access operations.
 	 */
 	struct mutex sync_lock;
+	/* Synchronize control over the physical bus operation mode. */
+	struct mutex access_lock;
+	struct mux_state *mux_st[2]; /* For external multiplexer control */
+	enum ad4134_spi_mode spi_mode;
 	int refin_mv;
 	bool crc_en;
 	/*
@@ -226,6 +246,90 @@ static const struct regmap_access_table ad4134_regmap_wr_table = {
 	.n_yes_ranges = ARRAY_SIZE(ad4134_regmap_wr_range),
 };
 
+/*
+ * When operating in modes other than minimum I/O mode, AD4134 register data on
+ * the SDO line is sampled on SCLK rising edge (SPI mode 0). In addition to
+ * that, when AD4134 SDO and DOUT0 pins are multiplexed by hardware OUTSIDE
+ * AD4134 SILICON, the multiplexer state must be set to route SDO to the SPI
+ * controller. With both SPI mode and multiplexer state properly set, register
+ * access runs as usual. Still, to prevent concurrent hardware interface
+ * configurations, callers must hold the access_lock. Finally, successful calls
+ * to this function must be balanced with calls to ad4134_release_reg_access()
+ * so to release the mux state lock. See AD4134 IIO documentation for details.
+ */
+static int ad4134_claim_reg_access(struct ad4134_state *st) __must_hold(&st->access_lock)
+{
+	unsigned int cur_mode = st->spi->mode & SPI_MODE_X_MASK;
+	int ret;
+
+	if (st->spi_mode != AD4134_SPI_MODE_NO_CS && cur_mode != SPI_MODE_0) {
+		st->spi->mode &= ~SPI_MODE_X_MASK;
+		st->spi->mode |= SPI_MODE_0;
+		ret = spi_setup(st->spi);
+		if (ret)
+			return ret;
+	}
+
+	if (st->mux_st[AD4134_SDO_INPUT])
+		return mux_state_select(st->mux_st[AD4134_SDO_INPUT]);
+
+	return 0;
+}
+
+/*
+ * Must be balanced with successful calls to ad4134_claim_reg_access() and only
+ * invoked with a hold on access_lock.
+ */
+static int ad4134_release_reg_access(struct ad4134_state *st) __must_hold(&st->access_lock)
+{
+	if (st->mux_st[AD4134_SDO_INPUT])
+		return mux_state_deselect(st->mux_st[AD4134_SDO_INPUT]);
+
+	return 0;
+}
+
+/*
+ * When operating in modes other than minimum I/O mode, AD4134 ADC sample data
+ * on the DOUT lines is sampled on SCLK falling edge (SPI mode 1). In addition
+ * to that, when AD4134 SDO and DOUT0 pins are multiplexed by hardware OUTSIDE
+ * AD4134 SILICON, the multiplexer state must be set to route DOUT0 to the SPI
+ * controller. With both SPI mode and multiplexer state properly set, ADC
+ * samples can be read normally.
+ *
+ * Callers must hold the access_lock and each successful call to this function
+ * must be paired with a call to ad4134_release_sample_access().
+ */
+static int ad4134_claim_sample_access(struct ad4134_state *st) __must_hold(&st->access_lock)
+{
+	unsigned int cur_mode = st->spi->mode & SPI_MODE_X_MASK;
+	int ret;
+
+	if (st->spi_mode != AD4134_SPI_MODE_NO_CS && cur_mode != SPI_MODE_1) {
+		st->spi->mode &= ~SPI_MODE_X_MASK;
+		st->spi->mode |= SPI_MODE_1;
+		ret = spi_setup(st->spi);
+		if (ret)
+			return ret;
+	}
+
+	if (st->mux_st[AD4134_DOUT0_INPUT])
+		return mux_state_select(st->mux_st[AD4134_DOUT0_INPUT]);
+
+	return 0;
+}
+
+/*
+ * Must be balanced with successful calls to ad4134_claim_sample_access() and
+ * only invoked with a hold on access_lock.
+ */
+static int ad4134_release_sample_access(struct ad4134_state *st) __must_hold(&st->access_lock)
+{
+	if (st->mux_st[AD4134_DOUT0_INPUT])
+		return mux_state_deselect(st->mux_st[AD4134_DOUT0_INPUT]);
+
+	return 0;
+}
+
 static int ad4134_calc_spi_crc(u8 inst, u8 data)
 {
 	u8 buf[] = { inst, data };
@@ -249,18 +353,27 @@ static int ad4134_reg_write(void *context, unsigned int reg, unsigned int val)
 		.rx_buf = st->rx_buf,
 		.len = st->crc_en ? AD4134_SPI_MAX_XFER_LEN : 2,
 	};
-	int ret;
+	int access_ret, ret;
+
+	ret = ad4134_claim_reg_access(st);
+	if (ret)
+		return ret;
 
 	ad4134_prepare_spi_tx_buf(reg, val, st->tx_buf);
 
 	ret = spi_sync_transfer(st->spi, &xfer, 1);
 	if (ret)
-		return ret;
+		goto out_write_release;
 
 	if (st->crc_en && st->rx_buf[2] != st->tx_buf[2])
 		dev_dbg(&st->spi->dev, "reg write CRC check failed\n");
 
-	return 0;
+out_write_release:
+	access_ret = ad4134_release_reg_access(st);
+	if (access_ret)
+		dev_err(&st->spi->dev, "error on access release: %d\n", access_ret);
+
+	return ret;
 }
 
 static int ad4134_data_read(struct ad4134_state *st, unsigned int reg,
@@ -268,7 +381,11 @@ static int ad4134_data_read(struct ad4134_state *st, unsigned int reg,
 {
 	unsigned int i;
 	u32 sample;
-	int ret;
+	int access_ret, ret;
+
+	ret = ad4134_claim_sample_access(st);
+	if (ret)
+		return ret;
 
 	/*
 	 * To be able to read data from all 4 channels through a single line, we
@@ -284,7 +401,7 @@ static int ad4134_data_read(struct ad4134_state *st, unsigned int reg,
 		ret = spi_write_then_read(st->spi, NULL, 0, st->rx_buf,
 					  BITS_TO_BYTES(AD4134_CHAN_PRECISION_BITS));
 		if (ret)
-			return ret;
+			goto out_data_read_release;
 
 		/*
 		 * AD4134 has a built-in feature that flags when data transfers
@@ -296,7 +413,12 @@ static int ad4134_data_read(struct ad4134_state *st, unsigned int reg,
 	}
 	*val = sign_extend32(sample, AD4134_CHAN_PRECISION_BITS - 1);
 
-	return 0;
+out_data_read_release:
+	access_ret = ad4134_release_sample_access(st);
+	if (access_ret)
+		dev_err(&st->spi->dev, "error on access release: %d\n", access_ret);
+
+	return ret;
 }
 
 static int ad4134_register_read(struct ad4134_state *st, unsigned int reg,
@@ -308,14 +430,18 @@ static int ad4134_register_read(struct ad4134_state *st, unsigned int reg,
 		.len = st->crc_en ? AD4134_SPI_MAX_XFER_LEN : 2,
 	};
 	unsigned int inst;
-	int ret;
+	int access_ret, ret;
+
+	ret = ad4134_claim_reg_access(st);
+	if (ret)
+		return ret;
 
 	inst = AD4134_REG_READ_MASK | reg;
 	ad4134_prepare_spi_tx_buf(inst, 0, st->tx_buf);
 
 	ret = spi_sync_transfer(st->spi, &xfer, 1);
 	if (ret)
-		return ret;
+		goto out_read_release;
 
 	*val = st->rx_buf[1];
 
@@ -323,7 +449,12 @@ static int ad4134_register_read(struct ad4134_state *st, unsigned int reg,
 	if (st->crc_en && st->rx_buf[2] != st->tx_buf[2])
 		dev_dbg(&st->spi->dev, "reg read CRC check failed\n");
 
-	return 0;
+out_read_release:
+	access_ret = ad4134_release_reg_access(st);
+	if (access_ret)
+		dev_err(&st->spi->dev, "error on access release: %d\n", access_ret);
+
+	return ret;
 }
 
 static int ad4134_reg_read(void *context, unsigned int reg, unsigned int *val)
@@ -336,11 +467,25 @@ static int ad4134_reg_read(void *context, unsigned int reg, unsigned int *val)
 	return ad4134_register_read(st, reg, val);
 }
 
-static const struct regmap_config ad4134_regmap_config = {
+static void ad4134_regmap_lock(void *lock_arg) __acquires(&st->access_lock)
+{
+	struct ad4134_state *st = lock_arg;
+	mutex_lock(&st->access_lock);
+}
+
+static void ad4134_regmap_unlock(void *lock_arg) __releases(&st->access_lock)
+{
+	struct ad4134_state *st = lock_arg;
+	mutex_unlock(&st->access_lock);
+}
+
+static struct regmap_config ad4134_regmap_config = {
 	.reg_read = ad4134_reg_read,
 	.reg_write = ad4134_reg_write,
 	.rd_table = &ad4134_regmap_rd_table,
 	.wr_table = &ad4134_regmap_wr_table,
+	.lock = ad4134_regmap_lock,
+	.unlock = ad4134_regmap_unlock,
 	.max_register = AD4134_CH_VREG(ARRAY_SIZE(ad4134_chan_set) - 1),
 };
 
@@ -381,6 +526,41 @@ static irqreturn_t ad4134_trigger_handler(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
+static int ad4134_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct ad4134_state *st = iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&st->access_lock);
+
+	ret = ad4134_claim_sample_access(st);
+	if (ret)
+		goto out_unlock;
+
+	return 0;
+
+out_unlock:
+	mutex_unlock(&st->access_lock);
+	return ret;
+}
+
+static int ad4134_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct ad4134_state *st = iio_priv(indio_dev);
+	int ret;
+
+	ret = ad4134_release_sample_access(st);
+
+	mutex_unlock(&st->access_lock);
+
+	return ret;
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
@@ -588,15 +768,69 @@ static int ad4134_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
+	ret = devm_mutex_init(dev, &st->access_lock);
+	if (ret)
+		return ret;
+
+	ad4134_regmap_config.lock_arg = st;
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
+		st->mux_st[AD4134_SDO_INPUT] = devm_mux_state_get(dev, "reg_access");
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

