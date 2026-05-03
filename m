Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83B930E0CC
	for <linux-iio@vger.kernel.org>; Sun,  3 May 2026 09:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777800220; cv=pass; b=RmZ2E2guOUji509+8y2XvBqF+Dzvvgt4WQUG07G+qryLsBxsmMeIkYL7P2LnrJWMbtPHkMZqGo5GkjVIAoTYG8bXT6n5B5dUyXLiI7WAQK+UnYoVhg2XrMTMeY/MkmEu1eBn4vgsDLDYAOh2LZEQf2IRBtQbpn/YVSRHLP3ARG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777800220; c=relaxed/simple;
	bh=ZW7gj7nsnEOHslU2wqaJOLTWVWiuNeY561RzxoLPWrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qzdjZ3GvmXZ5Unr7sj8dqQ834rzv9CIdnFiGX36s0jXKUrrooJc4wrWL06OiEiXS+nVFyJKTsKrv7IKms2On+4nHUwP5KxLVjOV2kr+Iid4FN43Y3gM+fj0mtskN04R4bIKFKPsyaptpO1l3SNFX0XvcjPFlTe+GD/FikuhJArM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kg6kArWW; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kg6kArWW"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-44c4cc7c1cfso527775f8f.0
        for <linux-iio@vger.kernel.org>; Sun, 03 May 2026 02:23:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777800217; cv=none;
        d=google.com; s=arc-20240605;
        b=gH9bYgRTzlO2nxT3ZUQCOUwgXYDhuJdSpmpJJFFOC4ap8A6v8Fzh+gKrTx24BsVJyc
         KPEMsp6BpmCtgoQIvkoZsAywuNMC4IkWTiMVuMO3Jm+y5Y7JR5B9CQlk1WJn1j5IWBi7
         uBB/7LepFMybb3702u8k8bOtN+rNp+jLMMoCFgDA66fK1+wiQixPvF60H0qwQJ1b2aJC
         oG+wLN52T75JB4V3H1ctwZX0DTBsqlP9YUXh3+DanTwM3s500gp1rLah1mCMlgZaK0cR
         T+6DbMOfLZ6clGcHmaug50WNb5wz//rBpnC4uqbnk/lQr6iEVHDt+iztxhuDiH19ZUUb
         RvJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=dG6+6rd5qFYh3TIAeefmjwN7hAQV9nR/lJhSwbq8nlA=;
        fh=+vJUYx9sibSJLXlOvP5CZ6kUacP8R9xecezbF0IkDTA=;
        b=Hh3gxQ7A3rQWWlVmEuZV5xeVuqY5Mc/d9GYJ7B2bdl2N70OGVsphex436l2hqo4BLx
         ZF9jCAfp9fQGdkyRmV2vfC4QAMze+Hp3rHbZnCWwVZdso36KIGCOxyHMdpGfjDaIkrti
         q9wdmezkhiM8DTxu/8jL7lCeRLNwcXW3eXRwKZCKa/eGnvqNm1+LeX4LcmRN4JLxN0yC
         bsY5Ms0fVCXei75x5DZMf4pM2CTQB3mk4dN2XqLFqyO3kOWrbTKyRjYPu9IQMpCrWbBe
         wCQ9KLQIoljdBM8gOhhho+VDL+AucDvJ55FZZCkYWPqm1NaItD2ev+qygmhD905hmbzZ
         AXOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777800217; x=1778405017; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dG6+6rd5qFYh3TIAeefmjwN7hAQV9nR/lJhSwbq8nlA=;
        b=kg6kArWWQADDir2bLdHxq9pUp14kNVtvUPR97G0u/148Gd5N/CO0jeQ6Mv7Z8xuSPx
         hNWASGlZ+0mFvQ95hflCX2hUn+uzPz9DNYAh+kjuHgaGdwkeey/AifFBMSO/Nu0YO7RH
         Daj35DDbozPukJwR78Ao4KJY8SC1S8y2w1iZBO31RAOFwvT9wi5GeGxAz3oQwE86WZy4
         lkMWneaoVYgItRi8996gPbIE7h/EXTMVAMhpTKf1UB+tupK5dnugsuTA8GaD1HiUaPjc
         s/wDc8WD4VOO5uEGWjkYhexzj2uWIizJSLYiLzk341IyQPf5+q6rjGn81tvdkOriwHRG
         eyhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777800217; x=1778405017;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dG6+6rd5qFYh3TIAeefmjwN7hAQV9nR/lJhSwbq8nlA=;
        b=BM1JOv4ntb7zPKQoEP3jJZ/u03FADvuejsIpwt+Woc+guJGPEkV6VfAXgOYaHgqQaa
         o4P+P434lvzJi+2gVpIMnVDvCbNEkwSos4I4Pzx7Wo/Sleb9soKf8+hYTrEcgo7yamFt
         4eCHOBHlS1vCmTe+fztI2pWxKLfvhsApN1rg5RSkF96MbC6zlFnZCau75koYo+iacYn8
         woAo9bCWadBiPSNtMtgmJZK0P4F+oIb6O3k5z2VUHYqEdL7HpSXRAJQ8IoHqM7kLY2qf
         VYgFniM/cDZ5rW/QBJfQlHbLMiwPgpxu5GQmpzhcbPU32fOJsv+0YiXM1TVnzFp0GUSw
         zDCQ==
X-Forwarded-Encrypted: i=1; AFNElJ+ws6sAUSmi9jj332RJmmKxMqOwEN5QYpLlPzqct8CzCHKjFhmjTk/cNPCml4l7sk75xSR62VpY5cs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjuI2dy9I3H3R/W1xFC7rdqJKicLx3l6ib7BPw7WC2py2c1e2B
	uJ6lTZcjKudZoPungdwKna9tU3ft81Y6mkJZ6cNrFteoAHFZOjr0BbBhqeZzwEQ2vFL+mIcZPsN
	wL8i336hraUF6bS1/17jsU25NaWpufbY=
