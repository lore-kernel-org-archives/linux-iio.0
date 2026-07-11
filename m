Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293E6314B63
	for <linux-iio@vger.kernel.org>; Sat, 11 Jul 2026 23:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783814355; cv=none; b=q0hoCdA2QHedejzLLoPiQL3oj2paQdcAx9TBmyxu90FFGHpK1NYoH0IyjElJCc+67pgG9sJhKTn3iuF7thAiivjZ7nimnsVvpHv/Oh412kbtLTfD+i0GVo1RsU7m24+SjcnpqSzjastPyNj2XnJT/sMIYHGAZvnH9oqXwjsNWWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783814355; c=relaxed/simple;
	bh=3Bo1jP3FSrJ/y4Wz866thIsc0EA6jjA4gqz8ci/KdJc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RW0bKD1lZ4oQbeb33LZudAaAACejnji+835Hfby09/scdOBy5w3N6nkzeLMMMCpdANSKyIiEs4aIp5xgOiLlikE0BTcdYrUQxcnmS46qhm92Bw2xyONdiJRNr0NfOp0UO1hMVV4TAWJ5l2FQcaaxih8jUl4WrkIV6yMIpMndzGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HUu6Urt4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ei3/OhLM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HUu6Urt4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ei3/OhLM"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66BKvxbZ776709
	for <linux-iio@vger.kernel.org>; Sat, 11 Jul 2026 23:59:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4wSgUdv+5waYuxVEOE3T1MOkfzAqGMVWHKhNUKZc5lY=; b=HUu6Urt4UkB3suc4
	8C+HjX878a7MfVHOrKzdH4xZwbiH+OLt3kQbQs12Of+qJYw4R0gwGA+8QU6zwTZM
	EPr6+RQSt6qqjgDmXbqF7l78XIUmClPHm6VC27N6ITdQBZ/1iYZVtyvvMl32cij+
	e6igHBj3gwmCbzKvrXxsqD/SgBlEWBMmKH3eePgWbg8yvAafZ8LjQR3RBslmA2j/
	nBXuEb4ktaiyfqx0oDrfX/9SP7EEekWHLdJDPzs4UF3cMgFYAnQdjIU7B1VTDmrK
	QmByR/bovjAR64mVlLD41Uvq0E7VnnUQOd28hKhigwGEvFOhdodDvvqjPifemqBF
	Bch3wg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbeaf9sn5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sat, 11 Jul 2026 23:59:12 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cae455cf6dso28825955ad.2
        for <linux-iio@vger.kernel.org>; Sat, 11 Jul 2026 16:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783814352; x=1784419152; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=4wSgUdv+5waYuxVEOE3T1MOkfzAqGMVWHKhNUKZc5lY=;
        b=Ei3/OhLM3JGBjjwZBKK+ecaQ72UsY7bVI0E7rTspTPWKubA1NJa3NTbEs6L0GQNSfK
         bSrFcClKY+QFAgn2fCJHXDKBLBF+uJTEcTOfqaWJOYwgU/AUDut5XtYb5rlDDNQBmAFk
         EnjIeR7V0W95SrvmETh1TnXGXnyXJq7fkvNUu5TV7hKRYscgKorLh4wnh8IJrZIXSxPd
         O92ymTWBrzH/qOdpRaihDEy0TvxXtyhYcBPeYC4lT3WsNEtnX34/NZ9kPPtb6pnP7lrY
         9c/u7S4pJX5TYKrMdayrKvgK/5qLfCtrQ0OdCDbwV8QDQqPiGSMiK2RwUXfCwg3pL3EK
         0RPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783814352; x=1784419152;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4wSgUdv+5waYuxVEOE3T1MOkfzAqGMVWHKhNUKZc5lY=;
        b=bvXgJQYRSlpta8APW8wBoW+qyF2wdZ32ywxfUHbd4U+7RtKnfUQpRMf9QewP6mLZhs
         /10Mutu26GXmyhyh40W2KxuRDo7wzkUNRmwbCyf/Dn8ISWmAY1igkQLAXRL+hC5kFU9o
         5n41ZjQDgtbcsFti54vAp1BnMdtwIpvcB7ukoBrPJ1ST/71cu8wkymxSMDGbTPAS0750
         qlVuWhIUbLH8W7/SjgeHzj1LQrD6YFQ005rP37ittZxCbpYFwxhxkuAKlaXvn6VeuRsB
         U8WKLrtLiXLbaLx1u95F/VMZKCaezcxIY7aE0NGF8gLDEVMfEGNPqH2+XieSV1fUVxQm
         cmjg==
X-Forwarded-Encrypted: i=1; AHgh+RpkfkFhOcXXn2yoU5e3ptwbMR8V8DYwNX2Y6a2AY/+ZESw/+Rbo71AQ83kfmsPF0bgNqcoiiVErOA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyA/T8p2SONHYd3tfr1dBT4utLARmtcJCT6M4+YZOF16ocTmXN
	FcAEEcn4fZoNV0fPNylCAQtn4eV3uYhcGGEkshWAHRxNgLFvZpT0Uxk6j0PPqKoQrwdR5cxCObZ
	JnL1gAuE5DQCllz1bL9a6P7vvL4vsON5UbilN8sg9dccxYzkwF1QLzdXm9CHs34M=
