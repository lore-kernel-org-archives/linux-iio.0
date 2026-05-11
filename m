Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A6F3D3318
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 16:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778515522; cv=none; b=fsZhj8xsiN6UO0l6EgjzeYXRJKegTa/Q2qMVuqaWsWeIbMwcOr183Y8v5MHOouRbuB0ZpGRPnXX60fS+eV0vj1CTGejAOxFrvFqwFL09emZAto+6JyqMou3WO91dU5sKrBM2FC03WPeke/g8etKtIE66bfi7MfTrqM8XUQyaD98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778515522; c=relaxed/simple;
	bh=uNxTZHy6hBKRG2nwBuXWKk+HJWsmPsaMDZjnsyp9Hws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R40XFtUqp4YAwq9Rz+WcpdkLygDkwij4AEOhjU4DL9pJD6wltEBlbSCbfIDrpOb6R37kVfpdIXw6j57u+LJRrfysrBzlKmlgBWXZ8pPiMN1sOC/1LtIQab86uEvGqSdVzKQV+fp0zd/IWwdGETWw26QbgBnjjZQ/VLleLKnCGtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=ADzugxLR; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="ADzugxLR"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-479ef2b78f3so3820229b6e.2
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 09:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778515518; x=1779120318; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hpvyj6Jcfot6MCDnve5ReW22UI34QHDg5W5s/ynN2wU=;
        b=ADzugxLRRLmVxHPwrm6M2xDKuy12rm0KK7VMw5nEFKaawHjiin8j+EAZ/+37YPjNJJ
         RAyvsFAzFYjl6iNs3tRMXg+Ov8maowUVqyqvI0kPppu20nU4WQCkZ15nTb89ey5JyBYY
         7+LPgzDByYmvb+doL8vNRD0z7FH3nWKvFH1IA+XZT7qalVksum+BFGTrkcjw2jtiYCgQ
         tp+GyPw92XPESiLNN0NtSUSz9Rs+A6ESE5MwiXwiZiuHhyZ9cXKV+wx5GXjApo6f48dJ
         TcXFXuXSUdTHgqEOa33qmQXfWHz20SL/vaVdR2OZUUt8XY43ycZqg47YfEsNdrYrKRu9
         jpeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778515518; x=1779120318;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hpvyj6Jcfot6MCDnve5ReW22UI34QHDg5W5s/ynN2wU=;
        b=ESXCNdZ3PsNHcd22ZeCd6TblBCiG0Y/o9Wtwfk3e+7FvssB9lBMA105hOgNC8HyWRc
         PRmqjkOsmQMYJXFvmXp8268lX75B6XSjw2HWayHS9a7kfiuUJL27f3y3gwU7GgDZKf2t
         /vpND1mw6XtsLwHMTnm/dg1uCoFtToSMlNwq8O25z+aszf06fdpXk22acnTQrQkLVt+H
         OLJMd1vHMwD+rc9ZwYusuY6xuKdEST8/stcUNlTcoa7iLtjLDOJpOZF4kv4WkaUVm7e8
         Xn6amm6I0KTILtlkOBQ5pVFC4HUwXTgnVdlaSyFA5GYRtuzJHrPHsJzBrzWySw/GaKLD
         +GUQ==
X-Forwarded-Encrypted: i=1; AFNElJ/j15RO882su3wTyOQEODf2vg/hkQYNjQtaWZkv0mOElZncBAl85Rh1H2rkd3wmWx/bBWJOw/HhUjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwesPi3vgw40100ACUw3P+mw7qoANjaPs0VljOhvy9NEn53bXzr
	qAhBGDAdCAtqXRO0OGVoRbwBVTuW5CJiY3jnzdWWbOE16wrNc0rTA+G4EDfQ1a0a6oPtIzaisAC
	whcMR
