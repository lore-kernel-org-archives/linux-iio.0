Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB18B4C4F5A;
	Tue, 15 Sep 2026 19:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789499585; cv=none; b=q6CRPce8W5tVRcFfATSEbtDUA/q4+6DjkyuVn990SFhwUphah3vI5YMvVz5wqIvuqs204adyLb92LkuVlaG4Gzylh/DJQCh9HGhvtr9VWKws+Z7+BhKmEfB7uO8W8rDxqNW5jUDXqMp5LbuC5e7UL7L/OEEZoN4fsjGkmesPX/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789499585; c=relaxed/simple;
	bh=YUMjH46B3smHRwp1F3iG862Wi03pyIiTF0rT9rOH2lo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C7RLPQLfPXI9g8tbtcDfb/jBp2WsVZeV+kizgBjbPRzO+b59obB14kBc08WUa8Eo52cDNoRAbYECnRJv9w1UXwXbgOQ2pguUYvj6WK9jpFbYTjqIxLeDk95Fj/jfCvBaTXSSoLBaJPzMCZwK3sKz0tC7i+1XFT6Esr4qRZDUDN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=csT7qq6H; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="csT7qq6H"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FIscBD1755371;
	Tue, 15 Sep 2026 15:12:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=VnM5v
	w6fajEToz5A5WGN8opfS/bSKtjNOjVG4zjGWUI=; b=csT7qq6H2kidt+aJP58k7
	C3BwzIyZgIMr0KlccODWbYttRSuV0VeftAwGwFwT9ZqwDTR6IsG1osDUU5eS4qFD
	mXaWuVRyIznrDW13HI1g5+1INTaCLQZBY7D0fMyN8oj03NLr1mJ09QwOBa23/Qk9
	BRk9mjbdtrjfqwEJ7Bjgx6g/WB8iB3DNX4iu0b2pdptQXh7+V9tBzKJfTDJzx6WD
	8sgrCPH6RNZxRQYcnCZIX2J6eYJ38BzPbk+poNycgmj9n4bkT6Omw+MXFYxIwH/P
	M3RhqCs5GlS8j3gy90CQtqiunD8fiWpKoTdGvSWKF71YadSv2BaB7N6/EqP5qim1
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gq43rjq0p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2026 15:12:58 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 68FJCvWL018978
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 15 Sep 2026 15:12:57 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 15 Sep
 2026 15:12:57 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 15 Sep 2026 15:12:57 -0400
Received: from work.maxim-ic.internal ([10.66.6.190])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68FJChii028126;
	Tue, 15 Sep 2026 15:12:46 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 03/15] iio: adc: ad4134: Drop import to empty name space
Date: Tue, 15 Sep 2026 16:12:38 -0300
Message-ID: <8e4ab2b09873f171767da897e02dd60c56f0a0c5.1789494473.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1789494473.git.marcelo.schmitt@analog.com>
References: <cover.1789494473.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: z3xKxkSrm_36BxFMKeGpfFzyq5zErwvl
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDI4MCBTYWx0ZWRfX5PSPtVQ7jRZI
 YGUb9DwRymzyqlPCRGWy5kF9Qye9iWbnqHoAYO2AqiQYBXV2yRRChNJ38MopbDa8b22+7Q05i6n
 6CA2Xe+cQhVziSZSngl440byn0vPOXraQ5dmo83zZAwxZUK4JhNR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDI4MCBTYWx0ZWRfX4A9j4dR1uBFc
 RkN9EiYMj23/dbwugqsw1Igr9xh+tgJ70qoEafY3FUdav1QJPG1SJWWCAiZ5s0wpY8kf86UawII
 wbiYh5bTZnvsc4JOBQiY1q77nE5sJs1wTniSYOqYy0VgnCaZEZeE7pcP3GZHXH+tmktK23XR/63
 vqIhlwOAfXO1KIjVeh8i5oYDmEzZcRA8ITa9U8gQxc3Q/ZpV5TeILSy7Er8qEO6rIY1W/I6rRDb
 GPwNuPv4lgY9pNCg66KpMSKOckW16zpPH5pVn1Ibrp0b1AzXhjLeUwcNTUnbR+VxVODMI+VvU5L
 wAi5aRCHg3JGcha4O3dRFoTGgBmHrEems016gAstIb3dt97DvLbirDpeo2+JUy9gN+vvi3e7UwD
 7R5PoRV2vK4CS6t6FIjHe0/LTBG/U26G8YqNy95p1kCmu7forthEcoGBV55rWx5X/nxMVTsdUrD
 rzHxWUi+D+uTuOzlMig==
X-Authority-Analysis: v=2.4 cv=HZeB3SE8 c=1 sm=1 tr=0 ts=6aa998ba cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8 a=CrC_sYL25YjGbbXwo-gA:9
X-Proofpoint-GUID: z3xKxkSrm_36BxFMKeGpfFzyq5zErwvl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150280

Drop unused name space that somehow remained being included by the device
driver.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
No changes since v1.

 drivers/iio/adc/ad4134.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/adc/ad4134.c b/drivers/iio/adc/ad4134.c
index 7d40c0521bb3..3c759b89d331 100644
--- a/drivers/iio/adc/ad4134.c
+++ b/drivers/iio/adc/ad4134.c
@@ -498,4 +498,3 @@ module_spi_driver(ad4134_driver);
 MODULE_AUTHOR("Marcelo Schmitt <marcelo.schmitt@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD4134 SPI driver");
 MODULE_LICENSE("GPL");
-MODULE_IMPORT_NS("IIO_AD4134");
-- 
2.53.0

