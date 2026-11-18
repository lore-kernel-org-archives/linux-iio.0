Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794997878;
	b=nTXQaXIOItXVSauxZxhlCRYoXl3nNpHyx3Bxt6y0gcNN0Ny81Ln7rZp5+S0xAFf8Agee
	 ytkL/U2v4QfghzOt6Noerhw0Kf1NFvKYzyaHQmn9VMVIXDR13VDdb2Z0t8At/RPjRXvRe
	 dkEkx0cdXQFuMMXxKp3OkzsO8UfNpW48TNJfVQdF9PhQ4XumCWcaIeSX+8grB4g/TQytz
	 hMMAu3R9v3lMvkHjQD4c2ssM3MgG/KLvnIhG7uwQ+MyYm8gstJmSdQ8Kx6/G5G9afAmSB
	 hWwKuGe/dU5I1Mug+ND8l9omEiVDpkB+azjdLMw/ndq/cMh/xLYxVynBWpeBXt+/ZIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794997878;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=RNaYfzqeD2INqtazwHcQmd57GXTu5xCWhu4vIapt7gM=;
	b=GHduyN+OBqs/tErm8amttLskAcHJtlzUMBgqITcBuR9zSsY6JXXnxOru/OGYWgX92YNU
	 uJXt4Y000OFnH0dmrvXWTqPbXDTD5m0BZdw2DAq1VHmaZK6XmzSgEi6mR2nOx4D1ymN43
	 pS7zv0VeSIvKvj+nVVwC67zZEGFLAppxOWCXavNLCZ9lEwUjIwWOBTwl5d7zc8cccbhev
	 G0xQk7VrqrOQbMeBhKjz9JLEzOWv+mo4Rl1kq9NuzWolTCh82P0A/rQbuzt9u8zUhT0eh
	 ZgpkrM20rq8EWYuNArH6mqb1rl1lhAg0F3wuiGSsWrX4TmYkmhCgOmHJKe2nqRcg7/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=owm1zLg0;
	arc=none smtp.remote-ip=209.85.167.46
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2024F606A320
	for <linux-iio@vger.kernel.org>; Wed, 18 Nov 2026 10:31:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2024F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=owm1zLg0
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5c126f80426so638046e87.1
        for <linux-iio@vger.kernel.org>; Wed, 18 Nov 2026 02:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794997876; x=1795602676; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RNaYfzqeD2INqtazwHcQmd57GXTu5xCWhu4vIapt7gM=;
        b=owm1zLg0VzYFmDdfm336JH/9bvcMfVg5N5R7J3bsi4HiUKpzL+6sCLOkWIwkPYCbMV
         UdAaZ9AVS1itm0VjYjLte2phA1r0VNW0wsggScBPXp2mNVaygoFzxOLr25NmEnebyMJt
         xp+ORVMt+ygOaD2zyIkYCYGqQ+ziH8XY9DswtnW4t9ZRd2jSkvNG407ofM1sHtyTn7al
         22JdLD6YyqYmnc9HY+zwPURAl1GUA2FbyBM8SAMRBr9bVD9yEcWwAQp2z/3yE24ad5+r
         nsSYBfq6iSWuqj5MtOXPNGP4HJqP8RKXhP4f7l/3251v3mr+6rObHBAAT34hCKtf5lDj
         fvUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794997876; x=1795602676;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RNaYfzqeD2INqtazwHcQmd57GXTu5xCWhu4vIapt7gM=;
        b=LfsYgQXq/QCyDgqUKmyKTCkD7UlYyJry0wW5uyZ0CYwSyoCZdbGde6SFMqeFO8LCUB
         NGRZb6CLHSB+MC3KDJDyYlOHlWaOo6a27WAGzVZ6pruj9FkuOjVhaOVgbMD3KLpg0gNT
         DahkS91onW/FrC/IbdFwYh3fjUyWhYqPwNEYO6n7j8tWmXaZbTMKoJh+esOCgJZ3Gfmc
         OfqnQuKxHYGbIA1ItJWjmD1olx9NClCRdNP4M6MKGI61YVxY4LMTwYMWRjzz8tAgayPz
         jQNzXlWMax1IBlXFInA8ZQ8vTUg6+TX1H0TlzsszuAXRATF5khVsOiAFDUyJYcggOqEZ
         hAiA==
