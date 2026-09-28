Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCF8485934
	for <linux-iio@vger.kernel.org>; Mon, 28 Sep 2026 09:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790586312; cv=none; b=sLwyPlLPJ4wkHonv0G49POlcNvV1Iaiu3MpFE77M0Gz8MLjqkFFhxNMYZI3fewxpy/zG6DPJzungVRsUWhMFh2FbKweALtQKO1FPsTLW7w7lMAW2Mx+vKyMeMJftKHN8/HqFdQV7s2cyaOsYUwIqD7NXSHJ9YOgh3U+j1DSYGS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790586312; c=relaxed/simple;
	bh=Dodyo73tHzWX6mITu1AXopUHn/pAmQk68ifxgr5KOns=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hVJ970BP//cXygiGMCscjENlfDNaK4kDEFwgWZPDwuSLEctcY5HkNrQDmdQ5dyyjlC5dl/qy48OouZLBTesFVBQN6CykI00K8hoL5PrvpJbc5fwGKv9I5ssiqoggHQJ/3Kburd6UbNqFhVzNeT8X6CnCEXbodPClsi+DIMJ2iAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nIHmSbtn; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIHmSbtn"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49ff9642c57so5725155e9.0
        for <linux-iio@vger.kernel.org>; Mon, 28 Sep 2026 02:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790586308; x=1791191108; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lOLH8R3k3uRQ7vYYCf3t/tbfkb4DGWyK1/C7dSgp7AQ=;
        b=nIHmSbtnhxniwr6W+zhGYiyXiNweG9LpGM2fAb84diJ8frf/46wwtsnf+njZfkujMS
         zEf7EFmFkWp509IHqMvUAxziMyHl0dL/pw+Zbk1d+ZrXpjqwiomTYHXS/Ow5dlhqVZt9
         JvPzzri/7+ouyBOAHw401L0sUlNiP1fhaVRKR2DGKx9i6mcDXYTmvwg5CL3XEK1ILnMs
         upsKF2QL9spDOnF0FBNcHVdrPbqq6qbMCFJbl9koI65+inwDOxNXKFojGJkeixeFkXfh
         PxYQzdBmiIBmyvpKiI6szl7DuRn8vu2lViNYkE6GUPV9OZnWxIBeSwO2VBmUrJA+3Hc4
         Cojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790586308; x=1791191108;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lOLH8R3k3uRQ7vYYCf3t/tbfkb4DGWyK1/C7dSgp7AQ=;
        b=LG25CBPy/QVl0idR+2UQh0lnhK+xsVcO2ofpkoQXMSt3VUoRKkGmhC6rfnX+3nGfps
         dctitFXHPA/r2dNoOOCtqOO66q7ZBv4AuVrUhXCvrI3pZ9HmkBsxW01pEaauvoqVe/jX
         HXK4xQiQBpGFh73jDihoN93lfQ4V1upNLmevDHUz5thiEC//plTW4y5d4PkyOq2rLYYt
         XxFCsrV7GZaob5XvXYHH/9B1JGQZBp9LuYuRsVnApXL6dAbEVLeYjKSWRAclizvo4qfP
         xDdEg/hnH952WLAkNYk8o9hJXlgqkzf7eHSN3mRCxcbl0ySQY8bWxdHcFML8X0iJXXfZ
         gfPg==
X-Forwarded-Encrypted: i=1; AKwUvBzgWuRVSNB1fxJUxcNbw3Ad4kJb41IH9fuzoV16FVggSCy7GW9Kp7UtrDBrzd2YCEhJqjl7ME4lGOE=@vger.kernel.org
X-Gm-Message-State: AFuF++nVF3Z8p3EiKWbVBXhxgCiI9MUfXp7zMEB6EAMhxstwGEwdJxIz
	+zWvNc0igvm+tsEofKD0NjMLEgCTKm+q1YxYFv4R1mIE+rDwH+gwgTW4
