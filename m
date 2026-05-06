Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6779933ADAF
	for <linux-iio@vger.kernel.org>; Wed,  6 May 2026 09:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778059479; cv=pass; b=sXzVLkFRb3Zr1Z0B2CVQ/Y7nwoXCkDGzHL9PEfAeN+O6ceCrCZ8pdwlRReptu9wRvI+Qp6IUP68ce3U7XrXqp/jZtCvJJuZ2D+kIsoGM1hm9gz++qBRZalQnqvmI55yoXa/tgi+e4S7XevQ4fuMqQZ7nfqxsqNjSCpHf4onBtTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778059479; c=relaxed/simple;
	bh=MdGZzg6UQD0PONvSDlWFMET6AGr3louaBFSZD0RVbqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=naMQzSgyMgM7pjGPjo162/tYj2S2Y4twYCNNGzGFI/gNCn3fhx8DmwnAie+H7Gjrn1IidA+HqVl8BKO/EXq0wuKPCJ8pIzF27IvcATPwVlMKRqtmxWtPskpRNmiWYcIkb8SA77haDDzcrQVm1sRz27sVFE7dP4sLWp6YoXEvtWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rbKFsDtX; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rbKFsDtX"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-44ce78ab5feso3192904f8f.0
        for <linux-iio@vger.kernel.org>; Wed, 06 May 2026 02:24:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778059477; cv=none;
        d=google.com; s=arc-20240605;
        b=D6uJkKju0IotGRTeIbpAHl3huu9WmH3KEOLZ4r6qCK+tzNmVk9TzvW42evv6chDWDC
         Jifao3s9d//2dzNFpzVx0hn3AsTKF2jyCrbbS6YRCT9ZlHW1FhSEcs7+NL7wKu0iOjKe
         LJA6dQwdy528B3Cx/kX+ow5oxnOy2cyJw6aW8CJOIc1l6/e+6PVf/pYjNGm/3Cm4qBfV
         w66Ycs+n6S3w1EfnNC33f4Dr/E0MmDRvXd7KXdzY6tcSWyoavbwoBuyWQgjs/DkbdEvG
         N0RuSMVtxbYXOYrrNDDWBfJwuhh3KJXZC4s49eeTd2z1sDBtHGEflhfuMW2YbVeDsjcy
         SbfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=28JLKMJaUdFUgBnmf6Lw07s3AlkKP4y9F0J1HAc6Tl0=;
        fh=Zk+0lNB3mcjKJ2Or9Q2hkKPg7j6JCbqATSq8Pg/PJUM=;
        b=XSTuajIdmD6GILYoTrh37NUW/GI65dy9PfIf2CnOo4ZSvjTJ3bOoMzS65jL7edGZll
         RY0Ugz+qiXonHxdi8Vh9+B03l/6LND5mfDqVjn/tpkX/KjTuWI38qdgoC9F2lXus68gm
         DY/bTJLspfbO3OawiqW+9FaZpbBVe9cQyOuyGVnxh0ySMeAtOLXaf4FUznd2yEFlC7QR
         Kgb0BlSsfCyhor4vf8O+6gDnvWYeszmng821QiMuIWMZSclj0g73G+zby9RwWkbMYNCs
         XZmOrtU5RHcD/lW4tGLvjVAyKSuIOYU7pn+RDBkMxNO75fFOvSqqGnOIz3cJ6R9oqgC0
         dxfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778059477; x=1778664277; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=28JLKMJaUdFUgBnmf6Lw07s3AlkKP4y9F0J1HAc6Tl0=;
        b=rbKFsDtXNmIZK7HG4E0+hQXqd2lUd7C4VMfmLB/l57sdRroPlJ5jLGKvapWGXB+/TT
         uRdm2PPT2i6cdpyOMRfOMgYJbg7YDLQBqCfVaDva/J7RY7Xtfpbm2J1sh9vlV0006J+g
         l32ymll6VGKTJasyPebWUo61O0C64qD4wagriVegTQANOUZQFgZIzaU4HMDEhkO1b0+i
         hzeaoopo7SdWezPeCaKUV3gk76uC9R9/9epZe5pJYiwz5I4gQDLESAqe3Su5EbAoEeO1
         nXzB5Ra+qSzE1+jPalozinca/gpYvBAD4ai7o7DEzw99BLcnvPsQpYlYUPiF4dAhN1Hx
         YHHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778059477; x=1778664277;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=28JLKMJaUdFUgBnmf6Lw07s3AlkKP4y9F0J1HAc6Tl0=;
        b=WQKCDdipZhlJqsNkaeH+lvWGZVQWrGkCv79SJTlcr6s9EzslHNhpD+wL735vGkraf6
         JnW5jK/x0jNwy8TGfGWeVLcsZUtxLQ+8JW0Xd93+nOt9+uhdBpsdTWL0ZgiepE0CajwT
         3RZIP8yZVyKqf+sOf4jtKQi8JfuFJYl1uEPPZVFLApKRQQ2/4uF2/K4hAU6E+Q9LDoEY
         jzoi7yAVxpx7Re5u3ytYXzvGsjVwy24DYFJoLZ8QnDyITV0h54bbQk3PLFwR1e7y6zDz
         w17W60ecwH+09UWRvDPjkhxoc1bJh+/QtDE1B6MJJ8k84t9H/FXTD7Dn2DEjaLE9i2Nf
         dSJw==
