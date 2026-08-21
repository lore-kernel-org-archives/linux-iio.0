Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FE04C77DE;
	Fri, 21 Aug 2026 14:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787321297; cv=none; b=kiMG1bKYJTTT3ISDQgQJxILvLypi6DPZdn0+d+wUWTpIUarSXKj6WVjw+Qm6/kySJr3zy8iaLjq+mWvQWA+agA8s4LyZJy/OS3DE1coIb4TxGACWa6oB7OK1e39jwhb18eezefZYEhQ+BPV+JzkqAsB8R6HM6DazgZ1ngoriUhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787321297; c=relaxed/simple;
	bh=BC3GY2a0PfAaf1anUYAI3VBIwF6NWvD9eEF7jo39oM4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=uG3ihoH6SIfVNW+BqixFxSjjh2KJhauYPF0dhdxowVx0cem2JcK6bKMMg4N+R1OdV8hX0W1aphsZbeSVB/7rtpOdvgHXcHHZ4A4hcc985D/Fx4kiFEngWkzMQLWU2vBs30YGHeMoDJvgoUTvl0Zquy3Mf3pfygw1bFcRfNUcogA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=mnVLxM0i; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="mnVLxM0i"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LCpGA63677096;
	Fri, 21 Aug 2026 10:08:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=meDou
	IdYda+dFUbpyjE577+DP2BMvJelM4xTd/l8MgY=; b=mnVLxM0ixD7QkQNady3Dz
	7lMCBv0WmDdqzGpsXs54KyM00srLrvyjwcGZttCl9wTaCBCnZymJGbEdX+/dSdS6
	2xhYQfaeGfMyH3CxKbtJulo0uIscZACaPe/xvdcRr9NiMorBXzBHLI9BkVVu0+GW
	0oJjUqpL+IfIuCPxX6KJkUM9vj4BQjStTrkmenPuyQEsoN7pknHez5AQqdhRl4PM
	OFfYlnZj2NwtxE0tlqQSPyVsG3rwuB3e+DiQNwF5yg5ohAhf4MOJhJD6uRwCZ0+a
	RfB7540ScGNC3ZfwgDI3V8FH86IdE8ghfe2dxzFYsOTx4wCE4AXhuIWL5lhnerv5
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4g6a27k3xt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 10:08:06 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67LE85VI032952
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 21 Aug 2026 10:08:05 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 21 Aug 2026 10:08:05 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 21 Aug 2026 10:08:05 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 21 Aug 2026 10:08:05 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.223.174])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67LE7Kkn024319;
	Fri, 21 Aug 2026 10:07:55 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Fri, 21 Aug 2026 16:06:57 +0200
Subject: [PATCH v4 04/14] iio: adc: adi-axi-adc: Add support for CRC
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260821-ad7768-driver-v4-4-bb8fbd06d4eb@analog.com>
References: <20260821-ad7768-driver-v4-0-bb8fbd06d4eb@analog.com>
In-Reply-To: <20260821-ad7768-driver-v4-0-bb8fbd06d4eb@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787321240; l=2211;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=BC3GY2a0PfAaf1anUYAI3VBIwF6NWvD9eEF7jo39oM4=;
 b=j6f/8oYRld8ZiXeJUHSER0zlB81tlKyoo6ta3Y2CUH/izU0rR5Cvs/heyLOeyaQbV2PD6SZdj
 zpRDKZblNV3BYQCiecIxc4Zfs8qI5BKyGCYapyz7dPwRQSsnNhKSqkX
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: MiGLaABGPLw4L2hejH5ZKxkmgzD_1aNT
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDEwOSBTYWx0ZWRfX237qJlScs8tT
 a6HEEWEnECUjJlKvqlVs4kWURkg1VW4IGf6H7TISFWzp6Oq6LjJz9q6uSCAIEytMEzClS72mJuw
 iEI3gCufoq7cv0OhK2ncw1ETKAKU4VAV6tplDKcntBsBm13ZyOuD
