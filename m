Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C55D406812
	for <linux-iio@vger.kernel.org>; Wed, 12 Aug 2026 09:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786526521; cv=none; b=U959mbOAaW8rKezvcGiX8zfUyrXzXJG05Y64XC4aaheRHnucRnWo1qBG8S0vIfh60h1bIs28ScCnRL3aXEwt9fa9dE024aeag52NwcnUtV6Ly3NmPLA4K5UfIax9ThcsMyomnPXELpV0pEikaxvxIETnoDM0xs9WS2YYEom7d7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786526521; c=relaxed/simple;
	bh=jvzPuBmH1jjZIV65CBV2Lt6mKqMcCPkwxjV/Li/4fcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e6VS26Hg3itR9Nc4uRaD14fdyzEczgLQvjlHz11z6RdyScCzZEZC3dmyuAbpn2WzVqYFoMsx3lMx2MHOvbQJ+KZup5b0P2FoBYPHbxLscK9rA3oj8NZ7+ZHowgH+mErvUNm8/yN++jAlv2ZDKSUMARt/O2qWMvpVq0ms1Q3nXMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TM4Sfrhf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NXPmA4hM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TM4Sfrhf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NXPmA4hM"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C8YAcT2526876
	for <linux-iio@vger.kernel.org>; Wed, 12 Aug 2026 09:21:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HfXtH3ktPoM1ChNA/H/V/L0UKO0QHDZrtEJ/UsptBis=; b=TM4Sfrhf/bdcAEV8
	70gF4pSn5/DnzWS7Bf+mXfDZ/hieLttGQMI0vfYcz9bjC/i65sst4RBlGGDlqEaZ
	7zeo+tceh7S6deNDbajraA8xWAXeOjCNQsCkgfZtnMxLJyiKDuT/fnxoFoQp6cnT
	ww47xaLdfvmHohna59gR4c81E4r8N9fMhH7zVSwaqAgvO4iE0Aq3dvgQRw84RaAH
	HNTYECtDRi6TALEWdLs6Bok6cQjvyPWAzH9dZQxTlh0sZQBS1dsX4gUrv2neWwKo
	TlcvKQNo/IwWblxOj903jGyvbxeBGRqIEM4J35gW2roStDGyBYoSHRQFMukXamt/
	E5nfAQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0mnd8c37-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Wed, 12 Aug 2026 09:21:59 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cab048cdb3eso790801a12.0
        for <linux-iio@vger.kernel.org>; Wed, 12 Aug 2026 02:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786526519; x=1787131319; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HfXtH3ktPoM1ChNA/H/V/L0UKO0QHDZrtEJ/UsptBis=;
        b=NXPmA4hMIZWBRFrQfVhsNnDHBfoZYyzG5x4MdU9OTMuwl56RSnBiPZjTSDj3hQH/5Y
         x+t0EucOcUj3lZ+68hySBnFrUCSmSg62ghnlaH8MGupj4DBDLMzRt3eReNIMldPINhjv
         UlPcG31fLAU3vbfioG5m0D2tFMSOkOECO/ZiIvTv/P99WBI7xoiatoS0BZB8qqMfmdcD
         esP8fntWhkd/T3p65DsNra/0KtZHHnuI1t6idgwji7c9XO2wjbOLk9JAcfUryMjX2EiF
         goLFKSV9Qq10dn8KfPg5cTAc6YAO2Al9c/XrhqDQLQB/mOQFlmf/YaLWB7OYFqNTd61H
         oHhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786526519; x=1787131319;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HfXtH3ktPoM1ChNA/H/V/L0UKO0QHDZrtEJ/UsptBis=;
        b=jSF1DXchxlMKTtcpZ31aHiq7ihqC7Gd8b2N51lbXFM6aG1bt6SkL9DHxJpOjl+Y2IP
         QQKK4Aj+zgmvEsnyz5pqOzv+RSaEvpoROGooyv2uhqo1EYMRLyogId2MCgikLjlPCS54
         awE8AiUxp4iG/QHDxX1ELSW+PBi7Gq3/cT2Ltr47AovUZsjDsgAhFox4KQC0n2Yt2XJq
         svjYoenksT6UAm7/T4xZPTw2Np4rcchNfOHMsDkjlEcHnQc3RYyj8f5FTT0Ft4KHR9+j
         QVWmrYXh3+Mh/bZZaKMuQaejhPNt3oOUJkMfYN2CoKQ5VTyUm0EGzn1Gj8an5q5wMJ7u
         KcDg==
X-Forwarded-Encrypted: i=1; AHgh+Rqt6H/JwebM5BLvei9cFNEMppbLZEZIggT8SAiCdotKF388ta2b2mt8SxAGP0jK2P++r0QM//i4EfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzIqG8+bXMEwxg6OZwfcgTodQuFSm4Ex6A1NrI036HBlvDxrze
	1XrXOM8Ap0PDu1dVkU9Ug0UwqTLnwUCwLITCM8J23hpBi+VuWGHUPDDx+MI25xMOPRv0MbcYpZ1
	bGDqsM2OoKJMsBOF6DRxMXHxDeT0RuAfNBxwjk6ydULzwxU0xQqhuayZUFm6Zvp4=
