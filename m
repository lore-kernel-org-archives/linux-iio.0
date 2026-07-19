Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E209030DEB2
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 22:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784500598; cv=none; b=Td9O99tYKZhyrOm9ioln3AssSRtkKJFl6YPTuBC3z3au20Mh79FPlACiuanYoLe20JFsmvX2VUqfSakcOswyFmBjfCKvxH2l/mfZ/srJTymw3i0zaC8vwYmmnaagw/Ivq2sEMxfuiT25nYqrG+xtoLrxKDPnjIUgXy9nF8MJKqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784500598; c=relaxed/simple;
	bh=TvHQr7mR8zbyNCsbYrCFEQMuGfn5VssLHfQxXppL0/4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nR25CaEpP2HAC2N7UUlF0GAXjfMskVRH2uw99yka8pCuDTdM/D+U59RCi/6xFI2AWBa0XuFfFfgFdoDzP31oQbiMvJ/B590Izn6ufF7v5qvJEiVe8U7zU7hgqeyulWSYnWS2gxlsuwUa00mrghIgproa/LxhNajaoeWAc8QiWpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WgNLEHAp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K1RsA2nc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WgNLEHAp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K1RsA2nc"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66JKQdkt1487885
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 22:36:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tFkbhIWtREEqHp6N9J9dlRkEfhn6oy0VKbjuYDPpRxE=; b=WgNLEHApJybzhVy+
	S6PghIJn/4MFxFi91pBw1Oj1TGh/qA6FIp3pN4TpOIW5QfZZrxwodZo5Rxe4QFCP
	evUeZCS7SXAiOgiXNdTIPLr2aevN0HaTAamrDgm+tW0cmcMDC9Dgic7RTZVUdUXx
	+6e7pb8EVuLXAo1EK7axBw2yJU+sulPBVstQ7oD9dXY3PjgEclvD/ingu0lgMAPD
	j1QZZLxlC0VAwgZc2A1UNoI/helyyQn5l0AOijncUOLRGd90lzY9+FcUYDVfErmw
	GvfQNJUeR+1TacLq4JmmgLy4ZOcOwWqIOT3fwhNDGJpw2w+s62JxHZwyagzAr/8f
	WtIV5w==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2aaujh9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 22:36:36 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84865f326efso9954012b3a.0
        for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 15:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784500595; x=1785105395; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tFkbhIWtREEqHp6N9J9dlRkEfhn6oy0VKbjuYDPpRxE=;
        b=K1RsA2nc81T+Ecc4NtcOC7a5/3DTe9YZuP2Fdfx2Oi1XhcmbFA5C/yhyEgprBh51Kn
         Kl/a/vZ9pBTdvP+DTsCmBNv2hxTuwDCyDUcyT21TLyZz4zJb3LJ8SDpeZtLBgEu1P5vp
         ekIs8fEMeTL1ldg9AiRkEIawB32f0alBxQpFoOJcR3co6qY5lTlyIXhS1GLVrzCFs/FL
         E2QMkXjHNyKM0FHKEpyHMS8FSEmyf1TOg5hEEqX526UNc7qrlCIinIBN5/RYKGxC29p7
         20e0z/BOT2WCcFRNC4d8RfH8S8JM+C4Sa8wAgLMf4H3Wk5Z4jhUrzU40iBTer67U+puC
         3MYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784500595; x=1785105395;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tFkbhIWtREEqHp6N9J9dlRkEfhn6oy0VKbjuYDPpRxE=;
        b=o8Qk7+ImpNwcWTBTOjTF10UEQqjZUJSoLjS6aT1GcjHwR3ik7SwDnduKs8P7Jzth2h
         2KjKAeIdo7Yn03fIMMH8CReWz2p/kHbTqtnpQy4B6UajC2RTkPSQu17nizqSXwmcpxd1
         I7dNDkqD4fVbgE8NAAKERE+9wiZe08tzJxyO1N9FriukULJcAFcB0wr5tIPXZpIN720B
         HrbmuLhAevuo/4QzeZnyOtboG+wKFghOG32Doi4jdP3MLFfIMHrpYMkWFxalhjU/59ga
         NeMY0mwUkoSOu+4vwNHgp63igjDsQTnHAyHIITbzP20pzqb2KM2cv9KO9vfzuPy5MKsV
         ViCQ==
X-Forwarded-Encrypted: i=1; AHgh+RoQ0LFJfJuUdn2qu8+LbTqiJb3AZdrAIj7hENuXlTKRPwunIrGGh84bSmkWJZpzuvjhlO1i+VhBnnA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/As8DSza4dIkWIQcuIHo4n/tk+FutuWZ3Hk7PndnFp0UHwi8O
	68rSuOTg/aNPsbj4y9tU5hGYZQPSK7vUnzqyoIuvI/4p5n0fZ8qOjGORmqm9GVT5tgajaILgStf
	JATdPuYFdo3sCQOKRbNds9QSiRXitxGCH6tsJebulPA2JdoGWq4F6HoqI+BLSOno=
