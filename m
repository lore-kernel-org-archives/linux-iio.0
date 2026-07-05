Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C5E23FC41
	for <linux-iio@vger.kernel.org>; Sun,  5 Jul 2026 16:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783270465; cv=none; b=V65EG41R/XqDNFx6NxKrI6ul6PSdElCZP5NqmR2HLimDmhqCNEn79dAjZMtVJ8v5VTtaiAPoE9CGPzKudVnCaDCEw84Kk2MmG27RHeo//mLyWR26Y39RJ2XV6T0w82Y9q5cW1t1CxEbAVdqyZRGciaXirdjTut9jM+QaeECGapw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783270465; c=relaxed/simple;
	bh=goLxOeIHIgfoLKTpZSuskmH2vf7z+LIBglVRN7QnIwA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AF+0o+TKNABy0V/V1Mqrv5B7wNNY41YOoSWD7VdrbqZyFA8TOfuNHTJocwjW+OuRFqYMVAnODA1YYEHeS0Bwd3p4nod4gk3rzuPLwgM+oa/OEjS03tLMhTh+GhKwzOqzFdG/utNSMRzdV88uVGth9aetfKpgY8nWkC9BYCF95Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l3H0kDzT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GjDzMQk0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l3H0kDzT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GjDzMQk0"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 665Borm01636117
	for <linux-iio@vger.kernel.org>; Sun, 5 Jul 2026 16:54:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EORU7/2/xHP2h9aNqThCS6cHlFvWyRUWhoJIuNcLyKM=; b=l3H0kDzTOwDeH/Ba
	p8oYBp7BhsYxG+Y3aZ7pwPk5PpiUdgXUVRGdIYj2COJ52as0ouInvZNm+5ZK0QJq
	ZydSmJxsF/DC1Zg95Pf6efJWccLuz10oRt4fVRzU2HSeX06lUND3QcNo7nLYKnFd
	d4qoW/9d6OaOR0PMkIHDbYpMALojuM3lHJaNq0Jh5mY9sJUkddQl64Q4dXC+t03P
	DeZUH5BB6r8omPcbL3khYU78zvQG0lEv+v6oInyCShOrodJ1rhHE8MZmAr8nrGvh
	KXsEXMNmiIm4ARN0DCplP+ErukfO/jG3+hxv1hMENF22jUqNyY0s5C1MBZaY5D/h
	3qkjzw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6s4su5mu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sun, 05 Jul 2026 16:54:23 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-381abcccbf4so1284478a91.3
        for <linux-iio@vger.kernel.org>; Sun, 05 Jul 2026 09:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783270463; x=1783875263; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EORU7/2/xHP2h9aNqThCS6cHlFvWyRUWhoJIuNcLyKM=;
        b=GjDzMQk0SIggUXuN0Ux8oMokg4U3TNLHTfsHDR1X+B4l2zf1kRhf2btyYS9qZgUYzo
         3VXwzR9Vhgo/sUl+e2/3Y9HrL2J4yySEE/RfyNr2ft1oaEIK6TVzYsA6Ia8T4q5kZ2NW
         3U3AqhvRvZf3Bt5l8rIIj6AH71l+KI02bvimR3pd+A104VBg0pK3Gplus/JzvYLLbKSv
         yDr06Qqtub1OHn5w8oA07lOiTKePxps+USlf6egWcr8BVHrpKJ/L2NxhbeH/iIFNBkCJ
         MU4P70rMoDs/DSTrwADxTRT2nt2DSwuvYndCfJuVjYud7/PUvlGDiucGqfZl3WkU1ruR
         8keQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783270463; x=1783875263;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EORU7/2/xHP2h9aNqThCS6cHlFvWyRUWhoJIuNcLyKM=;
        b=flKBSUBwPmk3FcsYe7dFmpdixZJXzk23ln9tU/VeX2aafMCzbNYO/7G8vC0f6Mwb4d
         hGe198v0d40Dn5xDeOBF6KeivNFs2h9irdxLVhrs+TmakphIYJlcZxsW1h6g33Nvc/mW
         qYxV4z++ZBLsZGwVDUPWopn5WWh9B4/TJSk67Qe8v0TjBce+2O3T4RRH3NKOn1Xt2GyT
         eDQz8f4mQ/Z2R9+TMyt8p3TC0t0db408Fo9iiW421dd5Tc4S4a6xw4Kt/ayGi17lk1tn
         aj8v6eEfe0+6+nmfOAAYnvqZqapRxAIncK2s8I8rIoEEitJwmePCaPMHDfRp4Yw5Wqnb
         oyHQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro7GWLkIMiS6m8K0RLX6hoeCKsshrwAkhPlgC2JJlZIOfcCIqbObE7+JkcDwAuBT0N2JF+z1EGZGzc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx90UcyVsmNuQB5MXzHgiLoHAVGoSRswDahj24GrkQdLIIa2aID
	sEyVWcLsiaD9NivGebQDgCsZ6A76F2KQ1a0hr6K5xR56q4K+qYZQNdyUX6YAnw2Q0tBZCgWXbFY
	UkZJd8mKQfIGy/iu6GPr6IZSCg638TLJGPha3eLGOG+zuKAxJgdwvBFWL6QkxdvA=
