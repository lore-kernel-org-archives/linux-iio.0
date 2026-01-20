Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C283438FF7
	for <linux-iio@vger.kernel.org>; Tue, 20 Jan 2026 13:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768917505; cv=none; b=j13ifpgsbI6uix5LtBV23aYYcTRDzV3g06YA+eW3XyLqDdzvIABq27GVwAUiBwf96VzHgDc8Ky+9ahEttoBU4UWf5LrXP7nEKJIxaLl9geogajbBaWVD0Xg3LFPZeItyswSqV12rZlCFKqProuBUBverAjpBIrgNE1wLMp4Ghy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768917505; c=relaxed/simple;
	bh=3IDL4zxJjglShzvhPFMDVOURKk3BNCU95g4Y7X/+DcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rItSkyX4WczmY+4gUbV2G8at8Q9d0j3e1FJvyRo/O0TgYCCERL3OBELQv7NaaKDT7Ljlu4cHDx/FDNSKE+qfJeQ9SyVqmpDH52ZIJq39LvBmaUwOAqGZYnztlGTnOKjaDG8Vtsva6jrafz5m1P59ro/otgVMmyNe28+WbGD2gkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eH/ZtHLq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Kyux1irj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eH/ZtHLq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Kyux1irj"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60K71Z8f1408477
	for <linux-iio@vger.kernel.org>; Tue, 20 Jan 2026 13:58:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kEDM7CJJ3UV8hfZIlecESNnT1FXIpAEI05BpdiooWMc=; b=eH/ZtHLqRRTwxXVz
	ZS+jIasqu0+yIF4FfiXXzNhKiUJvf9UgFsVQxJCvVQb/uujaThYLPVoT28HH8hrA
	l3RQX9TxtpMJUD0mb+gXiFYYJlwpn2W6M/8xhDgN6IcGTBsHK2lCcJrWjceGKNzM
	oAEWGBSEBo5WqLE94V2KG+48L+KFMMMXL7u2sKKJWGnzzuYwNSqh/cZLtJEaO9yE
	b5ZG3hBBtwJ4KgkvjZDACv5BcCTkBPBwqS0yqFJOE3cor1wNY6wyH+Tuvi2s+2y8
	I845qxDRv/BKvu4ObkUtfGZY70nGHARn+PBGjBLLshgAUXXGbL9plbh1XwWcRx36
	siCj4A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bt4y2s7h0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Tue, 20 Jan 2026 13:58:23 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c5265d479dso188697785a.2
        for <linux-iio@vger.kernel.org>; Tue, 20 Jan 2026 05:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768917502; x=1769522302; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kEDM7CJJ3UV8hfZIlecESNnT1FXIpAEI05BpdiooWMc=;
        b=Kyux1irjNFk33aNqM18UtidJkGWMf/+vCASM6LJ1W0BrFkOjWgUF5Mw2Xex7fMEdJk
         F+f98af5vTsqeyyKe5WnwVaI/oZkvuRuCM0c1jIersAeHU5dPFfo+z9l6yU1ba7uaPsD
         AMPqjtkz60E4mk+uxQ0TaVIhNDtZ+kSwaHeQnb6W2dgJ9sofvAEMF+i29mV6diozgzhq
         +lxVNyQCmPTamLHE0OCWjbl5AlNiEDa5FegDKDFjuOBxflyrCYWZ6PDHGf9La7gWGVpv
         vqMcuRtKEZSpBY0uIZ7/tIqCA/IM3wrlqwoEypOgVCO+oUCmJiU2Bzt6KaErdQwAR3Xo
         czpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768917502; x=1769522302;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kEDM7CJJ3UV8hfZIlecESNnT1FXIpAEI05BpdiooWMc=;
        b=RPCs8OR9pzcgSb3VO/F9szCVmmUrrtcbjsY+FI1CAR/euD8AW3iEp0zb81VamZ4JuS
         8LzgcjzOcTpRT7M+z9DOwW9B4cdoQLRIb5M4Eo0Ai6jMCjLSmQf/L0On5En+KW8ltMni
         KYl5a5UCW2IQIJ3PkRW11YWozNdIZCwEuTD5lOuFHPu1VkFlTdP9pS7tfWXcXGvrilYU
         hV2kevP0mB0p5PC5tLv+GJdVDIEIUiTonixSJGcMLl8jjWBKEgkve/5Z4Dsir+ejQDvL
         86+Z6rBd1TBQ6tYA6CRhrH4D1M/ZkTSMAlwlwzIuwzbpzz0pbEoi+YoYq/tOfTAxVsB2
         EMVg==
