Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4DC37C109;
	Sat, 17 Oct 2026 02:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792202425; cv=none; b=IFQfLvN1kNE9zuRjTZOFf0S/LrZJnHMVAneWNfjQZIm8TNzBIDfCFEd059OL+buQTHEvLqBrZaqYk7zSPj+7d3w0VN2UUcUPGdIx4OAi2/lWl+M2qFIJy5IlnGkKAENW2I6AeZvHRY8pG0c9ynVb25mRmDSkqLciua9WG0xtS84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792202425; c=relaxed/simple;
	bh=MMXha+dT3026QMAe7zX84TJ+URkFKPBNH7gxbBP8mBI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nc76pm0VnWo6l27lLyeDASp9x8Qc81Yazgb8nmkCZTDt8t2mIzB1PmMFiQJgqh3HrTFFCyxiWXHn22PoP6+e87o8y1GuPUqoxYXBPESnmFAzvZ5Kkx7CQU4UDMaLyzn3SZtPkkfgMkMciPnfc9CJT4wgOZoltvqLjtsU2EkAo9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=cBh00Ufo; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=g/ApJthp; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="cBh00Ufo";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="g/ApJthp"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69GNH1Ub3829504;
	Fri, 16 Oct 2026 22:00:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=x2p5Z5EbRChXuqb6FuyLn1HrEo487sT/nt/mejsImaU=; b=cBh00Uf
	oVOEI742zNlo1hflUss3XWs2prCzKxswX6R+Kndzay5H2GydSI+Xmveg+yQMmFGP
	2ZV0L15xuLgHAvpbjng+Qwk3J4vcZWR+TCduXKOv/gZFoQsfzIB7QCmhApExPeNk
	3k7Nakop0R0J2U+eiMPsRp4Pq4f+mklZJws0leAeq7XzlXKxY0s7dQmOfwAzANPk
	mhmvUcQ9cw//EUdeHoVfhy2DGD8eNw82OYOUnfku9PTVQ4wXQ8c6Ul/4XudQEhbF
	uUHT8VjJHeKCBuqe9S3Y7SPuL1Hhjfi7GX/8FCCfPrp9dMXJnx1Mq+4JYx/gfUV/
	UHnUNM/PvstaYnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=x2p5Z
	5EbRChXuqb6FuyLn1HrEo487sT/nt/mejsImaU=; b=g/ApJthpq1QVlgBicwFiv
	SqOFEks62WMirXMIwhiNYBOSN5Ou5a+bULV73LJL1/E5nze91qOJ0FUC5qxDDhbK
	IHltxAKk1fIPXBYfTeRybo0lRx/1JNI3uATUKvUV9RChULYvJ9arVx+vBfLmAjUJ
	s/Di0/wOoLCkh3pNcn5/GVyNhCYNYQJcqqa3sXP0qI6zgcXSXVPzi0ikbX1eTG39
	9qw5xbAbi6HkE5wDCSD8y+6EuqEccq4nF0b7CTfDQB7SsK406hKopHrtNzhRrIBa
	jetme5QFCUzYe6FrJkU0c9q6fxmNtiOJBHxROD3we9bNOCvO1owa6Yyj1Ztiy43G
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hbj17492e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Oct 2026 22:00:18 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 69H20H21062156
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 16 Oct 2026 22:00:17 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 16 Oct 2026 22:00:17 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 16 Oct 2026 22:00:16 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 16 Oct 2026 22:00:16 -0400
Received: from work.maxim-ic.internal ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69H2030a004364;
	Fri, 16 Oct 2026 22:00:06 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v5 12/15] iio: adc: ad4134: Support SPI 4-wire mode
Date: Fri, 16 Oct 2026 22:59:56 -0300
Message-ID: <fabe47973d8de0bc2f5177a99ef032a26b42d926.1792200021.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1792200021.git.marcelo.schmitt@analog.com>
References: <cover.1792200021.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDAwNyBTYWx0ZWRfX5Kij6zFh5RnE
 VygBuGgMehVty2zU3N3dLyDoH+rG5iey3rx2BDxXGkxyYp2qzhNKqGMDkmnTaEVOcoE/Ks/ZqYr
 skd/4Y0HPjK2e4Wl4kIxliMDUH1GFEM6i59ZyS+SDOqtBGKIUt8F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDAwNyBTYWx0ZWRfX5I+R4rzMNn5K
 xQQMGWf9HcLaEhL7GMcdrOPrSWEdTWDN0759OV95a1q/JNZ5qTr3SJf056wgFpgcMn27sKFh/7G
 HV4pHBtBKUXLq++XA5VIi0Vw+VtvB5GouGw3ij3BTiOkmE6OIQwNy+G2anxfe0uFklVoMzUZVuy
 CRub02a2U+vs4aO7PK4fcXgFjDILuf6Bqd39Eqh1SJu2XmCnDJnAsavmhNb4UUTZc4DisLn+uLk
 yNy4sFikGsr1MSc/910M+M3X/COqiQ0X9gmA2yKyxyunzdcE+G5A2F2aVfQ4aKTuv05p7BHLFYV
 iXwDr9Q3mqEIAfEgCP3L3zthEGnZXLn1ALcMZ1JPsCN3k/t1AMyEaDZcygtuWzff/WMqwOgWc52
 mVy08FzeGtcc/qOhYShSVTxv8iwT2GA0H7CMkJnDIoX2lb+RkjwCSKAHBwqzDhgo4XIdeuJl4Mu
 jX3GLf55h5NGyWNP4uQ==
