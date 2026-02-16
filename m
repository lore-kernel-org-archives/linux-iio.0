Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED99331237
	for <linux-iio@vger.kernel.org>; Mon, 16 Feb 2026 15:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771257166; cv=pass; b=mE6IrH5Q/3RyiOm8HXrbWYOmq5Uxb0UotSKz2CHdcORTntlDZGOnNpe2A881pAwWWz5OTu1MPHJTdpN/UMnzTU9gDH72MASRpfCgW8MtzXLkbRpahqTqEF0G1V1fW2V93lrqAFQr910HqWPzTlIsHexQ69sAfDEVG+MdIiZWBGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771257166; c=relaxed/simple;
	bh=WtNg8/l1eqg1/NegOwlpY7SzuGpHu6ScT3AQG3qCNFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZCru+dduvHiZzMOWx6xlVJ2byAgI1Xv81blt+E7GSzb6UJ0fpYh2+Kpdpq+oUmRDQR+83yDIR2euIPUwU0B25KqZ+YsZzDXkKYlM4/XpCBRMWKptb4/MZ4iqAcaF2XTVvbCk9DGiVKLqsHTRpyS+sDsx5CiSxBmtun3pDqnydnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bh+MUeF0; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bh+MUeF0"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-64937edbc9eso2829047d50.2
        for <linux-iio@vger.kernel.org>; Mon, 16 Feb 2026 07:52:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771257164; cv=none;
        d=google.com; s=arc-20240605;
        b=U48O1J1GE5qlIgmSK87YuuvHU9BCjDybgBwIMfEf1Phn/mTHvi0LFM9Qe6OyI8pOK/
         cFLqDlNBuz2D3x4L4mDDvcRwFFLQJSW/qKBmSCh8T7UmLgK3A8OFOxMJnk9rG+1QluBy
         BnqXmUQtRofV3Qu52/fLwxKli8/lRzIV06+9o0U7IX7S+W4Wr/eE16duA9KGYKpM5Y+v
         gVaq7rGoZptTyjFjvrJG4I5yfbJs9BqJzE6e+VMTNsYm3wBOucwRdOUxg5nBntmyuGXd
         pfzG5zYzVVKtaKjdrkVwNESXEsOnR56Aka2Ls8DDUJUtawdXNX3W3bKvAbF6QxrtIe3m
         edDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ot2mU0yu83xeq0xqLkly0xKYSkvAdLvXToIN6WuukKc=;
        fh=VZAjx4EyuQ31LaI6fiBcNxMgXunCXWLQNiAazybl/kk=;
        b=Z5EBw9LGh8htoCaJNw8i8RAn2of7+w5jELdizzx+kIi7IVakZiZdrvfdEz+rHXiM0j
         L7faaCPuAMkUaizbDtSVtReu+snvRlfdJ7pKNK4FRvQkvcWmf3fVsFjbWtDW9wv4PHgA
         dC2zwbruO9MlstTA9PR+xk3DhU0FKApB4Ihal7HkhWtq1rxa6nnSkS3JMU+ODX1Hxr3p
         CrfS3NCckwrjO+onsfuiOVUECv6NWnh3kbBXjL9+jC10p/zvPx5YAtAaL7gkxytEOyLL
         9fkkGSEpvZw+DH6yvJCh834HuntmDCdzNExXJn6h8893kTaEiZu5mYhCvkgHFNj6QuxC
         S8kA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771257164; x=1771861964; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ot2mU0yu83xeq0xqLkly0xKYSkvAdLvXToIN6WuukKc=;
        b=bh+MUeF0t+pF9ZXbH9J6R+jYIdRAmwh4whXAcbOVXkcczA7qEBdqxaOu6CNmqTUibe
         Bausm6mjPfgZEeghxkrnsVhO3op14FYJI+GiLF8ifAFP0Ts3/7pkqoIBVrcv0eAT3H/K
         c9DOvJwT0zLCNiP7cV3Cr074n3dbsuE29Dh2rGQCA++wTXHxIbGDSyMGsQJV+hFzcXMt
         yXR2Owx2mYoRaiQRcat0o6feNS8rFLKs3euBSzOHoF2zIk8ebJkPfGUgomqNDq50kKJd
         U8HpX1sS7GO3JX0C/76VyZfgo9jPr6DWhO0kHv47lWwmXxeehpfBM1h8hn3TxAl/QRqR
         QFmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771257164; x=1771861964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ot2mU0yu83xeq0xqLkly0xKYSkvAdLvXToIN6WuukKc=;
        b=EPqyRQGzQi89Ru4NAVF5zLzX/Kl+7UqY3GjkZqe0L4U/Edx3N3urfHGSqAW0GzHhCQ
         ul5jinogYoOs/UygiJ+YN4B7MfFnIKdJmJOgXHkGVFDcmmYP6U6wOys91zlmTWZ4/ZiH
         HAdWd3UEg9+U3DIF1Lx5Y2JNoD8U/XLhhXIZo8k7wGgN/mz6AY5KrFl6mVA4o/A2FXS7
         z32yoWoHzc+Uq/UQCa3NzVCxcy0brgus81iLO41XPGIvUU8FLN93qRTqDRWunmLEYwzv
         vyhFe/kmbZcbKpTLjIkogXUIsnMGp8sC/WajLrr0zlj2IHM176UvTm/IMigkff8F0S60
         7I/w==
X-Forwarded-Encrypted: i=1; AJvYcCXoh/NuAPJ9MUckG3jHHxY+QTNJ8dfwqQgy3yfvBV48VZDvyX/XhNthxPwGJ/2Txo8yM5QctN6k610=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlYaaeZCEuFokZapSkzVJRSYTeQAwom3nltCzskt/7ig3VHjG4
	mednuJMpxPuCmX07G9ijKEQbyvsJR7OdPsPji3TShkNoeXuIZVrTcf9KKmU2B2LX15Bz5xLPqY5
	3FLIkABj15Hb0322Hj+6V77zx4hHSbJU=
