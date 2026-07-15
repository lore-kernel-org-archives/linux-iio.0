Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE8E378D71
	for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 14:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784125565; cv=none; b=p+YP/67QHF8WFK2qTT9wadtccPIQBSKCIztrPfSqcHjTO4pfhw3shU9N3odEQ3RWA3FtV5730tTxpqNA/T9fUwVqkdidIa4KgF6LfPW13ZJH5kPJF15omVXPPteu8jtYNIUALdGukRUrJvYByOVCf2S4Mpf+aR8+ADqb7NY0/WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784125565; c=relaxed/simple;
	bh=KDg6y/VRh0fzXIGdR9844R5VIP6RvFEHoi8boxQALD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O2iIySP/sxOu9PIacRsGG+Y7/33rfJEUbUvMTWx4tzwR6J0IGiWQx1UtPriClyU2xkPeK6Jgc3Vpw+s5NwAwPvk62vQ/NawEg1ZTeYeyaDGZqgis0knkq3PBVL6PXh/bjK7quHAsvR5HNmW+bkubZsDTVjwpORx3waQMnAVgx0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lT+pZg9Q; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lT+pZg9Q"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-69e28b554ceso374026a12.0
        for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 07:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784125562; x=1784730362; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DfRoD+O3mIvLnBy5agZdWlJiUBWYTenY0lfFk8hTVeY=;
        b=lT+pZg9Q5FcEnsWFGmhiUTGsngqtfmFmn+fOt9Ac6BsJVy81e486CxPEIb1o6rCqj9
         ubAMyJy7M5IFnmc5Sk4fXUO+MMZytra/9+or1NiK9WmH/uJ4oWXI7hdExh2b4JQXKoBm
         gEEDlcAPSgACH0HMW5UZC3nNXqH1Eiz6aT9AIWq2Ufg11l+BEXB6bk726bwAeYawQcA4
         dDTt+dNYFRBtq68wkfJ0zohPY0cj/QAKEOlUowE5/jFQgE0jwpn6zgPpVPOe/PN/EOhk
         VOaGc/XTAezvtTkePQTZCZkCFfqz0Y9P7EaUtvVeOWzyDdR7Oc2WQbxckZuZxZx86uPu
         bpZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784125562; x=1784730362;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DfRoD+O3mIvLnBy5agZdWlJiUBWYTenY0lfFk8hTVeY=;
        b=EgHOOEdhw3SnzEXLeaU7f2gLWyje15dSQ0UaDbKehuIsYPkpCs7foO8Hjqmn8SaZty
         WrU8qBFkZtyNfyqOUX3jZ1I5RStVUZCE+eyR1yGrPNEpsT0dCetKg5sxdTQ/rXjZF234
         tkS5oNPJWIMg6+/MMd05VVhHnj1wtRF7lJjUmTRdy2swQ0wjFRjAaFKNQbYGdyDHyE1o
         ftPB1W4j5GqTgZbGGY2uzNmzuqs5kyIefILApci3e0DX7E2OSsoroKiX4mRbuzjB7ZSN
         VqiAITQ/aI8oFrNcfmv1pBLC5zMj0VFEcVB3UI4ZXAot0tI6wam1uzHKialDQAHvfix2
         zxdA==
X-Forwarded-Encrypted: i=1; AHgh+RoZoFJUPGz+JINHet+Tx4FTM3WcZylZWPJYicNQUGOdKef08HtqnEQO/PGFTaf93XA+P6LrRbu3+64=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEe63W+CUVJohXgAZaqKOX/GtuhK+hzt8FI4JDayrFC8Tsru9y
	hk3Hq8xt77ZRcthwOv3llMDlihMRgQKg48SlKyox0FBWhmgolpVH6C+Z
X-Gm-Gg: AfdE7ckzsBP1/tQLgm4LWZaEj22L60KikeStIGvSsZSi5Wgu6FNlnwMxw6Wph6mrLNS
	rmphfHej+HTUpAEt9CQsH1gw31hluHzCi/Jy0D3QyE62hKwjQsJfvy03mZaM1SnRNtSJfZf4fr/
	3fOVRM/HjCf8rNDOa2orI1AVl5RMranOr/+B0b8ARVFxJd20l+Qrhot/eDZQ3tjb9aGPy9KE6cp
	sZfQeKLNQgeHkFZ37Rnjv9FRDZwRZy0wduBdofFCTHRHkHLDpooE8hKSGjuZiu3bRDyFf89n/H9
	E1/QN2uTCculbCXclsOR9OBjtmNyzz177IRmhfqRYUzUvhdD7vMqo12mG6vURVtXpDq0TQmbeZn
	k5ZeKIazEOK3HdAHMvjR9tJHVQRBQ+5f59Yi3ItI+3G/T9Jr11zczo9OHLbi2v4Guq5Sctgsnp3
	SelmndogzaUjlxBbMlE8KWSLmUwwc=