X-Authority-Analysis: v=2.4 cv=Wd6Z+EhX c=1 sm=1 tr=0 ts=6ad2d6b2 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8
 a=NXAGyndoHhwLlbJfipYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: t_rsRlQrzW9JiM2KBR64CCbain1kdIxX
X-Proofpoint-GUID: t_rsRlQrzW9JiM2KBR64CCbain1kdIxX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_04,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610170007

AD4134 devices can be wired in a few different ways. So far, only minimum
I/O mode was supported. While minimum I/O mode allows interfacing with
AD4134 with a reduced number of wires, that wiring configuration is not
suitable for high-throughput data acquisition.

Extend AD4134 support to enable interfacing in SPI 4-wire configuration.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v4 -> v5
- Updated adi,spi-mode property handling.
- No longer selecting/deselecting multiplexer states when in minimum I/O mode.

Detailed reasoning for the external multiplexer usage.

Before coming to the current solution, the following configuration was tried.

  +-----------------------+                           +-----------------+
  |       AD4134          |                           | SPI Controller  |
  |                       |                           |                 |
  | SPI interface    SCLK |<--------------------------| SCLK            |
  | for register       CS |<--------------------------| CS              |
  | access            SDI |<--------------------------| SDO             |
  |                   SDO |---+                       |                 |
  |                       |   |                       |                 |
  | Data interface  DOUT0 |---+---------------------->| SDI0            |
  | for ADC sample  DOUT1 |-------------------------->| SDI1            |
  | data read       DOUT2 |-------------------------->| SDI2            |
  |                 DOUT3 |-------------------------->| SDI3            |
  |                 DCLK  |<--------------------------| DCLK
  |                 ODR   |<------------------+    +->| Offload Trigger |
  +-----------------------+                   |    |  +-----------------+
                                              |    +--| PWM1            |
                                              +-------| PWM0            |
                                                      +-----------------+

Though, because DOUT0 never goes high-Z, the DOUT0 pin keeps driving the data
line, causing register reads to fail.

