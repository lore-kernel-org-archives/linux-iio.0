Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB683C872B;
	Thu,  8 Oct 2026 09:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791451236; cv=none; b=ac22ZmkUxGfeg+O/zCl51qFZpEA88Sj0KNPg/Oq0/UNUTyblHN69ahwHvM6f1FkyKxUBLLwhLL9u3PfGSDYMjhkTQWch4NrQ1hUNjWrsx3A0TgZHRlNsMtGIdEPTVJyOvAe8OARzd4B9F1P+C3y/VgMmQBv2av2jamZaulyT1Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791451236; c=relaxed/simple;
	bh=BkOEDqYlS58ff/UeYnUVgwWKZJLIQYq/R44kqjjZ3bo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=VcslaNndahOs+UIjD3lBgGhoL3UXMs3HJ0v5CEmNoeXWbKeCgaCusq1Lnp+6/m7HFO+V38tcwsa/ft54WSarOjH2/1/rdLJMGWJtJFhrdGLke+1Ej7Z56fa5XM7JZC4ybiWl+HfaJcWv4nTYyrS/0XMCs0WlKVe6t6Ds7oxyR1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=ppQNyzbA; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=b+J8w9KZ; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="ppQNyzbA";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="b+J8w9KZ"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6987MQ773290626;
	Thu, 8 Oct 2026 05:20:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=DKIM; bh=GYNrkIVDjBhVVj8g
	P/9v6X6IVOiB8GYWfuV3mrS+89I=; b=ppQNyzbAD5QTMNevBNkS3MfsB1NLSIIE
	NT6Krff3mdzfvAPudWNwIhszMpjTcqT8+3Ri1+spq0FmbpAmVZwfo9plSY8GEIbL
	5UzgkHtVz7tRQrMXmpQXEYRopMzW9fm9W2iJa8xncUTf4vq+55X51Z0qym3Pw/F/
	tKn++TjxNgzJL/mKg9SccGgXMxwuQ9XgYDMYdVpK7sDTkC9zcOwikvyWSLD6+Bl0
	9MyODjwa5FX7B2FJDdFKq23DySa0ZX2MhCLGvvO4O8dT2sLZIueSfs7hyiSWjLIk
	FAgUNpcy2WLb4jBWWV65a/6sg6qzydr+b2lEwaIOZnZkaAaK/VOagw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=GYNrkIVDjBhVVj8gP/9v6X6IVOi
	B8GYWfuV3mrS+89I=; b=b+J8w9KZqHIzUuClhwiVJB4jZ9RQuW1ILrvPp2MnxPo
	7c21hP4SZxmd3pYEG5iXKNkASEDxrn3kcYZW8PlT3KOZfr9S9DuD5Oeb+RO3z5is
	13s9rvQc2aVQjPO4wev+AgHlyPQLHBS6EnoBCRjr9yzTRWhQlFBVgLV5qWTmPvdm
	0qCdHkPl8fDAUakN+HL8/eb/YkrQMZ++eSNs6lR/U3UYr6mCZjzRYzOhDqEjoxr1
	ln5G0K/2BS9a+O03/lQIXQRYdy/dFI1kUPzL4XoQctwpbtVjVXR7w565XChep09/
	tAUKWIBcGQS9LhuokM4/t2YI3EvVPglXA4/nyQrlosA==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4h5xer33g4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Oct 2026 05:20:08 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6989K7vo036764
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Oct 2026 05:20:07 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 8 Oct 2026 05:20:07 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 8 Oct 2026 05:20:07 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 8 Oct 2026 05:20:07 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.225.204])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6989JsHp025174;
	Thu, 8 Oct 2026 05:19:57 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Thu, 8 Oct 2026 11:19:15 +0200
Subject: [PATCH] iio: dac: ad5529r: Clean up definitions and regmap
 configuration
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261008-ad5529r-review-followup-v1-1-84a98e0e27eb@analog.com>
X-B4-Tracking: v=1; b=H4sIABJgx2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDAwMz3cQUU1MjyyJdkOLUct20/Jyc/PLSAl0jo2QLUxPzZNMkM1MloO6
 CotS0zAqwydGxtbUAgjmZ/WkAAAA=
