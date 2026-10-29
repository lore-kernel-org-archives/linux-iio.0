Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.161.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793240368;
	b=IpXzZ8FU9gk1CN6zWlCJ5PItcl3n7lIvXV1gsdmDPWRXyVijaKZ4s0/YPpZ6WrMo3L2W
	 rAjlbQdGhQNJcYxm4ylU2SLMAjXC3dHimERjw3IKgYe4SpBWJPAaraRy95ZKOdkYxRu2b
	 ZXPziF3ZomhzWhhrZdGuTp8FwOO+ZhH2g1DHccmDCJx260c1ld6MxEbcYhkoyF89oLrul
	 NQ59FgOTBUm8Wp4c6kum/sp0X8bE9mxBTxakHzWcNqwS/LFvtFQHW85tQjHjCNvK7ibwr
	 f9huHvBg1Fj8BI5B4Bb5mcho6MLHWdhUe/V6JQf1l7yYpnmTG8hEsvHTmIMCgeB/hvg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793240368;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=/LiOfXWRHjUDgLhmT1WvxPVPa3QavCe7SpY0favJ9tc=;
	b=m1MaY2MpIjvQw4Lv/dh7FNRKkOKvslNlBDL+arTAqq77ekfp2IUbpbOoVHFuLRsAqR+5
	 2v/Hf/mkoTY9TbqB2D0KIDaQd0UXajA6pgd68s+xF6JPiQc3oIucZju1S3v1gLXoP45uJ
	 dPl3fYLrFesxrakG2Fca1ETnfwjS7DZNaYN2or0gUjuSQl5r9DTDWmgF0CCezqIpFd2va
	 cNMOzKuyi6bFcPZHAaF61fOyfoAhCOEjDmEv56FGTThllMoOgo4Tb54b5M5ITvI9H4Dfs
	 hPm6FDZf9p/cuhzM8uIAkLrU61aX+fHHxbi7yXMFcIzBMxUhSDs0VqHG/RI/P+ftI0A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j84zXx65;
	arc=fail smtp.remote-ip=209.85.161.50
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E82606A31A
	for <linux-iio@vger.kernel.org>; Thu, 29 Oct 2026 02:19:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4E82606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j84zXx65
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6dd7070699eso1329080eaf.3
        for <linux-iio@vger.kernel.org>; Wed, 28 Oct 2026 19:19:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793240366; cv=none;
        d=google.com; s=arc-20260327;
        b=IJy70ODmTHgdMBerq++sRlKqy0B4+v0pFtZUkXRDk6+/jKJ3/LSmevB7jbBHySr4BU
         /OiGiy1qdJKbxWhlD4H38IVQZg/M84exaJDGlfstiC0BB2nswFCLKw65DyXAeS+u/zI2
         R0rqY8JWfdlZvy3hjCPUk9vzfxamDEBJyoyJq7Pkj2fqHBU7U5ggipBeZB28MiId3ahW
         B464PD/OzgOR6WH7tMgZdSPV02g/pM7jtCuRFoYR8wVJ4zr3L0r3/KzBkiA8z2OUX6+p
         8t9iDM62FfAgNyEuaK2JGtj2/uteqiIieiujFf8nT0lkOv3WzoOhpcCnEfMdceo8R3Ra
         RsRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/LiOfXWRHjUDgLhmT1WvxPVPa3QavCe7SpY0favJ9tc=;
        fh=ibHTxUIkeiqgmdE9MrEPV+FFjawQyYNV6lGkLlePGfI=;
        b=nVrewPtU13t1Q8Irui/myUTaxbsaQZW1+ruyqZbF8rH1twezaKpTas8mFKhgMY5h9C
         cGpARA+aO2toDBd61vGeFtWc79L+sE9hjFca7upI9X2Q/QQkC3diy+NGhAy0YrUKPTio
         IapVeG484W+ZxZh4u/IeO09Gao2ZsyapHzpSlULZrRcs3YsgXfn333G/kPm5+1D/51su
         I+vMIqeijKVvUsQe0Qed3SDE4g4TryPv+0tA6YmQX+aV0WseGiUEjlGrHlaxDYrcxN86
         dJxVUTZdA5woEfqqaEuM99ovxmecZMb4gdV8r5ltML+XZeY973cOtaehHwe+bcIOuIfR
         HWjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793240366; x=1793845166; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/LiOfXWRHjUDgLhmT1WvxPVPa3QavCe7SpY0favJ9tc=;
        b=j84zXx659Vk9rM2x6lrM1tdsePSk4pdpzHRtnrW1nXb4Nsb4f7ZH87bcfqhCY0I1Ne
         D5vfvn9+fFjEbF1mzik6+c67LlccrlaFqbNdBSpyBSYb2Lp0r1589MY6K3Qvdjqe6WHp
         m1nFcJnmYiEBGfFcilJAEiEf2A4iXA5tLq4jGeCTqGDQuyISFoshfXRIXc8R4Q7Fhd+4
         6zYo30I4UmDIOjjo2NWg6t5zYYPkQ7WMO7WG9cU5+0+qygmSOSiz6jrX5wzsPAMXeJc9
         Ikam7P+XLUbKSvg2ZS90r3yBhYe8G+O2Ythgs/fAmJ9uArlV4Pu7evCxpAAwkJBqElYu
         NHtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793240366; x=1793845166;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/LiOfXWRHjUDgLhmT1WvxPVPa3QavCe7SpY0favJ9tc=;
        b=eXi+G1GWCNSPA3CH9aT+SkjhamtEDUw2EzZP4F7f/lxgM0/bPvpBt3YKtK9c4s1uZr
         OKcf7ecDgtdA7M0jISn7MnbAwaxP+pbSpPUu7vGrXvCadL58pugUGUyjqDnpF26bQdEz
         klYX2glvrYsi8ViULrHS4m4NBtFeJd4d4Su+agoLiOiU31IM23TXDiuDP7ZBeUmj4d7z
         GNZ9ZhIAGMIzYkayYEDzWVoIsOvH6Llr4NzlenLUup1W7IXCr+5XgwhDyeKHASyxfgof
         ZFmTOewbgfjTSjc5KJX91CnS4vKgrgxufbypnN/oriNclTqijoA2FhXBKUDObm5CtBjK
         uc0w==