X-Gm-Gg: AZuq6aLTtgYNq6a0A/WUBnaZQE+kgfRyzjPx/QLJ46sNgqebg66sg//aAlti8c4LXKl
	IBGRJD1YXB6PV9HzKSupsVzW/H5uRxGnHQQosCNPJmO4SPVlg2A4yi9OEE9D6G76Sus5Y7hAyd0
	DVppuK+Gft2Jy9Eig+FOB752Wc33ifg7c8pf/v467S7a06+81+7dx9MCLyZtCvpKySQ972bao+G
	vu0NSfkSLOqrzPcqnkgDBfXqUQBPscM2y3G/74cAzfMEpq1s0naPYJ8JxFAuFkPjlo8nHoyUIXQ
	Dfovz92zmJwVQedcKjsvmcsKq+xsGzmZN5K2g7/A+Q==
X-Received: by 2002:a05:690e:4146:b0:64a:db1d:2d57 with SMTP id
 956f58d0204a3-64c21a44454mr6338152d50.2.1771257164397; Mon, 16 Feb 2026
 07:52:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122145633.14938-1-architanant5@gmail.com>
 <aXI-ZV4uAd5GyFLz@smile.fi.intel.com> <aXI_HnvDNbX68-lq@smile.fi.intel.com>
 <CADJHxWB3b+bH2+HBP+SG0jxhGNcozstBeWeDH_3dgS-4c2G-6g@mail.gmail.com> <aXJmYAZ-8KkXCFI9@smile.fi.intel.com>
In-Reply-To: <aXJmYAZ-8KkXCFI9@smile.fi.intel.com>
From: Archit Anant <architanant5@gmail.com>
Date: Mon, 16 Feb 2026 21:22:32 +0530
X-Gm-Features: AZwV_QhGPY-D69MH0lGVyOerHPtqCOXaIaKC2LSoy8MQRUla2KLfpWELTuP0yyM
Message-ID: <CADJHxWDCer97pMNHV-69B9AEVY0NfimTcxo8k8yFBbstg0wMQw@mail.gmail.com>
Subject: Re: [PATCH] staging: iio: impedance-analyzer: ad5933: use div64_ul()
 instead of do_div()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com, 
	gregkh@linuxfoundation.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Gentle ping on this.

Has anyone from AD had a chance to confirm whether the original
truncation via (mclk / 4) was intentional?

If there are no objections, I can prepare a v2 using the BIT_ULL(29)
form as suggested.

Thanks,
Archit

On Thu, Jan 22, 2026 at 11:33=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Thu, Jan 22, 2026 at 10:27:52PM +0530, Archit Anant wrote:
> > (Resending to the list, apologies for the private reply earlier.)
>
> First of all, do no top post!
>
> > Thanks for the review and the detailed math breakdown.
> >
> > I agree that `(freq * BIT_ULL(29)) / mclk` is algebraically superior an=
d
> > improves precision.
> >
> > However, regarding your concern about the original code:
> > > "why the original code drops precision, was it deliberate?"
> >
> > Since I do not have the AD5933 hardware to test if the register expects=
 the
> > truncated value from `(mclk / 4)`, I am hesitant to change the logic in
> > this patch.
> >
> > Would you prefer I:
> > 1. Stick to a purely mechanical change (keep the logic equivalent, just=
 use
> > `div64_ul` and `BIT_ULL(27)` for readability)?
> > 2. Or proceed with the `BIT_ULL(29)` simplification assuming the precis=
ion
> > loss was unintentional?
>
> I definitely prefer #2. That's why I plead to AD people to confirm.
>
> > I'm leaning towards #1 for safety, but happy to do #2 if the maintainer=
s
> > (Lars/Michael) think it's safe.
>
> > On Thu, Jan 22, 2026 at 8:45=E2=80=AFPM Andy Shevchenko <andriy.shevche=
nko@intel.com>
> > wrote:
> >
> > > On Thu, Jan 22, 2026 at 05:12:42PM +0200, Andy Shevchenko wrote:
> > > > On Thu, Jan 22, 2026 at 08:26:33PM +0530, Archit Anant wrote:
> > >
> > > ...
> > >
> > > > > -   freqreg =3D (u64)freq * (u64)(1 << 27);
> > > > > -   do_div(freqreg, st->mclk_hz / 4);
> > > > > +   freqreg =3D div64_ul((u64)freq * (u64)(1 << 27),
> > > > > +                      st->mclk_hz / 4);
> > > >
> > > > It can be one line to begin with.
> > > > Then drop that ugly castings and explicit big shifts.
> > > >
> > > >       freqreg =3D div64_ul(BIT_ULL(27) * freq, st->mclk_hz / 4);
> > > >
> > > > Now you can see That 4 is only 2 bits, so this can be written in
> > > > simpler way:
> > > >
> > > >       freqreg =3D div64_ul(BIT_ULL(29) * freq, st->mclk_hz);
> > > >
> > > > which may give a better precision at the end of the day.
> > >
> > > It also might be worth to add a comment on top to explain (with given
> > > context
> > > I don't know if there is already one on top of the function, though).
> > >
> > > And I think we want AD people to comment on this and maybe explain be=
tter
> > > the calculations done (and why the original code drops precision, was=
 it
> > > deliberate?).
>
> --
> With Best Regards,
> Andy Shevchenko
>
>


--=20
Sincerely,
Archit Anant
