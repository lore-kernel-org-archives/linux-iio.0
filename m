Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B6235A927
	for <linux-iio@vger.kernel.org>; Mon, 23 Feb 2026 10:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771841380; cv=none; b=s53tiKBvKdgsqSkfCeTxMLvVEbcK+MMEl5EtP2LlYmMug9Lo306CJFR6eb7LvOeKQ6XdvhVoV40YVPwLCZK6WJZ4X2uHTyqYOp2dwZnjd4DPQcGv6q3lkpv5GE+I6MKAVtRcEyB5imaJhxKtKfs0lYTaDJmFtwG1sbxrKAj+Ex4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771841380; c=relaxed/simple;
	bh=Ky3jcIBbGAp358Kb7hZKDppR/DA4Xry1FogPtt3x2sE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FMYnk9OESCm1BzmGj9lXjZCueR9z9M74hJ6lPecwS50gfZfUjmyD1fo49RyRNE2+2bTrJARnYWKUQ/kh0hNIYptVFlLAZNj1jlM54k65nqWGWC4BTHshHOH+QYizKk2WTWf3alN+12gqGt9tf9fUxY7a0xoEBEtcVcxJBz/YO00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YaZ5atst; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YaZ5atst"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4834826e555so39712435e9.2
        for <linux-iio@vger.kernel.org>; Mon, 23 Feb 2026 02:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771841378; x=1772446178; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y3U0wiZ1PaLP9HKufniCA3p+26o0xtDqndh6mBEwyx0=;
        b=YaZ5atstiuyyX/KZ4RGNr8CAywUBCCig5Wo62ckOMjU3Ar02DldYn69p7x3kgXyS0S
         gWClepkcbbcupsiVSlusldMOEVWNxCTcN6V7W7LvwAmasazxHXvic6YyJJf6ATOSOzur
         bh0SWGvIh7B+pKF+1P3iKhXN0GiCgsOfbpgkLKWi4C8P1XO1X0G0IXlIB71KZk8RiDq0
         IhuGbODNEdkycFjdKIHlKTmNnebWIBRc7Syt9Mw2ntlYUmsi3F4Q7a9ODtnf4M2YiULq
         IHde9fhM018Mc3nNuiz+UgvI7DMmj22TrusJmUPSppNC+uqz62pqIWuW6Gr120WqPufw
         tLNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771841378; x=1772446178;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3U0wiZ1PaLP9HKufniCA3p+26o0xtDqndh6mBEwyx0=;
        b=d+DmWmK8qOmBdd5offr3SHcIEyDCfYbelFGtXKcKOsVgDRd4HH1K+YQH84/wj9h45D
         mNBYnvqUkFnLxHb9DRyl2ivP1W5MjcqV0kZCW2B1bryFIupur9QGN99wDqere+kGmXMS
         if6Z/96s3dvd4oQl6YtmDgE4iMlbwomKjKBpM40/F8QxyW51W78CxnCKo58Xir+xIdV0
         BN1C2sjg6WfDld20W9HamqEozARY/CB75f3ey7FNWDW9gusyj2O61cSVW+XvuD2Ddldi
         N+Eo2VXWSB36Jd6BFapS2qecQEgol3Z+UnnG5gd6A8rToILKINQT9Cm6fNpTa39e5usg
         HWww==
X-Forwarded-Encrypted: i=1; AJvYcCV48lD9RScJubf2xbRANAUiaLUJe1NzMUDErkNMemGsjvSKbGBAhM4KTqXSU/WdSpUH3WplW5bRvec=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkfSvHo3jQDAdZknv3VsKpfcM8PVd3MtXoctmdh1rhrdMccWLS
	kpDoSB9pQwIAO31F+GfFRnKhuurfuboNPToOv4Z4FtgHxuEh6oT3Fza5
