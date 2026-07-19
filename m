Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFC823392B
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 23:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784504830; cv=none; b=Fc03vG5XdIBNMB6RFoUMtglAIQff0x5eXhAY8oTKtw+4+bfUQhR63tsONF91HYQl08kUe0cMRoqor4PpNBhtbyY7MIBJCsc9FpxWqQvW0SMUszL2R620EWLncX7Y3oMa6El1YN5org+g8bd0VQPdpZkFbZJc2mTYXCKRRbV04yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784504830; c=relaxed/simple;
	bh=l5yrIXfTKJhn/KaYYW7GzYpifUhfex9+BTfAGokHpQo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tjaeIu2e8b0NDj5f5g/r8O3aweb0oZMRO/9j6IjTGz+4CCQ+0D6qpPKHM6QE8nB03uo7mnoUqEiWBRwfml2SdEChTfC15B6bhP2hhaJ3p47BCNb019eWFYfS6TWCGE7RxqXH/IyIvrK+yQ1RMGDERbrWezAN2pIMz+yaJfUTVEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oue+c9Ux; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XemRcjO5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oue+c9Ux";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XemRcjO5"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66JKRhSe221737
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 23:47:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	b5g0YKFLM2vbBNnmNMZFT/ZU8dATm5jCfG0sB+Plxqg=; b=oue+c9UxQxKjwKoU
	iVYqWaycg2FxO7ol2z9pZRhOz7M+G7uCJEEVgTzy4VKcyvtIwz3Ng+CIe5mdro+H
	nn1jrMVe100UDK81p/2IEi8trpi8YZZGoADAeFigTDQ9Mp7BtHpSx2AjDo5duo+A
	vMhTVQQB5bG5PDuRLweus6+sK4evzNT4uUut0UPVPSBXCU26BC3JdHTXsyQJaytd
	6NhetfwOmp9jMsnicSNn/6mEqhKRhk/JrXc5j1X14n6FsjxW/fGMmkihUmUNQMOO
	8QSfpc4W1rXaBK1i5BI43XKe/kuKQkqIsDBmQrqsTl4uwDCN9XGoQgcNNhRPLRd8
	kcxFiA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2bvups1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 23:47:08 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38ce7fabf76so13675286a91.2
        for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 16:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784504827; x=1785109627; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=b5g0YKFLM2vbBNnmNMZFT/ZU8dATm5jCfG0sB+Plxqg=;
        b=XemRcjO5c3lXzM2JKVBmZTWDhA+OoLxbkwfM8B68iDkFasZHSHwp4jvt3AtdYHQSQL
         UYrRQ6eBIG1IcsTFCsR3gV3hpHWuRqjlWRUyAiyffUk84OMLY2av7FC/KLGdRIlJxZc8
         WhlU0gKVsojvRHBwu7M0yjQSujvPUxgD0XGrsZj4Ad0naYwG54VdCreow/t1s7Y8Ls9l
         Dg5s60C58Skpu7QQOqTssicu4uVxbEBeytzu4dmhmFtLLD+9UktX5dNo80cHa/om0SJw
         txHX1bONkVGIzt4QM+fbXjz4HCbSLh6QOHgtdfUNAYNNkBTnXiBi1i0m63Y4orqNLe5t
         xEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784504827; x=1785109627;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b5g0YKFLM2vbBNnmNMZFT/ZU8dATm5jCfG0sB+Plxqg=;
        b=iKjjfImRgWsXZc14iyPpt7xsQxXcoQu7owyQpidbrVd25JcM20cFFSwMxEdpAwEz82
         HPnbNLL+KyJCeVKQjCV3xIHcOZ9hOfS4uAxdw4TmAJ3cDcSWDm7R/IUOztNkPSqeCJSD
         j7uxLJmAQuhkR/hxBGo/t16ZMiti5ZkWfK2MUgAeD6Zn1tGobkVrkq6d42afTdl8wEws
         5bl68bG8fytWYY8cqk96KbmL6eQh2yuMuSwhi5jCEHttWPy8AWC2NG1QhAtjCQsn8f+h
         CURTF9ryjLZy7l6WprQsnTrKe8dEBLb0TkFwg6PZYKVlGyVE/m+lGBTsqVnEKG+C17rP
         mr8Q==
