Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FF836D9F5
	for <linux-iio@vger.kernel.org>; Fri,  6 Mar 2026 05:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772776636; cv=none; b=ThexLppwCUQ9MX0F/sjwJRfq0Jo1dWXRZ6UVWMnFxUWVbPoE0iBYhEOrd7Fxiu8i62yeONUiHtDW/LY6gOMmkkSDMGpucF1dXejH4uB/U5eg27VOs6C5Hj3gdpZEiRbAQsUSl8NkaJ7uqqBjrZpD5liR/3QRbLfhMuGEahoABxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772776636; c=relaxed/simple;
	bh=XRshhNWCUls58Ec0Kd4jJCVhaUfesTsvoPyvZA++FtU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZOwMeAh1ynnZXp5lnLjLOF/oIOvIhfuH7ynY+TgI5Mj8hlXQ21dClxMxoWmvrcVFTeAklNoCqz12BGD5j6f0rKHqAodwWCBG6BhYOUk91ghjqUcpggwi0Ow8eMEZR9Cgi2X2wQWaMLEjYSzQvEglTYacvVrq1rG5Ri4eQktSwfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DID515sq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TDB/soW+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DID515sq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TDB/soW+"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6264aVVW1087368
	for <linux-iio@vger.kernel.org>; Fri, 6 Mar 2026 05:57:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MiXXC9Y+HRfo/jOm96rMU2xnZoWoXsElrX39FtTY000=; b=DID515sqloTkGjjK
	Vui+++KEzoj0Wxds/W4mV/0g10ClKvTW3vPTjZ964veVCtbjD809lgLtEmEdDQAO
	b22bd9QJyFlYBqRnHEdG1aJB85TekWY8EZy/RcMITCHj11ZDfSPbiHJ/SANnpeA4
	+D+mTJkT0oiwML1XU95qCTl2CDvIAXlkxe6e38EzHrMwqAhiej8itSubDrc3pkLM
	K3ANdeURHnJta5Z0WUDxVWcs/W+0FOQw+jEMNgAUiVs7asxzpXTbZyVQ8Q6Kokg9
	LV52HSK2KbpWijGSJ8wkcuhgsOosLtKm8N0az+DiHVQLsJwsWLQ/zh+DsddmDNwb
	hNphYg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cqfg69scn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Fri, 06 Mar 2026 05:57:14 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ae65d5cc57so153747865ad.2
        for <linux-iio@vger.kernel.org>; Thu, 05 Mar 2026 21:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772776634; x=1773381434; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MiXXC9Y+HRfo/jOm96rMU2xnZoWoXsElrX39FtTY000=;
        b=TDB/soW+z+JlevVnzYPNEBMQt6xu9xIel6ZSmGjwZTxQNrTfNkgE8iU7HFDaFCLNc6
         ra/jX3jOX6hOvWqTSJfJgNuipWUHLLxdY7FFVH+3dNxRsVMxapbysY8QpqYwsOtv5pwh
         vEZcJjKPe2XihrNLRp+xqZ8nNe9aKL0PsY7Y2mLez5SutvmQZrJDWwrFLmy9JFusFoS1
         m6d1hTd6hEkzLFTeMKX5dH8ms2dJRP1aiGPt6D0y18f7fsq7hvJVJ9XTYyhBXo5jcqte
         IxItZvthfsKcnz1bFg1hHpbE0WwMK1SWG9Q28iG9lWfNZx1W6lhKUyQ3Lik/qYmovP8M
         GM9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772776634; x=1773381434;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MiXXC9Y+HRfo/jOm96rMU2xnZoWoXsElrX39FtTY000=;
        b=XFxGkuwvSwa/9aXaWQJ6P/NRnG/VYHdekJZkXlPhM4UMpoDRz8jfWOGK/1ac6vwnfV
         lPxXF34n2n7twgtAKgHUBmoJEe16cKreUmuRyx45saAwXDIdM272pYouvUbCyI5EKl0R
         6cz7wOPyvEGXVXSlpQYpEEbIfixOokGjEMvFqH2i1AR0hd5oPWC04mEpSjswyRWDrrR9
         FCb8e9RgT9clEuxLqc4uhFyr1gvUrqt9pLYLMT6z9ICa6U3nhKKWzSwBiLiAkQFe40yk
         krJNOy/WF8jVQ2CTnBLZnXs7+GBk7BXXZgF5AesHZIrODchgxvqOhA1QDFzMS2wWzBgQ
         ILWg==
