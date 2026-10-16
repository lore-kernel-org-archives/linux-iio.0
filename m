Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F114D17AA
	for <linux-iio@vger.kernel.org>; Fri, 16 Oct 2026 15:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792163477; cv=none; b=bpkbJoxxnoR3rqi1PHLCWMcDlje5pDQ0WDPKkJmc4nXGYR2KcZXRhJBveCYsQOqeVMGN+wPtcMXSEGXtWGFxo1u3dIrrDRCOlN0BoQx+78dHPoNSgK6I3QS02etdMOBoRe9Gp0Kz2yjjEVFe3NEuFyIohWz3VBec3xDKO30pruo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792163477; c=relaxed/simple;
	bh=7bPVnZplLmFVqkDLU3WnLpK2QvTlhSBgRlfPuPaanKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jiq7pGzHU237dMzInNJg9Q1Smmh0+svnVf3quZ9OihuSrUQnQJ7gu62HxneW4BezEuCDjbPUxRt715xWKQuvilnGxY60DLbGQZVatekEZzgTCSd88mw4bt7SOPo/Bjz2jbVH4FSWIt6xo5cPpiU88NCenYZHE+DqsRmklF6sA78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l+2eqF3q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CvhHvKz0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l+2eqF3q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CvhHvKz0"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69GE5jvU1910967
	for <linux-iio@vger.kernel.org>; Fri, 16 Oct 2026 15:11:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yZNacfeRWpMHG68hFaQoKsd53l54VClBNFu4uH2HbKw=; b=l+2eqF3q42+Uttmj
	E9iAkzhIani0xzuNa1za8GMIsHBRkxXn4IPVDkzQDfDwIDTaWIkJp703TxAumlXa
	81RsgIbkCaJAl0DVSGyjfQU/JTTx2vsvO+DunyCgv5c3h4Opg6axjGEmCJHB3VON
	nTqRGfCFQhTC6XYF9tFrMc5+yhE4QPamjgB2JwKC9vgfJgLlzcbYg/yuCoTvq2PA
	OCC0QOWZU1x2n9oB3+MLdoKBVQu6YzPVe7m/qhL96kHFd8IJl+hAMHqkFRGyvZmS
	pj8AT9Gd+/MGug5+l/KT7uHMazqYP2Wa2dv2v0Y5wnZ6Ch/JoJLzJOUc9CHeyC8a
	laZjpQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbjmf8wxg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Fri, 16 Oct 2026 15:11:15 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93edac5877bso1156185a.1
        for <linux-iio@vger.kernel.org>; Fri, 16 Oct 2026 08:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792163474; x=1792768274; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yZNacfeRWpMHG68hFaQoKsd53l54VClBNFu4uH2HbKw=;
        b=CvhHvKz0Af69SISCv25HwzXmrm6nSnjZIoralTw5k3iuxwcFyceckkT/MKEE3CC30u
         wdAdjW/aEp5CaavMhsQ+3Jy80daH8rxkkizitNI8UiQpagUffN1WvgPkkNArP+sF0+ye
         RRtPecdwFt1cLT4sMcbcBzgQ7KQGr2SdpBhu5jVfgZ1J+a5f2Bt1vxOBqd26rqCSwnzA
         KctxO2YeXKeyWksRJuBVsgDzJpqKZQ5Ti3Dcu0cCQUYUnaZvwJ/DSwk82pB+BmkHCzAH
         vUo4VEZgOfUpIplpOCpePZr+7syO6qugjr0t+ykQ2ohWVv5NNbAYeCcHgsK/a4U+qsDt
         u7iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792163474; x=1792768274;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yZNacfeRWpMHG68hFaQoKsd53l54VClBNFu4uH2HbKw=;
        b=tfYkpND0nl3m+lMcdmm4KhwOcrmHyZUwnEHck5bnewVTYNgwAkbc94HpvEL36OEiQA
         nWLRZS7HaHlzIGxTD2zxzOolX/fFEaeHDii9hvcjI0qvXWTZZz/0M4UTvxtoAK2cAw7m
         gzncocmxNY/s0u6482nnXNVbhaGW3BNtdI9hZGLeVZbyYwZtVUThRREYKG4uxYpzEFib
         Auq9XxmzmEJ5byebzHJ+/q66hn5QA2oRHL2adVh1d/3jlRyMsEPHq2dtkO8ZhOgf+Iqx
         13mk0dZM/PgCCBlycaBjTOmRu2VwSEfUFMZl3QWi251grS0YIwKhC08l6wsfm/CYfRDt
         6daw==
X-Gm-Message-State: AFq9FYJdC28n01hmLBYIJ4ZAdMUEb6RjrunOuT2baiioxI+AEOkWKIqM
	Brx9ojIp3ujp5fx3aSwvSHq1eN/tKxM4lW4iQwa5WsXC+cNiwjsnYm8UjvRM/ur2Ir1d2kvfG2f
	ZA8VWtrZK+lA0tIcM+ZV1BEP3rvRN/2TGIIPVcTpWimUOk3At8d4HGiqnnG/CZXM=
