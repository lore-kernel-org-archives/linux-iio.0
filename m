Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795166456;
	b=q+1QojD0z4CldH90O59rcyksweWuHy1S88JJSHTdiDOtoH1UcgslOPi+rD7mYpYRZwsg
	 NOhQG2MgYAiBHj91cW/lT/T2F2AOLm8X187ucz11UAtO1/hwsqe/S+tJMoge6yzHs4oOo
	 N/WPug1qOoHjbzTC0YatbuYgvAzUAmTBhDkOwWIB1BKTEw1BqRo3mCvhqv2VT+wRdHbdi
	 aoij40URrHuMTltHvY6TVJvlrZLd7JSxl+g6+6R/nrwjUEo+LQKiuSlmtmLmoPkNeYPJn
	 9hiC0X/YSveLry6e7o5jSC5/1aMY+5r8aMnq8lU88W4C3yA4WC01SWSkP4g/lzFXINw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795166456;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=iex+7DlCxfokNUjvAHxZkktzzR0JIxIsqe0F0xKUMZE=;
	b=qhIgZXsONDna+d8A7lRFRXdg3YdQR7QuuTral8jzO7TPyY8t9C138FDYHjDm/fJVl5XS
	 h2os4Sw5uywA5wftAnXU/lPCQpnTwka/QNOV/ks7s9I0oC1YkILZrocy2jgne5El5uj5v
	 jCkO/hY58vNimEcJYnavbaC2FEBIIXaDuZGFSEST312SVkyFg4dVpP6MbWGvFMo9poRJq
	 0lWmfsvLuWjOevMMHQ/SMsiHZDmcvNea3YjVuCCnjVuy7mSXfV0PhL5+j4BCTh5p/MdKO
	 uC1hzgyh3hGy1vuRp2zpd6g2NzvqHsbSfI2uLasxXk/0Daj8b3F808VJMikuZjiVDpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gmstM3Lo;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NPBaPM7+;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBF4606A320
	for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2026 09:20:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DBF4606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gmstM3Lo;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NPBaPM7+
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK7es9g2019478
	for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2026 09:20:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iex+7DlCxfokNUjvAHxZkktzzR0JIxIsqe0F0xKUMZE=; b=gmstM3LoZSHfV2dJ
	RxhiS3yH7+zvUjuisiI0wiiUUnhRzNorX7xavBW5WERpLyqXnEJDOW5/nB1gD020
	J1sSEF3PTENuZ3v0qr0yeekihpL2Ld9+leAuVYD1Uf68PzRfrG37HYp7iKnRtFoU
	m7rAaPKD1cknvkazujrQoIQWtc9Z9nZtA0z27cFIuOAP5z2Yfve/38J0b1615PiF
	MRc4RnLMQcWS7Vy4nJYdz3RC1aqkfZoLf2icfFPoDC7gxAt5jKiz+YydCf/q4AhN
	XL9xOytGNNe3jYrVX7VrguYQbgAVSzDXFqsv0lBYyd4tlgT9IxOI8ZS3o5zdZ3zH
	m//vOw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2fjj91wy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2026 09:20:55 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-89fb6a45c48so707619b3a.1
        for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2026 01:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795166455; x=1795771255; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iex+7DlCxfokNUjvAHxZkktzzR0JIxIsqe0F0xKUMZE=;
        b=NPBaPM7+9qOBTiYCbdvXQ6+Id0ygje3QTGewasWOmqlWXxYrtUYINfpSHq0eQc4qEW
         QB8C6KXx5FdY+88TKvSLIwJYFIvcrYDsz7GK2Uaz9nUUjbydHFG/qh76Fj6r9cMCl03N
         /6PLzHeASx6UbDyskIkJz4SlDFFo4HuanFFjL8BDAHHMkpg27OMp3gxpwauFilc75ZiI
         ceOcHsvZqBfKHJmjigS1B11fcJr2cuL1l1Ks6K+3b7tO8vJFHx8IRKd9DEyBw9QDEzXd
         5+rKGibKHfUSS6hriTa4hENBw64edXeCzgC5H6DpmnD8uv+S+ADAGnfx6rs1VkIlkUWO
         BccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795166455; x=1795771255;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iex+7DlCxfokNUjvAHxZkktzzR0JIxIsqe0F0xKUMZE=;
        b=X79WV82YG4ABC++dclo0z13ExDeVdmCcLBjxKQl/tlqmHpoXjYet0zOl8pmekXSCu5
         r55/ZUcYkwdEaDkvQ5LLg3MtPpfvDSXHXhpPQ6qi65bspW3VGqrT8+MPJE7xMM1g5ujn
         7oJdeEk/Gr7b3RwbQsJKu89kWNZ1oHUlolX4qDAqMqLyhzqtrjh6W6EXuJXu29b3DiIU
         CKcVLcmYEfo/LLJmSddYPl1d7Nx9UX4vYTkRIIaUcXCqlJeEF3rodxBC1qhApRDwgt8Q
         39TYKkP7s1gMhAkpH/iZpEl2VZwWzqcMpLKk9zIbcHbPPC0KGeuLyjvTfof3WOdshjVC
         Jc1w==
