Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC7A3CEBBC
	for <linux-iio@vger.kernel.org>; Thu,  4 Jun 2026 08:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780562607; cv=pass; b=mXJwaheWYs730bFbOjJBCb3lgK/QZcJmCURyzjMAKhnUoXZ2AOO8RLeWsGDosFiqeB6Zunoli70MEbCUunV2IDWI8BHJqftc4b3LhB6GXsHKlVMDoaz6IyeR+Nz616zwwnhKA++lr0gFtd1RzHjdTy9dnsk5LtR9dSrKwRXdKKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780562607; c=relaxed/simple;
	bh=gdmEJCQhVTGXJZ1HH+mNtKdPy6B72DPscwyOzYSF260=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LezofjM/JoBZkGBpYaQ5vr9NMbClNmu/Mhw9fhzyGUQgkOGDdWJIHv+I49gs1CVykjlrlhd3hjcFn34S0P7AYHUJR5H6DIU+wbi6twbMNnLibpBXDcwcfJ0m7NglqicrW01NNbkFSJFnHmIKQieKpycZrUVjKHW0Kc90TjI5Epw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MGmgf6b9; arc=pass smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGmgf6b9"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4903d730b1fso4649795e9.2
        for <linux-iio@vger.kernel.org>; Thu, 04 Jun 2026 01:43:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780562604; cv=none;
        d=google.com; s=arc-20240605;
        b=NCnzKNMj7MmPohIRdCMK59sMduKxRXgW7sWW7EmaSIvNijtbhemG12vcXsL2u2hpJP
         iumpnG/08qFcjE4tQeiPfZ+vNNcrFbAlxmVr6QhGnZSkkMburrN/BmaQiN4hWge1ZX/k
         Vtn2ROhX0BWW+/64yYt4w93HLCM9mTE/3kYQmmGi5zjQhZ6OM7QQMi6DlfFHajSZk5Nu
         79C4heS9kMduLm1U6wtzF89NsODMnJulwLUydVQH7uRbqOZvDKZQBFFlSoknu8Xtsq4R
         6yLP2jWuCO6hl453pubOhI7NVz/59sXeCsoSsfu4/6PBawr0MyMO+20dGjOelL4ESjt2
         TiVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=FFQ0Kl8I73JwK2OZ39TPIZi7qMnbD2vXTMTZhV/JDho=;
        fh=i6lmcGwHFBvltWw0tSJoqZB1iP9otqyGxyNrt+4k3eU=;
        b=lSg6G0yElnb3iYeDzXmoVRNFRlbCu+retZUizTsnzlDgkUQxhkw7jGULwwRLuxLKpW
         kT7bgo7Vergr2ITeyvOPB9/xscX5Nr8CrIQXkeetRirLUhx8fTOvI8MqdgEiG1wCr2hP
         h+bFT97hb00zEQBg/6Q6HA8nY/onM90NKjTlAeKuMtcpSVBe8FqUiK6FPImHeTswtfSq
         x42o8Fmb0hRKKRBigtO82e8+auzsqcHDl3bc55iZGFdvN7cu8mN2fDZ8WLSPbI7zq8jy
         fqRDjrrL+JOX/89WZaSnv88cwHA9YHZN/MG9c3ek6gab2fbBs0PfxUlE/qeN1yxPtY5Y
         J1SA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780562604; x=1781167404; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FFQ0Kl8I73JwK2OZ39TPIZi7qMnbD2vXTMTZhV/JDho=;
        b=MGmgf6b9HpN7D7CrSrnoOjgVssovsFI+zkgMyxWpcW/nriTib+uKwjb0CIqUxyI7Lv
         uyU4QiEmpVAnnGlmuVgk+DYXtGsC6IlI1S/MbElcl6spmlGrIUSqI2GmX29T3Ro+s3Bf
         zkIfRrHHuZnBFDfyjO/FdowCfBK3cKxZ1BIf35N5Fg80BG5nnU6tfj/sB8OcFQONeV/O
         yybL9YqO4uR4oy5W60nDJUp+RNGdmVC9GWevYP03T68BBzAkFNCx56sU57Uy+cRvfpPj
         UvyAlPfcypxsH0Bn4GpOD3hn7cPlcyD+PqVHCH7Rk2/qek5BRZNVZbRxnj3DdKesSjlF
         wAqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780562604; x=1781167404;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FFQ0Kl8I73JwK2OZ39TPIZi7qMnbD2vXTMTZhV/JDho=;
        b=mKVm2XHHB5PJTxq0CuMTJ2dKn+HsYudb0kZLS7y5Qxvq0HxUEHdN24CC2er2fAAOFP
         nnErp27aYeb7JpyqGHGzdGh2WvmhnfPrr2v+39FhIzbGDTjF6Bfqi9HCEroYzi1ST+qZ
         euzN/9rBubhhgzUMU7BLujmAQ76+vjCwebPIoAg3iU/AMYORECi2v3htTiA5cK/s8NtG
         oGworNKRA9Wvrhw+tHUMTFTIuNZKy8hLvJiij6oiGPZ2PplfdetdvvDEH7SzO3eyaF79
         mdUgOTR45v+lkVJhByTCpxqH7vEwnxaa9AjLy1+sJzmyksjqhqNaM/4eaWahipbNhmO2
         0vqg==
