Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793196592;
	b=DwiTD5Qk8mo5SO9NxaCsTxFVu5ESCV4auLMr/XaGLyC8g4FkT/Z34dWcKn0IkZRK1zbs
	 WZniLwYFYxBw73ND9ylQcWkYhwkcEPDLGJPg9quIoYA6AXJMftWoKsnawv4ZutC2DGGQ2
	 KbmzbxcNanwetsxbKSw2a/BEwa+JJlOFm7/a/kyMCMq9KqOIVZEFwLLiGLotWF2yFQkB1
	 1Nfqha2LUdJtCPV5GHcagGddAszEWfrOjFxvTygNrNg7BUp3Dkp8LZ391S87945xO2m5F
	 x1Yc3qZZkBIlzGiyq2KgRQr4YcQc9oRyGhlmDzEtMHH7PttWtg+SQkbfLrcu1FYcdCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793196592;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=cxJH0qp0FiIlpZ0MfESATVurtQCCVtnz1lsq71RKj1Q=;
	b=RgRU7+gPVZd/WK6qhr6efXgxNGIBp0EE7EEXfBApDbZYP6BTOek+ssAzDRP9YdJzbVcZ
	 ZngysohTGWSeqEYTJ70s7NiRZObgyDCkjtt0tfZYu/wHrEke/LjPaRbH226I9rW7enqvb
	 20A6CQddk0JkcIrUc0zfcMqS29Gtmp38sI0CDAE5ck69vI7EHprtDLUR9kO/8cTTN98xY
	 amDVOYgNqZfR9pt29o0kDAC9fndawbsXPMuxFyccOS0DVCuiVaJ9jYlE+fTs3aZ1y/iEU
	 OeUUYnN8cKbL5hg+L/Pez+8VJ/Ib2l1Q/9PmgvYCU9vogcy3ZvEYwgXlaBdU8BEVbmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mp4KMjVY;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CbVMu5ci;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B09606A31A
	for <linux-iio@vger.kernel.org>; Wed, 28 Oct 2026 14:09:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87B09606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mp4KMjVY;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CbVMu5ci
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69SBe4901053328
	for <linux-iio@vger.kernel.org>; Wed, 28 Oct 2026 14:09:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=cxJH0qp0FiIlpZ0MfESATV
	urtQCCVtnz1lsq71RKj1Q=; b=mp4KMjVYVmH3JyoOr9N0gjhCaISy4zYtKVjRKs
	+zW3BT8jIoOlkdGps3zxS34wmoMez3QAu2wxVMj+Sy9Uhx7hwd2GjhTjUofJeOQu
	QWE2JNRNC4ufofI8TdJbcsTV1UHXOWiVA643Wykruk0rIfgR/I+Nd4KBjcKDjqqr
	VfUlQe0BoUptbbhI6maM8grjvKAvwa24JihCWQNibNcvH9ZDkmfOI0gkcjth9mcz
	PJx4IxtWs5En00Sh/QtE/5QiGIwCAvBnL/D5jUAsmrbyGTVPxbHMeiGs1z3+JOpM
	TF0s8zrcf9CPzfQR4ICpLiNBtg+C4MPTi1FwcAgg7laetYnQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkbhw9s2f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Wed, 28 Oct 2026 14:09:50 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f5844cb60so207146485a.0
        for <linux-iio@vger.kernel.org>; Wed, 28 Oct 2026 07:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793196590; x=1793801390; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cxJH0qp0FiIlpZ0MfESATVurtQCCVtnz1lsq71RKj1Q=;
        b=CbVMu5ciZN7QPxoDrtCCXTgu1ZMnpEoney8ZfyUuKbqvWM/3QuXEuVSBKaEarUhzvr
         N6N7MaIoh1D5S+awqPcu+1j+93dU4wc2jTEw+iT1AvM3Znyk3ltysPgc8y2eKPVoRhvO
         XSgQ7Z3qmEZWzFRHuC0m/lvZjwLt4v1tNonQ2Bbtue3qD4A5nsf3Q5hXTQZ+RjL079nr
         8YB47i+ykeZa5JrL3mAEvG13iZWdu9sfLa4UijK5VDk/d2valNn/9uszvUzICbxO/xQO
         OCo4mwhKGQmjqllufZ6zO+rjH++zvfiWxPXhz7c0tNxD0h6DSxdrx2GRouxfPLeHq9b+
         QTEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793196590; x=1793801390;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=cxJH0qp0FiIlpZ0MfESATVurtQCCVtnz1lsq71RKj1Q=;
        b=sCf01f+XM90ISsML/JU13yNNiHSuG066c6UUd3ezNvzGx6acLrRcUBUzswXF+0+U+f
         xOmzD+6lv/3CxjJBEqzRfk+STyfu9ePMw2bdVetTaeshiH2H2OPEXItCkUFDJuE5FE9y
         FJWDgyj+Gc5YX0AkrRsOoNg9YfnewrfUmGPPriO1KU+sRTqOTr9Utt3roiG3GM6k4yBe
         knA2QoRXtYQ4RhFIvHRoFNLJ9cHtMuO8TX0q3ynPNCJP4X0IKebpTMsggWRugLbSAfNG
         /E72iQ1pTQ1som+u8WBk3RtlSqevYEjakWUPjbCfWMDG9wNUFkaAcGY5zpwkyRHtNL10
         0I1g==
