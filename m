Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4F744D696
	for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 18:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785521291; cv=none; b=aEymtLRSQi5tWxd6MJMd9+sJ0qdvAcXvmdsR84Ea/Yc2ST8mrUBllH6g+FmLYqsbKXfeJ27gQ6jIaxP/sS7j7WukFIdlNzU/E+VvTv5N0sTk+7sk/dnd84y7JxXhJpWZFlZtPF7yTynnJye1mJ7KaR5rNM9D/IXMomF+YXVBmys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785521291; c=relaxed/simple;
	bh=LOxUXcHUW8m9HTKf4+InD/drBKNdjdniL/Lo17aWE68=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LYPZ6r96iSx3Czr0QokHkheEdHyk6MFbBk1ge6Bex3ez/il+w4ei3zhmy2IZ6tptBBPkV5lpp6bDVsG07qsxyJWtyKm5yjdsHRfmNq59pNjKjqMDgR8OF1iVY7qbf9xsSb75Q/T4myJpzUNKFzJc/E4UUEqa0Niy2B/Eqz2i7cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hvhn8enK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Nj2SG1WI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hvhn8enK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Nj2SG1WI"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VFNvwa105912
	for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 18:08:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0+1IF6MZZfV+s/U2Wuif1+TYpS3Jw4Ys7hOvFs6NAL8=; b=hvhn8enKlqlqQuge
	bsJagM44/Lh3QU0xM3phPlR0hBWuo4tYfVj28zA9s5sRpoicFO/0/f886A0Msl3w
	y3eEIKT33GZf5lmlMhno6xuxDdPf6RLiLD5fFC9K89BjwlBsVtgK8Ji+hHBfUVwj
	JMBh0NTYtqAUODJniHLN0CmFLMClnQ76G01zxfbbV6pFwbmips0xkirTeHTsB3Kv
	zaqalmd3dfsmXLG5As6OZVdGF4ACd/GzP7zRZ0bP4zxyp5AtGXWrFIawpl6YJnx9
	IX6VqnjjR4F7GxkBuMJV+8Ht1Hrd2cjw3LInczy1LdtI7iWWUVQgceN8VBVzLkFy
	Yhtg3g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fru2u1rfd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 18:08:09 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cfa55c9430so11043045ad.0
        for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 11:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785521284; x=1786126084; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0+1IF6MZZfV+s/U2Wuif1+TYpS3Jw4Ys7hOvFs6NAL8=;
        b=Nj2SG1WIZN4Prorbs1RkTQAiG5PwCSrOJ46FaaD7ATPKDGEAifMFL+ZOdhKTG5vuFM
         8Ac5ALBpvpaGPoV7V4kNTY0kfJstItJL8wRVq+AsmJ4TEOQmQMhF9/a+m+29zLaF9u4Q
         0rdtkvEaREgNtU9Q8zh2V05ruwFycKIXsaJne4p9CmLv1uMxTjOTAyzCt8JZjNVRKxSE
         AukcY+LL+WRwM5r5+f+0E5HyCkxlAVt50Vh1ph3lsGCvHDSeBT9xEQHqiqjXU29PlIZ1
         dDgWCIK8DB62Aaec/1AN5oAVr1/P/0XNCvLv0euSPEu+F+mlNb6+pIvS5Fb1VkP1wKXU
         jOUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785521284; x=1786126084;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0+1IF6MZZfV+s/U2Wuif1+TYpS3Jw4Ys7hOvFs6NAL8=;
        b=OgbXCMMG/1dcV03VvvHfnzvinON96FBxzrVAkOb6Dj7zyHgoiORj0QUVrUzJ0Uow9d
         EDvwYSBFBQv1rSX1jsiTGpazw4HTS1lRCm7J77gCAZ+JbAlEpJhx9wBSb3W6oOWQD4Uu
         Nf9zRQTD9hODIRplV0eyQtxPMkCo8/D0Rt6LvDkAUMPwaGiDXIzP4uF4twJyvSEQ7QkT
         dmwPKoKWswgpG9oFMXPlUQXCp9lfez7WkBItfSqB0rVex5Y5Vf7awl5PkNmLnZke2S4Q
         biJvlY7hAU0wC8eSMzIO5cU4esHbDnbAJNmqXkpY9pht0UsclbbMcZfwFg5mnO2wrDWE
         7eng==
