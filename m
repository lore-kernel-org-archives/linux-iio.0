Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B950306D26
	for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 16:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783961809; cv=none; b=nMf4ADtiuiaNHLGtI9lJW+lUj/Ea5vzkS2IuR446eF58N4Gfd5UIZGOJVhk8UCZVblEaXJPO/Mrx0dlJEGyl8p+yuIl5HSRfe5b63YohXuu1jQM2Vy4FZCchavdqAj0lGnEL+VguS94d1Mlogew8WvleQhiYsTFomWMhG6PlVEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783961809; c=relaxed/simple;
	bh=f1dENWIJHys20RMrMzjKwGdXIMauPk3ExXn/7QJeIaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rRZWIVuK7+Nl0B3vCz1SGuFdo8NCGYc1d9lswFIsEHIzZ77mFND057FD84QDWTYOUxJcMswi+iB1TqHfWRhI4gO2Pfw1R5F6MhK6tAxSAqxYzQIXITNusV0Ucz+gkYjxJELG4/DYWD9gV2ATv3mg+zhkOalhifDRDuBd59fzFr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CXHyQvkf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iq0E6/4b; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CXHyQvkf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iq0E6/4b"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DF8U5B1803676
	for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 16:56:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t1BTK6gFt2giEtwJiw2DRM0UmiGtqToj6SdQoef7PZc=; b=CXHyQvkfz6bBl2Pt
	uw8jCZ2dmva3aRyVyYaavB3xthMwVC+62Hs27bbn16wmR+usqY/AS4Akse1extmb
	BA+4dlU8aZ2pU7ysSkVBXodzjx3ypvPO+wsHnLvkrAl3atXYovjpzGti0bNLIYhk
	5jhnxN/s5vy7hu97jXSw4cxI7JSUw1Rp9XF5ZPd3dN0EdwQwSrjfOfsrn8SD86JN
	IiXu/gR8G5T0KOsRx0NLI+0oOqmJb9x7ceJRk9y/CN1+TkD5Rh0VfHUJmGnXopsV
	4MR/BYUd/q9+FyiuM6pTdooxQ/pHH+njA9+uzprlOJKXi1kKHVys9mTsvQnVrV/m
	M4Thqg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwu4snq7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 16:56:45 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38869800848so5400613a91.0
        for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 09:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783961805; x=1784566605; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t1BTK6gFt2giEtwJiw2DRM0UmiGtqToj6SdQoef7PZc=;
        b=iq0E6/4bybjNgq3CiQTP75vusHPq0bpT54n4AQVFocFkLj+Znvcuqrsn1FuPLX1sFH
         2kVM4MjVhSHFmePdxgJ/pCAHsq3NpCtgTE4fW9u7SE/8L29ev9ttMItN9Z91mwehHPRQ
         LoPdcFwcA0XEu+PbaMFMOKn1CdPvnexLcOwmnJCUSQF1ukkXIR5MDVv3kEdcXXn6/25F
         jEVl6tw+2yrnke83XDOHh9A6KjdSvc5T0t5HhfU2w8tJZJ4EvOzywLOEU2k/k3Csx37s
         k2Yw57sygD77of6VPePQgynFpiK38HKcHacjbY/esTjOkiH1t/VhdAc+P3f1efvVDZu+
         oatA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783961805; x=1784566605;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t1BTK6gFt2giEtwJiw2DRM0UmiGtqToj6SdQoef7PZc=;
        b=Ixm1J4zAkYrRF7NOLAMobMawcsgr70RKj9Q5JLlvCVKrJi996zJ6WhlAozqJMYekKJ
         RwPM8ZCHeGu3q7Z3qDO6LboLNx6ox6ILAjXZioaH+FQpwewHMTt6bvbAmypbpRNsClyo
         CHbo/brt+LdaUVhiJxOy4v53bmhB/lmF6iI/AJuj1dpgiWSyNwWNrLKYoaZLEHAR5En6
         Prv7kobgMuC6HC8Vo2jdt8c6ieU95qTv9PaM59zJChQnvjKkiRjPul643jA81dLy9Low
         NfUPr7oLRzpoZ1JDEFafckixompTEIXWkkcOws0DarPjGowTjEgTUCex+65T6gRBckSp
         e9IA==
X-Forwarded-Encrypted: i=1; AHgh+RpbB5FJmLe/CgKt1+M1M1MuVLaYFd4wdrh+5G4KdHJJr0WcRFVqJzQ0nHWRNiRbyUZWtOnqyladJaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW9EyY9Qc/hsn6a6vXYtG/K5NsHOdfKYoW3HSVoRruqTJxAzzl
	T8qCp7mR+8Ow2etXZxkF6GsxZ5JImWsjGR4bPi4c8FfATlDvV1DlQAksleKje634snRcNZYp66v
	DViVix2g0zVpa6IyB8fMqAnIqi73+i+FVUnonID3i284Rb8cvouH0F8n4fGHueug=
