Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC3554CF7C
	for <linux-iio@vger.kernel.org>; Wed,  9 Sep 2026 11:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788955074; cv=none; b=ZVCF5+e4eXmpoW/wEjM9dZHOG5TM7eG2hnzui84jr4z8873sbk6VI+EUlYvkMiSiPeS51GeXnFmI63t7ix7FWoIFOSKxE4yP8Cp4YLSaYQ2lBLadW1GrPrqxcgV0y5J4uD+VlaPiQxDdpA2s9OKIsxdCLIp3OZjNwsq1mVWz5KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788955074; c=relaxed/simple;
	bh=lvHuBtyH8PU7WAC9E1zAzmSNFh7r/i19FyIT1zoM1w0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ofCiOsjMPIqq5lSsGivMe/aKOfVt/wHKd0LWukeltlpbTusZvA9tcPZ60tmNUFTuL1WePPblstNCZWMo5qWQaaQ4t6T0VqeotCSN7BLr4mYjdLrQFHih5poDpvMR6CITzQgEI6QLHW1qBAQ6LZyXWz27xMP/7a5435I5Gyuq3OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k5VDNKJm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=N/8cA8Eq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k5VDNKJm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N/8cA8Eq"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689BUbPu2019807
	for <linux-iio@vger.kernel.org>; Wed, 9 Sep 2026 11:57:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PWcE5nOjG7EYYp/TKk7d6uZY3yzA0oSkS2vdFUfogW0=; b=k5VDNKJma4gx7N2M
	bNVnCgOFRaeXbZzGItFtTmYpTv/gBSXOTIG+gOJ7tCdewnPFmTduVh4Cg6/dhKCY
	HAhJQyfQiWH2DVRHJYIWRKz410iLNuLH3u9cMEE5y8VxB1SjQ+CfwTQ7hfIYCZSa
	2ge4VK3Jzo7OsRA8OXKd6Hfr1xLTr8qzkSdW/ooSf2PoHtEHuD2vgvzlw7GpDv4X
	pqIUG8ZhkLV9ezcepSAPRlJSzXwmlhY5mmaLuqiSpLS3wNXu6utg2sWnZ222Gsfl
	dFhdO1kamLsCmebm1m9or8XcSM7NRv9FfubiUSS/JJUsvPkfkzJIxs1MCWPe8eRx
	2O3Oyw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk62x87cd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Wed, 09 Sep 2026 11:57:47 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93102454272so91107785a.1
        for <linux-iio@vger.kernel.org>; Wed, 09 Sep 2026 04:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788955062; x=1789559862; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PWcE5nOjG7EYYp/TKk7d6uZY3yzA0oSkS2vdFUfogW0=;
        b=N/8cA8EqDwEV6vdnPUzkppooAL03ZCnpY5No/yZoOZAGOKht3YkzJOxyJ85qwm3QV0
         ebJUxHRLQwC7wmFx41Pmh1Tiy9Me+Gk2lxUkwV68s/2z83qGHck4fMBasncOmHqnQYR2
         h+ndnUcW10XJ3JH2PE9aF8dpV7GekB3WfzyGWUCGrcXHoGDEiR6BjnJgztGuZslkYzxe
         NSX2m1uhouNqjVBt7Hl/Rr7JNFHGm2CQrsFZg/E5sklhxBy7ALL2DbVXSsh7uQaR7CSK
         kQ7jiu/xIAtmHP0BatE9qV51T00riLk1yuEgGArQSfP0asa41+PVOlfOuCF+ZVLBNQmE
         GUWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788955062; x=1789559862;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PWcE5nOjG7EYYp/TKk7d6uZY3yzA0oSkS2vdFUfogW0=;
        b=ZgHqQON7+UEWkNZyXtoCQXuzIkJt3dIisFLlj6DJ33Hb0XFe4j9VtXYnZWSyc9YB/a
         S1YgHlVka0u3ga100/PZHpB9zPW2bpo1JYPE1oOSiqmNagT69i/9l6E1N0vt6idrfHRL
         D51JSHUhvrpwhs6k9N6LpKOVDNQSFgqMNl0IfvdBJEJ0Y+Dk4/G2A00gzeEipV+FP5j0
         KU77NV9+KZB0xRW/laVFKHrKo0rHUdW4/yh6a0EjPtO/NlVhJdXUqBCDidznJY/IfhYe
         xQ0H1kmEKSn/Fd1wQPz6a2oUDuQM0KloIWnS50LuH1em+yxyDY57jObCWtXcfUnX96dg
         IE/Q==