X-Change-ID: 20261006-ad5529r-review-followup-22c8547c5b65
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux@analog.com>,
        <linux-kernel@vger.kernel.org>, <jan.sun97@gmail.com>,
        Andy Shevchenko
	<andriy.shevchenko@intel.com>,
        Janani Sunil <janani.sunil@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791451194; l=3899;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=BkOEDqYlS58ff/UeYnUVgwWKZJLIQYq/R44kqjjZ3bo=;
 b=1RUgaNx//96crPyTFmvYpbEJ1vJqVA7eKFsJivcRvcAjeIVskciQ5UhZFnvpC8jvAfISCeQa+
 L1If0PcsMOUC+LwqrkHEOy29j1n4+hVDT9tD8HZBa3SbgxRb6qXI3EY
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: dnePT5O1iY8-oCAdgT_QmJ3Cxt-WAPrv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAzNiBTYWx0ZWRfX4BwdoaoBe45f
 /8iX41chs0vltH2xe2OG3IJpii02WzhCyE5/g6oMY32PAoUGQoMl3MvD4GDTL6nGu7ya+iDm5LR
 kFpYylksoFTRHgCj2XpcOzpLjZeLDmCCcicbwtuuJxTE+h2qs2iQ09WGCZ4hXiYbEMu1EYPy00D
 CHSHVRT6K/y6GSXQt2el3xMX0nz2093xGpw54SN/T75suZFy8Ib0vjCuS/uYnppEZimgMJIRFtG
 PRDtb8mlFx2XCCn50iLIQjP0thhM558qnut19rKXm9c+ivw/d7MsuyPPqU599X9HcW0davrURUs
 g2e3zbMMj69+IuSfqin9hd3tKVQ7LPrVvlwZ3KqM8ayrkfgGD1bQVQYKb0zKXbZk7lSwlZaAJ05
 7yMDRRZ+kBAffTcUnDcW4n3xM8fSe3ebZY6nu5vSdauc8vviD5E0Q70De6DUZS5zGIvl6Xk0l1F
 3VxuG6EYSFquEr064wQ==
X-Proofpoint-ORIG-GUID: dnePT5O1iY8-oCAdgT_QmJ3Cxt-WAPrv
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAzNiBTYWx0ZWRfX559ZIDLO537t
 HAnQlhEtBUwVLjlhZ5+ASGOzN9LuhcW0ErDeuHPCddNxkEbFkiJlOG5zFrWbtPC8i7BxuGKvLpk
 Ozw7rrMTTSHonvf9DPIB1QiwkbaE3uV3ZEksAt3RuU1bLWj5qKV0
X-Authority-Analysis: v=2.4 cv=daIVTnXe c=1 sm=1 tr=0 ts=6ac76048 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=gAnH3GRIAAAA:8 a=Yi-XDGa3olEvBegW6LgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 impostorscore=0 bulkscore=0
 clxscore=1015 phishscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080036

Use fixed width register literals matching the device's register address
width. Rely on SPI regmap's default read flag instead of specifying the
same value explicitly, and remove parentheses around the channel
initializer.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
The AD5529R driver is already queued in the IIO tree. This patch follows
up on the remaining review comments from Andy Shevchenko:

https://lore.kernel.org/r/arzTnOTaL97GudZM@ashevche-desk.local/
---
 drivers/iio/dac/ad5529r.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/dac/ad5529r.c b/drivers/iio/dac/ad5529r.c
index 8154b87ff831..04bb02af9612 100644
--- a/drivers/iio/dac/ad5529r.c
+++ b/drivers/iio/dac/ad5529r.c
@@ -24,19 +24,19 @@
 
 #include <linux/iio/iio.h>
 
-#define AD5529R_REG_INTERFACE_CONFIG_A		0x00
+#define AD5529R_REG_INTERFACE_CONFIG_A		0x000
 #define   AD5529R_INTERFACE_CONFIG_A_SW_RESET	(BIT(7) | BIT(0))
 #define   AD5529R_INTERFACE_CONFIG_A_ADDR_ASCENSION	BIT(5)
 #define   AD5529R_INTERFACE_CONFIG_A_SDO_ENABLE	BIT(4)
