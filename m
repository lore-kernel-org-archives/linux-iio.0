Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280F43DD53E
	for <linux-iio@vger.kernel.org>; Wed, 27 May 2026 08:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779870607; cv=pass; b=t8ZLuKbEbxQQdiNjCG+gcgtu8I6RAQ9Ox6kaC6d7YO6fvlSLCpIbDQ6+bh+q0UZnG5PGODtdJ0IRjnLhEjdAeMdlhfAqYxqbSVFvv98gl2IsLYAtSlCZurMvVRR0LGIx2evJHBSo6vz5mR4Riv0oXuLrkZNIlfMDGhCldZTTCvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779870607; c=relaxed/simple;
	bh=nZ1pDGT6FlSes2V5NyuW48CIR9bKY76MxnUydMhQkQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CT75QzyHXBJ9mP1+KVp9i3jdEzgXkjISGHkfpU2rxSSdlBpZcZ+RSk/nSB8xkW8c8JqgrtqXqDNzTt09MnsYIiBs5nLrg6tA4ZlLM0Vri1Acki/1VDYN7xS2WQp7qWLcca2i1zP+K7EZZETJ/IUqAOI0jbZjeAmzA0dQH5pBpbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QcAcJWAi; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcAcJWAi"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-687ed9aabb3so11128196a12.1
        for <linux-iio@vger.kernel.org>; Wed, 27 May 2026 01:30:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779870604; cv=none;
        d=google.com; s=arc-20240605;
        b=CgOif3Y0o2x7tbI4z/uWaH1FF6ewb4QIQbnIq06OMFw1hJRL13DFJQRTzf8/RJhWa9
         JLN5JG+IhKqZge0xYFQbJd7WP/a9v9+LjftF4bCcpaw1ui5Km+hlmWFwotFesqqGyvYM
         EqNOJ6pg5Mzy354OOrsofAVvDQthpk4S0rbPAXiq8KzCL5bbcV5p5n+h4HSwgAQyiFg3
         MpZeG5cWan6rCndCTGz5XCPtpXTX3jdja4mdvcy0sSwI0BLbdkP0no2/0y6A18Od8HaQ
         ukFj3ZiZSJacuM5OnViPSWOEBfLT3diXMEDFLn3svNDUHsYE9kjWjwNrrjkLAW34jEdq
         fyRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ETqQguDCcaT0upfI0i3HQu/BkRTKnWBXAaPJeG+daRg=;
        fh=lsHxp6P6bSr/Qztz507kq34kEGquZ8ZUjeuTLE1Wsr0=;
        b=enDvXQV0C0R3ixQxyJzgv7BxzCFnjocoKyrSJ9/pL5R+VvFmfOAe0J/GINy2zqzBOT
         7JMlAZO9CYTTAqLEli62wmf+1sfUYrNVIX6z9Kr9heNJ41PUVS1vWvnIK7j8kNAU8aTj
         PxW/UflXK3b/GVmxq8KStYDzQp66LsxBKHKi8edsrKeflbwYnuUWexqOg7O+WcFeCqpN
         2UGeQ30Uo3pOWW/9+gWRZpPHsDgjr24rHDlcU7jZLRDXeWxyYSxlKHcMo6WENrmAImg0
         305sz2IAEcrVfO4XtSx5xJM88BUMqBO/I5PZviu2wAnrzCKrpG8gxuzO780QqcH8QFfJ
         4XrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779870604; x=1780475404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ETqQguDCcaT0upfI0i3HQu/BkRTKnWBXAaPJeG+daRg=;
        b=QcAcJWAiPJkcQtSLE+HoeBDVpcHz2Th1K5RSI7NeDL4ONUCKtnf6wR33sYhdUz2Az2
         5veEc+fXm8bG7u7hsJUBLoavoNym1aBiE5JVfl8m1Rmm0KTlWWx6whLRYGEczXb8qJk1
         WSk5s2EkVA/6wRwNPnopafzYDDRr3++QIOPAPTppDaebizuKTt4ma00G9k54HPlbyvwj
         cda7QUUt6LYAPZ8yUODe+tgoLKsUM2M92+dys2t7M0cBjuU49mT4pqwDWBWPUblX5ND8
         +jSwjBi6rajSdjlD7VbJtQmuk7Tca2yGiCrRzYj88tVQZeBPB7LG8LBANRfZIf/y1Gp9
         kxkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779870604; x=1780475404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ETqQguDCcaT0upfI0i3HQu/BkRTKnWBXAaPJeG+daRg=;
        b=mb1sKRorc4Yuz/8bPg8tmcYEPd6g5JcusuRE4sEZXsgSS6NU9DjeMb9k0MW/BLqEgX
         PM6CXCcWnwtpgkcYndWVoxOJK7sVSbps2OQw21HJDsqgIzouj7bUGjtAvpk3jfn35Txg
         OLM04yKhbncVi1ONMqIlORV+2Phuaocxq0AWS4EVV0AmCoUd4sJpD3iTk82fgGsfmPpQ
         sPVlvE8S2xKEC5avqZkFRsWYVSDcto+0k0lIfTkzfSem4CNtPybsZYdMVEvReMh7t0yg
         S1+wLUIfJyLmlIioEj9YqkadZ6BoXa4Hie3qBlzAk1BsFPogA3a5tPiZ1QiobdroYRUR
         DYow==