X-Forwarded-Encrypted: i=1; AHgh+RoF6MaYZWLEU+1e6ZkofPXVgvPnKGbFUH7Ye+yK8NKOvApyqFyB0d6WOCz7XOEb0OzYZu1mJY/s+QI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBcDPMVzC1V9X/NgvJXDXqObkImwxKrbMp18i8CrFIKtDz/Ak7
	M9kU4ZD/pyB4VIPeuwr5P6vFSmOvc52CZObv2uFyVdoaMv824Y1E+FMAwwxzsAzAa4HT1BPsOYG
	iLmMPUPStBVqe0rSs34DEBfRiDJ7QRoRrecDtx1zoKqOIyk5N0jUVkLs5Z7ATVkw=
X-Gm-Gg: AfdE7cnxRpn1rvNcWelTiWOXQ67+x0ElY53Hj1dvwUzYiOcbbLBkryOSCl5ZiumIeKu
	FjJn1bqJW5hfkUi6+B+3YwbhPHiIlBYTebWRFvON9vMwGh9aglIGrPM+tqZJ4Nb6ECaAaRyRVlt
	Jh9eolIu0UKsZ5eEQ5IYAKo1JYUSB6mYGCnrb2/GCezKXmzgGc/VsHzcy4OQfP4zB95QFqSx+5V
	q0iAXZozjDcfQcOis2fsu4Y0WAIQgw3qI1GCObfYJXmNYYGHI3fUQsKf3vXmDejaRGxFVxqYDOC
	aMEWq0DYNb9JVv7ixYu34SsNa+/k6CeCqQckZlICGjpwtY+iTU9Z8N5MpoiC2B5HvImAf1Z7c1k
	xF8F9ZQG0AXXltJCh
X-Received: by 2002:a17:90a:d405:b0:38e:712a:bb38 with SMTP id 98e67ed59e1d1-38e712ac393mr4444969a91.24.1784504827264;
        Sun, 19 Jul 2026 16:47:07 -0700 (PDT)
X-Received: by 2002:a17:90a:d405:b0:38e:712a:bb38 with SMTP id 98e67ed59e1d1-38e712ac393mr4444930a91.24.1784504826702;
        Sun, 19 Jul 2026 16:47:06 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e4b0e828asm4885687a91.12.2026.07.19.16.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 16:47:06 -0700 (PDT)
Date: Mon, 20 Jul 2026 00:47:01 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
 <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Chris Hall
 <c-hall@ti.com>,
        Patrick Edwards <pedwards@ti.com>, Kurt Borja
 <kuurtb@gmail.com>,
        Nguyen Minh Tien <zizuzacker@gmail.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v4 0/8] iio: adc: new ti-ads112c14 driver
Message-ID: <20260720004701.20474fef@jic23-huawei>
In-Reply-To: <20260714-iio-adc-ti-ads122c14-v4-0-25f8e3084485@baylibre.com>
References: <20260714-iio-adc-ti-ads122c14-v4-0-25f8e3084485@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: cQFGLCJsfCa8OR6VOLL_Dg55Me3Rsket
X-Authority-Analysis: v=2.4 cv=EcH4hvmC c=1 sm=1 tr=0 ts=6a5d61fc cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=9cybnhKkAAAA:20 a=bC-a23v3AAAA:8
 a=IpJZQVW2AAAA:8 a=DQu-socKgU88agjaWOEA:9 a=CjuIK1q_8ugA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=FO4_E8m0qiDe52t0p3_H:22 a=IawgGOuG5U0WyFbmm1f5:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE5MDI2NyBTYWx0ZWRfX4+WKxfwnqXp6
 1oyE8jqdJLL7Ewfx15cdyuuj4kpJf2SJFs7W5+2Zb1ll7QmGxbww69VsMJDG/RKJOllR1QOHiU2
 fV5Ket1qGyobZ8aRoEKqYnQIpAjIoPN5lIbUl/wRn/Ov6PoGV0iJwXhZlw96sd7BPjCowQGfPYA
 yV1v1Zug6ioVr8rkdbwEvImM83Zetd9qlSaGM9Pao95O8HZ8E0ou+fDqPxRJmVN4u7hl7C5BRcf
 mOQ/AZCJISf+hOIHZnvF8AXuG6gwBro4Kgj38/82K2EkS/X4J0DgM3W/vE1K3v8rPeekm5Jv8Fk
 Ag8oIesii0vEN8W4weDeZRZxQCDc4iSWZmKD/1p9qUSAT7PzBUw/APIYyMXDsgHc+km4zzF+gJu
 0I0wi1uL0BTt6bpDLvIEsI/3il9FsQov6H8MnWm5TWdcNAywH0IRGErbE1zVkOWfBSp27eNyRK6
 1Hz16FHJlDSohsYgwpw==
