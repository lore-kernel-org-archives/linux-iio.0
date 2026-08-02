Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852C03932EA
	for <linux-iio@vger.kernel.org>; Sun,  2 Aug 2026 14:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785682098; cv=none; b=JwFgK9416Gl92XZAWHrqtlSPxSxK/f8Gfh4ECz9hXeLJ8vVPk7eE1tN1MLzsvWeQdu9+GNKIM9RCTjh7gRMOK+0ZDcjf/tb9ZkKoIP5Jiil39WqQK1glIkpjajVBQWhW809mWAglfFhRaYA2XgwDHwgqEoyHjZml7e/63mg+r8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785682098; c=relaxed/simple;
	bh=Kl/kK6ZYTzg68QYqfqbJ3KVkURCxY2rizcrZuYbmm3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dP9VEAf6f7UGcQXmlIIrCvn5BEicihlCf/Shn/Q2Au0mOUFA49Uz5SNnbRVeL2Cus9TGKSVEx1N29WOS9dq9DpCIIHD5pcmXBTWm7+GCX5JJg/9ZTKJOO3V/fnAUnELCO4h+zMUt/J6kgbzAaN2z90CV9Ah/viibQRVx8+1KAnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=VPlc+6E+; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="VPlc+6E+"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-4591f35aff3so348587fac.2
        for <linux-iio@vger.kernel.org>; Sun, 02 Aug 2026 07:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785682094; x=1786286894; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5cS2ofFOue4M8XamUu04ihCfrUZX2sV7BxKpIDM4Wao=;
        b=VPlc+6E+3FsQ/M+lz4t7dSUK1qYhhyOzGsbpDPYqPECP4vXPw08/OBUkoGFwyHn4kE
         kU3RlfG9CRr+8ciVk8Ncaz71MoONNIOf6opXvUWIWejB8g1SqouycyekrxqzXzw7jzlA
         DzXZ8LZN/8kO8XwH1mbv/PBlfbyWRbHtruwxO8Ii49ZbUIg6BwEAzej8VHSxDZX0SNhK
         xnckLWHJMbsUq9k7nQwwMaXMdGOrqpctovb9JPd5BsSb1nqL4Gn1YM40PW1i7NF/jNU7
         5rRyGO5foch4tWbnWbsLgVPFTEs/mFPhsIoN+ZgRwo3LBpV95+Za6iGGk7lfEa2o+pry
         jCmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785682094; x=1786286894;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5cS2ofFOue4M8XamUu04ihCfrUZX2sV7BxKpIDM4Wao=;
        b=d44abYYfODuvWggfIP6iu5TIeCx4ezg9hQRTZ/n/hMUMfJWqDovallMovh8Z94wFpI
         p/U0AHR3WJWDpKJeBh89Xf+eKrx5Xu1wtIe2uTKRRCOyXMl0yVLbBQytucjXEvy/pMlf
         HCTZNGpNPUagpx+w18Br7O6WQXTSzzptTtZavAFydmdsYcOMBE7h2WmWEgrGpL71MZzh
         6zuuRhcN5mUI7cHwqi4ZQsUYNR9Flm/ma1scXYMGLXFoAwXqESRX+iF4AtN3OX58gdzI
         jG18zLa/0r2vMO4G1jHjxb5GzQpqrPb+/elgdeIv8kvUmDi77eBut50BkUOEiHXPrVu2
         SPyQ==
X-Forwarded-Encrypted: i=1; AHgh+RqjGXiLavr4qbn9/m3B/YB0tDsL84NKJLfaCAVAINelS1QhimaZzlAu/aTCXupuHEKtzrl5WUBwBL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVYeuNemPXKWwTHg4gucROPrV++zxH6FOvSzLU8E/XvHJEkB7l
	83MMGmiBtJykHTqYeSoRF62WaSGS7v/E6Kb8z5ytLy5OZ2IxwEeTcgf1JuKiGr/8J9/yr3oH3m8
	ysiP26y8=
