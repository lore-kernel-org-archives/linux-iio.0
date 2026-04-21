Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E34D2BD58A
	for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 15:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776785929; cv=pass; b=WWtJO6n5tpMg+EOk86mFJ1PNGbGj4vYO1u6cSBTIgriQdftpc25MdmmHO1i94+f6b1nwGRnJiFtlXeE+BEBNRfkZOzUv6j6K4FBOpHeSKOUoiplD/rkC8n4b805EJXoOv9ydp0tQELo0jtSvX54Rfp8WRmtt2xRjwAv0kazuqjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776785929; c=relaxed/simple;
	bh=ooor8Wg66l2hU5nd+/rDDWKrttHSiPMUgBX/qDNQA7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EEDo2FkSNWwlDdY4bf3XfoWpu1TVt0TB2jSKHqVXzOKX1Jj/Y2quT/NNyHU4uXhCDD4EivcVDdPqGGKPT0oTm/UzhztNyZA7FM2lAH/vpQEUdWMqrVy01u26CCNXXuzZShIRWf7wdPfAM34M8wwlGELUc/IG1HFKNAUi1GEq7Zc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rduJ45aY; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rduJ45aY"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3870778358aso33054871fa.1
        for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 08:38:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776785926; cv=none;
        d=google.com; s=arc-20240605;
        b=ZWKqKGjjSYA6IK6cSBCd3cn4VI0yQUI/Te+IfI8Os1LeEiDRtU8034F8C775YktFgo
         ZTbUqV7k4lPnWIZcUr0YmdOvc4K/JveCPaPoxRtfuiEn/UOyXhcCuU8PAXwL/uWLlkI3
         bKLIlvIveMFE8uxWJVVoNzue16GWCLJcTUffiMsp2vca8O8I18hpKB53mtSj0thLnIiE
         8Rh/GVX6m7s4xNrUKIo7Xv8oqKpMIM/egDPn3OjfkupslWYEe0ErKUBB/a2LMVQPa8Uv
         PNoIc6pRTGLrq+SATUa1jB28M5O3gFQkfol5SteLkUh1n5iWZMCFiLcNp4bompAUzzFn
         P6Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zl+Yk4rwSV3pc+0hAmsNIGhBC2b4D9FzfdQUh1cAks0=;
        fh=7jPhYRpK3W0m3Hlc9Iv+6fnMYVsDmjIRkx269QT4FIQ=;
        b=RRVbtxXdWG4mTwc+2385m/nFrl+PTw6kwjc4RpmyivOogEIWT3O+cFJQD1VcKhkmLC
         eDWa6oOF2c7FOYXDUmlGR/ne06eR7hbYUVes4xCg33zs2Z4jQmCWDqT/oEfY7WLxI0VF
         a7wPV2lDv4xVNkkceYEiv+BI8SAVGRcbrfKWvA/cwoQlDBK6XpOMMLNeiL1NWSwHlD74
         i9EdSA7xvqXfr8HOfwIdcksHifYEOzJqus6VH1y0CDaNSb/RUPLdHA9aFNECz2wesTnn
         iszGBttC2znHCWGzNwjI7sGwwIu+14VubN99b+Qs44G50GgwBgGTWeG5fpdemjTVrgU5
         VElQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776785926; x=1777390726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zl+Yk4rwSV3pc+0hAmsNIGhBC2b4D9FzfdQUh1cAks0=;
        b=rduJ45aYkLnpCh5MGpw/JrF8+lQoCU0CMgDNe0TIJA5GJZqFI2e3CyIA/gZkC9/A3q
         r1WifP4Cl+7qAhUL7wga5pNIBZJvPM6YyPIgggtsluAYR8DHNo0uulQ3Sb+ehD5bqhrG
         4SB8FHY/jEvu7ZCA5hN/kpYdArRNR0/xTcYeTRN4BfWHGXt4zGd269hOkcYQ5oAhCJEL
         IkQxK3D50WYaPjtlb8J9wQlsI14kCoCYzSN4La+WWd4bd/tj6ocnxK5Cqp534/bwqDuU
         B31AEm2ncAnt9t9Hmwyk9pKH0MQnudbrXFkZeP7F+5r3MST4fhKPV2oufQQKB83cz+5v
         Gfiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776785926; x=1777390726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zl+Yk4rwSV3pc+0hAmsNIGhBC2b4D9FzfdQUh1cAks0=;
        b=tV85xTI0fth7bR4jzg3/gSpKd5Svbraw2zJFsKU+3BGEtkb4b1knW+yk2JcfaFTY+R
         2VTJY8xbiK4a/mgMwCZqPgHbs/kqV4rbuno0QU2aLRVmoHs6DOlGv3HrJkyzYlyZuqP/
         VrFUMYQQ3qm0ascCq2ksZjogXqbMUMGX3DQcdaElLdOorAJeVIfI6eIeNB7gJbP8o5jy
         RXxehy59NrqxeL9RC9gsxJLxpVbwg30abuQfsBzP3Y8NBXapR3fYy5fnUKzL8sVPtsD7
         cpcW/XnF0yaoBjgqB0ePGllcPbCLgly8N3VrsZ8OuFdnwMNmA8Nl2znAuzblObG1LKCv
         dULA==
