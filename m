Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B073C6613;
	Mon, 30 Mar 2026 11:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774869667; cv=none; b=HrTQg1x3bONJzTjWWxkjQ5Cto8656637wSrzNWLeDc9PNSye78iZBQ3hAl5JYzuKco237rwVDAuM3MU4PHd0kV2wZTAN3O7v27j4Zt4RJCMZhGmltHixvzoahxFAxwHJBG9LNPWCfDdd1684dhJmbKt95SWrb6C3TfnZbTcHXH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774869667; c=relaxed/simple;
	bh=0jU1z4/HUE3tO61F9Zfpfm7igv3qZhCqED1/MvAh6Aw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ldBRCbJ70vKarN9TBZClWQfgvj4Stlv/knT1zgKCjKlLl1WXjeLSU+phUdz+wjxaUi4di2GWGejfZgnVmuvJwtseNDmPlDEaREiZz5gDu8ttPzUvzSZKYgEgJGPbMQsdYu6L5/450FBYu/+Y574F0jyGfD0KUInibNCb8tmxGOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=bdLZNIwP; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="bdLZNIwP"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62UAw8hk3973011;
	Mon, 30 Mar 2026 07:20:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=qMUm6
	HOgYwomSyrlrKY6ZQWQ/oAnfYFNrTxyiWpnETs=; b=bdLZNIwPZAWbVY42dfnD5
	3/sSRAzGnL2ub7OYzuS6Ep98bqqQ8xFy4Os786DKHNcFtt/DMBM1TNmoBj1DQICv
	K9xDAEZQz5Y938D0CwvUSUF3j2WVw89XiFMUIDHekT7ouJ7tFmd/SQSBld74MXE4
	hBPQkdO1umxOpxzd9CcbhFaSxkJeO6qJCXeLQVCCcT3aKgFDqWUjvPngZqk39STg
	LuBxr0CgWeLah48ZJTrivcoGGtDsG5m+M+40Btfj9m+sDDGRibDWCmfoI8IpN8vH
	+bZPMBaX0bGcGQVtwdtnhu9MWyIMf+gwglWKEqGvM+6KN20xsF8mkjuAUkcC5n8Y
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4d7gkv9kex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 07:20:43 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 62UBKg6t026925
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 30 Mar 2026 07:20:42 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 30 Mar
 2026 07:20:42 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 30 Mar 2026 07:20:42 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.204])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 62UBKDgc014225;
	Mon, 30 Mar 2026 07:20:36 -0400
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
Subject: [PATCH 09/13] iio: adc: ad7791: use dev_err_probe
Date: Mon, 30 Mar 2026 14:18:52 +0300
Message-ID: <20260330111856.121589-10-antoniu.miclaus@analog.com>
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
X-Proofpoint-GUID: FGxbx9VDiWs6QpNJpuoS15FsBXp_94Va
X-Proofpoint-ORIG-GUID: FGxbx9VDiWs6QpNJpuoS15FsBXp_94Va
X-Authority-Analysis: v=2.4 cv=TeqbdBQh c=1 sm=1 tr=0 ts=69ca5c8b cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8 a=2CiB3Z0a25eI0F54yJ0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA4OSBTYWx0ZWRfX3dvn0hDBmzG7
 rY/b7hyXT32uUAnPMQbEnYcUA8JZs7TLHasW+VFglCBWAU2GTgMPalKJyUFbkQGJva6fB1HxWmQ
 OJUTQ+adoBb9EKliLABhRfy89/xC53Nv9yZKfvIshO+4BvUqXkpyDCoWWYuEa7GpcnAkZwxWeZr
 sVHo2GECTpZlOk/paHeyCnRKN8ceiXM7nnC3FMDSS2WDdH1ozJkOc6j8tDIM6k0F3y39BzxrFL9
 h5fh5YToxAmzKQ7FNTOEngSoZCtJQmdnuiLGBNjq+DfJ1zDY34q8dvg9EnYJC9EM0itQzlT5zLJ
 YOBGW8ddhl+Bx553ifbOcvZf747ZpCyo6kfOypJfhDOtSZq1EBM177zpLZP4A3J3QCbEddQBWQq
 OiCN7BYNFD4sqa23+WOj9OMCFeERV0kFHVeL+OK8cUTyMzd1Bnhl/TtBPeMsYwM8UR34C9Ps/uA
 Ox3lsBRhdqxh4vdmlFw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300089

Use dev_err_probe() instead of dev_err() in the probe path to ensure
proper handling of deferred probing and to simplify error handling.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/adc/ad7791.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad7791.c b/drivers/iio/adc/ad7791.c
index ab1ab0d88492..bcdc19e799aa 100644
--- a/drivers/iio/adc/ad7791.c
+++ b/drivers/iio/adc/ad7791.c
@@ -413,10 +413,8 @@ static int ad7791_probe(struct spi_device *spi)
 	struct ad7791_state *st;
 	int ret;
 
-	if (!spi->irq) {
-		dev_err(&spi->dev, "Missing IRQ.\n");
-		return -ENXIO;
-	}
+	if (!spi->irq)
+		return dev_err_probe(dev, -ENXIO, "Missing IRQ.\n");
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (!indio_dev)
-- 
2.43.0