X-Gm-Gg: AR+sD13ILEmBArrDFqIsPWTVeP7iFt9PHS1ascM+KmSXVbeYshA/a+Azdks/LZPew6/
	dE0XM5gcJ9SBGA9E4TOqbRq2uRhbE+ojEYe31q+T0hs+mC52qIniOnRIbk/cBMUXaAZWJ37GEpO
	2dVnuJj1fh/pVR5PO+33qaRzMpLmH5w5TbbSmej8YtqAm3oCLh/ZDthE/XeFvpMzMk8vc7QClnO
	8vztTbu7lSQDvIwpmH2dqdST3/UEtC3zuDdE7dBr4YIS63ZRPr01eEOsI82JZcPpxzF0MalGpzD
	D1NjbET86RB8eGu/hw1W1oOqjqmxnymwpNvfN6rVi4lWVKILbFEwaqrv95C1u4zMuqwWFTI6o9u
	EVnU5Kw4NM2qHBlRzHMv4iTn9tCd5aZP3
X-Received: by 2002:a05:6a20:d709:b0:3bf:e761:6285 with SMTP id adf61e73a8af0-3cc3f7433ecmr4293936637.29.1786526518801;
        Wed, 12 Aug 2026 02:21:58 -0700 (PDT)
X-Received: by 2002:a05:6a20:d709:b0:3bf:e761:6285 with SMTP id adf61e73a8af0-3cc3f7433ecmr4293871637.29.1786526518355;
        Wed, 12 Aug 2026 02:21:58 -0700 (PDT)
Received: from [10.217.217.28] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbee7d52d4dsm387903a12.31.2026.08.12.02.21.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 02:21:58 -0700 (PDT)
Message-ID: <88e4737a-a791-46d4-af33-d9de57e6d835@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 14:51:48 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] iio: adc: qcom-spmi-adc5-gen3: Add support for QCOM
 PMIC5 Gen4 ADC
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
 <dlechner@baylibre.com>,
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
        Konrad Dybcio <konradybcio@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
        Priyansh Jain <priyansh.jain@oss.qualcomm.com>
References: <20260731-pmic5_gen4_adc-v1-0-9c49b2eea6f9@oss.qualcomm.com>
 <20260731-pmic5_gen4_adc-v1-2-9c49b2eea6f9@oss.qualcomm.com>
 <aneaaJ_gmyyLh8mY@ashevche-desk.local>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <aneaaJ_gmyyLh8mY@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA3NCBTYWx0ZWRfX/3EMx/1/1Cki
 SBxqWbYbDUQpDV8efYreLI7z/Gav/bV8WLxy6Gter/z0ktsJWoMCY7tN5mWtPLPiooMeJwmlndy
 xHVIlRw5GjMnRJ6AfiOAxu/UGTVQZ/4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA3NCBTYWx0ZWRfXxYqjy/7OvBFj
 z7tTolr/zAu/R8lsCEhnlTnHtE+A29Q4dVUOw2P/DzajnGNLRscW/abrvyL+FXV3O6UTylr6G1Y
 CgegUtA/7OGhzX/SWfq7ieTqTdneKGTG9YFTb99Z9ocFFGoZG54fwJXFx8Xl0rdeJ/qRGQoGmpf
 M05gBKQDXMNe7yScb/hC2+5O+qyV25Uk6oqk24JikdjPLX9DO8x+r2xBABir3snKhcFpLGk/Cro
 8G/+3wxs2dJVJYq31J4+gySV/N8XnSxToMrtoZPD66+KLJuGjqRr11GRxW95fv3qwvUAPaOTK+2
 EaM91Z1D9y7D3ipdafg1YlX/oEgW24g/f5j1yf+5NMLxdsAynPPSICk8qUKNvLtRrlq/v4ez2NQ
 7auPYFj2UNx7nZFmNyHnPgZV2aDTM00W1zsWBM9sVAVC5Kmi2tDYkx+goIEqdCWWsQnNrxCwx5g
 ZBkWU+Dbo7ktLzimBgw==
X-Proofpoint-GUID: T8RCjO8c8WxVBZOMraDTcSEBEfbpUj_k
X-Authority-Analysis: v=2.4 cv=C87ZDwP+ c=1 sm=1 tr=0 ts=6a7c3b37 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=TjZioY23ztXOLIvkaGkA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: T8RCjO8c8WxVBZOMraDTcSEBEfbpUj_k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120074

Hi Andy,

