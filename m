Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5D13A7849
	for <linux-iio@vger.kernel.org>; Fri, 21 Aug 2026 04:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787288094; cv=none; b=S3o+xbnPJ3pRquxfi351fmOK9H6EpwfpWa54R/Tin/ex+GMd/GdDqBaQOo/zPPeAn2IBbGgqITVsyaA15tTe2HQ2PYNou6oB/289vT5f1aCjXjbeNBcty/Lsj7oRUTqbxlALyV5umqu7ZXJMYN6BiC46w3k/cQpKTJ/yTWm0OCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787288094; c=relaxed/simple;
	bh=jJFqgVQ1xwob2w8K+J2uHQ6676Cn4hsN1VOaawuThpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X0C/uhMC0jeiDbTyo2mmWKt5V0ni6iaIX8NyLS6sXJc1tDCQyfZVxLwr3u3MKNktQQ8/WjQQqyAqPizWz5/FKDd54QvtZM/z6N6F5kJ3n2HF8ofotsa4ccVh6dYh2Tf/+okZbTefurrZCYZQFG72Qe2NhEsEk17fI5MVTalVKak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cCK+nW8s; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XJmpQRSU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cCK+nW8s";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XJmpQRSU"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L4dhZH1907449
	for <linux-iio@vger.kernel.org>; Fri, 21 Aug 2026 04:54:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JVPRdpKQ6Z8b1wwWbv6uhUylN+tu2/L/LH6uVlvCTo0=; b=cCK+nW8s2CiKTrbe
	YjL2ENSbeZfWg+crErkiOyrqwA0DGPwMWm5YK0YBjssY6MTbyHeRxeVq5Axc3/+V
	drtYKlW6TQVGbFPHb77R+6PwXMgLyy4dxSfryUyheDY7MaNyu24G5IEVZdQzVcvO
	6Cv13plEF6f2/+HdysLBdm2cPkiQej7H/U1IlcrsmqvhXn9hq8T/pNJx8DNcAc5u
	8IYmnlzCrM1VXlgH9BEg6VPV5LDbCITTNOFzV9bVgoQtR/Unq0cIbHuV+U4v3dpI
	OFSc5bEvuGXdmQBumQLDNCb0zs39wxVcPE9qe73Ti4xN3JBVwDGJauBjRKf8vzrg
	o8/HSQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6fuhg19r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Fri, 21 Aug 2026 04:54:49 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38fa7b09921so1133306a91.1
        for <linux-iio@vger.kernel.org>; Thu, 20 Aug 2026 21:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787288089; x=1787892889; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JVPRdpKQ6Z8b1wwWbv6uhUylN+tu2/L/LH6uVlvCTo0=;
        b=XJmpQRSUqIDf73TTjFxfswh+Mmm/W1Bk2JPr9fim4SKke+QLpLrFVP8OJdbZg6EI3W
         OxyerVc1DiBpt8bVQ5VfcplOUuNbZ8Sh2Cq5XuIRo+Ou2hzAVQ+7RUNdBs4XDykL0sd5
         Y5p7WWPkc1RRv5/2tM+pRHEi2DTYfY/aNJBOgHx2ZBKDt8OjFRAzE0gGhEKgHt5JAeF5
         rUFsWJSO0hoLYzsXUdu3qhGo3JEi4XcgkJz4Fq7KEgNG8qNj1AyPo9aZ0rneYciCBlt3
         wezOFMRIEgVsQcPr3ZZljJON/qwar23Uilg3RUdOhQRN7Bt5MTcKd3m1+pGFfUl2ViP0
         5bWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787288089; x=1787892889;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JVPRdpKQ6Z8b1wwWbv6uhUylN+tu2/L/LH6uVlvCTo0=;
        b=Nc4et24p2vQNtWWnNAjIVz+5sZ5Lo+xTYucFb6Vn+DS5R/uF4slE+OMA9ZlCpM+FYe
         Y31ABb+WQYg799oLKGrXktL60EBBbkWhs2XtiJEsxm+pIqpsR78MMVKVoXGsS9ZsQJ79
         g3/sTd27itUDIrphoAb6/aVrAP6MTK7m0+zbxKz7Tm1Y+bwZPZs/M0olxw7joUdHtfjj
         Ifr1CY+zWINaEp17AixJ2qnMK8VA4x2HinFRQ+74uMWlBRnnVb22dyg2lUc+5WMWOkEf
         upMbweQjo8O6CEMxqPQNLQUGBcA1QyWKrlRTyAkupeEKfWU/23A+MuwOES9Yte2qH3QK
         JjOQ==
