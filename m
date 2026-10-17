Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FAB39060A;
	Sat, 17 Oct 2026 01:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792202258; cv=none; b=NpgA0GaiInXgDwPKyl229y2AEgQXZasautgQK3ORER9MAOiQNUmIgIrfC0VfGiYYFhFPnBP+h+KxsLA157I48TZ7rP6C3z8eCJFjAZIL33bkJsmKKrVmQRqv6pDiqjWmYwmdD5dbXjK6uCecfh/PVP7UQxdxgVZHNQY1s4RSc/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792202258; c=relaxed/simple;
	bh=axIcYyhXsEKFmVsvQ5xKKo3b5dvkoKvEaDdxkdl2Mrw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mnmIvAR3y/RggU+XmC2gd1zourrJfHDef7vMmb05GrS0KQTHVAtg0Y80W2XUhYMO2dyBTY4J4RYb+K+FTO+eyyzHXLGs4W+qcs4XNPUj+51Z8GcfN4HKSPW2x4JqU5siyLBem1ovjyCslQjBZVqIF0UbuwTh3hCqiPo9A1Awcto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=WA0UOb+i; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=e93Ax/vq; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="WA0UOb+i";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="e93Ax/vq"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69GNHSN62680408;
	Fri, 16 Oct 2026 21:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=XLx9DHqGbBlJ1EASIywLAvHKwpYV9beFPCzIq2RmVMo=; b=WA0UOb+
	iSeJCksWC66xcshB3hxddcdA4Io0HdtOD8FaemKBE73gOtufgjrl8sBFV/yGXhkb
	RnW8b73Ha4f9o47Iw5QyMZjkTEdLzCxsc8sTa+u6RzPqJgNLnuq8w6hVWb6bTZ9p
	vgB0AOAwzw5xx3jazR0mSIsX6+rjuNTT1pBaw1424X2ImwEs8lZtG829H0ib5uPN
	QSy6BPCJ6o7rYljFFqUVXZf6E75I/cX66ccBPWjthM4axODB7CZQ+CPdVRyXeu2Q
	eKpR0Ped7cyDttnXEN1amzJ9yVoUqtAKedXMm9wkWBexs3KTksPYsGhXw0RkUyWg
	L3Po+6eZFHUA+zw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=XLx9D
	HqGbBlJ1EASIywLAvHKwpYV9beFPCzIq2RmVMo=; b=e93Ax/vqSLhj2fA/kTLOw
	OokBzdJA2EC7r/9Y+M8LAfWdmoM6w/5YBfwKfQgWPMeFZccSABQkWbt3CG63SNJk
	iWvKcjbqpi6loCOlTHRNovJiwHts+AGcWziBpvV0EBjpMUaroUZirOjc5L4oGQex
	Fr7yHxT+nkzEQO0/mwPbG34eFYXb8VVu0Pd6No9MPjovffuPWm7Vr78eyhfKGi7I
	GKskHbgG5dDPTD/6VddDgb70+6CY0fXHxMjvjzaAn6Y5uJQ8JBfjI7GPL+V8zNp3
	OxfyidTZPrNIZiENHmmHrevWG37L/JhZ6sU8sv5Q+pNqdWRhvzAdFMCBgF5qx+uG
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hbmr4ua50-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Oct 2026 21:57:30 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 69H1vTC3061521
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 16 Oct 2026 21:57:29 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 16 Oct 2026 21:57:29 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 16 Oct 2026 21:57:29 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 16 Oct 2026 21:57:29 -0400
Received: from work.maxim-ic.internal ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69H1vFYk004305;
	Fri, 16 Oct 2026 21:57:18 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v5 03/15] iio: adc: ad4134: Apply reset recovery wait time
Date: Fri, 16 Oct 2026 22:57:08 -0300
Message-ID: <9f6d78d607b2f9a896513535fefa3329d52c4464.1792200021.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1792200021.git.marcelo.schmitt@analog.com>
References: <cover.1792200021.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDAwNyBTYWx0ZWRfXz+p34AdoaXEA
 Ut79519UEOClaiLRzB/xw4q8VjYTlu/bx8pt2wyN0a2arrjJxinsGF2hyaJTnYRUnIZelsvGoDp
 0Pdr4XHPTmdel5uaTQogOJ3rArBsmtVr7s7/GP+T+4ab/2qm6hNOjrOrj7kFBU93Hpe+z2B/nYi
 Xu3tBEPjnyxobVKsp1hne19/rCo0EGPR4TqMKkvlnQPgAozmHXsJvTuXNHyTMOYvOTk2MmLM436
 FK42uaAemKnHky+8aAdKwt4rG1AuWMVF+sT8BWI5zBJY7UlNTmjQmjCQc1Yp8hYEbJiIWDSGPjC
 sGy6+K2VdbT0wW4OuB0EMCCttVCPXc17wiWTbhyAA8kYy25T9uR6OvZtivuEL7tL9yNs9xggR9b
 MNiKN2P6TtSWCNiYGMYPfPC8U07IfA3p9hlTJprr9XXEgebkd8x9ZVPLNhnnG+aVNIaBEHWdN8t
 NIuQv/GFyUy16eppnPg==
X-Authority-Analysis: v=2.4 cv=TqtzFzXh c=1 sm=1 tr=0 ts=6ad2d60a cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=lSUnOnxGDAvAs_IYlHQA:9
 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: zoiziy3tVuoy9BDpj9ufn4DbH6fxoAHx
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDAwNyBTYWx0ZWRfXwcgilmPcqg1T
 cO7KdYVd5swylKTz58QZOn6I/a5zLRMHBKFqxe2gd18RYeKbb18/SQbUNEXDCNPEV4cDH99R44f
 zs5+XoItdxXDbMXSwWiHhw2tjZ8rJaqwPdpYy+LIyXeu2Oda83Z8
X-Proofpoint-GUID: zoiziy3tVuoy9BDpj9ufn4DbH6fxoAHx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_04,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610170007

Add a reset recovery wait time to avoid any SPI transfer from running too
soon during device probe.

Fixes: e0bc6d7e2584 ("iio: adc: Initial support for AD4134")
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
New patch in v5.

 drivers/iio/adc/ad4134.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/ad4134.c b/drivers/iio/adc/ad4134.c
index 40b27b01f126..d555874b4959 100644
--- a/drivers/iio/adc/ad4134.c
+++ b/drivers/iio/adc/ad4134.c
@@ -442,6 +442,7 @@ static int ad4134_probe(struct spi_device *spi)
 		return dev_err_probe(dev, PTR_ERR(rst),
 				     "failed to get and deassert reset\n");
 
+	fsleep(AD4134_RESET_TIME_US);
 	crc8_populate_msb(ad4134_spi_crc_table, AD4134_SPI_CRC_POLYNOM);
 
 	st->regmap = devm_regmap_init(dev, NULL, st, &ad4134_regmap_config);
-- 
2.53.0

