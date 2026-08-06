Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69DC40911F
	for <linux-iio@vger.kernel.org>; Thu,  6 Aug 2026 10:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786013609; cv=none; b=AEmX4D2tqq/TuYTJ5K2qyBu0CpGxYtDJjRW1nYmRLtmvbE5YuRZPn+rHBHBoOK95cSxtTX8hMY1VpZu7L2L/haxgqdoOflZdwMCnZ1+OneCSfUlBqsTY7piuPFBj2O6aZn5a6GNy1BIHvvrRv9rMwis/euL04TggR3pmdVUdUkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786013609; c=relaxed/simple;
	bh=dJPIcsDZlDMAfg6zUysI1OwcH+C+3jNCyN4Fa+Z/3cE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cEnbk/gst0/R7GOq3s/HAT2ylG/8Zk3t3RKH5Yoh2dUUZ9if+yS2UbinKDtxCtRCT+KPrxF0qPJlWaA+Kcbhy6dNNJSu3zS2Dd7Z+5h5qZis5WeWy6PjICKPcFZFJIoRfYntdiiHyM7P5K0Wv03n7uhFvQElKMJsgRkgJzrBY7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TpZxN6TF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SOsejs3B; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TpZxN6TF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SOsejs3B"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6769nc9R1580566
	for <linux-iio@vger.kernel.org>; Thu, 6 Aug 2026 10:53:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mqTT4OdC+eo+D0Ndmyh5RHA/+pCdGGJQeQVezw4oxEM=; b=TpZxN6TFkXbMCi+m
	4hBcxBQotVcxhl1AD+K6QB6nZgmMe4v6RhPZh1yd2QQgqUjkZSPVAT7HNW+KKviS
	8VNJDKRMjmWpiJ/zMxSnxbdoCcp+TBPEV4n25Bk1UhfTjmaYKRUh4PHRAoMsqZ/U
	yQqksRYN1BS8bJqLeoVDzMVbPV+bNgOiBYa3i5PbDC5gNRtbeLnhPe+5NO6WkqlU
	vVLbEInMFyw9sLvnhICiHbOr3C1L1VITUwMVQ91W7cMySVCRD3oW5sxaaskz1uAm
	wrj8qTYeiNdkB8ohk0d7EtIrueNawBYue3dgfMwARmEdfQBrBO5UhjGheiLPDDJV
	xqeUeQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvmrjh663-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Thu, 06 Aug 2026 10:53:25 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84e1da97175so2818873b3a.0
        for <linux-iio@vger.kernel.org>; Thu, 06 Aug 2026 03:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786013605; x=1786618405; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mqTT4OdC+eo+D0Ndmyh5RHA/+pCdGGJQeQVezw4oxEM=;
        b=SOsejs3BkCA4bp4bak8qaKTL3raAayl18wXunc0ul4Baoh0gNXriR73iDlOaYSwYPe
         ugZciG0X0eD6k358nbhjZlE8a3WNx0/VnRWEO5ADOFBZgapsXjeBL7q4UuhdzeRyrL4F
         jXuaUk0TVV4jOt7z4We8nOPpKJXl4IUGyyvKpjb+rExOt4OhVtgrtyYs0b078oY6gnOv
         nmm161FrnKZ+YvaDraMZbDNjZve+gjRgro62oh30JeDMCrL0Lt+ssPAAkKs3pJylkQ39
         9UXRi8xw0Ng2YKndb0olRpHLQKwjLt/2spfscDIjjGTHBr4Ta4GLy0ItG96SVS/dAzx9
         j4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786013605; x=1786618405;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mqTT4OdC+eo+D0Ndmyh5RHA/+pCdGGJQeQVezw4oxEM=;
        b=WSi0+larrXxA3DIP8gH2T1Q720OybMlxuEtZiruIRMgEt+D6r6qN9cRN0FRzLnA71/
         N8V+H4t2OZA/g+LCTsPHhixGKe06tavrzDFb22TNjBVinnKdbWcObxfkXDJNYEy0dmDs
         0EPq7eplo1YNKTkPEkFzXGup+4jxEfmmME2Kng4kw/KwA1P+z/7RJqLqltKqGLlmz64l
         uoO16qYXQJl7QTRmichSKdYCIfCpCHL8lE8/ZZ+XvCbVmzJnqMfsrmQWawZ0g44xWhZu
         Iw/PuO0TTjvCxCA2+CqZnHqFVWh6XOEpCpmB5LON8z6E3SQRVRPRG6sl304tiFG4e6S0
         VmnA==