X-Forwarded-Encrypted: i=1; AFNElJ/f+NtVXooq4uTdsNZTyh81QDu/gSuk028d8mUWsuWn15JAA+eU234/WtPLs1nY64DaLCu++TqrPcE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+WQwlZKTo+JU0w2Dj6hy2abNjsNKlUVo72lLDngVPBNQU+tXG
	QDOMUUyHzDA8/zSM4z8HaKArxHYMhlRKTMPM51i8T4wcffkhvkQQEqtpquwZFYKi7BuGDl1z9UH
	QW644fMqQ9ST7XPovy8loF/iYYfOPM/o=
X-Gm-Gg: AeBDiesfE7kXfBpmubMocHnvR1yX1nHNYnalHtPPhfFZRjTXzESXtjXKVs0fU7qDRfh
	1KqrYzorPdJXZT5QmXsaMmKzmx9c+/gbeXCgCyFqBlZDj+EAzSFEYy0hvEuAXaRo/EbeUSjigN1
	Z0qT2qf0Oak5KinJxVyptUUf/IIOEyxUuD2V+K7A/6NZujPfNNziLpYUb4QV2XmHpOUxVka89Cc
	KVnZFwJ6aRe/srE7Va5QD16XENfevTLfiLulxeyconUeD52QV9WSZV6FWD8/HR2qTJVHfU3jEH9
	cqAODi5WAnhdjnvGepdOzvQYa9ae7nj+LX9QD7puPNuVfDWssuYwRPVvOdy8OOk=
X-Received: by 2002:a2e:bc09:0:b0:38f:20cc:2bb9 with SMTP id
 38308e7fff4ca-38f20cc37femr33563371fa.5.1776785925908; Tue, 21 Apr 2026
 08:38:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260419151327.26306-1-muchamadcoirulanwar@gmail.com>
 <20260420193320.22df4979@jic23-huawei> <CANiq72kKkRW7vwYKi38dvsM4HCtKGwzOF4ujMS-X=peGb_Vi3Q@mail.gmail.com>
In-Reply-To: <CANiq72kKkRW7vwYKi38dvsM4HCtKGwzOF4ujMS-X=peGb_Vi3Q@mail.gmail.com>
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Date: Tue, 21 Apr 2026 22:38:33 +0700
X-Gm-Features: AQROBzAPh-8rV-iHNyCsJxELuNXQ_YFaVo5DxQrC5oJPsOWT4R6e3VhgIFh8Fkg
Message-ID: <CAO26r3TqeLOF0mEgrsZszNU2TnGv6++OtSzEWtcSgXj-OvpTfQ@mail.gmail.com>
Subject: Re: [RFC PATCH] [RFC PATCH] iio: position: rust: add initial AS5600 driver
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Miguel Ojeda <ojeda@kernel.org>, 
	Frank Zago <frank@zago.net>, linux-iio@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan, Miguel,