X-Gm-Gg: AfdE7cl6soP4ERd950y82UZYJbj7TbnXfbrok1r+SbEqWC67CbNabtD+GlZFrfLfTD+
	cJ03s+J7W2dS6e5S4V562aGrBiIJKxmNtDlFV9Kq476k/zp3GWriB9j3dFbBzQljHzydbeuCCEh
	eAy1K5Q7KwbeXr32dBud/AufM7QZK0OlWKz+TcPDiAYau67d8RPo5UHw/7hdLoJDnsVoGF1Q19M
	G975HAqH2mIjpJgL0qFUyoqOEsodxz1LM31YJ+MDPkA9KSBzQu3GFm14alyT4PB/T+1hzWBjDcf
	eJsAwsOt57t8irRXOw4SZVU99OjufYy5gUyaL6g2lLUsa4T+RoAhoYEqE/GCVGUJHhfJniWAe3y
	JmWlal4+3AZOxu0EjksUsxh8Hsj0=
X-Received: by 2002:a17:903:3204:b0:2cc:7759:ffac with SMTP id d9443c01a7336-2ce9f052d4emr49349165ad.30.1783814351812;
        Sat, 11 Jul 2026 16:59:11 -0700 (PDT)
X-Received: by 2002:a17:903:3204:b0:2cc:7759:ffac with SMTP id d9443c01a7336-2ce9f052d4emr49348915ad.30.1783814351363;
        Sat, 11 Jul 2026 16:59:11 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ce9dc64037sm16641265ad.78.2026.07.11.16.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 16:59:10 -0700 (PDT)
Date: Sun, 12 Jul 2026 00:59:06 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: jikos@kernel.org, srinivas.pandruvada@linux.intel.com, bentiss@kernel.org,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] HID: sensor: custom: Fix fields lifetime issues
Message-ID: <20260712005906.4f196ff9@jic23-huawei>
In-Reply-To: <20260707071545.3087073-1-haoxiang_li2024@163.com>
References: <20260707071545.3087073-1-haoxiang_li2024@163.com>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 2LCLDXHAlcucK3KDDJE8O1VnVKHSpgVq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzExMDI0NSBTYWx0ZWRfX+8cKd2Wn0tjM
 i5PNDeHu05+JaXQK90ooU+mp3RB/WuzrztQd5Jv3mZuOuVa+8/9RG6Z7u9ILH5F+hxjYMgH4NOd
 KOFMJOq3qta8ibq5kv19PsG0sOHTI8uKV6lpYuCorecuXFxFfVesKd2OKicoi2Vq8E7dHUUMb/b
 j6BVrK7nVqxsTbwav+AigtRLh9eZQa/MHKPFv/R0uP1651f+zwdqFyOzLyxZ+U51wqjV/Rhf25A
 7lWZdOYr4kdAc7IeGeu7g662rtyXuXCgGxbf0IiXl+2k397AeR4E4AYk5vdRTHr5JrLiqfjcs4T
 K91F2z6qdgfy1rWeqY3+02AnPMgt0YTAs3fYSNZrpY+TSRidiYMqwhhoSccVc1zJqKJHdlMebTg
 qAiZMAxej8hntffSWV2yta0GWCXR9XpMsFSAM0zZ53gfgk1Zl2gkoz1PClKcLnbQx6i56TIvV8m
 6J83mcIX+xcdwe4Ifng==
X-Authority-Analysis: v=2.4 cv=O5MJeh9W c=1 sm=1 tr=0 ts=6a52d8d0 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=Byx-y9mGAAAA:8 a=4bbN0DY6XaUK8setVPYA:9 a=CjuIK1q_8ugA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: 2LCLDXHAlcucK3KDDJE8O1VnVKHSpgVq
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzExMDI0NSBTYWx0ZWRfX9RCrXh3jW9gS
 vJDfaP3e4uspnhxWtYmUgIUuA0r7eehYnFJuRw4nDuodof2mpeyssSz4E5vNSyFGCBngqPUpSO7
 xBemABO7fW/mO6Eg+ChNce1NpqEi7lg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-11_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607110245

On Tue,  7 Jul 2026 15:15:43 +0800
Haoxiang Li <haoxiang_li2024@163.com> wrote:

> Hi,
> 
> This series fixes lifetime issues around sensor_inst->fields and the
> sysfs attributes that can access it.
> 
> The first patch creates the field attributes before exposing enable_sensor
> and removes enable_sensor before freeing the field attributes. This keeps
> enable_sensor from accessing power_state and report_state pointers after
> the fields array has been freed.
> 
> The second patch fixes the original field sysfs group leak on probe
> failure by unwinding any field groups that were created before a later
> sysfs_create_group() failure.
Series applied to the fixes-togreg branch of iio.git

Thanks,

Jonathan

> 
> Changes in v3:
>  - Move the enable_sensor registration reorder from patch 2 to patch 1.
>  - Add a comment explaining why enable_sensor is removed before fields.
>  - Add Reported-by and Link tags for the Sashiko review.
>  - Keep patch 2 focused on the field sysfs group cleanup. Tanks, Jonathan!
> 
> Changes in v2:
>  - Split the fix into two patches.
>  - Unwind already-created field sysfs groups on failure. Thanks, Jiri!
> 
> Haoxiang Li (2):
>   HID: sensor: custom: Fix use-after-free in enable_sensor
>   HID: sensor: custom: Fix field sysfs group cleanup on failure
> 
>  drivers/hid/hid-sensor-custom.c | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
> 
> 
> base-commit: ef0c9f75a19532d7675384708fc8621e10850104

