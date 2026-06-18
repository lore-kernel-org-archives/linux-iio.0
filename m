Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A613D890F
	for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2026 10:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781778165; cv=none; b=DoO2XEiPrEaO4jA7fYEh+TwQBqDK1i14k79cogyp7ac+iyNZrWsZVA+myoXUsJWsN5RYlt3TAhEEBn/8hGR/eCq+c49GhqOEo2K6BOpuAWYq1fzhJ3yIjM3vBymlJCbuTXDcTkskslUHmJNDt5Ixuz857StTXOL8kYJa28ny1a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781778165; c=relaxed/simple;
	bh=DMLp0zDdJ/9XJpbbHtisG5K265zhnwPmo6k6Z4juAGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mctlmnD5FVuXTiDeQSsFkt7pGtKQsEtdqTIkbx2FUNFMgiSiBeBtkgWBIBdHReFLTBoUor07EB+IX1CHmzmwPpMWf4DOjXWgcxq3sNspNjxtWoCEbwImO5OQIjDXSlTpSuyiq4CIfQdyXmL9UPOQgdkVLkjr61DiXuJJcZ4aKO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y7WCSuax; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PSg0eGZG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y7WCSuax";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PSg0eGZG"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65I8wxPS722518
	for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2026 10:22:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AcN2ezsmfuVyLx0id69tXIlCQ7vrpJyBzJwuPr7tn+U=; b=Y7WCSuax9fBD9T5P
	pG05vgRzpQMSCoeZJJtqqcwU3+P7Sfo7+5jsgnAAdbWPDo232ek5XRTHCwtWqCDg
	OlF3eSWOkCw8VNyJIB6tPfMU7upxT+eJGSanzIvJ2YPfJUHewsaPA0uGOE9IPts0
	95Xfz91bY2MfcTo1aaXtefDHg9Bb3QayRpRL6suJ30HYuLU/Nt8OQm95C0Xe3n5H
	4Ah/1o35QaS0YQCS0tHMV5UcSWgPu1Vmc9BMFxbKaAQPz1UNmx0xZ8pzsgtigwmV
	Y1OtAEknyIb1xcTmSfRT8RUkAreNmRHkE+buUGgBzQ707Gf0Z+ntxWOKHN3Jh27m
	sFreJw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evdn409gg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2026 10:22:38 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-845319bb97bso760257b3a.0
        for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2026 03:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781778157; x=1782382957; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AcN2ezsmfuVyLx0id69tXIlCQ7vrpJyBzJwuPr7tn+U=;
        b=PSg0eGZGuKGlHER5zvNbAorWtMqxTSr3LGL8iw/kVq2hQOhARRc78igiaho2ZvoB4D
         tR5HrhPt6znxxMQfOf7MesDcSayOYfK12Z8fYdKEX2ecJHPqQBhZ0tEyfgqPiTbnGOUo
         DeTtdGoe/RgOeb6fGidU3d73whMlaLnrdHqmNQiU1Q4Z2aG5H4BrqIdxGo5W3/iAx1Uk
         X1TwRiXxlSn2bBbVm1npWGFh2Ikfy7cRZ5l6YhJkx6SZNlsVcXRihRHzaHcQrzHK9mod
         sB7PdWFytqkiNmIJ5xaqK6nNaoL+7wBLLh1WIgD3yhF4467omacs92hP947Xjh94pYpd
         Sl4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781778157; x=1782382957;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AcN2ezsmfuVyLx0id69tXIlCQ7vrpJyBzJwuPr7tn+U=;
        b=E/ciHixljcQuC0ATIXcznr1jA6Uo3sAdPRXiS+DO+AGk4BHLf4SR9qU6/u8b0hbk8Y
         jqhQnLuylAArPFN930ekgMnw2XPI98VEI5iWt3+CBoYjOE9hpsoOzsUPlI2mDV+d4fi4
         Cnl3/NCW9rRT1dnPVD3vG9q1+4vF2dQ2d5HWBCVXOs3iuFlNipVCnwpNjTEj/JVD8HMK
         UjVN3M3wjdDeIrPMEsEvgSIPLc/GLwLY6Rhf7kCfX1F46Kcy6X4ycFQzGIxo8wQvKnCU
         gqb/1NbdRiUjw4gdFZ/D8tKjBocNcokqmRccE8RNjjClfvutNIp86braDf2zXcuG+B9V
         +GLQ==
