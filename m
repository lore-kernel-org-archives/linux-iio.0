Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094B8226CF6
	for <linux-iio@vger.kernel.org>; Thu, 22 Jan 2026 17:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769103753; cv=pass; b=lNEfFo7PfEjqYp9GNsBYFp+YnC3q4soPYdWcH3B5Smwq7onm5MrR6X2BkZMunj6eoxgnyM2rSGhOxbBw7Tmj2KiMXQGCBeMDGma1vBMfoN1Kjm0H3l6j3R89IExT4a+ZJ0jUYbD8l3G3ys6NF3zExRiUPisWHYjsBtwJncHt/kM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769103753; c=relaxed/simple;
	bh=K1wLIlcv8Ra2S+TsSwtv2vqWQEsY+l9yW+y8Q525qxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MOAwBUbFQ9J/3bUyKsY3B+Hh6djhsb3XOZWL0mCDSHoavo72eDbDea84izY+rLSGBokAjtl5nxlyUDZUALu+QCQ+MkVv0gfmSjCfllRkWg13FRZ1ellmMcrPxfKcjIuggLs26CpZ78XmVBW25ZVUJfEYkMGZoAIFIp0aopVjwbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3DvWMbk; arc=pass smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3DvWMbk"
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-64b9cb94ff5so1727819a12.2
        for <linux-iio@vger.kernel.org>; Thu, 22 Jan 2026 09:42:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769103744; cv=none;
        d=google.com; s=arc-20240605;
        b=Ba2NqJfcYVVuW0Jc2ZwkO+svITXz/POh5Gbz1duSs1CcLhZDcL+LlJUFKHc9PMbKFC
         q4to9xwVRYki8+4EEAeErxSSW/2aUGWp1oUnR410SXkgOg6qSxcECKPL0M1WKL8CXfIf
         azE3lv2AYGsXXWYMN7I3JUt4AhdOkzp219FuSUF7C1Iq1t/zQGNNO+8NWajAJ/FGoJCX
         MrltkosKjYhW79E0Qk9e0wzqCfzzGdhsFuB8lkTsKpsXXmSxG8Maz+SdroY6WWzS82r3
         IwsRRP/ui3VfxtTkO8b3SF0vkGCkOoT1LFsfQvNmIM9gMa5WdkWOCVFJariFjANtWBdR
         v3lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aqoZDyaJvhhYOte+H2QXEaoIyJUjq4m9HjWIs7tmPAw=;
        fh=kvUBxOHU0phsiWDFGGMUW7PkWgE8uQpT/aLTxe1Es38=;
        b=JOD9KiC2Oiibcq2W99soXeVlzxRLWhDv0/zoB3dS5zIDrOOjldjwT/HpLRcEV943l0
         xZCdY1ZRUJEbhYs83W2bg1S6zNZ64foZOw2Z9mwCLRY1MGBfA3O48UFglJmjtBZzINmC
         vqlvVQLgFcmXa9G8KvhxeaWHZPNmLBWLc22ClQZJhUxu7E/GgZVRUxRyTSEFadjEzcWF
         ueaJWVlxiZxLoVtbE9+2A5FJIcUX6AFQp9MO/QkdiqAQtwK72rD8VM9aVpSlPot8DYBc
         qa3nhx/A2mHOIOf5PhVs+BZm2uBxXYR3xIibDc7N6ctjlT3YxJqaw9OwWjzSu0BQW6i+
         ZaTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769103744; x=1769708544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aqoZDyaJvhhYOte+H2QXEaoIyJUjq4m9HjWIs7tmPAw=;
        b=O3DvWMbkzpSzrTRjfUK2JYpDFPxexZMJSUj60sUHAK8pc4gpo2eBzaB1eiNFWCKf2o
         Ug9oXdXkoccpSUQVIpmJoXHXiwERL/7/VJf+ALV03/SI+7qQMu2xl3+37fmpYIZjv16A
         aLOi60cV7rzvmMNWmNZUsG+tvMajYc4Z9bF0OXZrMaWAnfxl7Lk1m9vGt3qSf4r/d0Cd
         hY+qndsXBJndh+87iH1Twx3I4xLFp2i7QG9DI24svSsCylA3ie+YjhGWV7Yi8ibngmRU
         ISC0GpEKQRikoOyCxGeaSHjuNWWcC7VU0euJtuOJH0k/lcLOdf9+2fBBRGEXwD6Dt9oV
         K32g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769103744; x=1769708544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aqoZDyaJvhhYOte+H2QXEaoIyJUjq4m9HjWIs7tmPAw=;
        b=RS3Rls/cTamE5T/hN0Y24KOoO+V0lUUSJPlHoElnpIrbjl+L6mMoIrIkWpYP3Erpxe
         O3uiKmm1HD1SiiTWoUxpS7IFg82FhevVnsGrdT2ztbFvrEWItx+zwoeuf6g2zAiMn8yQ
         DvXkBpUAZ25sByVm50uRSYYcK0faE4DWOTpGKcQDJ18NED7yamehUz4jQDeFtGVCQdSt
         pwKuSOGMNcit/mWpU1lFKCXkTfe6IH0rfuv7zL6yKBlVUpi87a0kuTElUgNLm6Tx/HxM
         68QkHTR31wBcXZ9cM8pqBlB62EjDLNGZwkvSpFw70IqDxluarf9roZW1yGxIuaqt2NIs
         rAzA==
