Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7950473C88
	for <linux-iio@vger.kernel.org>; Fri, 21 Aug 2026 10:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787308824; cv=none; b=qEea+aKYXtrF2ZLimB6Gxdn3RGAx3zbtalc6XM9XxzaDDzIo1d12i7n9PAtrZupIl1zJVovwTCU8lk4EISMHBPQ1UQ/hREEZ39nKzDgzCNcqS4Ra8Vi5LDfzFHIN8F9BvrGj0U1gCeDuA730Iozz/xKfo8hkklN263iYJNOv11I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787308824; c=relaxed/simple;
	bh=4XT6ntiCxwhOqfZIrUkceX0KNYF91a+0pYTPiObSL7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qVDONp8svff6qjHvZNwSsmmIryweD6NMokTqr7GzZ07lSH/mDjDMvn9MHMXIvyiHGiWj5sKSXFjtOwAaFEB3uaNRvtQvsk5/+4ZLgB+WvphxXqlHm0+4Chm2+WeEMveqhCojchyUN/fUTYyNcs4fjllJ+30fFRFc84NuBDVOM6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NgoMoxPZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D10NF1ZT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NgoMoxPZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D10NF1ZT"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L9Lthw2324786
	for <linux-iio@vger.kernel.org>; Fri, 21 Aug 2026 10:40:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zmQDQA2g5A0auoXQvpFaUoR6tH+1iJEktdW/IULXVvg=; b=NgoMoxPZ5dKpPnji
	zZ0B6FzL0k/otu1pPIMa8ElHEAf3zOdExgu8zRStmhIVQN1DtU23eiwvzK9HFdau
	Tj0PRmYpwZHL7j3qoMbqGgJirtbPlxumF9hquWC1EJ6QKSMtU5BpwlKppHo5uYz5
	KMwZrYrl0UK9R0ZBaWrdHr0GFdiDK3r7VKh438RlMXIE6CYOczqy2MNzhLY90AQc
	0HPHNoAOBLjHcLXGAhPoeSZRwhitT9sfaqLW/rhcJ61Rp3G2EzdZ4LAZGtZ++IyY
	VDB5l8Umv+H6O004t/G+AIinzhMm5P5c0KlfqjJNIdvtWmecjihu0Xy1spM/EDpZ
	afZfeA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6gdf14fj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Fri, 21 Aug 2026 10:40:13 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-9368b4c5964so60663985a.1
        for <linux-iio@vger.kernel.org>; Fri, 21 Aug 2026 03:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787308813; x=1787913613; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zmQDQA2g5A0auoXQvpFaUoR6tH+1iJEktdW/IULXVvg=;
        b=D10NF1ZTLiKAfC4U/W33NWy7qRAG7RLtO/Aa19Gk5oGd0wL1VZyU1gb6y1zkmIJo9q
         pD/iGpURl3ouKi8194BkffBZjivcahBXE618yUrWh73cZqjQbl0ExnjNXBVReQ0GefWz
         bR4gbomROABM0IwFJEVbUu8zq0jZHHj2O7Y7/DOR3GU0uV5DSBJpBi4Ft+IBFmUo4gJG
         1Bd+QfhWbbs3g6yPgZSzO/tkv8kj/w9uWIRM0m8Bcd3Z8xq//oNBDViAaahdRqcgt8KV
         Mp6wSsvF1j6sthEuBPn9uVOCYFTqTIxtpNbnPQjayL8V/vpmsSCA5lxrLnby9DVGmZE5
         KwKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787308813; x=1787913613;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zmQDQA2g5A0auoXQvpFaUoR6tH+1iJEktdW/IULXVvg=;
        b=FzmndJ2XDqZQm7kqvuPKgEJFjUWGa0XQasnUmyanyH1HbRr5L7HGJlWJc0K9UX4WAo
         6QvQYyk9rd+L391OgAmtyyybtDKfx8kl9Tpl9Yv1Rp0FDXOspla9qN3sjo7sSn63kjO6
         1HpHQiTqWIJdnTo/ASshLdMZm01SsiaknRws/CCeQ0r/w43VLw6rpbFkXM/thz/nxtWF
         SX/i6WLZvdjxifvxuCXFMUArTqEBZIxQSkj0gXhLzpFDnD73itEr2OcPic1ExCx2IQCP
         Jae7UwpYNY/zIbIQ941PhOT9qzhRgulH8yAM5qW/Gnxvf/T7AQlx8EPVEpt20S0zgYm3
         YPjw==
X-Forwarded-Encrypted: i=1; AHgh+RrYQoLJqB88v7WNigLiOPva0XEY6FftYabYiDoqAea9ocLdghvBs0Grvt/zTrsOipfkcdNiN2rg1XM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDNe+CF+w4ou8k1jsjCHTbzdOWmrnnYaDHtW33DyF/9f/WUNzn
	oVXeY3BeAK1N7/JFQydTYuYNaau3OX5SdnDsMdH1dq4A7uhAE/nEj9HFmLE8HJAce/gS6QmGnrk
	b/iUMgo9CNz8Fi/lasGCDCsafpp4sMFn06G4kPdnN1Sdkf5ezugpeCrZxCCyBEYQ=
