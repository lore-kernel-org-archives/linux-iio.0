Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15392BFC60
	for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 23:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776899037; cv=pass; b=rQCZ6oZM3AGcGaI6Q3Ox67L/3sJkyldGactMPuM8GCP351QmqC/H3UiDLfC1g67ymZJvv48k5TtYTkr7Lkbzx1pPfps3LHXxx+LmWAvta2m/pPKfI0yu5vW4YREr6Ge5RftTRcI16RSjKY8QiroHl9E/czuCOGlRaVM0MRgZ+D8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776899037; c=relaxed/simple;
	bh=KXO4RmZONLexDJA6cNlzp+sXYrBZSdnXXkmeFz+SI2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fb/ulIbLBPbUCsCZjj6jymNZFFg68cEZtBrdLVfC84hgxpBHjLty7svJWUZybipBDGnOU/Xvx9J6Lhm2anJfO6eoRauFBKHq0tYBqujKc1Dx2DAeChlnEkxoUrcln6xdR9BGF/3U90iJ1L1ibaB+0SL2d8hXMCQtCJBL3kSrVS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jVQhgUDa; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVQhgUDa"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-79495b1aaa7so60701717b3.1
        for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 16:03:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776899035; cv=none;
        d=google.com; s=arc-20240605;
        b=auwvyuDCIfvcqJJzt3VFDsMWxTZq6Dc9904NWDlXULPQEVVeg9s4i/rssz9fDfr6+b
         DSGfL1zvS3xbYhwG0Irmag5nw1X42NdwFN8HGwZTOgt5p7VZOLJBfxuiBhjVP6o2W8Jb
         Nlq69VYBEVkwCReIyPWLJ+bQhsHUmJ1191zmb812sIqVEPnOnJi5jTVz+d7vXMcflmre
         18ah9Gl5lD/wKK54lpXwyNLB96iIR2cNCd6Bqi8T2m4YYMuph7/txVkG9mpWEEuTAXfJ
         PDhBTgrba9llOdV8mNM1TFeBRYaGIhp2D5HYBs84pRcgwP4RbGj01GHZAGC5eA15M7zs
         q5TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=12x19t+iPik2XUzxukezkJLRNb4tdhI1WAaLB0ymjGA=;
        fh=2snsTeQLiON3NOWskYzjCzUYM4V/LjETDCbHjrFGlzg=;
        b=aRGEK4HALQjeUcbjlE6ATOrr3B/EKuR89qKmYwlbnGRCSpQPoLUgEgonpX5GB1jwcw
         q7EbR4LKSU51jQtw0mNTs6v9kk32NRTU3B4sFstSPxXjyu2fjTvVDAC54HGEcaQEMS+O
         GOqYlrhSZAI5FdYZaCev1hJNisVntnyNqs5jH5exZx9fA95bya2xOb4i9Xe8hM13LXOI
         WHnWStg0fOIrWkdky9I7AVt5pj8mvDuUibaFHPi8t8ei/xSNHiwv6T63xFIJdMuruCSM
         AGXAWhnYleewJRfIJ+Haj/g96ghSBAXiS14Ppu6n6htmPD5xDS2xq2pj3B2Js6I9EbrY
         uSxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776899035; x=1777503835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=12x19t+iPik2XUzxukezkJLRNb4tdhI1WAaLB0ymjGA=;
        b=jVQhgUDagP+VKQ+2VSuXtVDC1sDQd7H5rpvFaaa5YY6apjIouI5W5jGg6azFp8Ajti
         uJ7t8f/DU5DyUH2GkSt7+Qksh24WkqaoUr303MNqnyEI5Vc+Nw88h9ecFvH30iZ2yqf0
         eTujL8RFoHYUymaUbpZp0Wjt0gE0Qpo04XJEjpUlTNr1qgN+n8gaR7uFQOi4RQwPbFPZ
         qMAhMbJgcKQWuglPMfvVd4YjLEPW7Gm/8PkEAyDCLXN56lXQW6uOO3A8UkXX0GYUbMoR
         rTxEeOuNH52i3/48OvzeZWecoqDqqgh3CHhFccCcWKf0szudh9CkAZu8p3ggEZSO1FMx
         1KLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776899035; x=1777503835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=12x19t+iPik2XUzxukezkJLRNb4tdhI1WAaLB0ymjGA=;
        b=NpDiV97EzQ9Yjt6x9dp0P6YB4SMRWNTDFFeNEom1tB9UTouiiT19eRs1KLxiZZ/3wZ
         KPg4wrYIM1Ds1abDxAnpZO9QkilJrKK5SVA4NiZDMXYGEDG1R+L2cMAXyCZiEG1EwVtt
         G0joEk1o+/Ta5GwBfkW+oylvJPMImdizZfOMS974TGNLEvVGh2O5fc+bqsbjrfhfsS8g
         XzZeUWWP9O7ZYROyA8sAaeRpFquD1SDI1+zel5YdkN/r7nBU8PmuxmFIAyqK+Z881c/X
         kdFXlBnZ9hGrY06MWI9tN8mjLkAmX6JkZNWvEerYUKOkxQ/YZrcE+ras5dLyWmJo04Px
         JNRQ==