X-Gm-Gg: AfdE7cngnMkgQisqNWHPF/8iSDodD8s4eCzPePTQdoLRxuqWi0gXwOr19h1x3K20mTy
	GlA9V9Dk+vmO+Kg3yedOmbw3DRckjLonWdSRLZGGYVN9E/F08Kfx5GRBvJnWCk12C0my08Jx+Wz
	lAYT5XLEynl+8MdAYLKb3Hz/B+ei+y3E93jocyC8UHD6jAw2fhQJKCmmQkELR59Y5x72EybH0HK
	3sQOC9gNopdndpELh+V8AT4pSe+a92dAD/Kl2aU8Uxz1qfk83M2eZVywQEXxuXbANnTm3xGC5Va
	jdKBfHdjHNYgVa2jnlS1PKwEMJ036rMgYltcCcynTf17aovPnZTPy0Nyg5v16rSRO+qSr5uZPmI
	Y9zkPAcyTxiFWfn+A
X-Received: by 2002:a05:6a00:2d96:b0:848:827b:70f8 with SMTP id d2e1a72fcca58-84c29568573mr10913969b3a.67.1784500595384;
        Sun, 19 Jul 2026 15:36:35 -0700 (PDT)
X-Received: by 2002:a05:6a00:2d96:b0:848:827b:70f8 with SMTP id d2e1a72fcca58-84c29568573mr10913949b3a.67.1784500594910;
        Sun, 19 Jul 2026 15:36:34 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2af30befsm4501171b3a.38.2026.07.19.15.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 15:36:34 -0700 (PDT)
Date: Sun, 19 Jul 2026 23:36:30 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Vidhu Sarwal <vidhu.linux@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
        Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Per-Daniel Olsson
 <perdaniel.olsson@axis.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH 0/3] iio: light: opt4060: Fix integration time, pointer
 type and error message
Message-ID: <20260719233630.70820ece@jic23-huawei>
In-Reply-To: <20260715011544.281148-1-vidhu.linux@gmail.com>
References: <20260715011544.281148-1-vidhu.linux@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: lN8WKGCKvGRN7XC2XSlT3_1UAkFcZDfa
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE5MDI1MyBTYWx0ZWRfX9F/5GRTlULNI
 i6RlMdeChXDCSJTpeEwoZ0+lgW/NWF+SMIl7jSdyABYDy/gCOsIESDvF7zBxMKT6z3+Zd1qgoRP
 2hXX0IR7cCbQ5H3Eyot9hpKm8v3sdT0=
X-Authority-Analysis: v=2.4 cv=b9aCJNGx c=1 sm=1 tr=0 ts=6a5d5174 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=xk8rw5UoGxskDpt1Cc8A:9 a=CjuIK1q_8ugA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: lN8WKGCKvGRN7XC2XSlT3_1UAkFcZDfa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE5MDI1MyBTYWx0ZWRfX1cBKkT8A38G/
 8OYQyqpURiLGdQ0ENUy77G7lVySFKy+aQSMutHSSuw7bABgASXrD8ErvloKydWLqQLz6N11QM81
 MwRrIrQ/t5asiGVfbdW5kQ9O9qA+rXuwgTm8e5u1GFeHoLiKJqqWvPMpJFR1oSGhDjFYD10u7/I
 oUbUWNPiurUPVdgihaQ3unu3Ds5Bx9oX5tcZMVNusMoNqC81rhQFo1SOdbMrPxdYOL+jnQhWzYr
 xBfHvu+A/PXR/Dk7++6ASKet+Whstygzix1QCUe67jCpUYEQIEFX7Q4dnpz6BlqAcTcoaXca+Pz
 ah41nLMteX8QBYcxGphAQUM/weav8lk8xv9VfhLR1fE1+FCniM9vZaRgzW3HcFzDBIBqaEmOX1R
 cTM+pXcW3TIfloqJAynI65YjllqjErg6ZH8GMgWzmTw8Ytmw4QUMmmhmiLNxyco/jkh6NPrtdWR
 QzYZAyEWnkW0lt++QHQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_07,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607190253

On Wed, 15 Jul 2026 06:45:41 +0530
Vidhu Sarwal <vidhu.linux@gmail.com> wrote:

> This series fixes three issues in the opt4060 driver, all of which have
> been present since the driver was introduced.
> 
> Patch 1 rejects integration time writes with a non-zero seconds part.
> Previously, opt4060_write_raw() only considered the microseconds
> component, so values such as 1.000600 were accepted and programmed as
> 600 us.
> 
> Patch 2 fixes a pointer type mismatch in the call to
> div_u64_rem(). This is a type cleanliness fix and does not change
> runtime behaviour.
> 
> Patch 3 corrects a error in an error message that reported the
> wrong threshold register when a register read failed.
> 
> The first 2 patches are similar to recently submitted patches on
> it's sister driver OPT4001 [1]. 
> 
> Patch 3 is specific to opt4060.
All 3 applied to the fixes-togreg branch of iio.git.
I marked patches 1 and 3 for stable.  The second one as you note
isn't a bug with affects as such so is less important to backport.

Nice little series.

Thanks,

Jonathan

> 
> [1]: https://lore.kernel.org/all/20260714113134.3445-1-nikhilgtr@gmail.com/
> 
> Vidhu Sarwal (3):
>   iio: light: opt4060: Reject integration times with a non-zero seconds
>     part
>   iio: light: opt4060: Fix pointer type passed to div_u64_rem()
>   iio: light: opt4060: Fix incorrect register name in threshold read
>     error message
> 
>  drivers/iio/light/opt4060.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> 
> base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa

