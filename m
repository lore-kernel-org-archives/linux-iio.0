Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F398E3DDDB4
	for <linux-iio@vger.kernel.org>; Tue, 26 May 2026 10:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779792832; cv=none; b=ZWlSStEaXgQOTO6Iq7P7DmLvfwK032Pom6yWQBW9PVBVw8oULCqdtdURfqd2uZNw0Dk6vSGeF8W/k/EbW/zMkQMz9d+6GICYyfos3ZsFDDwFhLtBanefRax4iYLx9wOQEI5t5jdx9mGKQJZkQkuuLziRto7OKhFgjqd7/8ZtyYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779792832; c=relaxed/simple;
	bh=eRFI++GY0h29Oj/z1eOEYeAN0omCshxCgUg60gOKDYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NH/rWbiJMbKx0wHKjp0Jbjqs9ZjLCbxVg7sWMCnBQ9Z5+evdVOE0bDsDlsDF3Y4xV5YZakurOdL7KSr9ndcsgErDRQFMmMhwhAvMPXzydueeYK9a1o3h4S/FjiAxG+9MD//EiQiU+y4v5OEOAl64dYuYucCgwNoFXEHsAA6NweY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RmwL3f5m; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Uqb0emVQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RmwL3f5m";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Uqb0emVQ"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64Q7hXGN691689
	for <linux-iio@vger.kernel.org>; Tue, 26 May 2026 10:53:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qJTrqXlFYEY9B3t+nASH9FO5EeUSK4buZxILBrl96ow=; b=RmwL3f5mJSVj/kMR
	yfgSsGb1x2Rcqoy94GpyJnxCTrAYJDJSK8t7jNrw1x1dlphWO09XUsuG6LwvE1ID
	JQ/VAo+XPlXNiE6De+rl8s5Mcakpfmb9u1VwQb107CWEABzIveHNWh8qvXcNMrFX
	LNEZT5sxZatOuvUW2iJyA4O4Zi3kMc8xhLvL6AfRnLOvkdoSkNeHYl2qIhmObHg8
	6RMSTJK+0Q6ZKcDIiOCRZzl9DTsbhXy8AhzYTMjC7xphQMMchvUH60npcHnCL1s7
	TEy0dd9NWWrcAVQstkS21I4y9wjoWflblaSZjhE5vuO6dAeAf5JyoaEL5/akHmTL
	x6raEA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ecpy2kr5g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Tue, 26 May 2026 10:53:49 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b458add85aso114585435ad.2
        for <linux-iio@vger.kernel.org>; Tue, 26 May 2026 03:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779792829; x=1780397629; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qJTrqXlFYEY9B3t+nASH9FO5EeUSK4buZxILBrl96ow=;
        b=Uqb0emVQ/3kExVuMJOCG8pmLJ9zXhMgDJ+iltvfaj5rcJa38MC3YRUZyMg786AxKBx
         /oW7VIL/pmdKObdAKC37LqBP4p1BZI1X86WGIT3i3cKEsvV2tUQPpU8ar01J3+YkyniX
         ALkLVgkc4VJqWtBoqbXSKjx00J/beVhjjs78QHBNjjCzKQI+n+giutv9ObnNpA164+ob
         wM7n0SiCax/o6bO4g1A6WNSAesaSnpyPkMxI6swEsGWCCq+ekVo7PGNJ9ZoMyWdF1QLN
         O3Y1Tc03RsDkDFOKSrDvI609pPc29IvUTE8ubhTmzs9EppH+oASLV+ySoXFJfiU+CgfN
         R2NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779792829; x=1780397629;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qJTrqXlFYEY9B3t+nASH9FO5EeUSK4buZxILBrl96ow=;
        b=R7O8URsvzC3nUxaBqu2Q4XLWn9uer2UrRjTaIW/XHmgMosJNgDdcLwcJNsrupOIPvK
         V4LCSTSwIXVixLtRpVLo59MyS31OG78ay5IKTPoGH2OlmwMkquDaeOz6za4gfbpoA5cp
         AcuBqmoiTKu0JpFvGYIVFdRcEWcyOjL/HXB9OxJMmSgmLtIChb4QLvTGZBiJ1irlrR03
         BSxJAIeXbsNI8TwuRGRA5NzPA49BBEfECxgm2gyk25qjdlO5lukDhK39YEB1G4BAegTQ
         Lf3Cn80eRNKH3E9p4j3ppd+PrPJrYI7eAX6vVnAizwF5coUO3+Wmh45XLbovCjb0w2wp
         uXNA==