X-Gm-Gg: AfdE7cm03AzpwyjUAiZAnGUjOtBXWHqOGE++JI9TIKduqgp4zitsAN5ClAxAUTsK6AQ
	Hpx/0U+hJRluJLKNGkCsImSjl6T8P/rEYAkQUGOFaLZInG2x2BLce+AFGzy4JVXIstOOhUmhK7D
	0swrfv0ohOFvF6Hpak+sh/yT7h++KDLpgwjuhxlHv96FxH9caEb3rW2zmoTaUGdx6FUJztfmdm3
	QTVDW81UjBjJQfbj6tROfwvDcamtz/ptEs/jpty42HKKHWcostVpnKdlAg+yi2U7gqihTpVGR9h
	+OE0+wiamYbkUZok1BCyp9evy72ioWNmgeOOM6TihNWu54Z59qdjrPT9qfSSnXkNmQRESivzvra
	xTOcR95nhe5HgYkevtghl38IPyCbCIA==
X-Received: by 2002:a17:90b:3909:b0:381:528a:808c with SMTP id 98e67ed59e1d1-38280aa611dmr6592274a91.12.1783270460519;
        Sun, 05 Jul 2026 09:54:20 -0700 (PDT)
X-Received: by 2002:a17:90b:3909:b0:381:528a:808c with SMTP id 98e67ed59e1d1-38280aa611dmr6592225a91.12.1783270459492;
        Sun, 05 Jul 2026 09:54:19 -0700 (PDT)
Received: from [10.213.109.130] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f3a9341e0sm38253593eec.12.2026.07.05.09.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 09:54:19 -0700 (PDT)
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Date: Sun, 05 Jul 2026 22:23:33 +0530
Subject: [PATCH v3 1/3] iio: adc: qcom-spmi-adc5-gen3: Share SDAM0 IRQ with
 ADC_TM auxiliary driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-gen3_adc_tm-v3-1-ac62f387dbce@oss.qualcomm.com>
References: <20260705-gen3_adc_tm-v3-0-ac62f387dbce@oss.qualcomm.com>
In-Reply-To: <20260705-gen3_adc_tm-v3-0-ac62f387dbce@oss.qualcomm.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        David Collins <david.collins@oss.qualcomm.com>,
        Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783270447; l=6250;
 i=jishnu.prakash@oss.qualcomm.com; s=20251014; h=from:subject:message-id;
 bh=goLxOeIHIgfoLKTpZSuskmH2vf7z+LIBglVRN7QnIwA=;
 b=y6yo7C2821T7hk+4oVe/1OBPl9nGgZy5xs59SB7cQb7yoqxfV+6ZerF7m5Heq6WPQL4zo7q+e
 wuHU8fN1vWRBGHTrhZYT0AcDPSb28zfHibSOjJID1yYWIj4sINV/zLt
X-Developer-Key: i=jishnu.prakash@oss.qualcomm.com; a=ed25519;
 pk=g89pXdLVwRjdTeQ+uX1QzvBO346E3hQAc1N7fcTXgmk=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDE4MCBTYWx0ZWRfX9V9iTNhwAL6s
 iZIisToWmfBlkrtbnp0RBgyM2ExFsIBDco76dxczGwTfZeBXHtyWjzrRpTVfbLBGzM8NrTlblqC
 7fmCsMFD/3JcAK03X5HmoXWqRx3frPk=