X-Forwarded-Encrypted: i=1; AFNElJ+QuX/D1NbJFHmFEurg6NAf5eMRNdcbO/sOcMd8T3v+gjgekiQtL0E+pnPlbOL7VUZ3ww72H0kGpHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHGDLRJSY0Ev0CPpz5pnxOVvtsq/F+h9zk4P9Zh1D38znghNn0
	jk4EiAcxygJSINDjiSkuKBulX1T1lz/Q1ZUDou659xZXLGWNWEXevb5qsRvzDAlCCa2wcCrKG36
	JQfj7njhLLWdQe+nwzgqxACBZ+3m0S0Q=
X-Gm-Gg: Acq92OHyoLW4Rqlr6lSGPX0cQavo0zPyZl7TsIZRht3EiHtw2ek40Iw3qfp6e6IOMmT
	Sylxb5GpGZ3lNE9UU8nyEyzfBmNrdsRdHe/IlASEptJEFE8yk3zMz3eBSp+qQYVWKknmcgsNPp6
	eaGjvqot4/jO2n7CjdMKVT5A+20LvIlX7qkpWnXeFnPsMkcGFLbLrm1in8E8H+9O9NH4gOFKpRI
	yX+62qUPvGUjCoj28iIH+yKGoBw0iO7Zm2iickFFvWHpE+vv7aPVZbIgnyPYYke0QzlRggE58vf
	q/bP81cMJPN6ilFhhkFUFdojbVl+jlwjD9bZNujGlV+Sp9vVuqOcKhZ+EbWEELKkqhcjliT2A76
	YTUk4N7qxFhObbvMS7VRhjOnsl7RAaDMiQ472Ubciht+JqhPLrxFqy4Q1UJnCyVm/KHOTGUJMJh
	QR9oIIpJnrIAO324g=
X-Received: by 2002:a17:906:8446:b0:bdc:aca4:8d3f with SMTP id
 a640c23a62f3a-bdd2330ff0cmr1010406666b.13.1779870604335; Wed, 27 May 2026
 01:30:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHp75VecaMW5S+jtP5ZMr2ZtPTHXsTeVzos7+WSpgnj7YcMjLg@mail.gmail.com>
 <20260527081833.505655-1-wbg@kernel.org>
In-Reply-To: <20260527081833.505655-1-wbg@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 27 May 2026 10:29:27 +0200
X-Gm-Features: AVHnY4I9OHj6qtnflhlzPd3INw6Z4LI6d_kDSwmscr1VkdPAGC8uPoVKFUmuy_0
Message-ID: <CAHp75VcKEDjzUs4wrErGHAXOPEJ6GRge0A_LHra-Gf7k4e-X5Q@mail.gmail.com>
Subject: Re: [PATCH v2] counter: ti-eqep: balance pm_runtime on
 devm_clk_get_enabled() failure
To: William Breathitt Gray <wbg@kernel.org>
Cc: Stepan Ionichev <sozdayvek@gmail.com>, m32285159@gmail.com, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 10:18=E2=80=AFAM William Breathitt Gray <wbg@kernel=
.org> wrote:
> On Wed, May 27, 2026 at 10:10:20AM +0200, Andy Shevchenko wrote:
> > On Mon, May 25, 2026 at 5:21=E2=80=AFPM Stepan Ionichev <sozdayvek@gmai=
l.com> wrote:

...

> > >         pm_runtime_get_sync(dev);
> > >
> > >         clk =3D devm_clk_get_enabled(dev, NULL);
> > > -       if (IS_ERR(clk))
> > > -               return dev_err_probe(dev, PTR_ERR(clk), "failed to en=
able clock\n");
> > > +       if (IS_ERR(clk)) {
> > > +               err =3D dev_err_probe(dev, PTR_ERR(clk), "failed to e=
nable clock\n");
> > > +               goto err_pm;
> >
> > This is not right. The devm_*() should not be followed by goto.
> >
> > > +       }

...
> >
> > > +err_pm:
> > > +       pm_runtime_put_sync(dev);
> > > +       pm_runtime_disable(dev);
> > > +       return err;
> >
> > You have to use the respective devm_pm_*() at the same time.

...

> > William, this patch should not be applied (or should be reverted) as
> > in current form it replaces one issue by another.
>
> I'll revert for now. Would the proper fix be to replace all
> pm_runtime_*() with their respective devm_pm_*() calls?

Not all, but the ones that are opposite to
pm_runtime_put*()/pm_runtime_disable(). It should be done carefully as
well as PM runtime may be required before final registering of the
device to access the registers (I haven't checked the driver, so I
don't know if simple use devm_pm_*() will be enough).

--=20
With Best Regards,
Andy Shevchenko
