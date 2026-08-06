Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC303F7AB7
	for <linux-iio@vger.kernel.org>; Thu,  6 Aug 2026 10:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786013534; cv=none; b=bnSMyf1MB2wZ/yLT7VRLvXuvQNljhzR9wA5y5tyU6xrazV0Su2URQVBevguRC/upuZyyr4wznlgm1NErteYo1XY4xDX/XtQhGmtjOh1swzHa8bQ4UAk+InESjPp+gGnpUeqYQPK85/prcFqe3ljcVvxbExLPow7jwZAwFacSbLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786013534; c=relaxed/simple;
	bh=pG3nTZWIqo0Akp9Sulb7iX4hmqwWP/CuYA0lfOGOYc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FL1ntwkk12Yw349uxSyH/USVeuKr5tB1eZPbudhdAK9AGp4Go6qxzmoN0GN2jOG3WF01xQT0ir951ezMsMCu/f5PbbHXINmDlACgAoWTj+ifoY39E6oxazIRChsID80FoyP1dfQj8tmK8MTZrqDA6V8LPvo1jOZh9Cw06HTVktk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TN7C9A2G; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=S9YQjjG8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TN7C9A2G";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="S9YQjjG8"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6769ninM1277927
	for <linux-iio@vger.kernel.org>; Thu, 6 Aug 2026 10:52:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZA1oEgRFCJzqGhqDxYrY00E+txiTv+g+wlBr6oIblSU=; b=TN7C9A2Gfdz2+qXl
	YoG1tIrU+lOBQY3+H34BKsB7wR2D1n8tHybk7U4lRC2t6s9yqRnk4GY/HVLuPyq8
	UsVUYd/A3vnAmBHXNNSVk8k6gyds0Bfys+zhEI5ClLyFT098E7HoNRghTqahrzTR
	O9IEJV+ZnAvjgZcohuklwFylucH0+G22L9K74dcCdYUYzTRSQgapVrzEXOezGLn5
	c0WSkOYvUrA+IGWLOvJAfHJzPTGASSXSUmjzfppxNoz3l0NtJr72ZAWyQipeP86a
	0J5OEHPEaKYlGTqzuC1hhResJKntqWC1f70P4dmbJynfjjiDbhNsCfZQdeU2hFaa
	lz4+zA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvjuehmku-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Thu, 06 Aug 2026 10:52:12 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cfbf3e4a63so52445165ad.0
        for <linux-iio@vger.kernel.org>; Thu, 06 Aug 2026 03:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786013531; x=1786618331; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZA1oEgRFCJzqGhqDxYrY00E+txiTv+g+wlBr6oIblSU=;
        b=S9YQjjG8mPyECB4ltcJeZyHH8WgVTNLtm3QydenKOEopxatmlMYnM1hpwfIh09TnsG
         bH/vVcDGGgsm+msdJrByJFdIvDAlSRymGm+ee84Ci3yGfNv6gmtotDe1eCE4cNoNg97/
         KPSMYSlWBpoBh+4hbLnsjQ2YV6J+xROvlxyodOgyPDgRJM+ga/NndY923eR8FuGvV9QR
         6OXCXdDp3ZQr2sbhtV/qY8IvenwCjKz6xlh4D0tDBqcweg8+fiMakPY46ZGEVbcVJxVy
         iBK31pbM7daDlbkGrBzTeNbUUPmI5j9IAOFznfN+ugiQIZ+J6YLC1Wa8G0dU/Lqk46X5
         vZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786013531; x=1786618331;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZA1oEgRFCJzqGhqDxYrY00E+txiTv+g+wlBr6oIblSU=;
        b=IIW97M6/DeJH21ZPSQIZhjqgkDWbgcyd+Nt0gb6Qx1UZBpipgeumhdiNINAxFwlv4Q
         +GFCpfVyUfMbfb3Qz7OspBYOhCPP/ZSmpetYpln/t5wQbyiZw6ajB594dV3aCoXdFm6m
         5TXmck/qEvnACtRNCVEvFVuxXp344cW49AYORp1GHnUwbBViDLnfOwdV8+c8kRBjJHyN
         wSowaq5+0CCRdInMngGfdFYdGyPs3u0aY0AGxExjbUMlBw7qthX2WWXN9d9kHREXucUg
         t5+ojQ0o4ZxAsVwlVzMlwwyidBLk+ujpuI33YOcDrFpFYiBpa3EutvDeMsgh3ymzGrFx
         aEwg==
X-Forwarded-Encrypted: i=1; AHgh+RqMYnE3sBQOUekfXHLX1BpDJ06UKuh3Qu5W/GNtyD1I+CdwO/KaZPSMc94KUPILQfVGce1/8q7UGmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjRByWWYaf9MNCQWCNp28EDw+obK6trojMsGL7/pZKAxmgFbCx
	M2IOcxIRUc6paJ8U8BtVf6U9akHw9xZ06csOuYAeFHGS45jL5XEnueJGdPEaa8+JeP8JbE5sVZk
	LEogRq/AsP6I2a+mLD/snsjKuGKvy1vGLKrjivHxkov3Dq/HMwexoUW8vnWMrtMg=
