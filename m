Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:51275 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753451AbaGGOhk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 7 Jul 2014 10:37:40 -0400
Date: Mon, 7 Jul 2014 16:36:00 +0200
From: Mark Brown <broonie@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org
Message-ID: <20140707143600.GA2469@sirena.org.uk>
References: <1403287927-30031-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <53A6E6D1.7090507@kernel.org>
 <53A78159.90400@linux.intel.com>
 <53AFF4A5.2020505@kernel.org>
 <53B0225F.6030704@linux.intel.com>
 <53B025EF.5060600@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
In-Reply-To: <53B025EF.5060600@kernel.org>
Subject: Re: [PATCH] iio: accel: BMC150 accel support
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jun 29, 2014 at 03:42:55PM +0100, Jonathan Cameron wrote:
> On 29/06/14 15:27, Srinivas Pandruvada wrote:

Please don't use my Linaro address for upstream things, use my
kernel.org one (which is the one I always use for mail and is in
MAINTAINERS).

I'm also having a bit of an issue reading the mail due to it not being
word wrapped.

> If we are dependent on regulators to leave certain states, do we have access to how long
> they take to start up?  What about bringing buses up...

> Cc'd Mark Brown on the basis he knows all sorts of hideous corners of the kernel way
> better than me ;)

With regulators the delays are handled transparently in the framework -
by the time the functions return the operation should have commpleted.
If there is a need to have a non-blocking interface we'll have to add
this.  The delays can be queried with _time() functions.

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTurBHAAoJELSic+t+oim90WoP/2FbPaTUcglsvRatPmnD8XnM
PZu754a0ulyU5Oy2zzQPfXuABzV2YycMFw4koce6wBc+dGQrEsslAr+AA0YQREEB
TN1tBHZ1ixS6SaAQBNF4383NYqQvoHMResCUsFGPgJ989u6nXwGqJpQObQ4rcJcN
TpIDhLt5QS+2bDgNx6muhB109JW6OaZrstNM4R0DYPKPh2j6xBGlRVJBMZd3G/vp
e/wreIHYelqOPlC6iop22nFa55TH+L8fqH0FUWmqMnJb8kqkl0o36/JHQFS1952o
oliET0hsiKBfKSbQQ4PRfEuE76cHi8q1uyfp7gYeFGWrLcVGo8PkMkqDVCGmsR4C
4EdNYePlpVilUGp+HP5Lzbp1ssKaeVpg9HydNuctudZZs5BITCS7H3W67MAeRMfA
SHwyYtRXmAPc3OM7NGKp09LM9KP/2gaLiuVYd7ybInfwBDn/bHMi7nhwE2HKb7Ai
W1Eu6uVuXnTzEVsPYIlkSgKJhgFr6YXgJLdq9JhpZWHejvqgY9ANBMjCqickgKjg
XRrYNAkcZcfw6sahXhjEIRngM/1KWDzs3xNaNpfuk6e/ggVrCrMWoGwNCwQdwep6
ym+/8STRQpwq+OxxfOP6BhJMHqiTet7XNWo33cnpsdBAAHkEVK3pomr8/8TwY76J
zuoZGf6PJCnA4NOGNtQC
=ULDo
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
