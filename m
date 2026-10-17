Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA9F3822A6;
	Sat, 17 Oct 2026 01:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792202315; cv=none; b=IxnF6ZCtJwkBv5zVKLMg2nkGVBIqiecWyIerJjDbdH6+lVRtS4FBAimOSslQDF4ih3m3eOXcox/1NAy67/4jlk2HeRyETwEAg+y2QGPWp343guWaDfT+4+nkLgz4XuhBbigb2m4X16R8oD2olziFLxPu7zYFQvrXL+kKke6LN38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792202315; c=relaxed/simple;
	bh=foWlk2RpKGEk1AeYzoZS8gOa+6QFR8eVin0WRuycu0w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YBLEu3k6HYzuCv25XxnhAB1yQX9o+HPWz5lY2no+3pzoJNmZ/4GfCUC94+9cdWI3Qr2oiyWW2wIWdxSplIYLFCY+BiMsCgWZetgoaDKI4+53Vc1BRv3sOqFcs5sFyYWjiLyfQvC0z39PceOc3OYV2R+Q4k+TmmX1sIHeUHDg1yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=WtOLMqXl; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=xSi1R00i; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="WtOLMqXl";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="xSi1R00i"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69GNH3FE3829652;
	Fri, 16 Oct 2026 21:58:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=+iOf1KTOSIaM51yb3Q8ZqpjlIm+fQnFhjK2XE4q0LGI=; b=WtOLMqX
	lqsSjm0/nDdssYqHDQsgEJbfKiIz0+LWFGt0kXQAUxz8g2ZhprkN/u3i6nlTu5bK
	0+LNC7m868ww+TsGPOH/jHr/Vb99IvCIg0DZ0ZydUCJljs9sL7QTnqA6tn6AUUbu
	dkE/bA+JVN0eSJP9tglHFU3jvDYw5t//Jq/jHOmgNMwRXOdEbp4dz00GTBM6Njvu
	U5MN3IsXHMxvVM85OM51GKaxKEWpoMGg8XUSmztMTffRoONO6sz501TmVZ8DBiBa
	pftjv61reolDSQIspG144nwkJoRjRn5IgOsIKts5DpHuBxgH/DKON30OyuGzQsTq
	/2EtByh1SA5TO1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=+iOf1
	KTOSIaM51yb3Q8ZqpjlIm+fQnFhjK2XE4q0LGI=; b=xSi1R00i3uUgka2lnBMbV
	DQRHmhfpJ88hEDkMvj3HyiAGOCf8/SgXGmVUXLGEfL3mY7nCULKcU72j4Df6P+y/
	91b9rGD7vedaqFVMBqcqRtZsQggeguhU3S80vKk26Sxiye2nTo5pmDaahwUvyu3V
	q0BOs/anHdR8ImUnMMbMHxspvEHlkC1UntPdcucDa0y1rnCWKzIn1yCfirMhzYuP
	lIaheu3yk6qf8UKHleeyjzm76q2ccWP8z2JqGpR9rWLwFWkeFa+0tVcbYkW8y9Kf
	9zRUGE01wVpjOAL8N6S+qz5kL8hJ2LgUkNAbVylMnXmL6fMzEfYt25czPQLDpQhl
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hbj1748rd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Oct 2026 21:58:29 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 69H1wSo8061704
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 16 Oct 2026 21:58:28 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 16 Oct
 2026 21:58:28 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 16 Oct 2026 21:58:28 -0400
Received: from work.maxim-ic.internal ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69H1wChm004323;
	Fri, 16 Oct 2026 21:58:15 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v5 06/15] iio: adc: ad4134: Protect conventional device access from debug accesses
Date: Fri, 16 Oct 2026 22:58:05 -0300
Message-ID: <b05978468abb537f7fe5b1d0ed2753df9a69decb.1792200021.git.marcelo.schmitt@analog.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDAwNyBTYWx0ZWRfX7bY2s9VBb/Nn
 t1iiGQAUf5eOEzu2QF97I748txtuvzQZKF8HThJCu3BhDrAQ83mH2HNIYpmK0duCk5L5qI9SF2o
 BIvYeDP+ZONusYmnHOke7ePX9CfAxY/T7B8QLSvYw7AgCNjvtkC7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDAwNyBTYWx0ZWRfXwTMeFDTr1WCL
 zY4tKRhLzrAi4CrYZPbgqH3qid9VkU48yNwkt18dsOhBdoPkxO0NMvMmNsHUhdPguB4Aj37IuNx
 xVkDLwRbYjYUNzMY14CJpkrDxomvTPYTQQ+UePBbXGJe96worbMJd4DB+ZfjGM75LltFrscONeT
 UkcK2imYBI9tmj/1r1NvLk5X9BVXU9KK6N1wqHn1I+Czl6J8iPsKTXXLHEPcn8rZ0fWbj8YnIRM
 K4UhN//Wj24h1L2O+SOP41TR67hUXd3wTZS+DYhlew1en/plLrV6wt37eKfSiPSYbnLYvwdUd/n
 YZ2J/yR445bYDA0BA8CM8H0443MzfqBNadLAd+2rQ3QZDy6LNX8BLcxjlnK5Hpin8tj0OWs1FiY
 glk8Sc/KGgij+Qf55Mc6tSZgjVAbgY64CuN8PHTXRnfhXsc+cXf3fRIWVzYQpF8wRm+XD/Zm2Ro
 MVexFKHx5g5jSNMsuZA==
X-Authority-Analysis: v=2.4 cv=Wd6Z+EhX c=1 sm=1 tr=0 ts=6ad2d645 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=pgku8suc4UhcSmyt7kEA:9
X-Proofpoint-ORIG-GUID: OGgAMCWH9bt_6ELk97afJHus8j3uci9D
X-Proofpoint-GUID: OGgAMCWH9bt_6ELk97afJHus8j3uci9D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_04,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610170007

Require debug access to acquire device synchronization locks before
allowing any transfer from the debug interface so to avoid disrupting
operations issued from usual (non-debug) interfaces.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
New patch in v5.

I'm not sure about this one and have no strong opinion about it.
Providing it according to suggestion from Nuno.
https://lore.kernel.org/linux-iio/179199692826.658576.4841754843069240356.b4-review@b4/
From previous discussions I guess this patch might not be welcome.
https://lore.kernel.org/linux-iio/20250421142359.11fb483f@jic23-huawei/
In that case, completely fine with it being dropped.

 drivers/iio/adc/ad4134.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/adc/ad4134.c b/drivers/iio/adc/ad4134.c
index dc4d801490db..42a1272c2894 100644
--- a/drivers/iio/adc/ad4134.c
+++ b/drivers/iio/adc/ad4134.c
@@ -302,6 +302,12 @@ static int ad4134_debugfs_reg_access(struct iio_dev *indio_dev,
 {
 	struct ad4134_state *st = iio_priv(indio_dev);
 
+	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+	if (IIO_DEV_ACQUIRE_FAILED(claim))
+		return -EBUSY;
+
+	guard(mutex)(&st->sync_lock);
+
 	if (readval)
 		return regmap_read(st->regmap, reg, readval);
 
-- 
2.53.0

