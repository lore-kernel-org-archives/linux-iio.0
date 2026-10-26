Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793055969;
	b=N1X11pAXLq9m1iMdZeDC7sJEdGjtC1cqKRiKoELxkr/kxA7c69gOfnOC0ZgC3aoxC1dt
	 nq9EqiQnv64LeEQeFGBoue0HCItD3wK7i8+5eeGB4vO4+IN5kTP8H+sUixQQaIoJwsSmt
	 zpw+5ZvDR+xsNB9VrIbReo275UHII0XeB4wCNhejOueFHN5aPivoat8sSL/L5OKD4ClT1
	 BkN99aA2qS0NOLkacHSdCmy9Asb+l+KG3AL4XggTgn15gYSOY9BW6pqMEnAgPqMzFp138
	 8y9DTHFzke8P+Y0hfNCwCAVkcuyfF7zkifbEoAkN9wmsjJNzC4JzaFV+61ZbqwfFgcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055969;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=jwac24CApW7sQS2xXdqcHCn4BrZ8CU38scJ7szmeS3M=;
	b=oudv5KuurFtk9M/cemtlJEsWWWopi1Ai3ysfV9Y8CMgDPJ7tGBwvv8tINXDdjujmEnyb
	 E/LAUK/OT+uqCPdvOc50YFzoV3xxRC9tgE1ljhZpzRsIi7wdvs5F1P9WRx4ROsdlM6eMj
	 DuS4ctaSUD22mDFEiRp2zQA4WLMSazM/aHgP3sqxkJgKHOrXNHzqm+CMcK7PJ7rtzalIr
	 qOJ9XTAf1XtilAfclluV0Sxaj3uFu6Bpq6tZK8KyGe7D2ird1OOLmvfbs99kglmRPrulW
	 fPpOBbwkvhSb7lTwKEG+Kjyw2N/fYSB7LQvMfFmXrlCdmNIslrxGGbkyTzKoXBHszFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EYrrS8n4;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9EE606A32D
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 23:06:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D9EE606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EYrrS8n4
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QMP9jc1431506;
	Mon, 26 Oct 2026 23:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jwac24CApW7sQS2xXdqcHCn4BrZ8CU38scJ7szmeS3M=; b=EYrrS8n4cV4BvHkn
	tfw++14r2xk3cGL92zr/HZ91LPM5WIo/doLlJEySpqB/6sGv1SFP5JIfYXl/fp8c
	wp62AQT3Wsdbsx+8ofQIO/ur28lbe+HK7WNfUfF/2CJBNp7pUhhKpMSQZyadeIkH
	t6PANlYigAeK5tYZQO5cbgibxIW+ilum1p7qvHiqmHKbWNKL0OyMlTCyixLYhHaM
	CGo6kd7E8E5iM3k2Kc+P8AM2ytIkW2UgNyXX/XZo/e3nPoEqahF5tzZchcKDuIf1
	PcYpItQULW8+v3wbYgd7j2WHnxLxhtdLBe7yejNd8W3obHmsaSGJY1jEPSJpHKLA
	IhRreA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hje3d8d1s-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:02 +0000 (GMT)
Received: from pps.filterd (nalasppmta01.qualcomm.com [127.0.0.1])
	by NALASPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 69QN3xCC101330;
	Mon, 26 Oct 2026 23:06:01 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 69QN61WW104531
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:01 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4846927)
	id 32DCA2504F; Mon, 26 Oct 2026 16:06:01 -0700 (PDT)
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 18/39] iio: health: afe4404: use iio_push_to_buffers_with_ts()
Date: Mon, 26 Oct 2026 16:05:36 -0700
Message-ID: <20261026-iio-v1-18-8b136778eedf@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfXzLW7wHKtM3NO
 dceZxVg7OfD1vBQDu+Rz+8gafTXuLPea1FmpIsswwAyUJbCYRi99AK84vtL6TX3jxTLOvO/9ejn
 U1gMwnlCf6ytKzH05s2Wqfm15LSm8CE=