X-Forwarded-Encrypted: i=1; AFNElJ8KRnET0ZFCbOYXe5J7565GyYHijITVqxiyVEiAe77f60M+015159mcg2GkU52CBRLGTL3on54TeR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEpnbKAPmdH5Ek1cP/qH7xIRxuzzwBf8ixSdRS/8H731UZHsVF
	fOEssSl1BFcIBtVPLFb8qBdvlzoqa6vFTedu4SXz13A5D70iLs53bIW1XjsKSjbrpj9q+LAYf+Z
	9boob0zU6nF0pc1yZ4AzHcmxrSKtaPfUl+H3cecwvx6uGpxpVUTpBdvel1N/BL5Q=
X-Gm-Gg: AfdE7ckyPK/b8+h6RIarLqCBQpSDfCwW2Mx8tAv5Tc0TjkBuY+0FxoLkxQtxwproPtS
	BTIYYkhJcOcRlb1oUAARBe8/PfB0s/TbqEwL9H1EPB14U9jy7PDoKpcZ6TgRdtuWUgB/tUObxhe
	L5Q6qfnIViQ47Q0bVmVGDrR50i0UMckOQyptIBrLIQe2c1l7IFBWw3pvwVSdJeyC6U1uM3XlvZS
	a3WapvzxNGxKP8Cui9pa/LwQUTWm1bhlZlv14jxquCuVpIMBqY7outp0qCzrozwYpQ+0nkxCQcr
	CO+lfv2NHueEhXhQqEZZKHmihd6a6sGs+1tzkpKgZ5sZ9CS7y72GOgp5Bi8hYueZpsmXcde/QAZ
	Z5ZQNhY8yG20FA4JCXa5SY2Q3FKINSb1S4AfC/t/M
X-Received: by 2002:a05:6a00:760a:b0:845:286d:4675 with SMTP id d2e1a72fcca58-845286d4993mr6180173b3a.10.1781778157301;
        Thu, 18 Jun 2026 03:22:37 -0700 (PDT)
X-Received: by 2002:a05:6a00:760a:b0:845:286d:4675 with SMTP id d2e1a72fcca58-845286d4993mr6180136b3a.10.1781778156810;
        Thu, 18 Jun 2026 03:22:36 -0700 (PDT)
Received: from [10.218.7.34] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8453a8c9770sm2293492b3a.40.2026.06.18.03.22.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 03:22:36 -0700 (PDT)
Message-ID: <8ea7d911-8522-43af-8a2f-81ea8479f049@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 15:52:29 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] thermal: qcom: add support for PMIC5 Gen3 ADC
 thermal monitoring
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
References: <20260526-gen3_adc_tm-v2-0-702fbac919ac@oss.qualcomm.com>
 <20260526-gen3_adc_tm-v2-2-702fbac919ac@oss.qualcomm.com>
 <20260527124220.39ac0b64@jic23-huawei>
 <27631a0f-b5ba-4181-94f9-aa7726a4054b@oss.qualcomm.com>
 <20260614200630.2ea04817@jic23-huawei>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <20260614200630.2ea04817@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA5NiBTYWx0ZWRfXxprc1eKpn/vf
 j9qL2jBIAsV1l1ORkygsnEiM/qr8YdXq2960Omq9bapPU1tBc+eIDetjmEOWLfxPox94ieTnCMd
 iL7y3/VawDm4Wdy01Uw1UQ/wKbGKjDX+az9Zu5mRU0Hh1JjCPHjwib/RBO73z4tMcwTamaHSR1d
 0M+ksJZgP5Vslt2zK211BxcLaOGMjn8mBuNw6020737Ea8RBkgvu/1tjJRyDyZRxGBHNp4WFmUR
 s/Jbq3LW2aF674E50C5+VadRfvDJXeo8+RdoJvKM8pMzn8+KhCi66KZvfVv5xaxSg8JioP2Tdvo
 tjbnKLmDbwgH2qFBenA/5NNZP+bbBpxhHTfCgNY3Jirok8lWvWsVjzsi08caYpCaEwtgc/efHQb
 sgvB17a65DNnFC3gz3pC7n9hGSAxIAOgoRf8Hb4phAw5W1ALqMwE06zWFIF+2E5QxZTtRLnuIPy
 PibQPK50b1aFeZAQrRg==
