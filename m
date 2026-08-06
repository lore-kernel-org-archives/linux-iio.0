Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577D44399D6
	for <linux-iio@vger.kernel.org>; Thu,  6 Aug 2026 10:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786013567; cv=none; b=i5dLKZjaP6L+RIZLoPnTY99AWo/GLOz9vmiL/2fCEPw4R3cAKzXkw3RnHCSonASbyWztzSvir+Gk0SkiQ5T8GTPtSZUaxDAenAHcKzVlEUyZP4bjm056LxTodYxByxVpVRS2oIlwfhuN+6McsvuQ5krLiAlEYra8bE7uJN9zPsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786013567; c=relaxed/simple;
	bh=S14CCXsvZKcoB+hqjG0/+YwP1JERAdUsRwYB9FkJGyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I5KH7/tNddLtLsa8qkTBm2ixNpH8k1mIo/vzA3LpSFZWe3lZXP+cDiNVbhCCH+PvdhEuAEQPe1tmATmVYJAaYx9oEgOT+Rph22pP9CTUxilagHCKJ+hgD7yolW5dAtWEb8400DDBeihSWQhygFPg8+lou0/SWwr3//Vb6GfvXIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n0NCDN/y; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LSZuO5/a; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n0NCDN/y";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LSZuO5/a"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6769ndLk1308830
	for <linux-iio@vger.kernel.org>; Thu, 6 Aug 2026 10:52:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	P9wCDFhEDVTTIuhNLpqSgqnjSFrcAIQqWwJdGdfxngk=; b=n0NCDN/y4q+yVtss
	WfR8OPnwOU4MQH4vqe+FwO0TUO/Af2unPwR53vW+Zm0FT+8Ku826Fo0YR1I5NSIN
	RZR7iTS7ew8/g1Hxjf3fsL8Ogd12xGLqssGg8/geL6G/iw4qFvmhguTeFvTZi0mb
	7NpPEOf/L+W5TQ1x9w9nvmehOuHEtHKuZLMx5WZq7+lGkGU1GHv6I3uCGc3HlrSz
	EOXRkv0ZzbrkydWWxSg4O6Be3OBWde3ASFhL0KJxxMnmbDggItxS1ucn04rwZS7W
	B8TYJ1BBJaDdlFwh9ah9NKxz1J1ZqUKZ0ICQQPYFjH9sP0cOmEDSU+uyt8mEqBsM
	Mzhg6Q==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvp728rv3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Thu, 06 Aug 2026 10:52:45 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cb6dd278512so1219443a12.3
        for <linux-iio@vger.kernel.org>; Thu, 06 Aug 2026 03:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786013564; x=1786618364; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P9wCDFhEDVTTIuhNLpqSgqnjSFrcAIQqWwJdGdfxngk=;
        b=LSZuO5/amZE36TM/mmIp2cpELXlFAOa+7TbT2hZ6NwIowTYtY7tMevd0pcQA9U+31B
         ttMyEbEdPuw8JRVO6o071OPE6WxYAZmpcXxjHsGzLtJsJxXfaqmmv+mpxczEEdeXqtl6
         dAH9OmDMx4LOAQazeXvFQ0cJMi+tRcdDCozdXOudL5S/HHDV/Nu+N50ASTNBzlzD1rj7
         Pf15NLC9iioGp5HHoNEosIKqyK0ql9haYdsAvmP5QsINmgskZLZOa5p7jYO3OCeKm7ue
         iptuGdkK/RLtpt5RK0GLsKKyT0vBVYqM42gG6HDUMMc17HrIl2pafGtYPZ9ldXzdaFk/
         urww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786013564; x=1786618364;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P9wCDFhEDVTTIuhNLpqSgqnjSFrcAIQqWwJdGdfxngk=;
        b=iB2f7eliUkvwTQH5BLwO3QR8CI0Otaz6aj8KXibPdVGXsaN87kERiErIi50gBfB0QW
         FpYFWegaquuFzgYfi0F4NsDN+/0Cv4e3TBIvT66Rhqm8IZ17APcNOqAWXJaquPEJeFEz
         JWs3VsLSm1OTgyHWIlt/LzAjKSVC7inCZt6P1T2JoXcg0rLqBH5lCKpaPnYZU3sA7bKa
         CRngV2pDdDzJtvSeEUaEkEkVOSvop4VmXGuzDyr2Pd/xrGRkhWEmE56mUQSY5Y+Jv005
         vpRT/3m0oHTrdfcNQu0EAKbVyO7enMps+DYgmfxcYL6u7brlyROlRpBUWRzZs+tqg+ig
         IqOw==
