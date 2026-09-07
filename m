Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DD5456DF0;
	Mon,  7 Sep 2026 10:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788776407; cv=none; b=OOcp0t388opRXhMVpoiLYRYlOKMlB2gpJb0SvD8AjKH1NJybqdsbC/MDqW6fwDc44Mpw2VOH9SzMD5jwybcgrRmxn05omnqmDbanY69Pdmai3KRQbNIml/MlGfzG3krvWBBZYdJsNHrRO9OylCsoEDubswgfaOv2dd0rPiht/9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788776407; c=relaxed/simple;
	bh=7Hgd3VP7kY49kebIF+WkeD3M5EYG3nTnyBDX3s8uC6U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mK9JVnYe5HrsRybaJ3u5wDxniIRsGkpyW+o5y8WZm70fECXMUvbw8F2u+pXDW2xqyRQGHkxaGyZW66NjCCVgXOm04LkI+jPAb+B4xUkLkXtQMvhJ8YTUJ/N+aGq87JzcTuR4PlsUR8SEMCFfp3PAFNrE0eoun6/q2GBq3OlJcw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Y8lyjQnX; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Y8lyjQnX"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6879YNiS2726333;
	Mon, 7 Sep 2026 06:20:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=fHAlV
	rBiBjQlszKA7SNe3dH+0BhJxq6ijvam1i5M4zc=; b=Y8lyjQnXcEi8kGsDuseTv
	9wEadxfxYWT6TwNzRAXUtd1B9ZjbweUnYW9xknrgJGoa0h6gr7wNnmQtfXVfFXnE
	YRi2GfGjCgGftWS8I0EndMmHQ2EBr27Y+bFBSED+29/X5X+fyKOiPoTkX6V8IK7d
	obSyYae7kIiRo3HpCADymrY2LrDsbKbl8c6RI7TTdF9JnOaHrFl04sBcifFsPU++
	cPHEPrICmUgnpEeFX87beWbr9j3qcoUSleJWSJ0WTsVoA6LpjAqRTptp3Kw4SQus
	qxNJT5GhYTuhUd/i1iik+ouO0gz0kxNL/0kbRFdexc+AF8AWE7lPfNUDmxJmAj9W
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gh1dbvurh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Sep 2026 06:20:02 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 687AK1xF010667
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 7 Sep 2026 06:20:01 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 7 Sep
 2026 06:20:01 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 7 Sep 2026 06:20:01 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.185])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 687AJkx6007440;
	Mon, 7 Sep 2026 06:19:54 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux@analog.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] iio: adc: ad4080: add support for AD4885
Date: Mon, 7 Sep 2026 13:19:44 +0300
Message-ID: <20260907101944.9748-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907101944.9748-1-antoniu.miclaus@analog.com>
References: <20260907101944.9748-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=XOsAjwhE c=1 sm=1 tr=0 ts=6a9e8fd2 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=YKDl7HIqRfTMcHCtdIoA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDExMyBTYWx0ZWRfXy6RR7zIIefoN
 NwqDJjyfo5VMY9RiqI6RGHbqALE4B1c3vygYxn+NDpdEaTS0HRyJ2lase8yEh/BSOgH11TeAqB6
 OYO09DsKgxzdFSjwInbpQCw7QdMGq7xJHWO416HahUG5lHXQS/9A
X-Proofpoint-ORIG-GUID: 5lY_VMpcbLZpylTFCcpHmzlgnb1K5OaH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDExMyBTYWx0ZWRfX0DCq9bgcDN1N
 2YGRxibD6AuccxVS2/OiHR6D0edBn/vrlZQ1dRCqmgD00OZigIzUhisptrk+5jfpMhuKHii+PFP
 4yeXvSZ0WQXAoxxbI2SC2kIoCOy9SdM8icatKkpIzKqfGpLHgP3B5smg/IIZI7jsLixyInHjxkD
 XYYjsNSRAL9yskboqGSxtp4CKIU7Cz1rIs0BZHyHloiaxFOct69FjUFIyNipSTeAwfTN2urSjfM
 ey0JSkpY9aWALhbP0Tvi9RtyNGPHNw8W8fxoUq/aPgftlzIfeYDu0GTvwGmDQ/aSi2+g3W0gC5l
 pyFxsgje/UpreyGR4yt8uiLo8pgnds0LH09KMJwHvVnXi2wajKu7rmeUmnQE4Jc+TG5yem06gt3
 CnglLNfuQr64VJIU+g3vOEg7OTov4HTf9QJKaVBD+fuvuGwYGaoGdK0LejcuwSCoWTPpY+NzWhB
 QKNKUE7AwaYZHFW2veg==