X-Forwarded-Encrypted: i=1; AKwUvByo8IDdRfahsof6pzmK8Gmdg9bk20GtVRwaoKszRtt/xYmMVAYMOJbmbLjQyHF9dWLKsYyPDNiA8xs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJJbnJU9aN3bsXGtPG7GgSzO7EKyOUR9YjWsbZa0qGfCzrsyN/N
	xFFOhmo4SNY69ZwAdSvlMkqSilwLQxe0xkKCoxSFHJ2v2jzV9/FosNkYc9WuQDi831XXC6tTf91
	pCulBTh02pwJAnLusHaOdxeIpYkDCUTL/3JzikrvMLjWnIgkSzmpL6rjzgCEUZ+w=
X-Gm-Gg: AYBFou1C9F/D4EY/2YwqWEO0/nmRI2CyYVN5ZXZp/Zy3txx8foUH7eSyTJpr1Gu9hxI
	tfSTDldvFi9nCiciXSOk/EEYLSFGaxphCQJhB+IoUCLFL+IIIIAskBsC1fTVQyH2RE+u6QjYRr5
	llhbIcuyoxoSH7cSrtYt6LlRACcKoGUAU2K39GX15je2fwoV6XZBXZrHCC0by/DoHhDMuJ96XFS
	6i0dVvrHulnIeaV9T0VjfR8Ov6+aapV9z5HsnU6MgJXbX+b77ftkXlM2WvxfWn3276k1jo2Ts1d
	N4eT4iKQ+QYxJBlrlwYZDeB/T82tU6ZmnlPCtadhEda7eJUouxszhMWVA815QLZuECzD1Qsf6tv
	rhmAPwRws0c0jC3NFkY7/YFjoPMtf+4CjyGnPef08uO8QQivtw2PStdNjCtjtaZCTouUQZhQhKJ
	JHPwBVTEsB1lZ/LTK3hD15zQiAYXMCRac1kVnAG1AG8pzKXs5apuAKPW4WwfyEKQ/GguX1yIbDL
	d2d1Xn9gVCU1cw4CJXkS4M3e1Ok
X-Received: by 2002:a05:620a:846:b0:944:4e6:85d8 with SMTP id af79cd13be357-94404e6b700mr356957585a.5.1793196589646;
        Wed, 28 Oct 2026 07:09:49 -0700 (PDT)
X-Received: by 2002:a05:620a:846:b0:944:4e6:85d8 with SMTP id af79cd13be357-94404e6b700mr356951985a.5.1793196588953;
        Wed, 28 Oct 2026 07:09:48 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:9d77:8e43:b62f:d85d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecd8ddasm31369197f8f.48.2026.10.28.07.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 07:09:48 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 15:09:47 +0100
Subject: [PATCH] iio: adc: qcom-spmi-adc5-gen3: Reuse IIO device ID for
 ADC_TM auxiliary device
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261028-fix-adc5-tm-v1-1-0018aabc06c5@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIACoC4moC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDAyML3bTMCt3ElGRT3ZJc3WRLsyRD40STNBMTIyWgjoKiVKA02LTo2Np
 aAJXQkuRdAAAA
X-Change-ID: 20261028-fix-adc5-tm-c96b13a4f442
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: M6h3jKyY0ujOwe8jGAhuGe3VfdYXbde4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA1NiBTYWx0ZWRfX1qVIM9ouKxhO
 +r2II0iA//DGY3RbI2GQ4q7ZL1rTKikhKHmALZb4nrOXCAlz8rLdnMvuUk7zdgKzRGps/csyCXG
 k0AdBkeh4BUBwRg1gXbyosdlte2BWGs=
