Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9645136C5B2;
	Fri, 28 Aug 2026 15:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787931111; cv=none; b=td5Pj4u3reg1EoNFiQyAJmJryzdx/YRkKBa6pliMyTQLl1CIDRY8KVApr1kPNtFIEFJq7CjJHG8r/ZRe5XvcmuQPm/jf8EXNTUMk6W21oCayA8FYCZIWX8bWqg2KP70oIqrMoAH1DrAbW6aq7CsJzDTFcGb0yzxZUfMt7fAxDxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787931111; c=relaxed/simple;
	bh=blDN0LtmU7sRseC2tf3ct4y+Hqf1xBLyjypT/+RWM+c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=IXAfTUvFl/IACt8RFVeXCs7TLYHQTXH17CuDmJZLw7Xr8rTtRLnZ7gqTC5gxvgpG3w6/kNLi+7L3gi7vwXW+7BASKfwTj96SgXT9BRNoTUsmBcJJgGHOVuQuQUYIwtO2gD4s/T4I+/ojEyes4EJyapQxNq7scirgK7BUF04od9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=m6OrkGK1; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="m6OrkGK1"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SDWT2U1593725;
	Fri, 28 Aug 2026 11:31:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=edw50
	3BXTsE1bxevpgO7Ps7YX2BcspAP8C9/SOetlOE=; b=m6OrkGK1LVuKXqHu4Awcs
	vwIqXKOKwOqdz9t0DVbA+UB4KhNr2pnJUpV/fJreStt3IzuiarukOj3QFsLGLRIS
	axDkbQXL8sI1UcomyPXjj7RXdkGI4aIwqUCCRibr17q0QzKyMuFsFO5iGM3aQ4H7
	oDTi0ABvLb4IT89anJ/XGM9sXkFbVdjVSiKLCB3LeJHgg3LOzq6lGQYq0U38pjNw
	5fbcqT1WsDUfexpAFASy1jf/+ug2Cg4LWmkzLPMvBqclePsPXDdLXRrrqi5KMR1l
	hk0Q94bQOnHPrGXJtNxvJeuDz+38kNh8Uj0RBoBX4SA2prtPPsMVjDt1kLYsCjiP
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gbaebgvht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 11:31:39 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67SFVcYV013156
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 28 Aug 2026 11:31:38 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 28 Aug
 2026 11:31:37 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 28 Aug 2026 11:31:37 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.223.174])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67SFUY3r031424;
	Fri, 28 Aug 2026 11:31:30 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Fri, 28 Aug 2026 17:30:35 +0200
Subject: [PATCH v5 12/20] iio: adc: ad7768: Wait for digital filters to
 settle
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260828-ad7768-driver-v5-12-e33ca6f841a2@analog.com>
References: <20260828-ad7768-driver-v5-0-e33ca6f841a2@analog.com>
In-Reply-To: <20260828-ad7768-driver-v5-0-e33ca6f841a2@analog.com>
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
        Michael Walle <mwalle@kernel.org>
CC: <linux@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <jananisunil.dev@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
	<u.kleine-koenig@baylibre.com>,
        Janani Sunil <janani.sunil@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787931034; l=2289;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=blDN0LtmU7sRseC2tf3ct4y+Hqf1xBLyjypT/+RWM+c=;
 b=mhEmAAqUhWqoS57+9TnsJZh6D1w0gc7tcUKO5xfgXfDvNM7vYV7GmUWSz7+JBeC+7RIM7tCjM
 sC2me1KG1iVBU4Wk2lg3CTKh7MSo6EZAT4ejetvoQyAwinbtvOaZ29n
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDEzNSBTYWx0ZWRfX8dw/LLjorut/
 FIK89OSbox3AxrdJ2WL5DfCRFnE0vz5GhX1tc6RgEXQOe15YcP/Wf2gkzFiYk+SuLZecxeCVDHN
 ODyhIOUZ7Qjb7Tn5wlwKGboj5Fc3/1jdWVk7/vEtEETBXnsFdHwP
X-Proofpoint-ORIG-GUID: Fxq8JZB0bm9bHSPoVBdgMKY5_UXxPFnS
X-Proofpoint-GUID: Fxq8JZB0bm9bHSPoVBdgMKY5_UXxPFnS
X-Authority-Analysis: v=2.4 cv=WMtPmHsR c=1 sm=1 tr=0 ts=6a91a9db cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8
 a=meB-weNJVlBEWY6-UGIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDEzNSBTYWx0ZWRfX0/uZch3AmZhD
 afZouh7JFJ1mcWkbXBkyQ9XZtrvSl3H8Y3amBzyvgWAdDGI1SHK8sDOR90UHI2mK0DVrj1xdTB2
 kRASIiIK+CK5LI0AE5bcKYWv74exvmKXm4tscRRHiREwt0i/eTAko/j5ozVvX7+egFYi2QHC/Yb
 tjIVfDGq+F81prY0cN/lY+hWiz4lrjpfR7z+Mz9EERHr+BAH6nDDG4NUcYw073MuFbgBXed1jPn
 d/VCq9GRnfkwZPTKAg4JOXg/lcF+N5rvyJ1cn+hk5lGU2/rekxdXYGXUajClwLjMZfhDICphuYT
 6QCTXHgFBdV+WsGn+ra2n599Wwx9RQ70Pk47tVGoVy/uwT03ei8/2tQSjs7wUxrlH4ZAjbv+YZT
 WP08N5iNojywjFN5p8y5yMPc1hCcy0VInkVWSeu2bYbTnmXg2r/pT3xdYNKAXSJZIRMK8GUtWuN
 uYkuEgtMydqwWEmQ+lQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 clxscore=1015 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280135

After synchronizing the channel mode configuration, wait for the longest
settling period required by the active profiles. Derive the delay from
the selected output data rate and the datasheet filter-settling limits.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 drivers/iio/adc/ad7768.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7768.c b/drivers/iio/adc/ad7768.c
index 4c67f692861e..84b96b1fab09 100644
--- a/drivers/iio/adc/ad7768.c
+++ b/drivers/iio/adc/ad7768.c
@@ -112,6 +112,8 @@
 #define AD7768_MAX_FREQ_PER_MODE			6
 #define AD7768_MAX_CHANNEL				8
 #define AD7768_NUM_CHANNEL_MODES			2
+#define AD7768_WIDEBAND_SETTLING_SAMPLES		68
+#define AD7768_SINC5_SETTLING_SAMPLES			7
 
 enum ad7768_filter_type {
 	AD7768_FILTER_TYPE_WIDEBAND,
@@ -592,6 +594,33 @@ static int ad7768_find_matching_mode(const bool *mode_used,
 	return -EINVAL;
 }
 
+static void ad7768_filter_wait(const unsigned int *mode_freq,
+			       const enum ad7768_filter_type *mode_filter,
+			       const bool *mode_used)
+{
+	unsigned int t_settle_us = 0;
+
+	for (unsigned int mode = 0; mode < AD7768_NUM_CHANNEL_MODES; mode++) {
+		unsigned int settling_samples;
+		unsigned int t_mode_us;
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
@@ -674,7 +703,14 @@ static int ad7768_apply_channel_modes(struct iio_dev *indio_dev,
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

