Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18684219E8;
	Thu, 14 May 2026 14:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778770162; cv=none; b=NZZ4cDWdAWo6EgPJ1+j6IRCUPffiti76nsmLbGPswN8635rW4m/Lin7F/iqU45VKFgOQIae4WGjbYGBNYR6HaNVg/dJs33ugj4p1vtZL0xWwPi4w8THNvFfO6UcMg5Myr/nOWCDFLxnYUi2txgy9IqBFtDmQ/tt7Lo7RMYonAS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778770162; c=relaxed/simple;
	bh=Qz/boMORxlZ1KI3Pvg8gYe0+8w5uPjM0visgSbDRGWo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KY9cDZkdf5GtajqFmOKLPq/gGZjQl0edHPgnIHafemHs01IPiK0aD7IwwmhiNHoWCZT1+jSX0ZaGPAv/ug+lG6PeufEhKfeNblGXe1pWiP2e519f3S7MC4rKXKXArabxUsSNiGyFIpzDMLcenN3BKAuZcY/J6SbcnjGyP8xs3qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ihpussna; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ihpussna"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64EDgIHk2904955;
	Thu, 14 May 2026 10:49:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=sljiz
	F/u5WC++Xy6pey5/xnDlH9UMAj//KiFC4SdRcs=; b=ihpussnapkceBGCSEOe7l
	MSIfiXiOrvhYNf/H4KmUf991yb1BYl6LQGk3I0we7zLai2Wd/5zqEn9iYa/jVyU5
	gCXWQ4Nw2Ab+23xu1Fynp2W2ht+xjFb5KKSLNJiDazKQw1fI73ptfU2SLwJh4uCL
	u/a2+7RnY79E3Zu1p7ukkAs/0XbiqVJ+JeV+boW5VyAzTBg+3TXEhRkImQoha+H5
	TsrVV1hPGGLbHfn4Vp9ZnuVAoAqxRSgCf3LOFqWqHmMFAxp0uWTae/e4KFbp1Bh4
	k7/e8LLFSYAnEdFRV/F8Wtp73BVNfRRcpVrUZw6JpAgVbewsBKENZOSf/PiH86gV
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4e4t1xvwap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 May 2026 10:49:17 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 64EEnGmE041713
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 14 May 2026 10:49:16 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 14 May
 2026 10:49:16 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 14 May 2026 10:49:16 -0400
Received: from HYB-MkYHBcJRSnh.ad.analog.com (HYB-MkYHBcJRSnh.ad.analog.com [10.48.65.202])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 64EEmjAY014051;
	Thu, 14 May 2026 10:49:09 -0400
From: Liviu Stan <liviu.stan@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Antoniu
 Miclaus <antoniu.miclaus@analog.com>,
        Francesco Lavra <flavra@baylibre.com>,
        Liviu Stan <liviu.stan@analog.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v2 1/7] iio: temperature: ltc2983: Fix macro parenthesization and rename
Date: Thu, 14 May 2026 17:46:48 +0300
Message-ID: <20260514144712.64374-2-liviu.stan@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260514144712.64374-1-liviu.stan@analog.com>
References: <20260514144712.64374-1-liviu.stan@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: hHbn1pxAxIwxrdjcqdeVLKpfTJGnyBi5
X-Authority-Analysis: v=2.4 cv=Wbo8rUhX c=1 sm=1 tr=0 ts=6a05e0ed cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=NK9M8l_gB6tpaUwuH9IA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDE1MCBTYWx0ZWRfX7Tdd6cqd+dN3
 1VLHfoA6vurbNQfEWwrtXhIpMg+e5slsJERRP6f7NQJhkOaoNFQvBGvuXrY2QNOGlVDkjTjboRS
 wxSzoXPsdREut0K9+qxaJOWFuDwx+9l3DXjtYy/NmfgJUciVm8R4S8oTSuTzF3YiAcGTNkmfyzu
 /JtrkwAGQqm0B1YKYqu6t9Jniu2UddJ8KI4XL8Wpdc6zKl02geuIsgfMoXOccOaBNItvUAH8zSH
 4qhNLHTDnvRd1y2lIYN8l6H8F9AWi98vJb7hTcHLwDDhjKMCJUK8sswY1ahr3LFL+I9DNIPBjfD
 J7sEblTi5yseZRX1qxZmAGMZTS3sf4F5pvgNmdpM/U2JEHMeW1WTXpVE5gQn8/saEvuftY2pTcP
 wWk6z982SgRaaa1jbk50fPiB+yMCE5x2DD85OQGalOLIiYrk5AHnW254LiPR7Rxkv1py5wvIzgX
 VYVbqXrxRp4efCMsgaQ==
