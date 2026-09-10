Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3164656B861;
	Thu, 10 Sep 2026 17:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789061890; cv=none; b=bh9CL0Q6k2Ohx0PRxl4PT413nIqof16JRikRoIH6pLk0TOmuVyNvLE/0wAHNaPa3TDEGijYp0PN6RToi7ZcsrmBSMmgkfeHNgSuovkBF4k6WYzprfR/wdSACwBvO4ulp3hVBnWHPH2bLvv4ejf7vYed1UZHEci5XOJzG0wY0tVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789061890; c=relaxed/simple;
	bh=h5qK61XToBChPWnzc7k/ar18hPjhP95D8yaf0+jW2JA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=pt0VixQ2LwjEGLyNVAXxbujAQd3FR1qAKzoi1GYnFVdUxCOJJk0socCrphtHvmfDQ9PVftPvPYzYZxk89JLDlcC/ddwIednBrArvVMDEhTBVEKpRYCvQEhjv+0J4lt4Lj9jrlERuXQrXvd3v+vVMShb8HzvavFL18xVUm9LoCBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=TIn4b0zF; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="TIn4b0zF"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68AF7OqX343068;
	Thu, 10 Sep 2026 13:37:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=pLWvQ
	Ak76s98XK2T2f2SnvdcbszkyvSZsmmNdB1tBWQ=; b=TIn4b0zF+4yXws69FURYu
	RhYg+uoW94nRlBj76EwSMqeW0WtABd/0dil6q8A61+tuh04/pag3YPCYllZ5ZaiD
	xOZ6GYFfzp4cPJcqCxjO/YibaqVpCGGykmuTRNHWTeJuoaZIPDHK+u3x8B7jsfP7
	SFySHD4ZvsLyWiHjioPnLP34xtmLji0THbRBAZHN9WuGHenGNvwzxbkqaZF+mSbk
	vKgnnXL38Vcbb1oauQN2T9Id4EZQSm9/9iTZRChdBROJIgebN+k+y6aU5eLiBdgH
	T67MBnawYphZWTg4FfyvlSdNRyjbHr9uZC8lKII/9gfdHPaz0wBMUIOnqS+nEu0K
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gkcx95228-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Sep 2026 13:37:41 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 68AHbe1v038841
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 10 Sep 2026 13:37:40 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 10 Sep
 2026 13:37:40 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 10 Sep 2026 13:37:40 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.225.204])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68AHaSSi018832;
	Thu, 10 Sep 2026 13:37:32 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Thu, 10 Sep 2026 19:36:30 +0200
Subject: [PATCH v7 12/17] iio: adc: ad7768: Wait for digital filters to
 settle
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260910-ad7768-driver-v7-12-7f70b07627e1@analog.com>
References: <20260910-ad7768-driver-v7-0-7f70b07627e1@analog.com>
In-Reply-To: <20260910-ad7768-driver-v7-0-7f70b07627e1@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789061788; l=2279;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=h5qK61XToBChPWnzc7k/ar18hPjhP95D8yaf0+jW2JA=;
 b=nbddVFKru94WNsbNNAOhJP+yM1tYs0iP8oA4GIiP8wYfOdnD5io06ZCGvuJ4/7xLzgI8NfX5g
 81R3ww7I3EjByCMLm95k1NNvU9HKhsjw3gho9/gFVsDyn/tJAcZE0Ej
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDIxNSBTYWx0ZWRfX0CXQQt2w+J/7
 zog3A6uzNFSqr1zmwDXi1HOOoQVj4u1eR6UYq+f3Lq364g6+cu0PP7nUgstsaFiH6+876j5HOK0
 hcYyaJK4MkPM7eQbY498coxyIf09qUG4vDbfdrBTWECy5fmC7ISO
X-Proofpoint-GUID: Qmcafwb--QaZIPEnp6vjG2-EEgSUMWU-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDIxNSBTYWx0ZWRfXwXf2afOlOmp1
 Sx504g9RSxuattI9W2NsyiUPL0SE7vqnDr6B8MjOyhIBhe7X5tHTLGyqGR2xnzVIYfO3aPEJs4n
 zhyjj/hg7/n/VKOpzjvWAUXfPn0tQNQicdQ3W+zTiwBtKJvB4RxCjP0fm3nNhSeBD1NOpNsPNNE
 qLnMuejZcny40ag9OCcGiXPV2817Q/Itbgw63/V6HKVyILd85A+ItcY5PeuVhwti29FGIHmxWdC
 GqR/Pa6I6drsWOrDH3W12e7/HaBYE1TsPqO7EMpeyKT3DO9ZoZaGA2Guwe+HG2wCt1sStuZFAHk
 GRXbSix3dCXPUIY6SpK4dHaiF30f4nLNc3mxSlBc/C8P2bCBz492gI0Dx0Ytbyz6D3dTOhRG26K
 45ruqG8VOp+wuPOOVmtSlGN7vC+3G2oOU/MYI7XbjqcocsP98mT1v/P2Tp/ZhvpmV5zMJcXZ82j
 Hdy/ZmGNFVySqvvur1w==
X-Authority-Analysis: v=2.4 cv=G8CJgNk5 c=1 sm=1 tr=0 ts=6aa2eae5 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8
 a=meB-weNJVlBEWY6-UGIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Qmcafwb--QaZIPEnp6vjG2-EEgSUMWU-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_05,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100215

After synchronizing the channel mode configuration, wait for the longest
settling period required by the active profiles. Derive the delay from
the selected output data rate and the datasheet filter-settling limits.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 drivers/iio/adc/ad7768.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7768.c b/drivers/iio/adc/ad7768.c
index 2ff8a8569c0e..5d576fffad80 100644
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
@@ -608,6 +610,33 @@ static int ad7768_find_matching_mode(const bool *mode_used,
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
@@ -691,7 +720,14 @@ static int ad7768_apply_channel_modes(struct iio_dev *indio_dev,
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

