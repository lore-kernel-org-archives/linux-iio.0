Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1BC37DEB2;
	Wed,  1 Apr 2026 15:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775057524; cv=none; b=rXN9DqkSyVLlkv7CQs33uOErXFWRu0/5Iw2tvCapk9No/7rD2bfVQmUl5QGWURjJD7Zgh83j30FfD0NBmrmiNI9rin2ayGBSW7u0QkJ5IVzCrV8NAWjKd8R0930K9BihR0D2OEBqY4H3TpcGsZtM46/lV/sno6eKNxaARlPS63c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775057524; c=relaxed/simple;
	bh=429p/PvZ4/KTADk9f1TF5m7aMFnGM3maWkf7foASWUY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g6DJrGfOtqXQ3raDQhNrEwh/ACunBK6RZw+7TYkUuNS8awLyfo+MkgUyhPppbCupD1WrvSy2otjq9wmmzGm8lOmHu9aShw9wrdqBp0R1+Sq1P+y5J5aysMcNip95EUEX2ymD6F+euOEaLC4BKMHnP/RYH8mvWhH0BeCvjYw8biI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=wVRw00jX; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="wVRw00jX"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631DuU1p2772139;
	Wed, 1 Apr 2026 11:31:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=mnls9mZ+LR40N7DY2gn+EQesj1S
	LaGAq2AxkTJMjp1A=; b=wVRw00jXVcjYPZmLNVKqYck4q/yhSuH+ZjraqgIYuxc
	BhR7dP6RxAT+3Ppyc+V2BWuD2l/xHIu7C+c5gBW82qQwMW2y/882Z/lcWkCfZV1T
	ixCwh/A0JqJWGP2tAfhXPQWYAYnxTWEBybAnGYYi6ZsY6esM1ntOrHhLDb/bi5c3
	3kLXTRRDceWvJhjiRoeQQdHDFQjxmANhIs7IkCzfKm7ltMb3JC19vJxf9r3qmeqf
	lT0FzuGjYEUmHuNEJlCkN0hg1ANJCTJpNKkXpbl98T7PBSoJFd4EGfRyH/TCZsa3
	XL3NzsU1v8+xIOFaWj9VgfBCSawJqGfcVxCZ3fkaAIg==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4d90rjhdgw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 11:31:42 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 631FVfvt037275
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 1 Apr 2026 11:31:41 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 1 Apr 2026 11:31:41 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 1 Apr 2026 11:31:41 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 1 Apr 2026 11:31:41 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.240])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 631FVRq9006730;
	Wed, 1 Apr 2026 11:31:29 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru-Catalin Ionita <alexandru-catalin.ionita@nxp.com>,
        "Radu Pirea (NXP
 OSS)" <radu-nicolae.pirea@oss.nxp.com>,
        Daniel Lezcano
	<daniel.lezcano@linaro.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH] iio: adc: nxp-sar-adc: fix division by zero in write_raw
Date: Wed, 1 Apr 2026 18:29:24 +0300
Message-ID: <20260401152924.58073-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=SuadKfO0 c=1 sm=1 tr=0 ts=69cd3a5e cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=tMf5uOp-Ww8D4Z-4FK0A:9
X-Proofpoint-GUID: nHyvf4E44vmWjAdpEYH1PtQ5Kykj6n-o
X-Proofpoint-ORIG-GUID: nHyvf4E44vmWjAdpEYH1PtQ5Kykj6n-o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDE0NSBTYWx0ZWRfX370SFU2aqQhO
 I69/uFfuk2Y8hLquEJI/wfyYvy/mmYgmHktHjgGWc/qyy0HJPn6K72UuvTgJDzc8lvk4BY40Wnv
 ro8AP9/CRFDlpHwOTFSpq2w+Hr161/3shsXLoAnHZlqtl+6Q5Enqac4Q3V4/+HZRqNwKlZg/ahq
 Vi4VNl2UlRk6S+sIdHulgg8WbQvYPYm7Uq2aSXkgQNDFEhFr/xTxto7Oqcy8LAxuLUhdQGWzJ6y
 tw3wSfzkO8ouBp4w3yi2iab+5nmh21lsghtX55eGDZywJLT+0wqvAF2z5SCKkO8k9jn59Imwksr
 BikWbpba+nTy37znjHap4/VwomzPJ0qKh5D9aVAZp1acEpLlHuQe6PrpXeaIE9C9g8gAnYVvq9W
 cvL5+7wKpVNYibp+JsywlvqdyVgJHmU8bywmGizQCGJQeSoGbISyP4vFcA8gAx/Fc+yD6r7CIjd
 hgaSuu5fLkRjbbVQ4SQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 adultscore=0 malwarescore=0 clxscore=1011 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010145

Add a validation check for the sampling frequency value before using it
as a divisor. A user writing zero or a negative value to the
sampling_frequency sysfs attribute triggers a division by zero in the
kernel.

Also prevent unsigned integer underflow when the computed cycle count is
smaller than NXP_SAR_ADC_CONV_TIME, which would wrap the u32 inpsamp to
a huge value.

Fixes: fdee77dea4b6 ("iio: adc: Add the NXP SAR ADC support for the s32g2/3 platforms")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/adc/nxp-sar-adc.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/nxp-sar-adc.c b/drivers/iio/adc/nxp-sar-adc.c
index a6e4888a8464..c611f1c612e6 100644
--- a/drivers/iio/adc/nxp-sar-adc.c
+++ b/drivers/iio/adc/nxp-sar-adc.c
@@ -560,6 +560,9 @@ static int nxp_sar_adc_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (val <= 0)
+			return -EINVAL;
+
 		/*
 		 * Configures the sample period duration in terms of the SAR
 		 * controller clock. The minimum acceptable value is 8.
@@ -568,7 +571,11 @@ static int nxp_sar_adc_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec
 		 * sampling timing which gives us the number of cycles expected.
 		 * The value is 8-bit wide, consequently the max value is 0xFF.
 		 */
-		inpsamp = clk_get_rate(info->clk) / val - NXP_SAR_ADC_CONV_TIME;
+		inpsamp = clk_get_rate(info->clk) / val;
+		if (inpsamp < NXP_SAR_ADC_CONV_TIME)
+			return -EINVAL;
+
+		inpsamp -= NXP_SAR_ADC_CONV_TIME;
 		nxp_sar_adc_conversion_timing_set(info, inpsamp);
 		return 0;
 
-- 
2.43.0

