Return-Path: <SRS0=4Od0=NW=jmondi.org=jacopo@kernel.org>
Date: Sun, 11 Nov 2018 16:38:08 +0100
From: jacopo mondi <jacopo@jmondi.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	linux-iio@vger.kernel.org, Jacopo Mondi <jacopo+renesas@jmondi.org>
Subject: Re: [PATCH] iio: adc: max9611: convert to SPDX identifiers
Message-ID: <20181111153808.GB5996@w540>
References: <87bm70yt67.wl-kuninori.morimoto.gx@renesas.com>
 <20181111130915.57fa9aa0@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WYTEVAkct0FjGQmd"
In-Reply-To: <20181111130915.57fa9aa0@archlinux>
List-ID: <linux-iio@vger.kernel.org>


--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Jonathan,

On Sun, Nov 11, 2018 at 01:09:15PM +0000, Jonathan Cameron wrote:
> On Thu, 8 Nov 2018 06:42:43 +0000
> Kuninori Morimoto <kuninori.morimoto.gx@renesas.com> wrote:
>
> > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> >
> > This patch updates license to use SPDX-License-Identifier
> > instead of verbose license text.
> >
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Normally I'm against anyone making SPDX replacements except the
> author or someone who is otherwise doing substantial work on the driver.
>
> As Jacopo was working for Renesas at the time I'm going to assume
> this is a Renesas wide change and apply it.
>
> Applied to the togreg branch of iio.git and pushed out as testing
> for the autobuilders to play with it.
>
> Thanks,

Thanks, it's fine with me!

Cheers
   j

>
> Jonathan
>
> > ---
> >  drivers/iio/adc/max9611.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> >
> > diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
> > index 643a4e66..917223d 100644
> > --- a/drivers/iio/adc/max9611.c
> > +++ b/drivers/iio/adc/max9611.c
> > @@ -1,3 +1,4 @@
> > +// SPDX-License-Identifier: GPL-2.0
> >  /*
> >   * iio/adc/max9611.c
> >   *
> > @@ -5,10 +6,6 @@
> >   * 12-bit ADC interface.
> >   *
> >   * Copyright (C) 2017 Jacopo Mondi
> > - *
> > - * This program is free software; you can redistribute it and/or modify
> > - * it under the terms of the GNU General Public License version 2 as
> > - * published by the Free Software Foundation.
> >   */
> >
> >  /*
>

--WYTEVAkct0FjGQmd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJb6EzgAAoJEHI0Bo8WoVY87rQQAIFyxnT0Ko4dBitub//OVF2c
ogQs67cqLQ4FCYAlMgHvaRqKXMtwWIOpAtGUswO6vGFBFjKcjYbHFrBIWYBvDFZ3
fPh8f+gmP+r8KnuENd4h6ryyEJeKDLlC2kopR3igYQmNFvpuV++tnd4UosT8KjG8
rEGs8MYVLpqPrFwohWf0u4WtvTXxxjn0+JKnj1s91goP/Xxfdn0wsZaVBp+W6Pwl
1unNZmZUmo4RMqnX5qDzJ0IPJRn9ZEctt+KXgKIt8XUSAMjFbQnxDJMEeeoMndV2
JSj8O9WDxoMnIKnhjV5SKKzyy6+zvSPd8et3TH2TsVcbmt9Oy9F1xdNDoQqH5pZ9
qpTLp8onoR8QEspJUGRHiBB0w3XJ593SQbuLeOSkCO4wfTjaDpnR/UP1LxjkhmkG
RQpruL1MIgAd+AgLdeZhmVs1kXUN9zaK77D+F0SYKEfVa6blXVFh6cyRwNjoOYZb
d4hKJDk3WLMnvpuYbCmPQE7SGEt/veGp2cXyufejt7ug2Xw2+RbRAGFT2XUzOAqi
s+hGh+w+fx0/HJS3CMoDERXW3p0UnRMk2E0dpnbLELfX9t62PmfSGdSDaF/EOJWS
6XuEb3xRY3C2Ln91RNz+OBLkq6UdgyexKR+AgnwrpvUfZaWjB13fh3RO4Bq0zaJS
laLXQPMS1BHbMS7XHlkO
=WqYy
-----END PGP SIGNATURE-----

--WYTEVAkct0FjGQmd--
