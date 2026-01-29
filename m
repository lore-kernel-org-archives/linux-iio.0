Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C729B34B682;
	Thu, 29 Jan 2026 17:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769707498; cv=none; b=VbCBOLiRd3tfycYuIQxpD7oQHa32GyKK53RXHVibzVPKgm2oj4gprntZWsFA92ZuKL3xwT/xibl2LY5zUzNlxqZr1Li5A8lea8bysa0ZjeIR0nx+91x7MZ4alGcy5DWdCLBWE+AGuflK0AXo+4XZVEYYT2inj4yQNUWlPENWRFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769707498; c=relaxed/simple;
	bh=8AvKQDtUhMJogjK5FLXA/AeAGGPP9e/z81HNtAtcg5g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hjrrfWGj0EHUPlLfD6Rh1WHCwQ1Oej8cs8RewDXqNGfQqzezL6vlNk84GccT3Hkizrrz5VMf5buY31E2TK5BmXjuzqSAAaSoYqeJinnAi1lALVnkQHL4XjKs1nj/ZGwrRCKHu9NKn+7LxUeP8arXuu8BFTaRcMkoXY8BRJp3WTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=bflCTOjA; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="bflCTOjA"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60TEwoJH3441966;
	Thu, 29 Jan 2026 12:24:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=xNnlA
	s0e/IuwJWXrwIYP2bEwwHrD9F7AusWM/z29Ek4=; b=bflCTOjAMbPVw5LaGoL96
	fgWLDEIHR3IBy7/QhlPBDbVOus5nNgECAwcDT2tQS4GarAdot/tVie9I2aDFDrH9
	SRUgKzgwT1ltFRXuojAYwYZVqLqEsH+K6dAOehnns9rht77hxP/RCQfHAi6N09iy
	BY1imRECByJpWKJQm7npg4Fz/TT0le7Kgy0g04I63XeckGqOu8JzNaAO7AUX0VMG
	CqGe+12EIlq/0dfDxiVsK/0/08cjDjHVKezfxMNxembkAjYK6XklR2gfsxUcHdDS
	3Y1YY2a9o4ZK3SzqGMhbfd1Bg7N4upHYd6+80Fdgv0iZLpatd7vaozqmQURJX+TE
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4byfcdpnk5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Jan 2026 12:24:37 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 60THOaAJ055929
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 29 Jan 2026 12:24:36 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 29 Jan
 2026 12:24:36 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 29 Jan 2026 12:24:36 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 60THO5rn008516;
	Thu, 29 Jan 2026 12:24:29 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan
 Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>, Fabio Estevam <festevam@denx.de>,
        Matti Vaittinen
	<mazziesaccount@gmail.com>,
        Chen-Yu Tsai <wens@kernel.org>,
        Linus Walleij
	<linus.walleij@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] iio: adc: ad7768-1: remove unused mclk_div field
Date: Thu, 29 Jan 2026 19:21:59 +0200
Message-ID: <20260129172340.34216-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129172340.34216-1-antoniu.miclaus@analog.com>
References: <20260129172340.34216-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDEyMiBTYWx0ZWRfXzWL/genrWbmG
 /Vgf37BfG3W8FclU5cKdixw9+93HelRYWjgcbihR/MXNfY06mRDo5CsOqhFeb7ZYnA2sNcCRM0i
 rQW9rWdYi37iDcVIFmQ59NCg+fXmlrIefDmdID4HwU0d7UAFKynO+O85lVZ5q0nUAn5linhzIAG
 z4lersy80r/SIfno2zVbSf7fa5XPH0+Mpik97bwp0afPH25Wo8qtyU/M9pEWcPdm4qTmnUxYuJW
 EQjE9/dy44O1+23xTb5d9f3kcWrxT6714ovZHB3ZK/X1slyDJbUCpZlvvThqZ5b3QMqUuT9zFaW
 FCquLdXp0cqY+30Q5Cd7l/I9VwNL0z2Zg20pSKyoySoplHk4XbShLAzwxygrEDxkuO9NFBBVFxT
 OhJNX2R63SemB3Pt0/BDXASBDDc+2ivwLOnCeEPWFcoPqhp0bx0LS9bvBtVCho8BgflQ1RLKPxU
 JxqbLM5zIRMuUrFYE8g==
X-Authority-Analysis: v=2.4 cv=TqDrRTXh c=1 sm=1 tr=0 ts=697b97d5 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=LbWV5dLEJMo44prF9IAA:9
X-Proofpoint-ORIG-GUID: txyndOPjMvcPCr4N8kiGPbAG8_QKMOcr
X-Proofpoint-GUID: txyndOPjMvcPCr4N8kiGPbAG8_QKMOcr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 phishscore=0 clxscore=1015 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601290122

Remove unused mclk_div field from ad7768_state struct.
The field is declared but never accessed in the driver.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/adc/ad7768-1.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 980c079ab41a..c461f65f0198 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -290,7 +290,6 @@ struct ad7768_state {
 	unsigned int vcm_output_sel;
 	struct clk *mclk;
 	unsigned int mclk_freq;
-	unsigned int mclk_div;
 	unsigned int oversampling_ratio;
 	enum ad7768_filter_type filter_type;
 	unsigned int samp_freq;
-- 
2.43.0

