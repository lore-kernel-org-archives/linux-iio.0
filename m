Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7033E2757
	for <linux-iio@vger.kernel.org>; Sat, 16 May 2026 15:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778945886; cv=none; b=nugWxhES6lv32dQHmuExw0e2uRIiF/HkbPL5gc4FW3gzXDZT9/SBdU6E1DQmfgXrl7nAzluNCbkYUY3w6aSmNK5F9hRYl00To+vbEyMi4A86j8sfOxufuxt6s36s8k7AbJzr9qleQg1GTUGaIxVqfuvO//cMeOOD6TKOrZt1dts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778945886; c=relaxed/simple;
	bh=/75PCE3sU4ZNcHGvR8zG5bXzbL2Lu8dYaiJn+oAx7u4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nluZjMHws5lJegm41p5zrk1jDYEb2PbmF3qUhHKaZ1F27rCUEl17/GfnzBlwnAFVV/etKGr+cnFVKsdpnkkKVOHPvpsaLs1liOGt8avmUpAZ0oEyEIWR8BF6seX4z0K5q8qZDSM4VekUx2Qd8A1nhdhlxW4rkbYHceUZ8tcHJZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=K13K4uM1; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="K13K4uM1"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-69b692871e0so284753eaf.0
        for <linux-iio@vger.kernel.org>; Sat, 16 May 2026 08:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778945884; x=1779550684; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dG6BOi9eKWLoGvRvvTy/2CJLijhAKB9xvisswsHOsMg=;
        b=K13K4uM1o0j51hwxARFj46h2H5Dl3t5bP2yyW0rk+S2Kk5DUAgaRoxcyK0mXq0iEIw
         H9nBA1Ugn/YowmfqEQhHY76wbe6drUvza/20xbdpXcM4s0JCYmlPidPLUjsQRveHc0r3
         Nyi6jBmp47E6fIqDisaTSyL+wiVNtil7sZ2/W7d5hlXwGn2TgnzBpkZCWP5qBL8vGLLA
         dcYiyYZPvx7NcOPl0laFrvwdI8T548IWn30yb+S4JwkJ78GQxRdQ8vYKxtFBvwuDp4VZ
         lCiwKmQZJyk1YvotxrChS/RXecICkGB5+SOqpGkM5CxATDVqmQre2ZeVIepTd4HhPn8p
         iJ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778945884; x=1779550684;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dG6BOi9eKWLoGvRvvTy/2CJLijhAKB9xvisswsHOsMg=;
        b=LwINXWBsxrdZ523i1jEwTVf5096fzCxXHaTprDrXdA+zyepa620v1VFu0XYCHQ5WNd
         Cp8rj9/j0Eodw+BrkVVtaUFBarmYz/CrD6cvy0jiodDa9qVK4wNvO9pz9reC4g2ccTqo
         2uDPMZX4Au0g4LMWYS/oS7COiAw4j3DXKcHzd5tFkcAZHGJlh2Nd4gkVVtgqQ9jPbqjR
         NhgTtCtTNYyKEKtnjj0uWnHQHIur4uIQ/SiQc85HJMRfCMbQXFuv3psnrAjS5QbHEW3w
         FnNf8MFRyz4ZlJF4jVsABnQ0Uvm6hkY6zY2drSGRgjzarPn8ZPVUdojWfJ1GSdPenCQH
         97JA==
X-Forwarded-Encrypted: i=1; AFNElJ8W4rGhsscVffCT7BcPp8sJ534s0cxsGaX1xKe/pXEFQWvebphJ0/kMack52xr0/rmlAekQYlrNwaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvNFvfUKzkaoEiBd7t98iyjYBTHLd6FWTxizLhwK/PVUMJXty7
	FtQxsB/O/nDPZ2yfrrItItuJdxOMycZN6l9tf69g2qMnWsAv14KSrbSrPWJKkHxiHw8=