X-Gm-Gg: AYBFou0xmCmmledWwGmlTEBmBpltfL2A3msa8sCDr7pwpHEwgu02Ao5X5dzaP1iRTPN
	/iPSJl8FV+adLc7nQS+nlrdT1ohWIWnCIK4ABmZU53phw8mtS9YXhnpeWe7d52ADG3wMCCe9u37
	ieTqgGreu+aW0Q4zLWwcvK/4k0l0VQ7/jF+ZyLv1T6KIaRL+h+7vZKHHG6JWCrmFPvsPd/zhFBx
	LdBZ9pQBx1JxpSOf/dWRtfCe2HNinb0OlDaDoC2RYQn1mYxaH4JM0diPDicw3Bqnhdg9OQ+7ZGE
	LR8duFHCIGUVkh2TDveZvxxTBdahtHOZXHYDe4w6lh/6wWIQdhsP3la5Dyb8g0TFVFp7+ySEVTP
	Zf0dMEgpNwJuwuTHSm8Eo2Q==
X-Received: by 2002:a05:620a:2948:b0:93a:1312:ff19 with SMTP id af79cd13be357-93f29dcd9cdmr16484885a.5.1792163474394;
        Fri, 16 Oct 2026 08:11:14 -0700 (PDT)
X-Received: by 2002:a05:620a:2948:b0:93a:1312:ff19 with SMTP id af79cd13be357-93f29dcd9cdmr16476785a.5.1792163473754;
        Fri, 16 Oct 2026 08:11:13 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c416a4be585sm18365666b.68.2026.10.16.08.11.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 08:11:12 -0700 (PDT)
Message-ID: <5531e454-0d84-48f2-af0d-1ab34c149760@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 17:11:09 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: msm8916-samsung-j5: Add proximity
 sensor
To: Christoph Rudorff <chris@rudorff.com>, Linus Walleij <linusw@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20261016-iio-light-gp2ap002-v1-0-7c93312fa8d5@rudorff.com>
 <20261016-iio-light-gp2ap002-v1-3-7c93312fa8d5@rudorff.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261016-iio-light-gp2ap002-v1-3-7c93312fa8d5@rudorff.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: hMJFZ3MILtKCzqB61mus_n6USgI-qKHm
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA2MCBTYWx0ZWRfX+7CBGacwd2h1
 +5gJmqYvKkuzJqBwNC0uvDe+URKfpisG37G5l2ITdSQAtltKww9oPg0MjFzsge5pWPFcuB8sn5c
 zhnEkRYFYE+JwgvQp/Bkf5KHzl/N0Ac=
X-Authority-Analysis: v=2.4 cv=SrAFe/O0 c=1 sm=1 tr=0 ts=6ad23e93 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=qfT2Yf8mAAAA:8 a=FGSye35rWshla3B4t1AA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=nKa2voRIl820JbUdVH2x:22
X-Proofpoint-ORIG-GUID: hMJFZ3MILtKCzqB61mus_n6USgI-qKHm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA2MCBTYWx0ZWRfX6OGWEmbG40LD
 GTtdhETzczcSms2AAA2EMM2C4QL8u73n/KwV1PNCqILTmcwHfbskNby2Q4NYobhUsLAYiMStQMw
 llN9ubP8UgGZBTfBE9bakPIjIMZlegcbzKgHhwGnzBFY1gkadhdpwalMYRg78Pnvx3P0WStDmI5
 X6Q/xbv5gQBdRBOtj3AXqha4eFM+RNzaguRZFscVibxUu7iqZG9YqnylAUFvqrlF+lIgAIm4Ga3
 f/mfL1A2t8kujTpOF52E17tvHn12YvoZzKQ2rkYLrsNPMILLI+fUQJpgMa+pUsIyR2oEsO+13Uz
 NhruFz6AgQdDR1VgA4pRTiiiWkcDPEVo73GY5xiwudB/Hm7wZvHcTeU0KmHn6qPrWlF0JvkfORN
 fYTO7Pmb/gE82Nwzh8oW8HjBhjB7vCJf9r1GU4Q2fHAav8AEXyv2jkmos1I7oJm45K9RkmUCNrI
 Ztr9/r2ATBrbUep52lg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610160060

On 10/16/26 4:43 PM, Christoph Rudorff wrote:
> J5 got a gp2ap002 sensor, add it and it's supplies to the device tree
> 
> Signed-off-by: Christoph Rudorff <chris@rudorff.com>
> ---
>  .../boot/dts/qcom/msm8916-samsung-j5-common.dtsi   | 19 ++++++++++
>  arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts    | 40 ++++++++++++++++++++++

It's odd for the regulator and pin setting to be common, but the
sensor to only be there for one of these devices

Konrad
