Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792795047;
	b=gyQCwFQTMWUKroWh3yNqb3K/rld63GcremicsL4OuOmEUkXyifHJKrd6wSYjN3UjNhha
	 UlZ1C93Wnc9yaWZz2QXJ1nPF/02ZHN3rbxEBoau58gg7tuoLCpwjkIqbE5Nne65eU0OV2
	 BlEvJgc8cu3WvCbHXYcT4JdAvyPb4zQJ2NJ3c/CMxyt4cTqX+f2XDZc6GMdjw89vHy3sq
	 fKzG5Xq5W9B+leKaWygnlVFf7sVyr5BnsqtWji3QX5nEIgBGfFz80nQoCnX8B1DmJ/oO3
	 jAY3Rml0B/tCA8kEG/Fn/1w1u4FJ9NVcUCpSF95Io7nTe7MuS+18pKrtrL87PXjhobA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792795047;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-ADIRuleOP-NewSCL:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=dsaWhTfRTBa/wPTn95noLzuhl1zM73P4rwsojkPdNJA=;
	b=AZPWgii9fkc2Ugr2Xu5YFU/0BqSM1EL1KBwyA/ehclobeSUGlIPVXNu9iXmDntJMs4j9
	 LvY0fwTiakrXwJxSPstX5IdPSM2UznamtUmBzVs13bpOSyUNkAPNf0/TAtJ/3IjnFJ5zL
	 N5/O7o1mva2G3XoY6tC2VcVcB5j5AJU+YCAeGF5tL9vDAktaKwfOIaGY1fTW91OgnWCqS
	 qguwwB+K8fh5gQwDkflPHmSjaLteQp55aE0CJCuvnp4Zq5z/Oclp1fFogzbxZcelHDWzK
	 JBnmyo75b83C8uUwTXVUSqgLc65qT93s8eK8DyrjnvhkYlc/B026O2Bnd8Z74HJIH5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=n0e1xNU0;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=K8AJHK36;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBBE606A31B;
	Fri, 23 Oct 2026 22:37:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEBBE606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=n0e1xNU0;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=K8AJHK36
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NLwaOO1784476;
	Fri, 23 Oct 2026 18:37:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=dsaWhTfRTBa/wPTn95noLzuhl1zM73P4rwsojkPdNJA=; b=n0e1xNU
	0MhtypGdXkuHiowGDpRxkWFWFM84tYUnyUmwHPHS195qeeBNgX0Skn9sxarjrj6X
	V2068iecY6g79wapFG3ilsJCyXcpaqQvLH7AukW3P8VmhMPBevoqjVXMw0K9nc1L
	wgOwEgRx9zR26sMYhpPsRm17EPzj48EN55EX5CGQPLqaB8rrq1ZuhJIe/gWMoohR
	HJxui2eHMBTSpoK3ZhQ6DxOT0PGJ7M8gfWQ55o75HshynrMdnA95XUVQLqNSTwP2
	gD99eANQ8O29TBbgBEFnrM1ZjHZCxyCZPo0KehUwgNLZtVjQi/Mf2TTHGYr2eYd9
	bru5+mpU9zrPXlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=dsaWh
	TfRTBa/wPTn95noLzuhl1zM73P4rwsojkPdNJA=; b=K8AJHK36szmabhMuvCtqJ
	6+R/sztJA1EbkvCSqDkZop0OU5UGxuy9cr1m2VAdpspnjde5xlSS/6Vd1NtMmzJg
	XVEBA+/vsfpW/S8nbWOg/PSRiJxlMgmp2dgtnn7P4R52knLK7ZmHNMiOUDkEy0dB
	bzoBdMF102MUMgwFc6c/sWBmP+lcxzDTuHlUVvTHmkQBQQ5GUNw1IkfZst3+WzTM
	5zexLkqv0PZ9vPAyibqBcA7oiBz5zW5iVWlzkHGHyhB05Yz7cXHnohrQzxLewOJs
	4hVTkEwql264rJACmDAMZLKXiNFEYmqxQzE/61fCXowZEIWItoZMV6HEP/mCbqQb
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hg2mvmcmw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 18:37:21 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 69NMbK89027048
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 23 Oct 2026 18:37:20 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 23 Oct 2026 18:37:20 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 23 Oct 2026 18:37:19 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 23 Oct 2026 18:37:19 -0400
Received: from work.maxim-ic.internal ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69NMb4b7005907;
	Fri, 23 Oct 2026 18:37:06 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v6 13/16] iio: adc: ad4134: Support SPI 4-wire mode
