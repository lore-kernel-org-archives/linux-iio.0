Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:37267 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752631AbbLETB6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 5 Dec 2015 14:01:58 -0500
Date: Sat, 5 Dec 2015 20:01:45 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Nicola Corna <nicola@corna.info>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>,
	linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH v5 5/5] iio: humidity: si7020: add No Hold read mode
Message-ID: <20151205190145.GC1597@katana>
References: <1445976718-7449-1-git-send-email-nicola@corna.info>
 <1446118467-26453-1-git-send-email-nicola@corna.info>
 <1446118467-26453-5-git-send-email-nicola@corna.info>
 <56349644.2060308@kernel.org>
 <20151130173324.GG9554@katana>
 <56632BE7.2050000@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oJ71EGRlYNjSvfq7"
In-Reply-To: <56632BE7.2050000@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--oJ71EGRlYNjSvfq7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> If Wolfram doesn't pick this up, please ping me after the next merge window.

I tried to pick it a second ago, but it could not be applied (my branch
is based on 4.4-rc3). So, I really think it's better you pick it and
handle the conflicts.

--oJ71EGRlYNjSvfq7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWYzSZAAoJEBQN5MwUoCm2VloP/jWwE5RUZ28GabwmGGRfA5fl
5e5N87GkNLjfQlSG13cBR7d9+45vV2gUUTlAmj0NZCFG7ZbYD4hsO/ldG5VEHlUu
yKz/XWJgw7Lgl4HFPH8ME+ZuNLOJc6I+0Yjzh+lcS8jpBhvvHfeZ90GkqPTiJAQM
NKZfoVc3SB+CnERqHvUNMlhotCqsCkyYMXB4FqxDt5yxt1VxiPdFdsW/SS5D1tyD
ljQ3FNXozHLcsRAJIx36OGbKJ7R+x5ehgirF74pTxDcnROBKTo3Yzob1tOXETbdU
BOts5V0FvPDRmVKPUVqEC6WD4GlW+DxVBkXCBkIEcgNNbM1bd33fA2OHkuq350pR
PFBxA4V0erInEYmm10EOhCL3SNWIK3SpnYgp2TfkXInQHagUakcOm9Nmk0ZIjq7b
4KG/9tYDlzcm6InIk0oWjxXkKjJ4jnyOAXLxpNEmoG97xU9p+j3/W2NKsecsrQ57
qKIcAjU2dJWN552+7kKkz0UJAYsVPi0cPYbMI7kBuUE+2Y622NcMHPKkw4mKK+XH
/mG2HYp689aRfSX63i9EbzKBiqmEv6JpZMWdNsbbx9+Elk+BsN2DMfhMSDufPwHb
ESh9ppeLxd7leAX5IXP9StYovx1mSYMRVtextofCfugOT6O057dUbsGxEaf6g9jy
k6g7AdZJA0xEnllXfReY
=bYH0
-----END PGP SIGNATURE-----

--oJ71EGRlYNjSvfq7--