X-Authority-Analysis: v=2.4 cv=FeoHAp+6 c=1 sm=1 tr=0 ts=6a885bc6 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8
 a=xcMXqGzQfnDy9uQaBxsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: MiGLaABGPLw4L2hejH5ZKxkmgzD_1aNT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDEwOSBTYWx0ZWRfX9QFhI02AaUmd
 goUJSUA8h2XLGAzX9YgDFO7aYRRCdzPOWTvTChoHFcPFjQ3MJo1NHhEGW8aUwzzHpON9KG7Cvuk
 9XR1IQ4Tc8Vq/L3Ev5iYdKjooJYZvLfjx29Unof3XgzFU2wROLQ4sSYTOXZIJArVzgdjCeHQqEd
 4UFwnWIczBdXH2rwBy1yXhgD0wsv2TXp/pIVn1zXWWIV8iJtSMiXN+Hm5VIX+9kwOfoo5xgpbOS
 0k3r8FUfEjByBku2yowG8VXp2PlZhQywwScnAViqb/3MStHdkhk0V05EqKRuR2EhoclnOLgLFJ6
 CRyplwLjzfX2NEvurWuhvYW5R5DcV8OBF2UMgztfR7uXubhQ8b4uidhRdW4ZDuQXLl26GWiJ1b7
 p9h+yYs4MAf4StnOmA4fBSBdEYQsA7snCeH6rIJoexO8rCpeMsef22IXSRKh5uMc+vi8kDu8zyr
 v80KVnTEUsnEBHD9ARA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_04,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608210109

Add support for enabling and disabling Cyclic Redundancy Check (CRC)
processing in the AXI ADC backend. CRC provides data integrity verification
for high-speed ADC data streams, ensuring reliable data transfer between
the ADC frontend and backend processing systems.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 drivers/iio/adc/adi-axi-adc.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index b5e59b1871b6..e8f149e230e7 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -47,6 +47,9 @@
 #define    ADI_AXI_ADC_CTRL_DDR_EDGESEL_MASK	BIT(1)
 
 #define ADI_AXI_ADC_REG_CNTRL_3			0x004c
+/* Bit 8 is common to all AXI ADC cores; bits 7-0 are per-HDL-project. */
+#define    ADI_AXI_ADC_CNTRL_3_CRC_EN_MASK	BIT(8)
+
 #define   AXI_AD485X_CNTRL_3_OS_EN_MSK		BIT(2)
 #define   AXI_AD485X_CNTRL_3_PACKET_FORMAT_MSK	GENMASK(1, 0)
 #define   AXI_AD485X_PACKET_FORMAT_20BIT	0x0
@@ -567,6 +570,22 @@ static int axi_adc_reg_access(struct iio_backend *back, unsigned int reg,
 	return regmap_write(st->regmap, reg, writeval);
 }
 
+static int axi_adc_crc_enable(struct iio_backend *back)
+{
+	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
+
+	return regmap_set_bits(st->regmap, ADI_AXI_ADC_REG_CNTRL_3,
+			       ADI_AXI_ADC_CNTRL_3_CRC_EN_MASK);
+}
+
+static int axi_adc_crc_disable(struct iio_backend *back)
+{
+	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
+
+	return regmap_clear_bits(st->regmap, ADI_AXI_ADC_REG_CNTRL_3,
+				 ADI_AXI_ADC_CNTRL_3_CRC_EN_MASK);
+}
+
 static const struct regmap_config axi_adc_regmap_config = {
 	.val_bits = 32,
 	.reg_bits = 32,
@@ -615,6 +634,8 @@ static const struct iio_backend_ops adi_axi_adc_ops = {
 	.num_lanes_set = axi_adc_num_lanes_set,
 	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_adc_reg_access),
 	.debugfs_print_chan_status = iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
+	.crc_enable = axi_adc_crc_enable,
+	.crc_disable = axi_adc_crc_disable,
 };
 
 static const struct iio_backend_info adi_axi_adc_generic = {

-- 
2.43.0

