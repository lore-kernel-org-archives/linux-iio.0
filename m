Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322B83612E4
	for <linux-iio@vger.kernel.org>; Mon, 23 Feb 2026 12:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771849172; cv=none; b=euLkK5+V2gB1ixWANFchDNqHfz38I+Kl9RifuPow1Xv2g0kfNL8wAfbp1UpI/y0KVy6kA0V2YkWL9EH5cM7j0QJKc3LxQ8uTMy1weVMvgmdfP3JWEk2hUpfnxoXncbYIwPxYJNo93q4V+tgYREm80O94B5SEYItzPwkKvvDBEHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771849172; c=relaxed/simple;
	bh=H9tBpH3FJ8NHINo0k6gxJuREDCEnVNm57V43aQX5k/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HZR8as5MgmXCiGw8Mxmkk4rUdVNHA0zLU2GuD5D0XJJKucJNAAJ3rJmN5377ZHO1eWrU7kURfoVra1H+SIV20WwDGX3E/Fk784vAqX8pwZSyKv6ml7Eymat9Yi+sBUz/EgrpRR6W6bN1IGWFECIMoDMowCfRugo87139dotXtfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BS4Kplx3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hGu0SkkB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BS4Kplx3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hGu0SkkB"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NAX8to3698631
	for <linux-iio@vger.kernel.org>; Mon, 23 Feb 2026 12:19:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3Et4rmFw5DqcAxFldXWsgH23NJXURgSeQXkLXYWOqGk=; b=BS4Kplx3EbeQ9V6m
	OrVqeOT8W+6+fwfbK4UCcZ5H0RuNlMxDJPtzLoJ6c/OXduS5Vc812BlSZvM45ArP
	cL7d7/xjg2hzn7Uxzi7R+c0cu5Ce9YeaQsEcVYHIXF4C6uwbQqLdkdk7ZTIrQTwI
	VYsbHSK70Dc5CjEjOO6Ypg2w45rYkRPGUEF+p4ULg6CishGvrJ55wnURRHQhektI
	ykHAlHI1gCSnV1qkL9ZR6ienC65ACZnbKT96YxXvPD3GZy/XFbvc5k355rpfKH5O
	BU8tsgx7osGmRH6BnZRMSX6SS8dPBmEhI4iWMicDjq89Njc7Hiq5B+Mb3f9QR1pK
	+RPpVQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cgn8189j3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Mon, 23 Feb 2026 12:19:29 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2aad3f8367bso51108435ad.0
        for <linux-iio@vger.kernel.org>; Mon, 23 Feb 2026 04:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771849169; x=1772453969; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Et4rmFw5DqcAxFldXWsgH23NJXURgSeQXkLXYWOqGk=;
        b=hGu0SkkBHLPNggvQGvOw+7UVxx/AivcBLucfYOLwmmoprJBNoa7ou0HdM7xvSabzCO
         fKY5+oHdeyPtV4TBAHphMrvbhLeP4l9/jS/vQ+yq21baLIxIFpsTbQoswgGP9hMrO+yH
         RIqSASo8nHzbbwHppv3CFfGUklhkpU1e22SlK7U5Y+hWQ49NgZoblw1/ngKm8A9kDnig
         L4Vbl1ULYGbv4c5m9OGydtmAPzLpFCfEiyaP7i/eTCbDc2JQPCIkKxOYNxlDdle8Z1qO
         ZZrlptQwGJuTm4d4oo9RWOCswRnbKm70z98fFLenoKHjCIfM7JfnRSFGC/MyBKuo0W9F
         b0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771849169; x=1772453969;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Et4rmFw5DqcAxFldXWsgH23NJXURgSeQXkLXYWOqGk=;
        b=f1Ty402HfJ65E6Z7kBgCtQo5nv5GLTtHJkEwPf6B8b813wX3OMdbfWQdZfGmpkkzkj
         8Es9/uOBjd5LkkvTHSWQ+Y/0fICOtObx9HIK+4bzfeDUkbjV2Quv+6y/9wvEJCe/5cKA
         uTGcTesUVeUnYiho/jQGv0KTOWuLT5cfqRF1DukqUY+lhrBMqYb8goe+F9qzjvESv0U0
         /RC5t/7jbcAJcTZ+OW3a6InweXUbXViewLgVhe9ji4kS9qEKW8hY2tTZDJ+d6tbRTO19
         e+bpy/kUETjA+uaV0rMS3k5pzyaoVlskyIS+3L+3/FbYpnU8TkoRTJgG3frNTSjIhBTK
         aG/g==
