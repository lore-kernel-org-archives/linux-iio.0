Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6418F4F4723;
	Wed, 16 Sep 2026 11:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789557354; cv=none; b=Ik4VuGCIThAKRxKu6EhoPBRtLPPHQGhbEDIBBrwcMIauZwMbiv0IFMpbzxiVh5nozhADiO6CL/BH+s9GfZi0BYKG4Ia/OvB6+VFAp1LugW6RSgXgZRhU43Q9d3FBfSzLULdk0BUM4/KT2rPkmxxv+6MERdI7TLlt5dDj3efpG/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789557354; c=relaxed/simple;
	bh=1LmTZQAQz6oExoyaHKp8WvjGN1lsIiT0cUk3IdSy8is=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=mkE7iib30WrE1N/TtsSixrtRr0Zxo/M+2fmsJ1a9rL3EU/TPJ++siFrpEia6fZ1ONJ0yP0D2CcB7ooZM36R1Kvj2DsE6uI42iEYEwaEOUjeTfv6XKHOdiP04HAbQcKUBKkEN2OWih/78gATZLdUKZQ+DxycjHsGJ23rn30LD/RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=cnchwRke; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="cnchwRke"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68G7lHRX2062314;
	Wed, 16 Sep 2026 07:15:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=KGXos
	swi/MKqAe9zxr3HL4fKbi5P8nB5DiQuFtyobwU=; b=cnchwRke5NGmZ6W663q9w
	sGS98cVj9jgAcHegRspaIdulShXzJR5pWJwrSQjN1LW3k1f3SbU0YE+JEzoCmg78
	1UIFnbZKSoeuw9vkre/NJGSLyo4xfjNz1o4Jy+5peaXY80VmFoJ+1mur7pWWxcaA
	zbYGzQjCTcgAZxX27zdRQRoIgc1o1K8tOjrH4q7lp8wgLPWpeT34OC+w4x2EgJi1
	q/GlPYAzN5di8ecsFrPJUofEE681GLWeLSNuC46i13BGVWSOqrrx6n9DFbzW+Qon
	H2bNjZt50ZmPsMdwAOwz2Kn2N05vziS9OewvJ6Q6ITrTTnqFkUoXwt7wo/XipmD8
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gq43rp8ps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 07:15:24 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 68GBFNKl047124
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 16 Sep 2026 07:15:23 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 16 Sep 2026 07:15:23 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 16 Sep 2026 07:15:23 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 16 Sep 2026 07:15:23 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com (HYB-e1y2fvUQ3cx.ad.analog.com [10.44.3.69])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68GBENE4004263;
	Wed, 16 Sep 2026 07:15:18 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Wed, 16 Sep 2026 13:14:01 +0200
Subject: [PATCH v8 12/17] iio: adc: ad7768: Wait for digital filters to
 settle
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260916-ad7768-driver-v8-12-27aa24db5225@analog.com>
References: <20260916-ad7768-driver-v8-0-27aa24db5225@analog.com>
In-Reply-To: <20260916-ad7768-driver-v8-0-27aa24db5225@analog.com>
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
        Michael Walle <mwalle@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
