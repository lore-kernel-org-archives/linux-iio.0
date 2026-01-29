Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1B8238C1F;
	Thu, 29 Jan 2026 17:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769708601; cv=none; b=r6Wiph/RBdLt7yPZTtRKkp+Jc0pLmwUsR5yh5Ml275Igs8Uw4CD1LQ3c0BhCFyEcGDiX5Af+3MI137JE2WsbmgIaUog6JOHYOTs2yeDUi5BHS43l6dKqO5PzjiZEz9oS8NOwzuNCiTdyMLgvzQMFtD+30wPr76eZg0SdAfIcwvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769708601; c=relaxed/simple;
	bh=haszd2dJdlqFwx3w/yC9eVAyXwtjNHdZK+LipVxAdiQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HOpfu3WUHuGnd2Xb+6q0VKP0jrF9pHriWLBnXtxjAahePlYRMTGbwOlXfEd7sNDyBOgPWDSgM16ij5nzcBDZRg0I/+Huih9j3f6KmpacHEnJ+i3kr0tfQRBAZIu1NHXQsB3lRizb4WxGUNXSlQfynZtwA+1x7CnvGL3NQydMA3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=t6mmuBLC; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="t6mmuBLC"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60TDolrk009029;
	Thu, 29 Jan 2026 12:43:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=YcbiMRJkuUtz8NKOB+aPcKKl8xR
	vEZby+3KmTZUVEUA=; b=t6mmuBLCWMPxgDwVLPVJBBqS40Iyyb99Hvbe8WcfK8e
	gtKNDi/c1yu81KIDy49uy7fmtaWev/a4z6bZTAGsOdEBiRXg00hTstsrh7dwihUz
	cQPPJdp470c7Wz/gY9d/cD2+/xVgIRQcbvMi6Oqodihs3uBhYWDoc8CSkWKvmT0a
	5sIhhXx7WpIzMbwyBcw4ZXKSeg3tYUgDyU/OQT3qjYmmfzfH0e0ax/STLeOavowh
	aW9TWNt3TppmS02qvM0uCykIFFdUvrVYqCs9QBnpq6iA29UlDhvY/wfgVD5KzlhK
	hdhYStp6radGCIzFLB6S5QQovloYuDiQ7cFqDT2tXmQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4c08su8y0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Jan 2026 12:43:10 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 60THh9dl057577
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 29 Jan 2026 12:43:09 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 29 Jan
 2026 12:43:09 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 29 Jan 2026 12:43:09 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 60THgsKx009203;
	Thu, 29 Jan 2026 12:42:57 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
        Marcelo Schmitt
	<marcelo.schmitt1@gmail.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Eugene Zaikonnikov <ez@norphonic.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] iio: humidity: hdc2010: remove unused interrupt_config
Date: Thu, 29 Jan 2026 19:42:35 +0200
Message-ID: <20260129174253.39574-1-antoniu.miclaus@analog.com>
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
X-Proofpoint-ORIG-GUID: 6DI0VlpEC7JoylhLi8um-5T8Jg73i-P5
X-Proofpoint-GUID: 6DI0VlpEC7JoylhLi8um-5T8Jg73i-P5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDEyNSBTYWx0ZWRfX7BWzB97cWCw9
 J1eFnUSuou03QND6WoH2IyyBeCvGduOqG7Z3NHcLFjBPvQpWPDnACbfekEmJtvR+NAznXy54V/g
 x3ZInJ7fTUULivtWOnXhj5hX+WLfXhC18SKSKcZR5zFpdDJV+yX46OzYSfEXD922v214dEzABsw
 uvVKACyEEvvWdJux6k97IDuHdtFaud0snXx5dPslj3NMTHqLFi4I/y4t74CiJy2qLj+7JwTFUof
 OeBASt+iuIxgnvlke8h1w8nu+HrJz1GHPbsDidTP98LXG5idu7wRf4NjfmPzq5377jqcWANZYNJ
 O3DnFBdw+sOoJn/wh2+lkPHswet517A5ZZSqB7/b6xPZGkzaDQMKeGqJsCnHQtEeCi+Jsp/JXK1
 HyHBKcNj5mxAgf3blmgvP7HV0hY2HFQLTeQHSN79YJ1FmWEPOTAqrr25l7yVifVizW7tAc2SQbp
 pgd5/I0/zx4eAqn/c5w==
X-Authority-Analysis: v=2.4 cv=IsgTsb/g c=1 sm=1 tr=0 ts=697b9c2e cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=AHn-_dkCmIAsxzRBCjgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 adultscore=0 impostorscore=0
 phishscore=0 clxscore=1011 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601290125

Remove unused interrupt_config field from hdc2010_data
struct. The field is declared but never accessed in the
driver.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/humidity/hdc2010.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/humidity/hdc2010.c b/drivers/iio/humidity/hdc2010.c
index 894a8b4ab193..1a0f18251381 100644
--- a/drivers/iio/humidity/hdc2010.c
+++ b/drivers/iio/humidity/hdc2010.c
@@ -44,7 +44,6 @@ struct hdc2010_data {
 	struct i2c_client *client;
 	struct mutex lock;
 	u8 measurement_config;
-	u8 interrupt_config;
 	u8 drdy_config;
 };
 
-- 
2.43.0

