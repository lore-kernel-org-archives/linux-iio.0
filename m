Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793055975;
	b=poqcvuVwXS0EMw6CQfI9mIcHaq25dPJtUh/ygDMiu2Gdym0PivlPtz21QdpbzZHLoxov
	 ygXXOWRdNuDEZ6POSCP+8c6zzuxRvpTJ1Hw4j/8OZLTfeiD2XPgau5OABfGYLlx1vlWhO
	 XcjG6vUzPxdAdIcLzuSlkTORzdpv/HzCh+NjFFp0puL7FMJK/GzIVGwsjEc/OyK/HtZia
	 AV/aX7KjnAGhveOBBNoDStMTSErQo/QT7g6GNndu7++GA7flN3HzN4N9z0Wh1rZ7qjgws
	 5Vh9eTePscrG3HvpY97uY0aG0wONaylulUz0K4MS2eSQGQVI7XGNi0Oq4muUvfAWAjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055975;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Gc76cFU5mV1WvC/GlmLBT0XhrT2AFTu8YqIXob6cb2k=;
	b=FsDUfuEkGZK4zAxb43eHw80lm2N7TTU3EhJLD6pIpHRBFu4gRDaf38ObkWlzYTCwgajn
	 lH0BlXcXDiei4I0eEfI+nnBsndnS7BFThdGLLwy7xrZfNdve4JZTkrvyT0I5e4FGyM2MB
	 axAvRNqs81Oj950UDYigMRBRjVo7d71M1/yZ17Wxm3j61nBFxPsv2+jVg6y4PpZfbGVv3
	 N8RCIarCgiKXL+97Q1pir8O65AH5v+EIaulYLYRY2kKHDMjggqR7ISimSqdryxEpzGpzK
	 qK7u8gKoQQWjbocm/eqHnqYF0xuVhwh54+6vHkOIJq232TjxoaxcBBSRJanWWoF3weg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="BcMWd/MI";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4D9606A338
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 23:06:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B4D9606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BcMWd/MI
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QMOqae1430437;
	Mon, 26 Oct 2026 23:06:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Gc76cFU5mV1WvC/GlmLBT0XhrT2AFTu8YqIXob6cb2k=; b=BcMWd/MI5Ul1r7Wt
	pjqPXNf9igGHoa7cGUZXwNFGyvTEvOlhaOIXzlrOuHB/B6tSoX32TzqqEw/6a92o
	27I8AGPdQi4CGSbJrY+LWi1KPFEEeq3Bt+6E03eU1/XuIA6MKjUmjoE4GfLxmTbZ
	9/bhGhm5qz8b6xaxpWzT2mwQMk4OonuctOBjqL0fRCYD7c1kF3AqoPzVF6AfC99H
	JpXxt9X6oEZlYOakfpWW3ekpZcjJpKFpAcvZdo4mKfdiCgiCiGEH93M2Jj1/eGCe
	j1EhcO8l+GqBqKxoi//e4GB117Z3CqCE2JLz4xOxwknhaVDEVqnY5HXndxzQs5q+
	OKWajQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hje3d8d1u-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:02 +0000 (GMT)
Received: from pps.filterd (nalasppmta05.qualcomm.com [127.0.0.1])
	by NALASPPMTA05.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 69QN5pf5168537;
	Mon, 26 Oct 2026 23:06:01 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 69QN61AK168687
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:01 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4846927)
	id 1BD9625613; Mon, 26 Oct 2026 16:06:01 -0700 (PDT)
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Jianping Shen <Jianping.Shen@de.bosch.com>
Subject: [PATCH 14/39] iio: imu: smi330: use iio_push_to_buffers_with_ts()
Date: Mon, 26 Oct 2026 16:05:32 -0700
Message-ID: <20261026-iio-v1-14-8b136778eedf@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026-iio-v1-0-8b136778eedf@oss.qualcomm.com>
References: <20261026-iio-v1-0-8b136778eedf@oss.qualcomm.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.17-dev
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfXwje0giBgkV6b
 ty8tsvaz07ztInnbeWCn3viNaaWHEkivpTKke1gilUk3zDRGAXUHK41HbTshVcB9ChtGZRf+FLn
 HShINPQ6iWT4DaKMseNCBWzm6nFPT5Q=
X-Proofpoint-GUID: HwU3S0wcETh_MUpgqAyQIy7-jp1q3pod
X-Proofpoint-ORIG-GUID: HwU3S0wcETh_MUpgqAyQIy7-jp1q3pod
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfXwjbvFVSxGErd
 t7Sly+ajN3iVV/9dgHmoC613oN6bR/NwJt+0gwWN5llBGv76iSNrJEQLt0eowZ0zVYR1T2qEvUG
 8cyXrhdcpzoPcv8kdoDweV5jvKOkyAmsQc6/fvd38wIdgugesaEoixzFc0mgLs3PirEqARv2YDY
 FWZNoFY2qS8MWPmMunC8zUJNGYiZZi3i63w9WoQnxBWFbCUSxRKEB+CwaS5pNnAHxnceI95JsF4
 PGUBy0gVjB/iP7zT10jEzRjQ5hLoDDBJpmCl+cMjOqzdHPBStQuse0FZMMgu5RGZ4LpJri44eag
 fgVJfAC4G993DvF0BciotJjoW4yHujEWQ2VB/BcmhIFg1rU/d0Pm2QW6wYSC8h+xgBKIdkRlqUf
 oqQ0tPFgQeIHNQK9xqReajcRNxezJqT3ztJqVyJag/cQT5Gum2aZhu0loseHsd/RHG6AUchjKKS
 t2j/9EJCNUNFl4fy3Og==
X-Authority-Analysis: v=2.4 cv=SN/Xx+vH c=1 sm=1 tr=0 ts=6adfdcda cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=hVcwujEvAAAA:8 a=YPRX4qLdHzuC1tuK5o4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260092

Replace the deprecated iio_push_to_buffers_with_timestamp() with
iio_push_to_buffers_with_ts(), passing the size of the pushed buffer.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
Cc: Jianping Shen <Jianping.Shen@de.bosch.com>
---
 drivers/iio/imu/smi330/smi330_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/smi330/smi330_core.c b/drivers/iio/imu/smi330/smi330_core.c
index 7ec5ae7f521a..ef7f00825b4a 100644
--- a/drivers/iio/imu/smi330/smi330_core.c
+++ b/drivers/iio/imu/smi330/smi330_core.c
@@ -628,7 +628,8 @@ static irqreturn_t smi330_trigger_handler(int irq, void *p)
 	if (ret)
 		goto out;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, data->buf, pf->timestamp);
+	iio_push_to_buffers_with_ts(indio_dev, data->buf, sizeof(data->buf),
+				    pf->timestamp);
 
 out:
 	iio_trigger_notify_done(indio_dev->trig);

-- 
2.43.0

