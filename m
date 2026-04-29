Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F41C33689A
	for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 14:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777472827; cv=pass; b=ZHRgloiqSNVN4TtFenuLjjndBLp1d9HAX8DErBpL+v/+gzG7wB5w3+zHGb9n6Z4RAs6o2DcoPKZa1/KK7Jsl7gVsiVSaj51yqPIovKeanz0pu3FV3Ym/ngLDcJuzmm652bd94SWmj9syG9OFcGClxNEyrNKyECrbmjiHUdjcp+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777472827; c=relaxed/simple;
	bh=VEW/a8skn+6zpzLRQ03Fyafwelx2BMyNkGoiqeA5YbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kjXwaoapbk69g9BtAChlXqUj/0WkUNsBJnD6IA1P52jDQNHKxebpiE8BcmD3opQBuT4IICcRcHdrcgMoOU39aC3LZerSl4eSgyekgR6naRaHoM2D46HjTzHhnxoxPcAzaX/qV7l99uanmj0K5FDP8dviysr597sdxsKrRO6sRbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JxX0BxYI; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxX0BxYI"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7982c3b7dfcso123848107b3.0
        for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 07:27:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777472825; cv=none;
        d=google.com; s=arc-20240605;
        b=PuBxUMi603OBq4YDWf/0W+KaWYvYLe/jG0sX1HNLIuMFfRCzsk5SZUSKwLSQlSd9Us
         lsuo12RssMemdfA87B4racSVlvbZdgEXxnEd+LYusEkPDRsOJE5Nty+GlRPvYx3sxgwX
         8sENHwq/mzP3/Knk7iyfPDNUjpnFjQA3JKH4Z6N8qmnWO2GE1nrRZdF1POuN0/lD1tYh
         Pqc2c5sycHCpvqWCPzuRDFxHN9uR189Ng2Q9JQ+vavJUxiWl3MYpiJdHlZRqBbjwVRuc
         kPfYPL7un49DtSnwVVRMueI67olbLpXIpIZbfe5YnRWlXE+hhsSDJGN72hLKEAVjxcKR
         sZIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mUOJv2rcg63awdE+sl/k5KnSLLLRdiGM+pY0j1pbnrE=;
        fh=BXIvbxt5F4cYLwfPymsyuqXj6CFezxP4IRWGR/9Aihw=;
        b=hjdzhy2hKG281GfbB7tC/hlbG0NNEpaAz8XTanTd/drzFCJ2e9UV82J24hwK6wLahT
         mIpFozUomWpWGTDwk+tMpzetdfyo9uScG3PqrrfLVBOYmm0GbXiQV/gTrahzCfNRZce5
         24zKngVdUaum9du5V5bx1mCvTVD/1mOk2SG3CdA0EmzPIJ1O4vhTOY+OHSDsMF7GCngI
         Afs8si6EnTSavyyjVgh+wK6fom+8955DLFlDMedR/vopmkafuw0/ZUKPt2eOMiO76LuE
         I2BE+aqHjkzlw3oFXVJcuNS25x7I1zCr9uMpQjWBXJXeLB4zGr1Hy8GeYd65jZmAQ57M
         ocvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777472825; x=1778077625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mUOJv2rcg63awdE+sl/k5KnSLLLRdiGM+pY0j1pbnrE=;
        b=JxX0BxYIXMyj+2eDNQpyGGEonP634GzJ9znWGdoG4rztMkkx592nKYVgyIBOCOazXf
         z2dSR5/WnIVzX/+aix3o/o8qWIgb3/+Zg4dufrBjU0C1EK1CfmMkzI4fhEaYXNluVyUW
         dBF+ZcrJv8ihu5iq/6GK+dbogHVxT1JkY5Fz+Uda8tNoae6hTlWNmEBIGRmk7E0arSHB
         cyUwDOf906BnKHkH5WQUlnV4l20ImXY0F8B6IcjMAjsdTvo8JYwB6mwUuaFXMSH4EjnY
         Vhkpxtdl2iW0x2bWclcd603cHQv4KfqAz5wRjoWG2H/u0lVS6/y1uvSv1+s2ehce4BvA
         1k5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777472825; x=1778077625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mUOJv2rcg63awdE+sl/k5KnSLLLRdiGM+pY0j1pbnrE=;
        b=eWdfUcgRflPVPNV09uYVH8Zc8jFXsH7iIU6oFSb4t+nxWl8XFivxy8iSbzPnYxJH4/
         2QZasLvT9rJhbGW2KWELKL50Hx7S1ybprwGvBIxjMzml4nH3gNSSQ/C549dGaIyqUFIr
         BHyjXlhHd2N1MtEx/PcD2OPd7wlakcJqHHFoql53C0v8ZzfE6IOwWWxgJ+JzM/G1IuMq
         MvCLEPmRuYK6PVdMGGlaXfYtY7OsEaLxHxwm8eIaPgGpw5Ca9Ryk2eMEBQHRn4WFoZn7
         ad2BoyK8rqF/kStquk4zxLMxcA+JFoXM2jRcFGDjThub6pXvi/3mMfBEHFvV8YON18c9
         8Ifg==