Date: Fri, 23 Oct 2026 19:36:59 -0300
Message-ID: <d7e9cffc6a8c90295631b2b6119743d37b8ccce5.1792792325.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1792792325.git.marcelo.schmitt@analog.com>
References: <cover.1792792325.git.marcelo.schmitt@analog.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: IpNJRtiNqls0jPLoqCtkp3W0hH8pwJdb
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA4OSBTYWx0ZWRfX24Z3b0ZunVAo
 DTl65lj7us3vsA/ufdbrlw0ZaxtgnUULCqzm0TYxvNsql2o8KiafApUPCHFBoW2dxAIVILaIIuE
 tnGVadx6onaHSYNXzXnqH4ses40TSHHbSdvzknxo9zSVjqRl68BU
X-Authority-Analysis: v=2.4 cv=YJoKWhGx c=1 sm=1 tr=0 ts=6adbe1a1 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8
 a=TGdYEJQ52wNW7GhdO5gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA4OSBTYWx0ZWRfX5ByUfgFUymuI
 jiUUFDsKcSfgNY+sdT1JwtuQisl68s8RskfoCZiEEI1wo9L9T7RuyH85rTcnJ7JDsBU5uOYDQ8N
 sOSIigfXkHPrSMusNvc31oNhCEPNwG1C/KA7E9o5DzekhpifNqggXHHRyaiEp3pR8quZXMMOvwb
 CmWioK3OrQbKgf+EyDSshY7JkCa04TFvwWyB2Gov74BjBA/ndKuNH/91mCFh1/wR5jXYjcjvMwr
 t0mWaAkg94Uwonee1iQddTFxbkD4/41hXr4RAKwmw4I5eUWQ/HH+BDA3PBb3o6y++wY3HPpieve
 Vf3a1PRoyjZc3Q45Hnt0SjGdzXDRmvwZICk4+GZMbhZjnnfhDXAHy/Q2EqRwEBfHD7ynAP8h/Xa
 06YBi8hMTVk9rzdjFcoPdkn5Tcfy8oahAuYOp5qx/UH7Au5OthpGL0JfYhPep0tWX01hKRNoBaT
 nEvg+laNtrDgR6Sqe1w==
X-Proofpoint-GUID: IpNJRtiNqls0jPLoqCtkp3W0hH8pwJdb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 phishscore=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230089

AD4134 devices can be wired in a few different ways. So far, only minimum
I/O mode was supported. While minimum I/O mode allows interfacing with
AD4134 with a reduced number of wires, that wiring configuration is not
suitable for high-throughput data acquisition.

