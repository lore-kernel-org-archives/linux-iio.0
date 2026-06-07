Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A742E736F
	for <linux-iio@vger.kernel.org>; Sun,  7 Jun 2026 17:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780853285; cv=none; b=N+zy9cZZvYKMy5jcNyRYgLDb8X5Jmr10fNMokdj3ogk/Ogqkcqp8nf4IlLpWKWEnqS1E9JlXprHB4gNCBNN0mFyY/RFbuCx0UrMn3PqsKwEejb9fbq9p2WdGUR9Lk3k7FGJNWxWa7zEE3m2m07F0dDDBbXsXBV8ctxkN77bVHeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780853285; c=relaxed/simple;
	bh=ic6hP979jFIIR7VQQF0KZoJHeJIBAqqaK9TWJnCHRMM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NJQjm8h7EZZoPOAGa5VPuoN5wE6rnKsy9/c+vO3hQ0wAvIVBRHV/pikYgb1ty+B0grmJev3pTbfIDPOwbLHk5HaQ97RvthVtrQJ3Za+nUefjozXcFRf+Bz1jEhe683Ewuzif+7fVxd5iJLNGlcyS5Yjo9yrQpMP/AfJsXKAMKXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mv05PcBc; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mv05PcBc"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-45ef6565cfdso1574037f8f.0
        for <linux-iio@vger.kernel.org>; Sun, 07 Jun 2026 10:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780853283; x=1781458083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQ6CUffrQyUVa2bFDEYUSmaOzuwIqiY1ShS08nol4bw=;
        b=mv05PcBcO839OX+cFxQwI7vdS6BzYT022iendhDWeI337R4UQfXVjasIzQBxizUjQ5
         3owgeCi+bxlMvRhImKa3Erzc+zGlw0e15HBFDbaOWXfdusJdQt4DkpznAXbgCBFBJ867
         ZrHnDyJ03Q7Hs4CLJkx9pkqSqYumTJX1BWspZYBGqv8IwPlwF0cY1+pmXPmzqQ3moAis
         lueQD3Tv69f6qPk/Rbu4PJi9V7jj6OvEwip5SwG9htQZfvXJBUkOjiklZaoSRyDIplV2
         1+YMjmwadJbeHe3JjsteBh4473jFUeKR5sw6MXrCwM0GihY/z7sKnGmqc0a1BAonssxW
         HLIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780853283; x=1781458083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HQ6CUffrQyUVa2bFDEYUSmaOzuwIqiY1ShS08nol4bw=;
        b=CgW8Wrh2nDFvsoDH1vRbmWGeA98n/eqvpmMyqfWTyMlb31H88jkIiYtWcGIx5dhCZu
         bXcjqpiPAVzN+vOb6z48eS8m6IAFGFfzfOo+gaHOfcaX6PCQV8GWVnP3CqVcZCM+miOp
         yRYDCO1En9Pph+rAesMee5Td1b9M2lDnQdCyrHHc+XSl4BBVqYqxPyIw14QBLPkS7dGy
         +kLP9UKkDMaRaCWokSNeUa4r8dUBImKIW7bufaGso6X7o4sxGDoBmUYKdeSDc3Psym9M
         MfkwYEwkkqBl0RJSbr9BYHvnis2aVlfl22zGDc3Uue5LW3SpgVeW1L8yVuPg61ZKd1RD
         xMHQ==
X-Forwarded-Encrypted: i=1; AFNElJ/LeAzN6hoRaz1f8p3O3E47uE3RixfunIVzOc0zLKgwBPxuQC/yjVMEfla8nJYsO09uddAwMz7k8zI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTCSFV7z2BMnWAyM+nysbYiuUf7mE+mFXZqovkTDdh05ZIsyPl
	ZJovMcpoVNTyQH0DhFBlvzpQfeCGLgd7stHrcyxy+/nvt9lmr6eJ1E/K3YXb3QPJ
X-Gm-Gg: Acq92OGAroD+oG3Br6ip6jlG3mmu71OIIvLNqOAXLHNUqJgUmo0Hsyq1j3AvGYhV3dS
	WYc3geOszEpkKgcxT9nXMk9xJgaLE+6/AqtTefNP9XIalVrEh3G2NqojXM/b4mCwL1Il5+Y1tqY
	A0/isedM0zpRf/tQbUxUyf9NxH5yFESwq1N6VKQK3c+yRVEeWlMYzp3XIk/ipEWTR9uQbdkIGRn
	khadQHggc8FNt+euB1j2L54/qqQU1NbuB4DY9BV59IKtGxu0iX+WaD8OVQAa+RG81WgipUxYZfp
	UUAxl8va2O8vqd8PgySGLFEYN7USaJ2sku/NO8QcrTAYDxEK7zX0zccLeKyrMrIVAD+oxnO+Hj8
	H9YpCA3VOm7CjBG+7XLNoZ0BIfFRRvZhi4FLlNiLJIdiMsQG7IpHWE7Qy5M57T588kNZhr1gJ5u
	5XrQ3eMTkw4MEncdZ4rfItSLuX4h2rrN5hHSEHPxsgh0qAi+EhvmG5X+UJR27nho1GpHM0XNQ=
X-Received: by 2002:adf:fe01:0:b0:43d:775b:c9bd with SMTP id ffacd0b85a97d-460304fadf5mr14085622f8f.10.1780853282718;
        Sun, 07 Jun 2026 10:28:02 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f344558sm43703184f8f.18.2026.06.07.10.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 10:28:02 -0700 (PDT)
Date: Sun, 7 Jun 2026 18:28:01 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: jagathjog1996@gmail.com, jic23@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: bmi323: use min_t() for watermark limit
Message-ID: <20260607182801.2624d7fc@pumpkin>
In-Reply-To: <20260607132200.56495-1-dennylin0707@gmail.com>
References: <20260607132200.56495-1-dennylin0707@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  7 Jun 2026 13:22:00 +0000
Hungyu Lin <dennylin0707@gmail.com> wrote:

> Use min_t(u32, ...) instead of min() with an explicit cast to
> match the argument types and address a checkpatch.pl warning.
> 
> No functional change intended.

Right - provided when you read the code you find the definition of 'val'
and check that it isn't 64bit.
min_t(u32, x, y) is just min((u32)x, (u32)y) so using it adds another cast.
I really don't see why that was ever a good idea... 

> 
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
> ---
>  drivers/iio/imu/bmi323/bmi323_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/bmi323/bmi323_core.c b/drivers/iio/imu/bmi323/bmi323_core.c
> index f3d499423399..38ad05f9ef58 100644
> --- a/drivers/iio/imu/bmi323/bmi323_core.c
> +++ b/drivers/iio/imu/bmi323/bmi323_core.c
> @@ -1128,7 +1128,7 @@ static int bmi323_set_watermark(struct iio_dev *indio_dev, unsigned int val)
>  {
>  	struct bmi323_data *data = iio_priv(indio_dev);
>  
> -	val = min(val, (u32)BMI323_FIFO_FULL_IN_FRAMES);
> +	val = min_t(u32, val, BMI323_FIFO_FULL_IN_FRAMES);

Ignore checkpatch :-)
Or just remove the original (u32) cast.

I really must rewrite the checkpatch 'stuff' about min_t().

-- David


>  
>  	guard(mutex)(&data->mutex);
>  	data->watermark = val;

