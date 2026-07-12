Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4653A1DB
	for <linux-iio@vger.kernel.org>; Sun, 12 Jul 2026 02:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783822270; cv=none; b=uAqSLKPp5RfoWTqtz9EQfxLuZLKKsdeMw9GOrnf7X361unZv7hflAn+Yassm+bRQt75V5RjGqIG5mpejE+NczkY0dc5pxajFjJLB307S3qwZvS4WyM4ECwAcFLbuKxUkiDEl/fTpZ1+DDfx8nH819TU9aSkwQ8rm6YoAneGf+w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783822270; c=relaxed/simple;
	bh=1r1GbZzZlZfrk+m6SazeIRJ1GWrUC0qiAmiHu1U5UtA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EeaWX+Zmayu/67/Xg/rHiVP+eJJWjcCJoUG2Ta8T2YKeVqGljTjOU334KPcZvhHww64W+XZ7rAcMRJLhvqgMsk+UoInL3Fhp85SxZSu16LW7KvkYJNHuNPFpMNND+ts4HK3uULg1lZu/i0grQHhmpoARevgO5wFka2nXsvIyKQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W1alN7n1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ng8/Ewm1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W1alN7n1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ng8/Ewm1"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66C0XHfQ1102174
	for <linux-iio@vger.kernel.org>; Sun, 12 Jul 2026 02:11:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nXRDhEOOT6Gk7wxRd9wpTs6cwfxluhggpMpIIq7eaNo=; b=W1alN7n16aO974oW
	n0cBQDcTrFVnJ6e239dWqEw3nvJuDEpS3yPqg+Yux5Zer0m+ZRiNe62GkQd3m0A+
	2jopTMz4TRTyy3GVcls63Z4PVosJDvcfh1szBYqpHsUy85TmhlEr9pAJXL0Qjre1
	kepLF/5bA43trh1zBNNq10LSEDuxxG20xIm4PoGJQhjyzscWoCCvcMJRbuHoFCsl
	cCjF3A9TWCUe1NGofzNdcK8nfwuTqjwXmLiIyK5Y3vpcKxRHNRNwljhJ0StxEigq
	M2HdMklnzaJycQOu6Jy//i831j/vvvsOdvS8jnuoSC1YR1XlZ7wFyppNouQh2dwn
	9hJOeA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbeamt184-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sun, 12 Jul 2026 02:11:07 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c85798977dcso287601a12.0
        for <linux-iio@vger.kernel.org>; Sat, 11 Jul 2026 19:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783822267; x=1784427067; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=nXRDhEOOT6Gk7wxRd9wpTs6cwfxluhggpMpIIq7eaNo=;
        b=Ng8/Ewm1Xx+n6xPbSBIlteqOi/LZkRYrd6NseBOmgqM/gfbSk4y/E7uWDlPMAJmfMh
         x0rF1DdWRAxQheE7Vdv+V/lDH5bBbNm8Yvm1bt5d8ismxJ38D+2z9irgztI92cAa0ilX
         zVXoOIXwdIwTJn4a7a/6664W+phsfEDrY+L+ow+hhpSYm6I64gLT0OlUBUfHijUVWZr1
         b0BISbHiuOxj6mqbSDpszfWMzYQfpsKtEJgxhT4KT5+DLHKZzgkKMI59qGP7T4pW2ASQ
         UM8gj/788Htjpos/ez+EFpE72phrPgUFYfkZYm3uDPeNnQxIQYybaTEcPTev+6Gpi9/G
         fOmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783822267; x=1784427067;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nXRDhEOOT6Gk7wxRd9wpTs6cwfxluhggpMpIIq7eaNo=;
        b=ZI2sRGsReBWY33jjyQlSg+g1ASRF+9e+y3zXePLLCogKI6UnRf39N9pwQCEif3DE7m
         kOuoTVY5y4l7jWV8AwwH3shZc31hBisbJw4Zg7bGGkz3c9jTlj7PaixgOKekToeHqARp
         /JQVuxQg686JgCPzXqdSBWkzbGgovrdWk4l9M8sH0Hryrbp1JD16u5nn3DVkrqOV/O20
         qhDQd6NOrzW0mpReH1h/ePWYGhAlU8x7I/2eEu4nIk97m/w/CwZOAmWL/7yFfOj5p+zU
         rO5XS6LJKoKLdhdC5hF19r8z3GEN6vFBwrky6ytD1ZgfVna3KJdTpQvrBetXxR7DOTQJ
         eFPw==
