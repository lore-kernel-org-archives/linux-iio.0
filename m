Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4764AC151;
	Wed,  2 Sep 2026 17:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788369744; cv=none; b=NfhEYDr/gh1DAYdeeulEIa4rRWAn3KnX7FoMEfYcpujn9wXdTxkQF/L3qBGSDb5zZ8GycJyLKebwVA6AVyaDoufKNueNYIofr68pIobcrzLe+yxJYCknrgW0vDavB7P7NYZ67P5HlDXxGTY58LFs9PB4Rc69gFGdhkRWCs/Rork=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788369744; c=relaxed/simple;
	bh=4VxTjdwnn8MYzhpPUyV48oMSiut/e4cOIWqVuT5ZjqM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yw/ccQcwiXWbBInqE4zdqW0UJiA2IwBUYPePMEtqVXuJOaWFxnfOrDXuKg96/BFIqkVm+acpOe1+7/5ECqLLIY2P7DuvpCy072anxVmUP65usfBASgw21NDlUJ4apoDT1KdjnhZx3eZeJy2hDCMG5pafZ6OXNfLpsPK6gVpZ4Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=eq0FNCpi; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="eq0FNCpi"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682HDOsS2569989;
	Wed, 2 Sep 2026 13:22:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=gkv7f
	Do73bRbApVIu/rtbJTE86ypr+31Yx4iYgzKnII=; b=eq0FNCpi0nX+kdELTI0Lb
	MhnQ6A/x3Zq14tWsjuAzU8nUm+dJpG7qL4xkJz3qF95uzI1RDzkn7HYlbQKocT0p
	AALoNY9syIVAvL4fP8+i1pQkG1t1XCrxXcnbHqEazGmcqF+SjxjZ00K+1BAEK6QL
	LM1FPGj2iAUCRA2gJROWmTgmE9cDGN+8TK8IMBn/gCPo/jM9xIUJXGtD4gI1w0gv
	KjxkIb3wjEEDNJVYz2rbKgLMRpAfVE5ZqIR0n3DVA8RVJs3htzgr6P+BUuNwyFK5
	eIkRtQcXuhdRyxYOMp3TNKE8pyf1SM1rd2SsfO61Cuxe9pX95U1ixrgdqdlPt+mD
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4ge3v1n7th-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 13:22:17 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 682HMF8Y041197
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 2 Sep 2026 13:22:15 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 2 Sep
 2026 13:22:15 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 2 Sep 2026 13:22:15 -0400
Received: from work.maxim-ic.internal ([10.66.6.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 682HM2ex004210;
	Wed, 2 Sep 2026 13:22:04 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v1 02/13] iio: adc: ad4134: Drop import to empty name space
Date: Wed, 2 Sep 2026 14:21:56 -0300
Message-ID: <cece23bddac7f2b529a895c68415a5b67b3e4e0d.1788368334.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1788368334.git.marcelo.schmitt@analog.com>
References: <cover.1788368334.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=bql8wkai c=1 sm=1 tr=0 ts=6a985b49 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=CrC_sYL25YjGbbXwo-gA:9
X-Proofpoint-GUID: Ip4gc_iDOYbWx2BHqR4RVgYVZsg3fshH
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE1MyBTYWx0ZWRfX3Zst4opPbe/Z
 7ohcQ7AHsKz/rV2ggdO2HRu+887Gq7R+pllJDPKgY6j86XKsLiP7Lovu46Ph36ev+NAnYSNI/Ze
 qSCPW/VmQzAjJcRQEXVNhTdE5eoP1vXwacLMg2wEnbJ5mn3/HciA
X-Proofpoint-ORIG-GUID: Ip4gc_iDOYbWx2BHqR4RVgYVZsg3fshH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE1MyBTYWx0ZWRfX3WEqrOOeDQNJ
 ePhYm9BbY4dsv7qVR5nk8jL3/u2mrQaKOd+c6NlesMWO5WsbbATBZiCjsDrZYFETEFfy3iS+GcP
 q+2CTFl/jWZxl1iGmU8SXzWUYGgRqkyO/UFwR19w1gfwA5lyL8prKX7J6CaiVx88swa7ezDOl+f
 pwPYE2xaaV+Qb3N9A/+W8QfYVynjF74dS3Erp3SRA0Pvp8LrXxlAalh8ILJYyhfEXlWU8fh7rL3
 rwJzjEd1At/ANb9loCaDy71qY9tft6M2WAazCcIBs/ez5t8wHv771QRobodQjpQQx/LRykbFdIo
 5a/XVF8kQevwVfLmDB5a/sK4VA3E+GRpT3fVs7ZzC1UDzlmyXgBAtZtAFedXKAIQ7kKdf8WkF6y
 PajszarDIt0ffNAUwoNfV/CxgoG4tTppAYNv5i3KencmjUt/vnp2I2Mn6OCWBt3B056WtVV7ShS
 t+w0ch77Nm9A+4YCmfA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_04,2026-09-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 adultscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020153

Drop unused name space that somehow remained being included by the device
driver.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 drivers/iio/adc/ad4134.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/adc/ad4134.c b/drivers/iio/adc/ad4134.c
index 0490218bb0e9..70f80bf1825f 100644
--- a/drivers/iio/adc/ad4134.c
+++ b/drivers/iio/adc/ad4134.c
@@ -496,4 +496,3 @@ module_spi_driver(ad4134_driver);
 MODULE_AUTHOR("Marcelo Schmitt <marcelo.schmitt@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD4134 SPI driver");
 MODULE_LICENSE("GPL");
-MODULE_IMPORT_NS("IIO_AD4134");
-- 
2.53.0