-#define AD5529R_REG_DEVICE_CONFIG		0x02
-#define AD5529R_REG_CHIP_GRADE			0x06
-#define AD5529R_REG_SCRATCH_PAD			0x0A
-#define AD5529R_REG_SPI_REVISION		0x0B
-#define AD5529R_REG_VENDOR_H			0x0D
-#define AD5529R_REG_STREAM_MODE			0x0E
-#define AD5529R_REG_INTERFACE_STATUS_A		0x11
-#define AD5529R_REG_MULTI_DAC_CH_SEL		0x14
-#define AD5529R_REG_OUT_RANGE_BASE		0x3C
+#define AD5529R_REG_DEVICE_CONFIG		0x002
+#define AD5529R_REG_CHIP_GRADE			0x006
+#define AD5529R_REG_SCRATCH_PAD			0x00A
+#define AD5529R_REG_SPI_REVISION		0x00B
+#define AD5529R_REG_VENDOR_H			0x00D
+#define AD5529R_REG_STREAM_MODE			0x00E
+#define AD5529R_REG_INTERFACE_STATUS_A		0x011
+#define AD5529R_REG_MULTI_DAC_CH_SEL		0x014
+#define AD5529R_REG_OUT_RANGE_BASE		0x03C
 #define AD5529R_REG_OUT_RANGE(ch)		(AD5529R_REG_OUT_RANGE_BASE + (ch) * 2)
 #define AD5529R_REG_DAC_INPUT_A_BASE		0x148
 #define AD5529R_REG_DAC_INPUT_A(ch)		(AD5529R_REG_DAC_INPUT_A_BASE + (ch) * 2)
@@ -50,9 +50,8 @@
 #define AD5529R_REG_MULTI_DAC_HOTPATH_SW_LDAC	0x1A8
 
 #define AD5529R_MAX_REGISTER			0x232
-#define AD5529R_8BIT_REG_MAX			0x13
+#define AD5529R_8BIT_REG_MAX			0x013
 #define AD5529R_MAX_CHANNELS			16
-#define AD5529R_SPI_READ_FLAG			0x80
 #define AD5529R_ADDR_SHIFT			12
 
 struct ad5529r_model_data {
@@ -60,7 +59,7 @@ struct ad5529r_model_data {
 	unsigned int resolution;
 };
 
-#define AD5529R_DAC_CHANNEL(chan) ((struct iio_chan_spec) {		\
+#define AD5529R_DAC_CHANNEL(chan) (struct iio_chan_spec) {		\
 	.type = IIO_VOLTAGE,						\
 	.indexed = 1,							\
 	.output = 1,							\
@@ -68,7 +67,7 @@ struct ad5529r_model_data {
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
 			      BIT(IIO_CHAN_INFO_SCALE) |		\
 			      BIT(IIO_CHAN_INFO_OFFSET),		\
-})
+	}
 
 static const char * const ad5529r_supply_names[] = {
 	"vdd-io",
@@ -433,7 +432,6 @@ static int ad5529r_probe(struct spi_device *spi)
 		.reg_bits = 16,
 		.val_bits = 8,
 		.max_register = AD5529R_8BIT_REG_MAX,
-		.read_flag_mask = AD5529R_SPI_READ_FLAG,
 		.rd_table = &ad5529r_8bit_readable_table,
 		.wr_table = &ad5529r_8bit_writeable_table,
 		.reg_base = dev_addr << AD5529R_ADDR_SHIFT,
@@ -443,7 +441,6 @@ static int ad5529r_probe(struct spi_device *spi)
 		.reg_bits = 16,
 		.val_bits = 16,
 		.max_register = AD5529R_MAX_REGISTER,
-		.read_flag_mask = AD5529R_SPI_READ_FLAG,
 		.val_format_endian = REGMAP_ENDIAN_LITTLE,
 		.rd_table = &ad5529r_16bit_readable_table,
 		.wr_table = &ad5529r_16bit_writeable_table,

---
base-commit: a3b3580713f3ac5a32dc2874ee546828977a1d68
change-id: 20261006-ad5529r-review-followup-22c8547c5b65

Best regards,
-- 
Janani Sunil <janani.sunil@analog.com>