X-Gm-Gg: Acq92OE0QFy+dW/A8Ca4ovHVSgndEwgP8eQyZQ8v+NqKjdAVgcOJW8JzIw3LWJFtk2Y
	/B2kpFMJ6PaKhW9w7nsLEI/KuTfY/1wbpCoexlBbsO2+rDXhluV53hk4m9/UgVesqKDZhnKwNOO
	YFp4jrHAKckFZhCOKF+by+nJqyYSExRy6mVFrLfkdy3Jz6eZGoWwr7pG/G/5uzn4KySk/UPM2qn
	lp67caB4XbjKad3Z1S2qYkLT0tvsIZXWSM/wYs45AYV9shhvVkDYZC6mnbyCS9OGdv1L4E2ShEN
	tcG0HLdydqYTEl+PW/qS0RSjm0FgqAosTMDdhNUeKHERvFK+MoYxDvmrzmQ6ZgARW+1Z79sli65
	gi+IJmGZ0C7S8GUhTO9oM0nKBsqk7CkEy0tp299aoFo41961hSV0bqFbkF/OuOsUr+5JmEPf1tQ
	TNfC93bExLd/KeajJnYQYJKXCo5xG22TZT9QrQ6hiQAawQssS6SjC4s4NVYxvjPlGjyRu3tB3v+
	IX2uRgrFL3J
X-Received: by 2002:a05:6820:1795:b0:696:17a6:c06b with SMTP id 006d021491bc7-69c77a88e61mr4282706eaf.17.1778945883897;
        Sat, 16 May 2026 08:38:03 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b36d:bd18:7c02:29e2? ([2600:8803:e7e4:500:b36d:bd18:7c02:29e2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69d049384f6sm2758905eaf.14.2026.05.16.08.38.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2026 08:38:02 -0700 (PDT)
Message-ID: <827b665d-7341-4ec8-b00e-11d5a7f9cf07@baylibre.com>
Date: Sat, 16 May 2026 10:38:02 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: proximity: vl53l0x: notify trigger and clear IRQ
 on error paths
To: Stepan Ionichev <sozdayvek@gmail.com>, jic23@kernel.org
Cc: songqiang1304521@gmail.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260514143711.23648-1-sozdayvek@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260514143711.23648-1-sozdayvek@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/14/26 9:37 AM, Stepan Ionichev wrote:
> vl53l0x_trigger_handler() returns directly on the I2C read failure
> paths without calling iio_trigger_notify_done() or vl53l0x_clear_irq().
> 
> A single transient i2c_smbus_read_i2c_block_data() failure (negative
> errno or a short read) therefore leaves two pieces of state behind:
> 
>   - iio_trigger_notify_done() never decrements the trigger's use_count,
>     so iio_trigger_poll_nested() silently drops further dispatches
>     (see industrialio-trigger.c, the !atomic_read(&trig->use_count)
>     guard);
>   - vl53l0x_clear_irq() never writes SYSTEM_INTERRUPT_CLEAR, so the
>     chip keeps the DRDY interrupt asserted.
> 
> The sensor's buffer mode stays wedged from then on, recoverable only
> by re-binding the driver. The sibling driver vl53l1x-i2c.c handles
> exactly the same case correctly by jumping to a "notify_and_clear_irq"
> label that always calls both helpers; mirror that here.
> 
> The bogus negative-int return value cast to irqreturn_t also goes
> away as a side effect.
> 
> Fixes: 762186c6e7b1 ("iio: proximity: vl53l0x-i2c: Added continuous mode support")
> Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
> ---
> v2:
> - Drop the cited error-path code from the commit body; the diff
>   already shows it (per Andy)
> 
>  drivers/iio/proximity/vl53l0x-i2c.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
> index ad3e46d47..7acb94acc 100644
> --- a/drivers/iio/proximity/vl53l0x-i2c.c
> +++ b/drivers/iio/proximity/vl53l0x-i2c.c
> @@ -87,15 +87,14 @@ static irqreturn_t vl53l0x_trigger_handler(int irq, void *priv)
>  	ret = i2c_smbus_read_i2c_block_data(data->client,
>  					VL_REG_RESULT_RANGE_STATUS,
>  					sizeof(buffer), buffer);
> -	if (ret < 0)
> -		return ret;
> -	else if (ret != 12)
> -		return -EREMOTEIO;
> +	if (ret < 0 || ret != 12)

This can just be ret != 12.

> +		goto done;
>  
>  	scan.chan = get_unaligned_be16(&buffer[10]);
>  	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
>  				    iio_get_time_ns(indio_dev));
>  
> +done:
>  	iio_trigger_notify_done(indio_dev->trig);
>  	vl53l0x_clear_irq(data);
>  