X-Gm-Message-State: APuU4Z8GO0SjTLhtTaUHYMvBBD72caM2NMiQvMd/dXXKLbNnQWtvKU7f
	PtSeU2+bS7p449j/LU9ae50Jr3fp1aEutz5A+JR8U+vtW6YGUy0t5meQDLbKdVRfjjavZE7NNHh
	mf5A8/z9PKANfsTmXII8cKjYimQeBltjTIpbdF2ssNekq+xMtdrVOXYt88lfwDMg=
X-Gm-Gg: AZFdTZerM36GNhWE/axySv8ADujQhz4YxZiHSTDdCy6peT4RAORMjkFuxvXxK0fmI/1
	+lD9ymbXc5fMhAre/EqSrtZ++w1EZUvhWh6uG2zjUmKzOIjpsgwL469z0hk3binCD1Rjo/9mAup
	9QrcNOJ3eYPYf5Guj4s8g36mxDE3ALYB3nOCB4fzYJXU58CujCGPQg+aBC3j/g5MWPWnRdZX02n
	5IGaSMgME+YDW9FY2LK2Bea8Owc4bEIC1rPBY1hMDMvbtYyxTVOdt2Skc0xFBxtRB6SdrZZgZqz
	5tLs1RTrUao5ZXIAal/R4LW7dPgLafXCRKcpzvxuXi3LyuM5e2aRkDRnOuRil1YdPrUn9Cac0uy
	O3Uw4S6QNI2rAbKR78+Z1Qlke+09VOqq7pN4JZP9TOdZxxwJlX8tzVKh0dnQds1k1CNog
X-Received: by 2002:a05:6a00:2888:b0:89e:89f5:18eb with SMTP id d2e1a72fcca58-8c87baca1a4mr2848599b3a.15.1795166455125;
        Fri, 20 Nov 2026 01:20:55 -0800 (PST)
X-Received: by 2002:a05:6a00:2888:b0:89e:89f5:18eb with SMTP id d2e1a72fcca58-8c87baca1a4mr2848552b3a.15.1795166454586;
        Fri, 20 Nov 2026 01:20:54 -0800 (PST)
Received: from [10.213.109.130] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c873c1cfa0sm1186994b3a.48.2026.11.20.01.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 01:20:54 -0800 (PST)
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 14:49:45 +0530
Subject: [PATCH v2 5/7] iio: adc: qcom-spmi-adc5-gen3: Remove Gen3 virtual
 channel macros
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
Message-Id: <20261120-pmic5_gen4_adc-v2-5-94d0e1fd6847@oss.qualcomm.com>
References: <20261120-pmic5_gen4_adc-v2-0-94d0e1fd6847@oss.qualcomm.com>
In-Reply-To: <20261120-pmic5_gen4_adc-v2-0-94d0e1fd6847@oss.qualcomm.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
        Priyansh Jain <priyansh.jain@oss.qualcomm.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795166413; l=1334;
 i=jishnu.prakash@oss.qualcomm.com; s=20251014; h=from:subject:message-id;
 bh=I4p2EJOwVOFdhLV3d8fOV8mI8YFEYd6rXRgzQ+V6ybU=;
 b=rGlc5oobOonUPzUINfe0xZ01U9TskVZZ8B1j4gHL5EkU9puFHuIEXfLWsU0dm8BuRzoxIBRiF
 kDWSaLgE01ADQwp9CouyV4yLzDPMdMKAzrdmEGMgwp/UkEDQnpMbyAh