X-Proofpoint-ORIG-GUID: cQFGLCJsfCa8OR6VOLL_Dg55Me3Rsket
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE5MDI2NyBTYWx0ZWRfX2NHot4mr6x/G
 FlhZa3Mu1k9v+f9frVWunKUGFPcs5P/vvXY8sHlfGY37sODDYXd/wkwNBwq7tQrJoWSm1q83PoG
 PxPecLAFqgAvzLQEWILgl2qvv76uqJA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_07,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607190267

On Tue, 14 Jul 2026 18:21:22 -0500
David Lechner <dlechner@baylibre.com> wrote:

> This adds support for TI ADS112C14 and ADS122C14 ADC chips.
> 

Applied with a couple of tweaks applied as called out in replies
to individual patches.

I thought about bouncing it back to you, but the changes were minor and
I really want to reduce the number of series in process!

Pushed out as testing. Please check it + maybe give those remaining
comments from Sashiko another look.  I think we are fine, but best
to be sure.

Jonathan


> The closest thing we've seen to this in the kernel already is ads124s08.
> However, that has a completely different register map and the DT
> bindings are incomplete and the driver is extremely basic. So I've just
> started from scratch here.
> 
> We've also had a similar submission recently for ADS1220 [1]. That chip
> is in a similar situation to ads124s08 in that it has a different
> register map (but the submitted DT bindings are better than the ones for
> ads124s08, even if still a bit incomplete). And literally as I was
> writing the previous sentence, another series [2]  was sent for yet
> another similar family of chips (ADS1262). That one is even more complex
> in the feature set than the ones I am working on.
> 
> [1]: https://lore.kernel.org/linux-iio/20260610151342.44274-1-zizuzacker@gmail.com/
> [2]: https://lore.kernel.org/linux-iio/20260612-ads126x-v1-0-894c788d03ed@gmail.com/
> 
> All of these chips have in common that they are designed for use with
> RTDs and thermocouples and so they look very similar to each other in
> terms of wiring and feature set, even if the register maps are
> different. They are in the gray area where we could either keep them
> separate because they are just different enough, or we could do like
> we've done before with ad_sigma_delta and have a bit of an abstraction
> layer for the register differences and otherwise try to share as much
> code as possible. Normally, I would lean towards keeping them separate,
> but in this case, I'm considering trying to share code because the
> devicetree bindings for the inputs is complex and is going to be mostly
> the same across all of these chips.
> 
> After seeing Kurt's v2 though (that doesn't attempt to share code), it
> seems like the chips are different enough that sharing code might be
> more complicated/messy than I initially thought. So I'm happy to keep
> going that route.
> 
> This series includes just basic support for reading single measurements
> from the ADC and gain selection via the scale attribute. I plan to
> follow this up with additional series to add support for buffered reads,
> filtering/oversampling configuration, event support, gpio controller
> support, burnout support, DRDY interrupt support, DELAY support, CRC
> checking, external clock support.
> 
> The most interesting part about this (that I alluded to above) is the
> way channels are handled. These are multipling ADCs with differential
> and single-ended inputs. But what sets them apart from other similar
> chips is that since they are designed for use with RTDs, there can also
> be a current output required to excite the RTD and this current output
> might be different for different channels. So the way I conceptualized
> the channels is that the devicetree specifies the conditions needed
> to take a particular measurement rather than being purely a physical
> channel.
> 
> This makes things more flexible, but does make the driver a bit more
> complex. For example, knowing when the current output needs to be
> enabled or disabled. For now, I have chosen a lazy-enable where they
> are not turned on until the first measurement is taken that requires
> them, but then they stay on until another measurement is taken that
> doesn't require them. This can lead to some oddness with the diagnostic
> channels that may be measuring something that indirectly requires the
> current output (i.e. the external reference voltage when it is connected
> to a resistor rather than a power supply). This means you need to take
> a measurement that requires the current output to be enabled before the
> diagnostic channels will give accurate readings.
> 
> I have also pushed a branch to [3] that contains the start of some
> documentation for this driver that can give some more insight into how
> the implementation works. It still needs some work and also documents
> some things that haven't been implemented yet, so I haven't included it
> in this series yet.
> 
> [3]: https://github.com/dlech/linux/blob/b4/iio-adc-ti-ads122c14/Documentation/iio/ads112c14.rst
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> Changes in v4:
> - Kept the review tags on dt-bindings patchs, but made some changes to
>   a few of them that are worth a quick look again just in case.
> - This didn't come up in review of this series, but in other mails on
>   the list, Jonathan has been commenting on improper use of claiming
>   direct mode, so I have added a mutex instead.
> - Fixed use of 64-bit scale storage on big-endian.
> - Removed burnout code (saving for later series).
> - Most other changes were minor/cosmetic. More details in each patch.
> - Link to v3: https://patch.msgid.link/20260710-iio-adc-ti-ads122c14-v3-0-746d52cbf1d0@baylibre.com
> 
> Changes in v3:
> - Mostly cosmetic changes and a few bug fixes to address review feedback.
> - See individual patches for details of changes.
> - Link to v2: https://patch.msgid.link/20260625-iio-adc-ti-ads122c14-v2-0-ceb9b0b561cb@baylibre.com
> 
> Changes in v2:
> - Added patches for adding properties to adc.yaml.
> - Some of these are coming from: https://lore.kernel.org/linux-iio/20260622-new-channel-props-v2-0-aafd5369f253@gmail.com/
> - For now, I have stuck with one channel per single-channel pin or
>   diff-channels pin pair rather than some of the other ideas that were
>   discussed. Handling burn out current enable will be handled in a later
>   series. I'm leaning towards something like the _burnoutraw attribute
>   that Jonathan suggested.
> - See individual patches for details of changes (mostly renaming DT
>   properties, fixing some driver bugs and style issues).
> - Link to v1: https://patch.msgid.link/20260615-iio-adc-ti-ads122c14-v1-0-e6bdadf7cb2b@baylibre.com
> 
> ---
> David Lechner (TI) (5):
>       dt-bindings: iio: adc: add input-chopping property
>       dt-bindings: iio: adc: add ti,ads122c14
>       iio: adc: add ti-ads112c14 driver
>       iio: adc: ti-ads112c14: implement gain on internal short SYS_MON channel
>       iio: adc: ti-ads112c14: add measurement channel support
> 
> Kurt Borja (3):
>       dt-bindings: iio: adc: Add reference-sources property
>       dt-bindings: iio: adc: Add excitation current sources properties
>       dt-bindings: iio: adc: Add burn-out current properties
> 
>  Documentation/devicetree/bindings/iio/adc/adc.yaml |   41 +
>  .../devicetree/bindings/iio/adc/ti,ads112c14.yaml  |  217 ++++
>  MAINTAINERS                                        |    7 +
>  drivers/iio/adc/Kconfig                            |   12 +
>  drivers/iio/adc/Makefile                           |    1 +
>  drivers/iio/adc/ti-ads112c14.c                     | 1206 ++++++++++++++++++++
>  6 files changed, 1484 insertions(+)
> ---
> base-commit: aa58ecc73466d0cb8c418de98e2225490bf600e3
> change-id: 20260514-iio-adc-ti-ads122c14-d0b92479334e
> 
> Best regards,
> --  
> David Lechner (TI) <dlechner@baylibre.com>
> 

