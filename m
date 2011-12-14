Return-Path: <dan.carpenter@oracle.com>
Date: Wed, 14 Dec 2011 17:31:44 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Greg KH <greg@kroah.com>, devel@driverdev.osuosl.org,
        linux-iio@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH] staging:iio: Add wrapper functions around buffer access
 ops
Message-ID: <20111214143144.GL3503@mwanda>
References: <1323684526-11134-1-git-send-email-lars@metafoo.de>
 <20111213004506.GA11553@kroah.com>
 <4EE7145F.9040003@metafoo.de>
 <20111213235926.GA23916@kroah.com>
 <4EE87755.3000000@metafoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qo7zVO9a9OQ5oQtr"
In-Reply-To: <4EE87755.3000000@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>


--qo7zVO9a9OQ5oQtr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 14, 2011 at 11:15:49AM +0100, Lars-Peter Clausen wrote:
> Marking the function as __must_check doesn't make much sense here. Since it
> will either return an error or the buffer length. So you'll always use the
> returned result one way or the other.

Isn't that the point of a __must_check?

This reminds me of when we added __must_check to ERR_PTR() and
PTR_ERR().  We found places that didn't check.

regards,
dan carpenter


--qo7zVO9a9OQ5oQtr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJO6LNQAAoJEOnZkXI/YHqR5NQP/iC5x56N6hLXdxi+0rYFbVsT
ASvCLXNZuNk7mVMcPGcfsCLc21btbNHm8OeSKzcRQ/VQiRUV38L7bM1U969NM626
lBvO9qC70dNLFtOocOCJ2oLmWmcpSS5GBn05VI9LFZqPfp74N/2/iSeEud0TpBdi
LkUVyzDxt/SWjYzdoKxVSGgBlRMHn/fQjrBYVPquKFzqrAQuxymZ/cFuq6Rc2Bi8
tyEDex7VpgDIWiGa8ZuFT3IlhCFu4NNXFfCc0EP6/Zzq2w2lnKyTOuR5RXA/69r3
r9sxbChGQFutsdIHGTvce+nlNQ0N+fHKPFNIe5Alt7esePOGk5yI1tNclxSylqt8
CF/zCy2E/Dv6P5u8sDtfGs12nUY99n6iY+YMlvTet9lhPL9RGQPQveV72olRsutS
jSeq/ZRjRtcvArQCsoOaOrmd68vy/Tscq9ceGWrXj9qzGj/3PO/mykE/kzAmG3d0
NhowqSzZEzAD6Z29gT1dFxLvkGtEgz5q9ssoU5hGV4t9bC7+CKsWNMiJAiblTanM
GiOfiGU4+pUkn7+Csiv73MQoOcKhY4LbGCw0diXtVEj/e1j9g7MtXv+cDMxv1BaZ
7mFyJGdzALVnKN/Xsh5hlXOUXuMCMKHQobK5eR3hXxlCaNKDNi/MXErc7zNyV3Yl
c6O80mCLMYwxsaJwmakN
=y1cP
-----END PGP SIGNATURE-----

--qo7zVO9a9OQ5oQtr--
