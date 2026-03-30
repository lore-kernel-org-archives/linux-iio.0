Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4B33C73EB;
	Mon, 30 Mar 2026 11:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774869670; cv=none; b=NNDseYFT0k1qvPB6jKTry5N0JTExmw8COkoLnp+6no5hQdWUu9+yHpnxkfc3VaE2nNqQkH2lpGjvW61tnLK/AMIFZslfkPbH1T+EoKvmf56l7KCI0vzLMQCQvhrtBmqOKIBH8evgfivp7z3mZDdrC3FVySOTKAkB1QCuswIxQuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774869670; c=relaxed/simple;
	bh=YZC0eX1SqbFCTqmeOk9BBQDEQzwN4Cc4mRJR3EvyZUg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lyA8mWN2/ggywO+SH4j0EgdBi4xvjb6+ET5vdyzUiifRJ1tqNc28ZzmYfGnqSIq6871nOYQnYHrCqEXzkSGHWWHg7aqj0Q9mHfTjnVJK4qu7vHYF0f/QWt3e6Fg4Ts2taEiF3vf+dYZqTsR4GtOVOguIoIAe3+Zz4pUdm3E2Nxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=iodw06I0; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="iodw06I0"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62UAw7ss3973001;
	Mon, 30 Mar 2026 07:20:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Uky+e
	9OUvov0uCNS5cPahC4abIctml7hqiJBQF/inQw=; b=iodw06I0+wwWNyEI/YznC
	45LDmvVJodNg+yTwegk8wQPMP8CCzgcUqnr73qy8i41dF0I4VsbpkHRRnRiouvik
	9DPus+USLZPlw8tPGqrl4cU1MWJQTTwxJO1stJjzVoper3R3Bd9v7PJ8IdmA5OMY
	HnOwTjEsVPgTvDWF8gDUIPW8jJYnABHs87Y4709dTS5ngfYrZX1Y2mOYsmFWCBax
	XUMX7Lpzk82XbDctvtGgZb4LT7eXwwqWapsBG0WesG+zWOlRcAk8VV7ka1J+7uCA
	pcN6HTIinLEgdQYTXm2gYSYCvOpUXLAl+5lREfRTYcM/3f84noEbj/0t746rAJLR
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4d7gkv9kf5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 07:20:47 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 62UBKkXx026939
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 30 Mar 2026 07:20:46 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 30 Mar
 2026 07:20:46 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 30 Mar 2026 07:20:46 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.204])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 62UBKDgd014225;
	Mon, 30 Mar 2026 07:20:38 -0400
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
Subject: [PATCH 10/13] iio: adc: ad7280a: use dev_err_probe
Date: Mon, 30 Mar 2026 14:18:53 +0300
Message-ID: <20260330111856.121589-11-antoniu.miclaus@analog.com>
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
X-Proofpoint-GUID: V0IQtERppzcSGg1LQtPIpASN78TMxqjM
X-Proofpoint-ORIG-GUID: V0IQtERppzcSGg1LQtPIpASN78TMxqjM
X-Authority-Analysis: v=2.4 cv=TeqbdBQh c=1 sm=1 tr=0 ts=69ca5c8f cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8 a=JdEU7mAuevLnVqv-DSYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA4OSBTYWx0ZWRfX7l+Upj8ZOIJf
 zl1M9kUjP20Dg2cqZbQYPe3ZdoIKdTk3sF00eXO7AOpujLlWjQyaPldz2wrOQWS8wWvx1lyru0s
 57pOPSBWBMMXMFWzFR4EI6KBwhlV1mGvOCj9gigPMQL/KE+sKZJwgtkfHkBohKn+akpsl2nIOdV
 yFPFuOT0v7uFZJG1irZtcJj95aYceGguv1fNzXT/ER6UzE2s1GiNRsg0Jc9xmakT4Flv7EF/9gI
 RCfww7ySaCISfl4QhYwK67vNS/sZ/vwjm6IgJoMtSK0iJrwXaOF6i7hJecr0hA2DhQtU+Yf+19K
 vrU+hK+aMkbGuMZJVofCm7IfO7k5vcmuMC7d+BxYlPK6FeINXK62SuL9MjeKY411xbr6QafU7rn
 CzCnubQZyyjkZyrDr/f8QOQr2GbC6yCRO4Qr6jWMH8VozdHPy/GjBDaPYJbOlpNrEGJ8OGQo8rZ
 XCHP9VuK1pXhgeTlqVw==
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
 drivers/iio/adc/ad7280a.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7280a.c b/drivers/iio/adc/ad7280a.c
index ba12a3796e2b..f50e2b3121bf 100644
--- a/drivers/iio/adc/ad7280a.c
+++ b/drivers/iio/adc/ad7280a.c
@@ -990,8 +990,8 @@ static int ad7280_probe(struct spi_device *spi)
 			st->acquisition_time = AD7280A_CTRL_LB_ACQ_TIME_1600ns;
 			break;
 		default:
-			dev_err(dev, "Firmware provided acquisition time is invalid\n");
-			return -EINVAL;
+			return dev_err_probe(dev, -EINVAL,
+					     "Firmware provided acquisition time is invalid\n");
 		}
 	} else {
 		st->acquisition_time = AD7280A_CTRL_LB_ACQ_TIME_400ns;
-- 
2.43.0

