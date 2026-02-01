Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4C43F0760;
	Wed,  4 Feb 2026 12:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770208404; cv=none; b=SMqI5U1KQ9/EuOQSvUdM2/hgqj6kOPltFlB0PNkEIV58jK3D+7lFVu5u4Xj2rmyC56k/Ml512tPC6YW5s52tq0pu2dg4H6kosfQFU3FhoirHtjK/7IepXD/E+JJeE0mt564F/Doopbb78HoNaORNfQzwkfidDRG7+qW3ZHZwhgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770208404; c=relaxed/simple;
	bh=R3fiKQEtgOH0p2CWteOz/QfZorCaiPr1CPgCood4cOE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TdsoPhrOAxjJTs8UtV0HjLdrSyaZ4BidzeCjZuDQ3dR7wWCNUoenUHLGG7w+49kgNs2q5TOoMSSZHiMvbD5o/ZVIfRONpZuFCPK5tklvbEiGKvC1XuEaDviWFUeGV2mKeLkcwYVMRFHEa6AqPduXJKk6plp4pGsPbi66L4ZVPV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ieTF6Pos; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ieTF6Pos"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6147bFVk2906882;
	Wed, 4 Feb 2026 07:33:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=uKJhy
	dLlEyQtiuHUlSKGy0PCLN1MjCYGwCzhx+75FKE=; b=ieTF6Pos0e/Yz4IYgqpdP
	5hd2edokWcTCQli3SaqE2RYIMTiFc4aCbcKp+ir9OFkdsdKsMWvvzdZFxuy/ENG8
	GNeRoGDSPxm/S120WWJiUvDd3/RN1gT93FwoDjpXRQkGYuBRwNZyevD04v1fNBHi
	kxr4enB6D72uqDYhib4b3sldGLyQ5JdIPrYl2UUliM+La1DPr63a9atE5RjGmv2t
	hG0SJZrNw1s0EdKN2AFp+eUnj2yEO3rrfYQN64xRTXEhaSTNLYBu9TfaehXjos7x
	iumkglAMxoTUji6ZpA/WdFx3r05PofkR/DClcpAR+rTtotAcJOTmTVPzF9IAsEY5
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4c3vxva46n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Feb 2026 07:33:10 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 614CX9ix055435
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 4 Feb 2026 07:33:09 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 4 Feb 2026 07:33:09 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 4 Feb 2026 07:33:09 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 4 Feb 2026 07:33:09 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 614CWwtb007398;
	Wed, 4 Feb 2026 07:33:00 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>,
        <Michael.Hennerich@analog.com>, <lars@metafoo.de>, <jic23@kernel.org>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>
Subject: [PATCH 2/3] iio: adc: ad7768-1: prevent one-shot mode with wideband filter
Date: Sat, 31 Jan 2026 22:35:29 -0300
Message-ID: <fc00e0592c79bd301cc29dc36731241ecadb9f53.1769889074.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1769889074.git.Jonathan.Santos@analog.com>
References: <cover.1769889074.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: X-uuf4-VoyZfQ9pnzN_SxBKZycPq1odJ
X-Proofpoint-ORIG-GUID: X-uuf4-VoyZfQ9pnzN_SxBKZycPq1odJ
X-Authority-Analysis: v=2.4 cv=OrdCCi/t c=1 sm=1 tr=0 ts=69833c86 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=-hccp5cQjjF6FW3WzvAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDA5NCBTYWx0ZWRfX1T7etph2YHok
 1IQVlI7Pw8z3nQAXanaHrCmDjC+RxPr3j2nBXKxcnNRpvGSwBYgyGARHny+ZPEpfGW/aG/q8UaK
 sMgzO2ebLTsfcSsj9MSYsvXBomjUofg7PRVkRwBxp1Fo0xvD2DtmDk/kof8m4P++33oD9VLAkJ2
 oqh9/7IJxfENcKP9xlouVErG57EK+VjF/vwbgfGbTRmIfsCA/Hf8/5xLxVDeBad1TWYwFFc1Q49
 KBzzRR/owVAh+4Q/0LZMk+k/PMcYP9MXY8hPyouvc0C6C4ZYkRH0rZsp8savZiuZBGDx8BWe7F5
 9PVZCDVm/f+LSXASH02Et7F5d2wToKNgshlKFB1NcQFpc0t8ir8C8xr9gyRr8ySWMmajNWTGcky
 7aBjPQBNSPZIs/85s9oe7rktwbh8TmaQbsb3AqrrmZoXJjAQ8cQwk7fp/NenClb25SpGEO66jjg
 Ykc3dYnmeQ9T4ek3AVA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_03,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602040094

The AD7768-1 datasheet specifies that the wideband low ripple FIR filter
is only available in continuous conversion mode and should not be used
with one-shot mode to avoid malfunction and incorrect data.

Add filter type checks in ad7768_scan_direct() to skip one-shot mode
switching when wideband filter is configured.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
 drivers/iio/adc/ad7768-1.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 8d39b71703ae..374614ea97ac 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -463,14 +463,17 @@ static int ad7768_scan_direct(struct iio_dev *indio_dev)
 	struct ad7768_state *st = iio_priv(indio_dev);
 	int readval, ret;
 
-	ret = ad7768_set_mode(st, AD7768_ONE_SHOT);
-	if (ret < 0)
-		return ret;
+	/* Wideband filter is not available in One-Shot conversion mode */
+	if (st->filter_type != AD7768_FILTER_WIDEBAND) {
+		ret = ad7768_set_mode(st, AD7768_ONE_SHOT);
+		if (ret < 0)
+			return ret;
 
-	/* One-shot mode requires a SYNC pulse to generate a new sample */
-	ret = ad7768_send_sync_pulse(st);
-	if (ret)
-		return ret;
+		/* One-shot mode requires a SYNC pulse to generate a new sample */
+		ret = ad7768_send_sync_pulse(st);
+		if (ret)
+			return ret;
+	}
 
 	reinit_completion(&st->completion);
 
@@ -496,9 +499,11 @@ static int ad7768_scan_direct(struct iio_dev *indio_dev)
 	 * Any SPI configuration of the AD7768-1 can only be
 	 * performed in continuous conversion mode.
 	 */
-	ret = ad7768_set_mode(st, AD7768_CONTINUOUS);
-	if (ret < 0)
-		return ret;
+	if (st->filter_type != AD7768_FILTER_WIDEBAND) {
+		ret = ad7768_set_mode(st, AD7768_CONTINUOUS);
+		if (ret < 0)
+			return ret;
+	}
 
 	return readval;
 }
-- 
2.34.1