X-Proofpoint-ORIG-GUID: gpImTQv07pOxXwyVzFPw0hhETpomoOcK
X-Authority-Analysis: v=2.4 cv=FN4rAeos c=1 sm=1 tr=0 ts=6a33c6ee cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=DDJsQkWvfQMYwb-dyrcA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: gpImTQv07pOxXwyVzFPw0hhETpomoOcK
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA5NiBTYWx0ZWRfX6LwNrzfrr9Qn
 bEgIzW8MEq3tp3gUpJkNS3UbK9xQa7jn7BtgiRKRHnJ6i03qLn+XIcRbIVfY762xi9wysVfde3F
 LhzGfshqyPkUXcmB/VEIwgZTNLNgiOc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180096

Hi Jonathan,

On 6/15/2026 12:36 AM, Jonathan Cameron wrote:
> 
>>>> +static irqreturn_t adctm5_gen3_isr_thread(int irq, void *dev_id)
>>>> +{
>>>> +	struct adc_tm5_gen3_chip *adc_tm5 = dev_id;
>>>> +	int sdam_index = -1;
>>>> +	u8 tm_status[2] = { };
>>>> +	u8 buf[16] = { };
>>>> +
>>>> +	for (int i = 0; i < adc_tm5->nchannels; i++) {
>>>> +		struct adc_tm5_gen3_channel_props *chan_prop = &adc_tm5->chan_props[i];
>>>> +		int offset = chan_prop->tm_chan_index;
>>>> +		bool upper_set, lower_set;
>>>> +		int ret;
>>>> +
>>>> +		scoped_guard(adc5_gen3, adc_tm5) {
>>>> +			if (chan_prop->sdam_index != sdam_index) {
>>>> +				sdam_index = chan_prop->sdam_index;
>>>> +				ret = adc5_gen3_tm_status_check(adc_tm5, sdam_index,
>>>> +								tm_status, buf);  
>>>
>>> I think the clear of other sdam interrupt status that sashiko was pointing out
>>> is here as somewhat unexpectedly a function called status_check clears as well.
>>>   
>>
>> This is the full comment from Sashiko at this point:
>>
>>> "Does the threaded handler clear statuses across all SDAMs indiscriminately?  
>>
>>> Since this thread loops over all channels and clears the high status on any
>>> SDAM with an active event, could it clear a pending event on a different SDAM
>>> than the one that triggered the IRQ?  
>>
>>> Because each SDAM has its own independent IRQ line, if the thread clears a
>>> pending event on SDAM 1 while servicing SDAM 0, couldn't SDAM 1's subsequent
>>> hardirq read a status of 0 and return IRQ_NONE? Could repeated IRQ_NONE
>>> returns cause the IRQ subsystem to shut down SDAM 1's interrupt line as a
>>> spurious interrupt storm?"  
>>
>> This sequence of events can happen, but it should not be an issue.
>>
>> It is possible that the threaded handler is called for servicing an
>> interrupt on SDAM0, and in the loop there is a violation detected on
>> a TM channel on SDAM1, and the SDAM1 TM status is cleared. But in this
>> case, this violation would also be handled after we notify the thermal
>> framework at the end of the loop, by some threshold update or disablement.
>>
>> Even if the subsequent hardirq fires for SDAM1 and it returns IRQ_NONE
>> as the TM status was cleared, the violation would have been handled
>> by some threshold update, so the interrupt would not keep getting
>> triggered afterwards for the same threshold's violation.
>>
>>
>> I also checked the conditions from note_interrupt() in kernel/irq/spurious.c,
>> for enough repeated IRQ_NONE returns to happen to cause a spurious interrupt
>> disablement. 
>> It looks like there needs to be more than one interrupts returning IRQ_NONE
>> within 0.1 second to increment the irqs_unhandled counter once, but there can be
>> at most one TM interrupt in one second since we set the time period of
>> recurring TM measurement as one second here in the probe:
>>
>> 		adc_tm5->chan_props[i].timer = MEAS_INT_1S;
>>
>> So a spurious interrupt storm is not possible here.
> 
> Whilst sounds valid, it's a convoluted argument given it relies
> on us getting spurious interrupts reported, but not enough to trigger
> the stuff to stop interrupt storms. The rules around that may change
> in future given it's a heuristic to stop us seeing problems on dodgy
> hardware.
> 
> Can we just avoid handling interrupts for SDAMs that weren't the one that
> triggered this particular interrupt?

Thinking more about it, this would be better. I overlooked it before, but
we could get the right SDAM from the IRQ number and simplify the logic to
handle only that SDAM's channels. I'll make this update in the next
patch series.

Thanks,
JIshnu

> 
> Thanks,
> 
> Jonathan
> 
> 

