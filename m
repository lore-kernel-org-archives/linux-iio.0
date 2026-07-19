Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E439F223328
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 21:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784496658; cv=none; b=M4PnjfxbPnQfIOrUfRAyOqECEHHhQwBTonS8WD/Ag2WEo0qVH6HsnJ0R8H3EwCem+GYpTCggsvRl0Y6jnDBSzZh1gBEvycoaUsI82xmbJoOB9U6Eu+ePq7kv/ODvFeb8xmXtEwuhPjFsOBoGsc7CgzKkyj4syqw0H6LhUQx9RxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784496658; c=relaxed/simple;
	bh=uYhD72jyFtcft7wqlIG8dj+1gNo5zDOA0i7x8wGPwXY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VbSJb0ZDoKwRXL4Wkwadnwn5yYchnTFLQ2JaSXIyQkvZYYR2K4icuYjcYH9QULdrBKCPpMfsqIDhWS8iKqhb2GguaHzvPdSEUutJW2sLruwfoej2WoPMrsTojCZMh7CPBgddHJvJhLvOYW0VumWKNihMkiZlNh7SPvj3ubIrP1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LvmYWNts; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V4uyfDfM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LvmYWNts";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V4uyfDfM"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66JKQjwu4183969
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 21:30:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4GBWwZd4zr1Ikl+41JSFiE4ebzTAey4w2s4sUP3axoI=; b=LvmYWNts6O0KOow8
	xyNpIMVhrtLplYd/lXwieeu3mt2YWY3DMDhHlcBUhvRxlPUWRtBvjuYlTW8bE8YW
	kVoY/Q9WKiQ6WGLH5qIOi4nUxz/88iW7lGqGTIhKYc+EfaCsz92dce6SpB0rI4eX
	Vam+qaOi34hUhhBx0c1WSDtra5/3JO3wjolHizxaIv/IJ8lp1QFjWhKC9VaVl48s
	toq4+9uxDub6A1JQJ3F2h3phpjZ4tHXiS5pYjKblkGUbGUUcnXpJsKdBS6Y4B/D+
	FJctbfJQR1KAXN5LAKmUtwo8CKkvN/l4plh1RToJ7X6epa2FqZZ8jfX/WSCWAGQT
	mN37jw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2nhkgby-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 21:30:56 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38ce7fabf76so13581083a91.2
        for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 14:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784496655; x=1785101455; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4GBWwZd4zr1Ikl+41JSFiE4ebzTAey4w2s4sUP3axoI=;
        b=V4uyfDfMvj2+QhqbGnA8tE0j/LOnarFnNwMGOsNc31YcWdSUvUWEI7hLm6tyJZT90U
         9xm2TqzirpJaGwNnSVv5xRnsUie9T6+2j+k8ippyA42u6/CphQt5GL4PaeSGdS3oB5sF
         wb9o5SY00OgQoUBO90jXSq0hFTF05vyodMfcmPEsQZfOZdi1Mp4XUHu6BbSW0uU3ixw2
         Oh7P5q8DQVS/Xl28gPkmbrssCKud3/CW5XohFlyk/xjhWoFDFgUz3PW8SJGzDbm5Bb+k
         LMjFS13Q8pq3Ze6dHrB4D+PYgQvg+IbaZWZlqYiPfR3kwrXUsslecpCdfb6gFx4cuXqK
         IGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784496655; x=1785101455;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4GBWwZd4zr1Ikl+41JSFiE4ebzTAey4w2s4sUP3axoI=;
        b=bb1Y956xUFwgkcCTWCB+6Ziw+WfB8H0ROSBxiKmX7u0wIHMca/0Wsrz8qMIAfIed3m
         h+yNL+xJXuw8pmREAeztUYhgrLLp5JhAVSdpNVZoTW+SPZKRI6cHt350ENd65BN3G/U7
         l8CuwD3bn2I/0c5+xAIiiEMx34q587jIz8+yHr61g1H3zG+5kCCJ4WHFXdf6cZr7QTXR
         SqbmuBJL0anZTOV26Kuu708JyrcImeLvQ5Q+dGRqkuWj6iGRb/CJA3zoOBg5NCxm/1L+
         kk8hCZnktbucwPQTUL9EzY4GJcoZxxQoAtmHetH3ta6Ia/vc3tM34nnScCz5Rgm3oldT
         NZig==
