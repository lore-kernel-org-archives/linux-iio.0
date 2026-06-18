Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CC03E8662
	for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2026 10:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781778148; cv=none; b=ezXiXQKMb+zg8BAW64u2yBt4EJwZV7ej685xnh2hPoVbmZy+XpWCkr++/8Czig/yfANil5yUfb4240OkFKoBZRxsNGqCJcOdAWnEyqvZB57LvK+k8CZhVkc2sf5zBtVgcnmnGPw44e4yD436y00f6+nozIqqvqlj2E9t9jg6MHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781778148; c=relaxed/simple;
	bh=7GQkuyRg+UDBSS/P9xS38Vtou4tB13kaAZH5MkFcybA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aJUd3cDuIlR8jVKvuan9Plt7VnBFNcOVWtXxOm1IhvufPJO36iC0rzKWq20G40CwD2cPLezA41gt/Qr4Eplg6EWUVbJZUsplFjqV+L2rRIpSD+R4jE2gmLf8zyHfkW0byPh5KktqV9q7uyOUgcMRHmHWpHaK0+s9iB/SPR5KkBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OKsp7sSk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J+Q3x0ZQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OKsp7sSk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J+Q3x0ZQ"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65I8G14m1157426
	for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2026 10:22:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WXkzGNHSr32PSEXak0uSnyGttjoeqfrsCE+Fxu+JSt0=; b=OKsp7sSkXt71iqPF
	MoEK0azKtufcbzTnjKMsKcLZicqHEtdG5zx1cRIMPPWSnhAYfhYFamCRw5UDukQF
	GC7TqJMHWCdzmCkIQvaqynaXDLENCyXiCaG/CgEBOupPhwwokqXG3TGHWjutST7G
	qj5UE0hEH3vopXmmS2qyfaOGx+fImd/EjTzA5+vAhbE/26k0eoo25s7ta7c6Y96C
	hqlSfVjzcJ+vov/bGEh/Wz+Yycxck93O72JlQRQ77EWrkJFmfc3a/Xw7GYlf4yvl
	yX+V/XKEcwJ3Hc3vRBBNIo3K7iUw6TZZpcHz0vQH63MwTe1hfSyupYG29P1Wr434
	QipzZw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev19a2xqc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2026 10:22:19 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8422b544a4bso529746b3a.3
        for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2026 03:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781778138; x=1782382938; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WXkzGNHSr32PSEXak0uSnyGttjoeqfrsCE+Fxu+JSt0=;
        b=J+Q3x0ZQ2z5hZn3R8ecdMVCj/xVGpem+U6o2DgY9taV9vwt6ywLwAKFrs/i+os/Dad
         Ds5u4GzYW73Jrx+Dc6QwJtThIB8TK1u0lEr6niZ0K8pOE+3xRPxDvj0pUdFcdtE9wf6f
         gGibRLnechQu0CASaSWPwV89A+rBYM4Ml3cgWhDPTl8SPiNrfxfMDw4mKVEktTt8gNP6
         crCEtnbXBPdi2vTNYQQMzJ5EWbFRcu0MaG/l2qrhSUfG137CA9seTlC4UWuFbrc8oogb
         SL4CtwxCwjUm0s9txUVDHHEhyF5xFxBDCcEYJlwWza1dXL21+6/7zoZWypYSQy1q0Zoc
         ADdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781778138; x=1782382938;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WXkzGNHSr32PSEXak0uSnyGttjoeqfrsCE+Fxu+JSt0=;
        b=cY4lRaUBSCUYeeIxGpDI5VYIOUWKOPcJ/OM451eX329OIFAhxwVmmrVQ+W+UCFsmxe
         zS1CM572XHQ9W00rut9H0ckH+e+FSlOMvt+uJrjC9C1BDgF1arp+aYXhJzIFGpMFiV/4
         9wzknfA3k/T3+91ko0wadYDe9Og1znCVFIvX5yXrrdGwUDikhHUdQfqzpmXceS56uDzL
         J9TJw/Ck7SorMromxGfQB6TDxYFr8RWeLrav7fd6dQ4cinKB7XnW6nINArYs+4karsja
         nvoCWJnfvh9xV30H9bmw2kFRPmXWxkTuv9Rx3NI1PgZteiW5+O13gJbcuosM+pTXISyG
         qxtA==
