Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDF239D3FB;
	Thu, 21 May 2026 16:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779381927; cv=none; b=CWPq5bfa7uSRm+6xQ1n73Xg+/NTTf1I02b6GWrJbFkDX2BphkwsD4340xmoMXYrPAfbiCYThEZ8Z2Yx67iOVRS2cK6/t/zhpCHAjGCFJsj1joCxvtPoZ2s5beEqUZ2ugHZyFYr+JNFBR6L8HEDgUFmdXp0wjb2NKu+c7OGDsN70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779381927; c=relaxed/simple;
	bh=/aud7HYs5g6J1//2Jp687TI6hEmDqmvPE4VwrLY6IQw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jpdu8wvjpNK5uxS5ZEZB9pGFXALSGkW3JoY25kXhySXtvUYwzuTl0Le3KwLPSsuyoU4CKI8Gy/12pEpwBysDP8VeZ4q+G6oBe+qnnjOqLHvGWn6N45cwBDklElJDZGeJQHhwZ1uUMUB1yMBCi+oFJTAYPZAORf06sPH29OHpt8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ZQyTCRWw; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ZQyTCRWw"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64LDjG2C416888;
	Thu, 21 May 2026 12:45:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=dVkkP
	aayLKw0QEgzDjqYDxGr9Rbba+VUBxSYXnv/TFY=; b=ZQyTCRWwqsVwCQmNUMEGI
	YSmuZ7DIDkzqGi3m2XEVj5CaMS8Oaj0sod6/Edp5djQtCY3AfSaFRPvLcssTJFcm
	ENGlstEznFovBpB5BiT3BepwW2CzcbrUQQFnRlAu7BhN3HpngqlGkylFWUo0fy4F
	5+G+osme5CyoPntZABl23vW+MD8SusJqVzNz5SmbLCl3n4+3lKQ9Yg9GCYZ3caIx
	+cFgTNXDY4vGn0teKc6xefayiC5FQFam/jhIIbGLBMylSsS/eQhwG9yp3GdXOC3h
	UBcPryLHVNC0ZHcRTP3gVyxiuCrhc5jANp8eXUw8n46dlbwj3PYbYga52ceflKIz
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4e9e6wwahw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 12:45:22 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 64LGjLrG000392
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 21 May 2026 12:45:21 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 21 May 2026 12:45:21 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 21 May 2026 12:45:21 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 21 May 2026 12:45:21 -0400
Received: from HYB-MkYHBcJRSnh.ad.analog.com (HYB-MkYHBcJRSnh.ad.analog.com [10.48.65.208])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 64LGim0p024538;
	Thu, 21 May 2026 12:45:12 -0400
From: Liviu Stan <liviu.stan@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Antoniu
 Miclaus" <antoniu.miclaus@analog.com>,
        Francesco Lavra <flavra@baylibre.com>,
        Liviu Stan <liviu.stan@analog.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v3 5/8] iio: temperature: ltc2983: Fix n_wires default bypassing rotation check
Date: Thu, 21 May 2026 19:42:58 +0300
Message-ID: <20260521164323.770626-6-liviu.stan@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260521164323.770626-1-liviu.stan@analog.com>
References: <20260521164323.770626-1-liviu.stan@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: ehd8TAxDnkcxsJGYolQTDrYNLokUgU6y
X-Proofpoint-ORIG-GUID: ehd8TAxDnkcxsJGYolQTDrYNLokUgU6y
X-Authority-Analysis: v=2.4 cv=K8gS2SWI c=1 sm=1 tr=0 ts=6a0f36a3 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=itsfFgpfY7t2nVq4jXIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE2OCBTYWx0ZWRfX7VXOrAGkbW+G
 XWPSWwa5QIQxBq4wji1v33BL2vXp/noTHwT9fvMQNSrImLNG0Mgo22hGh3VUUAk3NQAJy91zOOx
 djGNwiJPCkt7TMPkuGqi+wBP75PenFuxKPICFnzEDw3soVL3UsIH7gm7tSdX/x32th0lxVptWBV
 IaJ1VOD73POsARvSHUbstPFC68rXtwYhsatqwT+dMtOT1A9tuhCOc1AnqQHNI11SphfTt8iZfl7
 ipgB3DKN/Kh389RwHAItZf/GWQPMb7UR6Yu/Hub/P9oDbDHVII6f73ohZQmdqa+U4DcaaSjfcWP
 KX9KU+dxvfRPAy7dmn4VXGwlE3xMff/lvYQe8hyMU1Wfe99NlA8TN8Szi6UV43Oit5AKSY00rzL
 5R4gQwlytOr4bzzM0XEVasi/YdL0o5b0EOqJ/WgT62NyZAN4VjJ4JB83oj+RIMcWjfTlwbKw2GJ
 DiEwmMTXwxPi0Fn3J1Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210168

When adi,number-of-wires is absent, n_wires is left at 0. The binding
documents a default of 2 wires, matching the hardware default. However
the current-rotate validation checks n_wires == 2 || n_wires == 3, so
with n_wires = 0 the guard is bypassed and adi,current-rotate is accepted
for a 2-wire RTD.

Initialize n_wires = 2 to match the binding default and ensure the
rotation check fires correctly when the property is absent.

Fixes: f110f3188e56 ("iio: temperature: Add support for LTC2983")
Signed-off-by: Liviu Stan <liviu.stan@analog.com>
---
Changes in v3:
- New patch

 drivers/iio/temperature/ltc2983.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
index 10f423fbe9cc..326f843f4271 100644
--- a/drivers/iio/temperature/ltc2983.c
+++ b/drivers/iio/temperature/ltc2983.c
@@ -749,7 +749,7 @@ ltc2983_rtd_new(const struct fwnode_handle *child, struct ltc2983_data *st,
 	struct ltc2983_rtd *rtd;
 	int ret = 0;
 	struct device *dev = &st->spi->dev;
-	u32 excitation_current = 0, n_wires = 0;
+	u32 excitation_current = 0, n_wires = 2;
 
 	rtd = devm_kzalloc(dev, sizeof(*rtd), GFP_KERNEL);
 	if (!rtd)
-- 
2.43.0