X-Forwarded-Encrypted: i=1; AHgh+RqQ3xUowYkFCShvKvWLh0M5YQumAmJwQu4qoXFxhHos7YL35QHi0Y1Q/Y8wgYkY4+HV9hdxzShXMFk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2LdNwSpdOhIPnYRHTwm3MXRD+AOyiy5z0tIvoOmbB/T7FZa3V
	RCIQxSBHIDa9cFXO8qzNx8/11ZPM5BdgH1FbZmGyA4ukqpCdl6RNb9egQg2EBoDc3yQOAmfJ25R
	HXbUUo+iMhEmjdwTwcv3cuz9Y0BLlRfkWA6qW6luuwDWSkLmdFBBQWO/eAWDfp1s=
X-Gm-Gg: AfdE7cmCg3B1cmNOj4kp97GE8VoSdJ5/LvuTUkyEoTs2bjfkghqYGZs3wVGU3TIgNBh
	Ca8OQLwksmrJKumwiJ/q6ToFCt5m4L90QCX4HQondumwrMQJIjRq7jx8CAXmr/GMBilaRaq8yhV
	Jwh0mQ4+0DLRSsUFwD5qOcYlRxs43m9WgNuKFsXnCY7gCQjEG9aLnW0HCp3IK3G+hf46dv9ZSxD
	h2AlmGar48OA/ZeZbAVMzCz1as0qt4btG31SBKxmgE4VqYdjwMUiEHGZY5qlC9Z6wEQvCAh2lhx
	k8JnkyaM5/EiTovXpWq2XSmHFeZA5kSdKcZiw/h18cqamAA+UZZkxzlmKaplS1MAtK5O8OdOP51
	yGXuRhOLPf2V2yCsr
X-Received: by 2002:a17:90a:d405:b0:38e:712a:bb38 with SMTP id 98e67ed59e1d1-38e712ac393mr4103068a91.24.1784496655352;
        Sun, 19 Jul 2026 14:30:55 -0700 (PDT)
X-Received: by 2002:a17:90a:d405:b0:38e:712a:bb38 with SMTP id 98e67ed59e1d1-38e712ac393mr4103022a91.24.1784496654690;
        Sun, 19 Jul 2026 14:30:54 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e4ae14a32sm4679897a91.0.2026.07.19.14.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 14:30:54 -0700 (PDT)
Date: Sun, 19 Jul 2026 22:30:48 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, Michael Auchter <michael.auchter@ni.com>,
        linux@analog.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Hennerich
 <Michael.Hennerich@analog.com>,
        David Lechner <dlechner@baylibre.com>,
        Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 4/4] iio: dac: ad5686: update device list and file
 header comments
Message-ID: <20260719223035.0acb57d6@jic23-huawei>
In-Reply-To: <20260719-ad5686-extend-dev-support-v1-4-841ec75cf5d8@analog.com>
References: <20260719-ad5686-extend-dev-support-v1-0-841ec75cf5d8@analog.com>
	<20260719-ad5686-extend-dev-support-v1-4-841ec75cf5d8@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Le0MLDfi c=1 sm=1 tr=0 ts=6a5d4210 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=-MFOFTiwL1uGPFAEI7kA:9 a=CjuIK1q_8ugA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: 9QZ8XxVilvPUx4bBzwFUgnpBLJo-RoSw
X-Proofpoint-ORIG-GUID: 9QZ8XxVilvPUx4bBzwFUgnpBLJo-RoSw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE5MDI0MCBTYWx0ZWRfX3qCYYT1/4Vby
 bgY7SZFaxaZJSlHFvYKjy9wYBJpXezx43q9VnOmfw0LqyHDEZG5iTSUZHMzUGAQ6meDK6xEilRr
 iaq8Gk5fGJMyUU/XzxJuCnryrVbL1X6nhsgymlA/ObFovL2MnVB7zYVXW80KOT8Fkv2gjxxG4Mw
 ZeQPhLSgRE1yuwzV9haZuJlyfAbquZ5WDCKBLEXNYR4G/P18RnXvXU8VOmnxcS2COCgpk0AnnHJ
 ZfK2zl1LgQqxdVUhK8VDTYpe+RBBw2M3YF+NH6MoPv62ck8I4JQb8aGZmzh8dN32z073XKdK+1g
 D8PO5lTb4Bwnn/VH1jIrivqCnXgaBbysht63BAUhYlAQ5Rx1WCXGlV6/ZQh6/6PWgBGour5TE+h
 pcyhhiC5gwgtI7ki2WX1omqW3pCTQ2XROByJjZ/4/5jimODXLnZbf6YC4c/iIgQEoJuw3zFJ87M
 t34AM+607fiqrnvfgCA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE5MDI0MCBTYWx0ZWRfX2tB5YtPlVrOY
 r5bpBIOjTbweT7T9DEyvfvcTMvNe8E6GiVUfRMVgGFXbLr0H+UoxuAVZRBB9BflbMioJdXlSpBn
 khGZ4WvwXsG6sdTPMIaqy2UtMGMS3o4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_07,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607190240