X-Forwarded-Encrypted: i=1; AJvYcCXBoug8mfWdJq/Z+ShtnChk/1SsR9eUmhEtDR8EYwXydyWSH1rYkUboJrb/oKgTxGoW18Jj5lsvynk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXLDDVecvOyA17bx898LQJqf1odRCvQbeGXveUjk1dxKHuu7ay
	TuwwFsrc/MlxmK4aszW/z0zVkVvQkJe6BmzYKnaEYeB50wRX4l9mw5dvb2gl4oGZCe2DcS86biI
	92IjDHmjjF2wdBrQmOxAjxAJnU9zrN15lK0kpPoy7q0b3MyefflHj+vNQbQau/W4=
X-Gm-Gg: AY/fxX7cTUfsgHHoqEAWTIIyOwd+BHRox/DsQ+lKLc6eBgglmO5l3Pn8qOLRZh1o5mx
	5QGuwJ3d5zDFPcd53omPzJ45VUcaJ6QMwn1hJ63G2j/C9dumuT3xeiCNaqJbRZJU9btG+nsp+6Q
	sODq5P4pKJNJy4D4a6t9dNbmoSvPh+OWVLluSC+PAhQhAUm2xafXE+JzXc6D4qq/aqb2C/2PWPy
	MlCC6EgpFmJBsH8qjtyxwUcS5tDyydhNyPSaC5YC53wl1wn7f3kPLt/le7i2dNaDb3pcoIjQA1v
	ykp4gP1w9Ylq0Eobff4lyDbAJYFDtFRzhlsXVERTUi+zRIyYMsfWCx2K+ak5wHRyTY0AUY4ST3P
	/g7og/shgwRDJ6lkGanlNaMF5rvW0lb8r1QkFJAn27lCQfM8nudVDWTocTKDRy0IpAh8=
X-Received: by 2002:a05:620a:6c0c:b0:8c6:afd9:e422 with SMTP id af79cd13be357-8c6afd9e501mr1190979785a.9.1768917502101;
        Tue, 20 Jan 2026 05:58:22 -0800 (PST)
X-Received: by 2002:a05:620a:6c0c:b0:8c6:afd9:e422 with SMTP id af79cd13be357-8c6afd9e501mr1190977885a.9.1768917501601;
        Tue, 20 Jan 2026 05:58:21 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8795168b2esm1436998566b.17.2026.01.20.05.58.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 05:58:20 -0800 (PST)
Message-ID: <78fa3129-59f3-4545-ba9f-b570a02b36d9@oss.qualcomm.com>
Date: Tue, 20 Jan 2026 14:58:18 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] iio: light: add AMS TCS3400 RGB and RGB-IR color
 sensor driver