X-Authority-Analysis: v=2.4 cv=V+joQuni c=1 sm=1 tr=0 ts=6ae2022e cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=6zM0cWFruIK7PyS1tvwA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: M6h3jKyY0ujOwe8jGAhuGe3VfdYXbde4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA1NiBTYWx0ZWRfX03nCSIuPyIj3
 y4bed0svCcpIv8THH1kJ86bumF0cmDNVHNz3VljQV+JDWOEL/Zq7J3fA5blkQ/+8qSnHnkuGbNC
 hvnof9v4EM3PAP2TJV/Ygi6fXPPiQ6b7OmpWgP0x97t0dZLtw9TzzpbzDJxruAybGtin6jbaf99
 8ILeoRBK1rqMywmSHDKw2MT9D85hOLDPM1TZ7vOpf8uKWhh3EMAnf68Mwoq6SuCssUZxjtWNaKj
 SqK64VePYObQidIjihyzvCKmgwgp5Lym+7ayOF9tFsrTsFFyatopDmf4GyVXYs+RVwn/DEo0Tmj
 KOUdnzOOESPu+v7CUGHkF9TVfwTJ1CIhNnfqJo4nn1QG3Ioem1hucAbwBbpT/QeB54IgDtTQYRJ
 XLYFbK9BHaP5CJ42OBgudLXbRliv/5ZcOp0Ay+Va6HgaeNbEMDDfc7vFUmisc0rHK7VcBeFUYAp
 mO0T3zxS62ex1kouwxA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 clxscore=1011 bulkscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280056

A recent fix in ADC5 Gen3 driver allocates a dedicated auxiliary-device
ID through an IDA to ensure that ADC_TM auxiliary devices receive unique
names on the auxiliary bus.

However, each ADC instance is already assigned a unique IIO device ID.
Reuse that existing identifier when registering the ADC_TM auxiliary
device instead of maintaining a separate IDA solely for auxiliary device
naming.

This removes the custom ID allocation and release handling while
preserving unique auxiliary device names across multiple ADC instances.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/iio/adc/qcom-spmi-adc5-gen3.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/adc/qcom-spmi-adc5-gen3.c b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
index f0b2544c16322374644ac3a2eda63322f318e25f..a23eb5c9096d765af7d76ad66b50ed895782b256 100644
--- a/drivers/iio/adc/qcom-spmi-adc5-gen3.c
+++ b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
@@ -15,7 +15,6 @@
 #include <linux/dev_printk.h>
 #include <linux/err.h>
 #include <linux/export.h>
-#include <linux/idr.h>
 #include <linux/iio/adc/qcom-adc5-gen3-common.h>
 #include <linux/iio/iio.h>
 #include <linux/interrupt.h>
@@ -609,16 +608,9 @@ static void adc5_gen3_delete_aux(void *data)
 	auxiliary_device_delete(data);
 }
 
-static DEFINE_IDA(adc5_gen3_aux_ida);
+static void adc5_gen3_aux_device_release(struct device *dev) {}
 
-static void adc5_gen3_aux_device_release(struct device *dev)
-{
-	struct auxiliary_device *adev = to_auxiliary_dev(dev);
-
-	ida_free(&adc5_gen3_aux_ida, adev->id);
-}
-
-static int adc5_gen3_add_aux_tm_device(struct adc5_chip *adc)
+static int adc5_gen3_add_aux_tm_device(struct adc5_chip *adc, int id)
 {
 	struct tm5_aux_dev_wrapper *aux_device;
 	int i, ret, i_tm = 0;
@@ -628,6 +620,7 @@ static int adc5_gen3_add_aux_tm_device(struct adc5_chip *adc)
 		return -ENOMEM;
 
 	aux_device->aux_dev.name = "adc5_tm_gen3";
+	aux_device->aux_dev.id = id;
 	aux_device->aux_dev.dev.parent = adc->dev;
 	aux_device->aux_dev.dev.release = adc5_gen3_aux_device_release;
 
@@ -650,16 +643,9 @@ static int adc5_gen3_add_aux_tm_device(struct adc5_chip *adc)
 
 	aux_device->n_tm_channels = adc->n_tm_channels;
 
-	ret = ida_alloc(&adc5_gen3_aux_ida, GFP_KERNEL);
-	if (ret < 0)
-		return ret;
-	aux_device->aux_dev.id = ret;
-
 	ret = auxiliary_device_init(&aux_device->aux_dev);
-	if (ret) {
-		ida_free(&adc5_gen3_aux_ida, aux_device->aux_dev.id);
+	if (ret)
 		return ret;
-	}
 
 	ret = devm_add_action_or_reset(adc->dev, adc5_gen3_uninit_aux,
 				       &aux_device->aux_dev);
@@ -814,7 +800,7 @@ static int adc5_gen3_probe(struct platform_device *pdev)
 		return ret;
 
 	if (adc->n_tm_channels > 0) {
-		ret = adc5_gen3_add_aux_tm_device(adc);
+		ret = adc5_gen3_add_aux_tm_device(adc, iio_device_id(indio_dev));
 		if (ret)
 			dev_err_probe(dev, ret,
 				      "Failed to add auxiliary TM device\n");

---
base-commit: f1ac44c32cba88ad65dcecd4a279661d14e93651
change-id: 20261028-fix-adc5-tm-c96b13a4f442

Best regards,
-- 
Loic Poulain <loic.poulain@oss.qualcomm.com>

