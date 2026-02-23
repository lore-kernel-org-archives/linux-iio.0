Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54C134E74E;
	Mon, 23 Feb 2026 10:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771841725; cv=none; b=iZPfZEgL+knRYd77rxkV3pYbDeY1p9FeDTQ7yEj+kq4VSFu3mqqL1wATcDsmeonFSRw4LvqpM6YZxEmpB3bcC+10e9koK70eE/vstjLgx5jTX8bavkX/IUpBbJhd6oxC0cLBGoCieC1wFMNra/Y1XHFui8tcD8sV/EQmP8P8y9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771841725; c=relaxed/simple;
	bh=4CbWvFMTewN0CQNeHIQETdza2vAPMhV0aVQhvd9E5Fo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CaeGIM1uqdaU9iLqGZO6BEbytBRU2DOnlpBmW0RcgheCtfg8rWweDOWrPGhF8BjtW98s0+O92Qv/8yqihho46ouxgi7w5Nm5p7/MTVLS09bL8CdxTy2dxqPYWtbh6C9jxN9vp5+gcGOE7r77ZkXE3JkjVDlr0OhVLHw9rYvcBPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=fjOdTCFC; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="fjOdTCFC"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61N7AMX62668516;
	Mon, 23 Feb 2026 05:15:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=u+q2lWUVn+Dj/O72fiM5nwnufEX
	64wNLdIJYrf2EU3I=; b=fjOdTCFC9O1OtLv9aAbaGms96hettPICN25XkFX/s2e
	8Ur0GASq/aK8Xm2t8rLLgA/007DY6hh0eEhlllf9f9Oe9gLTaqv91I1CGowbuzmN
	gscShG8ZYCzzC8zzviYglhZQwDtgkHd5XodvW4QzKonVk6RdnfkyHZP5f+8DWkzg
	wQXZDAjSHoMtCnAtBkL5m37hJv6NWa3snf50UTvESXFrO97IKPzN8tCBtET1Jjco
	iUYV6JPzFVRZ12rGZZht840sWvH/w53eIy0ck4Un9R5Uq7fAaQoqpwrwIpkLhmM6
	zzYSYcjHW0sQyEwaOn2TShHBklHlnjU4UPdCox38M9w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4cg7pbajws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 05:15:02 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61NAF17N055941
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 23 Feb 2026 05:15:01 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 23 Feb
 2026 05:15:01 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 23 Feb 2026 05:15:01 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61NAEoJY013609;
	Mon, 23 Feb 2026 05:14:53 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan
 Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v2] iio: addac: ad74413r: simplify timeout return
Date: Mon, 23 Feb 2026 12:14:40 +0200
Message-ID: <20260223101440.4872-1-antoniu.miclaus@analog.com>
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
X-Proofpoint-GUID: as7QZkzO_hzBwYbWGGDa-M9jfe5PqPno
X-Authority-Analysis: v=2.4 cv=RPK+3oi+ c=1 sm=1 tr=0 ts=699c28a6 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=-OOY9uvXF2ComtnGhFYA:9
X-Proofpoint-ORIG-GUID: as7QZkzO_hzBwYbWGGDa-M9jfe5PqPno
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA4OCBTYWx0ZWRfX9bgvVXHTD8ET
 ZZ3+yNV2vQeLGuaNWEnnE6HlOhryv+04fQKIZFtlFZ8sgnVdIq5JwjeLPt7qdQU5uZJKyzh4u3j
 W9zDdbhwgUM68juigzwk//vHoyuOgJ64z/ZkSymO5NrzzAG3D4HJl7IUh0/pzPBo2wg1qfvle7E
 k5+ph8qtpOnJopUdPifMwKZCfi4uvZtFeJ3FNiI3nHCPOBlUIfenkzk87wTvUtHRJc0QrWve2YU
 SgCbqtppMXT+VqnTXs61kGt+BdzK5gQB5y/nk1ZZfge9SQQRWtv5sE95ndaTWv18YbKfeQA5WfM
 UDlVu/puesmzL7S/LWK9Jmnl+zzd90unlTJeXfec3X585YhhlWHiflsO3ROtvjIez4fhVDiype6
 5t5+0x7Itxaw8kBu+kbl/m+uJMtnPLbz9u+BKU6X2mqHDUeRUIqI7znO6CksyJODZijgNcrTz/2
 Zi2me/SqPdeqoLsznqw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_02,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230088

Return -ETIMEDOUT directly instead of assigning it to an intermediate
variable first.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
Changes in v2:
 - Use wait_for_completion_timeout() directly in if condition
   instead of assigning to ret first.
 drivers/iio/addac/ad74413r.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
index a20b4d48c5f7..fe930ce5ee30 100644
--- a/drivers/iio/addac/ad74413r.c
+++ b/drivers/iio/addac/ad74413r.c
@@ -839,12 +839,9 @@ static int _ad74413r_get_single_adc_result(struct ad74413r_state *st,
 	if (ret)
 		return ret;
 
-	ret = wait_for_completion_timeout(&st->adc_data_completion,
-					  msecs_to_jiffies(1000));
-	if (!ret) {
-		ret = -ETIMEDOUT;
-		return ret;
-	}
+	if (!wait_for_completion_timeout(&st->adc_data_completion,
+					 msecs_to_jiffies(1000)))
+		return -ETIMEDOUT;
 
 	ret = regmap_read(st->regmap, AD74413R_REG_ADC_RESULT_X(channel),
 			  &uval);
-- 
2.43.0