X-Proofpoint-ORIG-GUID: UhNXk1-1WMyQtJbRSslJpkbRA6Ph7y-k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDE4MCBTYWx0ZWRfXzz23DYYYZoTk
 sFMj2rXXPwSA024i7hoGbXj3TGGxeRiGSk38OdMUKvLPUZ22wz1PrAyCWmFHYbwERdTlPwRe47a
 2K9Uik5K8lPdmqWfJYz42rNf4ncvchLoZpWbhx68GHmt3OuJxGnQGt9sUq2uA3K24XOKnZyN3QU
 NWjXmpdwc0eA2yAXuRqnYnJ0AoP3wbHYwMd2SmZVrrQk9FnK/f82f87zUJZR/4Jd/9Ke2YB4wVN
 RUX8asmYcBqKbf2mt6zTGucFluqRJvvXYW78sDVN2LlFKtf+9FDMhP7JK3XpaA8c1sCR35Pjjbq
 uY8Jng2jqN2kpUYLoYgWguzKQsD2xUvp5i/MX/pweNSYpgan5Wd+sAYwbD7cqzleGPsmwt0ETOi
 0RD5rbg24O31e08O9uJnM0VVxGZAxyxSWBE6TMWgJY6YX5TE6yEbTdcdASV9gEfBGHGfpoBdHZp
 vXIcSB3d719JXcmtG4Q==
X-Proofpoint-GUID: UhNXk1-1WMyQtJbRSslJpkbRA6Ph7y-k
X-Authority-Analysis: v=2.4 cv=ZfQt8MVA c=1 sm=1 tr=0 ts=6a4a8c3f cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=g_6YNVtFXVELDihYPjMA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050180

The SDAM0 IRQ can be triggered for both EOC (end of conversion) events for
immediate ADC reads done in this driver and for threshold violation events,
based on ADC_TM thresholds configured from the auxiliary ADC_TM driver on
TM channels on the first SDAM.

At present, this interrupt is handled only in the ISR in the main ADC driver.
When the ISR is triggered for an ADC_TM event, this driver notifies the ADC_TM
driver by calling a notifier callback exposed from it for this purpose.

To simplify the interrupt handling in both drivers, share the interrupt between
the drivers. With this, ADC_TM interrupts on SDAM0 will be handled directly in
the ADC_TM driver, so remove the notifier callback and all TM interrupt
handling in the main ADC ISR.

Reviewed-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
---
 drivers/iio/adc/qcom-spmi-adc5-gen3.c         | 65 ++++++++-------------------
 include/linux/iio/adc/qcom-adc5-gen3-common.h |  2 -
 2 files changed, 18 insertions(+), 49 deletions(-)

