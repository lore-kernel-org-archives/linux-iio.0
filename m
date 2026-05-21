Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A8422A4E9
	for <linux-iio@vger.kernel.org>; Thu, 21 May 2026 10:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779360387; cv=none; b=E15DDWPKfLnezjl852D0YrLpcfplO/bvTYWd2iZLPGru2zWdCMa3wlkKPAHKSM7iyLLMhoX36wx3OkGpJ6H3T8kY1d1Q2mQVaGYmhJSXu2LU6bk27HJPnRcXs+Vo6OUZd2sIsye5lSk/5J3IUcWzwwJNT7HXmN0rWcNUiiKPAUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779360387; c=relaxed/simple;
	bh=jVhyvPOlGGZP2dhEnThLCde+o20TjPBxMscgBABRnBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y9BlrBAAIMyDWC8VvT6sNwfVbEp3Q8Gt80YDbvLlPFW57DKqw/8RXi4rzqRp7Fj+jWgWppxN4h8QnUCq/d0oAVixICvKbcImwKgy6KVigzzbVHvLeJk4bYxFgC9it14w4jjhgdhOOSvWt8n5Fn3ErbhkRhYjSCYpFzGwrN5eaus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ek7OL2jS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GljevkR6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ek7OL2jS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GljevkR6"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64LAXuaq818850
	for <linux-iio@vger.kernel.org>; Thu, 21 May 2026 10:46:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	A/SNYoopy2EXsToW10jxxd+C9bFX/5dG+jDGPVRSedI=; b=Ek7OL2jSVqFHwMws
	3B7K6XwpKRY9kF+wlL/+dccUzdeD+TlxkNzJ+fUAwYCvxuU1Mb1SD8LXgThYFvmy
	7rARM+onQA92fCxjZu/jGa3zgpad+CghTUmsvu8DY9dhFEi8xiGbj67Fl/xq6ERL
	qwrGANfHTq+OgJjxaCPWVxTnstnNDi6f4lN1e/Ttsd6wKLtbLyavUL4p5s1yfvJM
	ou1eTCXNgJq4MAPKvV473Ngyqjk1grVESBqY5jP3rcXqyZY8Sus230fG4OOYSB9f
	ydeu9LIbYTC6iSIxSW+P75h4QydL15IExtk2n7E6SnhOAw7a6bjWo7f0bMzS7nEV
	C8xS+A==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ea0dkg199-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Thu, 21 May 2026 10:46:25 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-36629e48023so5707733a91.2
        for <linux-iio@vger.kernel.org>; Thu, 21 May 2026 03:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779360385; x=1779965185; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A/SNYoopy2EXsToW10jxxd+C9bFX/5dG+jDGPVRSedI=;
        b=GljevkR62BOucESBr29cje4goUS8+RfwouMwQSoARrnQ6dB5NDgvIlVyCVmoRTP4e5
         Bn8bkRrylO7+Kmj5u1eFETJ/wlAWTPUYu1D+QduKlqbvssQj4EoN20hKTmsgLAlnWWbK
         4bvcBY0RFeujH0eFROI4CLckRnb1+onvB67igi/7eMxrhhwSy4/YVvCV37qrygbUsx8a
         19bbAymwOoUN6JHs435NkG1EQ3wBZTLrwDDUiRD0W5JcY1EpJBXU8KvnBiwd9C02kPM8
         o+CYAmu+AAVIUmMA89SZHG+Fa2yYRXb9lvwFiIKn+Rf0boCOXzaOEO0luOQqXvqyvHZ0
         AUuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779360385; x=1779965185;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A/SNYoopy2EXsToW10jxxd+C9bFX/5dG+jDGPVRSedI=;
        b=pQfsLbDvEBLjuaMfp7afEQ1zYsYKjmEoXk9ks4BEtA6/FnwXwFpJg7xAFyB6WOQ4UY
         Mj1cwU/uLwiGpftURIOXR12lNLVazrVMYMC+WDZzO+OYEM6hSGK0sCDAiIgiIvdBKJl3
         8ON/+ZrTjwr3tePt/IkJwPPPjRG9nLUyI0wOzXrWTq1CP0g11rjD5rzXY5otsauBwqs8
         u/QScF44n4r4aB9ZsdJg3l115jyhgxSt/4sS4C9i/ImfJ4DRXesE7KzYovZTllpd9sXS
         9slw7+QhHdISSMu6lpJ2jwKIf8+0aygBVrI8je/8MWgHdFqilL0f4iz2LDek/kuO56Zi
         pacQ==
