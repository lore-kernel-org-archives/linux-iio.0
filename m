Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EC432FA30
	for <linux-iio@vger.kernel.org>; Fri,  1 May 2026 19:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777662296; cv=pass; b=rXUHyr93vb3EP4NuTTJBCjgnG1g9Z3YyOyfMxoAx77BzbIjGlKbHmfWTll7BxXnOGvzuhvVedJQbvz5gby/Brlg/bqdwfYa5GRnFyPrWyW7ZrbNO01xq9Vu6+As/0+FDl1JLytnJkD6ppOyjXquVE7gHGWrZdmu5IERVj6j0zf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777662296; c=relaxed/simple;
	bh=4EvmkWFiD+YkJjzcUgYpLWNr5ZQbkf9hyc3U3VTQrgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZYNR0nGC606gIj440HW0oU9hD5YXZp/jbfAfWeTIuo8BCUm1r6bFIiS0U3LCxfv2DzUwH090fOfjeMMk6Cjxpe7IArdQJs1t/t+/6yLsBkyIwt24jt8ua7Zfatjb8jI0a+Sje6A3ESgTI8QJYb291sJDC1rz7LvhBDz1kV7Ls+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjtjKJoP; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjtjKJoP"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7927261a3acso21053037b3.0
        for <linux-iio@vger.kernel.org>; Fri, 01 May 2026 12:04:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777662293; cv=none;
        d=google.com; s=arc-20240605;
        b=lE7YZ7rLmQr8k2Z6X0DtGk6lh7Q6fZP5C71cZTgs24Ff8EerXaRbQy72AM2FZFOY+P
         5M+yxqzetA2efI2fQWX9pEKTrecA21KIZThFrTmmfLbuCA4hUMGzqfWzFrhkGbX7o8gA
         wY3fljx+BiU21q14xe/sQ3suygiupn2l8pJM+h29Q+/Jy8ZiWvZnbn0MocVLGnC0ZaBo
         iu6AxecYMJy4PTSZENSle/vCgG/GTtHXA/9DtyP1sNlmYwM9Y552qcNMHDMBRuCTmwN5
         4IhHlBp4Ggjw5KiCi2y1rMOvVids9Zbf/Q0nTNQxb+RPWAvQs59yGgg4grduRr6MZGVV
         7ffQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4EvmkWFiD+YkJjzcUgYpLWNr5ZQbkf9hyc3U3VTQrgA=;
        fh=ucBVJApzXRyRT5mV+tDeQEzUGkFe/sg1docKk7/Gltg=;
        b=Y64WmZLkk2Ln2iyig62/JfaP2raG+LE7LL6Qwm/PoqPoS79y/X4eu/PC72Lt3RMDYj
         TFw/5wqH9uZccSlLCYFWKpAdskeQdRlcqFAKMjCZQnfeXLvUBmmDuSp2p+jOcVeM8+K6
         0aYFVbfw8nxxAotY796WyMzzzSGlk+TRm7uYNCEDfbn2aPdxfCkjPCtNPFQb8BletbhA
         gwk5XR28ygIbFqUCOkAb8Z3yR7CKhpXXivvNmP2OSkRB/7AZC5nL25ausohSQoDMhR6e
         /0bKUZyAdm67TigkmTnTtxNGb0oJisnLf28mh/qQJOpunvqT2Emt008g74KeT0GNc3LD
         SR3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777662293; x=1778267093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4EvmkWFiD+YkJjzcUgYpLWNr5ZQbkf9hyc3U3VTQrgA=;
        b=WjtjKJoPS4+yAo3LGhsojdNjiIFU2wtvAMCkbwuMSL6WblnaUF4UZI0CW7iCTy4jos
         79im2XqT8xqgectE1FMJLHuaR+Fuao4FxxQici3Pbt7GICTIPgwo740MhaeBdEyNV0LW
         6bRuP7u71xsQXXaoGsUaeFjc1qIeGeJg+wrn+SgiAZlx/YYzAVvyyAAfLVWthlLdH9pb
         Nlb3Qu7mtOuJ1TEjbS/m/lxdbWmLuN6qlMeDnW0Xf8hry/Eioj8rqaL4CPUvHvdmcovq
         41YrSCOQgGkImKS4O8BP84xkCiYTYec6C/RS8QenI/4wmgNrFlh2JhvRrF0+c1h0a7AX
         WtuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777662293; x=1778267093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4EvmkWFiD+YkJjzcUgYpLWNr5ZQbkf9hyc3U3VTQrgA=;
        b=pgQ10b+UVSfVSy6+m/OmYb5B2n7QWr55g/0ynmeK2soziTphKZXGVsMZv1qIwuOQpz
         qIctZtccZgrb1y62MCATAQ8JqHRiE9kfQHAlTO02EpkzcfDE25f8i8PjoiRLVGr/fsb8
         rLeYlcIMZ1R6aRcpv1hfNsmTPhz2gDwwbwHFoMLdX7QHb09l6qdzYRcQf9p87RFrFPoI
         fwd+cGF+zLr9vXbg1TLpqHeoj4P70cLT/sAzQXcrb1ZgM+wE4EwPpyvb1UHdDeig6yIO
         HbV3t0sgIzzgeZodpwaRA4LvqlDWJ4mfffiHXqVEn6qY8jDTT5Mz2yd2n9GWnV18cCgv
         Rl7w==