To: phodina <petr.hodina@protonmail.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
 <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        David Heidelberg <david@ixit.cz>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20260119-tsc3400-v1-0-82a65c5417aa@protonmail.com>
 <20260119-tsc3400-v1-2-82a65c5417aa@protonmail.com>
 <6ad1855a-acf9-43e9-a8ab-303f553eae77@oss.qualcomm.com>
 <aW-EFdqRQRFDJ-EO@smile.fi.intel.com>
 <iRHbGC3J-Do8RXQIaOqoVYAtebUbQGrJ_H63p4NBgKPUeTBw9dDHGK0YXwd-BhARpOTr_t-C1-rzj-W08AqfiUaLhzXd-4T62V3c82ASQDY=@protonmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <iRHbGC3J-Do8RXQIaOqoVYAtebUbQGrJ_H63p4NBgKPUeTBw9dDHGK0YXwd-BhARpOTr_t-C1-rzj-W08AqfiUaLhzXd-4T62V3c82ASQDY=@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDExNSBTYWx0ZWRfX5anwfSu1vFz6
 CxOtcfvGfbm/vK64wzhAUdmL0Z5AD4WXDQxAvwGN5g/T6l5So688EeZH0bArF0r9oF0B09GwvZ9
 Qfbc3zPQj0JPcrQcQ0CcDeUi/VfnaeVEQR6QwoeUthrWs0H4dfuLph+CPXMjrUdPfRjXF6SXOrq
 xMpYl5QCBrBl84uFfBgE8fthYY9yElOX85PdhthgTnzl/dwhfe2zcKJecx9QgOtQc+luESmQjiF
 +xNGLGkHRnA1s/HuhG0WpklVrmlWkqykrMfOOrLoxZTDw0qbgUlX4mp1wJdnuveh0j0iwjoPqiX
 RLPgz0iN/vyNPvWBRe3w0yjWXtvqI6VI6Bose9so8e+2TumAxZtWevlDmZcUwLx6GLgnaKnxoIS
 tQ1/FjRn+vIDci/B1ParFou1tsyIc0z79g1uMKD3TGxuxOe1jOhYkvqwK1TFfEow+oZl1Njohvx
 zH8kDT9xVnyT75lXIng==
X-Authority-Analysis: v=2.4 cv=Ds1bOW/+ c=1 sm=1 tr=0 ts=696f89ff cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=WPYAcN5PAAAA:8 a=OQN141zOAAAA:20 a=lLZmtIKjAAAA:8
 a=QyXUC8HyAAAA:8 a=sfOm8-O8AAAA:8 a=HSszxRPbfJk2xRrW558A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=6ZeUHvWJlyc_Iz7ozJi0:22 a=q5Nj8NTjyn2D8kUwajRn:22
 a=TvTJqdcANYtsRzA46cdi:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: n4WYMkWyNCu4feZStX0syY21LKrC4clE
X-Proofpoint-ORIG-GUID: n4WYMkWyNCu4feZStX0syY21LKrC4clE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-20_03,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 clxscore=1015 impostorscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601200115

On 1/20/26 2:51 PM, phodina wrote:
> Thanks Konrad for posting the datasheet.
> 
> I used directly the link from the vendor site.
> 
> https://look.ams-osram.com/m/595d46c644740603/original/TCS3400-Color-Light-to-Digital-Converter.pdf

Note these seem to be two separate (but similar) products

Konrad

> 
> Will add the link to the driver commit.
> 
> Kind regards
> Petr Hodina
> 
> 
> On Tuesday, January 20th, 2026 at 2:33 PM, Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> 
>> On Tue, Jan 20, 2026 at 12:03:26PM +0100, Konrad Dybcio wrote:
>>
>>> On 1/19/26 6:19 PM, Petr Hodina via B4 Relay wrote:
>>
>>>> Add support for the AMS TCS3400 I2C color light-to-digital converter.
>>>> The driver supports RGBC and RGB-IR modes, programmable integration
>>>> time, optional interrupt-driven buffered capture, and regulator-based
>>>> power control.
>>>>
>>>> Signed-off-by: Petr Hodina petr.hodina@protonmail.com
>>>> ---
>>>
>>> FYI this is the driver that shipped on Sony phones:
>>>
>>> https://github.com/LineageOS/android_kernel_sony_sdm845/blob/lineage-23.0/drivers/misc/tcs3490.c
>>>
>>> And it seems there's a datasheet available:
>>>
>>> https://mm.digikey.com/Volume0/opasdata/d220001/medias/docus/897/TCS3490.pdf
>>
>>
>> Thanks for finding this! It can be transformed to Datasheet tag
>> in the commit message.
>>
>> --
>> With Best Regards,
>> Andy Shevchenko
