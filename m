Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793055974;
	b=NQLSXR8nsXKSt/JI930KdL6XAZhMb6WNnVCcy78BEQRfxph29eP5KgmP76T+w2UB79pE
	 TiO5/olRwaaWzNRGpN24Vcw5fhLygX2jJTfaTjCrvG0OKqEQfS3VGYDX+gVXs9ojzY9bQ
	 SnWp/srFyCNuDQuIx4PkJJd6KbahNGMGJDNs58fab4Ko8HpJtY0pFCsBgANvjJllES533
	 8Dlv159199RoxcQ+chcX5EMApuS2d0GMeh2xc4vfGIcNOwkDxf2+LLQrk8TSnh04jvmhl
	 m0lXoAKH+64wx3v3tNd2prvV7sWCloqapd7oWDnjAqjponkUBO2ov7nFkouICZbDGgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055974;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=WRMA9EoCYjkUjUGTJqru35Yptva0h0ihJ5VsJvyLI2w=;
	b=Slx7ez3OTH2Xlegvjh+ihijhPukCtTrh7b6hArAi7/CLdmFQAODX6JSwEaLdcs2ZhuoP
	 OThSPPHROoqYWfoIgtJsHR2tNj1Q3Ga02VRbloMy+O4JKzpsTmucdkc2AduCnoB2wtmq2
	 TQGHz/1HIJVxnR/QKdA32y59LVgZqXxalLSqFaDDGxVJfR8m1OP4xmxtcatL3dHmLP1C4
	 DhNoCGX3p6VEzbHVeH/WpRDe5VD4Zpx8Hq+5rnwaJzW80tQ6BI8OxSJ1loX2ZwSAMIk6k
	 bPdZLmPBAB9YiVbsYUiWOKACtnSBpudvAN/Ot/NS50WeLtM1gTjjyDEIpLkQLAnZkzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="cFJ/nT0y";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2BB606A31F
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 23:06:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F2BB606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cFJ/nT0y
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QMxwvM3112691;
	Mon, 26 Oct 2026 23:06:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WRMA9EoCYjkUjUGTJqru35Yptva0h0ihJ5VsJvyLI2w=; b=cFJ/nT0yrCluvosw
	/+UoXc5Lpv5er3oo9BO5bMWS1pPcLEpVVNsUSnGwMuA/XTUyixSDcPsQZeExYMLK
	bagZsAnqZZUvlnf/HgOp0AqxRuYKCndtmu8f2Zd+f/XTNa4alrxcHvDDxdS7ijAc
	kDIsCcMxJZe9Xcqejwl4C/ugwZSIPAhU+wM+8jdGYRQ9aMQeT6e8HknXTwmEDfAo
	qxSe6dz5wPEuwdOa4ZwwlobGca8JP4BgB2UwInz2I4QaKsEapWCyzpKhPpv1sOBw
	OLczNVmfSLjgYZGEHGGiNUEzjqSPgYP085gLTjJi99dYHy9LyF4h90Tp0xBbJcgz
	Z6c+Pg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjb54h4hu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:02 +0000 (GMT)
Received: from pps.filterd (nalasppmta01.qualcomm.com [127.0.0.1])
	by NALASPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 69QN61HX104513;
	Mon, 26 Oct 2026 23:06:02 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 69QN619r104540
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:01 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4846927)
	id 52D0C25620; Mon, 26 Oct 2026 16:06:01 -0700 (PDT)
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH 23/39] iio: adc: cc10001_adc: use iio_push_to_buffers_with_ts()
Date: Mon, 26 Oct 2026 16:05:41 -0700
Message-ID: <20261026-iio-v1-23-8b136778eedf@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfX5BTJ8YmZMALF
 rzvVXIrDQr/468eh2OKAAuETCf5nl5YL1FewmHcLr3OoyUnCcU7sHnhjOwXFc2CnCusxgjWx+v1
 jJdnlmi/zHl5u8Guk2l8aM4vxi43+ew=