X-Forwarded-Encrypted: i=1; AHgh+RrqQPunBDEN2qSptVcOp7FqPRz2WSMHFkyRctPqNnL1pWZYWy560Rf8pp4ssDBaza396f7Vm5hOkiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXHZCLTygkFx4yyXXeH6/GnqfhcVyGmJqsnN7r/ttuhBZs6djR
	wj/fU9+VmFwk1OufN5FSHOo07sv5dVXxL3utkhOKi6gLHYLS2qMYf8PouwCWvQ+hLjZ/uR3+rSl
	5joZ7v6L/mELDqQJt1cYVgj/YJth6o812Hr1h90wMZFL9nh1JzgeEPI0ur2mKjMc=
X-Gm-Gg: AfdE7ckINiVvNEUp9jyyselioQWm2NwKW5lp8QzPAmzXtI42cUZEjqLe+zJnOH/za/R
	05YkUk3lVfbetsRjRBwHwsZZLnymRHCKZ3KH/maMA2XdVQMLkKJ6yObJt4R3kSnYctq22iPAAJT
	C4zP4Jd67paeLuB8AbLVIHo+N0wp/3cp2HSgqSqBuMdh0eKQUZvYeEMr+BjDpKM4N4RCtYmeiK0
	16RWKLIVWK55Bv7UnDD+d2jGO1WxLAlv3FjnOZn9dB3NvgWian0B17ELvb8MDyfY3/idOhYLpjq
	fOYrCh4JeDGsfDdcdjpgrCRuzyPUI3RP+FIkEK3RP915CBRyeBkgwwgHGquqmzVbz/8doipXeIa
	j7tNmrPcN4AYTHCNSykCIbDViW+g=
X-Received: by 2002:a05:6a20:3d07:b0:3b4:b276:3650 with SMTP id adf61e73a8af0-3c110289537mr6246971637.26.1783822266692;
        Sat, 11 Jul 2026 19:11:06 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d07:b0:3b4:b276:3650 with SMTP id adf61e73a8af0-3c110289537mr6246938637.26.1783822266135;
        Sat, 11 Jul 2026 19:11:06 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5af6e04fcsm6793483a12.4.2026.07.11.19.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 19:11:05 -0700 (PDT)
Date: Sun, 12 Jul 2026 03:11:01 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Mert Seftali <mertsftl@gmail.com>, David Lechner
 <dlechner@baylibre.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Andy
 Shevchenko <andy@kernel.org>, Jelle van der Waa <jelle@vdwaa.nl>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: accel: dmard09: Implement IIO_CHAN_INFO_SCALE
Message-ID: <20260712031033.11639ec8@jic23-huawei>
In-Reply-To: <20260710105109.000047c5@gmail.com>
References: <20260710083623.84243-1-mertsftl@gmail.com>
	<20260710105109.000047c5@gmail.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEyMDAxOSBTYWx0ZWRfX9nY1koTiirX0
 2c/E5ilplVCmZRQn9kNOL/eiZWmebYnBPD2JEqlhGeEylO8rZXLwJG553x3egAGvAyCWvRx+cio
 TGumV0SaWrtGJe6ILbwar/X9S8U4J2E=