Thank you both for taking the time to review this early RFC. I truly
appreciate the architectural pointers and the lessons on kernel driver
culture. It has been incredibly helpful.

On Mon, 20 Apr 2026 16:49:00 +0200 Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
> On Mon, 20 Apr 2026 01:33:00 +0100 Jonathan Cameron <jic23@kernel.org> wr=
ote:
> >
> > Do we have a rust equivalent of BIT()?  That tends to be easier to comp=
are with
> > datasheets that don't use hex for this.
>
> We do! Please see:
>
>   https://rust.docs.kernel.org/kernel/bits/

Thanks for the pointer, Miguel. I will update the constants to use
`kernel::bits` in the next iteration so they map cleanly to the
datasheet.

On Mon, 20 Apr 2026 01:33:00 +0100 Jonathan Cameron <jic23@kernel.org> wrot=
e:
> Have those been posted anywhere? Or are you working on them?
> I've kind of been wondering if anyone was interested in rust bindings
> for IIO drivers (and dreaming of having the time to write them), so
> this suggests that you are at least.
>
> In the mean time this stub of a driver isn't particularly interesting
> to review.  My concern is the common one on whether we will have enough
> folk familiar with both rust and IIO to review drivers.

To my knowledge, there are no official Rust IIO abstractions posted
yet. I initially planned to wait for them, but seeing the interest, I
will take the initiative to draft a minimal safe wrapper for `iio_dev`
and `iio_info`.

For v2, my goal is to implement just enough of the abstraction to
support the `read_raw` callback, allowing the AS5600 driver to
properly expose `in_angl_raw` and `in_angl_scale`. I will submit the
IIO abstractions as the first patch in the v2 series so the core
design can be reviewed independently.

> Push testing logs into a cover letter or under the --- so there is no
> chance we end up with them in the git log where they are too verbose.

Noted. All verbose testing logs will be moved below the `---` line or
into a cover letter in v2 to keep the commit history clean.

> ENODEV seems a bit too much of an indication the device is missing rather=
 than
> the magnet.  From my vague understanding of how these are used, the
> magnet may not always be present so perhaps failing on this at probe is t=
oo strong?
> If it does make sense to fail, then fail on the strong / weak as well if
> that means the outputs are useless.

This is a great architectural point. I missed the perspective that the
physical magnet is an external factor, whereas the I2C chip is the
actual device being probed. I will remove the `-ENODEV` abort from
`probe()`. The driver will initialize successfully as long as the I2C
communication is verified. The AGC status and magnet validation will
be deferred to the `read_raw` callback instead.

> Too noisy. dev_dbg!() at most even when doing development (assuming that =
exists
> - this is only the second bit of rust I've ever reviewed ;)
>
> Definitely not, even in an RFC patch. These sorts of things can end up
> making it all the way to the upstream driver so dev_dbg!() only.

Understood. I will downgrade the `dev_info!` calls to `dev_dbg!` and
entirely drop the noise inside the `unbind` function.

Thanks again for the guidance. I will start working on the IIO
wrappers and the v2 patch series.

Best regards,
Muchamad Coirul Anwar

Pada Sel, 21 Apr 2026 pukul 16.49 Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> menulis:
>
> On Mon, Apr 20, 2026 at 8:33=E2=80=AFPM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >
> > Do we have a rust equivalent of BIT()?  That tends to be easier to comp=
are with
> > datasheets that don't use hex for this.
>
> We do! Please see:
>
>   https://rust.docs.kernel.org/kernel/bits/
>
> Cheers,
> Miguel