X-Proofpoint-GUID: ZSKHl_T-VF3s0BlYx4iF6QB9GbE7BrwX
X-Proofpoint-ORIG-GUID: ZSKHl_T-VF3s0BlYx4iF6QB9GbE7BrwX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfXzcEgTVnkpxcA
 LNFe11AEw3ZTElrHXuRLoL4vCryaVkl0n8oEPaIG1aNOwUPwUGIXsMg729xbw0Qu6tMGfD5PaT5
 t1m/Av6MqPuBc126zLY6I7ABUcWKs0ynbagcsfFg5WsJX6G0bwTcx8fkguzcz4VtREYgje6PKtf
 hBpLOQnOkBGPDg8GVe18+y4jx5W3M+roey4IKNyPrHn/LDZFW5s2TPhnRylv18iSciHfGdlRAvm
 FIRtfdBzen3k8szKMfCexJQOC8uzW+XTlX1hCp0u5OhYEqzmURP4P4O5wiP4XTDEnHYyXjUUI3Y
 lf1U/DvbDh+CQ+DGDijTncwfpkZ+bLMOmTuSRAXuCIKnspGgzWdXQobWYyNPGqC0UeOMuv/ylfg
 CxFrZxMaGkQmMHl582U1d/Ij5lSf2P5SfGMO6+KyYMOVSn6nVpoZxiG5kkdeoAXZoGgfY9eGuXM
 4GWEFY8fzSr8c2spOHA==
X-Authority-Analysis: v=2.4 cv=SN/Xx+vH c=1 sm=1 tr=0 ts=6adfdcda cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=sozttTNsAAAA:8 a=PmcevWqu-hvqv7quII0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1011 priorityscore=1501 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260092

Replace the deprecated iio_push_to_buffers_with_timestamp() with
iio_push_to_buffers_with_ts(), passing the size of the pushed buffer.

The pushed buffer is never a direct DMA transfer target, so move it
from the per-device state to the stack. Use
IIO_DECLARE_BUFFER_WITH_TS() since the timestamp offset depends on the
number of enabled channels, and zero initialize it.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
Cc: Andrew F. Davis <afd@ti.com>
---
 drivers/iio/health/afe4404.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/health/afe4404.c b/drivers/iio/health/afe4404.c
index 22cd46eca217..561b563c98d5 100644
--- a/drivers/iio/health/afe4404.c
+++ b/drivers/iio/health/afe4404.c
@@ -82,7 +82,6 @@ static const struct reg_field afe4404_reg_fields[] = {
  * @regulator: Pointer to the regulator for the IC
  * @trig: IIO trigger for this device
  * @irq: ADC_RDY line interrupt number
- * @buffer: Used to construct a scan to push to the iio buffer.
  */
 struct afe4404_data {
 	struct regmap *regmap;
@@ -90,7 +89,6 @@ struct afe4404_data {
 	struct regulator *regulator;
 	struct iio_trigger *trig;
 	int irq;
-	s32 buffer[10] __aligned(8);
 };
 
 enum afe4404_chan_id {
@@ -330,16 +328,17 @@ static irqreturn_t afe4404_trigger_handler(int irq, void *private)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct afe4404_data *afe = iio_priv(indio_dev);
 	int ret, bit, i = 0;
+	IIO_DECLARE_BUFFER_WITH_TS(s32, scan, 10) = { };
 
 	iio_for_each_active_channel(indio_dev, bit) {
 		ret = regmap_read(afe->regmap, afe4404_channel_values[bit],
-				  &afe->buffer[i++]);
+				  &scan[i++]);
 		if (ret)
 			goto err;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, afe->buffer,
-					   pf->timestamp);
+	iio_push_to_buffers_with_ts(indio_dev, scan, sizeof(scan),
+				    pf->timestamp);
 err:
 	iio_trigger_notify_done(indio_dev->trig);
 

-- 
2.43.0

