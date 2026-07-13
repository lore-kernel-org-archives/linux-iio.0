Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C95332A3E5
	for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 16:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783961795; cv=none; b=mbOufZ0K/bvFzzsz4LhLlzkvGzj+x7ln6c9fCSLxoaaHsORZN7UWWvm0yOkxJIiivBazm8WF5GcHPJNHswAZ3LIvWIfuNxEeN3eZIjuEfHQYK1c1ODi76iGyY4BuoOg31yBeshcb57Jeq79iZi2QSvareYlHYsINpIJAfURu/HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783961795; c=relaxed/simple;
	bh=YOVKcvBDcl5QeFIAYmJr3NYTVxrvLURqfEhDCmXKHeY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=looymN9NtPVQk3bm00FI5ShbDUTYbN5+UXP9XERqaVIPvrwAF+H2tWQ89/BcMFtty9kFHRgbuB0FE4hs1WF+BfhS6lBQJkXEt/qqtQPHjgo6QHMwag/qapz8RZ2ztLojHws7lCgWa8hV5lG20OUuHsojIUih760Doxtu0InCxFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JX2omM8E; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ORiy+NfT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JX2omM8E";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ORiy+NfT"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DF89Ol1734757
	for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 16:56:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	r19hJChByIawCiG5mo+xQo8Hdwx6SlRuXbZQ0Q4Wfc0=; b=JX2omM8E8z/tMLmH
	FL2pZTMG2ZNKDMkAxp3C7yP+5WQJrFXtyg0G93RezL4by1z73TfdjYg+GZ5V2y6b
	v9IPI6yW1X4RWTUjziCnYbxSN3KmV84E27YfHYPmPKxsfcS5rbor+NJxHNa6TiIE
	nPjiXm0guxkHo/C96M82y8uqyrN1Iotf8LGOopff3oV2yB+A1tVmgnQYlAz4S0JA
	OIz8oXPxgZ1Z2GUGC9l3oKCNHriAURIGjKGDLEaW0elNxWQ21GhFoD9BEi6cn0fL
	dVtrBJ699iuY8ApfH4PVYDvTMPL3JqdlGkGugZ/kxq/PMU8dGz3XacS4ltGiYiYB
	bpZItQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fctc8jmt6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 16:56:33 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cc88e22f92so69205075ad.1
        for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 09:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783961793; x=1784566593; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r19hJChByIawCiG5mo+xQo8Hdwx6SlRuXbZQ0Q4Wfc0=;
        b=ORiy+NfTwUZjYwT4Zoym4Z5ZG4zLuOu7YU6YL1JXLIn3lyaPWjg1JSwKk8g5wSqCg5
         tTyeDg344/+Eb9dYV6LdHce3Qyn6KvaF7Ls5BNCxokaH+CkCfum5lrUcwNSBwUl53caY
         WmffedMSADT9Th5CQIXFyb4T4jRIf1DD7oto7FrmPVSluMo00KVqzxPJexRCKidno+pF
         jg2nCq+RxtAKE7EK2kSdZmOFRi1Q7GjKPGdfIomrX77a4prQHPH/5kQEqA0alUqu8wdQ
         PBnSoLzzjf396+x0sTZuVPFRT6mft01Pe6Ti0av7Y4JN2xlNJMKwwuObzF1Uvt3mStnW
         x1kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783961793; x=1784566593;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r19hJChByIawCiG5mo+xQo8Hdwx6SlRuXbZQ0Q4Wfc0=;
        b=Gk9WNPGp4MbUldjo6Qyoig/TY+MLW3EvY8dVfDfKKN2P1/r6HbiUNZPSWDk/4aJSiQ
         bQgLTSR2z4FREDqK4W7p8OEzQNazSw8BC9QLoy6X653054x+1bVsqzfbgbTHBG1wivke
         slR9vjdL8yn7stFpePiwX5t+Hap4GKLMPBFB8H4mIkV5F5GyazxTjOfLQ0mLqwP9Q0OR
         F2pesNwLDUS9T1LxGDTbVtR08XUH6B+gBUzzxUIYgE7QHd+KYNZ8tbpRWMnZ/DMnXTfL
         fe4Q1lNoWCt5NTdWXkFiytKfDs4fddhISA+1NVgxefLKHjjt51T9vKOTgf0qoDxjgM5d
         JvNA==