X-Forwarded-Encrypted: i=1; AL+hErHAtPU06n834zzRI3p9fPGVy3TmGQJ23jWXhuCRL/Gk8nK1hObc76ogAkIa03RPzlpWM3nO6zTmTbQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9nun+GdqQSAtFzoTya+P5UFoO2/Um157TaCfkUunfW96WRbTzQ
	dnqkNkQhd2P2X70vJKRHA0VNz1l8rS1RawcJ0LtpeEdlRWhp2kjQmTLG
X-Gm-Gg: AYBFou3qt7V4x+XdkT8JR0dVBG3X9vtpwS3jUWPXhUonMv4zMa2S5Oyo5exHTWFeVEy
	2YjC/EgE5h4ccGJ6U2pTD4xEKmiNQmPntuULm73uKbT2zNi7gRBDTOOZeLOfBf3hAEhZ5VZTusj
	WniM+MUdeN2xW9VpdXsaAvP6eXc++XLP0vFt+3yyC62lLSMxJE1dY3cbd3J5sPlJwt4MkIR3QoL
	xM1INnczXZiHZtphLf4kpHG5ak6te+ZeVQkjMro5OoHRava12fqiImNtEyqabu+zi0QJL+/85+6
	ZgXEIzJICqZBpbgqpnWaDszbdJLmKJGfqYDIE97zyAKq/I/s8sJ70Qwz7ENX+PGjNsyFVF0vs7k
	V2Z1PnNqMrl02ojYYpkOJpZVEf0kzllbT4MKDAeojOCkT03urgnLei3Sdz4CGc3a1Ml5QEsMnv3
	+I9UxFwp61UQ5TyDJMtcdNXx60M58umLo8/a8IRp106m+zCoMEAvTYoJYBFgOsjlZ6aMR+tWK2v
	r/PpHznUG1z0ICQYYamXd7ypm7gnEfgMoBo/MyOxU4RGFRmqDceD8vvg2sA86GADr7frjxZP8oS
	BEHjWuvS3QgfUGAqMNrk2NZSpaThOHApK/lmdr/8saUfO+1UKTiSg1dBTKS9V2rVEnbDgNME2BV
	fMG4xXSPt4A==
X-Received: by 2002:a05:6512:31ce:b0:5bf:b999:91ad with SMTP id 2adb3069b0e04-5c1a9c17fa9mr645391e87.20.1794997875982;
        Wed, 18 Nov 2026 02:31:15 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ae67b0cac2sm5223771fa.22.2026.11.18.02.31.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 02:31:15 -0800 (PST)
Message-ID: <c2e9261c-2906-457c-a6c5-8a81d87e3375@gmail.com>
Date: Wed, 18 Nov 2026 12:31:14 +0200
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: light: bh1745: fix 16-bit register accesses
To: Arnav Kapoor <kapoorarnav43@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: Mudit Sharma <muditsharma.info@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261117110327.198084-1-kapoorarnav43@gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20261117110327.198084-1-kapoorarnav43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/11/2026 13:03, Arnav Kapoor wrote:
> The 16-bit colour data and threshold registers are little-endian
> LSB/MSB pairs, but the driver accesses them through regmap_bulk_read()
> and regmap_bulk_write() with an int or u16 buffer and no byte-order
> conversion:
> 
> - bh1745_read_raw() reads 2 bytes into an uninitialised int, so the
>    upper 16 bits returned to user space are stack contents.
> - bh1745_read_thresh() reads 2 bytes straight into *val, which the IIO
>    core leaves uninitialised, with the same result for the event
>    threshold attributes.
> - bh1745_write_thresh() writes the first 2 bytes of an int, which are
>    the upper (zero) bytes on big-endian.
> - bh1745_trigger_handler() pushes the raw register bytes, which are
>    little-endian, in a u16 to a buffer whose scan type is IIO_CPU, so
>    user space gets the samples byte-swapped on big-endian.
> 
> Use an __le16 buffer for all of them and convert with le16_to_cpu() /
> cpu_to_le16().
> 
> Fixes: eab35358aae7 ("iio: light: ROHM BH1745 colour sensor")
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

Thanks a lot for hunting down and fixing this Arnav!

Yours,
     -- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
