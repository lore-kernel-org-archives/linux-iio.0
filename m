Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074B6343D9E;
	Fri, 20 Feb 2026 13:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771593559; cv=none; b=GcO2Vf/Nh+3VgBf/ESJ/AGFkgCc5lp1rpHViSqS2IBGnQldKiFOticCbFGExWxqG3JcYnzaqF3fAUMNb1tHcTB7NP2xBGFO+foBZLaruvV26Lx8xLZW84TAPmFgAjlZQeR4tkAdfjzNaP2tInZ3bq3oD1oUzWrpaywP85XbBT7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771593559; c=relaxed/simple;
	bh=cKLwI4Dv7G7zKvJ3uNMnRZHDQQGZuqTcSGzzNlv5v2w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C4igfmykHPrKK9EYL3sW3XzDrUrBu/sJa0pExm1yqIbTA65FkGOzguLhbvOlkxX4D+VYYRQJyNW2SeGNP1bMKVbVrzXpvJkNyocL9UR/GV+JF36iI7p4LyS7SAbofS6GRlbncCrKf1we4QRn9Ts9ldgHnb0to4kaEb0i6DPp5O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ACNQ7cvr; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ACNQ7cvr"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61K87EH7631899;
	Fri, 20 Feb 2026 08:19:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=XUX2W
	IbPhoHcp0XfG+hORNTfNA3yxYHtghNz1LWZOKU=; b=ACNQ7cvrhhjGTxNC1TKaR
	cCbTCg7DoxMsFYVzccAnsolctx5/4IobUHjApNiWxOx5Wt63hH0E6RzQZ0qj/Qpw
	nb45mbSLDhGNeHTSPyj2rMxu2HbsQcJr7aNMY3/2MbCGYe+cqGlMC1NW4/rvESUY
	+PV0o/6MGo8iveC2DmRERUHvsdd4l8eo2W1by96t/fkTd182IAiDXQG6pTC+GyVA
	AF5T3t81+i/eTAauebpbda0c+A7LQlwqPK8rwUOanr/cB3OMr5AIapcAtkO1befG
	rZHjH9jGTPBRgSkwj9cAnLsCQUGSG4bmBYkEeVTLqER+xnZVPEAMNF/YZKva2pgr
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4ced6fa7y6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 08:19:02 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61KDJ1FK000431
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 20 Feb 2026 08:19:01 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 20 Feb
 2026 08:19:01 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 20 Feb 2026 08:19:01 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61KDInCw009733;
	Fri, 20 Feb 2026 08:18:57 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Cosmin Tanislav
	<cosmin.tanislav@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 1/2] iio: adc: ad7266: simplify error return
Date: Fri, 20 Feb 2026 15:18:46 +0200
Message-ID: <20260220131847.76968-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260220131847.76968-1-antoniu.miclaus@analog.com>
References: <20260220131847.76968-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: BhDPcAmQizGNv5lPtpxNOyogv_SLGSmd
X-Authority-Analysis: v=2.4 cv=fPg0HJae c=1 sm=1 tr=0 ts=69985f46 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=gAnH3GRIAAAA:8 a=6YSntiD3rRTT28Zils0A:9
X-Proofpoint-GUID: BhDPcAmQizGNv5lPtpxNOyogv_SLGSmd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDExNiBTYWx0ZWRfX+Umi2DpsW2JX
 617dzjxcjt1u5s2D6AMci2m9BhTZ6wC6sVLckVVnspRfJPIoXFDt/nOET5KU8PSdzh8CqLz4kWt
 r11ofy+C7qhrIsnJbWYiVSBE1T+yWMPsEeOE3BI23rtF7EXqG0jyykk7EgluPVMuG6cJ+UzJjGR
 zoCLh0bpOpLxo4ftxGwK1Wcv/f6AmXYH2vEIi2LyGsmND9oqKLXkciSWOJb/Rb1TYSVMoxKTmzY
 jKKt3RKgdUXEDVp5OvySgZaZH6VJlAvjs4dHlFw/KdXZ/auGYoyfGky8x4jLcqaZBonxH7fmrq+
 o/NC1VDqcsICtRRw/32E9d/i338ECkeXp7xwWIjE5FIBNCttq5eLP/Njuut9hYia6qHcXcthLLj
 JnHo8r+WZPTsngnpEZME3SVBoCoqLgAPpDTizmWQR2XdYF+ruzz4X9g10HiUsmsWTEiJxYk/uCK
 qumEDHCRdsK/85/Qseg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-20_01,2026-02-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602200116

Return PTR_ERR() directly instead of assigning it to an intermediate
variable first.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/adc/ad7266.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
index 3364ac6c4631..0ef36c249ab8 100644
--- a/drivers/iio/adc/ad7266.c
+++ b/drivers/iio/adc/ad7266.c
@@ -409,10 +409,8 @@ static int ad7266_probe(struct spi_device *spi)
 				st->gpios[i] = devm_gpiod_get(&spi->dev,
 						      ad7266_gpio_labels[i],
 						      GPIOD_OUT_LOW);
-				if (IS_ERR(st->gpios[i])) {
-					ret = PTR_ERR(st->gpios[i]);
-					return ret;
-				}
+				if (IS_ERR(st->gpios[i]))
+					return PTR_ERR(st->gpios[i]);
 			}
 		}
 	} else {
-- 
2.43.0