X-Forwarded-Encrypted: i=1; AHgh+RqfgFh/jmFOZaK1l5nV1Fu+413i1EJaa/ezr8EO9Xb/VHJn5TRPainn+GdGUjAlTd4N4NxEy0fBWrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdJf6W1cSiFouzH1YL0AOvnk/ZRdBG/R4T2W7ZVXyDJk5pWA3A
	NNLt1QM/l3QDafGyOz0d8+XMfEmL3QXwXLCG8Jkh73AzaJSqa9garLSD7c3IHuxvKOx2EqDjDtU
	IrfByMsX/TLnIeGUwdmuIDO7ba53hSTAbXzX8KQWIllERcpBw2L4iqU6Y1As5nSQ=
X-Gm-Gg: AfdE7ckjiqd1xfOtKPyB7toVI2PvaS8wHV3fr1kB4HAcOgHELMi035FHdRQ5Nq6ji4Z
	ZKe3Lxj0z/uf6XIWghl7dhDvzn3nK0dFabQq2oKTORdlxkbtE88osBrFQw6yemeEAbmr01eKz95
	Lyp5atpA/adtZ53EZejaUF5iFSFKQBKJfhjllCELF05KEEIUnNphSmAnZlozLCd8vm9VdiANKWC
	gdu3n9lS+eZXZyrCV9ZnaYP7+xqT6sYAkHpmGnjmhexp/wQV5zOBAhr4SrmbDsrDz6WjG92+BiC
	0TsYHahPO6bvW/GkfQB7olVCY8YqT0XWIuSOd3wlTJtk9UeqqWaNZ41aLm+JjyRZNAML+vE93u6
	dZsWCr/Q7PjF2xBnlsacjcki/KZRVhDzQWjxPbb2qWDVRjQ==
X-Received: by 2002:a17:90a:d403:b0:384:8a11:33eb with SMTP id 98e67ed59e1d1-38dc777b95emr10042725a91.24.1783961792562;
        Mon, 13 Jul 2026 09:56:32 -0700 (PDT)
X-Received: by 2002:a17:90a:d403:b0:384:8a11:33eb with SMTP id 98e67ed59e1d1-38dc777b95emr10042704a91.24.1783961792124;
        Mon, 13 Jul 2026 09:56:32 -0700 (PDT)
Received: from [192.168.1.100] ([157.48.180.168])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174ac14f2sm76694721eec.27.2026.07.13.09.56.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 09:56:31 -0700 (PDT)
Message-ID: <cda89e9b-fa5d-4a17-9427-dcdadc0d8491@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 22:26:21 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] thermal: qcom: add support for PMIC5 Gen3 ADC
 thermal monitoring
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
 <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        David Collins <david.collins@oss.qualcomm.com>,
        Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>
References: <20260705-gen3_adc_tm-v3-0-ac62f387dbce@oss.qualcomm.com>
 <20260705-gen3_adc_tm-v3-3-ac62f387dbce@oss.qualcomm.com>
 <aktEMg55d6J_omaN@ashevche-desk.local>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <aktEMg55d6J_omaN@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: zhKjpd3D-XilHP0NDvjulYNayEfWbB5P