diff --git a/drivers/iio/adc/qcom-spmi-adc5-gen3.c b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
index 48c793b18d11..c1962312afcd 100644
--- a/drivers/iio/adc/qcom-spmi-adc5-gen3.c
+++ b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
@@ -56,9 +56,6 @@ struct adc5_channel_prop {
  *	requests from multiple clients.
  * @data: software configuration data.
  * @n_tm_channels: number of ADC channels used for TM measurements.
- * @handler: TM callback to be called for threshold violation interrupt
- *	on first SDAM.
- * @tm_aux: pointer to auxiliary TM device.
  */
 struct adc5_chip {
 	struct device *dev;
@@ -70,8 +67,6 @@ struct adc5_chip {
 	struct mutex lock;
 	const struct adc5_data *data;
 	unsigned int n_tm_channels;
-	void (*handler)(struct auxiliary_device *tm_aux);
-	struct auxiliary_device *tm_aux;
 };
 
 int adc5_gen3_read(struct adc5_device_data *adc, unsigned int sdam_index,
@@ -287,23 +282,21 @@ static irqreturn_t adc5_gen3_isr(int irq, void *dev_id)
 {
 	struct adc5_chip *adc = dev_id;
 	struct device *dev = adc->dev;
-	struct auxiliary_device *adev;
 	u8 status, eoc_status, val;
-	u8 tm_status[2];
 	int ret;
 
 	ret = adc5_gen3_read(&adc->dev_data, ADC5_GEN3_VADC_SDAM,
 			     ADC5_GEN3_STATUS1, &status, sizeof(status));
 	if (ret) {
 		dev_err(dev, "adc read status1 failed with %d\n", ret);
-		return IRQ_HANDLED;
+		return IRQ_NONE;
 	}
 
 	ret = adc5_gen3_read(&adc->dev_data, ADC5_GEN3_VADC_SDAM,
 			     ADC5_GEN3_EOC_STS, &eoc_status, sizeof(eoc_status));
 	if (ret) {
 		dev_err(dev, "adc read eoc status failed with %d\n", ret);
-		return IRQ_HANDLED;
+		return IRQ_NONE;
 	}
 
 	if (status & ADC5_GEN3_STATUS1_CONV_FAULT) {
@@ -316,30 +309,13 @@ static irqreturn_t adc5_gen3_isr(int irq, void *dev_id)
 		return IRQ_HANDLED;
 	}
 
-	/* CHAN0 is the preconfigured channel for immediate conversion */
-	if (eoc_status & ADC5_GEN3_EOC_CHAN_0)
-		complete(&adc->complete);
-
-	ret = adc5_gen3_read(&adc->dev_data, ADC5_GEN3_VADC_SDAM,
-			     ADC5_GEN3_TM_HIGH_STS, tm_status, sizeof(tm_status));
-	if (ret) {
-		dev_err(dev, "adc read TM status failed with %d\n", ret);
-		return IRQ_HANDLED;
-	}
-
-	dev_dbg(dev, "Interrupt status:%#x, EOC status:%#x, high:%#x, low:%#x\n",
-		status, eoc_status, tm_status[0], tm_status[1]);
-
-	if (tm_status[0] || tm_status[1]) {
-		adev = adc->tm_aux;
-		if (!adev || !adev->dev.driver) {
-			dev_err(dev, "adc_tm auxiliary device not initialized\n");
-			return IRQ_HANDLED;
-		}
+	dev_dbg(dev, "Interrupt status:%#x, EOC status:%#x\n", status, eoc_status);
 
-		adc->handler(adev);
-	}
+	/* CHAN0 is the preconfigured channel for immediate conversion */
+	if (!(eoc_status & ADC5_GEN3_EOC_CHAN_0))
+		return IRQ_NONE;
 
+	complete(&adc->complete);
 	return IRQ_HANDLED;
 }
 
@@ -684,8 +660,6 @@ static int adc5_gen3_add_aux_tm_device(struct adc5_chip *adc)
 	if (ret)
 		return ret;
 
-	adc->tm_aux = &aux_device->aux_dev;
-
 	return 0;
 }
 
@@ -741,16 +715,6 @@ int adc5_gen3_therm_code_to_temp(struct device *dev,
 }
 EXPORT_SYMBOL_NS_GPL(adc5_gen3_therm_code_to_temp, "QCOM_SPMI_ADC5_GEN3");
 
-void adc5_gen3_register_tm_event_notifier(struct device *dev,
-					  void (*handler)(struct auxiliary_device *))
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev->parent);
-	struct adc5_chip *adc = iio_priv(indio_dev);
-
-	adc->handler = handler;
-}
-EXPORT_SYMBOL_NS_GPL(adc5_gen3_register_tm_event_notifier, "QCOM_SPMI_ADC5_GEN3");
-
 static int adc5_gen3_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -817,10 +781,17 @@ static int adc5_gen3_probe(struct platform_device *pdev)
 			return -ENOMEM;
 	}
 
-	ret = devm_request_irq(dev, adc->dev_data.base[ADC5_GEN3_VADC_SDAM].irq,
-			       adc5_gen3_isr, 0,
-			       adc->dev_data.base[ADC5_GEN3_VADC_SDAM].irq_name,
-			       adc);
+	/*
+	 * This interrupt is shared with the ADC_TM auxiliary driver, which
+	 * is threaded and uses IRQF_ONESHOT. Since shared interrupts need
+	 * to agree on IRQF_ONESHOT configuration and there is a kernel
+	 * warning for using IRQF_ONESHOT with non-threaded interrupts,
+	 * make this also a threaded IRQ.
+	 */
+	ret = devm_request_threaded_irq(dev, adc->dev_data.base[ADC5_GEN3_VADC_SDAM].irq,
+					NULL, adc5_gen3_isr, IRQF_ONESHOT | IRQF_SHARED,
+					adc->dev_data.base[ADC5_GEN3_VADC_SDAM].irq_name,
+					adc);
 	if (ret)
 		return dev_err_probe(dev, ret,
 				     "Failed to request SDAM%d irq\n",
diff --git a/include/linux/iio/adc/qcom-adc5-gen3-common.h b/include/linux/iio/adc/qcom-adc5-gen3-common.h
index 6303eaa6640b..39cbfcbdb101 100644
--- a/include/linux/iio/adc/qcom-adc5-gen3-common.h
+++ b/include/linux/iio/adc/qcom-adc5-gen3-common.h
@@ -205,7 +205,5 @@ int adc5_gen3_get_scaled_reading(struct device *dev,
 int adc5_gen3_therm_code_to_temp(struct device *dev,
 				 struct adc5_channel_common_prop *common_props,
 				 u16 code, int *val);
-void adc5_gen3_register_tm_event_notifier(struct device *dev,
-					  void (*handler)(struct auxiliary_device *));
 
 #endif /* QCOM_ADC5_GEN3_COMMON_H */

-- 
2.43.0