X-Forwarded-Encrypted: i=1; AFNElJ9/ay+2ru7tJy8Dvv4r5faBAtU+rFeRouYmSLN8UEc01/hvG2bUkQxRk6cLz7WoDwqT8TH/hPKLhDI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2gVYBqYc9CHpWM3w2zqITdu2LOYo6OD1Dx0bZfqYMEQK6lJEk
	9Ixo6Hilio/If6Bh+TZ4i5t2PU8IQkWLP7L8lKghZ1aZNue9yRpBsPEskSWnOUS6SaZ4JLt1NGE
	3n6KUDdcinstfg2DDepmGFYM5BP7p8XpAwfNlKm3bUqBSOTmDIpEpoJzBeA8pF/4=
X-Gm-Gg: AfdE7ckDl90dvzgyLwfn/x+5F9Xv4B9wGDEsazTi4RakKmaNeK6TFJTVLLgoyJi0U7T
	LHAwPO9HTZsB40tAiB0Q5Ac1RuxJjybp1yyH/jVtP6yhoZwxG1rj7w/dD9Wj9vbCh5+sSEw1W76
	c8J+g/VuvtomPh8VTLAWeBqhOWaKGQBa7uFSidPsggivwA8Leyn8qFOehO21GXjVAatkHLEyrjA
	ZbIC+p+ZajtJiBZ5FhYNXsLNG9AFU6vpu7Fhe7f4UVFc6jQKdkHiifm21z+ql6tWRzG81ErYJo7
	Zv/ITCIRXXpDm6BgWZqUnpPw0By0p5dpXENbVe6pwNwFehS4O8vdZ+auRLOQjEWq0tHKk78TjiC
	oIwfnORXdg3AIjiQkoOMo6j6dQ/7i7DpGjTnCcmSx
X-Received: by 2002:a05:6a00:4c8e:b0:842:2f09:fde9 with SMTP id d2e1a72fcca58-84541991be6mr2404146b3a.8.1781778138581;
        Thu, 18 Jun 2026 03:22:18 -0700 (PDT)
X-Received: by 2002:a05:6a00:4c8e:b0:842:2f09:fde9 with SMTP id d2e1a72fcca58-84541991be6mr2404097b3a.8.1781778138109;
        Thu, 18 Jun 2026 03:22:18 -0700 (PDT)
Received: from [10.218.7.34] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84535894715sm3890225b3a.11.2026.06.18.03.22.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 03:22:17 -0700 (PDT)
Message-ID: <2bbb3b84-45c8-42dd-8e4c-d5aade9889a3@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 15:52:10 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] iio: adc: qcom-spmi-adc5-gen3: Share SDAM0 IRQ
 with ADC_TM auxiliary driver
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
References: <20260526-gen3_adc_tm-v2-0-702fbac919ac@oss.qualcomm.com>
 <20260526-gen3_adc_tm-v2-1-702fbac919ac@oss.qualcomm.com>
 <ah9ouLQFI7VtHCWL@ashevche-desk.local> <20260604114630.23ca427a@jic23-huawei>
 <aiGPMqHcz_AkUezI@ashevche-desk.local>
 <d095233e-ac2a-4b50-8a62-29fe1e36c2d1@oss.qualcomm.com>
 <aisELR6v1EWGcmqb@ashevche-desk.local>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <aisELR6v1EWGcmqb@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=YbmNIQRf c=1 sm=1 tr=0 ts=6a33c6db cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=QyXUC8HyAAAA:8 a=2FWZ_7yD6c0lXRLnv0MA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA5NiBTYWx0ZWRfX/otzxmDhnnMH
 zaJh3G+exdMJBFjhGeIl5CLIc6G7bsQyDePkBbUKfU6fzaJIPCe1E0H4BQ7CieF8xGSg5EJOCgw
 g3OIOtQ6vGPimQIinS6/6X716hmbLIU=
