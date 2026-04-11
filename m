Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C063845D0
	for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 14:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775917437; cv=none; b=X/0O4MCcGukKsHbY4emQwW8mjRPB8I4Zv8KohCST0dwdENv4Jdmje1ndnlW/e0yx3mhYEWTO6HyXLIKVUDJPVeuWgREiwaPO9xTosvp8XGj74aUNStGjCtDcEwc2TrZo5b1ydy38zZKFB6jDdyhiCsfJXDV0E46tRJ4a67tGVM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775917437; c=relaxed/simple;
	bh=HCjpfHU9DRjs/0HO1xqpnQ5SMAYdtvRUQTrSyjOqwp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R7Bb6ie3eso3+zkbY4ZwAISoY6dsiasrfAJQlUtY3tXAqNPo55TnMGYi+O5E7jCzexA2gZSZhplofXyzeCR4PmK5rBB2cZFN2o4arGvmiETPGhWo+NZrbPzRYiFJ8YTO5EVVlRD+9W5TdGbfo3EyFgvg8Qwnh1+4XRerD4T4hRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kMKrsXnP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V5zgGOF0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kMKrsXnP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V5zgGOF0"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63B7uhkE3336200
	for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 14:23:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	41coO8MNC2PFEkmPS4P+D7ydAu/kwwruLRjuaYLQ7pQ=; b=kMKrsXnPsb8j6yXa
	ntjMXwHVZcayWR1to03C0TjqFRe/JeHV3ajNPS3sMk5TaekgLN938wK9HG4pb5yS
	NP64eD19YB3jaQ0dqvNIlKK/3dtYK0okHjgpVfForPDmprOSIrWrFk4at2KbDuxg
	Caq4ts799UxjBSS42idegrrJeAEzc2KdF+mARUnG/RtFDFqbPA2TSsRAG90zLvZ6
	RG7Y/knbgFBia7JPeHSqX7HAS1JrFZtmOrNAq0gZHdPdu7dQidZEE7xeE/+PD7Gh
	uvsbApKOWUm92UfMCiHZ9Q+48nw9BOMBkI5AOzHuHMMGY19PbDRJ7VBPNblw5ZE+
	DP4qQg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfjbp8ghy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 14:23:55 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50b6f869676so57358181cf.2
        for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 07:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775917434; x=1776522234; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=41coO8MNC2PFEkmPS4P+D7ydAu/kwwruLRjuaYLQ7pQ=;
        b=V5zgGOF0VzoocEez1qQGg64o5om/7js7Y2XvRZ3gmr5MLl7tmaocWQheB+Q6o73Foo
         YHgkSfVLYJzOMjG/RFDT5q2eVrPJXVN6P/7meGE181sRD8rD3WPoV+vpqXhbQxwgQYmv
         yWnhhnDmGA+9HHK1EZ/n6xHSsr5s4howcycUiej9qEn12z9mR/dBNKIrB4P1vAdtX1NN
         ybJNFNRb/Ay14L/W57q1UIvCdluKi5gn5N1Rj2c0hDHeAyw0fXnptkfJBtmexVq5d5kQ
         LrtzqFRzb/eMtlRDGRMqaG4/vmkaAEtsq4iCCVD7Scb4Fuk5MICwSqpuZjN7p2g2H/XD
         /psw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775917434; x=1776522234;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=41coO8MNC2PFEkmPS4P+D7ydAu/kwwruLRjuaYLQ7pQ=;
        b=nLo6VBqmfkVbs9qJGkcCKwtj9A9EhWBPXfCxdldGhUZEXsihbhHbS0VCqGibHSztpK
         +tEIRtSy7UqqM5ZPzizQvZF8sPLrmzOiM/HV/vGoJeKMcUDIw+tvgdXIhVgM5MeTBf0v
         SXhSRXDJUnnT/NcIPe6+qTVZyJDUqlmNgk2rFR4R4WVNphtmgIPRl9pPsegu8L+lmaX6
         LxnnlCZVSKEtqqmkRjbXHKlLnf31OdqIdoOIvHDWdlZcuDJRdgMGP2Ma06MTD5KnrVMZ
         tcWeGtX2IRavgZUMKT4+eAEXznu/p5U8L0oIsMSR/khRWvbiXnpqCU5ld73eVxdD9Yjj
         XXUA==
X-Forwarded-Encrypted: i=1; AJvYcCULT7FjK1Cts2yogBJrCTcn3JYI4UvSNpph8tPw+yAfIA1UjiwtJkr+eQcWXPFVz5jMm2VYC64WzSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhdWEGxWB7XmgVoi5nGYHtiXZREZM/JHOFf+TxMt980VgiAYX/
	bOYbzVfzSXxRNWnHP04Y7nkg2J0CX5UaF/oldlDANuzWq0aIAQmuNWbk8Vjd7JEuo2/hBSvi5RR
	p8E1ZBihjMrihnzJWQ5p2l0nyblI151L/buuNd3CYlXm8+23Aell4bqpjbt4bbFY=