X-Gm-Gg: AZuq6aKPXwmr4St2MCKV0+7+5n2dOS3hLZ/HfVc057C7AJ8lQYOgarsZVvuUX6WcK3/
	uyLzbAKHSXclAdOTUGY3YkBbiN+kUqcGZUWOh+LbU/FIBtn5/DeAY2/NBLh5/tqZbH2rF6MrnJd
	bwaQdPle8e9SjjG1B78fUrI4evgzpCZrEn6BzFhBDvp+f7zc4qoiBfrT6c7xQOuOnuWPrJUTHhi
	mg29uM76wlAifge9sUbbksbtFzbwYVxM9exrYK/wwwi3q8YA3VcGDnK4EKnqyPgeOTI47kYjGxk
	so/pGQgOIAOXuD5UYXwzbwJKPWeJpg9VahXKSbTzB3aowpK0XEEhSZWMbDMyxDy39w0Kk8EprOn
	u8bhA+895dSBsk7qDGjTcqbUOp2oA72pcr9c9+Ap42Bz2x/VI9nH71k9iCzIlD8RzIpLvghVG9m
	hRrhTOO+YdU0sdTSmzpDkVcBxeWAqYnO6nCGviqaNKnA==
X-Received: by 2002:a05:600c:34d3:b0:47a:975b:e3e6 with SMTP id 5b1f17b1804b1-483a962e175mr136244295e9.18.1771841377468;
        Mon, 23 Feb 2026 02:09:37 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31bc068sm245815725e9.4.2026.02.23.02.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 02:09:37 -0800 (PST)
Message-ID: <d1a1f8af14fd515409805f1071c051fb51206b1d.camel@gmail.com>
Subject: Re: [PATCH 2/3] iio: dac: ad5706r: Add support for AD5706R DAC
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Jonathan Cameron	 <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=	
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring	
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
 <ukleinek@kernel.org>, 	linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org
Date: Mon, 23 Feb 2026 10:10:20 +0000
In-Reply-To: <aZiSVSvCOS4MvcGt@smile.fi.intel.com>
References: <20260220-dev_ad5706r-v1-0-7253bbd74889@analog.com>
	 <20260220-dev_ad5706r-v1-2-7253bbd74889@analog.com>
	 <4fd329ed6416fd2f8e2a72adfa5a77f73107948b.camel@gmail.com>
	 <aZg-vtenBU2rKKX_@smile.fi.intel.com>
	 <a6a2fc3ebb45fa4d7b379d552196d56eb13fa8d3.camel@gmail.com>
	 <aZiSVSvCOS4MvcGt@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-02-20 at 18:56 +0200, Andy Shevchenko wrote:
> On Fri, Feb 20, 2026 at 03:02:37PM +0000, Nuno S=C3=A1 wrote:
> > On Fri, 2026-02-20 at 13:00 +0200, Andy Shevchenko wrote:
> > > On Fri, Feb 20, 2026 at 10:48:59AM +0000, Nuno S=C3=A1 wrote:
> > > > On Fri, 2026-02-20 at 16:02 +0800, Alexis Czezar Torreno wrote:
>=20
> ...
>=20
> > > > > +static void ad5706r_debugs_init(struct iio_dev *indio_dev)
> > > > > +{
> > > > > +	struct dentry *d =3D iio_get_debugfs_dentry(indio_dev);
> > > >=20
> > > > It should have:
> > > >=20
> > > > if (!IS_ENABLED(CONFIG_DEBUGFS))
> > > > 	return
> > >=20
> > > But why? The debugfs is a stub when disabled, nobody should do that
> > > in the cases when the main purpose is not the debugfs code.
> >=20
> > Because the compiler can then optimize away all of the above code...
>=20
> How is it different to the code elimination part that is inside in each o=
f
> the below calls?

Clearly none :). For some reason I thought it would matter. Maybe I was mis=
taken by
some old code that had #ifdef guards on the debug code.

Any ways, I might send some patches cleaning some places where I added the =
above so
people do not copy it around.

- Nuno S=C3=A1
>=20
