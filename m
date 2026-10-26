Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793055975;
	b=nVmzCrbPw6Lq9fUnw8ZfsSoc3bFfX47haqhRvARzCqUf5gPCfTD82V/uKpExhen54YEU
	 Ciev0jdvkUddLh4wh1TaIgNQee9ZmT1/d0YrDm83xm8q6ODTrE4XVDtQD5K4X51oqAWcv
	 FOhRfp7o5vVlxTODiXwhvgGtPeLSWUmeb94IKmJ5FOHL8NbbD4Alvu9+SeRiqCYSvPYum
	 2Ly5bTu9TfPQaVfb94AJzBvxgST/NT2N6+rskINEbIoMYf4n4C3O9UtzHq0XkhnCwVHC8
	 706CCALUOVHc45P5B8HuNJ+KgD/JW0MwjvYv+mgJonGDc5kXvdm4WHbLSKj+YDMSnVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055975;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Q04oZfw3OjLDZgUZRGcxNy1JfSRYfzVtpRaBDOhbG1k=;
	b=VPU8JE4+SVF+0blRKzwvi72Ln6BtE0IhcrPhITOn6nLW98HToNUE3FVy+tb3AxeIZiHm
	 2vnatcCaKd68YNowJrpbkqU5LLopv8Up/ZHrJl+HqSZ6JJ0oY3hIEvALesTNq6AmRWK3K
	 BrLSX/chfKzElUyd2nAxyRabuMUaONd2QaLCaBDliGFMWyJVeweMI/U2drUGVKAtqGHna
	 9jdMIjk07CxJnanZ9r8X0ruY6+vWd84tHaxdJrmc6w0x5nW89FwtKVn61JwqBrL7Yx9GQ
	 qMkEUSHLKli7qKXpS2QEdl+6aj/nx2Hs1EmuSVSZN+02UGATK43dAnNlzvYjvcs/F3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="Ofz47Z/L";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48A7606A31B
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 23:06:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A48A7606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ofz47Z/L
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QMPE753042727;
	Mon, 26 Oct 2026 23:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Q04oZfw3OjLDZgUZRGcxNy1JfSRYfzVtpRaBDOhbG1k=; b=Ofz47Z/Lo5hkm85l
	WP/Cx2XPDPeR4LlU76PHiTIRTYCwGnEVCaOtn8y5Y0VQGixKIQoAwkevImMxeNf1
	ciXsZhyxWerMBSLF4z6sZ26ErvQdl9O3WNw2frKWr4yshUJyjLMr0M7G0opvQ1Sk
	0jRtBxGLObS0HQuRM3BwLVqzVr/60AkB23eglaSb+Wz4bVk0r2kkQUUWy5ai1lhl
	b7QDbVXV0G1pYC1Nss1TqR4wq1ES5k6rvcJqzsgqwvjCwaS+4d6IvIKjOa+3AO2j
	ub2EtSruZiqHxGrEtu1EkEZVXyXfCfRgnm8diKr8czPwNCHBsq2FGhoGslspeZlF
	QsVBRA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjb54h4hk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:02 +0000 (GMT)
Received: from pps.filterd (nalasppmta05.qualcomm.com [127.0.0.1])
	by NALASPPMTA05.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 69QN00sf158309;
	Mon, 26 Oct 2026 23:06:01 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 69QN61kl168676
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:01 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4846927)
	id DE8B3255F3; Mon, 26 Oct 2026 16:06:00 -0700 (PDT)
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Cong Nguyen <congnt264@gmail.com>,
        Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH 06/39] iio: gyro: mpu3050: use iio_push_to_buffers_with_ts()
Date: Mon, 26 Oct 2026 16:05:24 -0700
Message-ID: <20261026-iio-v1-6-8b136778eedf@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfXxzU5PnHIRPt4
 3SQyIuBXbN+v7WFYLi0UtxutVICnB44PacHIzRZ1uDmeaTZMFQMPmoIvPmtRqAVfkxA5s57lJe8
 WTIXJtChL4tF5K47u74nM/APw8thK1o=
X-Authority-Analysis: v=2.4 cv=bsnZl0ai c=1 sm=1 tr=0 ts=6adfdcda cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=pGLkceISAAAA:8 a=TDnj59O4D6Hfr2lGhU8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: RSr36jmlYkezhlCJhU6qkqIxahWkGa9v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfXxu1ItrGVT0/6
 FPCSQoY6gi5V7TGko6+CqbXdE0J5xuTnKJsSvTA03NcRIS+AaSkRQZrZ0vv4bLgsC0xWmyRclqi
 wfrd7KfufVctRJ5r/bBNefLBj24BqJKmjfmoQuSQNctGx0+09z/yOcOP9xJNovF4ShKrRYYZ4EK
 dtA5NI3UP8H10r+MBtnYO5nDP+NJRDGeUohMgsQ4ZZCwwV6Qxdc+YU2F0RbkxXi59XqihbeQ44H
 uLWwrnOhG+KJctQRyEV1vyoMOhUUvNmOjFBdY3+AZqBWeNZB88Yfgiysss/KUkQCY4m3EF2YDI9
 2lG0P1LqSgqrn4jG0hlMFUEBR9/A7EuMdbnquLABPqEu1FQZ/K/0NByWDv6uLjcrfS0f190utNF
 2IYsloomKtFBcMjFg4GaCoszKJ2+YcGXpNRPgaXhdhghNfzXcrnl5ARph/nJZd4XEH0C2D7gjP8
 dEmtbjTOkHWzc2tVz0w==
X-Proofpoint-GUID: RSr36jmlYkezhlCJhU6qkqIxahWkGa9v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1011 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260092

Replace the deprecated iio_push_to_buffers_with_timestamp() with
iio_push_to_buffers_with_ts(), passing the size of the pushed buffer,
which is on the stack and local to mpu3050_trigger_handler().

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
Cc: Cong Nguyen <congnt264@gmail.com>
Cc: Ethan Tidmore <ethantidmore06@gmail.com>
---
 drivers/iio/gyro/mpu3050-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index 07c0f9011c63..f91b1173c2a2 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -637,7 +637,7 @@ static irqreturn_t mpu3050_trigger_handler(int irq, void *p)
 		goto out_trigger_unlock;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &scan, timestamp);
+	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan), timestamp);
 
 out_trigger_unlock:
 	mutex_unlock(&mpu3050->lock);

-- 
2.43.0

