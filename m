Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8747E37C0F9
	for <linux-iio@vger.kernel.org>; Wed,  3 Jun 2026 09:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780478012; cv=pass; b=n4HSEU1mGFKyGkqh0jDuDEOIRu7C6WyFO4D/INTvBJJJiqmvIgUp4WfFBYW3qvbUf+CoKsmSBDcReCTLeU2IyRhI3QDe/7w0oS9ooiZZVUD+95Jd3PNVLGP2SZKKy2qmXW/7JZG+dA1Z3YxZPjtkO2/kYVPF6B66DktSkSWWrRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780478012; c=relaxed/simple;
	bh=IbYUgc+Z5RfVyiB1zaY52a59shitcbpmklnqcweRM5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mhPQH91o4YZ6BSAasbD7P/xMfVtXL0CqhBzww7JoYsLdKumuNXiiluC1bJ6u/LMhTJevBzNto/TdC3of6mnd0J0QmmgOYISVRaOK2yZutxocs+W8YT10lc8Wqelxrak+MCnEzuDTxWXevw+xTUHQFxauUzta9qhm+so6r0Hm+1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sPLcGIRJ; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sPLcGIRJ"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-45ef41adbc1so3532894f8f.0
        for <linux-iio@vger.kernel.org>; Wed, 03 Jun 2026 02:13:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780478010; cv=none;
        d=google.com; s=arc-20240605;
        b=gon5kiq1bqVStsTY9b/2gLuP9gCfemH2leV6/ydIugJkUKx4X+gYfSWQXaqAEF58Xd
         iY/K39efAMQ6Na2lEccrn1gchR/9QsJp0jzJ4it6Qb3aFBQQBfGkQ49RbnTazPy+ZAjR
         C0ZT1g4dHcKoSja1CoCuzB/Sjxlq2N+7IcGLxTAdKpkEwEvlfq4x0WSGtab4rXHfPbWq
         oR6K77Y3qbYEESGE9qsVKKwA0xSXG3N+Cb51gD8RJnXbn+VsIYY6kqxz1Q/bSNymXVi/
         cHNhei4ItEBAKcBu9ItpkVEbL2tuaqL6l1yBHyggIRRw0zHrP3TWDhhpDZM4GEJ7LGJ5
         N6SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=J/IB4F8wtmp6htqLg8CaoDs0oxjd0u4Dbg5g8165e2M=;
        fh=hk19psVuQsClVvLAU2qJ8Joe9G+OXfkTH1ViSn7clZM=;
        b=kcob4MEEwKe5v9E1uZHn+q8/quL6kGpyQU+rMO+FsIgLwVMBPmUp/4LQ1ElEfDkaKU
         XA06LTmaczY0sda4XkSvWOor6RShLtRrl+KHcnGFhs8GxrecbDMi0f5TnizS0YgMEsvH
         0O6xz93VOgHO/fstZiXRljeHm4Ca9AscWBc9QYVgUm0LUICbGwLrmP+JK33wLulh1iOI
         Zsr+67hlblJcb6I/5N+7j77YzNl9xM/aCpmoYWlTJzajnEHfGAsP+wlOhDT1NMShIQaw
         cm+7OxJcQWTd6k8SLa9dkWiy6i9qP7QH9T8ri5OtW8GvmBOIojwYtTqHUZvOlAbuW64r
         jeLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780478010; x=1781082810; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J/IB4F8wtmp6htqLg8CaoDs0oxjd0u4Dbg5g8165e2M=;
        b=sPLcGIRJK5wHB5+dkyIJGCkyV/9B1NhhMpSQ0Io9HpcVlbwn+lBAZE60yQtpOVE8GF
         p4HM7CGOOgIPiEpkKGpN/6NDstH9ZmIvWjxtNil+bdExuuMHg+gFJ+VjUK3ugRhgzFFW
         CQL+9py6hBaKmhTkWn7dupBEC9i+jezi2OEoCwfFrSUPvyacFehIUUmHFOBvqFGzxMVl
         tLaa9ayY3MrKoASLnFM0uWk3y6R0PYHz8Ii/k74Yhe6SzWv2HQlLK1euopwShmtmU9P6
         PuPvOD+sSQby/eQH7RS+fJmRatmV3Qm9mhwZN+82YS3zvR+8rfPZnrcn4Rc8b4/e1Xf/
         niaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780478010; x=1781082810;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J/IB4F8wtmp6htqLg8CaoDs0oxjd0u4Dbg5g8165e2M=;
        b=dKWys5FwLcc6PInv61cwfgAYIBUD+wT+B93i2qykJKeAXwvbu0w3AeaBHtYww5g4+e
         evjnXWzSjgA1SEyFHrNe+usHeqQgkhTzLc3itgei/FhaWGAQSxeXM5CRarLmgsqTCvSG
         lF9HXUd/m7FZrEDGUgJEtJzU1en4XTYQClZWek5brTjh+g4ij/ykZDVu9l8LF1x+y94b
         NeB+kcHORe4w382iiRQ3jVwKTpSSbjpbI4PXfUgvihavzkOI6cA4IMowdGE3ipol9lNf
         3uaMUs1RksKU4wmsaC5LkrszK4xE8FHD9x7LGtYt/KSmhA+PVmNTLjJkZaIh4MzF7OEk
         jRew==