X-Gm-Message-State: AFuF++n+a8cjTqoW1rWtix+ZlOnnwYTBM7VIXYoT39erVG2FDsDLkhfy
	1BvLyUteffebDKt67QdwxFiKROHq4bbPF+63+Gdd2hcf5Iu5PL2WOz2f36zhVfxYdTZ+I+6rJOF
	3F0Wpc3ykiHkYHfYRDHyfkN3Yp40XWse7Rzsh08e+6TnwkIsp8JSV4EGrUXDtwww=
X-Gm-Gg: AYBFou1LstBf1Z7Teni8Mu16vFEBeg7NED7qQZLD7gO4tTxPaffMEtTvsOTBr1u77uW
	Cq3uq2kwo6g2OB3lmFD+iz1qkRYuPsak8DTNIUn4qf/B0TFczHWj6u6wdjoap1VXGiwl25ggahE
	vOa3vG3a1TOZhfzq1G3OASgd1tn1hbMdSxQxa2WgXUvEVz9AoUWg0nT8RTc+OFkLKCEYEewHHUW
	ipkRYjIj/Lx8iLqy0zTD22K8Uv74pEek2seBRfUYFOUYu0aJ1/FBPkPCk8RJg6NrG0iZatYSrmQ
	FoXk00A135VPK9vl8ntHOGNT1k9XRkfqbm8ssn7JoFxDrMiSISAIOJh8SFWUlLzU17qjkQOxTIA
	ZdtOX7HANc+DrnNt1C5sD5g==
X-Received: by 2002:a05:620a:9c4:b0:939:9205:4d78 with SMTP id af79cd13be357-93992054effmr1798965085a.3.1788955061616;
        Wed, 09 Sep 2026 04:57:41 -0700 (PDT)
X-Received: by 2002:a05:620a:9c4:b0:939:9205:4d78 with SMTP id af79cd13be357-93992054effmr1798961285a.3.1788955061188;
        Wed, 09 Sep 2026 04:57:41 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a94f2e167fsm1614641a12.26.2026.09.09.04.57.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 04:57:40 -0700 (PDT)
Message-ID: <cf856c97-ea82-4a33-aa9c-57cd317e5b79@oss.qualcomm.com>
Date: Wed, 9 Sep 2026 13:57:35 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] arm64: dts: qcom: glymur: Add ADC support for Glymur
 CRD
To: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Amit Kucheria <amitk@kernel.org>,
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
        Priyansh Jain <priyansh.jain@oss.qualcomm.com>