Alternatively, we could have something like

  +-----------------------+                           +-----------------+
  |       AD4134          |                           | SPI Controller  |
  |                       |                           |                 |
  | SPI interface    SCLK |<--------------------------| SCLK            |
  | for register       CS |<--------------------------| CS              |
  | access            SDI |<--------------------------| SDO             |
  |                   SDO |-------------------------->| SDI0            |
  |                       |                           |                 |
  | Data interface  DOUT0 |-------------------------->| SDI1            |
  | for ADC sample  DOUT1 |-------------------------->| SDI2            |
  | data read       DOUT2 |-------------------------->| SDI3            |
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
documentation (patch 15).

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
 drivers/iio/adc/ad4134.c | 221 +++++++++++++++++++++++++++++++++++----
 2 files changed, 204 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index d625f36a0283..10f3c804df9a 100644
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
index eaf5bb55f25b..6b05e40f7aeb 100644
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
@@ -110,6 +126,8 @@ struct ad4134_state {
 	 * consecutive register access operations.
 	 */
 	struct mutex sync_lock;
+	struct mux_state *mux_st[2]; /* For external multiplexer control */
+	enum ad4134_spi_mode spi_mode;
 	int refin_mv;
 	bool crc_en;
 	/*
@@ -219,6 +237,85 @@ static const struct regmap_access_table ad4134_regmap_wr_table = {
 	.n_yes_ranges = ARRAY_SIZE(ad4134_regmap_wr_range),
 };
 
+/*
+ * When operating in modes other than minimum I/O mode, AD4134 register data on
+ * the SDO line is sampled on SCLK rising edge (SPI mode 0). In addition to
+ * that, when AD4134 SDO and DOUT0 pins are multiplexed by hardware OUTSIDE
+ * AD4134 SILICON, the multiplexer state must be set to route SDO to the SPI
+ * controller. With both SPI mode and multiplexer state properly set, register
+ * access runs as usual. Successful calls to this function must be balanced with
+ * calls to ad4134_release_reg_access() so to release the mux state lock. See
+ * AD4134 IIO documentation for details.
+ */
+static int ad4134_claim_reg_access(struct ad4134_state *st)
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
+	if (st->spi_mode != AD4134_SPI_MODE_NO_CS && st->mux_st[AD4134_SDO_INPUT])
+		return mux_state_select(st->mux_st[AD4134_SDO_INPUT]);
+
+	return 0;
+}
+
+/*
+ * Must be balanced with successful calls to ad4134_claim_reg_access().
+ */
+static int ad4134_release_reg_access(struct ad4134_state *st)
+{
+	if (st->spi_mode != AD4134_SPI_MODE_NO_CS && st->mux_st[AD4134_SDO_INPUT])
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
+ * samples can be read normally. Successful call to this function must be paired
+ * with a call to ad4134_release_sample_access().
+ */
+static int ad4134_claim_sample_access(struct ad4134_state *st)
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
+	if (st->spi_mode != AD4134_SPI_MODE_NO_CS && st->mux_st[AD4134_DOUT0_INPUT])
+		return mux_state_select(st->mux_st[AD4134_DOUT0_INPUT]);
+
+	return 0;
+}
+
+/*
+ * Must be balanced with successful calls to ad4134_claim_sample_access().
+ */
+static int ad4134_release_sample_access(struct ad4134_state *st)
+{
+	if (st->spi_mode != AD4134_SPI_MODE_NO_CS && st->mux_st[AD4134_DOUT0_INPUT])
+		return mux_state_deselect(st->mux_st[AD4134_DOUT0_INPUT]);
+
+	return 0;
+}
+
 static int ad4134_calc_spi_crc(u8 inst, u8 data)
 {
 	u8 buf[] = { inst, data };
@@ -242,18 +339,27 @@ static int ad4134_reg_write(void *context, unsigned int reg, unsigned int val)
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
@@ -261,7 +367,11 @@ static int ad4134_data_read(struct ad4134_state *st, unsigned int reg,
 {
 	unsigned int i;
 	u32 sample = 0;
-	int ret;
+	int access_ret, ret;
+
+	ret = ad4134_claim_sample_access(st);
+	if (ret)
+		return ret;
 
 	/*
 	 * To be able to read data from all 4 channels through a single line, we
@@ -277,7 +387,7 @@ static int ad4134_data_read(struct ad4134_state *st, unsigned int reg,
 		ret = spi_write_then_read(st->spi, NULL, 0, st->rx_buf,
 					  BITS_TO_BYTES(AD4134_CHAN_PRECISION_BITS));
 		if (ret)
-			return ret;
+			goto out_data_read_release;
 
 		/*
 		 * AD4134 has a built-in feature that flags when data transfers
@@ -289,7 +399,12 @@ static int ad4134_data_read(struct ad4134_state *st, unsigned int reg,
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
@@ -301,14 +416,18 @@ static int ad4134_register_read(struct ad4134_state *st, unsigned int reg,
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
 
@@ -316,7 +435,12 @@ static int ad4134_register_read(struct ad4134_state *st, unsigned int reg,
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
@@ -372,6 +496,21 @@ static irqreturn_t ad4134_trigger_handler(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
+static int ad4134_buffer_postenable(struct iio_dev *indio_dev)
+{
+	return ad4134_claim_sample_access(iio_priv(indio_dev));
+}
+
+static int ad4134_buffer_predisable(struct iio_dev *indio_dev)
+{
+	return ad4134_release_sample_access(iio_priv(indio_dev));
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
@@ -440,11 +579,6 @@ static int ad4134_min_io_mode_setup(struct ad4134_state *st)
 	int ret;
 
 	st->crc_en = true; /* In minimum I/O mode CRC cannot be disabled */
-	st->odr_gpio = devm_gpiod_get(dev, "odr", GPIOD_OUT_LOW);
-	if (IS_ERR(st->odr_gpio))
-		return dev_err_probe(dev, PTR_ERR(st->odr_gpio),
-				     "failed to get ODR GPIO\n");
-
 	ret = regmap_update_bits(st->regmap, AD4134_DIG_IF_CFG_REG,
 				 AD4134_DIF_IF_CFG_FORMAT_MASK,
 				 FIELD_PREP(AD4134_DIF_IF_CFG_FORMAT_MASK,
@@ -591,10 +725,61 @@ static int ad4134_probe(struct spi_device *spi)
 		return dev_err_probe(dev, PTR_ERR(st->regmap),
 				     "failed to initialize regmap");
 
-	ret = ad4134_min_io_mode_setup(st);
-	if (ret)
-		return dev_err_probe(dev, ret,
-				     "failed to setup minimum I/O mode\n");
+	if (device_property_present(dev, "adi,spi-mode")) {
+		ret = device_property_match_property_string(dev, "adi,spi-mode",
+							    ad4134_spi_modes,
+							    ARRAY_SIZE(ad4134_spi_modes));
+		if (ret < 0)
+			return dev_err_probe(dev, ret,
+					     "getting adi,spi-mode property failed\n");
+
+		st->spi_mode = ret;
+	} else {
+		/* Default to no-cs mode if adi,spi-mode is not specified */
+		st->spi_mode = AD4134_SPI_MODE_NO_CS;
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
+
+	st->odr_gpio = devm_gpiod_get(dev, "odr", GPIOD_OUT_LOW);
+	if (IS_ERR(st->odr_gpio))
+		return dev_err_probe(dev, PTR_ERR(st->odr_gpio),
+				     "failed to get ODR GPIO\n");
 
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
 					      iio_pollfunc_store_time,
-- 
2.53.0

