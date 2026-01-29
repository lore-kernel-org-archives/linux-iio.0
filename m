Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C96238C36;
	Thu, 29 Jan 2026 15:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769698997; cv=none; b=mwwa+OoMe/6unNNZD7bKSerwuD5W+MOL4LFMhn1mhEI8s1/OoyNKm0WAjUdmY5JQ9VsnUGXocs9CX1tSmIdvD6RliaW60DkF+m29babO0vahoxtUdwHvaUVInhuC8npQDlKtURRKupPMFwVWjJYDoce/WxK53DgctWC5rHbe/KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769698997; c=relaxed/simple;
	bh=TUP6WXD5BJDYAYYkOa1ZKs7dZl1YGwLzONbYsOot4IY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Im/rTsfk6mBnsRgBE0LPU3knj5A8+cSBagG1uoXw1xvnA57mZAc4lESvma2pO2Wh4NETIZNxlGHGr4mY/SrlZW8Jv3WL0EBO0T94AKgx/6pn/KKLbd2DTeGAuM0H4SvNqbCH8BW+kW0LIE8i+Z/iwgLOjXrnYRPYgpzC3bVsHRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=hA1ITTRC; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="hA1ITTRC"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60TC4ZH03783266;
	Thu, 29 Jan 2026 10:02:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=aPRk9
	Kb2wkFaP3NMN/T9jZBs9aIupZO9Emm9Jdeg7Yw=; b=hA1ITTRCaA3t1LsfzPjPL
	yOS947bVwDmvi8nr/5VM8442vKDVRe88p2tBA6mNLTKs14dnBAQK1mQyYYJbqGma
	/hBrVThGpLxK71wZUeTCt8RISv4VZiXzXZDqylwqk/QimEtXKtJUR8J8BmuesOgr
	WFVpA0H2vJbwFJXmEb7Sugfe7OXq+SHzbJOhXAWqe/qRFcOKuZEOJsentebD8cAg
	sjBnW0X1G+73Rwvg91HK9HQaur+unu1BcoulYfbgmKgojeMnvkTGO3FG3L8uUgWg
	KsH9618yrUFcjPlo+FMnOkDW4KMJAtzgCdO7FwGMBu2hobz6FfACQ4CgYJMi+ttu
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4c011bj04m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Jan 2026 10:02:54 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 60TF2r72039068
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 29 Jan 2026 10:02:53 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 29 Jan
 2026 10:02:52 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 29 Jan 2026 10:02:52 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 60TF2aeQ001997;
	Thu, 29 Jan 2026 10:02:48 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Petre Rodan <petre.rodan@subdimension.ro>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Manuel Stahl
	<manuel.stahl@iis.fraunhofer.de>,
        Lars-Peter Clausen <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] iio: pressure: hsc030pa: Fix i2c_transfer return value check
Date: Thu, 29 Jan 2026 17:01:46 +0200
Message-ID: <20260129150151.127713-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129150151.127713-1-antoniu.miclaus@analog.com>
References: <20260129150151.127713-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=PvmergM3 c=1 sm=1 tr=0 ts=697b769e cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=U5OZ4VVk8pM9WLIraqYA:9
X-Proofpoint-GUID: 9ermlBTHuZI7vAidLmwbN4RmZvvPnETc
X-Proofpoint-ORIG-GUID: 9ermlBTHuZI7vAidLmwbN4RmZvvPnETc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDEwMyBTYWx0ZWRfX2CLVb1MruBe/
 YWsoVqaohILCPlyaQSxVPGnUMINmfirPO/SkexqEcIisFFt4LfM6KbbQ0nh2qMAfxOQQIcn3qPg
 I7KmoDLY/vBeZmsnSOv4PwJ1uW0uJQW7lVsOfQnMHMfWR9e16HCQdYahvhCUWhkUSPp++pX39wh
 NLid2eZU3X3Ubii9G39Bg5P9cI5vOIhXafhPgWhqUB7R1ABp1RKQ1W93uAhxmwiYrCIlF1qVv5V
 WAPFZ0LdlnAZstI0+p1ME+R3rL2sEBf5tCJszDCzhWaWHOb6x05WacCvjUTrF/bBiww73ayzvJT
 lWFUWVgkmLLHsaJcbh49Ma0i8IAVhcvR0R479zvCZ1wtJNbSJ25M27UkiTps1uFRbbuG1FZR05t
 znfnhQo/bQQmx0dL2n83o3vvrJQDTMIO6OrenEFK9pqpUeZJco8X2f6Um9v7j/ufTTBPIXL/IRW
 7CW84IQvSfyu90DqXDQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 clxscore=1011 suspectscore=0
 malwarescore=0 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601290103

The i2c_transfer() function returns the number of messages
successfully transferred. The function sends 1 message but checks
for ret == 2, which can never be true. This causes the function to
always return an error (1) instead of success (0).

Fix the check to compare against the actual number of messages sent.

Fixes: 6362d96585e3 ("iio: pressure: driver for Honeywell HSC/SSC series")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/pressure/hsc030pa_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/hsc030pa_i2c.c b/drivers/iio/pressure/hsc030pa_i2c.c
index a34ef4653f34..e780732c7b75 100644
--- a/drivers/iio/pressure/hsc030pa_i2c.c
+++ b/drivers/iio/pressure/hsc030pa_i2c.c
@@ -35,7 +35,7 @@ static int hsc_i2c_recv(struct hsc_data *data)
 
 	ret = i2c_transfer(client->adapter, &msg, 1);
 
-	return (ret == 2) ? 0 : ret;
+	return (ret == 1) ? 0 : ret;
 }
 
 static int hsc_i2c_probe(struct i2c_client *client)
-- 
2.43.0