X-Gm-Message-State: AOJu0YzNiIszDEA72oKYzKHCdTH1hmb56kafznFmWkCZsHOJPcNEzEdd
	iYEkmdXEl6DKcR+boD2nLvCmzLg3KMcMoCYKk3WebC/FLh2dg+mgZ0OCLhWVfy32sHSBEZw8KjR
	vRqBiG08urjCxyQXSHrJhYBrdNK7S86TfmQH8y9ozszE49Nr0fjw6qELgXjeTgPM=
X-Gm-Gg: AR+sD11ZdvwtYbMQ4OcpPlYjFO3hxxXgpn5fPiIw2lWI4PO6+1LMoe4tSYR4OoHPCVb
	+S8eTUhbBLkFP1qG7RPGJ3GvXMuyzQnH7tdmhvAXteUjXA7CTyG+HfTQstsonjwk20HWxdeP8xr
	T0JiAFPAUYF9BS4dcYHha/iU0aSThtd8+cX9jrrjjAIdaAzETih8RU9I/7LSnGs3z28XUlNytUz
	R96RWOdCPZjeAxebcPdQJamp8zMEYjTaz7YO+qiA1PcmkTuqSFvbm+LtaeeUcOoyIrGM8Z+Sd/u
	OjdvGu0JrKqLs6DcH3e211K2PSG7wMqd5AmUghK45gEzb1UuiKcCIdA01zv9B3wQdcGtLVjoYcn
	7Gv+vPf2wEuCfQ18fB84=
X-Received: by 2002:a05:6a20:9f46:b0:3c3:b656:4f5b with SMTP id adf61e73a8af0-3c92a8f424fmr698454637.56.1785521283765;
        Fri, 31 Jul 2026 11:08:03 -0700 (PDT)
X-Received: by 2002:a05:6a20:9f46:b0:3c3:b656:4f5b with SMTP id adf61e73a8af0-3c92a8f424fmr698426637.56.1785521283314;
        Fri, 31 Jul 2026 11:08:03 -0700 (PDT)
Received: from [10.213.109.130] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e06fe9fsm7069923eec.25.2026.07.31.11.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 11:08:03 -0700 (PDT)
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 23:36:17 +0530
Subject: [PATCH 4/7] arm64: dts: qcom: Add header file for ADC5 Gen4
 channel macros
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-pmic5_gen4_adc-v1-4-9c49b2eea6f9@oss.qualcomm.com>
References: <20260731-pmic5_gen4_adc-v1-0-9c49b2eea6f9@oss.qualcomm.com>
In-Reply-To: <20260731-pmic5_gen4_adc-v1-0-9c49b2eea6f9@oss.qualcomm.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
        Priyansh Jain <priyansh.jain@oss.qualcomm.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785521244; l=7279;
 i=jishnu.prakash@oss.qualcomm.com; s=20251014; h=from:subject:message-id;
 bh=LOxUXcHUW8m9HTKf4+InD/drBKNdjdniL/Lo17aWE68=;
 b=3HpwDAlmeDOVM/nq0/kPljvLl2A+JEzarXEbWEv6JZaNrDLYsYsAtNRlZSnqgrI93JKsOeJtm
 sAuOExLVFViDZKRdH/KegtrGRhYp2CkuWubfJ+t1zOhkd4phSXk+sbu
X-Developer-Key: i=jishnu.prakash@oss.qualcomm.com; a=ed25519;
 pk=g89pXdLVwRjdTeQ+uX1QzvBO346E3hQAc1N7fcTXgmk=
X-Proofpoint-ORIG-GUID: H6DwQ1kpVTpIa8YsDjBdSjQeeOEpXGDH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDEzOSBTYWx0ZWRfX05xx9YKTj1f5
 g0lgHSn38F+VK09DNM6EJZ0cYiDkMMnRZzQ6AY3kvIHpPSZKlmzD6wtVXlFT7dZrrzbipHbEv72
 s1lktEKIXL2zZLb5b28GOcyJ/hIHOng59LVuGFYmTTWJdO3vbKKyNKaLBStRA3mcyagHS8H9qFV
 p2+Fca/lMvo+oPqoudcGTB+zND7wNeuknN4pUyiFHP886St6LXRsr7XwfQ7X4DcGqJYZlgDF/ZV
 ilAdrVUY0GzVplX8N7Eva0C7UNiIJJ93AUQch8QUekP2jg/jeD8hhC7gEmI/JIwS5ecuQTLTNxO
 7de2fTWddKeL55gYxCf6O2xzg+kjEXs81/jvgQLvVnQMV/5MBYYDryGFa38NFUwsaX9ma0rLh38
 w/yqZUs0gfTvpE1+pAnvvzh0rk8Wkg+G0MLCoSY63z1jiXgHbxpI8NqE1J0pDyJ1ZWfnhkc0VXV
 64SOJdICOX43kFA9qNw==
