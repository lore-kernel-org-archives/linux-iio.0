Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DE639A075
	for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 08:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777277945; cv=none; b=HiOXiABmtotsPkSEVGB06j4rjuzFFlsm5UI5rISrwHQOSBQDyb6Pe7K9wzjc0C9BeskJK0PB/+BWrbovXdm2zH/3wTWuPTvAOc83He7rIWJDnJV/am+4/3brWLLEWDNwuAkMeBmkVseLHykvzLKDddqCOEimiVkuOln2tlGV8zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777277945; c=relaxed/simple;
	bh=J2TZUzyKbhBP8QKXUd6dU18LJ5IcJowSmbEIPSADdyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kF92AKiX406BgUtSL/RT7eBwcevSV393ci5DBGt1CpaObBLUWwTTl2U/Yj2P6/u9YnPj5yejUIUcqJPhLjT0m1U4iaMfX3KHrMnuEnK6OGa60NMUqyO9vx2W1x2sU0WdVaXmD85t4NlD0snRj2kdoUBbET3HQ+EakEcGiR6QynM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jtqvudJ/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Lusci4Fc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jtqvudJ/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Lusci4Fc"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63R7LPTJ1463843
	for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 08:19:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Rc4id9/G0ofQjHwOaT3b3hRz38cbyjQ45C7/+/HoEKo=; b=jtqvudJ/Pq9709S+
	cUByznB4LR2yKhv+KhNnbT46W8mQ4ool2nxxZd+3hVdk9fBVZ/nGVtwzX8Z9bK2B
	P5a79SSnGeyxVU8ABXLcQxutFIf8ygILVXHsTi3nnLnZZBuPSXaqxxcj4BN6yjxi
	7/seMI3smejc/9PNlMozG93tSKpJditgTPFBcqKLtdOoo51E8FItNA22hB0xgQ6R
	fzaP42KmL8MXCWM9/KAusI8mxo270Rj2jJnGSCQSL6Np7aIMoe7QeAtMhjHUH1eC
	oZmDFD54Yi3Ly+xSLYN6a3Do3SqEnuBd6EGXbCjKESrQszn5NPqNPvk2I9oKhWSe
	AzIVUw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dsa4uu4a9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 08:19:02 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50edf0245b0so31022991cf.1
        for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 01:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777277942; x=1777882742; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rc4id9/G0ofQjHwOaT3b3hRz38cbyjQ45C7/+/HoEKo=;
        b=Lusci4FcW/CNXhiXs4PPt3Pmr86C0+7ARUHOqc8FQGIBY9gkJG3rs6hc32clnmaBug
         t4DsBQoVp3MpDejxIo9ANV62TK30S5QBKOHDpW1CXgGAecn6IlmpAPetVmtI6KQuev/H
         AVgwNUtfjeKW9KNnJrIG/tzyLyyFGI19dUOKr7maEnc2HD7kzeos3vKPplC8v0OpeBRp
         qYVthoTCz8A94DSe+4kJ1MgYVkMUC2WJp+hg/dQmr5ZPduujuJhlYfvYEZMrYraDc+UW
         d8Un6TpKebuqiLoMTpfwmhSYBA4Lzso/NjF/8DL7CaAsULNbFlHQxjFRzpxyXEHACyFg
         J8NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777277942; x=1777882742;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rc4id9/G0ofQjHwOaT3b3hRz38cbyjQ45C7/+/HoEKo=;
        b=tVS11mRXwdTCjd8reBeTeBk4a+EjL3lUswm7OIrQy6bNGOGWSCtYVMLmEcSTlzt0VF
         bY+egPxhlsZEwyznPLls7lAlW7S/wCvfqCKFk+a9QUy2TLGmxVt2O3vsu19vh9+3FHWv
         Q4HGOtqas9p5ig82CFzta67MOtNDZj0wBMzeJxmFC/r6/waQ0LMmrPNoWn9akdD7PL6q
         neCYLjQAfR59Cu/mLmbR2QjBOmu3j6D+2EofmJrzKQTlB1qokvQbHetk5aYOGmAGeHr5
         w3vFQk11wLeMJTOb6hVheNp5t47Y8GMDpw+1OnmGAn12HI0YDrVQR+eNxRW5N4WRL5W7
         TIAg==