X-Gm-Gg: Acq92OH36ztq+gdfvrtw6D1KuFNziQEf9fT+ltlUVn7zDYjvHJwufRKqeJl49SX8Prh
	U+LNkCEXBvY4n6t0YAGnsuT8u3ZEkg+udbc6GSFkuyT+js0w2SNMGxOU+fdOJZ0SvsJB4eDzY6V
	i0K1NoLgM4wh0vP4MtgZ94r9Nm92DH14ZTDHLueK4uZ/ZxfYKRFpgJtY4vnsQJafVujh6N8BdB+
	SDsWAlZwn+z/z2b3gIVt989h8eYSE3k+ZfOeYzIIFmqK3VE5zUWSBbTYnOdc+xCR6L6xjUROioh
	oVwlOuWswaERlh8DacOuTY07vtnVPxhHrmr6SaUf/P3PnCZq2RkiDrLSL0J+cbRBu3GOBLLdXrw
	TIozZMnOKNfJ5WqwK6eVan6tOrfGeo1+SakfkJJ3oBRlBPr5kS7BlFsvZnAFGolZCqeH5UbVeWY
	krj87qePou8BIxE3NLroaL7KrplyR6j8DiFKUSFLTBFU+gnY7zy5zZDAv1Nf7Ipqoh0873wrA=
X-Received: by 2002:a05:6808:1b23:b0:479:d605:64ab with SMTP id 5614622812f47-4807f92a250mr7995938b6e.0.1778515518378;
        Mon, 11 May 2026 09:05:18 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:591:4577:3439:3a1e? ([2600:8803:e7e4:500:591:4577:3439:3a1e])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c76936271sm20420540b6e.9.2026.05.11.09.05.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 09:05:17 -0700 (PDT)
Message-ID: <36fc2a82-004a-470e-b625-b1795d3f4fe3@baylibre.com>
Date: Mon, 11 May 2026 11:05:16 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: ad7766: Update to use
 iio_push_to_buffers_with_ts()
To: Ethan Tidmore <ethantidmore06@gmail.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260510221404.22834-1-ethantidmore06@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260510221404.22834-1-ethantidmore06@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/10/26 5:14 PM, Ethan Tidmore wrote:
> The old ABI function iio_push_to_buffers_with_timestamp() is no longer
> preferred due to it being inherently unsafe.
> 
> Update to the current standard iio_push_to_buffers_with_ts().
> 
> Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
> ---
> I asked a while back regarding possible things that would suffice for a
> GSoC proposal, that has came and went, but I remember Jonathan
> mentioning wanting this to be done. If this is correct, would a series
> be preferred next time?

When I look at these, I always look at how the buffer is being defined
and used elsewhere to see if there are any bugs or room for improvement.

In this case, we could consider changing:

	unsigned char data[ALIGN(3, sizeof(s64)) + sizeof(s64)]	__aligned(IIO_DMA_MINALIGN);

to something a bit easier to understand.

The most direct replacement would be:

	IIO_DECLARE_DMA_BUFFER_WITH_TS(u8, data, 4);

In addition to improving readability, there are two more improvements
in this change that need to be called out. I used u8 because that is
shorter than unsigned char, but it is the same type.

And the 3 in the original implementation is actually wrong. The SPI
transfer is doing:

	/* First byte always 0 */
	ad7766->xfer.rx_buf = &ad7766->data[1];
	ad7766->xfer.len = 3;

So it skipping the first element of the array and writing to the next
3 elements, so we actually need to declare 4 elements in the array.

Other than those 2 changes, the macro expands to the original code.

In cases like this where there is only one channel (or cases where there
are multiple channels, but we always read all channels), we prefer a struct
instead to make it easier to see the layout.

This case is a bit odd since there isn't a 24-bit data type but it works
to use a struct anyway. So we could also write the buffer declaration as:

	struct {
		/* 24-bit big-endian value stored in 32-bits */
		u8 data[4]:
		aligned_s64 ts;
	} __aligned(IIO_DMA_MINALIGN);


> 
>  drivers/iio/adc/ad7766.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7766.c b/drivers/iio/adc/ad7766.c
> index 9e4a66477d2d..4f256ce522c2 100644
> --- a/drivers/iio/adc/ad7766.c
> +++ b/drivers/iio/adc/ad7766.c
> @@ -74,8 +74,8 @@ static irqreturn_t ad7766_trigger_handler(int irq, void *p)
>  	if (ret < 0)
>  		goto done;
>  
> -	iio_push_to_buffers_with_timestamp(indio_dev, ad7766->data,
> -		pf->timestamp);
> +	iio_push_to_buffers_with_ts(indio_dev, ad7766->data, sizeof(ad7766->data),
> +				    pf->timestamp);
>  done:
>  	iio_trigger_notify_done(indio_dev->trig);
>  


