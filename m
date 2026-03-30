Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195FB3C5557;
	Mon, 30 Mar 2026 11:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774869670; cv=none; b=hL9CtJTJ55Td1Ineov3wQxZ1itk7bn7omiceRiLfys67FqSPINlstLfzrChVZhL0zChhP1sEDQfsN9RDMct+UEGjukvvcAIMP3iwK5KFjIfZSktL/qysIJjqbNYbdMKx7yn1m+Dy2QLNgEWWRTKr4DtFNb0DiWlzbDqep9gTeFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774869670; c=relaxed/simple;
	bh=Uf5kWA2KDEBBnhlix15FvE6L23GO/1i3M/PG/Z92bLM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rLmurmWoKdNa7NWZ4wqcf4uvB7q/fHLH8LJGEBQWlIfe3d3lVKKPxWccWy+Fi/4TIOEFeNq5qPyNV9njsmh1pDhiAzl4k/KkdLI3tdbtg0frAAMYTTURW3DJ7LiQ0jrvt+titRnf0VRECVRzLZ7O+RpyiG6w4P4JZIf8Z/fPcOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=A2tM844V; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="A2tM844V"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62UB0SQs1037161;
	Mon, 30 Mar 2026 07:20:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=pH8fp
	X3BfcM0L5HVudJ3oyr10hr252AnnPiixxzf1Ic=; b=A2tM844VirzmrESdZcDv8
	Rh9QQ3cKicQ4iLNWNrtGvbZshfVVVUApyxYh/HNwCfxBB//L0tKWc4F84+7Ii7n2
	Qd7hLTmTOD0bHH+ABhwj+A4sf3YxbU2Hpeu6RMVpiEDda3d9HR7Mi2K3A2ezcEqH
	WBp804CGL8I3v68qk9qVYZAi9mw4D16WX5B0X/IfiwPAOqE2i+06MB8XQWnG70Ap
	mY39T2kagvzoq/nMvz6aIvgi5P8F7nlDaNY0BUDwkEN0UMVH9Zej7hIdR7uER+sF
	1RmJbS7Vj443NiNGRHIc7J25c5DuyKwQF2lxpShB50uLzsmUvYEJ3MqvkGrLkXrH
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4d740ybbtw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 07:20:47 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 62UBKkdX026942
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 30 Mar 2026 07:20:46 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 30 Mar
 2026 07:20:46 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 30 Mar 2026 07:20:46 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.204])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 62UBKDge014225;
	Mon, 30 Mar 2026 07:20:39 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Jorge Marques <jorge.marques@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan
 Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Marcelo Schmitt
	<marcelo.schmitt1@gmail.com>,
        Renato Lui Geh <renatogeh@gmail.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 11/13] iio: adc: ad7768-1: use dev_err_probe
Date: Mon, 30 Mar 2026 14:18:54 +0300
Message-ID: <20260330111856.121589-12-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260330111856.121589-1-antoniu.miclaus@analog.com>
References: <20260330111856.121589-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=ANnNY0ku c=1 sm=1 tr=0 ts=69ca5c8f cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=3ypIGDK6mX7mcVr3tMcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA4OSBTYWx0ZWRfX+qxY8ZefYh4v
 WjxwXmpI8BwMhQbhnRl9r6rEahYIY8SGhEyn+lIEuASRPJqFV+4n4i7uyyDz3MEBF3JLd3tinco
 6ui5lZt5KFyiUq/xueVZ2ilp5BRX/og3YHILK6lUZ4D2hprxW0JQYHKUetA9ojEAOBfU5aI0qMI
 q2AKMDb/xQNicvaepdZJRlDGwm77ja53VNFx+rQt4gqwl4M4l168KdJByZhFDeiC68gQXtI8bwr
 x2WByeMqOLp6a7XzTEs+CeuIV94ulK5LCB7fhc15g2MRXfYOZOy3HnQY2NJVcOgv3zMf+aQvdbr
 JyAbVWhGvTQoR5g1LG/eQB00irToRsPi+qY4uGaTuYN6sqNGRUI8TUw1zVvJPEXLKOTpX+SWcYM
 PQCTaODbJ90MdPt52WFeP4HxBYR2bOgn0DApegHi041H65s2xhOUTwlnnLkdwCYDiZa/rfLxtCw
 V6sN6VESYVryi634HYQ==
X-Proofpoint-ORIG-GUID: XIHhYyDefvuFt-yXn86xsb3J7tGFxRZu
X-Proofpoint-GUID: XIHhYyDefvuFt-yXn86xsb3J7tGFxRZu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 phishscore=0 priorityscore=1501
 adultscore=0 suspectscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300089

Use dev_err_probe() instead of dev_err() in the probe path to ensure
proper handling of deferred probing and to simplify error handling.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/adc/ad7768-1.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 73fb734d06b2..598936e47fd2 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -1871,10 +1871,8 @@ static int ad7768_probe(struct spi_device *spi)
 		return ret;
 
 	ret = ad7768_setup(indio_dev);
-	if (ret < 0) {
-		dev_err(&spi->dev, "AD7768 setup failed\n");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "AD7768 setup failed\n");
 
 	init_completion(&st->completion);
 	ret = devm_mutex_init(&spi->dev, &st->pga_lock);
-- 
2.43.0