X-Gm-Gg: AfdE7cnyLFbTBanO1FrP53uhYOJ3jwhUIRK1x+wzQKxfy6A0UUDLchBkBj1ivor5JGY
	GXd5dS/TENq/8NasA67+uevTD8qi0lEmminAA9Q855m+Hthrdfeyc4In3+JPHuSnetupHHprQhI
	xVnLG8/X7MLnnzmIW0Aq9gX6JwQgJ4qv8XlYrA/2hFc9Sesus6bHfxeM0D6PAtMCCSCMGnnBi3N
	OSA+Yw0+gdx0S5mT6KimVr/ED6T20GkxWlr+YDeR4AXd7FoJ77nhgm7IFxWSnKklIXmPbwgDEkV
	xqxc1SNo0SXR/QeEluJxtU7yF5zRP1mzQ6sbII+pLF4ak+SmkUKL7IDayvrv/VAEgOOoCYF0fWS
	eZlvuh3CmlSCtHaSzUxjhrHIxvLG8oIc7cFrgf9LCVou/iA==
X-Received: by 2002:a17:90b:2802:b0:37f:9ce1:7364 with SMTP id 98e67ed59e1d1-38dc774cf00mr9949880a91.26.1783961804612;
        Mon, 13 Jul 2026 09:56:44 -0700 (PDT)
X-Received: by 2002:a17:90b:2802:b0:37f:9ce1:7364 with SMTP id 98e67ed59e1d1-38dc774cf00mr9949860a91.26.1783961804152;
        Mon, 13 Jul 2026 09:56:44 -0700 (PDT)
Received: from [192.168.1.100] ([157.48.180.168])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174ac14f2sm76694721eec.27.2026.07.13.09.56.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 09:56:43 -0700 (PDT)
Message-ID: <ee6c2c71-d988-4bc8-b716-1468458965c9@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 22:26:36 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] thermal: qcom: add support for PMIC5 Gen3 ADC
 thermal monitoring
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        David Collins <david.collins@oss.qualcomm.com>,
        Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>
References: <20260705-gen3_adc_tm-v3-0-ac62f387dbce@oss.qualcomm.com>
 <20260705-gen3_adc_tm-v3-3-ac62f387dbce@oss.qualcomm.com>
 <bbe3e9a1-86df-4c36-be68-ed480de10c1d@oss.qualcomm.com>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <bbe3e9a1-86df-4c36-be68-ed480de10c1d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=FMErAeos c=1 sm=1 tr=0 ts=6a5518cd cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=62VzjLAzdHZQ3L95IMgkXw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=ZJtfdnNEmsHLE5vD43oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE3NSBTYWx0ZWRfX+tG/D76dbFRi
 OVWa8sWvr8UqmjzTaR+jqJrzOZFJe1LCF7PjG8q/U4J5x3g1Z5bOi6kFCl7RczPtGydoqEmQsvI
 +QOjkbAuPW7d/hHJyQ4c/jCf4X7MYEw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE3NSBTYWx0ZWRfXz8V6CjW2+q/y
 7fIptba/Yi1DNzVEXBiv7WZGpHjcdIsqYOhvdFFGNwn2OtJuKB1BLKRpRJczOJOU5EoeSxqCk90
 k2NP6ye3UcA9ef8UJHj0vc2+QJKr6GR0UGHuHju7VasYq++dKb+yPtJWCuhWcB5bQLdlRIBs+4n
 6RCB+klzT1FARCfYr8Twel16hno1aAb9RTovvAwzUeRCWe7PImcY4nCkpbwzJlybnIHac8U3H5D
 IXIrKNBUMkkfLtNeyRW2N+xxBBf+hKXqeXLF/6Y/NVNzRiQFiVvXmx8oph4LSuPweDNSgkvTyi6
 GYLOchqdrqNC2X2C/UiFNIr8kZpt1wir/JRy9GTRWhyEuzSeCPZBQ5eFSu5GNPixxbxoxQTvYBH
 WKQgzREL5r2kgFH+c58ESheND78u9FsixGCy+kQAX8RKwSJkylN8WD6MgSkLIRDTfTZcKCSNFSw
 pQJm7cEQHfyo1fqZW+A==
X-Proofpoint-ORIG-GUID: PcbUDWsp5jcqZyt6WKzsA0qV10swOPE2
X-Proofpoint-GUID: PcbUDWsp5jcqZyt6WKzsA0qV10swOPE2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130175

Hi Daniel,

On 7/10/2026 12:38 PM, Daniel Lezcano wrote:
> 
> Hi Jishnu,
> 
> On 7/5/26 18:53, Jishnu Prakash wrote:
>> Add support for ADC_TM part of PMIC5 Gen3.
>>
>> This is an auxiliary driver under the Gen3 ADC driver, which implements the
>> threshold setting and interrupt generating functionalities of QCOM ADC_TM
>> drivers, used to support thermal trip points.
>>
>> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> 
> Overall the driver LGTM but as you are sending a new version to take into account Andy's and Jonathan's comments, please take the opportunity to document a bit more the code and the changelog regarding the hardware (eg. register layout)
> 

Sure, I'll add a paragraph or two in the commit message to give some
more details about the driver and how the HW implementation changed
from the previous ADC generation.

Thanks,
Jishnu


> Thanks
> 
>   -- Daniel
> 
>> ---
>>   drivers/thermal/qcom/Kconfig                  |   9 +
>>   drivers/thermal/qcom/Makefile                 |   1 +
>>   drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c | 425 ++++++++++++++++++++++++++
>>   3 files changed, 435 insertions(+)
>>
>> diff --git a/drivers/thermal/qcom/Kconfig b/drivers/thermal/qcom/Kconfig
>> index a6bb01082ec6..1acb11e4ac80 100644
>> --- a/drivers/thermal/qcom/Kconfig
>> +++ b/drivers/thermal/qcom/Kconfig
