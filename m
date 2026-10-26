Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793055967;
	b=P36HDGUOSfKarKP1ggqPqSUkSCNsasDW3+OSzlsoxFYulRrET/aIY6FqaljDHiY7Kmdr
	 FQWCArojjM4wmNhbjrSwUyxV0BkhpBO1aEf2Z4dUFlKWJmAGwP4KR6fs6D+BH7uBm+wGE
	 4Q388sb6IUEdUS6NJKZ4KNZC4b0oxf+iXNQe54Fefm3uFAZ4BGDjus2kDAR6aEjFXENN7
	 tMeOgEmCHHWNMuC6rB7bSqhk5flhnuKFyi/L3STU4cjiBCoS/3YFlaxclp2fHajmLWEZw
	 zreqIrCOxxVEK2b5v7WLqjfIZX7iSUZRxb9boZHBpW55Bk/Ke0+O/IazRV9C2gfllEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055967;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=z6rpwOUEK1DAl9rEbu02MT3gWJ+0GYPIaYmAUiVtivA=;
	b=npEIqRGbPDDI2ivnjCSXWqr+9rlm+i2uirV5qxKgM2EDNRMogVKnFu5B9MsMcS3CAoIz
	 p/LcCvTS+4r15RGdDALch6D4MlhmXzkpKAPxMKLMo9GsjDI17vZAxPaUERu6eK4b8tNRp
	 NyT51cwzeEdyshBMrOZwrqR06OFI+tuwhBVuil7BQEthhnn4hludJJ1a+ItBQyZYFdqH5
	 T68E+OEw7S/WCRDWRW2SsjiJTjsYvi2sSz67S0NzIwZC9Kl6EjTKbMeQN1w1K4Yrtn++o
	 DlYHiVhBzU0oHHOAVwiUb/1L3Sf6qyOHdctJPbGplgtVzFKWWQzaj2l9b7OGHJ0bMxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ETmuIwYT;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925EA606A31D
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 23:06:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 925EA606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ETmuIwYT
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QMOsat1439438;
	Mon, 26 Oct 2026 23:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	z6rpwOUEK1DAl9rEbu02MT3gWJ+0GYPIaYmAUiVtivA=; b=ETmuIwYT/RpULBlR
	LKIP7/bhqWebEyJr4Wcz0eIiJurIjujrwPIeyIJj/sQ3a4/WafqrdUBUcZro/J+q
	+fvB1QKKAaP9NQmA+a8Ekm3MavJHk5QhlFN2BYk+/dgYzceBemuhO/TTw0+Ov23G
	9EzBcJgVNQELF0Ph0Pn3mB4sm12Mu/EM7KrtcGbIGHgnk7cjUcMJGpzkdaACs5Xp
	of5jI6cnra6V8ALVsLC+755LXouZ+Ms7KVYUtyFaC3AvqFnEOD/2/jQn44rWWE3M
	B122fSjmH/VWVBXwzkKUSnUWHS8zMUlalSvNjuHw8y7UUK7Z8m5eoeERNQ2Fk/Nh
	UW5+wg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj53q2qnq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:02 +0000 (GMT)
Received: from pps.filterd (nalasppmta05.qualcomm.com [127.0.0.1])
	by NALASPPMTA05.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 69QN5A3Y167182;
	Mon, 26 Oct 2026 23:06:01 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 69QN61sk168679
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:01 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4846927)
	id F19FD255FE; Mon, 26 Oct 2026 16:06:00 -0700 (PDT)
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH 09/39] iio: light: vcnl4035: use iio_push_to_buffers_with_ts()
Date: Mon, 26 Oct 2026 16:05:27 -0700
Message-ID: <20261026-iio-v1-9-8b136778eedf@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfX47d+ZftDIAO0
 HVTXbJwokmTZXzN76YshlZqJdV8ZwUClc42Qc4y0uyz5X2w40/bXacmoPFU1oRoN++S86J77Wpp
 I/4GePgMNDeE/rnkREF3gKlarSRY8NI=
X-Proofpoint-ORIG-GUID: NJw4aYOegatp5d3nzFSzRaOTNIkzkxQK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfX1PcDXgXGqdDw
 WgnWj+d7XJ0l5ErXC7FwGEuWzDLrUZLarJz9QcTTcnIfJ+js1yhEmpT2bSscYvBiipi0AwWxMIY
 uw7BVNIepDmlCaeRRNtqvqff0tG4HRg0V8jU82d86ozU02McdWYN1gXzDfhryjQ+7a6ONqcBaCM
 yF+vLG+SyM4fTRbdUkPAYkDPpOouT/SMGtwqHGhydXaHiZljVVAgrQcibMSKvPKXyALZab/fhsK
 RCmzvP1IbmXg0/SeBjprrLVlYdIE4MHLTfaTi1iJeWjcJASTtajcPS5qayme/BxbnQ8mVZPODfa
 DiAJ4WL3CIOG7DW5yiMG6b4l1ZxwKgxOzMb44mUXJp+ED2q+JxY+I/VCpCkCwJNg2xq3g6UlpTE
 ce/zXJm4w2ZeAGTh17Af2s0nhiaTI9xEqHTw4N5MuVdLU5Vtsn6Mxh8DxH9wwK7gemoNAAMNSex
 aL0M+6CcrcrcsgMqr+w==
X-Authority-Analysis: v=2.4 cv=D93SufRj c=1 sm=1 tr=0 ts=6adfdcda cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=8BzgmZaioEoOlyBWVq4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: NJw4aYOegatp5d3nzFSzRaOTNIkzkxQK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260092

Replace the deprecated iio_push_to_buffers_with_timestamp() with
iio_push_to_buffers_with_ts(), passing the size of the pushed buffer,
which is on the stack and local to vcnl4035_trigger_consumer_handler().

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/light/vcnl4035.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
index ce1bd42b0c7c..23bd0d42363d 100644
--- a/drivers/iio/light/vcnl4035.c
+++ b/drivers/iio/light/vcnl4035.c
@@ -118,8 +118,8 @@ static irqreturn_t vcnl4035_trigger_consumer_handler(int irq, void *p)
 	}
 
 	buffer.als_data = val;
-	iio_push_to_buffers_with_timestamp(indio_dev, &buffer,
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, &buffer, sizeof(buffer),
+				    iio_get_time_ns(indio_dev));
 
 fail_read:
 	iio_trigger_notify_done(indio_dev->trig);

-- 
2.43.0

