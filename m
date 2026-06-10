Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E8633B6D3
	for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 14:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781101953; cv=pass; b=tA3q4YYdyAOBMlQarvE/BbWx1jE9agITlG+jrW/HvRSYu7cAxIoyC7wVGp2PahSjxNypasOpK7sEIsnc+gt4pP+gKZRbyoq3ZBUOXpd9YN/WtHNjxk5Nj3JNi6J93moCLtEGiXgk1NQn8qkRTGPQxG1MWxRg8Ee8IXFQwlOvTAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781101953; c=relaxed/simple;
	bh=ES4Wwnm7LDTekDfxBkRjueXtU+JExOHrirYIoXL7mMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rqoHqdCzT8k3seltqwwaNK+IJIjZgwwS1bXaDj/5QtPfgpi5Q+nQZlSRz1X5j+TYPFQpUVEmYxrMQHKUhfSrdGkqxEFL73syjE2AAOQ7fznjiLvN3j6YzFUbqxfxTtqiR65ZVv0KbnL3seZSxl2cS9j/TUi3aT/VsRWiULdyuRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WFfICjz2; arc=pass smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFfICjz2"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-304c520fe9aso2186792eec.0
        for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 07:32:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781101951; cv=none;
        d=google.com; s=arc-20240605;
        b=Nfw3zT90GeGW2PMecO/t4CO1YQ9L7Gx1RJ8J1HaowhnfncdJF8QfjwNH9Q4/NktNoE
         67u7wuRsr3rgAsQWZmQU2eP+7PsSH4ymFuToqz+nhLbDyha6RH3a9lQHs/Nrur5f+lQE
         P8EuPZqCMDpJYt+ocPFiDIL6DUmueJ9yMWkk5Gh8ZaiLa1Y8UIoQ7ByJrtWYu7AiHess
         C18LK5Icv1cc2oGO/R80mVuHdh9WvASL6RWC/gbM8EsDdVFES4ymXwO1j3GcTkaitC3T
         c5lh69GRCdAiN7gIGu398/bVGHxHIKxRazPHcJQVphuJt7Dp62O8gOo0zlf9ldoXzx3v
         06kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oYlaQ1NUVVCcD2TPrqOfDsKTXd5iB9hu+Glwj3KNaZ4=;
        fh=7OM8vwiqH/W4tENQ469U9Z/nBsX5dVFGAe3balKW4IQ=;
        b=kqidbtMtS7J6OFrxUX2m73Or1tizMgUJ/dYyQQUt4v750LEeqt21OWwTyXHzvdTYmm
         tf7hSkEY0f4RjOGELz/7cc+6poT1X8sil941mvU9UquS8nrBJ/TwQ4540I3du+c+IyDZ
         RAcdIob33d6ZBHp19IPB/niOrJ6jftp/2ZZVzGLfOz5tUJnfzItnc6xrVNAf2M9PAge3
         P69CCUfUx0YzI0MI3TBr9lLquA3dQOgq+fY81+s5ZUa1ZzO5lWoN27+cw+xmxHKKkJVw
         4Com8SOO5mKo1tpv/iJnNq7X5cVl3RtgWSL85KvJ6XsUYzmXSDs/6kWHVaFlAcubq3JE
         FpTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781101951; x=1781706751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oYlaQ1NUVVCcD2TPrqOfDsKTXd5iB9hu+Glwj3KNaZ4=;
        b=WFfICjz241T2kl0XBGu8welhc92Wlr0xtBHWITgpIxMHe5DxxLf3s5BWWcXF40Xct6
         DrvQRQNtctSuTLpSt0XKQtpeKOMV/lQcK/UvwFeXNjn58A0px0zqWy+yvwvzd5LMmEYX
         mgPRZFEgtH8pZsOaQdbUlGyeI/lmOxLN9cIAZLWnYPpLijeRi/9z+aVo5dChJ3yYHZWx
         TtiLfrcb3JcHBjf/RXCLb4KPIBxjVQ0LTSWoe9A9ENoedrCLZMrUGAR5UZPoW5xv1ta0
         LI5J7MH/UfQFJ2bFvddlrEMHUSicdIIpUCEsQ2tt4o2yFLWF7f3YdQP7G4W0Fa3Xbp2O
         V1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781101951; x=1781706751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oYlaQ1NUVVCcD2TPrqOfDsKTXd5iB9hu+Glwj3KNaZ4=;
        b=H2z/w6R+CFa+1Z93er653M5uQ/o0zTqUeyVUkN9eYumKuQEBubV4iwYR5lQrcAyOFT
         DAILoFuKNL3JKpT7byfLWEn3eaKnYDCxO21R+0e2NJOqFbL54l1tDqffHksaYHRgpK0z
         RF9mzYarDrhs0wqDUuU2d109pjD8SAyIcOLbATo7hHwIj9wL4rG18Kb9gHVGdRL6Jb7B
         ZqIIXSGzxpCPIVbxG57Pd5ZC1vMn6cJKd/IzDW2CwCBVm2nRhjUhc5GbZN2KrZrZpQwt
         gFzMwmfGZMNMeMHdRlh9v9RXJKPG4KKP0Y48ZANc7YEP7NB5K0TCLhLVGjKshiI1auST
         D8VA==
