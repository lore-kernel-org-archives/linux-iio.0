Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E7A301493;
	Wed,  1 Apr 2026 11:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775044735; cv=none; b=K9G4Ai29D7f0dTaQCvqnsP0WWtyxWXgg7p543tcmIOB94YyKz6ik+bspdVwm8h+I8DP2XWkOUfzOEZk91zyAT0QtiFhEjP4+VNIELrZTrB+1a/aYS3ZINpevEh86P1M2W3JksQuTevqc+ECMR719z0a7brazTmtQc/YOmIbEqGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775044735; c=relaxed/simple;
	bh=0XrT1b9habRQ2N1EPtvIQnYARYV3LkqnuhipQFyG1Yw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FIZEemZJMvoIFNBydsXD8xZerkEBxPvN3wR3ECLvWhJnCxUyvTYHdlZ50n9r1MV6MuVGC8LY3Wo1Qf38RLBbv+2kRUzzVZMfr7Tjp59ZAAQbqyc4wca8lw1SARK3tS/pAA5hVwNqxbefhappH6H2bW8Fu4B9OCPIW2f5f9MDpxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=DmXXJXYp; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="DmXXJXYp"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6319RZep1912836;
	Wed, 1 Apr 2026 07:58:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=8V81S
	nlJUWn03Wi9LGiWS3P+Ggs0o4Rmzahkz3UIabs=; b=DmXXJXYp3RpnNXv9TwMgO
	rSMQizj4UMcabIjAIJ4ETlDeHOOSO02HtB/4ixrJ8wHSMbr3fEc0CLvF3J0rs6Ky
	b8IKZI76ZzRCl/cAcnSt5jrA+doPS5Eneb6MNAz6Qfgn8Yt0bCVKkLmy087q7JNu
	/j7B13j8tvKCO+BZjMxyVd23v6DgRgLVWIWs5zd48LlK8lWzkFQzPwYk/NAkdMwk
	CFDlwHWzfr8wVN9Swuhi7lr4eR5R/GhrFq/vjOigAhheX0rLtBF+V2n1Lmv3R6Im
	bCKKK7rwyFWmX1AbBhoY5SVqVEmypasQH0+QYuKIl0nRm8chHNVdLstPtAIA474a
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4d90re8gyx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 07:58:39 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 631BwcFS005243
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 1 Apr 2026 07:58:38 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 1 Apr 2026 07:58:38 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 1 Apr 2026 07:58:38 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 1 Apr 2026 07:58:38 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 631BwMlt011480;
	Wed, 1 Apr 2026 07:58:25 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        Andy Shevchenko
	<andriy.shevchenko@intel.com>
Subject: [PATCH v3 3/5] iio: adc: ad4130: Add SPI device ID table
Date: Wed, 1 Apr 2026 08:58:22 -0300
Message-ID: <e840b555c7d9fa0e7ae67663dd8e03e2c996e329.1774996100.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1774996100.git.Jonathan.Santos@analog.com>
References: <cover.1774996100.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=VqQuwu2n c=1 sm=1 tr=0 ts=69cd086f cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=QyXUC8HyAAAA:8 a=gAnH3GRIAAAA:8
 a=ijA5dNRdcb88KqkhJh4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDExMCBTYWx0ZWRfX7XYy3q+W4hJJ
 tNqmOcoM5w9NXJ+LvInWVtLzM+xphkzmXFKeUo6pqMsfbeTU4YXF8zB4ZJ299KHokvco5H9ppbU
 YBNaPj5jgEeYlCza0gd7E48307XL4vQyyOPnwUgrP5OHYpJy5F+JzrBDfCC8o1LuMG0LVecXBf5
 X3UT06oPZo09Jvyb/2cJ+wDXH1JToT55JykRLvdSX4uqtUOEqjQDzvUKtRAX9d9mdGjve1QA1lb
 D7xa6jg30uAk3X4CYPRBrvNBHmK4yKVFhwb8iX3SU38x51DrmCLJ7vB6loqPc6Tv3r0P0cVD1cZ
 kxVFFLaZxTcFPZvJV+n/5EETQ2l0Q+2Orpv7g7hdnU4n0/GbBSAgqySOCC4JUMcG6t4BTA3l8QV
 GuXwBvg6WqySf8Qf5cR1xLCmS+2iKO6T69HWRiwJunoxsC9B7sdTJ94VnGfgHptieqZCnwSL9H/
 lnBS2xffZJDCdDx68Qw==
X-Proofpoint-GUID: JflbSGemF37IRuJD4jSAO_9w-0-mXrwf
X-Proofpoint-ORIG-GUID: JflbSGemF37IRuJD4jSAO_9w-0-mXrwf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_03,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010110

Add SPI device ID table to enable non-device tree based device binding.
The id_table provides a fallback matching mechanism when of_match_table
cannot be used, which is required for proper SPI driver registration.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
Changes in v3:
* Removed ', 0' in the ad4130_id_table.

Changes in v2:
* New patch.
---
 drivers/iio/adc/ad4130.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/adc/ad4130.c b/drivers/iio/adc/ad4130.c
index 5567ae5dee88..d7aaf57ab87a 100644
--- a/drivers/iio/adc/ad4130.c
+++ b/drivers/iio/adc/ad4130.c
@@ -2109,12 +2109,19 @@ static const struct of_device_id ad4130_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, ad4130_of_match);
 
+static const struct spi_device_id ad4130_id_table[] = {
+	{ "ad4130" },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, ad4130_id_table);
+
 static struct spi_driver ad4130_driver = {
 	.driver = {
 		.name = AD4130_NAME,
 		.of_match_table = ad4130_of_match,
 	},
 	.probe = ad4130_probe,
+	.id_table = ad4130_id_table,
 };
 module_spi_driver(ad4130_driver);
 
-- 
2.34.1