X-Forwarded-Encrypted: i=1; AHgh+RoG0fdFbQIOKQ7Qbzoqb4gUEbCFwCHo40VPyaX6VWvH5tvbHtLzGTMHi2zXHeKUUpu8ffmzAQ554SU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq5AIOul7MJ63bhnYVDLqI4w/TkzFPHfSQdwH3yCLe7uZmmZ+V
	YnaYapIQ0U0eKnkdybuUK7uFX5RrNkk6GWwZ4Q2q8U8vfFl5iPjvBawDFU+Y7MovCOayIM3ah6j
	ElN2hNHyTtzGs+CTJe4UvUO3uEjkw1iRhzqeMm+AcOb198ex8vb6MGUMrlL+lfqc=
X-Gm-Gg: AR+sD11YQzWTeO8C/wZzEAE/JqvavbDO9EnIXHawi8aG/NdlPjGZ22jFYh/VK8AGn0i
	n9D5XTlg24RuQ4rQUb0mecakjSBkzYcG4VKu8prIMEMqT2oNmY+4VRHVFUMTPdmYD5Pw7ufoXUo
	ngRUQulQIOS2s1W4xGQDhibzg+opmS59SJDmzmVWm37vrk/epJUlnoeizy9oZMFcL/SnM6zPoLi
	h/3ZJzDwQozzBlzhWazSbSr5Fy0kqeKu1olAHEKDjGuhZ8AhBOU7E2nRKpyjNO1kpN3qOoi/h+L
	i5eYJ8oFyYwOk1cAg7ha4ZkrY0C75tN1VhklKrQPnRN/XPxi8ZajeBnlLM6jYSUE9jvYbaiTP0g
	MSoSj0bUr4QuxjoLCHSkYtt1u1//CTqOt
X-Received: by 2002:a05:6a00:4293:b0:84a:6540:3389 with SMTP id d2e1a72fcca58-84f2dfc53e4mr16136557b3a.10.1786013604711;
        Thu, 06 Aug 2026 03:53:24 -0700 (PDT)
X-Received: by 2002:a05:6a00:4293:b0:84a:6540:3389 with SMTP id d2e1a72fcca58-84f2dfc53e4mr16136504b3a.10.1786013604208;
        Thu, 06 Aug 2026 03:53:24 -0700 (PDT)
Received: from [10.217.217.28] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f45389e5bsm1173338b3a.1.2026.08.06.03.53.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 03:53:23 -0700 (PDT)
Message-ID: <4e25b74c-baea-4283-9730-7313162284b5@oss.qualcomm.com>
Date: Thu, 6 Aug 2026 16:23:15 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] dt-bindings: iio: adc: Add support for QCOM PMIC5
 Gen4 ADC
To: Krzysztof Kozlowski <krzk@kernel.org>
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
 <20260731-pmic5_gen4_adc-v1-1-9c49b2eea6f9@oss.qualcomm.com>
 <20260804-marvellous-crayfish-of-recreation-d06401@quoll>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <20260804-marvellous-crayfish-of-recreation-d06401@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=VNPtWdPX c=1 sm=1 tr=0 ts=6a7467a5 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=he8iogTWBVq0M3DZNvYA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: ZmBTTfOSvnN8dUg9vhD6LFRGUZcuES2R
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDA4NSBTYWx0ZWRfXwgQ4Y2MM+GB6
 dZ3kW1Z0j9V8JAzMpB4zztdsBFoRLbSWzR7RkkaY/nW9HzCD4diLSMMPO8o9n/fkJDoIAe9qoiH
 akkIvzkAGKJhVoYVj0Kp15NZsq5BJWo=