CC: <linux@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <jananisunil.dev@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
	<u.kleine-koenig@baylibre.com>,
        Janani Sunil <janani.sunil@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789557263; l=2279;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=1LmTZQAQz6oExoyaHKp8WvjGN1lsIiT0cUk3IdSy8is=;
 b=/DVf+PV2YA7hLQEH8N+fWaelcXF5GLJRKeeKKLtkVPJJ3dXArEhcmkMl6Ds9BrDBun0XqVWBY
 jrBP2zKDfDwD0bfKtTC4x3F9QUHqfltNULTo+p7WJYL19/BTSaD+6+G
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: UEgLJ4mL8Ps1KGHQJ4OfuaIA85g2i9gd
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDE0OCBTYWx0ZWRfX/ewDixh8i60H
 iONSKWINkIbYwgiI2Iqts5ZjuHaBB+l5QLirP62QIHFDks56Pa1f2DZs4/EizVW2fG3gLITdzZP
 SuSDfQqhrFLiuIrw2ML5gf+8R1cz0cl1CmMWpPkR+ASwQHYIV+P6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDE0OCBTYWx0ZWRfX8+lrkrO9IC20
 MMyAPzPQVk7/ziDheefzdbXEPOVi1B31ocUh9TrpOEXMjco2mkcPXpxoRehm4ud3pHyvGCUVkkx
 8p2K2Y1Mzl6Bfe1IrrlpoYzcTrP+zRhfw6CLN4qddnxcQiSLxPcra6BHScdGYnHSyaJ2mqiYTm/
 GvsCNN/lmfxwbARFmw8L4oNGxAoJzKSaY/YxvB1DV6mLF5SibJe/SsHnfXYm6DRJi78jvLAc8WD
 zlqnxiWYS9oGThjKWS/C3hC2eXHEYzr+vUmNbdrcOsZtYnQnedlaxwsJLFPvkGByk9PlskClblM
 C/gYLKuyUu2RfWvXhVRuLLWNcIaBfTcTgBhelgA/s0bGYD+PqgIlBnTBvlrYOTG+QB+irA95nNA
 IZI8OZLFifj5V0CjttUfe8yHYRgMYE6L5x3xY9rpEM2yuI108GL8KuOTZ4JNYoWoiOkEaUF32Uh
 uYLvckPxRnhSMQxpMPA==
X-Authority-Analysis: v=2.4 cv=HZeB3SE8 c=1 sm=1 tr=0 ts=6aaa7a4c cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8
 a=meB-weNJVlBEWY6-UGIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: UEgLJ4mL8Ps1KGHQJ4OfuaIA85g2i9gd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160148

After synchronizing the channel mode configuration, wait for the longest
settling period required by the active profiles. Derive the delay from
the selected output data rate and the datasheet filter-settling limits.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 drivers/iio/adc/ad7768.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7768.c b/drivers/iio/adc/ad7768.c
index b2e129e6fa33..bd0f5cdac187 100644
--- a/drivers/iio/adc/ad7768.c
+++ b/drivers/iio/adc/ad7768.c
@@ -103,6 +103,8 @@
 #define AD7768_MAX_FREQ_PER_MODE			6
 #define AD7768_MAX_CHANNEL				8
 #define AD7768_NUM_CHANNEL_MODES			2
+#define AD7768_WIDEBAND_SETTLING_SAMPLES		68
+#define AD7768_SINC5_SETTLING_SAMPLES			7
 
 enum ad7768_filter_type {
 	AD7768_FILTER_TYPE_WIDEBAND,
@@ -621,6 +623,33 @@ static int ad7768_find_matching_mode(const bool *mode_used,
 	return -EINVAL;
 }
 
+static void ad7768_filter_wait(const unsigned int *mode_freq,
+			       const enum ad7768_filter_type *mode_filter,
+			       const bool *mode_used)
+{
+	unsigned int t_settle_us = 0;
+
+	for (unsigned int mode = 0; mode < AD7768_NUM_CHANNEL_MODES; mode++) {
+		unsigned int t_mode_us;
+		u8 settling_samples;
+
+		if (!mode_used[mode] || !mode_freq[mode])
+			continue;
+
+		if (mode_filter[mode] == AD7768_FILTER_TYPE_SINC5)
+			settling_samples = AD7768_SINC5_SETTLING_SAMPLES;
+		else
+			settling_samples = AD7768_WIDEBAND_SETTLING_SAMPLES;
+
+		t_mode_us = DIV_ROUND_UP(settling_samples * USEC_PER_SEC,
+					 mode_freq[mode]);
+		t_settle_us = max(t_settle_us, t_mode_us);
+	}
+
+	if (t_settle_us)
+		fsleep(t_settle_us);
+}
+
 static int ad7768_apply_channel_modes(struct iio_dev *indio_dev,
 				      const unsigned long *scan_mask)
 {
@@ -698,7 +727,14 @@ static int ad7768_apply_channel_modes(struct iio_dev *indio_dev,
 	if (ret)
 		return ret;
 
-	return ad7768_sync(st);
+	ret = ad7768_sync(st);
+	if (ret)
+		return ret;
+
+	/* Apply a filter settling time (datasheet Tables 28 and 29). */
+	ad7768_filter_wait(mode_freq, mode_filter, mode_used);
+
+	return 0;
 }
 
 static int ad7768_update_scan_mode(struct iio_dev *indio_dev,

-- 
2.43.0

