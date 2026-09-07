Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE044EA394
	for <linux-iio@vger.kernel.org>; Mon,  7 Sep 2026 15:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788793828; cv=none; b=HRHiKJuGtqqjO4USLPKl0E3+ohaw44ndChYaBiwIit5fpt8N/4lLSTA49tHid3Ldb+imOyWUpoSq0/yWS/hCH2GcQx9Y0u0wp9Yk7dm7cMqNzBekChO0xqgMuq/Cyk4EQXqk0Kh1WJSvMePuFDq67lgBgHttXTAK15T7CczmCjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788793828; c=relaxed/simple;
	bh=9oy5qButklff8GfbM0z4UX0XLV0AKreE357ixiVYz+g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n3WBD0Co3USzefpCo4HSEN+Oc7AQ4Uvz7CR6bHoIU8C2ywodmS6S6fB6XI5g3vl8V3equFat0nSN1XWP1iO5KUkPeEG/B80lYlRIJrfY1uyOj4+4zxOy4P4Q2z2NJh/8RjT4dvDUg9B6fg4JRIKtB6ZGqZ2OJQ3IaUv7lJbIX1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qSEl4jDi; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qSEl4jDi"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47fe89fb333so2352562f8f.3
        for <linux-iio@vger.kernel.org>; Mon, 07 Sep 2026 08:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788793825; x=1789398625; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jMzNA5pqITvRuO+ddPK9SULMMrrO+6pkpf8K1+l6RNg=;
        b=qSEl4jDiK/u0HPAvp6tWHHHl8bZKP4M/Tt4AGAAqjjy9xs03mHyY9PugHq4E/HkT/t
         l1O3xY5u2i0cvbm+WybdwgySnZDI1pdXULVToavF4s7j5FmtTVrnfCuGmVCjixZXLgdi
         1CnMCquH47FC8EK3ltzIZdBRpaDVjbBYZ3MniSTWR4ngErUKzMw28J1SzlIcYa1C/2Ev
         svsJAuk4LDrHbt0W81Jy0cQm0nREWEhnRus42R/KLI8KBJPiR0Yeo5W3dAvrIOJr0zFV
         8i+mHjKTHiNY+vq+iFYaP1GSUuoAh8YoBi3FAK4/g6VF1+awvc/fKrLf1rlrBmkpO5T3
         j+4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788793825; x=1789398625;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jMzNA5pqITvRuO+ddPK9SULMMrrO+6pkpf8K1+l6RNg=;
        b=T+PuotQuWC9qlAEd4B+np+oMPZAWtLeHcF8r4fn7yk1Aw77DsXa9sScT+w8OJ8sADm
         xzyR/Rc8VVcHGClMZsKSd8h39sX6t9zibj0WF9kaJsOKpAeb/tHzLY9qxD+QGNJz81pT
         cerABrPK+C3tDWbP8tpXi7haWYris3dXAdKceYaGKZCYbXw1pRYj4VBr0WQvWeOFd3ER
         Vwaj6x8P7bZywjTqeUjuiPdaKhJfwHM6T1DwKMXXPNy5OWUfGcgM2k6SjMcWhp1s/4ny
         GxdAT92RvFkdZE3RXcWUgBjQmQ9XKV4UuqtPZ5pdinS223DGeMW25icx/rwyo1QxkyND
         gcWA==
X-Forwarded-Encrypted: i=1; AKwUvByZI7H0dE50yJr4xRUrfloeyFzasuiwCtlzCse85C/kMZ6ctlVTsmnoOzb0RbgqiauFu7c95ixxLfg=@vger.kernel.org
X-Gm-Message-State: AFuF++mBD7/ly8YPOUKoQ51sjt+G7gu9Gw1Bog0rI5blDP0+cu7Aww6J
	iC8tfAY8gFU5qp++dQJjhC36vrGct87altvCQJAtePq+BE8j9ttQmP8F