X-Proofpoint-GUID: ZmBTTfOSvnN8dUg9vhD6LFRGUZcuES2R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDA4NSBTYWx0ZWRfX/+QA7Iq4f/z0
 +cmXTVtg9EDSunBAKr2gQOFKDMSGMajmPoprabO+q0qCJOOxHewrLUkJRRiWXntpQlDb3hut+QL
 pRm7rus1C4tJRyX2sy5Ek30nIcax00gljG8DQ7tV4cw0M+VUUGB6uDNVUkEfRNbLh5TmCQXVofg
 foQ+84EWlwZj24yhk+Wx0eqJn7llmwXRxC6050PkVUx2kY4gmX6OeUKTRQVqCLuHVuMtZNpRYNC
 2gZTN7Z8fNg2nNlmkvwWeDzWDUtxQqWexNTIBWYVN27Csf75Oyx+Lej5sqJLx5/844W8i0n8n7I
 aLCHuXsT+/nJokxp1VyQRAmN0jtFyMPxkLnPw0x+d6Ni1ihcbrvcZgtPpLlww6fX9ZG/5ZlvEKF
 z2tExYhxs5KJRImNFdOd5MaR5PAgu0yz7O2plts+RY87RKZXasl/PKu/EcY5C/RP5JQmsiICp2U
 riE8vb8+UNeEGPxtR5Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060085

Hi Krzysztof,

On 8/4/2026 1:50 PM, Krzysztof Kozlowski wrote:
> On Fri, Jul 31, 2026 at 11:36:14PM +0530, Jishnu Prakash wrote:
>> PMIC5 Gen4 ADC is similar to PMIC5 Gen3 ADC, with several changes made for
>> improved performance, mostly at the hardware level. The main differences are
>> increased ratiometric conversion resolution (from 14 bits to 16 bits) and
>> increased bit field width for PMIC SID (to allow communication with an
>> increased number of PMICs, supported on latest SoCs).
>>
>> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
>> ---
>>  .../bindings/iio/adc/qcom,spmi-adc5-gen3.yaml      | 47 +++++++++++++++++++++-
>>  1 file changed, 46 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml
>> index 149f4af8f4b8..e79ddc2acca0 100644
>> --- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml
>> +++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml
>> @@ -21,9 +21,14 @@ description: |
>>    All boards using a particular (SOC + master PMIC) combination will have the
>>    same number of ADC SDAMs supported on that PMIC.
>>  
>> +  PMIC5 Gen4 ADC is similar to Gen3 ADC, with some differences such as
>> +  improved ratiometric conversion resolution.
>> +
>>  properties:
>>    compatible:
>> -    const: qcom,spmi-adc5-gen3
>> +    enum:
>> +      - qcom,spmi-adc5-gen3
>> +      - qcom,spmi-adc5-gen4
>>  
>>    reg:
>>      items:
>> @@ -83,6 +88,46 @@ patternProperties:
>>            This property indicates ADC_TM monitoring is done on this channel.
>>          type: boolean
>>  
>> +      qcom,adc5-gen4:
>> +        description:
>> +          Indicates channel is of type ADC5 Gen4. This may be needed in cases where the
>> +          master PMIC has an ADC peripheral of type Gen3, but some of the other PMICs it
>> +          communicates with have ADC peripherals of type Gen4, so channels of those PMICs
>> +          need to be marked as Gen4 to ensure their conversions are handled correctly.
>> +        type: boolean
> 
> It is implied by the compatibles, in this case the peripheral
> compatible.

This property is needed in cases where a Gen3 master PMIC has Gen4
channels under it.

The main point to keep in mind for Gen3/Gen4 ADC is that the compatible
describes the ADC peripheral on the master PMIC, but the master PMIC's
ADC communicates with ADCs on other PMICs, which may not always be of
the same generation. Under the master PMIC's ADC DT node, we have ADC
channel nodes from all the PMICs it communicates with.


For example, SM8750 has the following 8 PMICs, having ADC channels:

PMK8550 (Gen3 master PMIC)
PM8550
PM8550vs (2 instances)
PM8550ve (3 instances)
PMIH0108


ADCs on the first 7 PMICs are of type Gen3, but PMIH0108 has
Gen4 ADC. So ADC channels of PMIH0108 exposed under the PMK8550
ADC peripheral need to have the "qcom,adc5-gen4" property to
indicate they are of a different generation and may need a
different conversion formula.

Similarly, on some variants of the upcoming mobile platform Maili,
we have the opposite case (master PMIC has Gen4 ADC, one of the
other PMICs has Gen3 ADC), so we would also need the "qcom,adc5-gen3"
property for some platforms.

I'll add a description for these properties too in the commit
message, hope it helps.

Thanks,
Jishnu


> 
> Best regards,
> Krzysztof
> 