X-Proofpoint-GUID: hHbn1pxAxIwxrdjcqdeVLKpfTJGnyBi5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605140150

Wrap the 'chan' parameter in LTC2983_CHAN_START_ADDR() and
LTC2983_CHAN_RES_ADDR() with parentheses to prevent potential
macro argument expansion issues. Also rename LTC2983_CHAN_START_ADDR
to LTC2983_CHAN_ASSIGN_ADDR and LTC2983_CHAN_RES_ADDR to
LTC2983_RESULT_ADDR, to better reflect the datasheet names and avoid
them being confused as related.

Fixes: f110f3188e5639c81c457b2b831d40dfe3891bdb ("iio: temperature: Add support for LTC2983")
Signed-off-by: Liviu Stan <liviu.stan@analog.com>
---
Changes in v2:
- New patch.

 drivers/iio/temperature/ltc2983.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
index 38e6f8dfd3b8..a292274e6ff0 100644
--- a/drivers/iio/temperature/ltc2983.c
+++ b/drivers/iio/temperature/ltc2983.c
@@ -56,10 +56,10 @@
 #define LTC2983_EEPROM_WRITE_TIME_MS		2600
 #define LTC2983_EEPROM_READ_TIME_MS		20
 
-#define LTC2983_CHAN_START_ADDR(chan) \
-			(((chan - 1) * 4) + LTC2983_CHAN_ASSIGN_START_REG)
-#define LTC2983_CHAN_RES_ADDR(chan) \
-			(((chan - 1) * 4) + LTC2983_TEMP_RES_START_REG)
+#define LTC2983_CHAN_ASSIGN_ADDR(chan) \
+			((((chan) - 1) * 4) + LTC2983_CHAN_ASSIGN_START_REG)
+#define LTC2983_RESULT_ADDR(chan, base) \
+			((((chan) - 1) * 4) + (base))
 #define LTC2983_THERMOCOUPLE_DIFF_MASK		BIT(3)
 #define LTC2983_THERMOCOUPLE_SGL(x) \
 				FIELD_PREP(LTC2983_THERMOCOUPLE_DIFF_MASK, x)
@@ -351,7 +351,7 @@ static int __ltc2983_chan_assign_common(struct ltc2983_data *st,
 					const struct ltc2983_sensor *sensor,
 					u32 chan_val)
 {
-	u32 reg = LTC2983_CHAN_START_ADDR(sensor->chan);
+	u32 reg = LTC2983_CHAN_ASSIGN_ADDR(sensor->chan);
 
 	chan_val |= LTC2983_CHAN_TYPE(sensor->type);
 	dev_dbg(&st->spi->dev, "Assign reg:0x%04X, val:0x%08X\n", reg,
@@ -1197,7 +1197,7 @@ static int ltc2983_chan_read(struct ltc2983_data *st,
 	}
 
 	/* read the converted data */
-	ret = regmap_bulk_read(st->regmap, LTC2983_CHAN_RES_ADDR(sensor->chan),
+	ret = regmap_bulk_read(st->regmap, LTC2983_RESULT_ADDR(sensor->chan, base_reg),
 			       &st->temp, sizeof(st->temp));
 	if (ret)
 		return ret;
-- 
2.43.0