X-Proofpoint-GUID: ri8LbE0hRdgY2aFvuo1VBQsAxSMtIEnG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA5NiBTYWx0ZWRfX+1Xzp9iNAYws
 l9OxvAQ2bbseHf7AjAKjNJNcZaQLFoXy/W9krQdDwnDQyXCoF+xV56fhXn9uZpWGTfAjFLWv8N+
 AJBGzznas5VDgUROIqlkI8nrB990qDgp+aYxIGVo4CY7MVWQ5o+gS1+55dZk5sBRR4Ur0pxblIr
 Dr2z6rKR8ivF2XxA6wzaV2Jxh3JV7qLKSL5WIcq1BfLOYmz3TSZyYOHA11BOVQNEJnFhxddT0zJ
 YSERJKGxl0HhX9nrpi5+M4UI/WeRHN56WDZigw6FTOP6iHwrKaut/iCN4LN2bQWnvE/Yf8Y/Wp8
 HQxNw6ycolL+KWNgHvogyzvkBPZYY8esVNGznU/IyRfLLMYg2VK0Z1uzJEN1L7RAyxphIMor7mr
 aXEijzQa3CIlHnfWUJw/+k/S2R2nRBVCcSjTbqqr/StIgzOiXBEaLUNKeZMRk3GeBGTdr9ScV1Z
 j76G+x4Qwnxe7RqioVA==
X-Proofpoint-ORIG-GUID: ri8LbE0hRdgY2aFvuo1VBQsAxSMtIEnG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180096

Hi Andy,

On 6/12/2026 12:23 AM, Andy Shevchenko wrote:
> On Thu, Jun 11, 2026 at 04:13:07PM +0530, Jishnu Prakash wrote:
>> On 6/4/2026 8:14 PM, Andy Shevchenko wrote:
>>> On Thu, Jun 04, 2026 at 11:46:30AM +0100, Jonathan Cameron wrote:
>>>> On Wed, 3 Jun 2026 02:35:20 +0300
>>>> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
>>>>> On Tue, May 26, 2026 at 04:26:09PM +0530, Jishnu Prakash wrote:
> 
> ...
> 
>>>>>> +	ret = devm_request_threaded_irq(dev, adc->dev_data.base[ADC5_GEN3_VADC_SDAM].irq,
>>>>>> +					NULL, adc5_gen3_isr, IRQF_ONESHOT | IRQF_SHARED,
>>>>>> +					adc->dev_data.base[ADC5_GEN3_VADC_SDAM].irq_name,
>>>>>> +					adc);
>>>>>>  	if (ret)
>>>>>>  		return dev_err_probe(dev, ret,
>>>>>>  				     "Failed to request SDAM%d irq\n",  
>>>>>
>>>>> Also add a patch to drop this duplicate message.
>>>>
>>>> There is another thread going on this.  It might not be duplicate
>>>> if -EPROBE_DEFER is returned.  The message won't be printed but it
>>>> will be logged for helping debug deferred probe reasons.
>>>
>>> Yes, and I explained that it is duplicated as long as I understand current
>>> code base.
>>
>> After I checked for Andy's first comment, my understanding was that
>> devm_request_threaded_irq would internally call dev_err_probe in case
>> of an error, so this dev_err_probe print above would not be needed.
> 
> Correct.
> 
>> Please let me know if it's better to keep or remove this print.
> 
> You already know my position here :-)
> 
>> And if I make the change, shall I add it in a separate patch
>> before or after this patch in the next series?
> 
> The rule of thumb is to make sure your series won't do ping-pong type of
> changes: when one patch introduces (or moves) some code that is removed or
> modified in different way by another patch in the same series.

Thanks for confirming, I'll add it after this patch.

Thanks,
Jishnu


> 
>>>> So maybe we have been a little too energetic in removing these.
>>>
>>> Or maybe sashiko consumed a bit of LSD :-)
> 