X-Forwarded-Encrypted: i=1; AJvYcCWsflT7lkE+QzQ+lK4vy+Zah9/LQfP3PANE5L8QBOMQ7WcE4Z803j0NnUB3FR9cpbgXkUg67e7De7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSq8aoFRUbx9r8dHStwEzTIpe7d4LdWaQjrpk2UIJu6nKEBSN4
	Z6g5cnzzhKiuJtEnKfBp5H7mHYXH1IKFXUkh7Kv5DbvXQ2R1o6wd1PuN72jmpL6gHNtg9ERkWX3
	69Nmsx/S/xMcnGg9aPTCbsywat2ZMm5sJLK7g97cB3BRsksH8kp/rCkmOfDBlSrk=
X-Gm-Gg: ATEYQzxI7Qbdj9JZ9UsF8hUSHvxlFde52D124uVE1EezA1Fxh/vsrqkRa/M2n4oJrd8
	7x/MoOdmrt9numXD+Lx8LkxTtQv93fUJNjWwldovm9bbmAv2sYkhcxDF+4toYvS0/MLhaNnnFlL
	NExRYgre25azFYWTIGoIy+ETXKbmz5TetDTdyo29KMQfh9p3u7GXgevSB7vc6wW4QFwivsO/GAo
	4en8pyeEBoLZ8t1RpWstZz4MfyUxVGPUgOhToqKfBhGfs/5sPCOj7XWB8h23MWt561TAzXvp/18
	4EprxZflrYbE2pxdBTr4dqzaWxa3IF49AQrXohHwe+B9rf0O5XPy2/9womHf957LLyQlnuuvPwd
	ZiNtLoq80LcL6s1gS/lT+TUzIqtMfW3JXF9s9hXMFUqckISEZspbbbQ==
X-Received: by 2002:a17:903:2451:b0:2a9:5b48:2b57 with SMTP id d9443c01a7336-2ad7454a6bdmr76541555ad.45.1771849168746;
        Mon, 23 Feb 2026 04:19:28 -0800 (PST)
X-Received: by 2002:a17:903:2451:b0:2a9:5b48:2b57 with SMTP id d9443c01a7336-2ad7454a6bdmr76540885ad.45.1771849168127;
        Mon, 23 Feb 2026 04:19:28 -0800 (PST)
Received: from [10.217.217.28] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad75035487sm74021225ad.74.2026.02.23.04.19.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 04:19:27 -0800 (PST)
Message-ID: <70b77d54-a6ab-426e-a7e1-3e011adad6d4@oss.qualcomm.com>
Date: Mon, 23 Feb 2026 17:49:18 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V10 3/4] iio: adc: Add support for QCOM PMIC5 Gen3 ADC
To: Jonathan Cameron <jic23@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
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
 <20260130115421.2197892-4-jishnu.prakash@oss.qualcomm.com>
 <20260131173941.68b8116d@jic23-huawei>
 <6012ad64-3a10-4f05-9f37-f2d0c36df582@oss.qualcomm.com>
 <20260207165638.0ed27302@jic23-huawei>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <20260207165638.0ed27302@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: uuGEYXre_9mwMCyj3ITGthL8yPSZQ-wD