X-Forwarded-Encrypted: i=1; AJvYcCUrrmp4VJFtHRraDZZqKNYjaZqOOp40MGsiw1xHPJC6cQmnf4en0zjmVfi7YvLxD1bfDAhvDnpr8kU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUePSQEivsTXTbdeYAKONQrRVaj2L20SK/NV5bh6HwuBIAZgY6
	ifoAN4jYwwf2Io1ulu73/fhD7BO4xEGGZrQkzyfXzrDlbIUN2PaJZKPRYZuRBTzfsNMjStTr4Ed
	Drqi0Ge2z48DqtOBuV44hIhy7Rl1cAoaY0oRj/SPbqG60cegMamtnU0bhxfxw21g=
X-Gm-Gg: ATEYQzxbc4Zje8Z27TlpvrafIjh0R8dG4yIpLJx9OPz91Xd3nnNzWhTL1ZMhphm25xm
	81uIBxOTs+cChyVOoEYozV42NN6NftUQkPCgGRd2wmLSSBBFxor20xcYqh4aIBBb+NIaaS+Ga1I
	188Za1H94Uaf5nPrWFXfzvrW9jQXoYHUQy91PnPnhgDwyWaoZupcaFOP6Oupunac2cTtlBORPBt
	5ag9NkhePonR3PdbvbzFGuolGm0FmEoDh9tnkgp0oGbOTLBv1xGOhLJXJGhS7T0LABZ4ed2VM0K
	yqntuL/JDoAti74bzQNTUaSV6S6A1+m3lPbp7MrDDaPBx0zxdzTqQaRGU+ZfCxFBpchYdD/SYKv
	JGtAumX6G6I0EsbGuSvO/gSMgxdmhUcLXT0cz9MEeHwDRs8wDFaM=
X-Received: by 2002:a17:903:2ece:b0:2ae:567f:fd7f with SMTP id d9443c01a7336-2ae8249ad12mr12630375ad.53.1772776634034;
        Thu, 05 Mar 2026 21:57:14 -0800 (PST)
X-Received: by 2002:a17:903:2ece:b0:2ae:567f:fd7f with SMTP id d9443c01a7336-2ae8249ad12mr12630055ad.53.1772776633508;
        Thu, 05 Mar 2026 21:57:13 -0800 (PST)
Received: from [10.218.7.34] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83fa81d5sm5952335ad.71.2026.03.05.21.57.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 21:57:13 -0800 (PST)
Message-ID: <20301a77-2f75-4447-979a-f2dd4431c85c@oss.qualcomm.com>
Date: Fri, 6 Mar 2026 11:27:03 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V11 3/4] iio: adc: Add support for QCOM PMIC5 Gen3 ADC
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
References: <20260209105438.596339-1-jishnu.prakash@oss.qualcomm.com>
 <20260209105438.596339-4-jishnu.prakash@oss.qualcomm.com>
 <20260228193946.2e60ea5e@jic23-huawei>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <20260228193946.2e60ea5e@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: XK6OZ6AOFdH7zWcLkG9MK0lP77LcLFt3