X-Gm-Gg: AR+sD133a0JeLLSg9Aml67rB+qErRfu6rssPHXjobAUZSjwI9l0HvJJZbjZGafVOpzx
	xpFr+5lf74/KB35K3BD54EilXZWhaaVZ8rsoESoxV0OjuE54p1SJXNIbR5n17k/5bYD4SeIIlVY
	4/3/PqNNyd+A3b2IeUakNDcIDgUaXwpOd9z6R6G5UxAuAc7BCN5udWUPfgJ7qpy78dulGwo4fZy
	+a39qjG+m8h19LuQcU/Zihyl28GX5LnByVh5C7C4rHxAwIbV3ZLUijpLdVeWL3ZYHx7xmD3r5ZJ
	fmFVeuoEYthHKiOPOfI0b83ecUscZhgMp5OzCT2hAHQefpzDbphul6R3SjGjYtZYLe42PHJiFXB
	3b7StcaOlLU7ugIPmH+8s8aGUUXcED+xs
X-Received: by 2002:a17:902:f546:b0:2cc:aa36:c046 with SMTP id d9443c01a7336-2d0ca77ece3mr148064785ad.14.1786013531581;
        Thu, 06 Aug 2026 03:52:11 -0700 (PDT)
X-Received: by 2002:a17:902:f546:b0:2cc:aa36:c046 with SMTP id d9443c01a7336-2d0ca77ece3mr148064125ad.14.1786013530978;
        Thu, 06 Aug 2026 03:52:10 -0700 (PDT)
Received: from [10.217.217.28] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0aa4930e1sm29469905ad.41.2026.08.06.03.52.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 03:52:10 -0700 (PDT)
Message-ID: <bc1096de-94c8-4713-88cb-5b9e96b5419b@oss.qualcomm.com>
Date: Thu, 6 Aug 2026 16:22:02 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] dt-bindings: iio: adc: Add support for QCOM PMIC5
 Gen4 ADC
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
 <20260731-pmic5_gen4_adc-v1-1-9c49b2eea6f9@oss.qualcomm.com>
 <20260803004940.0277c0ac@jic23-huawei>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <20260803004940.0277c0ac@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=aNzAb79m c=1 sm=1 tr=0 ts=6a74675c cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=IlOKGWYkYrl9SAkidhAA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: OmLYkYKTM8XeHaASJLFutQkw1f8cP-y6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDA4NSBTYWx0ZWRfXxZFP9phQgw8/
 Rt82opb7rdiiuQo7S//ZOzUCrP9fOjCYqVmwer3r+Oc7AqixrW5sC2FAFkByaBnyPtW6OT8xuH2
 AZ5+FzzWCqRHstTFvqoV6lxSdRGRqytkCXK1D3X2ya57E7cEHPqy1tff0GV53OEGm1F1KIQS6xN
 m9/DPN3xBsmAqbSNyRHe5aia7HRE64vHKsQNDsDxFYXVkhjzNs7MXsUfkFjMdiuFr2mZSPeZPrq
 IsXpwHKyeD/c8KYhzPMiDPrbUibykdZyznua/KiZxow3SokkivsReFfvfrjEd1p65pSsd/a5BkR
 dyg2Dbz36wk6+JDoNVI82I283PwrPjYhEeWCtiHciiggTGz/WddacFUbBSa1dtTBkGDeRmoiAa3
 X5m+tSF1mRl4+PJUABiL6KFO/i2FiN+VKm+HBaRjMzlQFgBTn3zb8rdGGpK2HnWJzwq8WMg86bL
 iKyjYuTnYkGSuvI6f8g==
X-Proofpoint-ORIG-GUID: OmLYkYKTM8XeHaASJLFutQkw1f8cP-y6
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDA4NSBTYWx0ZWRfX0/NHdad6wtaM
 E1qeIIL+XqynESMqIwf+eX7BDL5E0nFqwnvgutWaRRE3zgRqh1jnjcTVesU1SdeGKviq4HrgQNq
 ULAnaNARNiSsJl3xylSTgcP7ipTgtXI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060085

Hi Jonathan,

On 8/3/2026 5:19 AM, Jonathan Cameron wrote:
> On Fri, 31 Jul 2026 23:36:14 +0530
> Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:
> 
>> PMIC5 Gen4 ADC is similar to PMIC5 Gen3 ADC, with several changes made for
>> improved performance, mostly at the hardware level. The main differences are
>> increased ratiometric conversion resolution (from 14 bits to 16 bits) and
>> increased bit field width for PMIC SID (to allow communication with an
>> increased number of PMICs, supported on latest SoCs).
> 
> Hi Jishnu,
> 
> The mixed case is enough of a surprise (to me least) that I'd expect
> there to either be more discussion here or for it to be handled first
> as a dt binding patch to allow for v4 channels on v3 hardware.
> 

If I understand your comment correctly, you mean I should either add a
description of the mixed cases in the commit message, or split the
patch - one patch to add the new compatible and one to add the new
channel properties ?

I think it's slightly better to add details in the commit message
and keep the changes in a single patch. What do you think ?

Thanks,
Jishnu


> That would provide a place for a description of why that is necessary and
> then the following gen4 dt-bindings patch with gen3 channels would seem
> like a natural extension.
> 
> Other than that this seems fine to me.
> 
> Jonathan
> 
>>
>> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
>> ---
>>  .../bindings/iio/adc/qcom,spmi-adc5-gen3.yaml      | 47 +++++++++++++++++++++-
>>  1 file changed, 46 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml
