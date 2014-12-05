Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:43349 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751081AbaLERtM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 5 Dec 2014 12:49:12 -0500
Date: Fri, 5 Dec 2014 18:49:07 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
	linux-i2c@vger.kernel.org
Subject: Re: [PATCH v2] iio: imu: inv_mpu6050: Add i2c mux for by pass
Message-ID: <20141205174907.GA7025@katana>
References: <1417734625-13739-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <1417734625-13739-2-git-send-email-srinivas.pandruvada@linux.intel.com>
 <20141205070313.GA1197@katana>
 <1417795398.1851.17.camel@spandruv-desktop.jf.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
In-Reply-To: <1417795398.1851.17.camel@spandruv-desktop.jf.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> > Since those two functions are only called once and don't encapsulate
> > much, I'd rather put the commands directly into the calling functions.
> Agree. I will move them to the caller and submit another version.
> I hope, I can still use reviewed-by tag, after this change.

If you only change my comments, then yes!


--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUgfASAAoJEBQN5MwUoCm2QgYP/1CUgRfIsxFnUlIaU5YgHmeI
cyTGRNZrsRo0533qEldJguA3ddJwffJWbQkseBg/kXQWMDxrCuPrvK/7ovUkoEXk
VifHEove9trq3uOGQNN5FTmaKpYTi4HDuDyOyAinMApzxkWQj6LqWXz4f7nHDtv/
WY3Qh3ddU6arx1+U5s2AAkXZzu4Q8rjR7EktIUL3tczC1ymc6Zm0HIxDLHDmqK1p
hj3v/XUQ9X6ELPqcNPXq51B0zVbL74NWPzoQCEXmTj204WL3akxdJyLYk2NevJJM
69FmsQVajEWQVEhjPiQ7sl4y7n7mUCqLn2O89yk4bYElfFpp3IsJxfMSUP6rdjRX
tPKMhiBdX0fYmkr+IXFsBAiMUdiYA2ukV9LF62OvuZSiytZDzMJKe/YEqqnKmMx7
Jvzcr9nk5Lig1aUbwzmOxV64mC/Nec8QkPf+7C/mrcUZ2PasgpKVepTkKMbKXlIV
8qRATGq2xtR354QMrXseT6L2DV8c6T7pzE+zjLzkkx1y2I0DiX+87+tuvUyCFE20
Qg5vUG5z6e++IqS+HD3v+wpdrcGDCqwvKYo+e5vbZvSJCT50SE3A6VGKCa5DGcyo
9WQ4EHggnLWI/JBkmnmNcKMArL2f0ROaSy0qbXuIDJs6l59TZ6Ee2G3mJGS6XR8c
CE6+okyAe2lgQv1fSPy3
=ztP7
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