X-Forwarded-Encrypted: i=1; AHgh+RqMVFgV9EJbK399tutblAaXegmm9jBzY+SEngagFLvMyHuVlWeqArQPYFJkFgm98NjF1V1hlhr8pUA=@vger.kernel.org
X-Gm-Message-State: AFuF++n6cDpqHjxG3dqkqDyrbELW0a9Q/nbPfl72G2K0Vbi9ppT3g1e4
	8+myEd4efL3mAkZRpC1knN14lgw4/zbwUorSSYOnjNwum2Ru3vGbGxy7wG3fFCPJM4JSYXzOtbW
	L8FwGwpwBmhzUmAJWk5YqGquU3bb98od5rv7+UugZ2Jjp3BlWij+0HEwU6GyPsPE=
X-Gm-Gg: AR+sD10hTVMIRDFXUYArEobg5od+pyP2IZl4DPQ2Bqdva+ckN0U+R2ofdfazbSKzI2o
	ZDRkp3XZRNOnxRoRXZoLJ5hYW2fgwFGM8M+Jd/6VUinDXrcGaMEd6QvZMs7EzYwAmijjkzKBuWN
	CRb+O7RT/+QG9PUNzXJknsog9M4T5KmXtgZtFGMLLirmfc0IMtOp0RncYnAoTckv2RBu0+0Y73V
	Z3M4HBN64cB0wVhpA+bvfvlHWg24XC2C8+8+FTbMoxCiXjUlU1+ujRwvKQ9lTVtno2bMl0T0Rvj
	Zw41EbuxMN72RV/NHRbPmTG+ddRRyYur4W2sDzvFCVh3iCoIL5FqmGMilfeHP7aVYUpqLwxMlkX
	YbVcTgAnxfeOGEhyYaKYvbjdu8yakOw==
X-Received: by 2002:a17:90b:4a89:b0:390:8361:a532 with SMTP id 98e67ed59e1d1-395c33bd6d1mr6622719a91.7.1787288088927;
        Thu, 20 Aug 2026 21:54:48 -0700 (PDT)
X-Received: by 2002:a17:90b:4a89:b0:390:8361:a532 with SMTP id 98e67ed59e1d1-395c33bd6d1mr6622618a91.7.1787288088440;
        Thu, 20 Aug 2026 21:54:48 -0700 (PDT)
Received: from [10.218.7.34] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c4553168sm1530980a91.1.2026.08.20.21.54.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 21:54:47 -0700 (PDT)
Message-ID: <04990044-45b3-45ca-9e39-925d5bbe62e2@oss.qualcomm.com>
Date: Fri, 21 Aug 2026 10:24:39 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] iio: adc: qcom-spmi-adc5-gen3: Add support for QCOM
 PMIC5 Gen4 ADC
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Amit Kucheria <amitk@kernel.org>,
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
 <20260803011400.1fb6c93a@jic23-huawei>
 <a98d90bd-aa9d-4af3-aa54-3a34300070d4@oss.qualcomm.com>
 <20260807001822.31f7c137@jic23-huawei>
 <f2b2f590-de3e-4f10-b883-92845f59412d@oss.qualcomm.com>
 <20260815030830.24fc732f@jic23-huawei>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <20260815030830.24fc732f@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: gk9LKVQZkTgcZclIotYTpFJPIdBN7yv0
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDAzMSBTYWx0ZWRfX6khpNpz8Nval
 G8EWqTJScZt6dCp+e71fkp7fMELxyckb/66GF6AOIe+BQYPb/6qkuWBkxCbtY4DbLVK1Fx7Vg0Q
 NQQhpdQiQvw2L5HupaAXvx7M6OkyoR8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDAzMSBTYWx0ZWRfX3NDhZ2/V39Cs
 OnaTH/r9rTjejSCVdmM7lAoHU/F5hpLgdiqg8NBBWT4nseB+I8mZwX0BrtIRNQKRk+PkEFb6GTj
 aUchISV/uvLVqxp0R1GhrmjL0SD4fRvlgcA498hIWlD62J9+vl1ZACqVWFYph2qTeBXXakm76b6
 cwqcLaw89YigQCGSjborsTTtXdyUTZv6CjKaCK8/GJqUyJWUhc+/m7BIMnt9Xd7LrkWoRptWOft
 B06WyLUkJokt8PNLKPXnKr4YVaW46mGMuy3j2oWz8dxtJdT4QReVZ0zD+O9ptQC2/O/y10+Az9t
 vRKYJZLfX1a5FLy5mza8b3tcIygFydtn9e5upZjxVQ4q5uReLTlGzSeN6aNajtMfkmD18lteEpL
 H/aul43/k4S8LSwzG4ZB+a1E56Xc80vAZhK2jlRiWhHNxK/MNM2TIslNeytXL1s1jAK1P4ZQbFV
 Y2knFKwyjZuK/6ZsdcA==
