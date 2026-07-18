Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4420346FB0
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 21:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784411103; cv=none; b=Q+AEoVf68oyzJw7SOH8DEW7IjPOobqeT2b4xQ8ug7Qjoia41rjX7ueRToJJMv81qIei0tr6nhUnTspPMLO5tiWvXoT4hftVYB41TGuz4NOpRA/eJkmF7vIKbc4z1JQymWcKiwlngFfjgea9Pul1jD2vUqZyhLfEMdtzMKF9Ek3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784411103; c=relaxed/simple;
	bh=ih8ms/owZ+RScVB3ZJrDZi7GqO3cel0/toM/R1WJzYg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G8IWpv/kZhDNMIU4tNgthgz0rACvWrMbGXt8zKI3xgbXXyMMVRx7PzvOEyiftzrJqqbLPmU1JDyGtf2PL+Vl6UNbIZnSCPiDJZ/tRbe8hBvv+QmWEAjLZuNQlcs44B1IjiwifYkkM1xFur9ghxbC/eCbX1vu1qVrnkvivKd46RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K4rC3Nno; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GZfKVJci; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K4rC3Nno";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GZfKVJci"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66IJrC6e1692542
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 21:45:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	v9i30X73wLKDf8GyIvQ4kSpBdJxAnI7LPj28ao4WKTc=; b=K4rC3Nnox28v1ZK4
	cbv2aLCbTJjX3QdaOHeVYIqancbrmqt70GCI0G6wEzMFNiuQxXod6jl0cqT5yI67
	hzxJs2LYgbycIuyy83fPUyyGV2+jx2SnYOXR/xjkGPUC4eQXbyW2Rd29f4htcbAD
	SEig+I1u29iFtumDdn6aJIO6Srgk82awyJaCjbT1n6zQ+DPHLx0KeHLT2xYIS2Rp
	xp0k7pxUz1f0/SOJTaYsOkZBcqauA25/F3KGdDJqkLwjx+dqQyh9Dp8hEvaRcq7D
	JpX9zY/1iHwgzyaR7IPjYibpOkOO1q1ujcg8wXhMFvtamKpWuBShNMhFGCo7pKXe
	VoMZVg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2c69mbc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 21:45:00 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38ce7fabf76so12579662a91.2
        for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 14:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784411099; x=1785015899; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v9i30X73wLKDf8GyIvQ4kSpBdJxAnI7LPj28ao4WKTc=;
        b=GZfKVJciuNoSmepHDXDhQbgXRvcUt9WzC3m+DaSEIuxzj3uBZuxhQfQJq8yNEDkQ5j
         bFl8MObIaqo2HXK8R6ZQV0pWJgY0/P5LkUGpUX0uVYVEt7oH4ddPKxgIuXgGrX3A7hE5
         TM1AB9WaR3ZV6FcpRTUtF/9iizBWOoOEFpGAkPGpgJ7DlJ272/8eiQLxpOWP4zN6R9nI
         +oMSSsJ6hC5/szJYbCYRIfLouZX14ZJSNbJyEVrBDSadI5IX35SaOIk+xKiSfFy6e9IR
         hT9C8PNhbebmJjcJC8IjkKG11MbtqMArSxek4N2GhRsPPmsbR1bnhHLc7iXnLteU5gCc
         +2CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784411099; x=1785015899;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v9i30X73wLKDf8GyIvQ4kSpBdJxAnI7LPj28ao4WKTc=;
        b=Bax1r3GwkwBJdwqd5jE6hdQoZdC/jSPT526gl7/CTzs4VY5pTqVaLhLWhRwhAjTzGm
         a8/IkST2oc8tHbPIxBPpVnEZ3kyLNAzr16sIMkgnIEjpnJL7iv3J5IfXJcNRJCoQUDhv
         EUutjjneFhknOKbnGal16FYKaMDi48MuXjgWg3QjK1HBmzLiXnlC2kxgwiEkBXRm+lyd
         JzcLDFJCZdMobo4k7f+sR3pheKwYokok8t36PMELTChXZPvUI03MKD1x9FmMtpVXHZTz
         952HYnaN60kF4ikRsZJbdvpRcM55QMetD6ZVFtotLS8IsEGcTAAeiUGEYQPVLtOJ7GNc
         GDVg==
X-Forwarded-Encrypted: i=1; AHgh+RroDBQauF63TpvGsaUNNscqq9zNlLODtwXzRGo2+Bcnpr7r+n+bTtNK4bEOUTmOHLvzWrzSo3vr5oc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4V4TRoXc4L/JuW6sTyVsLR0mSZVsr2nlviTHsXNWHnm+i/6qD
	O6Atuf6e+WjO5m6cbaZ301pJA2z5ReluHHdOzWb+gf+Hfria5PDWqDxm+rDXE78f3wc4uEy6bZV
	sGNyyqPQ1uykmsxdWpjn1kGbPh57lhDK1k5CDgDBpklYy/QKsRFE2FP1w/r2RJkY=