X-Gm-Gg: AYBFou3RfSBK5sDMqnyqs1KNWifDiutWEhP7LIRHYFwIwN8hWPxE5lIEA1LAVN7cSzb
	BVOPEtvHG3b1qYMottMKDaXdDdWun1StIiQYajVRDKfrvbsoD8tf4RoX5HsAoGOJLauZsKHMehD
	iLrIBrPIqjkfgXz7tKI3Y7JNFjBr8PGbboXCXu88MjziMBuxV3C1uqFwNbUNjPKNDV2WfUncgG1
	GAoVXp/9jwfqEIVLimBzgn3ZyHUrP71GGjSdmkC2J4Gwc19+egZ6Pd5OJOKgiazUBeLEeMQiaEw
	SbUI2INSn4ErWU8zD3h8dNrrt7Ilm25R1h1WDUM4eVNpcazmtPCpRJDLFwxfK4iohNST3vwMo0i
	0dkrfrp/4z3FHaN1MNfPWR7Dx8hvgCpqFfyhi5XFghvh40rL+U0RYYkkjWyr/5mYHiAHkFXV09W
	jHpTYEPIsw1ei4W6kcFjABxxAVBQZruAvDyhxnHi+w3s+ZHOjdapi+EagGkYoto0Rp2yMOplM/q
	3G8IhA4Rq+fCvEe7pVYkpXR1juWAfoNn5U=
X-Received: by 2002:a05:600c:8b82:b0:49f:fefc:7d01 with SMTP id 5b1f17b1804b1-49ffefc7e4dmr89811365e9.15.1790586307457;
        Mon, 28 Sep 2026 02:05:07 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a001906c5esm125927285e9.12.2026.09.28.02.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 02:05:07 -0700 (PDT)
Date: Mon, 28 Sep 2026 10:05:06 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Ivan A. Melnikov" <iv@altlinux.org>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Francesco Lavra <flavra@baylibre.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: tools: Use proper macro to detect _Float16 support
Message-ID: <20260928100506.7ba18d8b@pumpkin>
In-Reply-To: <20260918161305.1161852-1-iv@altlinux.org>
References: <20260918161305.1161852-1-iv@altlinux.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Sep 2026 20:13:02 +0400
"Ivan A. Melnikov" <iv@altlinux.org> wrote:

> __FLT16_MAX__ is an internal compiler macro. GCC defines it if
> _Float16 is supported by the target in general, but the support
> may depend on the exact target options. For example, on i586
> without -msse2 I get the following error from GCC15:
> 
>   iio_generic_buffer.c: In function 'print2byte':
>   iio_generic_buffer.c:141:17: error: invalid conversion from type '_Float16' without option '-msse2'
>     141 |                 printf("%05f ", ((float)converter.f + info->offset) * info->scale);
>         |                 ^~~~~~
> 
> To fix that, use the public macro without double underscores.

Assuming float and _Float16 are both IEEE 754 you can directly convert them.
If I've typed it correctly:
	union {
		uint32_t u;
		float f;
	} converter;
	converter.u = (input & 0x8000) << 16 | (input & 0x7fff) << 13;
	printf(... converter.f * 0x1p112 ...)

That handles denormalised values (near zero) but not infinity and NaN.

David

> 
> Fixes: cdd445d4b2a9 ("iio: tools: Add support for floating-point types in buffer scan elements")
> Signed-off-by: Ivan A. Melnikov <iv@altlinux.org>
> ---
>  tools/iio/iio_generic_buffer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
> index 000193612aad..9ea93984e0e9 100644
> --- a/tools/iio/iio_generic_buffer.c
> +++ b/tools/iio/iio_generic_buffer.c
> @@ -131,7 +131,7 @@ static void print2byte(uint16_t input, struct iio_channel_info *info)
>  		printf("%05f ", ((float)input + info->offset) * info->scale);
>  		break;
>  	case 'f': {
> -#if defined(__FLT16_MAX__)
> +#if defined(FLT16_MAX)
>  		union {
>  			uint16_t u;
>  			_Float16 f;