X-Gm-Gg: AeBDiesJwWh5Opo24wIl5klXgoCx/xUXBefy222ywabUhuwmoOeOg7wAElc2fyx9Qim
	lSNCsyBPEfi2VUt+KzURXlXnKZwBSkDSUlwnjZS8VIeYCHEGq1R9zbSyK3VNc8i4bEGjwkxFdIK
	ySkDIZl81hLwMq7ui8Gh7+cBo2ZpAsNBkbXEMzFpWafjXNlXgEWSrAaDB5ios6C0DmcG68+jddK
	PBurVttscaoM0M2KsOcTrqilpJGzIQIopz4Z08XK3ijERRLDI8Xbin+he3JerBnYyqxFpaInKgG
	2feEQP/sbaoosCXVvrn3nZ/Jzt3dcVKK0w1htP+eM5t7OnlfvtGph2ieKZXH0CdynUTf/P96QEc
	HDRwERGKubhFYYheRb4Hbc1IbBaajphqCO0xqXAfNweazo9mYB9Yo1T/4wyGoWG+wlAQOvdJY+B
	qf6lAqQ846wegfKRncVVJWmMOMEdmF2ZSNmYUaEFNjuE0AkzhL
X-Received: by 2002:a05:6000:3109:b0:43b:4f86:e985 with SMTP id
 ffacd0b85a97d-44bb5c4269fmr9330024f8f.33.1777800217315; Sun, 03 May 2026
 02:23:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260502234348.131563-1-gabrielblo@ime.usp.br> <20260502234348.131563-2-gabrielblo@ime.usp.br>
In-Reply-To: <20260502234348.131563-2-gabrielblo@ime.usp.br>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sun, 3 May 2026 11:23:25 +0200
X-Gm-Features: AVHnY4IzLwebGutgf9DiBeWwyrHEGFwz04VXk6HIk1FgAKFhbRjNpP8cZt35WDM
Message-ID: <CALoEA-z7jwCkPaapNp+y71NE2zgx-kdMSM_p9Cje4AhW+rhLsg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] iio: light: veml6030: Remove 'x' wildcard usages
 in file
To: Gabriel Braga Lagrotaria <gabrielblo@ime.usp.br>
Cc: andy@kernel.org, dlechner@baylibre.com, javier.carrasco.cruz@gmail.com, 
	jic23@kernel.org, nuno.sa@analog.com, ricardo.kojo@ime.usp.br, 
	elliancarlos@gmail.com, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 3 May 2026 at 01:44, Gabriel Braga Lagrotaria
<gabrielblo@ime.usp.br> wrote:
>
> Remove use of 'x' wildcard at struct veml603x_chip, as it is not
> particularly future-proof. Instead, use name veml6030_chip_desc.
>
> Signed-off-by: Gabriel Braga Lagrotaria <gabrielblo@ime.usp.br>
> Co-developed-by: Ricardo H H Kojo <ricardo.kojo@ime.usp.br>
> Signed-off-by: Ricardo H H Kojo <ricardo.kojo@ime.usp.br>
> Co-developed-by: Ellian Carlos <elliancarlos@gmail.com>
> Signed-off-by: Ellian Carlos <elliancarlos@gmail.com>
> ---
>  drivers/iio/light/veml6030.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
> index 6bcacae3863c..3d11e4736330 100644
> --- a/drivers/iio/light/veml6030.c
> +++ b/drivers/iio/light/veml6030.c
> @@ -82,7 +82,7 @@ struct veml6030_rf {
>         struct regmap_field *gain;
>  };
>
> -struct veml603x_chip {
> +struct veml6030_chip_desc {
>         const char *name;
>         const struct iio_chan_spec *channels;
>         const int num_channels;
> @@ -108,7 +108,7 @@ struct veml6030_data {
>         struct i2c_client *client;
>         struct regmap *regmap;
>         struct veml6030_rf rf;
> -       const struct veml603x_chip *chip;
> +       const struct veml6030_chip_desc *chip;
>         struct iio_gts gts;
>
>  };
> @@ -1167,7 +1167,7 @@ static int veml6030_runtime_resume(struct device *dev)
>  static DEFINE_RUNTIME_DEV_PM_OPS(veml6030_pm_ops, veml6030_runtime_suspend,
>                                  veml6030_runtime_resume, NULL);
>
> -static const struct veml603x_chip veml6030_chip = {
> +static const struct veml6030_chip_desc veml6030_chip = {
>         .name = "veml6030",
>         .channels = veml6030_channels,
>         .num_channels = ARRAY_SIZE(veml6030_channels),
> @@ -1178,7 +1178,7 @@ static const struct veml603x_chip veml6030_chip = {
>         .set_info = veml6030_set_info,
>  };
>
> -static const struct veml603x_chip veml6035_chip = {
> +static const struct veml6030_chip_desc veml6035_chip = {
>         .name = "veml6035",
>         .channels = veml6030_channels,
>         .num_channels = ARRAY_SIZE(veml6030_channels),
> @@ -1189,7 +1189,7 @@ static const struct veml603x_chip veml6035_chip = {
>         .set_info = veml6030_set_info,
>  };
>
> -static const struct veml603x_chip veml7700_chip = {
> +static const struct veml6030_chip_desc veml7700_chip = {
>         .name = "veml7700",
>         .channels = veml7700_channels,
>         .num_channels = ARRAY_SIZE(veml7700_channels),
> --
> 2.54.0
>
>

LGTM.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards

CJD