X-Forwarded-Encrypted: i=1; AHgh+Rp15w8oESrOgFQpV9BIAPgPuTLaVIaHeKNwJd3K29ZPjGw4nr7TXN19007TbQa5B3CmjZtUSw2QeMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZvkkeAO1igK8K8+3wOwTvEyCK90y/D5ZplsNrKmWMh6nbdySX
	oTl6lZFc5KD1hQ1DHX3omkVBdaIuxEKmtKbhnURO7pm9kjNI6A4Dkz+9ylTQL+HAUNbubqNJBjl
	CyZeef/+yyI1G9I+lp23NfOp7RzEUO+afkQsqu+lVsqivisxatX+F+OUIwQ97/D4=
X-Gm-Gg: AR+sD11iSkLcMt9UuwcwnbxoJov0H6/on+SJnpU5CVCRTdTicHDhscCf3Ii4zybEN+/
	LEe7mz5DN81F46j+YTEwBB8dR3XYR5+rV5mKO4vA6e2oul8YPJOg2T4FuRJ4va9+BAaY9Is8DZ5
	85NmGIs8h3EaQcynZSTtW5Hd2AyDHGt9/zdod7A/LtRjQVnkpTMpWl+2CjakOe25rU8HYqt499Z
	BfPtTtpECkfxWC3o4UUb9KQ6jUkpfxoSk7W7ZlgJu5K6SCoYlLZoNjd7EgXEqIvQORG/wEGfq41
	fj8se7VYfVQ7EEU9J2NCrYVDZ871cGCZjB9DfXzlG9MzkgZ25VDEkDdL0Dzhz55SJXKCbF+l84O
	sdfsv1et+vnvnUwdLwA2x+upbGg6CQbwm
X-Received: by 2002:a05:6a00:240d:b0:847:7a61:e68e with SMTP id d2e1a72fcca58-84f4febe965mr490068b3a.31.1786013564173;
        Thu, 06 Aug 2026 03:52:44 -0700 (PDT)
X-Received: by 2002:a05:6a00:240d:b0:847:7a61:e68e with SMTP id d2e1a72fcca58-84f4febe965mr490026b3a.31.1786013563745;
        Thu, 06 Aug 2026 03:52:43 -0700 (PDT)
Received: from [10.217.217.28] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f45bc9b32sm1179448b3a.58.2026.08.06.03.52.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 03:52:43 -0700 (PDT)
Message-ID: <752aaae3-10bf-4714-bfef-e075ce30604c@oss.qualcomm.com>
Date: Thu, 6 Aug 2026 16:22:35 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] thermal: qcom: qcom-spmi-adc-tm5-gen3: Add support
 for QCOM PMIC5 Gen4 ADC
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
 <20260731-pmic5_gen4_adc-v1-3-9c49b2eea6f9@oss.qualcomm.com>
 <20260803011709.31cf83f2@jic23-huawei>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <20260803011709.31cf83f2@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 8uk6Xf8rWW1-UMzlabsLK_FDUzqNZXKr