X-Authority-Analysis: v=2.4 cv=bsnZl0ai c=1 sm=1 tr=0 ts=6adfdcda cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=yOBmZFm5iA8jCHl1I3wA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 8a0n1q4uBy2kqU7YjfzukVAGTD7jpVxr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfX4Q1mRm7TC8h4
 jRrq/fwlL1rUzDAGe78BgeLS6F8GUQPeWwxWCtto1hIAixWSOsnAyY0aAZe1nTSsaqinVt3l1Vd
 C1V4bLaC6YI9mKcaXLNxImFCu29a3n7ywNWSyw3xm8+R0yOLLz+rw4eZusqv8xb/ipoCtxAsjff
 Tg+4EYAoTBnXT557VnYYFq8nfaVN7nKZLFq2Knlkh090FPyVdb9gt9N0gnb7VI3VJVuFk00cw5D
 IArmUuO1Onbs7klJ/w96AEkVTK65E0GOEBuwS8vTcEn70srYhrnDqGr0El75riR+E5MT673Moxa
 jCHi5N9QZdztckY/tt0j3aPnYp3VQAV9tnfmlcYo5dgP2MJdbmrMmAm7CzN4zfQO9fpp7irc+ou
 Jor5zqJqehrlVEvy7vW31nV1VfIMc1aXbJ87xuQWVY5hcYyrwyPKyyYG4FvnkMqB7+j1qfwD0zk
 YMbPTe5u79jFj8Ja5RA==
X-Proofpoint-GUID: 8a0n1q4uBy2kqU7YjfzukVAGTD7jpVxr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260092

Replace the deprecated iio_push_to_buffers_with_timestamp() with
iio_push_to_buffers_with_ts(), passing the size of the pushed buffer.

Move the buffer onto the stack, local to cc10001_adc_trigger_h(), and
declare it via IIO_DECLARE_BUFFER_WITH_TS(), removing the now unneeded
update_scan_mode() callback.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/adc/cc10001_adc.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/adc/cc10001_adc.c b/drivers/iio/adc/cc10001_adc.c
index d42b747325aa..c7ea718305a2 100644
--- a/drivers/iio/adc/cc10001_adc.c
+++ b/drivers/iio/adc/cc10001_adc.c
@@ -55,7 +55,6 @@ struct cc10001_adc_device {
 	void __iomem *reg_base;
 	struct clk *adc_clk;
 	struct regulator *reg;
-	u16 *buf;
 
 	bool shared;
 	struct mutex lock;
@@ -140,12 +139,11 @@ static irqreturn_t cc10001_adc_trigger_h(int irq, void *p)
 	unsigned int channel;
 	unsigned int scan_idx;
 	bool sample_invalid;
-	u16 *data;
+	IIO_DECLARE_BUFFER_WITH_TS(u16, data, CC10001_ADC_NUM_CHANNELS) = { };
 	int i;
 
 	indio_dev = pf->indio_dev;
 	adc_dev = iio_priv(indio_dev);
-	data = adc_dev->buf;
 
 	mutex_lock(&adc_dev->lock);
 
@@ -178,8 +176,8 @@ static irqreturn_t cc10001_adc_trigger_h(int irq, void *p)
 	mutex_unlock(&adc_dev->lock);
 
 	if (!sample_invalid)
-		iio_push_to_buffers_with_timestamp(indio_dev, data,
-						   iio_get_time_ns(indio_dev));
+		iio_push_to_buffers_with_ts(indio_dev, data, sizeof(data),
+					    iio_get_time_ns(indio_dev));
 	iio_trigger_notify_done(indio_dev->trig);
 
 	return IRQ_HANDLED;
@@ -241,22 +239,8 @@ static int cc10001_adc_read_raw(struct iio_dev *indio_dev,
 	}
 }
 
-static int cc10001_update_scan_mode(struct iio_dev *indio_dev,
-				    const unsigned long *scan_mask)
-{
-	struct cc10001_adc_device *adc_dev = iio_priv(indio_dev);
-
-	kfree(adc_dev->buf);
-	adc_dev->buf = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
-	if (!adc_dev->buf)
-		return -ENOMEM;
-
-	return 0;
-}
-
 static const struct iio_info cc10001_adc_info = {
 	.read_raw = &cc10001_adc_read_raw,
-	.update_scan_mode = &cc10001_update_scan_mode,
 };
 
 static int cc10001_adc_channel_init(struct iio_dev *indio_dev,

-- 
2.43.0