X-Proofpoint-GUID: gk9LKVQZkTgcZclIotYTpFJPIdBN7yv0
X-Authority-Analysis: v=2.4 cv=UtFT8ewB c=1 sm=1 tr=0 ts=6a87da19 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=hBCwbVwefb8Xt-lYK48A:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_01,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608210031

Hi Jonathan,

On 8/15/2026 7:38 AM, Jonathan Cameron wrote:
> On Fri, 7 Aug 2026 13:37:02 +0530
> Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:
> 
>> Hi Jonathan,
>>
>> On 8/7/2026 4:48 AM, Jonathan Cameron wrote:
>>> On Thu, 6 Aug 2026 16:22:16 +0530
>>> Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:
>>>   
>>>> Hi Jonathan,
>>>>
>>>> On 8/3/2026 5:44 AM, Jonathan Cameron wrote:  
>>>>> On Fri, 31 Jul 2026 23:36:15 +0530
>>>>> Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:
>>>>>     
>>>>>> PMIC5 Gen4 ADC is similar to PMIC5 Gen3 ADC, with several changes made
>>>>>> for improved performance, mostly at the hardware level.
>>>>>>
>>>>>> One significant software change is that ratiometric conversion resolution
>>>>>> has been increased from 14 bits to 16 bits, so the maximum value of
>>>>>> these measurements needs to be updated for Gen4. Add a new scaling
>>>>>> function for thermistor channels which use this type of conversion.
>>>>>>
>>>>>> In the latest PMIC arbiter version (v8), there can be up to 4 buses
>>>>>> under the PMIC arbiter and 32 PMICs under each bus. In order to
>>>>>> support communication between ADC on the master PMIC and ADCs on any
>>>>>> of the other PMICs, a field of width 2 bits is added for bus index
>>>>>> and the bits for SID are extended from 4 to 5 bits, in the SID
>>>>>> register. Add support for this.
>>>>>>
>>>>>> In addition, it is possible that the master PMIC has ADC of one generation
>>>>>> and it needs to communicate with another PMIC with ADC of a different
>>>>>> generation.    
>>>>>
>>>>> "Possible" sounds a bit hypothetical.  Can we state this actually happens
>>>>> on some devices?    
>>>>
>>>> Considering existing upstream platforms, this is applicable for SM8750. I'll
>>>> mention this in the next version of the series.  
>>>
>>> What happens on that platform today?  Wrong values?  Should this be treated
>>> as a fix rather than a feature?   
>>
>> There is no issue on that platform right now as ADC channels needing this
>> support are not added yet. SM8750 board files only include pmk8550.dtsi, which
>> has the top-level Gen3 ADC peripheral and some ADC channels on the same PMIC.
>> Gen4 support would be needed only when PMIH0108 ADC channels are added.
> 
> I guess chances of anyone running an older kernel that the device tree on
> that device is low as other critical stuff won't be supported?
> 
> If there is something easy to point to for that, add a note to the patch
> description as it justifies this not being a fix.
> 

Sorry, I did not fully understand your concern here. Are you asking if
SM8750 runs on any older kernels and the lack of Gen4 ADC support may be an
issue there?
This would not happen - let me try explaining with some more details.

DT support for SM8750 has been present since kernel version 6.14. At that
time, it included pmk8550.dtsi, but this file did not have an ADC peripheral
at the time.

The Gen3 ADC peripheral was added in pmk8550.dtsi very recently in this series
from Neil Armstrong: https://lore.kernel.org/all/20260721-topic-sm8x50-adc5-gen3-v6-0-a507f4a1e537@linaro.org/,
and I see this series is present only in linux-next right now.

With this change applied, the ADC peripheral with 3 channels of
PMK8550 alone (which is Gen3) would appear for SM8750. This
would work as its functionality is fully supported by the existing
Gen3 driver.

Gen4 support is needed only when we add full ADC support for SM8750,
meaning when we add channels under all its other PMICs (PMIH0108
specifically as it's Gen4.).

Would it work if I mention in the commit message that SM8750, added from
kernel 6.14 without ADC support initially, would need this mixed-generation
support, but only once we add the full ADC support (for all its PMICs)?

Thanks,
Jishnu


> Thanks,
> 
> Jonathan