X-Forwarded-Encrypted: i=1; AFNElJ8mlOUAZV7n2oDQtp9LCXbSpxA4jxkOnUnQR+26ZEqczsSDFa1s6Usy3gd+hFRWi3EVBt00OBu9oTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX5biLDwz8MrEudiuy8baVcitTsKza1j/BdA0W/Y26U1Lo/bSh
	TCENIARhircmjrAQ7ZybFCovp6QlTBoL/JOQHPHzLSkuWqKMIbl/SBBHXZz7tz2osRAr5YOEAKm
	tR46sZqIjeqM4JdDj5wIEH0ygxPyOKwutKWpmuswrHX/gV7OOYi/WmMEL/uI3g3k=
X-Gm-Gg: Acq92OHvYkZVWrN/ccYF0O3pW14ND9C+PkccXwHINR1+vYMz3YauskWTxdGC5N04CzI
	UQ6UGbwfatilPhXGy/MQrnTBkLUyNzNzi/HywEgviNjgn11QiElweVuRHBkRJZxXSttlPR6l7KV
	k3Zgc69DThf0OIOhwvoJx4N+2Nn9ImToJc+oUt1rMvmnCRtgdmya22b1+p+2dgTZMpD4qIRohnb
	GEI3Z/FACJ3fF05jADlNRMP4SS23lxp2MyJOhMXg5t4jy0TxMOpGN9vEjXGbNiNvk04prT3gmwz
	aSPZ94nbchV5L2anLV1USVJgokkCeVUaQt42Ejl/hMjEnUUpGlOB2Z4Dv+VbJdHfhl/5jXznySS
	jMp/WOX3tOgmWqGdd7Z0HotZtd3cs9UNhlOgtfgNsVJ6KXhtzSC8=
X-Received: by 2002:a17:903:1a0d:b0:2b0:6e60:9582 with SMTP id d9443c01a7336-2beb06354bcmr199316905ad.18.1779792829068;
        Tue, 26 May 2026 03:53:49 -0700 (PDT)
X-Received: by 2002:a17:903:1a0d:b0:2b0:6e60:9582 with SMTP id d9443c01a7336-2beb06354bcmr199316535ad.18.1779792828529;
        Tue, 26 May 2026 03:53:48 -0700 (PDT)
Received: from [10.218.7.34] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58b3cb3sm123368905ad.40.2026.05.26.03.53.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 03:53:48 -0700 (PDT)
Message-ID: <e954c647-397b-499b-ba47-ebfc9a65c2b4@oss.qualcomm.com>
Date: Tue, 26 May 2026 16:23:41 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iio: adc: qcom-spmi-adc5-gen3: Share SDAM0 IRQ with
 ADC_TM auxiliary driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>,
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
References: <20260515-gen3_adc_tm-v1-0-39ba29f9b4ab@oss.qualcomm.com>
 <20260515-gen3_adc_tm-v1-1-39ba29f9b4ab@oss.qualcomm.com>
 <20260515145450.3b1e9c3d@jic23-huawei>
 <6c876a92-e572-4cb9-8c31-bbf681a4770b@oss.qualcomm.com>
 <20260522114722.49b6055e@jic23-huawei>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <20260522114722.49b6055e@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: KoezCJXr0sS7EoQ0F4NDvRSMwBtlXZSS
X-Authority-Analysis: v=2.4 cv=ML5QXsZl c=1 sm=1 tr=0 ts=6a157bbd cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=XFE9V2JDpLeksAh3blAA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: KoezCJXr0sS7EoQ0F4NDvRSMwBtlXZSS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDA5NSBTYWx0ZWRfX9nDZQT/PBJMq
 mIeA50bn3eJTneQ7aL2zmMFCiKnBoUlATgX+kgiTYwZNyrigHTdahGqex6/IjRQ+pHrMPP+4Bnn
 Bd88PljkmWFcEym/rFR6Xg1XuC4bu3mONCkSAlebIYiw0vutrKEwOYJxHY4+OOZ/FFuS1pONFpZ
 /4N36sKuS5ZMEjfWMquCJ1gzN5WFbnrDgRGMTKatf+9Br0SKyUYP6bccSHssLw04S31xcUd3Z5j
 2xECRlFcPNwthIrvqfFGJuq0fmFyyRM4gLZsO8tUHycA8r7pjCrJhSCIJN5eE4bkDN95dE0ErkF
 iWDL5FtCVySoUy+j9SvucbP4KHdNVz2btUNkLFGuZvK/pocxQlau2rsvt6+imQa5XOWoKHC2AkW
 Ef1NhmtR+iHEWn8lF930HqsUl57Y9r/PAYHIzLygXi4X1rIpu33EW5aAvYvmOLz6e6j6PPDfW5c
 1XHUxvvcHnc/samlvKA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_02,2026-05-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605260095

