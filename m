Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6E13B895D;
	Mon, 13 Jul 2026 08:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783932099; cv=none; b=suizHlKs8/5LJduDfcNexYZ6ygrqhiuXjHhOzbwhVVZ1PIxVg5HVwrKpnhFkXk84NWuWT3vb7iQJGHG37w/ipuEHWzYcmJYV5bHX72mSPXboVNNtyV9IElm6ZqEnXuRHEqwZH4P1R1zwqu+oFbQy2dRAu/yAhvaBIYFZNQQeRlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783932099; c=relaxed/simple;
	bh=BITR+djYrsGrTWEzZ/SD0Usr9RVc1mEwa/+7CRTb/Vs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z1upwlsaoa+9Z3X9r9CYgPduvRmzuiaSaMtmVA5rm90/8vTLztoGJmTxwCCsLVbCpiTRho63yREfrf6DFQDczyfSETFUGYv1oNnWw0NmpK8c0fwB5dcKSxmswZmYqyx6WnQM7e57Gf0333svYrmrK9yHmv8GeW7utmSTV3lCf/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=A6+dDpOi; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="A6+dDpOi"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D6RpjO2787747;
	Mon, 13 Jul 2026 04:41:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=MxoDD
	knga9s0TWUSrZJM/Zu8d+Yde1SVeoM0kBHEN34=; b=A6+dDpOinURAcvhnMCsWq
	jxVWRLe2sGdAjb7HVuhjxuTeq0ZuKTvezIwpZdd7DQSqvD4vVImCDbT71vTE+miP
	iKCT5rw5UZvsl5IKTUvS8wn2ZNoFyXfM1tdBCIwZ7sqDhfk93zKeXM8LbN2w9F1c
	zrawzyM10vrdvhRXRYZVKkQoZMYS/+dE1SuEuQre3DiRBty3mB28xq9655OTasgX
	bPU9dTCqw/du6qVHAy4HTJSvMZr1+MJwFGGwF2JFNFylOXYzR+klG1eH4qB/FXYO
	bXqx5xBP28RxOvN3j4exHw6YhGuG+K6yVU3oCPtPC+zsw2ND3/X6scmscEF7lrMg
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fbjr15gr1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 04:41:33 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66D8fVSO047365
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 13 Jul 2026 04:41:32 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 13 Jul 2026 04:41:31 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 13 Jul 2026 04:41:31 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 13 Jul 2026 04:41:31 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66D8fIAB015758;
	Mon, 13 Jul 2026 04:41:25 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, <linux@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] iio: adc: ad4080: configure backend data size
Date: Mon, 13 Jul 2026 11:40:43 +0300
Message-ID: <20260713084043.10856-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713084043.10856-1-antoniu.miclaus@analog.com>
References: <20260713084043.10856-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA5MCBTYWx0ZWRfXxxAS+AHY2Dg+
 5d77/kEnTeKfXmS5S1+EmChlSazsCLJKYH0+Eo4Pn5DGXt1ljt/7Y85x+/S9+OGfGKGpzsV368X
 0+JvE1iJ1DMY6UbuOPDhn2loJfcz6NG1Nj1+EsiTF2J7+5Rbcrbo
X-Authority-Analysis: v=2.4 cv=Ovp/DS/t c=1 sm=1 tr=0 ts=6a54a4bd cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=3QoOr0BjASE6DIQceiMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA5MCBTYWx0ZWRfX1YfQ+ZdgTx+J
 23oX+JG7S2yja/OFa3Y8WG/5Kg2V0CE6O+i4kVouV0gNEs6Rjfi4XugfchlB8ygP1EgL/wd/XUj
 fYK3sfccTGKpvRVsAIF3ZnnwGI46wexQRhUhKmi95eCTOJoVB7mT0aneKvLHt6oZdCWdMU7l6SJ
 UYJtxCVQIFlqlQLogUuUE7rLLPcmsRuCdStCH9fG2KQPT5JLIBwliRajAWRufb1rm3piPVZNEyP
 ZCVCawrB3szMOxJWqCdAV1sibU8bgH1hR6gnd+CS3JE0SYWGCL+TLgQPAmkO6eDLe2heOxF5MDN
 jizlEWSPWgkU0TBDAcz5NfXR5fZ8jfZnfcL+dfIDH1Lkupui4vSx4xde9sAyKJBrQzpL49fiHsE
 /LwLsXporwpaXl/a3XzZ3OPn3Z1XSZQUQBQAmUy4R1oDVBy7oFJhpZwl6mJlytYXQ0fy8Dl3/1X
 Dbb3UoHVS4VNcBgkOuA==
X-Proofpoint-ORIG-GUID: wmJHDDcioOx6B8vvyJiHuWvNkioRIruF
X-Proofpoint-GUID: wmJHDDcioOx6B8vvyJiHuWvNkioRIruF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 bulkscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130090

The AXI backend needs to know the ADC word width in order to pack the
sample data correctly on the bus. During channel setup, program the
backend packet format via iio_backend_data_size_set() using the channel
resolution, so the data is transferred according to the device's
realbits.

The backend packet format field defaults to 20-bit packing, so the
20-bit parts (AD4080/AD4081/AD4082, AD4880) were unaffected. The 16-bit
(AD4083/AD4084/AD4085, AD4884) and 14-bit (AD4086/AD4087/AD4088) parts,
however, were left packing data at the wrong width, producing corrupt
buffered captures.

Fixes: 6c3e7265734b ("iio: adc: ad4080: add support for AD4084")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v2:
 - Expand the commit message to describe which parts are affected by the
   wrong packet format.
 - Add a Fixes tag

 drivers/iio/adc/ad4080.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
index 8d2953341b15..8feb0c7f7fcb 100644
--- a/drivers/iio/adc/ad4080.c
+++ b/drivers/iio/adc/ad4080.c
@@ -698,6 +698,11 @@ static int ad4080_setup_channel(struct ad4080_state *st, unsigned int ch)
 	if (ret)
 		return ret;
 
+	ret = iio_backend_data_size_set(st->back[ch],
+					st->info->channels[0].scan_type.realbits);
+	if (ret)
+		return ret;
+
 	if (!st->lvds_cnv_en)
 		return 0;
 
-- 
2.43.0

