Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:52817 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752753AbaGHNZM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 8 Jul 2014 09:25:12 -0400
Date: Tue, 8 Jul 2014 15:23:55 +0200
From: Mark Brown <broonie@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org
Message-ID: <20140708132355.GV30458@sirena.org.uk>
References: <1403287927-30031-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <53A6E6D1.7090507@kernel.org>
 <53A78159.90400@linux.intel.com>
 <53AFF4A5.2020505@kernel.org>
 <53B0225F.6030704@linux.intel.com>
 <53B025EF.5060600@kernel.org>
 <20140707143600.GA2469@sirena.org.uk>
 <53BAC744.3070704@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cUjMc5fB5G+GsIM6"
In-Reply-To: <53BAC744.3070704@kernel.org>
Subject: Re: [PATCH] iio: accel: BMC150 accel support
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--cUjMc5fB5G+GsIM6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 07, 2014 at 05:13:56PM +0100, Jonathan Cameron wrote:
> On 07/07/14 15:36, Mark Brown wrote:

> >With regulators the delays are handled transparently in the framework -
> >by the time the functions return the operation should have commpleted.
> >If there is a need to have a non-blocking interface we'll have to add
> >this.  The delays can be queried with _time() functions.

> We are looking at a somewhat tangential question here...

I don't think so...

> Hence rather than picking a given power state (deep sleep or similar)
> we want the control to be on capture latency.  Hence userspace
> can specify the 'worst case' latency it will accept and the
> device will hence enter the lowest power state, between samples,
> that it can without failing to meet the requirement.
>=20
> What I was wondering is whether there is anything similar
> elsewhere that you know of? For example, could we query a
> regulator driver to ask it how long it will take to start up
> a given output?

=2E..hence my comment that "The delays can be queried with _time()
functions - you don't need to implement the delays but you can find out
what they will be.

--cUjMc5fB5G+GsIM6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTu/DjAAoJELSic+t+oim9UyIP/ifpGoPmKjbspuy9cStswTL+
hM+wSo57RPdRzMyB/Cedg/rGYIei/it4cSLe90mZ1m+goRX75TLGoAMYVzV5Fmh1
xviw2RfPlBwdtYj3urIYNfAVjA/ILgIiixqukGCD7NXRqbvgCSdRfU6gijYykHl8
C+9sDK4DQd0aTwWUbvspF6MOQ/l3YdFurNQhXEhW0COvKI0sV4dLK9uJh52wJ4dM
f/AZO97AgjN4LRjv7wT6+83/Nz5E+wOjckUXtxoZOy6Z0XxooCLVd90NiJxqeblw
vwHU+FQLkYsEu6moSJ0dvrXyAfQ+Mq3TYWFoFEnm+e5vQAXmKOemT7sKd7QjO2Hv
MzvYjRiYcmZep5CU4tVimb+rH19/r7E842360rM+4Q5c8aN/QdLcxv9ugqVf7D7Q
8QwyYxOWwB4KZIKQoDxvQzpSeRYsWHBQxyw5U+jAM+91+q4gbQz/l2wIyoRS1e2m
Hm0h192yP41aa1v5Wd0i7dOv5bg24G+u3oVVdHO/PAIq5QkmE927XTB3+cet9MQZ
8lw2mStahn0aqaN8TxhqKlFyy3vpucxdfOqPfK9kPyvR2h7GMbN6VKuHOr+SXYJp
I/zgoVi+jfjcXvhEudWU5ho0hdWp89hXyAF1mDFjJXZx6z7XSzHCMA7kCKbdAiLF
/0a9eniPcbuvFpItznUb
=bCNj
-----END PGP SIGNATURE-----

--cUjMc5fB5G+GsIM6--