X-Forwarded-Encrypted: i=1; AFNElJ+kgmvKHqkLdaVl5rE7oo25DDQiS1yYwVXsaeKhwqZ9gJyll3yT2kZ1nqtOzrdEAtGPDon1IZiGTG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqXC6VsWbZ7lPqccPPFkUcsq9jgFH6wqREUydcCq/ARrUAUf8B
	c/KUiEjNLxLNF2QHITZSi+E7E4YYW2LpHg8Gng4mRzf5k5LTs2XRvBryd8RFVI0aFPX7zC4lZ/R
	dFUY5xldKH7+ZjhOJ8WOe3K84xZH7FgoLhiK/KMQ1c24uq9ttB1L2Bqy3kbE9oBA=
X-Gm-Gg: Acq92OGKD/+kcxgaEznlUvuMBY/dT+Og1vtWILOmgIotBUO5Lpq3QP3oUkYdoD09aez
	U0NAm0JMwXBfED+RdQgg2tVC1/Vc7rPSfBCVed0RS9VvCmADlqatLcPfZc+mAU4CGXbnT6NHW2Y
	IixfoKzDoNYZUNphi/eH9nZFbqyqytkx0c6h5tDtr9ZmdoGDk/L6oWt/BJeLEXlX4D8EAHjOsGR
	XNPay/Pxj4C3Gep5DTRxESwf7iN3rs7iyl1A91MqRtQ1TMKKhGEcRi0QNCyFamjitRuW8oIuvqR
	O8t/Y7Y0kqOYnuaEwt2xsZJKDr4oFDdKGUYdfMVauV5C9I4225/xP2+kQt/0F04oYi56JkJi1fN
	66U1grEipeLaHMAjoGdPdBBrsCqTT7QsbzhZS/Z8no6HDjmk8550y4Q==
X-Received: by 2002:a17:90b:2b8b:b0:368:6159:980c with SMTP id 98e67ed59e1d1-36a45642699mr2467187a91.20.1779360384741;
        Thu, 21 May 2026 03:46:24 -0700 (PDT)
X-Received: by 2002:a17:90b:2b8b:b0:368:6159:980c with SMTP id 98e67ed59e1d1-36a45642699mr2467142a91.20.1779360384209;
        Thu, 21 May 2026 03:46:24 -0700 (PDT)
Received: from [10.217.217.28] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a3d1e9300sm2494766a91.13.2026.05.21.03.46.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2026 03:46:23 -0700 (PDT)
Message-ID: <6c876a92-e572-4cb9-8c31-bbf681a4770b@oss.qualcomm.com>
Date: Thu, 21 May 2026 16:16:17 +0530
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
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <20260515145450.3b1e9c3d@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDEwNiBTYWx0ZWRfX+x5GENV8/38M
 /nNvAxhDrJxJ1MlnnredaC8uxkMsgNEW4mN0Vzpu4JsWHIqts4rvvBrL3yakKDmyjJzrE5FQTFg
 Nge4AtcGohyAJ1HbMypEoCoP4zZm+q7wiL5Cs5HL6sEqvaW1pl+0gJvCXMY8t0yt5mkwyH1Diup
 KKKwbY2Nm1uYkDOZ6sC/M/xxbcb/0ASiDsxlD2wF+PZ8qcfNFekgzQTaKwLG+aATdRcGSfn35Qc
 lz5n9pvba/Fw2sYhleTFYlkKsb+I2Q58tPN9ohXLLZejJVtlgGd3N6ctzIT/a8UliphkHl3YNuE
 3hj1N+Q83/rgq5zVXWXSLzKrGio0/SXitzfOM/BUBdHac0AJiKPxD9SFqXoc/xVXscBLwWikQ1L
 eBQgB56JGAqhLZcoXQN5FgHrJElnwkU6E4TOgzOjpVRbbLoUV56hpTZ8/Y395RqTwKx/xuzFYvZ
 Q5/pxDtyF9ElY60/zKg==
X-Authority-Analysis: v=2.4 cv=aueCzyZV c=1 sm=1 tr=0 ts=6a0ee281 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=c92rfblmAAAA:8 a=EUspDBNiAAAA:8 a=4cpjoD5cMJYPUXxCrlAA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: 4CTmJGWvlv0SpPyQnrapsyIsx_xwAZxG
X-Proofpoint-ORIG-GUID: 4CTmJGWvlv0SpPyQnrapsyIsx_xwAZxG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605210106

Hi Jonathan,