X-Proofpoint-GUID: 5lY_VMpcbLZpylTFCcpHmzlgnb1K5OaH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_02,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 bulkscore=0 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609070113

Add support for the AD4885, a dual-channel, 16-bit, 10 MSPS SAR ADC.

The AD4885 is the dual-channel variant of the AD4085, sharing the same
register map and SPI interface as the rest of the AD4080 family. Like
the AD4884, it uses two independent ADC channels, each with its own SPI
configuration interface, but it runs at a lower maximum throughput and
therefore uses the same maximum LVDS conversion clock count as the
AD4085.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/adc/ad4080.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
index 994625a7cf8b..4843ecdd91a8 100644
--- a/drivers/iio/adc/ad4080.c
+++ b/drivers/iio/adc/ad4080.c
@@ -137,6 +137,7 @@
 #define AD4880_CHIP_ID						0x0059
 #define AD4883_CHIP_ID						0x005B
 #define AD4884_CHIP_ID						0x005C
+#define AD4885_CHIP_ID						0x005D
 
 #define AD4080_MAX_CHANNELS					2
 
@@ -561,6 +562,11 @@ static const struct iio_chan_spec ad4884_channels[] = {
 	AD4880_CHANNEL_DEFINE(16, 16, 1),
 };
 
+static const struct iio_chan_spec ad4885_channels[] = {
+	AD4880_CHANNEL_DEFINE(16, 16, 0),
+	AD4880_CHANNEL_DEFINE(16, 16, 1),
+};
+
 static const struct ad4080_chip_info ad4080_chip_info = {
 	.name = "ad4080",
 	.product_id = AD4080_CHIP_ID,
@@ -681,6 +687,16 @@ static const struct ad4080_chip_info ad4884_chip_info = {
 	.lvds_cnv_clk_cnt_max = 2,
 };
 
+static const struct ad4080_chip_info ad4885_chip_info = {
+	.name = "ad4885",
+	.product_id = AD4885_CHIP_ID,
+	.scale_table = ad4080_scale_table,
+	.num_scales = ARRAY_SIZE(ad4080_scale_table),
+	.num_channels = 2,
+	.channels = ad4885_channels,
+	.lvds_cnv_clk_cnt_max = 8,
+};
+
 static int ad4080_setup_channel(struct ad4080_state *st, unsigned int ch)
 {
 	struct device *dev = regmap_get_device(st->regmap[ch]);
@@ -890,6 +906,7 @@ static const struct spi_device_id ad4080_id[] = {
 	{ .name = "ad4880", .driver_data = (kernel_ulong_t)&ad4880_chip_info },
 	{ .name = "ad4883", .driver_data = (kernel_ulong_t)&ad4883_chip_info },
 	{ .name = "ad4884", .driver_data = (kernel_ulong_t)&ad4884_chip_info },
+	{ .name = "ad4885", .driver_data = (kernel_ulong_t)&ad4885_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad4080_id);
@@ -907,6 +924,7 @@ static const struct of_device_id ad4080_of_match[] = {
 	{ .compatible = "adi,ad4880", &ad4880_chip_info },
 	{ .compatible = "adi,ad4883", &ad4883_chip_info },
 	{ .compatible = "adi,ad4884", &ad4884_chip_info },
+	{ .compatible = "adi,ad4885", &ad4885_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ad4080_of_match);
-- 
2.43.0