X-Forwarded-Encrypted: i=1; AFNElJ8jVuwz1L0bkEl7D9Bu1olHBHermP1UsKmNDfnH1ObgaKVi6GGE3QqIZSSfcvp3FYBHfp3NSycb8ho=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/Pft5q598MQ89eW3pxQnXBGtA3WI9IUGOQ0KjtvEAqTrrwPzz
	vOd2//dN3C9waS1memhBSDDcPOM/t3dfp94uwIWmJIbhpcoWUm1U+FY/aKrnkN6QXKtSEcTAVj4
	H07fRDST2bAT04/deB/95KqeiM+WYxKe5efuP
X-Gm-Gg: Acq92OHeEZzJcYUwgneBkVLhCfp6BgcwMrCOU4jGYBiJUpQlgqJzlcwg6oGJWshIdPX
	0nZ0gRnX028Wwl8f2c8XOvZ50b+SZuSJltA1WACtTfGtFduqNPIaGnfEF15BM1UXqAa3Lp9BWS8
	R5c65XQMbndF8ZZSj0OELHG2WSV5XTBP8CQ1LxXVCtrSI1RVfkS/66lJPu1buV98qlPTalrnUx7
	0mYeZRaiCYXQEVH0Z93MS+099Wc+FpsnLALTKxgkSXtolGk1fT6XRCE43BhQ4YzO/vaRgoojVqI
	AqOR3K8pKToozHsX6rQw9vDMZhWXof2igsp6Ug/mJROPBhJLS+zn8zTUGrnOLpF8xtNZdZV6SHZ
	MghjnihLyNyrJC7V225RPrqoni26OXwDBekIkUv7XjPqJhilOvyNpGZIwNoM139s0IbFCqeqd0j
	vBda3frCOOqOUI3s5x
X-Received: by 2002:a05:6000:43c5:20b0:45e:eec6:5023 with SMTP id
 ffacd0b85a97d-4602197e8f0mr2424451f8f.37.1780478009800; Wed, 03 Jun 2026
 02:13:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603123333.5608-1-tahanarimani3443@gmail.com>
In-Reply-To: <20260603123333.5608-1-tahanarimani3443@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Wed, 3 Jun 2026 11:13:17 +0200
X-Gm-Features: AVHnY4JWFwCvcrQtv_7Lobpb98peeHbSW84YciMGGf4bVoc08SZfJqhxO7KDQF8
Message-ID: <CALoEA-zvki0Gvzug6bueyf6p5011_rP94uEijrUKaJTGneo_cA@mail.gmail.com>
Subject: Re: [PATCH v2] staging: iio: adc: ad7816: Use devm_gpiod_get_optional()
 for busy GPIO
To: Taha Narimani <tahanarimani3443@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com, 
	gregkh@linuxfoundation.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jun 2026 at 11:07, Taha Narimani <tahanarimani3443@gmail.com> wrote:
> ---
> +       chip->busy_pin = devm_gpiod_get_optional(&spi_dev->dev, "busy",
> +                                                GPIOD_IN);
> +       if (IS_ERR(chip->busy_pin)) {
> +               ret = PTR_ERR(chip->busy_pin);
> +               dev_err(&spi_dev->dev, "Failed to request busy GPIO: %d\n",
> +                       ret);

Looking at this, you could eventually move all of the dev_err() calls in the
probe() function to use dev_err_probe(). (For another patch though).

-- 
Kind regards

CJD