On Sun, 19 Jul 2026 10:52:00 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Update device list entries in Kconfig and remove device description from
> file headers. One can rely on the ID table(s) to check for supported
> devices. Adjust comment header accordingly and update Copyright notice in
> comment file headers with the current year.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---

Main comments here are about the patch break up.  I think it needs
just enough modification for a v2 to be needed.

>  drivers/iio/dac/Kconfig      | 31 ++++++++++++++++++++++++-------
>  drivers/iio/dac/ad5686-spi.c |  7 ++-----
>  drivers/iio/dac/ad5686.c     |  4 ++--
>  drivers/iio/dac/ad5696-i2c.c |  6 ++----
>  4 files changed, 30 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index d6d560c09e25..ba2065241af3 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -251,9 +251,18 @@ config AD5686_SPI
>  	depends on SPI
>  	select AD5686
>  	help
> -	  Say yes here to build support for Analog Devices AD5672R, AD5674R,
> -	  AD5676, AD5676R, AD5679R, AD5684, AD5684R, AD5684R, AD5685R, AD5686,
> -	  AD5686R Voltage Output Digital to Analog Converter.

Given this is adding entrees that were in the previous patch, I'd have
preferred to see the more complex dance of a precursor patch before that
which did the reformat (and dropped the stuff form the c files)

That would then be followed the new stuff being added as part of the previous
patch.

Whilst the ends result is the same I think it is worth doing a v2 just
to clean that break down of patches up.

> +	  Say yes here to build support for Analog Devices Voltage Output
> +	  Digital to Analog Converters:
> +	  - Single-channel:
> +	    AD5310R, AD5681R, AD5682R, AD5683R, AD5683R

Eagle eyed Sashiko spotted last entry is a duplicate.

> +	  - Dual-channel:
> +	    AD5313R, AD5687, AD5687R, AD5689, AD5689R
> +	  - Quad-channel:
> +	    AD5317R, AD5684, AD5684R, AD5685R, AD5686, AD5686R
> +	  - 8-channel:
> +	    AD5672R, AD5676, AD5676R
> +	  - 16-channel:
> +	    AD5674, AD5674R, AD5679, AD5679R
>  
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ad5686.
> @@ -263,10 +272,18 @@ config AD5696_I2C
>  	depends on I2C
>  	select AD5686
>  	help
> -	  Say yes here to build support for Analog Devices AD5311R, AD5337,
> -	  AD5338R, AD5671R, AD5673R, AD5675R, AD5677R, AD5691R, AD5692R, AD5693,
> -	  AD5693R, AD5694, AD5694R, AD5695R, AD5696, and AD5696R Digital to
> -	  Analog converters.
> +	  Say yes here to build support for Analog Devices Voltage Output
> +	  Digital to Analog Converters:
> +	  - Single-channel:
> +	    AD5311R, AD5691R, AD5692R, AD5693, AD5693R
> +	  - Dual-channel:
> +	    AD5338R, AD5697R
> +	  - Quad-channel:
> +	    AD5316R, AD5694, AD5694R, AD5695R, AD5696, AD5696R
> +	  - 8-channel:
> +	    AD5671R, AD5675, AD5675R
> +	  - 16-channel:
> +	    AD5673R, AD5677R
>  
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called ad5696.
> diff --git a/drivers/iio/dac/ad5686-spi.c b/drivers/iio/dac/ad5686-spi.c
> index 003541edb742..b4531b49cb22 100644
> --- a/drivers/iio/dac/ad5686-spi.c
> +++ b/drivers/iio/dac/ad5686-spi.c
> @@ -1,11 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * AD5672R, AD5674R, AD5676, AD5676R, AD5679R,
> - * AD5681R, AD5682R, AD5683, AD5683R, AD5684,
> - * AD5684R, AD5685R, AD5686, AD5686R
> - * Digital to analog converters driver
> + * SPI driver for AD5686 and similar Digital to Analog Converters
>   *
> - * Copyright 2018 Analog Devices Inc.
> + * Copyright 2018-2026 Analog Devices Inc.

That definitely belongs in the patch that made a real change, not one
that is just messing with comments.

>   */
>  
>  #include <linux/array_size.h>

