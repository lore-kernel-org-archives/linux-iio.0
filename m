Return-Path: <dan.carpenter@oracle.com>
Date: Thu, 2 Feb 2012 14:19:16 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, devel@driverdev.osuosl.org,
        linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 5/6] staging:iio:events: Use non-atomic bitops
Message-ID: <20120202111916.GT3356@mwanda>
References: <1328121956-29596-1-git-send-email-lars@metafoo.de>
 <1328121956-29596-6-git-send-email-lars@metafoo.de>
 <20120202062053.GC24652@mwanda>
 <4F2A53F1.3020304@metafoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KNVwDSkw2BjFUkD8"
In-Reply-To: <4F2A53F1.3020304@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>


--KNVwDSkw2BjFUkD8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 02, 2012 at 10:14:25AM +0100, Lars-Peter Clausen wrote:
> I don't think there is any real performance improvement to be expected of
> this patch. If you have good a reason why non-atomic bitops should not be
> used I guess this patch could be dropped.

No.  This is a pointless patch.  Why should I have to review a patch
that doesn't provide any benifits?

The double underscores in front of the function name means it's
tricky.  Simple code is prefered over complicated code unless there
is a speed up.

regards,
dan carpenter

--KNVwDSkw2BjFUkD8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPKnE0AAoJEOnZkXI/YHqR/PcP/inrkvOzO6oof7Ymie7gC2nU
e3kIuhzq/vtsADRdKCWC0WsnVE/kJyMpqbz03RSgSe5Pqc8uv6MT2ui9Ycz0Juii
WgwrLHlX0TPFNGJ9a5T4whEmdMx3MMy2t7GCWLpf5L2KuRG+aFi0/xGS6LZHc6eO
QR9Wfj/THmklYo0r+jyV6LnTMWuaN7IBkYQrYaD3xab7jJp+TVMc3O7GIVvpcMA9
uxbGBN1oVobeJQVdl0A3mTKL6UdPjUL4M1xcNss7c1zIMQ17fnah7ZWZ0JMO/yoS
nV9FEGOMjoaqZKHQ1/z4kjQs0riClJfSCCDOALHNxsGsW5AFPufNnY7K8ulccuoR
fXxA3Q/WAg/dzgxFIkmQNWd1F7S19Uum0BvRSnQFYb6HV4f0PLguTxca8qDeF9e9
I12p3Qdlp6zMKOX3LlROlGqaYdOP4RQZsJ/mR85ClLTJUUiGlCflGQNbsFfXK5HA
bQiOHtGNrbLtGuploPpAAXUcMsedqMIlgr4OBNgUSXz2+OS48I9F6CaU4K1sM3is
JVqGU6p7fTsqrpQFitnv9Px+FnOhYd5NpGpJvEi2wB5bae6C4N5Yiaw7p6bUltdd
5/kowcRYxxSey8w1JA74JNOwIVHMw7/NFGO39IyoySbuUk6GCluIS31q9x3kpIuB
xKSt7rZzpgIoFvHBTZ5P
=ot/8
-----END PGP SIGNATURE-----

--KNVwDSkw2BjFUkD8--
