Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC4E3612F1;
	Fri, 28 Aug 2026 15:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787931086; cv=none; b=B0Ubk1M1x+I/xXIuHb66VzlXP0pa4/CQjs3AoXRzKgnuXLQHkSASbkYlAdUz6a3qAgCgGl/gntwiXPJ6/91nno5ENDj+bDQ3xGcEeS2NNOFd99mGT65WtUm8pipTfki4oAYP6yEKqmSpO6KdFIvEBIbVcPM0cWtiUxQLlxYGulY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787931086; c=relaxed/simple;
	bh=PyICtn448EN/Byag4obIZpriu1X20AQEWAXYvefarKo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Z9DN1yAlhBv+X2crbOS7zPzCvClOv7xJcmHTWSViTVWBZ2coo41Ydc7gFo83DbcO/KqPhnTHn5p6JllO0ivWqKwSOg1mb7HYE5LV0pFC1NaHp3ckukPVj9MV9EqYsIteMMq9fGh9HoRn8pKcmyJYhIcrc+igfDBMGu+U+QJiiD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Ua3/ai7/; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Ua3/ai7/"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SDVgLC1142281;
	Fri, 28 Aug 2026 11:31:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ggUlf
	NBEcj1WgTXWxgbpZomq3MRs/rWvFYGhbsUMZOk=; b=Ua3/ai7/AAuINBkYRWIbs
	DV906bhB3ep5zWjFVjFa+5a9+Fn8itnEsSMCZ7mpsbUuruu9PbyxyunxvJqu3EZp
	UfuyuVSKH04H7gUy2liqJgCxS88+u0xi/zuNUVDTU8g14GMKVm6B6FYeBeSWCUX6
	NH3zPv43KydQt/oi+U9R7+1nE3GVoqHraqIQ0rbrwawR7YBjDKvmt8a/Daw6Z3Tf
	P6AL39ytpCnM4+Yps+rZAIDpznPrTq0chzBR+4fxBNoYUbLNlAAj3Re9+D8IFv4D
	MDZPPkjaUF5H4F7r7xGhe1i3V5jGmRzTg/EA5AZ/3aRssxxejkmu7Je4yoe7shCX
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gaj3cqj5y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 11:31:16 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67SFVF2n013014
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 28 Aug 2026 11:31:15 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 28 Aug 2026 11:31:14 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 28 Aug 2026 11:31:14 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 28 Aug 2026 11:31:14 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.223.174])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67SFUY3l031424;
	Fri, 28 Aug 2026 11:31:09 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Fri, 28 Aug 2026 17:30:29 +0200
Subject: [PATCH v5 06/20] iio: adc: ad7768: Validate master clock rate
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260828-ad7768-driver-v5-6-e33ca6f841a2@analog.com>
References: <20260828-ad7768-driver-v5-0-e33ca6f841a2@analog.com>
In-Reply-To: <20260828-ad7768-driver-v5-0-e33ca6f841a2@analog.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Michael Walle <mwalle@kernel.org>
CC: <linux@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <jananisunil.dev@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
	<u.kleine-koenig@baylibre.com>,
        Janani Sunil <janani.sunil@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787931034; l=2190;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=PyICtn448EN/Byag4obIZpriu1X20AQEWAXYvefarKo=;
 b=TPCNSi8VX5gG3dPOL8syiZYu7+mLYbrxsHTq2G25zk1LTH5T4vUapCKk9b2f+TwG5toe7KUen
 Rr+9fZYwW6HCzs3a3h8cMQfpwiLXMYyqBxCTUojMyMExJBjk7NX3yez
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: SlzNEJ3qGLJm_0AR81Rjbct29gCWApC2
X-Authority-Analysis: v=2.4 cv=erHvCIpX c=1 sm=1 tr=0 ts=6a91a9c4 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8
 a=P_lMv_IeYrmPur7vI-MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: SlzNEJ3qGLJm_0AR81Rjbct29gCWApC2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDEzNSBTYWx0ZWRfX885U2sSuiY/C
 WhZRd+SmUIQ7t7jPt3BulsnKSIq1W2j7y5jvRiX/adH4+XvukdFtbFTSMRWAsx+b/5VkTl6xhfQ
 SXLNNZNL5Ho9oXzZ+NKC+M21LVTc1/p7OHZcAdxS97SFjJFzSBDQaouXULSm0/7Va+1PtTrtmXL
 Z9SJ/qtClx63cisQsv1NjjHs8ej3CTLNK67hFCWte9S0U7DygtDTirS4IA3uAsXQH2OAvmbKaEG
 /9YRV8vJ4iCcLtqc12ghKwJIahn5Xoj8TTiRMzGvQhRbEpMw0Y7tfK/k6/p3UzCyscj4ahHu/iW
 QRfa8BA0TRYtB6M+aqTZs2vHiL3CH1AiJe9ooLpkLg5PHNGuNTGg1xAEZAC/5WUVodMyEcz9mUK
 75qrTIvvEVAqNxoTif97vRZBsa1auUxYbgQvchwXalIvTIMJ9dUk98ZGZg7Z+sGj+G+y+4t1YPc
 YYcIksM6tZpYmeircJg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDEzNSBTYWx0ZWRfXxOKzMIwwRDl5
 8KImXBeuvWwUQF4EQbHv8y0ISETnOj3CwEG45XxQYi1IPbIWJxD0W4o95x+UJa8k0P690EMwg0x
 SWKCvutU/1fetLZQ4WuYWokYrhuKzIfiOgS4bDJr1Hc5xdcXeDdz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0
 suspectscore=0 malwarescore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280135

