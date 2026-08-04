Received: from mail-244107.protonmail.ch (mail-244107.protonmail.ch [109.224.244.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC2B39F168;
	Tue,  4 Aug 2026 14:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785854650; cv=none; b=ZjPFITwQ+1b5sO9bmnFMlKiUuSvoWfvx/mPJXCPJgLaeBnD2mTqGs5F0Vnd+NH6rOhBWL4ULUemAvmK6tHEhkwl3TOuKR5pKugj6NfG9geOGJxt7sfRlzST5j8g0+PlmVyfyqiATKEWlc9nHisbIoFV0oWC9k4WRdLFhAb2CTAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785854650; c=relaxed/simple;
	bh=tRCtExrDNycQl/KAnVn8BjSsdXGk5ty79EyIiX9CMl8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mlKeBjqg9bzObcY5n8k3+djmdqbKA+GWpCbQx3BuX00P9Icr8H83HhNI2kPnXEjmmPg5VOKHMIkV1vJxcZJnwC6nKWY1KG6eZI6cg/PlzivaGPQ2LVouZwNGV4B3Ozq1Y4/w07jpMx9MXFgy+o1NlCkMYmf8v9pcbufEgbmpkdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=VULEBSCS; arc=none smtp.client-ip=109.224.244.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="VULEBSCS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail3; t=1785854645; x=1786113845;
	bh=3in15dZVLlxJAE+j8ddyRNkSfPjTBhBwJNuRl15WtEo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=VULEBSCSFDmTrYu2ZUZBelXLro7VZZafL6B0A2h0fevCZC0fv30PX3fXioG1wEeBp
	 8RiE4dNvkqeWqPLc5ZO/1SLi6YKOG4RcY+S/4l+uozkLgKhkcwHYX18RNOV5WjLI1H
	 vw4G52rvYGYyRRRYJVKBI5JpVxh71iTzziCOO46zbWysHdKW8CM0kXBcGXI0iG252q
	 d0biXlAldn2KLQBuGL4mlOU290Gcfmy/eOMVGbCmNFDPf5UG5At1bBdwozSDhs9Ve+
	 TEjVOTlLmoJ1Qa9clOxhXL9iHRHt87ejQnarxpiMaYwL5ISga9Qy2S/7ll+RegKubm
	 7x50L0rII0tLg==
X-Pm-Submission-Id: 4hDxBW5qM9z1DDrp
From: Esben Haabendal <esben@geanix.com>
To: Nuno =?utf-8?Q?S=C3=A1?= <noname.nuno@gmail.com>
Cc: "Jonathan Cameron" <jic23@kernel.org>,  "David Lechner"
 <dlechner@baylibre.com>,  Nuno =?utf-8?Q?S=C3=A1?= <nuno.sa@analog.com>,
  "Andy Shevchenko"
 <andy@kernel.org>,  "Rob Herring" <robh@kernel.org>,  "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,  "Conor Dooley" <conor+dt@kernel.org>,
  "Nikita Travkin" <nikita@trvn.ru>,  "Maslov Dmitry"
 <maslovdmitry@seeed.cc>,  <linux-iio@vger.kernel.org>,
  <devicetree@vger.kernel.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] iio: light: ltr501: Add ltr329 driver support
In-Reply-To: <lax5ggtixwejynztwul5brnkciq4gq5scbd4cuoyev2w3hgcti@dflf7hnw4rgq>
	("Nuno =?utf-8?Q?S=C3=A1=22's?= message of "Wed, 15 Jul 2026 16:25:58
 +0200")
References: <20260715-liteon-ltr329-v2-0-d18af55edab5@geanix.com>
	<20260715-liteon-ltr329-v2-3-d18af55edab5@geanix.com>
	<Q-ueoELrVUGcnBAEpAJE8z7yejEFFfSQBfk5ZeoZgVu4Cf1NwcMQRiRH-cvknalrNQBzoSJDMCG7w56-0MrHVw==@protonmail.internalid>
	<6vro5bil5b5j72rigujnm5zj4ot56rtwgs4fvn6xydybxpi4rz@vrc6p6bbkl3m>
	<87ldbcmkr5.fsf@geanix.com>
	<Ouq1f3XzhZ5grFMyCxC8cEFbB3eSSXdVMwFQWynPlH_OezdqbjGeOQrNu0oM9NcPieYKgzdY-MnZLTFJebC9-g==@protonmail.internalid>
	<lax5ggtixwejynztwul5brnkciq4gq5scbd4cuoyev2w3hgcti@dflf7hnw4rgq>
Date: Tue, 04 Aug 2026 16:44:02 +0200
Message-ID: <87h5laaqtp.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Nuno S=C3=A1 <noname.nuno@gmail.com> writes:

> On Wed, Jul 15, 2026 at 03:43:10PM +0200, Esben Haabendal wrote:
>> Nuno S=C3=A1 <noname.nuno@gmail.com> writes:
>>
>> > On Wed, Jul 15, 2026 at 02:27:25PM +0200, Esben Haabendal wrote:
>> >> This adds support for the LTR-329ALS-01 chip, which is similar to
>> >> LTR-303ALS-01, except for interrupt, which LTR-329ALS-01 chip does not
>> >> have.
>> >>
>> >> Signed-off-by: Esben Haabendal <esben@geanix.com>
>> >> ---
>> >
>> > Hi, I have a small not below. Kind of personal preference though. But
>> > what Joshua mentioned should be addressed. With that:
>> >
>> > Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
>> >
>> >>  drivers/iio/light/ltr501.c | 33 +++++++++++++++++++++++++++++++++
>> >>  1 file changed, 33 insertions(+)
>> >>
>> >> diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
>> >> index 7d045be78c6d..379e57ac5f5b 100644
>> >> --- a/drivers/iio/light/ltr501.c
>> >> +++ b/drivers/iio/light/ltr501.c
>> >> @@ -15,6 +15,7 @@
>> >>  #include <linux/delay.h>
>> >>  #include <linux/regmap.h>
>> >>  #include <linux/regulator/consumer.h>
>> >> +#include <linux/array_size.h> // for ARRAY_SIZE
>> >>
>> >
>> > ...
>> >
>> >>
>> >> +	if (!ltr501_has_irq_support(data->chip_info))
>> >> +		return 0;
>> >> +
>> >>  	if (val < 0 || val2 < 0)
>> >>  		return -EINVAL;
>> >>
>> >> @@ -1257,6 +1270,18 @@ static const struct ltr501_chip_info ltr501_ch=
ip_info_tbl[] =3D {
>> >>  		.channels =3D ltr301_channels,
>> >>  		.no_channels =3D ARRAY_SIZE(ltr301_channels),
>> >>  	},
>> >> +	[ltr329] =3D {
>> >> +		.partid =3D 0x0A,
>> >> +		.als_gain =3D ltr559_als_gain_tbl,
>> >> +		.als_gain_tbl_size =3D ARRAY_SIZE(ltr559_als_gain_tbl),
>> >> +		.als_mode_active =3D BIT(0),
>> >> +		.als_gain_mask =3D BIT(2) | BIT(3) | BIT(4),
>> >> +		.als_gain_shift =3D 2,
>> >> +		.info =3D &ltr301_info_no_irq,
>> >> +		.info_no_irq =3D &ltr301_info_no_irq,
>> >> +		.channels =3D ltr301_channels,
>> >> +		.no_channels =3D ARRAY_SIZE(ltr301_channels),
>> >
>> > Instead of playing the above game with info vs info_no_irq, an explicit
>> > has_no_irq would probably be better. I mean conceptually if the pointe=
rs
>> > are the same, it could also mean that both are with IRQ support. With
>> > it, I think it would be safe to leave the .info pointer as NULL as it
>> > would be always overwritten.
>> >
>> > Having said the above, so strong feelings about it so up to you :)
>>
>> Calling it has_irq would avoid double negation. But we would then have
>> to set it to true in most of the entries (all except ltr329 for now).
>
> Yeps, that=C2=B4s is why I proposed has_no_* :)

The has_no_irq could also be read as a variable saying if there is an
irq (pending) right now. For that reason, I will go with no_irq_support
instead. I hope you agree with that as well :)

/Esben
