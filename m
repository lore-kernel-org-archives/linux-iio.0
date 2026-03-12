Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BB73B4EA9;
	Thu, 12 Mar 2026 11:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773314481; cv=none; b=o8Mnl8JvJgtL9MOeu1c+dKRnCWX//U5QDMs2hnUiCJvdJuY7VVnQeaaS9zAy16yds17vRiXB6sYtZoZ4cB4f2QpXjq2diGNgpG72F4cvgerEevrA0ogsHscRK+3iXg4WI+1X8j91YEsCCzbJbot1C50KLamY54XjFglduNX2kWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773314481; c=relaxed/simple;
	bh=4XXD+HXtrMHkRsv+2kSnF4m5wb45hbzXtmO33LLp/ec=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oqhwAOcxSYmDkIzN95YPvbL+edr+7wvAemEe5BNag8MuILO5IHxvtKD8SObCj4ZjwWSQCeA6liaFNYxpytb4v7DxTkhyTOOaWyXKxzv/FCBxGDuMjJ5wokK6g2jnPK+1Y7yhpW/WHStzdL9BKMG5mhbxVsu3v+NqZuuYVQZEIws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=1iBgw5W+; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="1iBgw5W+"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62CB7kKx2000247;
	Thu, 12 Mar 2026 07:20:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=7pFnlbmYf3MGufWAlhOGud5obHK
	HEgB3fChDwf8xd8U=; b=1iBgw5W+/gNN8hGy4+2wVBE+QpPHjtEFpfyJ1P7F2PB
	Z01h7G3n8I6qG1Hl8MF1Wivvwi99JkVjJ8Wf+J4WAe50MDTCjm//bCEDE5BZSxpR
	xGVCFuFPZM7KDTQuAeC8MO6eRcS1hILfVZ4Pa034WbXGW/iV451ltdM/XqzW8sH8
	TNVuI6skwsnQobPFYlPqxif03IIQSA8MYNmrmWsIHC83Es1k8Z/6BKh5bYw1H+K1
	wTjaIq9kdQnmGdyhvu64wtd8Tf3XDVioa73A+vUPlzQyQgYEkScz6H5joM7eqwry
	9Mn3bTg82kOqsGW93lHt0J3bnOsK+ad5I2WwEg727vA==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cuh5wj9h5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 07:20:56 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 62CBKtuH032442
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 12 Mar 2026 07:20:55 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 12 Mar
 2026 07:20:54 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 12 Mar 2026 07:20:54 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 62CBKbhk021783;
	Thu, 12 Mar 2026 07:20:46 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Lucas Stankus <lucas.p.stankus@gmail.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan
 Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>,
        Lothar Rubusch <l.rubusch@gmail.com>,
        Mircea Caprioru
	<mircea.caprioru@analog.com>,
        Alexandru Tachici
	<alexandru.tachici@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH] iio: dac: ad5770r: fix error return in ad5770r_read_raw()
Date: Thu, 12 Mar 2026 13:20:24 +0200
Message-ID: <20260312112025.57554-2-antoniu.miclaus@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDA4OCBTYWx0ZWRfX7i9BFMBX2zU6
 nB8xrzcHiJyJPw42FfyiwNX8WbqTdKmqEUgbwpvHoj51hnwPTCOTGSus6tBUIEr+BuOKTRU3DMj
 GOO1FXxDj0D7wcCoPJbrycYoT0RXVhNpjPxfKOZE7ncftnWVsnjdwKzwSfq1var2LezfQhBal1e
 Vy8oQ644Rknp0k4KmT54XewM3QdHOmYOJq7/R8H/sKbo03GpEENiUxJIDeEuw1w+bKC8UqlTVRX
 GqygFelJcKgoQeWQQ9CTXsTfbfKOI1F1fTL9UmnDKuUYfjZ5ymYm7yb12njMNljUZW6zdKgy3TH
 ii8bRAeU85OhbNWdkCslT5omUPbCojOqO5FUsVdXvZ/ruU2zYaI5QTBiT0snqtmZ8wMudE6YnoL
 EwQby7bztUOcnm/zN22Laxv2Am+FcmoJAFA+tniNmZ3x5hI9WNpYyxL6hdTG/5OKnIQ5ffVHhbq
 TzdP2lVpIMDP8yPgL7A==
X-Proofpoint-ORIG-GUID: Akhv_Iy9YZTWJhB4EK3BgiAWk4salWU2
X-Proofpoint-GUID: Akhv_Iy9YZTWJhB4EK3BgiAWk4salWU2
X-Authority-Analysis: v=2.4 cv=K+Qv3iWI c=1 sm=1 tr=0 ts=69b2a198 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=jGQaXIFN5YzkRPLG0tIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 clxscore=1011 spamscore=0 impostorscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603120088

Return the error code from regmap_bulk_read() instead of 0 so
that I/O failures are properly propagated.

Fixes: cbbb819837f6 ("iio: dac: ad5770r: Add AD5770R support")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/dac/ad5770r.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5770r.c b/drivers/iio/dac/ad5770r.c
index cd47cb1c685c..6027e8d88b27 100644
--- a/drivers/iio/dac/ad5770r.c
+++ b/drivers/iio/dac/ad5770r.c
@@ -322,7 +322,7 @@ static int ad5770r_read_raw(struct iio_dev *indio_dev,
 				       chan->address,
 				       st->transf_buf, 2);
 		if (ret)
-			return 0;
+			return ret;
 
 		buf16 = get_unaligned_le16(st->transf_buf);
 		*val = buf16 >> 2;
-- 
2.43.0