On 5/15/2026 7:24 PM, Jonathan Cameron wrote:
> On Fri, 15 May 2026 14:23:44 +0530
> Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:
> 
>> The SDAM0 IRQ can be triggered for both EOC (end of conversion) events for
>> immediate ADC reads done in this driver and for threshold violation events,
>> based on ADC_TM thresholds configured from the auxiliary ADC_TM driver on
>> TM channels on the first SDAM.
>>
>> At present, this interrupt is handled only in the ISR in the main ADC driver.
>> When the ISR is triggered for an ADC_TM event, this driver notifies the ADC_TM
>> driver by calling a notifier callback exposed from it for this purpose.
>>
>> To simplify the interrupt handling in both drivers, share the interrupt between
>> the drivers. With this, ADC_TM interrupts on SDAM0 will be handled directly in
>> the ADC_TM driver, so remove the notifier callback and all TM interrupt
>> handling in the main ADC ISR.
>>
>> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
>> ---
> 
> Some stuff from Sashiko on this one:
> https://sashiko.dev/#/patchset/20260515-gen3_adc_tm-v1-0-39ba29f9b4ab%40oss.qualcomm.com
> 
> Given I assume you didn't see the warning (I'm fairly sure the bots analysis is correct
> as we've been busy fixing similar cases all cycle), can I just check, have you tested
> this on latest upstream?

I had tested on a build based on top of Linux 7.1-rc2 and verified the driver's basic
functionality, but I think I overlooked the warning from the interrupt management code,
sorry about the miss.

> 
> Thanks,
> 
> Jonathan
> 
> 
>>  drivers/iio/adc/qcom-spmi-adc5-gen3.c         | 52 +++++----------------------
>>  include/linux/iio/adc/qcom-adc5-gen3-common.h |  2 --
>>  2 files changed, 8 insertions(+), 46 deletions(-)
>>
>> diff --git a/drivers/iio/adc/qcom-spmi-adc5-gen3.c b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
>> index f8168a14b907..a819c3e627a0 100644
>> --- a/drivers/iio/adc/qcom-spmi-adc5-gen3.c
>> +++ b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
> 
>>  static int adc5_gen3_probe(struct platform_device *pdev)
>>  {
>>  	struct device *dev = &pdev->dev;
>> @@ -818,7 +782,7 @@ static int adc5_gen3_probe(struct platform_device *pdev)
>>  	}
>>  
>>  	ret = devm_request_irq(dev, adc->dev_data.base[ADC5_GEN3_VADC_SDAM].irq,
>> -			       adc5_gen3_isr, 0,
>> +			       adc5_gen3_isr, IRQF_ONESHOT | IRQF_SHARED,
> 
> Sashikio points out that IRQF_ONESHOT is never correct for a non threaded
> interrupt.  The point of that flag is to ensure we don't handle another interrupt
> until the thread is done. If there isn't a thread then it doesn't do anything
> (other than omit a warning!)

I tried at first keeping only the IRQF_SHARED flag here, but it seems that
shared interrupts need to agree on the ONESHOT flag configuration, else the
second interrupt's IRQ request call fails.

And the ADC_TM interrupt needs to be ONESHOT, since we don't want that interrupt to
be rearmed before we have notified the thermal framework from the threaded
part of the handler. So I had to add the IRQF_ONESHOT here too, though it is
not useful here.

I think it's best to use a threaded IRQ handler in this driver too. I don't really
see any meaningful way to split the actions in the interrupt handler here into a primary
handler and a threaded handler, so is it fine if I just make the primary handler NULL
and move all the ISR functionality into the threaded handler part ?

Thanks,
Jishnu


> 
>>  			       adc->dev_data.base[ADC5_GEN3_VADC_SDAM].irq_name,
>>  			       adc);
>>  	if (ret)
>> diff --git a/include/linux/iio/adc/qcom-adc5-gen3-common.h b/include/linux/iio/adc/qcom-adc5-gen3-common.h
>> index 6303eaa6640b..39cbfcbdb101 100644
>> --- a/include/linux/iio/adc/qcom-adc5-gen3-common.h
>> +++ b/include/linux/iio/adc/qcom-adc5-gen3-common.h
>> @@ -205,7 +205,5 @@ int adc5_gen3_get_scaled_reading(struct device *dev,
>>  int adc5_gen3_therm_code_to_temp(struct device *dev,
>>  				 struct adc5_channel_common_prop *common_props,
>>  				 u16 code, int *val);
>> -void adc5_gen3_register_tm_event_notifier(struct device *dev,
>> -					  void (*handler)(struct auxiliary_device *));
>>  
>>  #endif /* QCOM_ADC5_GEN3_COMMON_H */
>>
> 