X-Proofpoint-ORIG-GUID: XK6OZ6AOFdH7zWcLkG9MK0lP77LcLFt3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDA1NSBTYWx0ZWRfX8Lfj84+8L7tM
 ZhAOnrKXuTXbuDXjTj6IPZxtJS5RRZjDcO2lvKRdcvAUf12M1L67JC+p6LizGL00kLfZL7LoJDU
 IpHCrByMkXNc7MqLuuo2EBhejhL01uNLbHeCAMm2lirbxosE9XgU+/1RAzEp4aj2S9sL9noJ/oT
 R3088TzqfkCv6ZVHFTmQZOPkB8tTdf/Rc+04lRXMJiRfZYzk0I71riLTSokt4zhmpX0HtZxe9Y3
 dk5yO32XOqEonVVWJ6f/bn5IJpnkMUTkQowhkJGP68da7bErWVyd9J59F8vKKllh898BPbTOzA3
 NRo3D4taCfUsMliLkHKDFgxLxQXU8HBCc+cEQidpcmWM6o2QWpIuImSKVXZ8rxUD7eFsrXyD8Bw
 /NmSP4ihfBgS0v6qNJdmoycdQUikserCylScoMGNpyCLui7WyKfjlabc5ZLd3D8BQiJ+h5hJeIe
 zFkNAtFzY15eH1HdHdg==
X-Authority-Analysis: v=2.4 cv=XKg9iAhE c=1 sm=1 tr=0 ts=69aa6cba cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=UEldCo81gXLG25mkEUsA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060055

Hi Jonathan,

On 3/1/2026 1:09 AM, Jonathan Cameron wrote:
> On Mon,  9 Feb 2026 16:24:37 +0530
> Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:
> 
>> The ADC architecture on PMIC5 Gen3 is similar to that on PMIC5 Gen2,
>> with all SW communication to ADC going through PMK8550 which
>> communicates with other PMICs through PBS.
>>
>> One major difference is that the register interface used here is that
>> of an SDAM (Shared Direct Access Memory) peripheral present on PMK8550.
>> There may be more than one SDAM used for ADC5 Gen3 and each has eight
>> channels, which may be used for either immediate reads (same functionality
>> as previous PMIC5 and PMIC5 Gen2 ADC peripherals) or recurring measurements
>> (same as ADC_TM functionality).
>>
>> By convention, we reserve the first channel of the first SDAM for all
>> immediate reads and use the remaining channels across all SDAMs for
>> ADC_TM monitoring functionality.
>>
>> Add support for PMIC5 Gen3 ADC driver for immediate read functionality.
>> ADC_TM is implemented as an auxiliary thermal driver under this ADC
>> driver.
>>
>> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> Ah. I just realized I built the immutable branch from v10 not this.
> I wasn't seeing any review outstanding on that version and didn't read your
> email closely enough :(
> 
> I'd rather not cause more confusion by ripping it down and creating a new
> one.  From a quick look none of the changes since v10 look vital.
> Perhaps we can spin a follow up patch to pull into IIO to make those
> tweaks if you want them?  That way the immutable branch remains
> the same.
> 

Thanks for picking the patches. Picking v10 shouldn't be a problem,
I can make separate refactoring patches for the v10->v11 differences later.

Since you have made the immutable branch now picking patches 1-3,
is it possible for the thermal maintainers to pick v10 patch 4 now
or are there any other procedures to be completed?

Thanks,
Jishnu

> Thanks,
> 
> Jonathan
> 
> 
>> ---
>> Changes since v10:
>> - Made following changes to address Jonathan's comments:
>>   - Replaced inclusion of device.h header file in 
>>     include/linux/iio/adc/qcom-adc5-gen3-common.h with forwards declaration
>>     of struct device.
>>   - Updated all for() loops to declare and initialize the loop iterator
>>     inside the for() loop statement.
>>   - Moved initializations for drvdata, completion struct and mutex within
>>     adc5_gen3_probe().
>>
>> Changes since v8:
>> - Dropped the common module (drivers/iio/adc/qcom-adc5-gen3-common.c) and moved
>>   all of its contents to drivers/iio/adc/qcom-spmi-adc5-gen3.c as suggested by Dmitry.
>> - Made following changes to address Dmitry's comment to use module_auxiliary_driver()
>>   in auxiliary driver patch, by simplifying auxiliary device structures:
