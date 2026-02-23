Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864FE3659E6;
	Mon, 23 Feb 2026 11:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771847999; cv=none; b=ffG2zRMiBf4Grokeb4J7iEMIZZJ2ykPK7l2jE77pYvcg4HI61/t+BWl1shpovnb/iIDt4eJH+nPVK7/6W9MxWcCnfVLa5gYyHWQoqbBJ3jbl2aqCe54XlMuTNt7ARc9fK5oMRbkSvex5rW8tIGsN6mzhSPNs4oCqODC24yObxr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771847999; c=relaxed/simple;
	bh=XfySPrOJqSjT/SEKYyjp0Pg4NScYW7xZ70lfnKpKcsk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RjGHCiPXAamH/bZbYQmBBkLNEZzwJ2vO0GFBJM9noEspxnZrYMbLjPFQq6+cuboSdb7XS8ZAkKLjUCLLdfafgpk3cAv740KAdJQA571jRAsPDfma7CbMO8fO3CF5YNSE9dQTrF9xR4xIQHNfobH6+09dffuBYgE+lcHxnsvdaM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=V/SFFbzL; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="V/SFFbzL"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61N6nDbY1743194;
	Mon, 23 Feb 2026 06:59:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=spBj1
	xSbF+uHZ7QWpbXQzjgBtsnrv/ctoVAx4Gq+fvQ=; b=V/SFFbzLnHN/pGHWag7cx
	07ust527JHazftTjU+lvx8cbdCjkurGqO3oJkrTVmdrpjB7Ut1bgsx+SfZEyifkq
	VA5xA1tMZDYGGqAHBUEf74QhiVp6Bw/Y+KUqJjLzrgujtOAF7Q8k1Wld/OtyQSDJ
	LkzqPwR+wLQ7MbHXclZgv9yTMXrjXyL3eaQQDWenKv+lT9SenuUcL/2Ekidz69BY
	jIlkZWIHNkokm3AsVZfg0he+4MVEz1tDyIFehMh7usMxRsa5CcQalV1BFwSHSgDL
	cgwq+3kn5RZpSTrj3bU/h1Qb1syohGyNYflhGbtHGJzghiP0ai3nTVT9I8vcpMHn
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cg7p4jvb4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 06:59:43 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61NBxgeq000989
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 23 Feb 2026 06:59:42 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 23 Feb
 2026 06:59:42 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 23 Feb 2026 06:59:42 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61NBxQi5017964;
	Mon, 23 Feb 2026 06:59:29 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <jonath4nns@gmail.com>
Subject: [PATCH v2 1/4] iio: adc: ad7768-1: fix one-shot mode data acquisition
Date: Mon, 23 Feb 2026 08:59:26 -0300
Message-ID: <37b4d283b247d9078b75bee0b203d44df8d45f8c.1771362939.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1771362939.git.Jonathan.Santos@analog.com>
References: <cover.1771362939.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDEwMiBTYWx0ZWRfX28b5dbEO9CTs
 EIEhM/4hfGThsVcbQqBfBYx6x4xu2kn/TY74IztPIHKVNXJvCelUNPys8uDRQSmC2HRGtYGicF/
 857mJDaS82sMSnP5Blw50V/Gca010wUrXNbKgnQreMapY/j/EBNopz4wOm2PbXXZ3qHxRLlASMC
 jESN5MxPFOTbi4a33yJPx4TIHK1c9LSrB3ZCdwmRC9yzs5LQsITc8hDTYNnnyGPo+jvpnqgc59G
 oBHmsgDwDNUDP4cU6v9GF349QTTSqMZpD72d/9dV5NsXO43Nqwj7DD/HbHYuG5tw67N7NmLB/Lv
 LMFY6l9uKv1p7NrEGRtuQZ8fmIFVGav55qQGrQPUHKkknG4LqYwpx4SlkFHeDx93wz8UWJf2aua
 fb6PBdrhWOtUdRbinYSOXx7AQq3IsvMIrpqcouDpU/6IrjS7GuNa0gBzwqtIGSHdFR97K+JjIBX
 PtdILguiYY1NR0P6ZRQ==
X-Proofpoint-ORIG-GUID: j64q-tvd10JvZBD-VQKqMrbu-pibT65c
X-Authority-Analysis: v=2.4 cv=LfgxKzfi c=1 sm=1 tr=0 ts=699c412f cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8 a=uXKFMexyRkwL0ZmDwxwA:9
X-Proofpoint-GUID: j64q-tvd10JvZBD-VQKqMrbu-pibT65c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_02,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0 clxscore=1015
 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230102

According to the datasheet, one-shot mode requires a SYNC_IN pulse to
trigger a new sample conversion. In the current implementation, No sync
pulse was sent after switching to one-shot mode and reinit_completion()
was called before mode switching, creating a race condition where spurious
interrupts during mode change could trigger completion prematurely.

Fix by sending a sync pulse after configuring one-shot mode and
reinit_completion() to ensure it only waits for the actual conversion
completion.

Fixes: a5f8c7da3dbe ("iio: adc: Add AD7768-1 ADC basic support")
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
Changes in v2:
* reinit_completion() is now called before sending the SYNC pulse,
  to ensure that the completion is properly reset before waiting
  for the conversion to complete.
* Patch kept for backporting, even though superseded by next patch.
---
 drivers/iio/adc/ad7768-1.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index fcd8aea7152e..4cb63ab4768a 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -463,12 +463,17 @@ static int ad7768_scan_direct(struct iio_dev *indio_dev)
 	struct ad7768_state *st = iio_priv(indio_dev);
 	int readval, ret;
 
-	reinit_completion(&st->completion);
-
 	ret = ad7768_set_mode(st, AD7768_ONE_SHOT);
 	if (ret < 0)
 		return ret;
 
+	reinit_completion(&st->completion);
+
+	/* One-shot mode requires a SYNC pulse to generate a new sample */
+	ret = ad7768_send_sync_pulse(st);
+	if (ret)
+		return ret;
+
 	ret = wait_for_completion_timeout(&st->completion,
 					  msecs_to_jiffies(1000));
 	if (!ret)
-- 
2.34.1

