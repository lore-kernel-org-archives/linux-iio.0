Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:47643 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752314AbaBXRFD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 24 Feb 2014 12:05:03 -0500
Date: Mon, 24 Feb 2014 18:04:53 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Ge Gao <GGao@invensense.com>,
	Manuel Stahl <manuel.stahl@iis.fraunhofer.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	lee.jones@linaro.org
Subject: Re: [PATCH 3/3] iio: imu: inv_mpu6050: Add basic support for mpu9150
Message-ID: <20140224170452.GA3748@katana>
References: <1391596475-21986-1-git-send-email-manuel.stahl@iis.fraunhofer.de>
 <52F623AA.6020905@kernel.org>
 <E7747D604FBC9F43A71AA431AFF44762104C3FB8@IUSEXCH01.invcorp.invensense.com>
 <201402101939.46467.manuel.stahl@iis.fraunhofer.de>
 <E7747D604FBC9F43A71AA431AFF44762104C57AF@IUSEXCH01.invcorp.invensense.com>
 <52FF5D61.4080506@kernel.org>
 <20140215133934.GA2579@katana>
 <53031B17.8030608@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
In-Reply-To: <53031B17.8030608@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Seems like overkill to introduce an MFD for this little addition to a fairly
> large (and likely to grow driver).  Its a little ugly, but would you mind
> if the multiplexer is just handled directly within the  main driver?

I guess this is the pragmatic solution for now.


--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTC3u0AAoJEBQN5MwUoCm2ncAQAKuFfgeQnZjpkJf6UAKu6n0v
zZJvb3Oac9nTheC4u6zZq69moRxwBPW/A06CNdmuNhdFPbXHUdfJXv6QeFVhdkPO
nzqgeQau+03eOQORLIIW0zmmn8+GYGx5gAsaWTkeiEsH2NzH2aRuIiBjaNoejBuu
s/XsPO1Ibbn0OZKOOIdAc7VvqbOKIFnBGPuE3ytzc+MuLgUk+9ORPAYSzT7RVxsg
VF3XkJzilprlGLH11qY2E5GvwhXKRcx24HjeH4UvCLN9Ho2/5G1PtgSrGCwD4zKy
2JDY19YxU7JsZH6oLpb487fcXQij9e07D6ta3OGVZ0Vh2206cyKU0o498gD8Ymeb
RnfY/PTFsuWNn9JCAWSyZZVegBHFO2Mprd+vGnohYlAp4wpnNOcHVFEjHr5Vwv3L
v/yL3weYNwVUblad/YVi+yG2winASHduH0EU1+VjoEn6z+8G8LIApCXGWJEN6UzI
HSm0hIvk9ZZ8RfxwNGN4PZyyZ82kgfM5j1FX97ZEuMk0YfP/wV6bBZwlmNP+tYWI
mQp0ZrLkIjsSQ78aQWyRECU3gCOwDzhF/gLhRG33fNvzTvSRPK011Y/pjoBwHcsV
8ajCzl1K7Nb9Gn0NvCRzHMPqfhjdX5df8qI0jKNexVVg/gZQx0A3jZrroqEs1abT
psJWhfwtLosEhTqbXPO1
=kFfy
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