X-Gm-Gg: AR+sD11bjehYIM5TumusV6Yzm4WuxL50z4v1dZbiRAyiJewm6RrkQNGsVumF/hqQtts
	U4fNS4keEwffVvvVi97LEMpDMPFbr12mxo40i7kH+YTZ6d7RBBHg4eAxd0+WdSJxYePWtFtnyFU
	yNHf9m241MVSOTOMFcfpVN+RfUC7kep0h2GDOmpREofWufxlCoIS/W6BGutVPNi7ssNpGLj6j+c
	fI7ETVehgd5FncTePX7N1pTRSNq3tNT+ipySlNRJM8SGLM/8qE3pBXYhncOFvURLBu0LKW/WA7O
	eve352mIr9yxhL/kJwh9rhoQYsO3LHan+3UXPkcUAI/dW0IMroRvGZ/o5PCVaOaE/EQQBFcQdPz
	7mwB+P7ASEOwCMPmPPNWxBsffld1NSKGRgQ==
X-Received: by 2002:a05:620a:a08c:b0:92e:e299:dfdc with SMTP id af79cd13be357-937395ceaf6mr346264885a.21.1787308812671;
        Fri, 21 Aug 2026 03:40:12 -0700 (PDT)
X-Received: by 2002:a05:620a:a08c:b0:92e:e299:dfdc with SMTP id af79cd13be357-937395ceaf6mr346261085a.21.1787308812183;
        Fri, 21 Aug 2026 03:40:12 -0700 (PDT)
Received: from [10.111.142.131] ([212.136.9.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b915cda6sm27044825e9.14.2026.08.21.03.40.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2026 03:40:11 -0700 (PDT)
Message-ID: <5b840b5b-f44b-46c3-ac5d-9f7ae0a97d87@oss.qualcomm.com>
Date: Fri, 21 Aug 2026 12:40:08 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux-next] thermal/drivers/qcom-spmi-mbg-tm: Add module
 namespace import for IIO_CONSUMER
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Mark Brown <broonie@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        Nathan Chancellor <nathan@kernel.org>
References: <20260812-qcom-spmi-mbg-tm-ns-modpost-error-v1-1-d849390d2714@kernel.org>
 <20260813023543.6936b188@jic23-huawei> <20260814000505.GA3919970@ax162>
 <aogl2JvYUnxwr_cE@monoceros>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <aogl2JvYUnxwr_cE@monoceros>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=CsqPtH4D c=1 sm=1 tr=0 ts=6a882b0d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=/bviTfK1dmy+WGcHzWQ0gg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=Z_i5BMom4yr8lRnCMGMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA3OSBTYWx0ZWRfX8NokNVhKJwb8
 Tk8ChxNXTjCF2bFrmiGRnvbCGCGyvkj+rz27NDkhV3K4jbmNzq81zDy07zb1QBIl1UuifdwT29E
 9qC1puTeJePRIDjAbsOrtVghw1XEUkCckiHQYNW7KapeO0NKC1CVk2JiDIxIH8NLBl2xHwbRvUJ
 Zd8xf8oADbk0nGmM529+pi2Cl6ksIFwOwsMUbwDD0tbEUiyZdJ80O8OwKX7d5e7CiEqIy45ZYuu
 3R7ncNkyaWAWH8zFdmS5nRUXGZ2qzVU2BlLc8TRS6cnguSoQzejVjHObbJZT2UEudVbG1/aD45Z
 7pJU/ckNOJzJs1uU2HJncRl6nDPL8xKv4iV2zvFkz1G72D9WXWrKdPFIC3vAm0Q7vZkFzXN32vM
 jdHJfmCn867KUu0G3KzaQk44fW9KRuIAqRN3hk12sM0dva+Eu3Gl+aGKPQXSLDVeYVE35bNgnwD
 azgtopkMstQo3Xmyurg==
X-Proofpoint-ORIG-GUID: pOr3yZOdkqPEY5_4cnsQigxHLwgMw3-d
X-Proofpoint-GUID: pOr3yZOdkqPEY5_4cnsQigxHLwgMw3-d
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA3OSBTYWx0ZWRfXyULId1ywEC+z
 fI8uy8whmOLEbRxDh3jpzLjJVq6SO5Ol0+NwKCPcwuA5gj6drSNlc8hxWvHgPJPsjPS0znS5Bb8
 GDBipWa14zvBDrjO83hiT/iih7Q9riY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210079

Le 21/08/2026 à 12:29, Uwe Kleine-König a écrit :
> Hello,
> 
> On Thu, Aug 13, 2026 at 05:05:05PM -0700, Nathan Chancellor wrote:
>> On Thu, Aug 13, 2026 at 02:35:43AM +0100, Jonathan Cameron wrote:
>>> I did plan for this being a possible issue:
>>>
>>> Ideal is merge
>>> https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git #iio-inkern-namespace-ib
>>> to the thermal tree.  If I'd called that out originally (or a thermal
>>> rebase is a possibility) it would be cleaner to do this before the
>>> qcom patch adds another user then squash what you have here in the appropriate
>>> patch.  Alternative is do it as a merge conflict resolution whilst merging
>>> in that tree.  If the second, I'd also mention that in the thermal pull request to
>>> Linus given it's a little unusual.
>>
>> Ah, I did not realize that you had a stable branch with the module
>> namespace patch. Merging that in then applying this to the thermal tree
>> seems like the best course of action. If rebasing is possible, I do not
>> mind this patch being squashed into the original.
> 
> FTR, this issue is still present as of next-20260820. Assuming that
> c3dce117333c ("thermal/drivers/qcom: Add support for Qualcomm MBG
> thermal monitoring") is supposed to go into v7.3-rc1, it would be
> awesome to address this before the commit hits Linus' tree.
Rafael ? Do you want to pick it up directly in linux-pm/thermal ?