X-Forwarded-Encrypted: i=1; AKwUvByCHzc9ji0cIN7/s5OVaZIzHCxcXxD6eG5MeYzcqLQ/meAGy267RCPr+/Jj7SNGbINy4RD3ULoMnzk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLxDU+DnBunFdSLTZwxTTJrJAjbble3aVCT9InuwpTIcLFvLqqN
	H3oRRklM7X03GnLxQkVEBMU6AEpqeOQ21A8TkkrSvwpXBfsQoRHshdv2LZqnYl5iNACdUExDoSL
	yIH37juFUTaKWGWqs7Ze0/Kn4EftFVEA=
X-Gm-Gg: AYBFou1LeoWyd1p4dbmsi26zLU+i7VoOb9rVnxqDLOUOdojSPlpnqB1khAYVe5GMENg
	UPNFZ92xM89Zbk9ibl1eyvo0GpBzgUQyu+vAwCD2cET6o4TsF5SwX18gkPZ5t2pd0DAzdTrNyA9
	mtQNhqYk3CvYlPTrqsf4rTXo7+gc06UOSmCsMEVJEZlBcc7SkZGT0d5ARTqluDOUR2+OYp8XRhy
	cSSBcQnFjOSLi33BvEc77M4qKmTZSEY73re8EYKQGv6HdbsHDIJ0aOPDlfWLxqXNR0WSbQqu+uZ
	AkmFKi96TuJuJY/+KTR5TrovpMI2Z3japO4ZZUcnMCiUlirr9zag4JRogmY2NC9HU9vlHExShFk
	2Fmt5zQQBVq+qv7BUIbkf+x4vt8kreTOAFOFeSapeyW/hUY1LVsCoJKIFGt392+9q3XjAB4sig5
	V04FV9+IbEOJ9HjND7BqpfpFuJd6o=
X-Received: by 2002:a05:6820:1501:b0:6df:2b6e:d57a with SMTP id
 006d021491bc7-713f04d5ab3mr2650404eaf.76.1793240366413; Wed, 28 Oct 2026
 19:19:26 -0700 (PDT)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020-tf-luna-v1-0-53a88f93db24@gmail.com> <20261020-tf-luna-v1-3-53a88f93db24@gmail.com>
 <20261020092316.00003339@gmail.com> <atcbe2O6REJqok2n@ashevche-desk.local>
In-Reply-To: <atcbe2O6REJqok2n@ashevche-desk.local>
From: Vidhu Sarwal <vidhu.linux@gmail.com>
Date: Thu, 29 Oct 2026 07:49:15 +0530
X-Gm-Features: AclHuK-sDGs78YBOmA5Mf81isBK3M5HnFRdgXc0AbERqvLh0UlNiIFbXRQ4I_GQ
Message-ID: <CAFqz8L+fCc19aaUhs6k0a47y=oxhiM9PSgjMgjY0JYH8HN5wKA@mail.gmail.com>
Subject: Re: [PATCH 3/3] iio: proximity: Add Benewake TF-Luna LiDAR driver
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Joshua Crofts <joshua.crofts1@gmail.com>, 
	Vidhu Sarwal via B4 Relay <devnull+vidhu.linux.gmail.com@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, Oct 20, 2026 at 10:42:51AM +0300, Andy Shevchenko wrote:
> > > +static const struct regmap_config tf_luna_regmap_config = {
> > > +       .reg_bits = 8,
> > > +       .val_bits = 8,
> > > +       .max_register = TF_LUNA_REG_SIGNATURE + 3,
>
> No cache?

Hi Andy,

The only configuration register the driver writes to is MODE, once
during probe. The other write is only a one shot trigger, and the
registers read afterwards contain measurement data that keeps
changing. also need to read MODE back from hardware since the sensor
can silently ignore writes that come too quickly. I was planning to
add caching later along with runtime PM to restore MODE , but I can
add it in v2 if you think its better added now.

I'll also address the other comments from you, Joshua and Jonathan
in v2.

Thanks,
Vidhu