X-Proofpoint-ORIG-GUID: zhKjpd3D-XilHP0NDvjulYNayEfWbB5P
X-Authority-Analysis: v=2.4 cv=UtRT8ewB c=1 sm=1 tr=0 ts=6a5518c1 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=62VzjLAzdHZQ3L95IMgkXw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=QSFfxCxHlpgOv1NLln8A:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE3NSBTYWx0ZWRfXzUvr5iuvCHgq
 DS3f/inG5Q3C/zHVzS5QGMx1w7Ybgdak2bAk6/IAf6nLR/K0Q8V/N6uFqVAkIvkj2+ljNXIbHj1
 W45D79GDB+LkZIjyHYs9TvupknkB39A=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE3NSBTYWx0ZWRfX/WXvaPPIryBw
 Qz5STiRnt0RG7Dn10IolicMWIz0IYPe9IIFbgMrzZ9w0ub55XkRCWjQHwh0Zt/1L5wDq6Hq2ywW
 ox7MNJ/KIy6lxyPKlGslrWnUlNEV5fu2R2T9fhjepALOsqLDgWhAeYcrrhvhw5vTT67IWZXAmzn
 LBtP9JsyqZHmK1SNQbjVy+qkSTODOqQ2fMK6Rpe+0FxCPIZBoLPSVIyki2nx4YSyh86oGU+3ACA
 NTF12OgYCyr6+kBw4e/Tngy/wlmrez+iQavJAqe1RLfV9YKtiL0aur61SYQ1i6IY3aTC6mi550l
 Hw6a41v0mSbEpRD8WSaV9Ucza+lz5UhLN2qVgl0rkaYhsTtNqM+/JNrHdxe1gRoGJcG3Azyl2RX
 OirETl0x3agENkzqGZCzd1WtGn70pkeNzuJwDuc/Enea0KsOYV26X/tl5+yJxtoRRVXRXGUviI6
 zNL2D4nCg5nmWaUixVA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 suspectscore=0 bulkscore=0 clxscore=1011
 impostorscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130175

Hi Andy,

On 7/6/2026 11:29 AM, Andy Shevchenko wrote:
> On Sun, Jul 05, 2026 at 10:23:35PM +0530, Jishnu Prakash wrote:
>> Add support for ADC_TM part of PMIC5 Gen3.
>>
>> This is an auxiliary driver under the Gen3 ADC driver, which implements the
>> threshold setting and interrupt generating functionalities of QCOM ADC_TM
>> drivers, used to support thermal trip points.
> 
> ...
> 
>> +DEFINE_GUARD(adc5_gen3, struct adc_tm5_gen3_chip *, adc5_gen3_mutex_lock(_T->dev),
>> +	     adc5_gen3_mutex_unlock(_T->dev))
> 
> Logical split is slightly better.
> 
> DEFINE_GUARD(adc5_gen3, struct adc_tm5_gen3_chip *,
> 	     adc5_gen3_mutex_lock(_T->dev), adc5_gen3_mutex_unlock(_T->dev))
> 
> 
> ...
> 
>> +static int adc5_gen3_tm_status_check(struct adc_tm5_gen3_chip *adc_tm5,
>> +				     int sdam_index, u8 tm_status[at_least 2])
> 
> This function uses exact size of the submitted tm_status. Instead of creating a
> complications to the compiler with all these new fancy attributes, just pass the
> sizeof in an additional argument.
> 
>> +{
>> +	int ret;
>> +
>> +	ret = adc5_gen3_read(adc_tm5->dev_data, sdam_index, ADC5_GEN3_TM_HIGH_STS,
>> +			     tm_status, 2);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return adc5_gen3_status_clear(adc_tm5->dev_data, sdam_index, ADC5_GEN3_TM_HIGH_STS_CLR,
>> +				     tm_status, 2);
>> +}
>> +
>> +static irqreturn_t adctm5_gen3_isr_thread(int irq, void *dev_id)
>> +{
>> +	struct adc_tm5_gen3_chip *adc_tm5 = dev_id;
>> +	u8 tm_status[2] = { };
> 
> ^^^^ The only case for the above function.

Yes, it might be better to call adc5_gen3_read() and adc5_gen3_status_clear()
directly now than keep them in a separate function. I'll update it this way.

> 
> Also why do you need to nullify it? If it's an error condition, the compiler
> should be clever enough to see this. It's not that complicated code.
> 

I think the null initialization is not needed, I'll remove it.

I'll also address all your other comments in the next patch series.

Thanks,
Jishnu


>> +	int sdam_index;
>> +
>> +	sdam_index = get_sdam_from_irq(adc_tm5, irq);
>> +	if (sdam_index < 0)
>> +		return IRQ_NONE;
>> +
>> +	scoped_guard(adc5_gen3, adc_tm5) {
> 
>> +		int ret = adc5_gen3_tm_status_check(adc_tm5, sdam_index,
>> +						    tm_status);
>> +		if (ret)
>> +			return IRQ_NONE;