X-Proofpoint-ORIG-GUID: uuGEYXre_9mwMCyj3ITGthL8yPSZQ-wD
X-Authority-Analysis: v=2.4 cv=CbsFJbrl c=1 sm=1 tr=0 ts=699c45d2 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=PFIV_uwPMKvENUFLfcIA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDEwNCBTYWx0ZWRfX1bwyUBR/gBW1
 m2sv8w+FN3gXU7eaRNpKk6fhJZM0pEGfcgSxkGgGztaMwaRwlACqfSoV5cCIQX3o/GU96EyxkY1
 P9iiQ/oiByDBdaEMYrnsEx5qWAqE1AtxhJ4/WpJks3XFy/Go2aQHiXH5pcATQryiFn8mJEj5adX
 TT54rNiku0cBWFyJaH0dyZ2Q3kpu5BTUmNB2bHWH2PHmhzj+sFUe+AybeWk1lFzE8TpdY43ZULI
 9RBhvvVvsTZ2d5avgN+iZ1PN75j8yFGveZe0IUPqcLv2+05I2rThwxHYiux2JhbIH+4TE5IPcBN
 IgshvMx4fZP5JYQSRsVRG9Ivx7prmLFHxSXJKKezM90EBiesoQf81uQ0mnVA3TM3WtoucIOwhU7
 CuYwKI1uw7Dg9ArxM/zi2+7OaxbOpoeib3P8LYvl6zoyzbRzF8OYQFI9Eoa0pBTitNWgXOaycu7
 sMUnnH6G8XtFb2ktpHg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_02,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602230104

Hi Jonathan,

On 2/7/2026 10:26 PM, Jonathan Cameron wrote:
> On Fri, 6 Feb 2026 18:45:02 +0530
> Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:
> 
>> Hi Jonathan,
>>
>> On 1/31/2026 11:09 PM, Jonathan Cameron wrote:
>>> On Fri, 30 Jan 2026 17:24:20 +0530
>>> Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:
>>>   
>>>> The ADC architecture on PMIC5 Gen3 is similar to that on PMIC5 Gen2,
>>>> with all SW communication to ADC going through PMK8550 which
>>>> communicates with other PMICs through PBS.
>>>>
>>>> One major difference is that the register interface used here is that
>>>> of an SDAM (Shared Direct Access Memory) peripheral present on PMK8550.
>>>> There may be more than one SDAM used for ADC5 Gen3 and each has eight
>>>> channels, which may be used for either immediate reads (same functionality
>>>> as previous PMIC5 and PMIC5 Gen2 ADC peripherals) or recurring measurements
>>>> (same as ADC_TM functionality).
>>>>
>>>> By convention, we reserve the first channel of the first SDAM for all
>>>> immediate reads and use the remaining channels across all SDAMs for
>>>> ADC_TM monitoring functionality.
>>>>
>>>> Add support for PMIC5 Gen3 ADC driver for immediate read functionality.
>>>> ADC_TM is implemented as an auxiliary thermal driver under this ADC
>>>> driver.
>>>>
>>>> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>  
>>> Hi Jishnu
>>>
>>> Whilst there are a couple of comments below, I think this is ready to go.
>>> Unfortunately this is just a few days too late to merge for this coming
>>> cycle as I need to send the IIO pull request today or tomorrow (due to going
>>> through char-misc) so this would get no soak time in next.
>>>
>>> Also, I'm not sure how we actually want to merge this given close coupling with
>>> the thermal driver.  Perhaps best bet is I do an immutable branch of next rc1
>>> once available that we pull into both trees. That would have the first 3 patches
>>> on it. 
>>>
>>> Jonathan
>>>   
>>>> diff --git a/drivers/iio/adc/qcom-spmi-adc5-gen3.c b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
>>>> new file mode 100644
>>>> index 000000000000..f8168a14b907
>>>> --- /dev/null
>>>> +++ b/drivers/iio/adc/qcom-spmi-adc5-gen3.c

....

>>
>> Also, is it alright if I push the next series to address
>> your comments immediately? Would you be able to include patches 1-3
>> in the immutable branch you mentioned, once it's available?
> It's fine to post a v11.  I'll only be building that immutable tree
> after 7.0-rc1 is out (or 6.20-rc1 depending on Linus' decision on naming
> for the cycle that is about to start)
> 

It looks like kernel 7.0-rc1 is out now and I had posted v11 here earlier:
https://lore.kernel.org/all/20260209105438.596339-1-jishnu.prakash@oss.qualcomm.com/,

so can you please check this latest series and pick patches 1-3 if there
are no issues?

Thanks,
Jishnu

> Thanks,
> 
> Jonathan