X-Received: by 2002:a17:906:f5a1:b0:c16:12ff:dc8b with SMTP id a640c23a62f3a-c161f3b58ecmr970705666b.54.1784125561706;
        Wed, 15 Jul 2026 07:26:01 -0700 (PDT)
Received: from NSA-L02.ad.analog.com ([137.71.226.102])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1687317c58sm39978566b.36.2026.07.15.07.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 07:26:01 -0700 (PDT)
Date: Wed, 15 Jul 2026 16:25:58 +0200
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Esben Haabendal <esben@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Nikita Travkin <nikita@trvn.ru>, Maslov Dmitry <maslovdmitry@seeed.cc>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] iio: light: ltr501: Add ltr329 driver support
Message-ID: <lax5ggtixwejynztwul5brnkciq4gq5scbd4cuoyev2w3hgcti@dflf7hnw4rgq>
References: <20260715-liteon-ltr329-v2-0-d18af55edab5@geanix.com>
 <20260715-liteon-ltr329-v2-3-d18af55edab5@geanix.com>
 <Q-ueoELrVUGcnBAEpAJE8z7yejEFFfSQBfk5ZeoZgVu4Cf1NwcMQRiRH-cvknalrNQBzoSJDMCG7w56-0MrHVw==@protonmail.internalid>
 <6vro5bil5b5j72rigujnm5zj4ot56rtwgs4fvn6xydybxpi4rz@vrc6p6bbkl3m>
 <87ldbcmkr5.fsf@geanix.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ldbcmkr5.fsf@geanix.com>

On Wed, Jul 15, 2026 at 03:43:10PM +0200, Esben Haabendal wrote:
> Nuno Sá <noname.nuno@gmail.com> writes:
> 
> > On Wed, Jul 15, 2026 at 02:27:25PM +0200, Esben Haabendal wrote:
> >> This adds support for the LTR-329ALS-01 chip, which is similar to
> >> LTR-303ALS-01, except for interrupt, which LTR-329ALS-01 chip does not
> >> have.
> >>
> >> Signed-off-by: Esben Haabendal <esben@geanix.com>
> >> ---
> >
> > Hi, I have a small not below. Kind of personal preference though. But
> > what Joshua mentioned should be addressed. With that:
> >
> > Reviewed-by: Nuno Sá <nuno.sa@analog.com>
> >
> >>  drivers/iio/light/ltr501.c | 33 +++++++++++++++++++++++++++++++++
> >>  1 file changed, 33 insertions(+)
> >>
> >> diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
> >> index 7d045be78c6d..379e57ac5f5b 100644
> >> --- a/drivers/iio/light/ltr501.c
> >> +++ b/drivers/iio/light/ltr501.c
> >> @@ -15,6 +15,7 @@
> >>  #include <linux/delay.h>
> >>  #include <linux/regmap.h>
> >>  #include <linux/regulator/consumer.h>
> >> +#include <linux/array_size.h> // for ARRAY_SIZE
> >>
> >
> > ...
> >
> >>
> >> +	if (!ltr501_has_irq_support(data->chip_info))
> >> +		return 0;
> >> +
> >>  	if (val < 0 || val2 < 0)
> >>  		return -EINVAL;
> >>
> >> @@ -1257,6 +1270,18 @@ static const struct ltr501_chip_info ltr501_chip_info_tbl[] = {
> >>  		.channels = ltr301_channels,
> >>  		.no_channels = ARRAY_SIZE(ltr301_channels),
> >>  	},
> >> +	[ltr329] = {
> >> +		.partid = 0x0A,
> >> +		.als_gain = ltr559_als_gain_tbl,
> >> +		.als_gain_tbl_size = ARRAY_SIZE(ltr559_als_gain_tbl),
> >> +		.als_mode_active = BIT(0),
> >> +		.als_gain_mask = BIT(2) | BIT(3) | BIT(4),
> >> +		.als_gain_shift = 2,
> >> +		.info = &ltr301_info_no_irq,
> >> +		.info_no_irq = &ltr301_info_no_irq,
> >> +		.channels = ltr301_channels,
> >> +		.no_channels = ARRAY_SIZE(ltr301_channels),
> >
> > Instead of playing the above game with info vs info_no_irq, an explicit
> > has_no_irq would probably be better. I mean conceptually if the pointers
> > are the same, it could also mean that both are with IRQ support. With
> > it, I think it would be safe to leave the .info pointer as NULL as it
> > would be always overwritten.
> >
> > Having said the above, so strong feelings about it so up to you :)
> 
> Calling it has_irq would avoid double negation. But we would then have
> to set it to true in most of the entries (all except ltr329 for now).

Yeps, that´s is why I proposed has_no_* :)

- Nuno Sá

> 
> I will give it a spin.
> 
> /Esben