X-Forwarded-Encrypted: i=1; AFNElJ9yKmSXTy/iumSA8UjFiq4EJ/aiGiGnGRCpNGtr0DhsMjXyqVf7c52Y1RRbdiht3UIgHYHdp4BmXiA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyum0H4gyfRggf2XxOwGIYu3lBOCrpZfhqQ1oQFB0yA4vIb1o74
	bsXB6NuDqJMwf4Kvj4E/rR0Ycr+K5pEK2I3u+dEVQYOEM9Rm4lZnGfQ6DzpBfmEJawZ89B2UcUw
	fsnv0lq8WKzzkdCiqdb0cd2IeY5UvzCI=
X-Gm-Gg: Acq92OEtS2tfGsj0lJYAP49AHtBeSYpOywSutknjTY+VD8RNKYwCTyhE2VXRE4B/g95
	Td4xC7QkwSgAWJoolfL8RZsNBxHF9d7rHJbFjWWIKBY0wr61P6oi/hFZivsr21+50h9r6m6iw2w
	jyl0QcyX97rMVcpXXcGZxamNMRLPWoXrM7U2b1ggutJUuqV7CiSdHkJvEf8qXTqsXwxT2D4lvRu
	AZd+4V2M2OdJXQf7Zp+WbGvhlPc/+V6R/oxETGkSVxGqkktM2314BSMq7IfeZz5R4Un5h9gmpIl
	ZDc63WH2bgTOEHbQq+I=
X-Received: by 2002:a05:7300:7304:b0:2be:2cfe:68b7 with SMTP id
 5a478bee46e88-3077b3c7767mr18495535eec.11.1781101951047; Wed, 10 Jun 2026
 07:32:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260606045738.21050-1-clamor95@gmail.com> <20260606045738.21050-3-clamor95@gmail.com>
 <aiPDzdKuccdLIvlF@ashevche-desk.local> <CAPVz0n2rdgw8Xr3uxVdQGwrHTNFqK4SKQDFU2FEB8LzLwPhQ_A@mail.gmail.com>
 <aihjVZ9xvM2BRFu4@ashevche-desk.local>
In-Reply-To: <aihjVZ9xvM2BRFu4@ashevche-desk.local>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 10 Jun 2026 17:32:19 +0300
X-Gm-Features: AVVi8CeI8hlh1GbQ3AYGIMwG28HB2xx8su6lqiYAmfvLYDOtgithK37JF5bkrak
Message-ID: <CAPVz0n1fHWCpHN93v-dKfzGYhvB-dC1E3JgQmXpvfr6bGNLqcA@mail.gmail.com>
Subject: Re: [PATCH v4 02/14] mfd: lm3533: Remove driver specific regmap wrappers
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>, Johan Hovold <johan@kernel.org>, 
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 9 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 22:02=
 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sat, Jun 06, 2026 at 10:22:43AM +0300, Svyatoslav Ryhel wrote:
> > =D1=81=D0=B1, 6 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 0=
9:53 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5=
:
> > > On Sat, Jun 06, 2026 at 07:57:26AM +0300, Svyatoslav Ryhel wrote:
>
> ...
>
> > > > +     ret =3D regmap_assign_bits(als->lm3533->regmap, LM3533_REG_AL=
S_ZONE_INFO,
> > > > +                              LM3533_ALS_INT_ENABLE_MASK, enable);
> > >
> > > In cases like this perhaps leaving mask would be fine and together wi=
th
> >
> > I prefer to remove intermediate variables it the helper allows to
> > directly pass needed value.
> >
> > >         struct regmap *map =3D als->lm3533->regmap;
> >
> > next patch drops lm3533 so there will be als->regmap which IMHO is
> > more logical instead of passing entire lm3533 to child devices.
>
> Still it's longer than map. A local variable may help with making lines
> shorter.
>

Introducing and assigning a local variable for a single use regmap
operation seems excessive especially since next patch removes operator
chaining leaving only als->regmap.

> > > this be nice one-liner:
> > >
> > >         ret =3D regmap_assign_bits(map, LM3533_REG_ALS_ZONE_INFO, mas=
k, enable);
> > >
> > > >       if (ret) {
> > > >               dev_err(&indio_dev->dev, "failed to set int mode %d\n=
",
> > > >                                                               enabl=
e);
> > >
> > > In many cases it won't increase LoC count.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