Extend AD4134 support to enable interfacing in SPI 4-wire configuration.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v5 -> v6:
- Put dev_err_probe() in a single line.
- Use mux_state local vaiable to improve readability.
- Restore SPI mode if spi_setup() fails.
- Use cleanup macros to handle claim/release pairs.

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
 drivers/iio/adc/ad4134.c | 206 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 198 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 50b995a6a12c..70552e13d3a9 100644
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
index 4252244a23bc..4efb63c45aa2 100644
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
@@ -221,6 +239,99 @@ static const struct regmap_access_table ad4134_regmap_wr_table = {
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
+	unsigned int spi_mode = st->spi->mode & SPI_MODE_X_MASK;
+	int ret;
+
+	if (st->spi_mode != AD4134_SPI_MODE_NO_CS && spi_mode != SPI_MODE_0) {
+		st->spi->mode &= ~SPI_MODE_X_MASK;
+		st->spi->mode |= SPI_MODE_0;
+		ret = spi_setup(st->spi);
+		if (ret) {
+			st->spi->mode &= ~SPI_MODE_X_MASK;
+			st->spi->mode |= spi_mode;
+			return ret;
+		}
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
+DEFINE_GUARD(__ad4134_reg_access_mode, struct ad4134_state *,
+	     ad4134_claim_reg_access(_T), ad4134_release_reg_access(_T));
+DEFINE_GUARD_COND(__ad4134_reg_access_mode, _try, ad4134_claim_reg_access(_T));
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
+	unsigned int spi_mode = st->spi->mode & SPI_MODE_X_MASK;
+	int ret;
+
+	if (st->spi_mode != AD4134_SPI_MODE_NO_CS && spi_mode != SPI_MODE_1) {
+		st->spi->mode &= ~SPI_MODE_X_MASK;
+		st->spi->mode |= SPI_MODE_1;
+		ret = spi_setup(st->spi);
+		if (ret) {
+			st->spi->mode &= ~SPI_MODE_X_MASK;
+			st->spi->mode |= spi_mode;
+			return ret;
+		}
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
+DEFINE_GUARD(__ad4134_sample_access_mode, struct ad4134_state *,
+	     ad4134_claim_sample_access(_T), ad4134_release_sample_access(_T));
+DEFINE_GUARD_COND(__ad4134_sample_access_mode, _try, ad4134_claim_sample_access(_T));
+
 static int ad4134_calc_spi_crc(u8 inst, u8 data)
 {
 	u8 buf[] = { inst, data };
@@ -246,6 +357,10 @@ static int ad4134_reg_write(void *context, unsigned int reg, unsigned int val)
 	};
 	int ret;
 
+	ACQUIRE(__ad4134_reg_access_mode, claim)(st);
+	if (ACQUIRE_ERR(__ad4134_reg_access_mode, &claim))
+		return -EBUSY;
+
 	ad4134_prepare_spi_tx_buf(reg, val, st->tx_buf);
 
 	ret = spi_sync_transfer(st->spi, &xfer, 1);
@@ -265,6 +380,10 @@ static int ad4134_data_read(struct ad4134_state *st, unsigned int reg,
 	u32 sample = 0;
 	int ret;
 
+	ACQUIRE(__ad4134_sample_access_mode, claim)(st);
+	if (ACQUIRE_ERR(__ad4134_sample_access_mode, &claim))
+		return -EBUSY;
+
 	/*
 	 * To be able to read data from all 4 channels through a single line, we
 	 * set DOUTx output format to 0 in the digital interface config register
@@ -305,6 +424,10 @@ static int ad4134_register_read(struct ad4134_state *st, unsigned int reg,
 	unsigned int inst;
 	int ret;
 
+	ACQUIRE(__ad4134_reg_access_mode, claim)(st);
+	if (ACQUIRE_ERR(__ad4134_reg_access_mode, &claim))
+		return -EBUSY;
+
 	inst = AD4134_REG_READ_MASK | reg;
 	ad4134_prepare_spi_tx_buf(inst, 0, st->tx_buf);
 
@@ -374,6 +497,21 @@ static irqreturn_t ad4134_trigger_handler(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
+static int ad4134_buffer_preenable(struct iio_dev *indio_dev)
+{
+	return ad4134_claim_sample_access(iio_priv(indio_dev));
+}
+
+static int ad4134_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	return ad4134_release_sample_access(iio_priv(indio_dev));
+}
+
+static const struct iio_buffer_setup_ops ad4134_buffer_setup_ops = {
+	.preenable = &ad4134_buffer_preenable,
+	.postdisable = &ad4134_buffer_postdisable,
+};
+
 static int ad4134_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val, int *val2, long info)
@@ -442,11 +580,6 @@ static int ad4134_min_io_mode_setup(struct ad4134_state *st)
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
@@ -552,6 +685,7 @@ static int ad4134_probe(struct spi_device *spi)
 	struct device *dev = &spi->dev;
 	struct reset_control *rst;
 	struct iio_dev *indio_dev;
+	struct mux_state *mux_st;
 	struct ad4134_state *st;
 	int ret;
 
@@ -593,10 +727,64 @@ static int ad4134_probe(struct spi_device *spi)
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
+		mux_st = devm_mux_state_get_optional_selected(dev, "reg_access");
+		if (IS_ERR(mux_st))
+			return dev_err_probe(dev, PTR_ERR(mux_st),
+					     "failed to get reg_access mux-state\n");
+
+		st->mux_st[AD4134_SDO_INPUT] = mux_st;
+		ret = ad4134_min_io_mode_setup(st);
+		if (ret)
+			return dev_err_probe(dev, ret, "failed to setup minimum I/O mode\n");
+	} else {
+		/*
+		 * This controls a multiplexer OUTSIDE OF AD4134 SILICON.
+		 * See AD4134 IIO documentation for details.
+		 */
+		mux_st = devm_mux_state_get(dev, "reg_access");
+		if (IS_ERR(mux_st))
+			return dev_err_probe(dev, PTR_ERR(mux_st),
+					     "failed to get reg_access mux-state\n");
+
+		st->mux_st[AD4134_SDO_INPUT] = mux_st;
+
+		mux_st = devm_mux_state_get(dev, "data_read");
+		st->mux_st[AD4134_DOUT0_INPUT] = devm_mux_state_get(dev, "data_read");
+		if (IS_ERR(mux_st))
+			return dev_err_probe(dev, PTR_ERR(mux_st),
+					     "failed to get data_read mux-state\n");
+
+		st->mux_st[AD4134_DOUT0_INPUT] = mux_st;
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