Reject master clock rates outside the limits specified by the device.
External CMOS and LVDS clocks support 1.15 MHz to 34 MHz, while a
crystal requires 8 MHz to 34 MHz.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 drivers/iio/adc/ad7768.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/iio/adc/ad7768.c b/drivers/iio/adc/ad7768.c
index cb84bb344aef..ccd457c75224 100644
--- a/drivers/iio/adc/ad7768.c
+++ b/drivers/iio/adc/ad7768.c
@@ -24,6 +24,7 @@
 #include <linux/spi/spi.h>
 #include <linux/time.h>
 #include <linux/types.h>
+#include <linux/units.h>
 
 #include <linux/iio/backend.h>
 #include <linux/iio/iio.h>
@@ -100,6 +101,9 @@
 #define AD7768_SPI_REG_MASK				GENMASK(14, 8)
 #define AD7768_SPI_DATA_MASK				GENMASK(7, 0)
 
+#define AD7768_MIN_MCLK_FREQ_HZ				(1150 * HZ_PER_KHZ)
+#define AD7768_MIN_XTAL_FREQ_HZ				(8 * HZ_PER_MHZ)
+#define AD7768_MAX_MCLK_FREQ_HZ				(34 * HZ_PER_MHZ)
 #define AD7768_MAX_CHANNEL				8
 
 enum ad7768_clock_source {
@@ -758,6 +762,23 @@ static int ad7768_get_enable_vref(struct device *dev, unsigned int index)
 	return refp_uV - refn_uV;
 }
 
+static int ad7768_validate_mclk_rate(struct device *dev,
+				     const struct ad7768_state *st)
+{
+	unsigned long min_rate = AD7768_MIN_MCLK_FREQ_HZ;
+	unsigned long rate = clk_get_rate(st->mclk);
+
+	if (st->clock_source == AD7768_CLOCK_SOURCE_XTAL)
+		min_rate = AD7768_MIN_XTAL_FREQ_HZ;
+
+	if (rate < min_rate || rate > AD7768_MAX_MCLK_FREQ_HZ)
+		return dev_err_probe(dev, -EINVAL,
+				     "MCLK rate %lu Hz outside %lu-%lu Hz\n",
+				     rate, min_rate, AD7768_MAX_MCLK_FREQ_HZ);
+
+	return 0;
+}
+
 static int ad7768_probe(struct spi_device *spi)
 {
 	unsigned int spi_readback, rev_id;
@@ -831,6 +852,10 @@ static int ad7768_probe(struct spi_device *spi)
 		return dev_err_probe(dev, PTR_ERR(st->mclk),
 				     "Failed to get master clock\n");
 
+	ret = ad7768_validate_mclk_rate(dev, st);
+	if (ret)
+		return ret;
+
 	st->regmap = devm_regmap_init(dev, &ad7768_regmap_bus, spi,
 				      st->chip_info->regmap_config);
 	if (IS_ERR(st->regmap))

-- 
2.43.0