X-Proofpoint-GUID: CpxydBjLUkG5-AmBoCpW8du8-ZxeN4m4
X-Proofpoint-ORIG-GUID: CpxydBjLUkG5-AmBoCpW8du8-ZxeN4m4
X-Authority-Analysis: v=2.4 cv=dJSWXuZb c=1 sm=1 tr=0 ts=6a52f7bb cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=QroGHPVtAAAA:20 a=pGLkceISAAAA:8 a=3LJn6HzHc33MJYVoLt8A:9 a=CjuIK1q_8ugA:10
 a=3WC7DwWrALyhR5TkjVHa:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEyMDAxOSBTYWx0ZWRfXzphcDPsEXivz
 mZ240RLQ/FcxAnMwXjjO1X81xClxGetE4g1UFwoYHgWM4BIXXuQimilpYnWgdh0sOEitdtFzNch
 YHIfrfoofHchRms+/T8zRpz5zp9w6hvwjdrZ6xT8Kj4ogN8Ote2+V4IBfuqjloOlc+rdQLT/55A
 OXakMIzTcKp3TKlOLFCB59ThKjZXXPRfAldPdtYuGJ4dYHPTH7JMqiRM5xGIc2In7XlJge6qOGJ
 QYAnn4GXUbxT6VsxOUYSsd1urGY3wySOUb40qU/qCw8BsO6DaGT54nvt5kNuL2qi6YQ4z/eQBH+
 txGKQt5jXb1nKnsQWcdNdGunsFJJAwuvivcg00Z6eSbc8pyhu+q/I7QGmcXvllrjUzRYuvwBbwU
 duAqZFofuCmaGvWcKCQ1qxzSe3DGsqhUHguB2obGN1smVxA51L9cUzbRwGykxALCN9hNSGxmj2d
 vh4WCoC3Ngsi+rk2h0Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-12_01,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607120019

On Fri, 10 Jul 2026 10:51:09 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Fri, 10 Jul 2026 10:36:23 +0200
> Mert Seftali <mertsftl@gmail.com> wrote:
> 
> > Reading the in_accel_scale attribute on the DMARD09 has always returned
> > -EINVAL: the channels advertise scale via info_mask_shared_by_type so the
> > IIO core exposes the attribute, but dmard09_read_raw() only handles
> > IIO_CHAN_INFO_RAW, so a SCALE read falls through to 'default: return
> > -EINVAL':
> > 
> >     $ cat .../iio:deviceX/in_accel_scale
> >     cat: in_accel_scale: Invalid argument
> > 
> > leaving userspace with raw counts it cannot convert to m/s^2.
> > 
> > The driver was written from a vendor source [1] without a datasheet, and
> > the scale was declared but never implemented. The vendor source carries
> > the sensitivity: its conversion is
> > 
> >     acc = raw * GRAVITY_EARTH_1000 / sensitivity   (then / 1000 -> m/s^2)
> > 
> > with sensitivity = 32 and GRAVITY_EARTH_1000 = 9807 ("about
> > (9.80665)*1000"), i.e. 32 counts correspond to 1 g.
> > 
> > That sensitivity applies to the value this driver already reports as raw:
> > the vendor reduces each 16-bit sample to a signed 9-bit value, and the
> > preparation in dmard09_read_raw() yields the same value. It is
> > self-consistent: 256 counts / 32 = 8 g full scale, matching the +/-8g
> > range.
> > 
> > Implement the scale derived from that sensitivity using standard gravity:
> > 
> >     scale = 9.80665 / 32 = 0.3064578125 m/s^2 per LSB
> > 
> > Link: https://github.com/minstrelsy/mediatek/blob/1f49d8c87b839651bc89afc870277e8e0f2e2d55/custom/common/kernel/accelerometer/dmard09/dmard09.c [1]
> > Fixes: a4fa6509dda4 ("iio: accel: add support for the Domintech DMARD09 3-axis accelerometer")
> > Signed-off-by: Mert Seftali <mertsftl@gmail.com>
> > ---  
> 
> Good thing that Jelle sent the vendor driver, LGTM.
Indeed
> 
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> 
Applied to the testing branch of iio.git.  It's been broken
from the start, so whilst it is a fix, I'm not rushing to get
it upstream!

Thanks,

Jonathan