X-Developer-Key: i=jishnu.prakash@oss.qualcomm.com; a=ed25519;
 pk=g89pXdLVwRjdTeQ+uX1QzvBO346E3hQAc1N7fcTXgmk=
X-Authority-Analysis: v=2.4 cv=FJaOVOos c=1 sm=1 tr=0 ts=6b0010f7 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=YNQv7Wq190UJ8kr6mkwA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAzNyBTYWx0ZWRfX4Q+a33IYvGe+
 B49Q7gROc9sEXaVkPrCp7u09qS0xW0DZ+1b+XkNLhmlN6BPxPcHLwHvq77ICrXxs2h39cEwykAu
 ckC+Tcij3mw7d/NZGqIt5R9AKyusSyk=
X-Proofpoint-ORIG-GUID: 8xIsVkQLJ3qc2fNGxuWrvzhxBM3CauR4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAzNyBTYWx0ZWRfX9MmI7CeiixTR
 nM1L9E1rMFOve2duBLif65b3ZfEOTo89r0Jh5vlKfju3afHLBo0c+Fb2ke3DfPPDXqn0NEmY3zv
 KPH4jIrhSp7+Hk9M49v0mDCgC0zkXj8WOWnCEIIZhv97WsHHCedFSW5Br9p7B/dx6wPfyHpGtDe
 ZF1bYVuGpANVmXIICDePz9io4eHNGonZRAsVFZcDoj08h1k+5MQ3SqHAjGRURwX23BHtMCYqiYi
 v16jZHZqgFpsBggUIx2YoZWt5W3Vf1/Kh3rHHS+1PRqPB2yvFqUM0QT2tnNGnjVsMt0M6hCVMr0
 EzGNb2GyeBw0xA2uIAm7SRUc9h3WlNVhBaET2V5y2F0FM8FfuJ5dTUyreVAJM9ArjbqZpAHceo0
 1ZgfWSsJnChUfAZxai6ARiBeDn6WppsNb8/ENhXo1jGM+z5MSJyDkHoMLh/YfWGvrIQPgQ5PhNX
 bnNXCFN7QcEz4Ah8iuQ==
X-Proofpoint-GUID: 8xIsVkQLJ3qc2fNGxuWrvzhxBM3CauR4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200037

Now that the Gen3 virtual channel macros have been replaced with Gen4
macros in both main IIO ADC driver and auxiliary ADC_TM driver, remove
the Gen3 macros as they are no longer used.

Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
---
 include/linux/iio/adc/qcom-adc5-gen3-common.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/iio/adc/qcom-adc5-gen3-common.h b/include/linux/iio/adc/qcom-adc5-gen3-common.h
index fa7e08d67f26..105b0766a01f 100644
--- a/include/linux/iio/adc/qcom-adc5-gen3-common.h
+++ b/include/linux/iio/adc/qcom-adc5-gen3-common.h
@@ -40,7 +40,6 @@
 #define ADC5_GEN3_CONV_ERR_CLR_REQ		BIT(0)
 
 #define ADC5_GEN3_SID				0x4f
-#define ADC5_GEN3_SID_MASK			GENMASK(3, 0)
 #define ADC5_GEN4_SID_MASK			GENMASK(4, 0)
 #define ADC5_GEN4_BUS_INDEX_MASK		GENMASK(6, 5)
 
@@ -78,10 +77,6 @@
 #define ADC5_GEN3_CONV_REQ			0xe5
 #define ADC5_GEN3_CONV_REQ_REQ			BIT(0)
 
-#define ADC5_GEN3_VIRTUAL_SID_MASK		GENMASK(15, 8)
-#define ADC5_GEN3_CHANNEL_MASK			GENMASK(7, 0)
-#define ADC5_GEN3_V_CHAN(x)		\
-	(FIELD_PREP(ADC5_GEN3_VIRTUAL_SID_MASK, (x).sid) | (x).channel)
 #define ADC5_GEN4_V_CHAN_BUS_INDEX_MASK		GENMASK(14, 13)
 #define ADC5_GEN4_V_CHAN_SID_MASK		GENMASK(12, 8)
 #define ADC5_GEN4_V_CHAN_CHANNEL_MASK		GENMASK(7, 0)

-- 
2.43.0

