Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB15346FC0;
	Fri, 20 Feb 2026 13:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771594594; cv=none; b=iKJQzxAyfuk74B81zQPfegpssLRYZRW4XVyCG037TXltjlhvuhO34rlvxJlqWDf3zD8+Aho8KNNjl6iJcXGo1eVI1/YVnoWpxFxo7UtqHpnoNF15GhPrP1tDkeSSFPz5Dofa59zXaTy3YLAsHV3xOd51lOZ9xuPiZ4lC9vLXBQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771594594; c=relaxed/simple;
	bh=q6A1Si7AeOLphX+XdZGijLMPVhgC5r5rhdr2aoLd+yQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bLiWWfHwNy2Oo8DF89WNULQuYOhpQd2xZLzp47YU7WOdP8ZiAgYq/wDg4htv3LMf5t0LBNMSeuL3kLcIEO8djQ6LqEa2Lvv3WEV9HDcqmtC31HOboNsqBNiu0gFrjG5OaQ9BZhX8cn9POO+wwd+I1UWsy2c48svtNc1s7sGhQ6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Mz+j8Ale; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Mz+j8Ale"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61K87ErJ3823368;
	Fri, 20 Feb 2026 08:36:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=twDsI
	6NwjfehS4eMKKBkUQgRHchdvZa36q/MgH7pOfU=; b=Mz+j8AleRw9cbxyhPxCRx
	PKyeSLawUan1S2Ap0OJrYBotvgmq4iDVm51DY0p7Ri7P0ofCTKJDDMp5Xent5BLB
	TJCm5AOJV7VObq+LPL718hRNd8BRfw64Isx1X6M3A7NUh6IBBK9INeh49hub2SwV
	2BIYaiRmD4ewA09gKIpio8SkKA2+mrmTNFgSeWJVb/hdiwjBoTDiCy+GgNDDXK0C
	qIuVSqpX1+HOqUPGocoVnCDnWbjffMUnpHV8oyGda+UlcJQ4aFASU+80CPsNC/oW
	bwRMZuwZOLJpY7Ql/GZY1IXMcWcma19BXNSAZvTmJfGH2Y10UEjk5ry/Gvp5Gj4t
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ce0xvw2xm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 08:36:19 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61KDaIMZ002406
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 20 Feb 2026 08:36:18 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 20 Feb
 2026 08:36:18 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 20 Feb 2026 08:36:18 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61KDa2Q5010396;
	Fri, 20 Feb 2026 08:36:14 -0500
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
        Antoniu Miclaus
	<antoniu.miclaus@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/5] iio: dac: ad5592r-base: remove redundant else after return
Date: Fri, 20 Feb 2026 15:33:32 +0200
Message-ID: <20260220133337.85216-4-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260220133337.85216-1-antoniu.miclaus@analog.com>
References: <20260220133337.85216-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=AeK83nXG c=1 sm=1 tr=0 ts=69986353 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=gAnH3GRIAAAA:8 a=K-JCSTTCk04vdcaz_WEA:9
X-Proofpoint-ORIG-GUID: s3_x8LRzUkh4BF-1k7SXxKHAwIx2eUOh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDExOCBTYWx0ZWRfX39MKJ8pzeLtu
 x5dCJ22H4MjzBRNaOiYHZqynYUVUGMwkMgi9tPwCGnvmxPIAuLRl/5SsAlcjy67wQuNNfBBD59W
 +CLHuuOkKOfTbuoIETw6BAPmshUNj9NUUKlVmcpDnpYHT2gK5rjPaW8LmRq9v9n1R3zo1JdxUN4
 kCKou4rw6XaPtXqsiEsuOX5aweEpXP7jbWH3UrWztYLmzEiWnjWwU34C+isUdv6lPi1IQD7gTAT
 EiiUMCPJilO8iGDpbygZQ4JlP/XgJLEemZL6JUmtfcHZpK3hYg3vR3EcqnkZxs3TLR4SNdYpeO7
 M86fQyxTtfGXN9PFKryOAx76Q3qskECB5s6RqzoVdifkfR8WcisX2K7a3a09jkg6/lkvzYezBg6
 Mhq7poxlLDLZqgydJYVJBacesaKb55PqMPqeNR5Fa7xn1F4V8fJ5PWIiDaasCNgzYrgQinAjIhH
 zMm9GEUUuQCd1KByp7w==
X-Proofpoint-GUID: s3_x8LRzUkh4BF-1k7SXxKHAwIx2eUOh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-20_01,2026-02-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602200118

The else returning the internal 2500mV fallback in ad5592r_get_vref()
is unnecessary since the if block for the external regulator already
returns.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/dac/ad5592r-base.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/ad5592r-base.c b/drivers/iio/dac/ad5592r-base.c
index 4720733d66b2..a8c10ca238d0 100644
--- a/drivers/iio/dac/ad5592r-base.c
+++ b/drivers/iio/dac/ad5592r-base.c
@@ -179,9 +179,9 @@ static int ad5592r_get_vref(struct ad5592r_state *st)
 			return ret;
 
 		return ret / 1000;
-	} else {
-		return 2500;
 	}
+
+	return 2500;
 }
 
 static int ad5592r_set_channel_modes(struct ad5592r_state *st)
-- 
2.43.0