X-Forwarded-Encrypted: i=1; AFNElJ/sMMrFnxWmAZbrSmbX9gkqh84ilVT5mitaDFmIkb0yw2GvNRpXK81GyP0P2rQjpsNHs45fnbKmk1M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2Lct4qmVgB+k0kIAzL30eqzqI6X4E0JSDgEEtVnSNu5dlw9kC
	4LZe97OrUtGPxjR+/voqO/0dSILwF3hVIC5Nss+Y4+6NRokeRRgH0SmS/WiGMS3bh6sIy93CJS3
	DqD85BbFjVghm7CQdVs5Ybe/1S+7DGzp25c9rAfRqx/tyTPYks9xgsj6HXtjvOE0=
X-Gm-Gg: AeBDiev9ivHSLwDvmEoE06UyxjN5tbbJVuiF2gTmWnV9HPqiT9Ro/qWn1ccb8N0MBCQ
	alZ+YRsBANDbfm+6UnZXn6j1TlbFhi2BARvNCTYjnyr843zMbJ0sbTAIssEX3/XzHoK/fyWgSen
	rj9QhfVACLXGBqxXRgWHgTjTbB+F2+oACjTo0Wk1Ri5E0sIe5sMlX4xz5aP1H1j4UbSkxTKtt5t
	f0FbWfUATZZkG9U8gwUaEt4lSSCDNOJ5Tt45fQIxlwECD5iJJNk7jCBRUTxNrHdWCLGgPXYwpHa
	VhnP2fVFIz97u/75R8KO9B2YtGOeGxee9rQeEUbqle02u/YswboTk3MwLwkVeFW1FHZj3OtLmdW
	gy6anQQ/LBMjtB6CP7FxTOQYA4oApBJ9jJ6or8WPSugP5KhKjZLd+gv8dTHtUZgNTFHt6AkoDCb
	RwgOVCFRd2pS+jbJzo/sA=
X-Received: by 2002:ac8:7f55:0:b0:50e:defb:9dc2 with SMTP id d75a77b69052e-50edefba0b3mr409749461cf.27.1777277941860;
        Mon, 27 Apr 2026 01:19:01 -0700 (PDT)