X-Gm-Gg: AfdE7claP6ak4WiI5GRTl7KO3c9SQAtIWuTbE0+V9ekkIY5Smt7XNemH1taSLL8t4oX
	YEQwDAGZVs7uNKbYVNOz6vhvK7xWMGlyhSFYfYJoHtMkrZEPrF0KDiR/WOWDcfk7hqpa3sd7YRy
	sog44/NVyHE3g1g6SiNArT7GpetLXsuZpW3Xe0/MQTjeu6SoD7lyd/2K1zUfxf3KLGBLZ1UdeZh
	U6iSAPE4e3Z723yVhk3Lvac+ZtzD9NEBHz8URGDovoL/iSIabmatL+ob4KasFm3XmK69zHQMa1G
	dkpHe2Dhst175cVlHz+XAFDB3JwcC0gR3MZeABjsVdEGcn0vNVAU/5gtkDIDBIMynXHFU7IMRnx
	d12SI2doY2vsQ/DR6
X-Received: by 2002:a17:90b:580c:b0:38e:2524:724f with SMTP id 98e67ed59e1d1-38e4b410109mr8821644a91.12.1784411099590;
        Sat, 18 Jul 2026 14:44:59 -0700 (PDT)
X-Received: by 2002:a17:90b:580c:b0:38e:2524:724f with SMTP id 98e67ed59e1d1-38e4b410109mr8821625a91.12.1784411099131;
        Sat, 18 Jul 2026 14:44:59 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e656e5686sm1265884a91.14.2026.07.18.14.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 14:44:58 -0700 (PDT)
Date: Sat, 18 Jul 2026 22:44:55 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: eajames@linux.ibm.com, dlechner@baylibre.com, nuno.sa@analog.com,
        andy@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: pressure: dps310: add FIFO support
Message-ID: <20260718224455.38acd927@jic23-huawei>
In-Reply-To: <20260718211727.39752-1-zoone.rupert@gmail.com>
References: <20260718211727.39752-1-zoone.rupert@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ho8Qy4jAPjzF5CuPYqVKRAoQ36W0BsVa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE4MDIyOCBTYWx0ZWRfX7KHYiHa9OstD
 zaLlSpocEtb7GmtvcQISGzZXg9tx98z+/b7/lREw+AR4PYauPxJEEQBFre8mK5LTq9vEKHgoCwq
 Gvara7yZ78BBx2Q5hmhIl1gSG0oI3YX68+4wJ7Nket9Jg/sh482G76JTKYelSZwtzisVcQhfNrs
 hiDrN0BrNBQzBAPEhwkxRpWIRo5dSajCxPwXC8VKfVW+mCROjSX8QOsR1c+GeXsQpzqmbLxFfEh
 nOPE1PC3gRqFjv4fgx9xQCqDScXtfx2DieorPMewL4tNfD1ilYrQLB76pwHbwJ5VGxY2ihLVk9p
 K+Or3S7bxXXg7ywWFNh8iIx1mSBvbkjva8Qt1MH8MgsBVijyCLMSMLK8GL/D5RoDf1UdTlWMaXo
 u2hT1B2YTNZ7GTbVh/+OonCd3nOmq6HRa3NgR64WFPQ4aGfBQiaTJ0pPJZMa9vOZ+F3iC//OO62
 Z7xwxqoglV01SqTeKEg==
X-Proofpoint-ORIG-GUID: ho8Qy4jAPjzF5CuPYqVKRAoQ36W0BsVa
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE4MDIyOCBTYWx0ZWRfX/BqTvolI8kvl
 lKMEJKkaeJscecY1q2fgZFUDouoWRrA0lY0PpPN8OtEoLOaqMS0D24H51VEU+4k200TWgNAO1Wi
 rBCzFctVq0fb50g03flfY9DnMA4WZXE=
X-Authority-Analysis: v=2.4 cv=CJQamxrD c=1 sm=1 tr=0 ts=6a5bf3dc cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=pGLkceISAAAA:8 a=nxv-fjLCAa1BqBDA6HAA:9 a=CjuIK1q_8ugA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-18_06,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607180228

On Sun, 19 Jul 2026 00:17:26 +0300
Rupesh Majhi <zoone.rupert@gmail.com> wrote:

> The DPS310 has a 32-sample FIFO that buffers pressure and temperature
> readings. The FIFO_EN bit was defined but never used.
> 
> This enables the FIFO in the probe after startup. Add the necessary
> register defines and init/flush functions. If FIFO init fails, driver
> falls back to single-shot mode.
> 
> Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
Hi Rupesh,

This looks to be a v2. So check Documentation/process/submitting-patches.rst
for the format and use that if you need a v3.

> ---
Also change log needed here.

I thought you were going to submit v2 with the full buffered support?
Perhaps this was an accidental resend of the earlier code.

Jonathan