X-Gm-Gg: AYBFou0WBZdSIry/2mfkcNCuNQut4+9rtUIG4LcPZDtHWTYC+pztfBMGFRO6pZ7SJRN
	jQ+puf1HGFFyESufqOBKuLaNHzjrKJ6ER18JNcrP0RF1CSmnotIS0yL/bqx5Sqn5hg+9gPJtAZ/
	yaCc2m3SLm6wPH9YhZs3IkvMHfLkSV3ZTfDNqeg9wo6C4R1D4Ktd0i20Zx0tOr2u54gkI3GXqBv
	xo6BcRDGU70NC5AAo8d4yDKO2M4VUKTiFMrBIHs2XNFJO7w2ohwWlfJ0aAPnfzA9Kbw3TcNfTlc
	kDjslmItuN+SHRjkvn/ZusHDERLtdqgtdhXqaRPtDn/CG1IMpnp9+03vciVqQub/mxmLwgxN2R2
	6D5HMX9Z6fUDM15twxihWUuxm3CSdTCpQ7LOPjU3x2KBSUrRIj2f01H0b00bVB+REq/B3TduWFf
	vBFwuVlCn0Kmrgj++wUlfZpLtVVPDkyY6KuQ+U3nWsESqOyTxWg9l7UWemvLUAbEgg9BX+2M/M5
	URBBviDp7pQrKGwxB3FBLnKpJ0CfX0lOxa21cgIvANUTeskIsWGaN+yNGORmpxuJZ82irtlxm0G
	cDeQ7WEBPxaSZ7hKuaWmZEvqB6itPpcUvu34S290HhmR8lIWk4GZNfa4w2WJPNI4fnzKastqqsz
	1keLl0UJWjEA9+8q8GwzTzURQUyTljYwWdbf/o9f8O46m4GlVm7xwlpE0+2Rzvr98sgtUfQ==
X-Received: by 2002:a05:6000:2dc4:b0:485:8a47:5b8d with SMTP id ffacd0b85a97d-4858ddea668mr18452129f8f.42.1788793824528;
        Mon, 07 Sep 2026 08:10:24 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48591eb3d3bsm17177278f8f.0.2026.09.07.08.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 08:10:24 -0700 (PDT)
Date: Mon, 7 Sep 2026 17:10:22 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Esben Haabendal <esben@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Martin Kepplinger
 <martink@posteo.de>, Sean Nyekjaer <sean@geanix.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Martin Kepplinger
 <martin.kepplinger@theobroma-systems.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 9/9] iio: accel: mma8452: Support interrupt sharing
Message-ID: <20260907171022.00007100@gmail.com>
In-Reply-To: <20260907-mma8452-open-drain-v8-9-c17407e22118@geanix.com>
References: <20260907-mma8452-open-drain-v8-0-c17407e22118@geanix.com>
	<20260907-mma8452-open-drain-v8-9-c17407e22118@geanix.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 07 Sep 2026 16:51:04 +0200
Esben Haabendal <esben@geanix.com> wrote:

> Adding support for sharing interrupt line with other device requires the
> interrupt handler to handle runtime PM suspension properly, ignoring the
> irq if the device is suspended (maybe even off). And while at it, we use
> the PM reference to ensure we do not get suspended while processing an irq.
> 
> In order to prevent the chip from raising irq while suspended (that is when
> using fixed regulator, where suspend just means setting the device in
> STANDBY mode), we disable all interrupt sources by clearing CTRL_REG4, and
> then restores the value again when resuming.
> 
> With that in place, it is safe to add the IRQF_SHARED flag.
> 
> Keep in mind that the device by default is using push-pull for the irq pin,
> which might require additional hardware design to allow interrupt sharing.
> 
> Signed-off-by: Esben Haabendal <esben@geanix.com>
> ---

...

> @@ -1784,29 +1796,62 @@ static void mma8452_remove(struct i2c_client *client)
>  #ifdef CONFIG_PM
>  static int mma8452_runtime_suspend(struct device *dev)
>  {
> -	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
>  	struct mma8452_data *data = iio_priv(indio_dev);
>  	int ret;
>  
> -	scoped_guard(mutex, &data->lock)
> -		ret = mma8452_standby(data);
> +	guard(mutex)(&data->lock);
> +

Hmm, this patch might benefit from breaking it into multiple patches
(the change from scoped_guard to guard, the local pointers etc. along
the fact that these aren't mentioned in the commit message), but
that's up to Jonathan.


-- 
Kind regards,
Joshua Crofts