X-Forwarded-Encrypted: i=1; AFNElJ9NmwWU3TjaoyDWyHv8XYIYgGcpzqalxzkIHCMgcZE7fIZES+b22TGqFfVbK1snBh0vIYQs3+Me8ic=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsMFRGfqi/vmTFebr4MzUgpTUIwFbYbuf47JXLpiM698MnzzMX
	D85p289txKr3uRQBV1yImLTFnc6HRvidPD+OY4aVtClSPo09himXNyBHW7BHzzKeqnizm34YjtV
	iT7nMYsOp+eolPEKCcIP3Vcv5o59KMEg=
X-Gm-Gg: AeBDiesrhtEqhCT00w4A40WdxKsF2B6ghgCKnD1izOXL9oQL6DsOZQhtQUNXN2IDJWc
	ODJhQZxvtdaFH/3H6zJOH2X9I6Nn752RZWvFh5VC9R2uEr3X2HI85lb4qlAAdyRR8D7zwNyKSXp
	6xAbpBmjG8kFCDDIvQmGPJ8lp7g+lsu/aTJKvT95A31y6MZdQ8iCloFVsLQZ5tOc2R0T02mmktf
	vfWfrEhI8OzuND2lmnf0thQ3RvR0D+u9+gkxkP6WljXK5LtErDBU82g4TzeMJiFdJ6IgNv8S2r7
	8rrmbKMJb41yPHBgLCrE
X-Received: by 2002:a05:690c:e3e8:b0:7ba:fd82:9105 with SMTP id
 00721157ae682-7bd7710417bmr7103417b3.29.1777662293420; Fri, 01 May 2026
 12:04:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430200515.7915-1-guilhermeabreu200105@usp.br>
 <CAHp75VfsEkAWfiiNu0xPLLPN_1KLdxfoY_g+mv2bQRkgQpfyUQ@mail.gmail.com>
 <CALoEA-xP8PUpLFWwGrohHPUSC45jJhNuD2db-kFFo0AoH8SX5w@mail.gmail.com> <CAHp75VcVmhO0WwFwUL=hfXsNd=_LaXMBQS+zTx4UpC8RvKytQQ@mail.gmail.com>
In-Reply-To: <CAHp75VcVmhO0WwFwUL=hfXsNd=_LaXMBQS+zTx4UpC8RvKytQQ@mail.gmail.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Fri, 1 May 2026 14:04:42 -0500
X-Gm-Features: AVHnY4LvCoPZOftNNWtDOj4kSqS5RlNgIbyXDYIeJJJl5rYj47oWgdanFBSy66c
Message-ID: <CAKqfh0GrkjGOYz=yH0M+ez+9Mze56_t_Xy+p1+mzmWdU6y3YFQ@mail.gmail.com>
Subject: Re: [PATCH v4] iio: gyro: adxrs290: Use guard(mutex) in lieu of
 manual lock+unlock
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Joshua Crofts <joshua.crofts1@gmail.com>, Guilherme Dias <guilhermeabreu200105@usp.br>, 
	lars@metafoo.de, Michael.Hennerich@analog.com, nish.malpani25@gmail.com, 
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	=?UTF-8?Q?Jo=C3=A3o_Paulo_Menezes_Linaris?= <jplinaris@usp.br>, 
	linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 1, 2026 at 1:49=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Fri, May 1, 2026 at 9:37=E2=80=AFPM Joshua Crofts <joshua.crofts1@gmai=
l.com> wrote:
> >
> > On Fri, 1 May 2026 at 20:15, Andy Shevchenko <andy.shevchenko@gmail.com=
> wrote:
> > >
> > > On Thu, Apr 30, 2026 at 11:05=E2=80=AFPM Guilherme Dias
> > > <guilhermeabreu200105@usp.br> wrote:
> > > >
> > > > Use guard(mutex) to automatically release the lock on scope exit,
> > > > simplifying the error handling path and removing the need for
> > > > explicit unlock and goto-based cleanup.
> > >
> > > LGTM,
> > > Reviewed-by: Andy Shevchenko <andy@kernel.org>
> >
> > The code is still missing a <linux/cleanup.h> include.
> > How does this even compile? (kernel.h does not contain it)
>
> Ah, a good point. Yeah, if that header is missing I dunno how it might
> be compiled.
>

Doesn't device.h include cleanup.h?

Regardless, cleanup.h should be included directly.

best regards,
maxwell



>
> --
> With Best Regards,
> Andy Shevchenko
>