X-Authority-Analysis: v=2.4 cv=JYCMa0KV c=1 sm=1 tr=0 ts=6a74677d cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=VLISa07izfuZ2-VxH8gA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDA4NSBTYWx0ZWRfX/jDxr9xgeM0e
 o4DE8efm+4by5Nk+5mL524l1/XwDU0Ypw0aI6MjsFdPgia+8NwOEcb6ZANBeQvdAhSVCbGCg8Hq
 Q3INpIzzpOFP7Yh07cM+GFyldhPMtT/sFt+5767jGVBSUtxfPbbpFJZsMxUFo1Fd/NA0r5u1wag
 T3+Kyj5UvHWhBOF4fN8kFWdTIuAKuy7GiCIxscykxFRHF9zPVN1/FBeycQTEhr5ti7im7pvuif6
 DFVf1ZcKYXsLJ16eNiqiLAkUqobQPdkOueqoQyvA9HI9fP9X0M8bPHKeVqAvj2GgO6eHiOskJns
 EugE/XVJfgxATkI8fDJII5xFeklnuH1VxnddtE611KPfpPtZ5+9RqiKlhmoXx+z456VtjIyT4yY
 wRda37sqUZMe7sneMzcr3u0ttTk3mBbaePUyx6VKCOPhiHHf4tjLihoQUoYKF3+VEJ+KH1i2dPB
 30SJCo3Mwpqt6nzmN2A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDA4NSBTYWx0ZWRfX7pn4DueJzWRs
 bnaNNucZImXkR4FCKCDpkhs/oL0PxHczuB/x7raBJcp8JViTzcDNb0y+ulCfUzhEW7cL4Ctj1pR
 L4HlklxXQPZoMODD8v+/VFgfR8sUqKs=
X-Proofpoint-GUID: 8uk6Xf8rWW1-UMzlabsLK_FDUzqNZXKr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060085

Hi Jonathan,

On 8/3/2026 5:47 AM, Jonathan Cameron wrote:
> On Fri, 31 Jul 2026 23:36:16 +0530
> Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:
> 
>> PMIC5 Gen4 ADC is similar to PMIC5 Gen3 ADC, with several changes made
>> for improved performance, mostly at the hardware level.
>>
>> One significant software change is that ratiometric conversion resolution
>> has been increased from 14 bits to 16 bits. Add a reverse scaling function
>> for Gen4 ADC thermistor channels.
>>
>> In the latest PMIC arbiter version (v8), there can be up to 4 buses
>> under the PMIC arbiter and 32 PMICs under each bus. In order to
>> support communication between ADC on the master PMIC and ADCs on any
>> of the other PMICs, a field of width 2 bits is added for bus index
>> and the bits for SID are extended from 4 to 5 bits, in the SID
>> register. Add support for this.
>>
>> Co-developed-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
>> Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
>> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> Hi Jishnu, Anjelique
> 
> Code looks fine, but I just wanted to check.  What happens if
> for some reason the patch before ends up in a tree and this one doesn't
> Do we read the wrong temperatures given 'bus' isn't specified?
> 

Actually from what I see, patches 2 and 3 need to go in together, else
there would be a compilation error in one driver. This is because patch 2
replaces two macros, which are used in both the IIO and thermal drivers:

ADC5_GEN3_SID_MASK -> ADC5_GEN4_SID_MASK
ADC5_GEN3_V_CHAN -> ADC5_GEN4_V_CHAN

It looks like I missed checking for bisectability, sorry about that.

To avoid this, I'll add the new macros in patch 2 and remove the
old ones in a separate new patch after patch 3.


To answer your question once bisectability is fixed:

The changes in this TM file affect the flow in the .set_trips() call, which
is used for setting high/low temperature thresholds. The .get_temp() is
not affected, as it directly calls into the main ADC driver using the
exported function adc5_gen3_get_scaled_reading(). 

For the specific situation you mentioned - temperature reading for Gen4
channels using get_temp() would work correctly with patch 2 in place, but
setting high/low thresholds would go wrong for all Gen4 channels as the
conversion formula is different. Bus index not being specified would
also cause errors for configuring channels on bus numbers other than 0.

Thanks,
Jishnu



> Jonathan
> 