X-Received: by 2002:ac8:7f55:0:b0:50e:defb:9dc2 with SMTP id d75a77b69052e-50edefba0b3mr409749111cf.27.1777277941230;
        Mon, 27 Apr 2026 01:19:01 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:9464:b7df:8046:49f4? ([2a05:6e02:1041:c10:9464:b7df:8046:49f4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cc0d51sm80260977f8f.10.2026.04.27.01.18.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 01:19:00 -0700 (PDT)
Message-ID: <e1845fc5-254e-4481-b783-5e631d4e506b@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 10:18:58 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V10 4/4] thermal: qcom: add support for PMIC5 Gen3 ADC
 thermal monitoring
To: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org, lumag@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, konradybcio@kernel.org,
        daniel.lezcano@linaro.org, sboyd@kernel.org, amitk@kernel.org,
        thara.gopinath@gmail.com, lee@kernel.org, rafael@kernel.org,
        subbaraman.narayanamurthy@oss.qualcomm.com,
        david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com,
        kamal.wadhwa@oss.qualcomm.com, rui.zhang@intel.com,
        lukasz.luba@arm.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org, quic_kotarake@quicinc.com,
        neil.armstrong@linaro.org, stephan.gerhold@linaro.org
References: <20260130115421.2197892-1-jishnu.prakash@oss.qualcomm.com>
 <20260130115421.2197892-5-jishnu.prakash@oss.qualcomm.com>
 <addDTiI8MB2b_AzJ@mai.linaro.org>
 <12d683aa-44c2-4e2d-8459-78ba9f2ab61e@oss.qualcomm.com>
 <f46ef4af-1c05-4473-9226-901d3393ea89@oss.qualcomm.com>
 <7e619cef-ed08-4454-905c-05ab0939d60e@oss.qualcomm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <7e619cef-ed08-4454-905c-05ab0939d60e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: xqAAtJx3UruMgE4KoB20-dm2NgWpGV7m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDA4NyBTYWx0ZWRfX+WZqCDkCNr1+
 78Q0LQgEEwfuBUUCHA7bXQyg11a3cxjD1ZP0FRJUFTYIE0Mh/rGkPAbM7mEiwwfwCqIYEaYPm9d
 D9bh/rrcwEHVnGauSLOX160gO3QzQHAayUo6PkzvBAlZTFdbm4V9FPpy96RjoI8tmtXaoKS5Aks
 ePSJqOaZj3jPei9F1SK1T7PY7b6EZr31eIIY7c50CgcDOHRyYfM11rZCDL7cZm30rM9ZM7wu6WE
 xRwpwLh7ShUiHNS4xl2Q18/EGsHiK73slBI56vKUSPPiZM8tulWj2zy9CJqT3hv60klwnKmuStm
 pn64Sj5b5BN9YKIIvz/oL2DA7mYmX0pbhswXGd3De9zjqhT4iN6+fMUoap8UG8sqUscLR/d+JsV
 RwwLeoavselPdaH8LDG7hSgbyDNufISfIHLW4CGzylNtQT2D7qYgXHa4Jetvn4IFwFhKdhnYIXi
 VDQwq7/V3Osmr8oeXKQ==
X-Proofpoint-ORIG-GUID: xqAAtJx3UruMgE4KoB20-dm2NgWpGV7m
X-Authority-Analysis: v=2.4 cv=J/GaKgnS c=1 sm=1 tr=0 ts=69ef1bf6 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=Q6r41MFCYhVuxuzLeoIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270087


Hi Jishnu,

On 4/25/26 12:37, Jishnu Prakash wrote:
> Hi Daniel,

[ ... ]


>> Actually, if get_sdam_from_irq() or adc5_gen3_read() fail, they will return without clearing the interrupt flag, so we should potentially end up in an infinite loop.
>>
> 
> I went over this discussion and the code again and I need to explain a few things.
> 
> First, please note that individual PMIC drivers do not handle interrupt clearing by
> themselves - they are under the SPMI PMIC arbiter (drivers/spmi/spmi-pmic-arb.c),
> which is an interrupt controller and the arbiter driver handles IRQ clearing internally
> for all the PMIC drivers under it. So we won't be clearing the interrupt explicitly here.
> 
>> So the status should be cleared at the end with IRQ_HANDLED. IRQ_NONE returned if it is for another subsystem.
>>
> 
> Maybe my explanation above wasn't sufficiently detailed - the "status" I mentioned
> above is not related to the interrupt by itself, it is just the ADC's status register
> reading. If it indicates an ADC conversion fault, the fault has to be cleared by
> calling the function adc5_gen3_status_clear() before we can make subsequent conversion
> requests (like for .set_trips) on the ADC.
> 
> 
> There are 3 main reasons for which the Gen3 ADC interrupt may fire:
> 
> 1. End of conversion for immediate conversion request (handled in main ADC driver)
> 2. Threshold violation for TM conversions (handled in this auxiliary driver)
> 3. Conversion fault (handled in both drivers)
> 
> 
> I think it would make the most sense if I make changes so that the ISRs
> (of both main and aux driver) return IRQ_HANDLED only when any of the above
> 3 cases are detected and they return IRQ_NONE in case of errors or when the
> interrupt is confirmed to be for the other driver.
> 
> Does this sound fine?

Thanks for clarifying. It should be fine.

>> If you think there can be a significant number of errors in the handler may be you should add statistics but later in an additional series if it makes sense.
>>

[ ... ]

>> [ ... ]
>>
>>>>> +    dev_dbg(adc_tm5->dev, "channel:%s, low_temp(mdegC):%d, high_temp(mdegC):%d\n",
>>>>> +        prop->common_props.label, low_temp, high_temp);
>>>>> +
>>>>> +    guard(adc5_gen3)(adc_tm5);
>>>>> +    if (high_temp == INT_MAX && low_temp == -INT_MAX)
>>>>> +        return adc_tm5_gen3_disable_channel(prop);
>>>>
>>>> Why disable the channel instead of returning an errno ?
>>>>
>>>
>>> This is the convention we follow in our existing ADC_TM driver at
>>> drivers/thermal/qcom/qcom-spmi-adc-tm5.c. If both upper and lower
>>> thresholds are meant to be disabled, we disable the channel fully
>>> in HW to save some power and it can be enabled later if this API
>>> is called for it with valid thresholds.
>>>
>>> Is it considered invalid in the thermal framework to try to disable
>>> both thresholds? Should I both disable the channel and return some
>>> error from here?
>>
>> Well, if the channel is disabled, then the temperature sensor of the thermal zone is disabled, consequently the thermal zone is disabled from a HW POV but enabled from the kernel POV.
>>
>> Why not add the 'change_mode' ops and then disable the thermal zone (+ pm_runtime) ?
>>
> 
> I have a doubt about this part - if the thermal framework sends threshold values
> of (-INT_MAX, INT_MAX) in the .set_trips callback, doesn't it mean that the
> framework is already trying to disable the thermal sensor?

No, let me clarify this:

  * the thermal thresholds are set by the userspace to get notification 
when a temperature is crossing the way up or/and down a specified limit. 
Thresholds can be deleted, added, flushed, etc ...

  * the thermal trips are specified by the firmware and should not be 
changed even if I agree there are the writable trip points which IMO we 
can consider for debug purpose

If you specify a trip/threshold point with min=-INT_MAX and max=INT_MAX, 
semantically speaking it is correct but in practice these temperatures 
won't be reached so it is like the trip point is disabled but it is a 
side effect.

A trip point is a property of a thermal zone.

A thermal sensor is represented by a thermal zone.

A thermal zone can be enabled without trip points or thresholds. The 
userspace is still able to read a temperature through netlink or sysfs.

> Or does it just mean threshold monitoring functionality can be disabled for now,
> but other functionality like temperature reading is still expected to work?
> 
> Please note that adc_tm5_gen3_disable_channel() only disables the threshold
> monitoring and interrupt generation functionality - the get_temp() call to read
> temperature will still work.

Above you stated we receive a notification when the conversion is 
finished. So how do you read the temperature if there is no interrupt 
telling to read the converted value ?

> Perhaps I should not have used the wording
> "disable the channel" above, as calling adc_tm5_gen3_disable_channel() is not
> exactly the same as fully disabling the thermal zone.
> 
> Please let me know if any change is needed there - should I return any error
> after calling adc_tm5_gen3_disable_channel() ?

I understand, your point. Perhaps just put it apart and address it later 
as an optimization when the driver is merged and everything is clarified.

>> [ ... ]
>>
>>>>> +    /*
>>>>> +     * Skipping first SDAM IRQ as it is requested in parent driver.
>>>>> +     * If there is a TM violation on that IRQ, the parent driver calls
>>>>> +     * the notifier (adctm_event_handler) exposed from this driver to handle it.
>>>>> +     */
>>>>> +    for (i = 1; i < adc_tm5->dev_data->num_sdams; i++) {
>>>>> +        ret = devm_request_threaded_irq(dev,
>>>>> +                        adc_tm5->dev_data->base[i].irq,
>>>>> +                        NULL, adctm5_gen3_isr, IRQF_ONESHOT,
>>>>> +                        adc_tm5->dev_data->base[i].irq_name,
>>>>> +                        adc_tm5);
>>>>
>>>> The threaded interrupts set the isr in a thread and from the thread
>>>> handling the event, there is a work queue scheduled. Why not use the
>>>> top and bottom halves of the threaded interrupt ? Hopefully you should
>>>> be able to remove the lock.
>>>
>>> Yes, I can use the top and bottom halves of the threaded interrupt as you
>>> suggested. But what exactly do you mean by removing the lock?
>>>
>>> If you meant the mutex lock used in this driver, we cannot remove that.
>>> This is because the ADC_TM driver needs to write into several registers
>>> shared with the main ADC driver for setting new thresholds, so we
>>> have to share a mutex between the drivers to prevent concurrency issues.
>>
>> When using a workqueue tampering with registers while an interrupt handler is doing the same, the lock is needed.
>>
>> But if the workqueue is replaced by threaded interrupt, the lock *may* not be needed because the design may prevent race conditions.
>>
>> That may be not true in this case, I did not investigate deeper in the code to figure it out. Let's see the next version
>>
> 
> I think a lock will not be needed with the change I planned, but you
> can judge it in the next version.

Sure, thanks

   -- Daniel
