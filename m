Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91B7238C1F;
	Thu, 29 Jan 2026 17:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769708613; cv=none; b=GyvE+C7bTbRALuZUkZcx6kyUbGF1fRb8nK8VVqjvY0mUjjMJSqiNgc7bxnu3v4Ul152j4c4UJJ1F9Z7A4l1p1EOiG8OlQUIQp4LpX6NYyzhmMqJXWMxCWwADGq7GL+yDgAOQBA0n8OamZkqJcI6bFgcLrTzIEQRAmS7bK+T+WA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769708613; c=relaxed/simple;
	bh=Qt/okT3pBW5HKxmqHe/n9fcnAGcWs/WRbYX0fr0jyKU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oz8b2GS1RxIVZ8hzjDXRfxgabTj9IREFjgq6HpFhBh1aR8inwH7yUl53VwKtyps0Yh20h2PUFX4vLP2SbWaz2J9tUteg7aSFjcaiaxwEb9QSFQzhKA3fJOsKM+MUmCo+i+XkiQuR7Cnjs2Q2+E+QP5r+2lq2w+CZVLG/xV0Mhlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=sNO/kSvV; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="sNO/kSvV"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60TEthb62649131;
	Thu, 29 Jan 2026 12:43:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=VVVAn
	ilNesagY0p6CeeeozX6bNfebk+wyapykPxfP4Q=; b=sNO/kSvVGkLfRWnKVhh8z
	6SfR8IFIAbjPAiXycjqQ1qobO+gHoFzF7Nsti+G8fr+G4T12zeLwzOYZvM6bNO7u
	OuHJ8rIcD01G3zRnsurgL28/T7SLkCbGM5855hKwQUAq+lIZrD5Pz/+i9y/S/k92
	4gXB7jooQQZb/yo69VowQqPkarhFvzzGpeDY0hhIPz8MVUBk5UKSN491vcxu8sv1
	oa2ax9mDsI6AhuTzLB+CJLLv7eCicQNyeZPTz0uUQbgWJ7Q6d+1kgN7CAiR2bCI5
	39gnwixDW7eY+pjk/MYI67YgSfx6BIFi70TorAsXqOusm1OI6hfY37/AZG+LX1Dd
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4c04891xss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Jan 2026 12:43:24 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 60THhN2F057601
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 29 Jan 2026 12:43:23 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 29 Jan
 2026 12:43:23 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 29 Jan 2026 12:43:23 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 60THgsL2009203;
	Thu, 29 Jan 2026 12:43:17 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
        Antoniu Miclaus
	<antoniu.miclaus@analog.com>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Eugene Zaikonnikov <ez@norphonic.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] iio: light: gp2ap020a00f: remove unused debug_reg_addr
Date: Thu, 29 Jan 2026 19:42:38 +0200
Message-ID: <20260129174253.39574-4-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129174253.39574-1-antoniu.miclaus@analog.com>
References: <20260129174253.39574-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDEyNSBTYWx0ZWRfX9eBpAvsl49KL
 z4V7Dg+7opJ0qZdeNzQpaGNJkbQXJWhmrzPe0rsMPZcX/ipFtWIJHUcWrpNVkA+MEocFu+N8PBD
 oyBavzChY7+9J8Ssx4SfxAmlBSGWJQCljKWVW39rP2hGTkLdWDo/cOLmuEbCM11oct88nsh4VeD
 d9dguTU1+MvFzdupGnzfUR8clVWtcVindTWcy52ivZ61yvBKTFvyBqHUEs1BlsbLldWqrfTtkEF
 h3lpC2Vzn1co1UvSGwcKJbn+sB4WbYZHOMWrPcbBJ8QBhLGaWI3u7GmlmPhG4QnuLTHTKwVqkKV
 2d+7R6LVwZIffiSMwmulKt7N4l1AtLQl4vB2eOclqXA4Dc9cieIog0+3Ft/UxA6El34AcboKAJ4
 QjP49D8t2JwkoZUl1ixbUhBEBtq36cR55z4urz0jT1nHaEPdyvPKUpaFLN+QNRmlpqggTrQZM1c
 cRZys1jJcOZLtexj1ig==
X-Proofpoint-GUID: RebDGVXFBSnlP93WCtvx_hvKK5aywTyJ
X-Proofpoint-ORIG-GUID: RebDGVXFBSnlP93WCtvx_hvKK5aywTyJ
X-Authority-Analysis: v=2.4 cv=dq/Wylg4 c=1 sm=1 tr=0 ts=697b9c3c cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=iQSssSEnmO4gRBikR1IA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601290125

Remove unused debug_reg_addr field from gp2ap020a00f_data
struct. The field is declared but never accessed in the
driver.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/light/gp2ap020a00f.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index c7df4b258e2c..7cdd61db7096 100644
--- a/drivers/iio/light/gp2ap020a00f.c
+++ b/drivers/iio/light/gp2ap020a00f.c
@@ -246,7 +246,6 @@ struct gp2ap020a00f_data {
 	struct iio_trigger *trig;
 	struct regmap *regmap;
 	unsigned int thresh_val[4];
-	u8 debug_reg_addr;
 	struct irq_work work;
 	wait_queue_head_t data_ready_queue;
 };
-- 
2.43.0

