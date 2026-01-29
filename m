Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A74C3491C2;
	Thu, 29 Jan 2026 17:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769707521; cv=none; b=JWq6/RWrQeB79cRQFGjb0eOIuHbaE6bex217CCy3W6aLRmaMoSiHAqOjGsG60fhPOdq6TqiUjC953Gc03FQfvJN3+3Ozr+Yn5aRBLpwOj90VDDMxc9mnomi0iRnOgEMqf6ZMZvAIrFqAvfjZpFNQnY62TCwTtZl0JId4Zs7A5Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769707521; c=relaxed/simple;
	bh=e32mG9lTNVxxP64B9Z6kQO1yjl+PTuE5GZsYTWijVJs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SUllWgiqVCcYbyA0oxHgqjnAqRpugzB/5Skdffawm8fi3JSRV51Dl2q2qoPjf0NCUeFfW7OvzzgGnPpSXNvwlvYYEyNrdoO44wXGG8gCp13Ym7yvpszj7anYf7rCNgY7KAaSE9MxoVdjJsSQOETzRW+EoBCH5mwlWBWTSKlLM9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=JhI84i0H; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="JhI84i0H"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60TG0XNc3441837;
	Thu, 29 Jan 2026 12:25:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Or1f6
	yVUEqvUPvzmjcHCisz5+ifJVO/+m3OG0IuAJOw=; b=JhI84i0H9RPFYeJa3V2h4
	wtWGkMf/h2+GA4OP2bwx3adoBigPRUliRDGpGUb26i1gTx4He2yag8l+N4cG13Ig
	lMwkk1PV/xHrbSEM19afuR1aRIWOlTr0hUVqmiyF3V3nYD7zfzLvg6GBmxgd1m6d
	TC0f+OnH3oAgrFU84KaIYfMXSbemXtIL3uMBdIS9zCmMGUu6mK2Y0o4bI5n+xqoF
	/kREjdL6F4Z3T48ln+nFVeOnZdmazNRf7CDRTfGhiGXnq4ON2YgHI1TFOL1vUuLT
	uOA6dMSZpPKVLBfGbFa8puSTbqBGIaK33qCbjrwhMoznjLv3xDEKKHDTYzTpJMi6
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4byfcdpnm6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Jan 2026 12:24:59 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 60THOwEq055953
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 29 Jan 2026 12:24:58 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 29 Jan
 2026 12:24:58 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 29 Jan 2026 12:24:58 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 60THO5rp008516;
	Thu, 29 Jan 2026 12:24:52 -0500
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
	<andy@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Fabio Estevam
	<festevam@denx.de>, Chen-Yu Tsai <wens@kernel.org>,
        Sakari Ailus
	<sakari.ailus@linux.intel.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] iio: adc: ad9467: remove unused output_mode field
Date: Thu, 29 Jan 2026 19:22:01 +0200
Message-ID: <20260129172340.34216-4-antoniu.miclaus@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDEyMiBTYWx0ZWRfX6uKYKU5BRJL8
 qX9NZNN3CiJQzgXIImRr2CpdlruXkYlVsny/ZDxrNyvIgTJse1MeFnjKVM25Zmd3QDd1Fe5ZMQU
 IWTGGa+9fQbKfszrt6AoBWE8o6tjYPXBww2HlcIPOkg3iPJ9KRbplImfBQ1/rhqGm5IDexF96hg
 KAQssSsZtfNX1crkZL816547YnK7pKv8NILnre2Duw2C0ikdOOk0Wua6jvaJnkzSqyJlgYRhQSV
 DEbLV0V89VKt+sHlPMwLInmUOK1eS4Onc8IAyWDpvBK6pcdWKrxE5nrL5UkbtF3nuDHHEhNGtI8
 4krn2RWdTzsRYeRVO5JBYjtRPea6/0mK/R5rxx1iHW8TYcpz7L1FC0g5Yce3BUqtn8UUxzq4PrW
 GoHU4Gtdath9DaxB0bXWlwk1iU85QFMWNcSoJh+2Slpr0RS7KY3+9nB8K/rfNw2ZPH/vcWYHPds
 juL2A17cqBTpVdPUgFA==
X-Authority-Analysis: v=2.4 cv=TqDrRTXh c=1 sm=1 tr=0 ts=697b97eb cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=LbWV5dLEJMo44prF9IAA:9
X-Proofpoint-ORIG-GUID: GV6o98Bsf4crdV6qTz3EuDjhT2AcgXbC
X-Proofpoint-GUID: GV6o98Bsf4crdV6qTz3EuDjhT2AcgXbC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 phishscore=0 clxscore=1015 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601290122

Remove unused output_mode field from ad9467_state struct.
The field is declared but never accessed in the driver.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/adc/ad9467.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index 9cfe66425d4e..df0c05e7c60f 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -176,7 +176,6 @@ struct ad9467_state {
 	struct clk *clk;
 	/* used for debugfs */
 	struct ad9467_chan_test_mode *chan_test;
-	unsigned int output_mode;
 	unsigned int (*scales)[2];
 	/*
 	 * Times 2 because we may also invert the signal polarity and run the
-- 
2.43.0

