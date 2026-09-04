Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826594CB8C4;
	Fri,  4 Sep 2026 14:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788531389; cv=none; b=j+7HC+H0QBYrsqbnY7lGHYp1KsCb5E1VfbJlXQZBFYkwMV9g94/aj9kmj2lBpiOujXA1IZQs0YhHjkBQxFy1ztNyPbzr92Y7MH3oAYANWTDbLLu5udXH5o1yET0FYS/v3uD5MeBaS5LEeIl3B1dUj3fJJZgK6x6s3gLoZfSD/1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788531389; c=relaxed/simple;
	bh=Gng0O6YkiF01/cFtKdvl8bmy4Zs56iHjUpnoGLkDNIE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=usZfMVMbN5lmHCxe/lO7zy4oPijmzf9ey+dGSwSI5QizroSGGxC4ocaXTPdrvzAMB3tBt0I7CtHVjnoxUYJoirHseu7s4faiXNy5X6D/flOAOWKP8d9bG4zSxsDieIBlC74FgKn+UHt4hff1SlqqImz04MtyYo5gvsDd1axuiOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=IvGn+qni; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="IvGn+qni"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684Dg7UA4068323;
	Fri, 4 Sep 2026 10:16:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=lhnmy
	CXfNwIOvQRuBD4vDTjGWOLquvD1bp04yyC/5g0=; b=IvGn+qnixTt37LghZYdp6
	7pbflnova191uVa8UWJq0qqVrXz1+jsny3Ti11tzGmcM/29ffEq77k8akAHfXqmR
	wy0QoWqiE8vCHGQP0ysxNmVjVkVFx2808kon3CxdQRacWf/ndDZC4uqvQ36kgQ15
	0dxRW5/iiMwp/kHXhArB+IcOhPiqKujw9QiW6QdKI6Lb8xJ9Qb1qH5OCutGu4G0A
	YpRlYOITRL8U8UhQRmyvz/K+UE1+ICFstOvp36HPQGGSBeivZhZbIklB7s3gSR7J
	snuBlYJpcXFn3YLYGxnTBQhBvJrKBL3V24Fp+bC4IRAGJZtu7I8zYx4fONEZ6ccd
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gfxaw0d53-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 10:16:11 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 684EGANB036356
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 4 Sep 2026 10:16:10 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 4 Sep
 2026 10:16:09 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 4 Sep 2026 10:16:09 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.225.204])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 684EF2dG026210;
	Fri, 4 Sep 2026 10:15:59 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Fri, 4 Sep 2026 16:15:04 +0200
Subject: [PATCH v6 12/17] iio: adc: ad7768: Wait for digital filters to
 settle
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260904-ad7768-driver-v6-12-e4378f946bfb@analog.com>
References: <20260904-ad7768-driver-v6-0-e4378f946bfb@analog.com>
In-Reply-To: <20260904-ad7768-driver-v6-0-e4378f946bfb@analog.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788531302; l=2279;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=Gng0O6YkiF01/cFtKdvl8bmy4Zs56iHjUpnoGLkDNIE=;
 b=XyTFPtdbbreROD9BWuJjl1Y1yORZ1cCPVpji3QyBY9e2KlCvFoaZysrFQId+xnPM+fhHtdV9Q
 LR2JE/UPtQSBIVQVX66FfdS53yG+xOmKin6RBp02ajnMSAWl1UTYa38
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=UNnt2ify c=1 sm=1 tr=0 ts=6a9ad2ab cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8
 a=meB-weNJVlBEWY6-UGIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDEzMCBTYWx0ZWRfXxtLMpDy92hgR
 3a4oS7/7tWuls/GBnJb/3mO2+rRPy8Sl7+z3xuw9A69qzoXZ9VhYsGRQbrCCI9sA3abo9Go+6qB
 +9+H3T2r7N4MPIhAVexR9qbyGwKeyICeRLN6kfrBPEhJtjC4g29s
X-Proofpoint-GUID: oiWAlIpKkZe6ukJ-QjDCk8FSuYg94x-9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDEzMCBTYWx0ZWRfX6czVk1JYW+ya
 HUeU4I2uyATJ1yNsfd8V8r5O3u6HVxoWiu9MRMACSNdjdaK4nkuAz4MCHcoX/uBfN6TSWNy7WX6
 egUUhsj4h83ChDmFIZbVarZQvFMQsum5lykJUCvXnoDQhG/wIj1F9AB7a1LdwyYSLI7Q7psa/+u
 1mJ8gMwA2+ulTMX030dEuWhc+hhqMyg/2Qy4Dhzl5gAW5nwxFa78H7bAmEGB0pIvOkyuuJpJ07C
 Cz9sqtbRxCbdW5MrOE900yuUGM5NE2pQtfuBlZZgs2fdzBgDja79H/flsO6kq4xUeIqm/oh63b/
 GJwExc+xuJfpmEHGqBMXsTZZjy1FOdzePfQ3OpTQyEnMKVICEd0Y9+C03EMh7Hf9c60OFDdHsBq
 rtzyGyeK17TndGoBUNk3gmxNLeC4mK9rBI3eCsNpv/xE5m7U4TELoLHCjoOi9RB6YWT/UMP1Cb7
 9M0miRGIN4VJpcOKxoA==
X-Proofpoint-ORIG-GUID: oiWAlIpKkZe6ukJ-QjDCk8FSuYg94x-9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 spamscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040130

After synchronizing the channel mode configuration, wait for the longest
settling period required by the active profiles. Derive the delay from
the selected output data rate and the datasheet filter-settling limits.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 drivers/iio/adc/ad7768.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7768.c b/drivers/iio/adc/ad7768.c
index ac236e5c74c7..f2c762688fb3 100644
--- a/drivers/iio/adc/ad7768.c
+++ b/drivers/iio/adc/ad7768.c
@@ -107,6 +107,8 @@
 #define AD7768_MAX_FREQ_PER_MODE			6
 #define AD7768_MAX_CHANNEL				8
 #define AD7768_NUM_CHANNEL_MODES			2
+#define AD7768_WIDEBAND_SETTLING_SAMPLES		68
+#define AD7768_SINC5_SETTLING_SAMPLES			7
 
 enum ad7768_filter_type {
 	AD7768_FILTER_TYPE_WIDEBAND,
@@ -596,6 +598,33 @@ static int ad7768_find_matching_mode(const bool *mode_used,
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
@@ -679,7 +708,14 @@ static int ad7768_apply_channel_modes(struct iio_dev *indio_dev,
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

