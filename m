Return-Path: <SRS0=emZ9=BU=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF4CC433E0
	for <linux-iio@archiver.kernel.org>; Mon, 10 Aug 2020 12:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50CBE20729
	for <linux-iio@archiver.kernel.org>; Mon, 10 Aug 2020 12:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbgHJMfn (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 10 Aug 2020 08:35:43 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:49352 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgHJMfn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Aug 2020 08:35:43 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id D562D1C0BD6; Mon, 10 Aug 2020 14:35:40 +0200 (CEST)
Date:   Mon, 10 Aug 2020 14:35:40 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Christian Eggers <ceggers@arri.de>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: documentation: light: Add as73211 sysfs
 documentation
Message-ID: <20200810123540.sdzbtpgwkyqjg6ag@duo.ucw.cz>
References: <20200808171443.114c8e05@archlinux>
 <20200809074335.23734-1-ceggers@arri.de>
 <20200810090054.GA8495@localhost>
 <4688751.agSyimv0uN@n95hx1g2>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="jvs7m357s4mlepiy"
Content-Disposition: inline
In-Reply-To: <4688751.agSyimv0uN@n95hx1g2>
User-Agent: NeoMutt/20180716
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--jvs7m357s4mlepiy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2020-08-10 11:57:46, Christian Eggers wrote:
> On Monday, 10 August 2020, 11:00:54 CEST, Pavel Machek wrote:
> > Hi!
> >
> > > The driver for the as73211 light sensor provides the following not yet
> > > documented sysfs entries:
> > > - in_intensity_(x|y|z)_raw
> > > - in_intensity_(x|y|z)_scale
> > > - in_intensity_sampling_frequency(_available)
> > > - in_intensity_hardwaregain(_available)
> >
> > Should that be hardware_gain ?
> drivers/iio/industrialio-core.c:
> [IIO_CHAN_INFO_HARDWAREGAIN] =3D "hardwaregain",

Yep. Fix that before people start to really use it.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--jvs7m357s4mlepiy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXzE/HAAKCRAw5/Bqldv6
8lWXAKCuSzegjhy/4xYA5ebKeC6eynYALQCfZv5D11TrJDXd6Iz2XCNGF8akEi4=
=ViiX
-----END PGP SIGNATURE-----

--jvs7m357s4mlepiy--