Hi Jonathan,

On 5/22/2026 4:17 PM, Jonathan Cameron wrote:
> On Thu, 21 May 2026 16:16:17 +0530
> Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:
> 
>> Hi Jonathan,
>>
>> On 5/15/2026 7:24 PM, Jonathan Cameron wrote:
>>> On Fri, 15 May 2026 14:23:44 +0530
>>> Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:
>>>   

...

>>>> diff --git a/drivers/iio/adc/qcom-spmi-adc5-gen3.c b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
>>>> index f8168a14b907..a819c3e627a0 100644
>>>> --- a/drivers/iio/adc/qcom-spmi-adc5-gen3.c
>>>> +++ b/drivers/iio/adc/qcom-spmi-adc5-gen3.c  
>>>   
>>>>  static int adc5_gen3_probe(struct platform_device *pdev)
>>>>  {
>>>>  	struct device *dev = &pdev->dev;
>>>> @@ -818,7 +782,7 @@ static int adc5_gen3_probe(struct platform_device *pdev)
>>>>  	}
>>>>  
>>>>  	ret = devm_request_irq(dev, adc->dev_data.base[ADC5_GEN3_VADC_SDAM].irq,
>>>> -			       adc5_gen3_isr, 0,
>>>> +			       adc5_gen3_isr, IRQF_ONESHOT | IRQF_SHARED,  
>>>
>>> Sashikio points out that IRQF_ONESHOT is never correct for a non threaded
>>> interrupt.  The point of that flag is to ensure we don't handle another interrupt
>>> until the thread is done. If there isn't a thread then it doesn't do anything
>>> (other than omit a warning!)  
>>
>> I tried at first keeping only the IRQF_SHARED flag here, but it seems that
>> shared interrupts need to agree on the ONESHOT flag configuration, else the
>> second interrupt's IRQ request call fails.
>>
>> And the ADC_TM interrupt needs to be ONESHOT, since we don't want that interrupt to
>> be rearmed before we have notified the thermal framework from the threaded
>> part of the handler. So I had to add the IRQF_ONESHOT here too, though it is
>> not useful here.
> That's an interesting corner case.  Maybe the warning needs to be more refined?
> (I don't think it checks for shared?)

Yes, at the point Sashiko indicated, it looks like there is no check for shared IRQ,
although it is checked later in the same function (__setup_irq).

> 
>>
>> I think it's best to use a threaded IRQ handler in this driver too. I don't really
>> see any meaningful way to split the actions in the interrupt handler here into a primary
>> handler and a threaded handler, so is it fine if I just make the primary handler NULL
>> and move all the ISR functionality into the threaded handler part ?
> 
> That's fine by me.  Just add some comments on why.

Thanks for confirming, I'll push again with a comment explaining this change.

Thanks,
Jishnu

> 
> J
>>
>> Thanks,
>> Jishnu
>>
>>
>>>   
>>>>  			       adc->dev_data.base[ADC5_GEN3_VADC_SDAM].irq_name,
>>>>  			       adc);
>>>>  	if (ret)
>>>> diff --git a/include/linux/iio/adc/qcom-adc5-gen3-common.h b/include/linux/iio/adc/qcom-adc5-gen3-common.h
>>>> index 6303eaa6640b..39cbfcbdb101 100644
>>>> --- a/include/linux/iio/adc/qcom-adc5-gen3-common.h
>>>> +++ b/include/linux/iio/adc/qcom-adc5-gen3-common.h
>>>> @@ -205,7 +205,5 @@ int adc5_gen3_get_scaled_reading(struct device *dev,
>>>>  int adc5_gen3_therm_code_to_temp(struct device *dev,
>>>>  				 struct adc5_channel_common_prop *common_props,
>>>>  				 u16 code, int *val);
>>>> -void adc5_gen3_register_tm_event_notifier(struct device *dev,
>>>> -					  void (*handler)(struct auxiliary_device *));
>>>>  
>>>>  #endif /* QCOM_ADC5_GEN3_COMMON_H */
>>>>  
>>>   
>>
> 