X-Forwarded-Encrypted: i=1; AJvYcCWG+pJqTa7EMgxt4sjgZkv510DKEw+rSfIRpktVP3w2J+Opu/obTKp6Z/kyBRov9V52HTW+d9nUDNU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/GeYOaOAQCEZ9joedYj5F3UK25GVx1hOuEjELLxYpCbUw1qXm
	gGdhcgRR85II+8eepfIGgh9Tlq/5pkDfROl0dY5OXvNeH6wGK9Xb35AqZ5mutl6L00fBl8OocMh
	eY0arNFRmGy+cRBG9mwMIx767xrzjhUY=
X-Gm-Gg: AZuq6aJV/aj0pZ16kZHg6r+PYzHlN0Oi9xAoU0eyBn8VFl7hd+EVYEWjgTLDcjGNu8W
	IPvP589vk6z532pC8EUx18GR2QuJWF/c3RkKgYyc2ySNmm9VxgcvNOHNlx16qjEPlf1oYEIJdW5
	JYf62ivUBonKX6JkZaJSm8JhCOD5yWS1r1ADsH5IVABMeT5q/aVMIFMk367FmdttEoOVmZ1zBzZ
	FP48PMR4MyiBefbzlKS5IaswvyXKn6BV70fukabmHEhYeSfzq6qZKUE/O0hdFi+wzE21Gw=
X-Received: by 2002:a17:907:3c87:b0:b87:7cb9:c3dc with SMTP id
 a640c23a62f3a-b885ae2f879mr3705766b.32.1769103743678; Thu, 22 Jan 2026
 09:42:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121-b4-rfd77402_v5-v6-0-5b944d0605dd@gmail.com>
 <20260121-b4-rfd77402_v5-v6-4-5b944d0605dd@gmail.com> <aXCZ8gRTsR93A5Kz@smile.fi.intel.com>
In-Reply-To: <aXCZ8gRTsR93A5Kz@smile.fi.intel.com>
From: Shrikant <raskar.shree97@gmail.com>
Date: Thu, 22 Jan 2026 23:12:12 +0530
X-Gm-Features: AZwV_QikGFsPBAR086DSVqI-x0bVL0CP0mEeNRNImR3rRyGoH7pU8QkkrPXrxIc
Message-ID: <CAHc1_P6cugsNNFW560BsM8CsFN=2iv_hU30fUAF3qZ1vZLTdXA@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] iio: proximity: rfd77402: Document device private
 data structure
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 2:48=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Wed, Jan 21, 2026 at 02:05:44AM +0530, Shrikant Raskar via B4 Relay wr=
ote:
>
> > Add kernel-doc style comments for struct rfd77402_data to describe
> > the purpose of each member.
>
> Assuming checkpatch.pl doesn't complain (see below why),
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
>
> ...
>
> > +/**
> > + * struct rfd77402_data - device-specific data for the RFD77402 sensor
> > + * @client: I2C client handle
> > + * @lock: mutex to serialize sensor reads
> > + */
> >  struct rfd77402_data {
> >       struct i2c_client *client;
> > -     /* Serialize reads from the sensor */
>
> Not sure if this can be removed due to some checkpatch checks.
> Have you run it to verify?
Yes, I verified using checkpatch and it did not complain.

Regards,
Shrikant