X-Gm-Gg: AR+sD122+PTt+oLAsXP/cTQ7g8HjOcsicCXl925sXoqGh6jIBBPHM3Va6kQxC+2tPdP
	ST1Vf91JjJtlHbS9fWT1BnyvgvuQieBbdBP0j/pNNC+IqKnXL9zzJyg30BAnMdr9z7cRntz3tjD
	e4+R6HaQRtceNjvatWcvI5+yv2cDwZoba/oPh5TsQEHUHaO4clpvzl+HCxsAQENZlkzOQLifG48
	r0NHijrzmlKBxq1cgZ2qCb60TZvs/Rr5luyclM+SDV8WKtUb6iEtIFpj0QQyRN1leNFky/USEtY
	7V4eG6HOm4qBPHeBASHcpn8gdFBHgYnTVu4T7IjmOfa+MHnS8yhTqrPI8mkEDN3Ahg5yK9U8vH0
	ddyzg21JqxXgTkfFGRdM8XaGSrmy5t1Oucsfr534/vJ4Tj7I1bpdrbA25O6NU5fu+ZTxmM+/g74
	zf07DtmocaKjOSppwL11TpfO2+opiAvnuA8zIcnq4IJexrkuUhpqlM0FeRKLN06q+bB2jMq7whk
	XZrf8p4YuyJHL54T3vNa5A67669bk/WDtWXGrc=
X-Received: by 2002:a05:6871:c91d:b0:448:768a:49ee with SMTP id 586e51a60fabf-45905dd7d52mr10874364fac.13.1785682094364;
        Sun, 02 Aug 2026 07:48:14 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:5487:2b6e:1057:d3d3? ([2600:8803:e7e4:500:5487:2b6e:1057:d3d3])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-458f6064843sm6446172fac.4.2026.08.02.07.48.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Aug 2026 07:48:13 -0700 (PDT)
Message-ID: <f8670ea5-1e76-4a04-9c5e-e43ffac92be0@baylibre.com>
Date: Sun, 2 Aug 2026 09:48:11 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: humidity: htc100c: Fix checkpatch warn unnecessary
 else
To: Adi Nata <adinata.softwareengineer@gmail.com>, jic23@kernel.org,
 nuno.sa@analog.com, andy@kernel.org, u.kleine-koenig@baylibre.com,
 mazziesaccount@gmail.com, bhelgaas@google.com, o-takashi@sakamocchi.jp,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: linux-kernel-mentees@lists.linux.dev
References: <20260802014417.15485-1-adinata.softwareengineer@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260802014417.15485-1-adinata.softwareengineer@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/1/26 8:44 PM, Adi Nata wrote:
> Checkpatch warning:

Making checkpatch happy is not a good reason for a change on it's own.
It is only there for guidance. It is not a strict rule that has to be
followed.

I think this is a good change because it reduces duplication of the
return statements and eliminates an unreachable break statement. So
write the commit message with that reasoning and don't mention checkpatch.

> 
> WARNING:UNNECESSARY_ELSE: else is not generally useful after a break or return
> +			return IIO_VAL_FRACTIONAL;
> +		} else {
> 
> Signed-off-by: Adi Nata <adinata.softwareengineer@gmail.com>
> ---
>  drivers/iio/humidity/hdc100x.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
> index bc452cc8fbcf..38903239fb9a 100644
> --- a/drivers/iio/humidity/hdc100x.c
> +++ b/drivers/iio/humidity/hdc100x.c
> @@ -229,13 +229,11 @@ static int hdc100x_read_raw(struct iio_dev *indio_dev,
>  		if (chan->type == IIO_TEMP) {
>  			*val = 165000;
>  			*val2 = 65536;
> -			return IIO_VAL_FRACTIONAL;
>  		} else {
>  			*val = 100000;
>  			*val2 = 65536;
> -			return IIO_VAL_FRACTIONAL;
>  		}
> -		break;
> +		return IIO_VAL_FRACTIONAL;
>  	case IIO_CHAN_INFO_OFFSET:
>  		*val = -15887;
>  		*val2 = 515151;