X-Forwarded-Encrypted: i=1; AFNElJ8wak1vOd1qsLPfbMoJvA/HFMgkR0oSGurZ66Uf3URQHfYoBzKudZa9LpJHKeU62zXmXjUkGYiX6JE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVOsjj7sq1oTJZXk4o1d3++JgWxaKr3UsD36i+saD224t2izuR
	IJADyO1EExFisk0ZgCof6cERmP0urZV3eT6bWaSDvb6UTC2JFyD616YyaRiCLjvgxWeG02B7+X2
	H7mM0duGEnPWKitQ7jrJ4wq0mLDN2WtQ=
X-Gm-Gg: AeBDiesP+plS1xDEIyKnB7atyW75kOixWEQ+aVP2E/58tAbnFMr8EJw8Ssxu3SxhJlL
	djOWqsIns02o4DfuuiQ9CmAzCe3JXjmts4n9Rg7/KpUvcuPi1QLPWCt2AvatHLXDFn821nwV20W
	LgY43UnVzJm+uBiKAoc8yq44oLno/paTrrQnGTNPd0zHCR93ktVYDB9fFDkfIFxNtlku9j7ET5V
	PQ6yD6zrFt565dF/60TT47LhEjJ62rr5BVU9fB3rovnNd0PfDgK/BqFzh9R8rPU9jwygvstHH5W
	1zncHLP51r4Jlb3OVwpp
X-Received: by 2002:a05:690c:7301:b0:79a:8f2f:cb3 with SMTP id
 00721157ae682-7bcf57a4bfdmr79675727b3.44.1777472824895; Wed, 29 Apr 2026
 07:27:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428222600.91322-1-m32285159@gmail.com> <afHLYbjUjE-kQGer@ashevche-desk.local>
In-Reply-To: <afHLYbjUjE-kQGer@ashevche-desk.local>
From: Maxwell Doose <m32285159@gmail.com>
Date: Wed, 29 Apr 2026 09:26:53 -0500
X-Gm-Features: AVHnY4J02lT8KEqnr4eEil8LtnQ9rmUxCgv8eKIouP_56oCz9tEM4Cpqt7Z7PPs
Message-ID: <CAKqfh0EXYOjzyLcXfRB7RdBVfcNOkjpoL8H+7t124H0n17UKXg@mail.gmail.com>
Subject: Re: [PATCH v3] iio: magnetometer: rm3100: Modernize locking and
 refactor control flow
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: songqiang1304521@gmail.com, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Wed, Apr 29, 2026 at 4:12=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> ...
>
> > +/**
> > + * rm3100_guarded_regmap_bulk_read() - Wrapper around regmap_bulk_read=
() with a mutex
> > + *
> > + * @lock: Mutex to lock while performing operations
> > + * @map: Register map to read from, passed to regmap_bulk_read()
> > + * @reg: First register to be read from, passed to regmap_bulk_read()
> > + * @val: Pointer to store read value, in native register size for devi=
ce,
> > + * passed to regmap_bulk_read()
> > + * @val_count: Number of registers to read, passed to regmap_bulk_read=
()
> > + *
> > + * Intended for use only in rm3100_trigger_handler().
> > + *
>
> I don't mind having kernel-doc for a static function, but if you do that,
> validate. Here is "Return section is missing".
>

I'll make sure to add that in the v4, I probably should've been
explicit in that description.
>
> > + */
> > +static int rm3100_guarded_regmap_bulk_read(struct mutex *lock, struct =
regmap *map,
>
> No, supply *data and not a *lock.
>

Understood, I'll also change the function signature for that in the v4.

best regards,
maxwell

> > +                                        unsigned int reg, void *val, s=
ize_t val_count)
>
> static int rm3100_guarded_regmap_bulk_read(struct rm3100_data *data, unsi=
gned int reg,
>                                            void *val, size_t val_count)
> > +{
> > +     guard(mutex)(lock);
> > +     return regmap_bulk_read(map, reg, val, val_count);
>
>         guard(mutex)(&data->lock);
>         return regmap_bulk_read(data->regmap, reg, val, val_count);
>
> > +}
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