X-Gm-Gg: AeBDiesibg9wkOmleyrg97bmL5eKRi3WVCN/UgWmiBBQ8NBdCkFvjoDq/0+/A1X2kCB
	7T53VBvlJYtDA6CSi8gsngGI+o5jQV6QxHkUSPydjUjaxu/8PMPR4eavOEcor5ILsuMdJm81Fe/
	8PU9YMsCFYVk45Brjjy2+oUS5yZLFzcf+xYHeqdFnsgqyc/J1NsI8ndc4jMsTcJAZGKK9/SHucl
	yuq9hflg0wWB1uNpSDQFmON2N2ETNauMn+S7Ju1SclDoC+arHah55CyJeweDnxX3rMrZdbPLAcb
	tZ7mnefMARkd3gwGtfdeC8hC8HkOmKC8Zg+rTuQzqh2Z1LXB9kNx7pLtTHfhw8gFVCpveeQ9qgh
	FBBR0GtCD0XSfb96zrONZs2FcRGCpORg2FMFoU0y3/OMt9BhvFKwJ8gDcfXDlf0ivKXm9rSstvA
	BzbldkjcNc
X-Received: by 2002:ac8:5ac8:0:b0:509:120d:4311 with SMTP id d75a77b69052e-50dd5c02761mr104005921cf.60.1775917434098;
        Sat, 11 Apr 2026 07:23:54 -0700 (PDT)
X-Received: by 2002:ac8:5ac8:0:b0:509:120d:4311 with SMTP id d75a77b69052e-50dd5c02761mr104005571cf.60.1775917433640;
        Sat, 11 Apr 2026 07:23:53 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:4c22:1fff:c4de:2c96? ([2a05:6e02:1041:c10:4c22:1fff:c4de:2c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d681edd2sm47937695e9.18.2026.04.11.07.23.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Apr 2026 07:23:52 -0700 (PDT)
Message-ID: <58af4ec0-f00b-42d9-89a9-542228488980@oss.qualcomm.com>
Date: Sat, 11 Apr 2026 16:23:50 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: adc: nxp-sar-adc: use field_get() for EOC bit
 check
To: Piyush Patle <piyushpatle228@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Alexandru-Catalin Ionita <alexandru-catalin.ionita@nxp.com>,
        Felix Gu <ustc.gu@gmail.com>, linux-kernel@vger.kernel.org
References: <your-message-id>
 <20260410214130.188694-1-piyushpatle228@gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260410214130.188694-1-piyushpatle228@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=PuijqQM3 c=1 sm=1 tr=0 ts=69da597b cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=IpJZQVW2AAAA:8
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=JwGy_oeBAWJtcqKhl6AA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: UxwP2X2Lz6CB3e4mLzifY1ElUJIU-KGW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDEyMyBTYWx0ZWRfX8KF3+jXHcNC+
 NtZRGcbI8JzcEj7a5sD3G4/3ozSltGXSJrXOv6uPLlAusMM+k6n4MufKxzapETXAtZegZyrKOaW
 e/Oo4Dsle3plHdlx0xA6GWps/lqn6KChM+7lmg2/CMWr5lQOozlG55NlOsl3gTE8pVTno5WlToI
 6+X7eB2so+30nQxugXVmsMHv1mWdKijJ+sZ3AnLhzsLJiQTruIoJXMofXteNlZHSDllz5eMr6Om
 0tl4S7GNJhfTpfpLy5dqqDihd3oUMB1q3Xvimc93RgLtbxJkhjuQDJyfJoZn45ZyjIyV8Hthc4E
 8RAiwnfTJqG3wsUpHew21EK/2sc3NIeDzYwo4SWwpAE9S/3CHhVU/jdpmNsj4zM09NyN0UqSMfK
 Pl/Z1SzFkfz9Ld/be0jRY9NLHKN1qkpuyubhLO5bzm4CFelaKjyGirQCnb0VubLZk8oMvwFYBsU
 G8kydvZ62KUfAi4h8qA==
X-Proofpoint-GUID: UxwP2X2Lz6CB3e4mLzifY1ElUJIU-KGW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604110123

On 4/10/26 23:41, Piyush Patle wrote:
> Use field_get() here now that runtime-mask support exists, and drop
> the obsolete TODO. Since NXP_SAR_ADC_EOC_CH(c) is BIT(c), the
> resulting !-test is semantically identical.
> 
> No functional change.
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>

Acked-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>

> ---
>   drivers/iio/adc/nxp-sar-adc.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/nxp-sar-adc.c b/drivers/iio/adc/nxp-sar-adc.c
> index 58103bf16aff..d6c2a0d50bb4 100644
> --- a/drivers/iio/adc/nxp-sar-adc.c
> +++ b/drivers/iio/adc/nxp-sar-adc.c
> @@ -316,11 +316,7 @@ static int nxp_sar_adc_read_data(struct nxp_sar_adc *info, unsigned int chan)
>   
>   	ceocfr = readl(NXP_SAR_ADC_CEOCFR0(info->regs));
>   
> -	/*
> -	 * FIELD_GET() can not be used here because EOC_CH is not constant.
> -	 * TODO: Switch to field_get() when it will be available.
> -	 */
> -	if (!(NXP_SAR_ADC_EOC_CH(chan) & ceocfr))
> +	if (!field_get(NXP_SAR_ADC_EOC_CH(chan), ceocfr))
>   		return -EIO;
>   
>   	cdr = readl(NXP_SAR_ADC_CDR(info->regs, chan));