X-Forwarded-Encrypted: i=1; AFNElJ9A8Xt6F3oKxyiP5Jz5l9pF7PSRICKCI+YSxzP8c7uLgkgt9hjQNbrvYGfwfNvmHqo7SUeh8Qsc0mE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdjl6hhST249PhLo8JkTR0U+nZRfXkEPzOxZ+io3EjoRbW3ufs
	Ek8KYkCZpgMZylN9YlY2UvK+B2x6lF/IMEVvksSfi46MJwYoh+dLjgVSi/H3dOQeg20UZ/1s0eM
	ZlZq60u/OBBzGAbmmiHxSK51XXkQ4qwI=
X-Gm-Gg: Acq92OGyC5pNVmg37/lKxLirw9WpyijU9tFOQNQepI2G7EHwml/yCFXl10mMID64eSz
	yvUufhkRWm/F1zgzCRk/5AVIv6Vt+HII9/yfVS5FuX7dRmWYb02d5dkifjREaxaY6kQqIx9l+Sj
	FdANerMsrOJbD7NsECCGOIu+SqYIoqBkzK0lHsmm7NqtvqozNGuTWzQBVq3D/+eiSNGV9kVT6VW
	x8Vcv7zNatcPnQuamsKyw1LEbSyztPjX1ZPSZpbTxd/hxPtlQyAE73mB2UmM+pRPVzcR7wb1g4A
	SPd30Q4ZeuSbZSnI5Hdy6F85zxuPk5VKsexduNaA2AreXa4PAXYy5vZ7sbNXDXffkBIyPXCwLt4
	U7TfCT2iNYPAYDTvF96LEo1iMUz79VGEJsCMkaIM7sdmrbyL6uhMrP8+BRTgpUJ1uUfP1m2c2Mw
	T/hC1ohyaV1GPsnkkGlS6rYGdr/jw=
X-Received: by 2002:a05:600c:3f1b:b0:48f:d1b8:9ab1 with SMTP id
 5b1f17b1804b1-490b5e82dccmr116688715e9.9.1780562603790; Thu, 04 Jun 2026
 01:43:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531111605.2411980-1-jic23@kernel.org> <2417EDFF-1ADA-42CC-8D52-C93E90EC4953@gmail.com>
 <20260603145551.3f97ed31@jic23-huawei> <CALoEA-yQrjLyt3vwMKxMy+dj4f43Cj8PfZFtkGPBBP41oz3Myw@mail.gmail.com>
 <20260604093706.1f02eba4@jic23-huawei>
In-Reply-To: <20260604093706.1f02eba4@jic23-huawei>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Thu, 4 Jun 2026 10:43:13 +0200
X-Gm-Features: AVHnY4L1A2IJZ1MpLYsN_70tjWV5VsrvHk0w3HbX_XhUq1bMxV7dsAjoPfWiTDo
Message-ID: <CALoEA-ytCTBP8V5jSJLgCsxwyG_g-w2sh5QtutQqFoYzO7Qq=g@mail.gmail.com>
Subject: Re: [PATCH] iio: buffer: Ensure bounce buffer used for unaligned case
 is zeroed.
To: Jonathan Cameron <jic23@kernel.org>
Cc: Sanjay Chitroda <sanjayembeddedse@gmail.com>, linux-iio@vger.kernel.org, 
	Jinseob Kim <kimjinseob88@gmail.com>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, "Reported-by: Sashiko" <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jun 2026 at 10:37, Jonathan Cameron <jic23@kernel.org> wrote:
> > Sashiko had some remarks about the wrong member being memset, however
> > it seems relatively standard... human 1, Sashiko 0?
> >
> > Does this memset operate on the wrong pointer?
> > When iio_push_to_buffers_with_ts_unaligned() is called for the first time,
> > iio_dev_opaque->bounce_buffer is NULL. devm_krealloc() allocates a new buffer
> > and returns it in bb, but this memset uses the old pointer, which would result
> > in a NULL pointer dereference.
> > Additionally, if scan_bytes increases on subsequent calls, devm_krealloc()
> > might free the old block. This would cause memset to write into freed memory
> > using the new, larger size, resulting in a use-after-free and out-of-bounds
> > write.
> >
>
> doh. It is right - the patch is garbage.  1 to sashiko 0 to idiot developer.
>
> I messed up the line ordering.  Memset should be at least one line later.

Right, I must be losing my marbles as I've completely glanced over this
even after reading Sashiko's comment :( At least my remark had some
sort of purpose.

-- 
Kind regards

CJD
