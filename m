Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A493B7B98
	for <linux-iio@vger.kernel.org>; Tue,  1 Sep 2026 02:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788229610; cv=none; b=gA+9HEexb3w8QmlIxkmcV+Dse3rCrFdalQ1KJCp5RZsPz5KEZuD6KreBx0Ml6B5TW6yjCnp9OflcqHHQRxEX6WjUJ9sSNRUVBtfo3ZzTyZ20B1agDzj7IJcWM81NLkzayNAXn2aBZrfc+e9uhymT7lCxb3rEDfe0+u+Pcu58sXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788229610; c=relaxed/simple;
	bh=1ivU+b0VUEHSpmznsrcD2siFu4zCj1n7MJ79jTDXJQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NTwcDxJZ4C1O3CZhnMBL0jcsdcdsbgD0EnZs4CCYG12IZRMr6G0tLt5Nk82lQ9yDddAS+HmxvybyRG4fdVRxmDOQR37xe+J0wqJ0EHcQ75wN48Vfz3+aRgHUwRKrhtKTjMkGHmg8yaokh6qml5lI+TUd2zmsTu5G69RnpnHlckY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q9RlQtVH; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9RlQtVH"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-855de2d0d4dso8506737b3.0
        for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 19:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788229608; x=1788834408; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jDt+CxLSf4w3iJAIBpJcXGUG31tyCk7fy3CEY8EdRVs=;
        b=Q9RlQtVHp5uxy5UiwvwkX/lENyhAiUiKmAP+55IA6lvoguQaBJamzC1Wm+0fatIdXN
         8/RKdSSrAvdlxfOh5f9lgqtnbf90UEsEeqzjwsZaUMTUD8hGXW2WDOZLAffm7TV3UClR
         0WikKPLraBpwlLqFFDazf4bhIknTU1xCuBjKl5u3lF53i2W2LXBtQ74OHw4dS747E1i5
         ZCcw6lOdXF2FfsFz60LSLtVg4ij466oF78w9DmVBoTa2BtJcjPi2fzw8KbsAfp2jc906
         bJCMHcbG6l5S/KcV6SJWIJbqY2Kh6rkK73EbLYmCcz+HNAcuxNUdwEiRYbtPzCBl4nNj
         4QbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788229608; x=1788834408;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jDt+CxLSf4w3iJAIBpJcXGUG31tyCk7fy3CEY8EdRVs=;
        b=SZUBIfhuhz32NuxerB0NwTeE5afYbuC14BQyAKquk0h3XA3HD2wbSc13Ul4f4Vlm21
         7u8ubkrA6Xne6MltyCxOB+5XZJEvc+3CR9kSf+WgoUXIvcHEIiJhmczfna00FYQi8Te0
         Fl3osGyrrkcppJhYI84jBkGKT3u0pkE4BcdunUx+4ve7OfusVjzM6snS4Kre4M+JRpvE
         F+cT7/pRpgy/wyxu/ROrjinBnQk5ZYLYUTKYOO5ePqmhKSVEItneYESiI5uQhZYMHWcq
         hm8gqyTLxbpXcwhw7nOatebASy1oE+jqNVnRWkVX6wikgxilYOdhBsH0D4cp2sSVghyb
         AmMQ==
X-Forwarded-Encrypted: i=1; AKwUvBz8lTFmcoADknBaWtzzyTLexC3RMn/Polfm4LuAwYSqt2tiwIBMlXM/qenbHy7cUJvWAIeU+rIETL8=@vger.kernel.org
X-Gm-Message-State: AFuF++nLPGfIushyVRTVw/nvqYQdarrg/wxceEYmT+3Ii1WXpoXpgbQE
	3NFoyS5dhu5snStgIa5/NP6VoAc2WI8XqZA4PYSb9Ru1I/AHPzrN/GBc
X-Gm-Gg: AYBFou0YkWcFT7cHB6kDeOYfxdBD6NAJ7UB4gkFqhp0Ph1cDKtAckRLmTtK2bp61uqd
	Ce64pW756gkwRSKyrImvohTFmFMglK3QFRutyKZVaRAHnmQSCNcEd8BoqQzm0IHELjTiRNJoXqZ
	qdi6o1Ty+e0b4RDVTUGP2HEnQ3b+H4pDzKVYJAaoAmEyK5rahS/bZC5iRiIz0zuvV54kM1sTi+O
	0QN/zUUWCDbFN8Cnan/mz9hZalhkkKzVycUg3gEeuzejZeUuWj6tWds4IRiD/58oOiw5BFW5j0n
	MIkAihebC+5YTSS3Ss/Jwv4IywtJC5U/9lKj8UpxyOI9ieZkXkZ0ixJRsUClhhzFYDUGlHivFUe
	wcypPC3Oe7pTSi3xBilQo/8JcM0nreeotnKTJubxHmxhacHAwj33g7HXAh5fXIFDWM59sLyh1vY
	V16oPPBRdBviOOuQrXL++YhzAWLYolIvRSHZ5rJvHPaHgQiRYJj00z7VkSJi5ccAsWwcTACrzd2
	YUF58M=
X-Received: by 2002:a05:690c:a65a:b0:834:fadf:603c with SMTP id 00721157ae682-86948ae2315mr9271507b3.2.1788229608300;
        Mon, 31 Aug 2026 19:26:48 -0700 (PDT)
Received: from localhost ([2804:30c:94d:7300:da0f:c2c1:1aa6:43da])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85e66abc938sm64653947b3.37.2026.08.31.19.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 19:26:46 -0700 (PDT)
Date: Mon, 31 Aug 2026 23:27:37 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: mdshahid03@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] iio: adc: bcm_iproc_adc: fix include dependencies
Message-ID: <apY4GY-0_XMSfE9B@debian-BULLSEYE-live-builder-AMD64>
References: <20260830170919.470974-1-mdshahid03@gmail.com>
 <20260830170919.470974-3-mdshahid03@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260830170919.470974-3-mdshahid03@gmail.com>

On 08/30, mdshahid03@gmail.com wrote:
> From: Mohammad Shahid <mdshahid03@gmail.com>
> 
> Add the headers required directly by the driver for completion and
> mutex APIs.
> 
> Remove the unused `linux/io.h` header now that register access is
> handled through regmap APIs.
> 
> Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
> ---
>  drivers/iio/adc/bcm_iproc_adc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
> index e46e3761993a..2b59819c4ca4 100644
> --- a/drivers/iio/adc/bcm_iproc_adc.c
> +++ b/drivers/iio/adc/bcm_iproc_adc.c
> @@ -4,11 +4,12 @@
>   */
>  
>  #include <linux/clk.h>
> +#include <linux/completion.h>
>  #include <linux/delay.h>
>  #include <linux/interrupt.h>
> -#include <linux/io.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>

I think that's okay. Though, if you go for a v3, you may also add 
#include <linux/bits.h>
#include <linux/types.h>
#include <linux/array_size.h>
#include <linux/device-id/of.h>
#include <linux/iio/types.h>
which mostly completes the list of includes iwyu tool reports to be missing.

With best regards,
Marcelo