X-Forwarded-Encrypted: i=1; AFNElJ/iNgDUYRi7QnN/M2nxXStlJMupTPL7kKm6wwfT9FQutv5+foZsvqST4aG4eaTg1Lzd8qYZ8wmDe4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB5Pn25160vRPlm5ia9n2yH9O4zNCW1c/uPpO0Ret8YuWEYf56
	glu2eMGNRZqHfGEEfUnclMFHWyOqv95z6uymTmxipiHqFCAQ8DunTmXqEJdo2Bdl6x0B6eGb+eu
	h7lqnWdJkLIRDoKUj1tQKWh4osAW9B6Q=
X-Gm-Gg: AeBDieuqrpBdX6lxuDXJggbYG9pH95YeRUJE2UCR2F1ZJvb1SKmJR7HISymX3QCu0fQ
	10yelCPZLD9/91eWz0wKuC7mbdjOZlxBxTInMH2CKiw4encqVY535I925uvv5I6GVsCNTJ3seKa
	SSZtRblUTShz7ZpM0+ZA7tSwKJ7O02C4Ux1O6AIkAD4ehCiwwsLOFA7lnV6azZPtDvSlsMNIz7o
	tYkx7cRApiKpqv8PN8XcuLbG//T82C1/pK6xR6qWGXBmAz+qbH4ls8dy5H7PJOi4I1cN8nCaI/X
	RpEgKFigqDpYZNVi5/7+sh2r0RCzrvaJtQRlCuBikuMDyL1fs3PEy6AtDXgPF42N3Juna0mYCJa
	cOrr8CpJuG9y1w7TNSHrro5Nc2IisiAS9zQW12x9NH2F1KpL9AGIArtsemdnLkfy7JhX3TKQxbs
	u4yZp1YF99R0KCRO+Q
X-Received: by 2002:adf:e742:0:b0:452:d67:5020 with SMTP id
 ffacd0b85a97d-4520d67555emr1141594f8f.1.1778059476316; Wed, 06 May 2026
 02:24:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505174640.3998281-1-sanjayembedded@gmail.com> <20260505174640.3998281-4-sanjayembedded@gmail.com>
In-Reply-To: <20260505174640.3998281-4-sanjayembedded@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Wed, 6 May 2026 11:24:25 +0200
X-Gm-Features: AVHnY4K4KmPZ3pLt61rE1-SDip3E7FceiFc2mVDT18H_HIAIUt9KsVLwDV6jO44
Message-ID: <CALoEA-yUHJb=coHuPYjrVhP_Vmvvi7qKxkXJqTp3qXRQ_wuG8g@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] iio: accel: mma8452: cleanup codestyle warning
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, sakari.ailus@linux.intel.com, 
	christoph.muellner@theobroma-systems.com, martink@posteo.de, 
	mfuzzey@parkeon.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 May 2026 at 19:48, Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:
>
> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
>
> Reported by checkpatch:
> FILE: drivers/iio/accel/mma8452.c
>
> CHECK: Alignment should match open parenthesis
>
> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> ---
>  drivers/iio/accel/mma8452.c | 47 +++++++++++++++++++------------------
>  1 file changed, 24 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 279a9b364886..916631519d3f 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -706,8 +706,8 @@ static int mma8452_set_hp_filter_frequency(struct mma8452_data *data,
>  }
>
>  static int __mma8452_write_raw(struct iio_dev *indio_dev,
> -                            struct iio_chan_spec const *chan,
> -                            int val, int val2, long mask)
> +                              struct iio_chan_spec const *chan,
> +                              int val, int val2, long mask)

This is still not aligned by 1 character, it should be aligned with the first
character after the opening parenthesis.

>  {
>         struct mma8452_data *data = iio_priv(indio_dev);
>         int i, j, ret;
> @@ -788,8 +788,9 @@ static int mma8452_write_raw(struct iio_dev *indio_dev,
>  }
>
>  static int mma8452_get_event_regs(struct mma8452_data *data,
> -               const struct iio_chan_spec *chan, enum iio_event_direction dir,
> -               const struct mma8452_event_regs **ev_reg)
> +                                 const struct iio_chan_spec *chan,
> +                                 enum iio_event_direction dir,
> +                                 const struct mma8452_event_regs **ev_reg)

Same here.

>  {
>         if (!chan)
>                 return -EINVAL;
> @@ -818,11 +819,11 @@ static int mma8452_get_event_regs(struct mma8452_data *data,
>  }
>
>  static int mma8452_read_event_value(struct iio_dev *indio_dev,
> -                              const struct iio_chan_spec *chan,
> -                              enum iio_event_type type,
> -                              enum iio_event_direction dir,
> -                              enum iio_event_info info,
> -                              int *val, int *val2)
> +                                   const struct iio_chan_spec *chan,
> +                                   enum iio_event_type type,
> +                                   enum iio_event_direction dir,
> +                                   enum iio_event_info info,
> +                                   int *val, int *val2)

Same here.

>  {
>         struct mma8452_data *data = iio_priv(indio_dev);
>         int ret, us, power_mode;
> @@ -881,11 +882,11 @@ static int mma8452_read_event_value(struct iio_dev *indio_dev,
>  }
>
>  static int mma8452_write_event_value(struct iio_dev *indio_dev,
> -                               const struct iio_chan_spec *chan,
> -                               enum iio_event_type type,
> -                               enum iio_event_direction dir,
> -                               enum iio_event_info info,
> -                               int val, int val2)
> +                                    const struct iio_chan_spec *chan,
> +                                    enum iio_event_type type,
> +                                    enum iio_event_direction dir,
> +                                    enum iio_event_info info,
> +                                    int val, int val2)

Same here.

The rest is correct though.

-- 
Kind regards

CJD