References: <20260731-pmic5_gen4_adc-v1-0-9c49b2eea6f9@oss.qualcomm.com>
 <20260731-pmic5_gen4_adc-v1-6-9c49b2eea6f9@oss.qualcomm.com>
 <52c023c0-a61f-4116-851f-ed19de4d23f2@oss.qualcomm.com>
 <695dfc01-2c1f-4503-9049-2ae266774ed2@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <695dfc01-2c1f-4503-9049-2ae266774ed2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDEzMiBTYWx0ZWRfX6XcZ+y6tsCS+
 OAkbI+03sP4+EntPWaJHFrkfwBDfvU4Ro9081doU6l6cVZyVUiQWeXW3f7AHsxZRIHCYYLAxxH3
 fQDpI1THL0q27UrotKDHiozDcmocpVU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDEzMiBTYWx0ZWRfX85LjO4cKJ9ig
 l4Z6pMUQ01xmPyLgwKSZGT6fg1L1WpSMB29Cj4ako/8g/eOl5Ft8j0LlsdLyxxOa+hUMjIajeOx
 jB6h6baaEHWe4Jus/T+cto9d7s1drr9SiZhw7DAjQcKBoK1gO2ZyoI/GeNv3zVtA7zDb0jk5rJq
 oiQV3gf4EF5gaEYuC14+c7CEGvcg3uHu+c5rNJdMpNN1eH5+aXm8Lffiq72dwoCv+etdQrGIWK9
 gtrOsLObHlaxFPD6H1AsPssndxaM03HzNheQ2CcklADe/jjOUwVknzDtG4J4CYAEoYpLMWXJ9pR
 FJqrZh1TEX5gFs0He/QnsBcFE7QVWl66Pc0lNcOUfmtaD4sCGpDYLOseOB4GlEft18Avy3bMez2
 Ry6WSv23wS5dIp1Uahb75f1RSG7GKalctK12/gZXni9MjTlcIOTq/5O7LNWRp7CazgflJ0WyJHh
 +Lq0lTC6Ky9wZKO3ueg==
X-Authority-Analysis: v=2.4 cv=UeFhjqSN c=1 sm=1 tr=0 ts=6aa149bb cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=CY4bWrPPlyhwilDFwNAA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: 1Ha_WIp1dh-0afOAbqO02cuuAn3pbEIQ
X-Proofpoint-GUID: 1Ha_WIp1dh-0afOAbqO02cuuAn3pbEIQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090132

On 9/9/26 12:39 PM, Jishnu Prakash wrote:
> Hi Konrad,
> 
> On 9/3/2026 2:19 PM, Konrad Dybcio wrote:
>> On 7/31/26 8:06 PM, Jishnu Prakash wrote:
>>> Add the ADC channels under the PMK8850 ADC node for the
>>> other PMICS on the board with ADC peripherals. This includes
>>> die temperature and VPH power channels per PMIC.
>>
>> [...]
>>
>>> +	thermal-zones {
>>> +		sys-0-thermal {
>>
>> Please name it xo-therm or something similar to make the connection
>> more obvious
> 
> Sure, I'll update the node name to "xo-thermal" and make similar changes
> in the other patch too.
> 
>>
>> [...]
>>
>>> +&pmcx0102_c_e0_temp_alarm {
>>> +	io-channels = <&pmk8850_vadc ADC5_GEN4_DIE_TEMP(0, 2)>;
>>> +	io-channel-names = "thermal";
>>> +};
>>> +
>>> +&pmcx0102_c_e1_temp_alarm {
>>> +	io-channels = <&pmk8850_vadc ADC5_GEN4_DIE_TEMP(1, 2)>;
>>> +	io-channel-names = "thermal";
>>> +};
>>> +
>>> +&pmcx0102_d_e0_temp_alarm {
>>> +	io-channels = <&pmk8850_vadc ADC5_GEN4_DIE_TEMP(0, 3)>;
>>> +	io-channel-names = "thermal";
>>> +};
>>> +
>>> +&pmcx0102_d_e1_temp_alarm {
>>> +	io-channels = <&pmk8850_vadc ADC5_GEN4_DIE_TEMP(1, 3)>;
>>> +	io-channel-names = "thermal";
>>> +};
>>
>> Are these going to be always wired up this way on all Glymur boards?
> 
> I'm not sure what you mean here - each temp-alarm peripheral here
> is using the die_temp channel from the ADC on the same PMIC to
> read the PMIC die temperature. Die_temp is an internal sensor
> and the die_temp ADC channel is always present on any PMIC
> which has ADC, it is not like thermistors which are optionally
> connected to AMUX/GPIO pins and can change between boards, so
> I think we can consider the above configuration will not change
> between Glymur boards.
> 
> Does this answer your question?

Yes, thanks, I overlooked this

Konrad
