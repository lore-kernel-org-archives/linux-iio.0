Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793055970;
	b=gU49tS+MAB6B4nrAUJ3pp2cdp0wZVQ1Hufd3fzCxkABdv9efFG39EIXbjsoxC6OghzMM
	 X9qxBp8/Go6Ax8BRK3PwFlKXYLg7bZ0/gzpVcrr+Em5iUHDTpGtFK3rm/Wa9nUYbE4Paf
	 H3CQZPGhbdQ6lpJh6QDYG/AEPS3zRJx9NOj+xpGC++u5o6ZliGq/Tm3AVWdc+2nnXV4P5
	 hAPW1qNGkq9Gro2ySj8j1/DLe0vQ9jgWVuosacIfj3kMwiAcSr/h8nWrcmoEmYOF0gdBP
	 OkHxkdys3TOp/nG8mB7PDzUMvAstx7iHaVvtjBe3KDtrTiERIeb+c3io3vui7bCeVIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055970;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=V72pinhcf4xq0ufjj9Qfvr3Y59dDXTJliIWIi3TQLss=;
	b=DIMkc7CwnqJitMfmgBRi9Vh8esM+4xWa7Z7lfxpHPn5S4ZmWHRAUxKFwIseKOjEwD5mn
	 YyCoPexAGtBsf/bq8eIEwAS9dxFZcoY5z9XFyTGuvW40lZVGVWr1W/teBQotTnILQ4wPW
	 uS6G0eaO/w5pGoaO+vzkqPrKu2Y/XZfwaXMCwNz2JO8m6vdRvQG57+Vid4V5z2llfME8z
	 QKIOU95fP1K37VxBnZ1/kGXtDE8jeQX6XhfieeUzNjrDV4Mt7OBagJ7znWa59V3VDqn5x
	 d1aXkW/y+hCsegZb6zTlIFH1KMR1KsZoE2mOHVkPDzF6kXvl9uVinD86J8bJpxdlT4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=o4nIuKDw;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A219606A32E
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 23:06:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A219606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=o4nIuKDw
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QMPFVR034820;
	Mon, 26 Oct 2026 23:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V72pinhcf4xq0ufjj9Qfvr3Y59dDXTJliIWIi3TQLss=; b=o4nIuKDwL1R7gPKN
	lZk/XRqJeUfWNntUl2A77Pg3X1d9+BB4zgMjrGUqwgIIE92kmNe97bxlA+86Aa4R
	WWCTusXY+TwwLBLwm2tCKk4jNIy8sIvKkKcjGRMjp8BV/jWT/5XsGUDsOcmzrB4n
	sNZAMcIIV37jSvrEBrUuJ+qXx3evh9h/KGsoKdAFHZR3nsnVlTmA7VxYwvyfvRJu
	a/0z1HG7qR4I9m7n1GahUUfpshYZcJGSKTdlQLApMQY1auEGFV1cHXQa421Aitfn
	Rqzsz2H+q1q2WvBV4rnvnGvT8MFrwNKQOrv5fqrKdfhQWtqbBtKo0Fpd8Mm3FUIv
	/pAPyw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj4cpawu7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:01 +0000 (GMT)
Received: from pps.filterd (nalasppmta04.qualcomm.com [127.0.0.1])
	by NALASPPMTA04.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 69QN61rx186495;
	Mon, 26 Oct 2026 23:06:01 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 69QN60n2186467
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:00 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4846927)
	id CB20F2504F; Mon, 26 Oct 2026 16:06:00 -0700 (PDT)
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Jonathan Santos <Jonathan.Santos@analog.com>
Subject: [PATCH 03/39] iio: adc: ad4130: use iio_push_to_buffers_with_ts()
Date: Mon, 26 Oct 2026 16:05:21 -0700
Message-ID: <20261026-iio-v1-3-8b136778eedf@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfX/TdtfDUrtR6M
 ov17RVGqq96F832PJZEuAsplGe2q0iSMYE3gSQTGIx6hNpL4cO1Zr1coY/UoDa3BDyzj/izi31I
 MOjPCmmakYjETikxxWWuX+B4vuQ784VDJFAJHpUXV1sJ4wpl78dU2Mf8UNYZmTMiPSrJbNvmfYC
 0aVY2RHFz1wx4BBaanvN68Tysoz+9FjnxEqX2A0LiaU62A02gnAcejtepDfzN6UH/cHsjEBfENQ
 DmX1HL2+fK6MRnPgvq+J20rEzsP1WahNWKN7PKx418VALTgK23W3NiEn5u4GbygpNLHoVe0byhK
 2qz3ZKdN+RngazS4EAbRiu7442qliafKZyAyhQDCrSGCeUeHmXcLa2zcPcYh4iimxsweZ2QJ8Kc
 HIsmCXj42cfgxiaFIk2+Vk7GoSe+UMhq6N4gLSQMApll3PX1UqXzXik59xmGp0embMOTOQNgpZj
 w7SvLv8hAfdhDTbgAjQ==
X-Proofpoint-GUID: 01sj8BC-nR4is-t1pwTVotj44U16Hz0i
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfX5mOaUKNGPkYz
 JqM4TvUTplNCexNiLnazZmmI48Mvgetw1XnA9e1OpvvNd7l9slOptJh/iPBESN6i1FAFxUBYRMA
 YR7XvO0Jb01REP3jeohBIGrp9J3njCU=
X-Proofpoint-ORIG-GUID: 01sj8BC-nR4is-t1pwTVotj44U16Hz0i
X-Authority-Analysis: v=2.4 cv=TboDJhQh c=1 sm=1 tr=0 ts=6adfdcda cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=gAnH3GRIAAAA:8 a=3EzvfgzFHwXhTwWFh5sA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 clxscore=1011 adultscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260092

Replace the deprecated iio_push_to_buffers_with_timestamp() with
iio_push_to_buffers_with_ts(), passing the size of the pushed buffer,
which is a structure within the iio_priv() data.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

---
Cc: Jonathan Santos <Jonathan.Santos@analog.com>
---
 drivers/iio/adc/ad4130.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad4130.c b/drivers/iio/adc/ad4130.c
index 3ffc4b765e0e..9763a811caa3 100644
--- a/drivers/iio/adc/ad4130.c
+++ b/drivers/iio/adc/ad4130.c
@@ -704,8 +704,9 @@ static irqreturn_t ad4130_trigger_handler(int irq, void *p)
 	if (ret < 0)
 		goto err_out;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &st->scan_channels,
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, &st->scan_channels,
+				    sizeof(st->scan_channels),
+				    iio_get_time_ns(indio_dev));
 
 err_out:
 	iio_trigger_notify_done(indio_dev->trig);

-- 
2.43.0