X-Proofpoint-GUID: H6DwQ1kpVTpIa8YsDjBdSjQeeOEpXGDH
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDEzOSBTYWx0ZWRfX1wReCaOA8ZpR
 v/TPLo+Gc/7CCcB5Xp6nXv6VXiSNabxR0LXAMioo7qzDC3giKIaSljQPQQEHgCWhfQPhlaOr640
 bfnmYtSABO903ohPfOyPcempiZi9cC8=
X-Authority-Analysis: v=2.4 cv=b+uCJNGx c=1 sm=1 tr=0 ts=6a6ce489 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=-dRfuHEhnKqeEr1aVL8A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310139

Add macro definitions for virtual channels (combination of ADC channel
number, PMIC SID number and PMIC bus ID number), to be used in devicetree
by clients of ADC5 GEN4 device and in the "reg" property of ADC channels.

Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcom-adc5-gen4.h | 96 +++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcom-adc5-gen4.h b/arch/arm64/boot/dts/qcom/qcom-adc5-gen4.h
new file mode 100644
index 000000000000..cf94e3185e21
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/qcom-adc5-gen4.h
@@ -0,0 +1,96 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause) */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __DTS_ARM64_QCOM_ADC5_GEN4_H__
+#define __DTS_ARM64_QCOM_ADC5_GEN4_H__
+
+/* ADC channels for PMIC5 Gen4 */
+
+#define ADC5_GEN4_VIRT_CHAN(bus_id, sid, chan)	((bus_id) << 13 | (sid) << 8 | (chan))
+
+#define ADC5_GEN4_OFFSET_REF(bus_id, sid)	ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x00)
+#define ADC5_GEN4_1P25VREF(bus_id, sid)		ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x01)
+#define ADC5_GEN4_VREF_VADC(bus_id, sid)	ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x02)
+#define ADC5_GEN4_DIE_TEMP(bus_id, sid)		ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x03)
+
+#define ADC5_GEN4_AMUX1_THM(bus_id, sid)	ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x04)
+#define ADC5_GEN4_AMUX2_THM(bus_id, sid)	ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x05)
+#define ADC5_GEN4_AMUX3_THM(bus_id, sid)	ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x06)
+#define ADC5_GEN4_AMUX4_THM(bus_id, sid)	ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x07)
+#define ADC5_GEN4_AMUX5_THM(bus_id, sid)	ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x08)
+#define ADC5_GEN4_AMUX6_THM(bus_id, sid)	ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x09)
+#define ADC5_GEN4_AMUX1_GPIO(bus_id, sid)	ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x0a)
+#define ADC5_GEN4_AMUX2_GPIO(bus_id, sid)	ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x0b)
+#define ADC5_GEN4_AMUX3_GPIO(bus_id, sid)	ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x0c)
+#define ADC5_GEN4_AMUX4_GPIO(bus_id, sid)	ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x0d)
+#define ADC5_GEN4_AMUX5_GPIO(bus_id, sid)	ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x1e)
+
+#define ADC5_GEN4_CHG_TEMP(bus_id, sid)		ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x10)
+#define ADC5_GEN4_USB_SNS_DIV20(bus_id, sid)	ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x11)
+#define ADC5_GEN4_VIN_DIV20_MUX(bus_id, sid)	ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x12)
+#define ADC5_GEN4_USBC_MUX(bus_id, sid)		ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x13)
+#define ADC5_GEN4_VREF_BAT_THERM(bus_id, sid)	ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x15)
+#define ADC5_GEN4_IIN(bus_id, sid)		ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x17)
+
+#define ADC5_GEN4_VREF_BAT2_THERM(bus_id, sid)	ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x1a)
+#define ADC5_GEN4_ATEST1(bus_id, sid)		ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x1b)
+#define ADC5_GEN4_ATEST2(bus_id, sid)		ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x1c)
+#define ADC5_GEN4_VBAT_2S_MID_CHGR(bus_id, sid)	ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x1d)
+
+/* 10k pull-up1 */
+#define ADC5_GEN4_AMUX1_THM_10K_PU(bus_id, sid)		ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x24)
+#define ADC5_GEN4_AMUX2_THM_10K_PU(bus_id, sid)		ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x25)
+#define ADC5_GEN4_AMUX3_THM_10K_PU(bus_id, sid)		ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x26)
+#define ADC5_GEN4_AMUX4_THM_10K_PU(bus_id, sid)		ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x27)
+#define ADC5_GEN4_AMUX5_THM_10K_PU(bus_id, sid)		ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x28)
+#define ADC5_GEN4_AMUX6_THM_10K_PU(bus_id, sid)		ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x29)
+#define ADC5_GEN4_AMUX1_GPIO_10K_PU(bus_id, sid)	ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x2a)
+#define ADC5_GEN4_AMUX2_GPIO_10K_PU(bus_id, sid)	ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x2b)
+#define ADC5_GEN4_AMUX3_GPIO_10K_PU(bus_id, sid)	ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x2c)
+#define ADC5_GEN4_AMUX4_GPIO_10K_PU(bus_id, sid)	ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x2d)
+#define ADC5_GEN4_USBC_MUX_10K_PU(bus_id, sid)		ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x33)
+#define ADC5_GEN4_AMUX5_GPIO_10K_PU(bus_id, sid)	ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x3e)
+
+/* 100k pull-up2 */
+#define ADC5_GEN4_AMUX1_THM_100K_PU(bus_id, sid)	ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x44)
+#define ADC5_GEN4_AMUX2_THM_100K_PU(bus_id, sid)	ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x45)
+#define ADC5_GEN4_AMUX3_THM_100K_PU(bus_id, sid)	ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x46)
+#define ADC5_GEN4_AMUX4_THM_100K_PU(bus_id, sid)	ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x47)
+#define ADC5_GEN4_AMUX5_THM_100K_PU(bus_id, sid)	ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x48)
+#define ADC5_GEN4_AMUX6_THM_100K_PU(bus_id, sid)	ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x49)
+#define ADC5_GEN4_AMUX1_GPIO_100K_PU(bus_id, sid)	ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x4a)
+#define ADC5_GEN4_AMUX2_GPIO_100K_PU(bus_id, sid)	ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x4b)
+#define ADC5_GEN4_AMUX3_GPIO_100K_PU(bus_id, sid)	ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x4c)
+#define ADC5_GEN4_AMUX4_GPIO_100K_PU(bus_id, sid)	ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x4d)
+#define ADC5_GEN4_USBC_MUX_100K_PU(bus_id, sid)		ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x53)
+#define ADC5_GEN4_AMUX5_GPIO_100K_PU(bus_id, sid)	ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x5e)
+
+/* 400k pull-up3 */
+#define ADC5_GEN4_AMUX1_THM_400K_PU(bus_id, sid)	ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x64)
+#define ADC5_GEN4_AMUX2_THM_400K_PU(bus_id, sid)	ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x65)
+#define ADC5_GEN4_AMUX3_THM_400K_PU(bus_id, sid)	ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x66)
+#define ADC5_GEN4_AMUX4_THM_400K_PU(bus_id, sid)	ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x67)
+#define ADC5_GEN4_AMUX5_THM_400K_PU(bus_id, sid)	ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x68)
+#define ADC5_GEN4_AMUX6_THM_400K_PU(bus_id, sid)	ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x69)
+#define ADC5_GEN4_AMUX1_GPIO_400K_PU(bus_id, sid)	ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x6a)
+#define ADC5_GEN4_AMUX2_GPIO_400K_PU(bus_id, sid)	ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x6b)
+#define ADC5_GEN4_AMUX3_GPIO_400K_PU(bus_id, sid)	ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x6c)
+#define ADC5_GEN4_AMUX4_GPIO_400K_PU(bus_id, sid)	ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x6d)
+#define ADC5_GEN4_USBC_MUX_400K_PU(bus_id, sid)		ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x73)
+#define ADC5_GEN4_AMUX5_GPIO_400K_PU(bus_id, sid)	ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x7e)
+
+/* 1/3 Divider */
+#define ADC5_GEN4_AMUX1_GPIO_DIV3(bus_id, sid)	ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x8a)
+#define ADC5_GEN4_VPH_PWR(bus_id, sid)		ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x8e)
+#define ADC5_GEN4_VBAT_SNS_QBG(bus_id, sid)	ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x8f)
+#define ADC5_GEN4_VBAT_SNS_CHG(bus_id, sid)	ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x94)
+#define ADC5_GEN4_VBAT_2S_MID_QBG(bus_id, sid)	ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x96)
+#define ADC5_GEN4_VPH2_PWR(bus_id, sid)		ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x99)
+#define ADC5_GEN4_VBAT_2S_MID_CHGR_DIV3(bus_id, sid)	ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x9d)
+#define ADC5_GEN4_VBAT_2S_MID2(bus_id, sid)	ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0x9f)
+
+#define ADC5_GEN4_ICHG_FB(bus_id, sid)		ADC5_GEN4_VIRT_CHAN(bus_id, sid, 0xa1)
+
+#endif /* __DTS_ARM64_QCOM_ADC5_GEN4_H__ */

-- 
2.43.0

