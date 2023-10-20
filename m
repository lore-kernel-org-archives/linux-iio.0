Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5487C001DF
	for <linux-iio@archiver.kernel.org>; Fri, 20 Oct 2023 14:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377523AbjJTOZT (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 20 Oct 2023 10:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377541AbjJTOZS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Oct 2023 10:25:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E991B19E;
        Fri, 20 Oct 2023 07:25:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58324C433C8;
        Fri, 20 Oct 2023 14:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697811916;
        bh=PdEijCCqs6eHOgtQhlQOCpXG95OQYCeSQG6gEQ7o8DI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lUXt4nGeVKfkLYINAkezPy4TTl+guqDEdZcvzJYBSgiUce47Jv9fT4vleQGb347hL
         0mRCqPg8ZUy5xNQH6Cgbc+NN+lt6o3GdLgTzAxMD+zcwR7tcu3QhFZgAB+jHU6A303
         N94o37HNrhkm+gSc3Y79EKXmwWt7kDRbMCaAjkn7vf7ch+ZxVZGxlDGwQ9XvxiIkTX
         eQMVkUUkicsDhJhCI+pdmgU7nzbc82Bh+W7eK9bHbxt25GpSRXVoRRr1a5BWvrFvVZ
         REZ0O9gfOJpsmXosl/HqwVnIb89ES3YyGpPkhLKgT1U+qyl4fELy35l5KhGjdSCZUx
         u+5Ap3etRhIxg==
Date:   Fri, 20 Oct 2023 15:25:12 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        matt@ranostay.org
Subject: Re: [PATCH] dt-bindings: iio: light: Squash APDS9300 and APDS9960
 schemas
Message-ID: <20231020-clunky-tummy-290b557207fd@spud>
References: <20231019080437.94849-1-subhajit.ghosh@tweaklogic.com>
 <20231019-rematch-ethically-9d482ca4607e@spud>
 <20231019-theme-clunky-f4a2e1d122e7@spud>
 <0084ddad-d6fc-ca26-2d26-ba71e81f5f8b@tweaklogic.com>
 <20231019122120.00007cdd@Huawei.com>
 <20231020082804.5ee8364a@jic23-huawei>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zYibD16LsXD1wAkk"
Content-Disposition: inline
In-Reply-To: <20231020082804.5ee8364a@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--zYibD16LsXD1wAkk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 08:28:04AM +0100, Jonathan Cameron wrote:
> On Thu, 19 Oct 2023 12:21:20 +0100
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
>=20
> > On Thu, 19 Oct 2023 21:24:09 +1030
> > Subhajit Ghosh <subhajit.ghosh@tweaklogic.com> wrote:
> >=20
> > > > Also:
> > > > <matt.ranostay@konsulko.com>: host aspmx.l.google.com said:
> > > >      550-5.1.1 The email account that you tried to reach does not e=
xist.   =20
> > > Thanks Conor for pointing this out. Can you please help me out with t=
his?
> > > get_maintainer.pl suggested me to add this email ID. =20
> >=20
> > Matt has moved job, I've messaged him to find out if he has a new prefe=
rred
> > email address.
> >
> +CC address Matt suggested using going forwards.

Matt, can you please update your contact information in the various
places where that is relevant?
A mailmap entry would likely be a good idea too.

Cheers,
Conor.

--zYibD16LsXD1wAkk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTKNxwAKCRB4tDGHoIJi
0nXMAQDYE5epxVgzgquyXUK1kk1YWiueaHq6K0DNAuiLEVp26wEAnz0OpIWfRtU/
mWIgZMvTCNkGnCQs+Jt1y5/UabKisAQ=
=MWsb
-----END PGP SIGNATURE-----

--zYibD16LsXD1wAkk--