On 8/9/2026 2:36 AM, Andy Shevchenko wrote:
> On Fri, Jul 31, 2026 at 11:36:15PM +0530, Jishnu Prakash wrote:
>> PMIC5 Gen4 ADC is similar to PMIC5 Gen3 ADC, with several changes made
>> for improved performance, mostly at the hardware level.
>>
>> One significant software change is that ratiometric conversion resolution
>> has been increased from 14 bits to 16 bits, so the maximum value of
>> these measurements needs to be updated for Gen4. Add a new scaling
>> function for thermistor channels which use this type of conversion.
>>
>> In the latest PMIC arbiter version (v8), there can be up to 4 buses
>> under the PMIC arbiter and 32 PMICs under each bus. In order to
>> support communication between ADC on the master PMIC and ADCs on any
>> of the other PMICs, a field of width 2 bits is added for bus index
>> and the bits for SID are extended from 4 to 5 bits, in the SID
>> register. Add support for this.
>>
>> In addition, it is possible that the master PMIC has ADC of one generation
>> and it needs to communicate with another PMIC with ADC of a different
>> generation. Add new DT properties "qcom,adc5-gen3" and "qcom,adc5-gen4",
>> to distinguish Gen3 channels under a Gen4 master and Gen4 channels
>> under a Gen3 master respectively, to ensure that their conversions are handled
>> correctly.
> 
> ...
> 
>> +static const struct adc5_channels adc5_gen4_chans_pmic[ADC5_MAX_CHANNEL] = {
>> +	[ADC5_GEN4_OFFSET_REF]		= ADC5_CHAN_VOLT(0,
>> +						SCALE_HW_CALIB_DEFAULT)
> 
> Always nice to see a macro with the embedded comma...
> 
>> +	[ADC5_GEN4_1P25VREF]		= ADC5_CHAN_VOLT(0,
>> +						SCALE_HW_CALIB_DEFAULT)
>> +	[ADC5_GEN4_VPH_PWR]		= ADC5_CHAN_VOLT(1,
>> +						SCALE_HW_CALIB_DEFAULT)
>> +	[ADC5_GEN4_VBAT_SNS_QBG]	= ADC5_CHAN_VOLT(1,
>> +						SCALE_HW_CALIB_DEFAULT)
>> +	[ADC5_GEN4_DIE_TEMP]		= ADC5_CHAN_TEMP(0,
>> +						SCALE_HW_CALIB_PMIC_THERM_PM7)
>> +	[ADC5_GEN4_AMUX1_THM_100K_PU]	= ADC5_CHAN_TEMP(0,
>> +						SCALE_HW_CALIB_THERM_100K_PU_GEN4)
>> +	[ADC5_GEN4_AMUX2_THM_100K_PU]	= ADC5_CHAN_TEMP(0,
>> +						SCALE_HW_CALIB_THERM_100K_PU_GEN4)
>> +	[ADC5_GEN4_AMUX3_THM_100K_PU]	= ADC5_CHAN_TEMP(0,
>> +						SCALE_HW_CALIB_THERM_100K_PU_GEN4)
>> +	[ADC5_GEN4_AMUX4_THM_100K_PU]	= ADC5_CHAN_TEMP(0,
>> +						SCALE_HW_CALIB_THERM_100K_PU_GEN4)
>> +	[ADC5_GEN4_AMUX5_THM_100K_PU]	= ADC5_CHAN_TEMP(0,
>> +						SCALE_HW_CALIB_THERM_100K_PU_GEN4)
>> +	[ADC5_GEN4_AMUX6_THM_100K_PU]	= ADC5_CHAN_TEMP(0,
>> +						SCALE_HW_CALIB_THERM_100K_PU_GEN4)
>> +	[ADC5_GEN4_AMUX1_GPIO_100K_PU]	= ADC5_CHAN_TEMP(0,
>> +						SCALE_HW_CALIB_THERM_100K_PU_GEN4)
>> +	[ADC5_GEN4_AMUX2_GPIO_100K_PU]	= ADC5_CHAN_TEMP(0,
>> +						SCALE_HW_CALIB_THERM_100K_PU_GEN4)
>> +	[ADC5_GEN4_AMUX3_GPIO_100K_PU]	= ADC5_CHAN_TEMP(0,
>> +						SCALE_HW_CALIB_THERM_100K_PU_GEN4)
>> +	[ADC5_GEN4_AMUX4_GPIO_100K_PU]	= ADC5_CHAN_TEMP(0,
>> +						SCALE_HW_CALIB_THERM_100K_PU_GEN4)
>> +	[ADC5_GEN4_AMUX5_GPIO_100K_PU]	= ADC5_CHAN_TEMP(0,
>> +						SCALE_HW_CALIB_THERM_100K_PU_GEN4)
>> +};
> 
> ...
> 
>>  enum adc5_cal_method {
>>  	ADC5_NO_CAL = 0,
> 
> (here as well, see below)
> 
>>  	ADC5_RATIOMETRIC_CAL,
> 
>>  };
>>  
>> +enum adc_generation {
>> +	ADC5_GEN3 = 0,
> 
> Why is this assignment? What's wrong with the C standard?
> 
>> +	ADC5_GEN4,
> 
> If these are related to HW communication protocol or bit fields, all of them
> must be explicitly assigned (to make code robust against changes in the middle
> of enum).

I see that ADC5_RATIOMETRIC_CAL is used for bit fields, but ADC5_GEN3/ADC5_GEN4
are not used in HW. I'll add a fix patch to explicitly assign all the enum
values directly used in HW and drop the assignment for ADC5_GEN3 from this patch.

Thanks,
Jishnu

> 
>> +};
> 

