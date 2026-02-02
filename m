Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D90311979;
	Mon,  2 Feb 2026 11:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770031769; cv=none; b=g/k5QR72ORLcAWgTG70kuXfIB4e7NLwzGUljmgRSM5MyII52HWylJaecFxoesbPS9AnpxnotyW8ix/1D9BxwNybwVSEz3TPihQYu7vOUF96NZs7J5/LWmoV+pHluaANp9oYITMlMl2z+p0GooIC9MhMglPkf25CMgkVktZ0pfqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770031769; c=relaxed/simple;
	bh=oZeEyFOorPZEIQ9PtbLcSEQ9DPtm4MD/XTyDnx/T9Mg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AGiGKhSXPyBrFQqAjizMWli77c/iNLxQPQQj4E/7zl6suDUYWn6NLmgdZFrEcuteoJV0LnJok+LhLchOGlbBo/7nsDstSgUqwbLj4811OBGvwfWaxgJjMkGxxXFy7ZZkRUFrq6av62k1ghJhhUJZgTz5Q4rBHxnS7oq8t0n1PiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=bLlzaA3a; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="bLlzaA3a"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 612979R6348279;
	Mon, 2 Feb 2026 06:29:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=k/Qs+
	UqIPSGJxMqGTCl7Os2FI+zXhd7ucL0NdEcr3aU=; b=bLlzaA3atljcHmRp63c7B
	SS0TyNvNLyIVy7vDALb6yA2iyhuxdp9mHs7r2s3oqklmf7c0c8Z8Qz/wxHvcsOQZ
	CjSGdt1gHsPPRMneV25L30m86QLRcmpHtoe6xtWHMbb4QFrETJOp6OnrNEVm54eH
	f5StAKFpFsTkE+0Vp8jzqaz2t0svMv4inj0m59cuZKFJeqwSC6ohmAfaw6dZ9vuW
	X9jZ2f5452cWFJmZ7dFU2g+FoFieNKYbP/YAiivt5miMjzBQUGsYqZKdIW4A4i2h
	ePrQBXT2l/sfcXdZ7SiHk7C9F4mRoQy5vNwejxOXN2MWzzim0vxWNSC25g1Uowgu
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4c2b8wtp64-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Feb 2026 06:29:03 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 612BT2SC050092
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 2 Feb 2026 06:29:02 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 2 Feb 2026 06:29:02 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 2 Feb 2026 06:29:01 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 2 Feb 2026 06:29:01 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 612BSK4A004681;
	Mon, 2 Feb 2026 06:28:54 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Subhajit Ghosh
	<subhajit.ghosh@tweaklogic.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Fabio Estevam <festevam@denx.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chen-Yu Tsai <wens@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Eugene Zaikonnikov <ez@norphonic.com>,
        Marcelo Schmitt
	<marcelo.schmitt1@gmail.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 02/13] iio: adc: ad7768-1: remove unused mclk_div field
Date: Mon, 2 Feb 2026 13:25:52 +0200
Message-ID: <fd3be0b6a47de7a4003c3dd266b251201bb134e6.1770030812.git.antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1770030812.git.antoniu.miclaus@analog.com>
References: <cover.1770030812.git.antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDA5MCBTYWx0ZWRfX+Bkh6yN/uDH1
 7f4GVGQK024zrKbTLczi0NAvbjVz+bJjiIWeteXbrNdSMhLEIKlCmNCm7HXehV9Pkvsv3G7b//e
 G3JC/ZJrNO8ZQLNL5TIXPR84Xr1ztWoncvQXLJGxwgdX6uHv/8HMvtPsM2xMjbrTQeMip50ft3t
 LaiTVacCUjpTAlyd2I/MT15iL18QE/GfqlHURAV5MSVGyCrPxSFkg3VtKYp1QW4TKlbGKjLYRCQ
 hfaPwhQZlqlEO6ThCuiPCMc3iCDTxDVeAbk8kItvE8hslX3cvua5APqJIR4w4lT7yT721Cd9YiO
 aBve2NW3jHiW+KbiIRd8V99rekV/G5Wr7PMDdg5LmwAQsEvMGaRzLsnyvsvEcaW1A3bokci0X9s
 k9RdfZPDkqL2L+6Tsk6tdtn4yMeU44dpnu1O6/alIdOU0GPiOF0h+k4lYOrQ165jDvlBGpr+5XR
 zI+gx6fa5WSxyy9/tog==
X-Proofpoint-ORIG-GUID: FgAGNoZIDHhbw2rUCVL8P8mDgKkD5XQu
X-Authority-Analysis: v=2.4 cv=SK5PlevH c=1 sm=1 tr=0 ts=69808a7f cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=LbWV5dLEJMo44prF9IAA:9
X-Proofpoint-GUID: FgAGNoZIDHhbw2rUCVL8P8mDgKkD5XQu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_03,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0
 adultscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602020090

Remove unused mclk_div field from ad7768_state struct.
The field is declared but never accessed in the driver.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/adc/ad7768-1.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index fcd8aea7152e..5a0863cf22e9 100644
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