X-Forwarded-Encrypted: i=1; AFNElJ/W+N3vHCFHrNFpNvI7IgTZvusichcEfNZvj7r3nAEhTsU6seQXou9Qll6T+znjt+3/yFkfMXeabW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfMWDZolaF6JVtFXYZHDbP9by2RAyEPxkRTDaYCZWpOqYVWjbX
	ZWg9hQSfzahHG+2wIgKkYHVfyHNdRBsowqFII8tJ/IkXnT0nHRUnoXQjUWUUJemjvnGoTjEufaU
	f0tg3CrHB9E11QImiGgt9zDPnUlJkbnI=
X-Gm-Gg: AeBDies0ItZ6IJlUgSRs8piZYpFectt1D184hgOuB/vYtLey8UOt0sLhhM0Nznmk8qU
	PWPB0s+stTIR9RAQUjqBZwfxFidjg4JBJ1b0R6Dojpd2fYx5yaz9fBVK3tTa9egPhY8c/uriKZI
	ipG9np+KLGrGltscMrhXXQRNytAWyewaRUp7OmykKzw86cIpzpvxy0BanWKY19UtIZpKbsoG2Gg
	H3aDC6V18Ki6Gb+sp5PVSazj7/1Y+RgJp2DdkKfOJwy00b9C7k9wQb2AoGnyPQpaZ0AIsA0ptbJ
	mbz4+EFXMbi+HtQbgg==
X-Received: by 2002:a53:b608:0:b0:651:b7f5:14f5 with SMTP id
 956f58d0204a3-65310a11307mr18278799d50.31.1776899034766; Wed, 22 Apr 2026
 16:03:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421190855.24132-1-matheusgiarola@usp.br> <aeh8Xu90pyUBBzj5@ashevche-desk.local>
 <aeh8wfWGGkWppTe-@ashevche-desk.local>
In-Reply-To: <aeh8wfWGGkWppTe-@ashevche-desk.local>
From: Matheus Giarola <matheustpgiarola@gmail.com>
Date: Wed, 22 Apr 2026 20:03:43 -0300
X-Gm-Features: AQROBzCKAFAUGMtIXMBBdLqx3J4_DRmiMwSURZmNrlB_kPeqUZf3hMOLrc4-AcA
Message-ID: <CABGH8=a77fmjW01gsmBZnKz1bSkQHA4MrVu-_9snpm-Zv3z54g@mail.gmail.com>
Subject: Re: [PATCH v5] iio: adc: ad7280a: replace mutex_lock() with guard(mutex)
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	matheusgiarola@usp.br, arthurpilone@usp.br, davidbtadokoro@ime.usp.br
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,
Thanks for the review. I noticed that there's another student working on th=
e
same change, so we decided to join efforts and continue on his patch,
dropping this one.

The other patch can be found at:
https://lore.kernel.org/linux-iio/20260417131029.12568-1-lucas@ciziks.com/

Best regards,
Matheus.

On Wed, Apr 22, 2026 at 4:46=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Wed, Apr 22, 2026 at 10:44:36AM +0300, Andy Shevchenko wrote:
> > On Tue, Apr 21, 2026 at 04:08:55PM -0300, Matheus Giarola wrote:
>
> ...
>
> > > static ssize_t ad7280_show_balance_timer(struct iio_dev *indio_dev,
> >
> > >     unsigned int msecs;
> > >     int ret;
> > >
> > > -   mutex_lock(&st->lock);
> > > -   ret =3D ad7280_read_reg(st, chan->address >> 8,
> > > +   scoped_guard(mutex, &st->lock) {
> > > +           ret =3D ad7280_read_reg(st, chan->address >> 8,
> > >                           (chan->address & 0xFF) + AD7280A_CB1_TIMER_=
REG);
> > > -   mutex_unlock(&st->lock);
> > > +   }
> >
> > Not sure if we need {} here (as it's one statement body), but the inden=
tation
> > now got broken of the second line there.
> >
> > What about
> >
> >       u8 devaddr =3D chan->address >> 8;
> >       u8 addr =3D chan->address;
>
> Just checked the second one s/addr/ch/ as per ad7280_store_balance_sw()
> implementation.
>
> >       // ...or use existing names in the driver for the same things
> >
> >       scoped_guard(mutex, &st->lock)
> >               ret =3D ad7280_read_reg(st, devaddr, addr + AD7280A_CB1_T=
IMER_REG);
> >
> > ?
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
