Return-Path: <wsa@the-dreams.de>
Date: Wed, 28 Oct 2015 00:30:00 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Nicola Corna <nicola@corna.info>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>,
	Eric Anholt <eric@anholt.net>, Jonathan Cameron <jic23@kernel.org>,
	linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 4/4] iio: humidity: si7020: added No Hold read mode
Message-ID: <20151027233000.GB1572@katana>
References: <1445976718-7449-1-git-send-email-nicola@corna.info>
 <1445976718-7449-4-git-send-email-nicola@corna.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JYK4vJDZwFMowpUq"
In-Reply-To: <1445976718-7449-4-git-send-email-nicola@corna.info>
List-ID: <linux-iio@vger.kernel.org>


--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Not a complete review, I just stumbled over this one:

> +			if (client->adapter->quirks &&
> +			   client->adapter->quirks->flags |

'|' should be '&', or?

> +			   I2C_AQ_NO_CLK_STRETCH)
> +				return -ENODEV;

--JYK4vJDZwFMowpUq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWMAj4AAoJEBQN5MwUoCm2Pp4QAKL6uMYyz7ZIOBykVL2zVckL
tQh4NxGFPpNjT9qoEwN7j8q670MOInnWMEo8EL+1zHQ7gVb+YB83mEo95i1/Pt8E
Dl1jd60EtfsL7Wgoh9V0cJtTW7ttHM69eTGoL5jVwnvbPg1Pu2lJ+/2AVqCN1j4q
JLlBbdEhDll9W0U/0UmR5NB0/0wwu0Dd47C5KTRsp0ufMTZ7Eq2oPWQdhDAJt9oj
l7qgKg0U8sxmpVNlcMFZshnuaRA4+EDtfuB+01+5vRlgHDaBPXrMIj7dEOPfkrPW
smufEQMhFpCwpa6/cF+RZS+2edezAKR7MGBe1dgcR7iozqkzEiDErazfVkN6tO5F
xDisw9BWiHvZ9dMxlzB8DDk7ooKLEjwedMVpX+jGfJNrXMI+IXay/18NLcDjlDhN
S6fFjcIdDogzu+6CcwHAjLzh9oBKNOuTO5C+R2WTtpGFCB+7uPXdf53WvtoGLi3s
ZhINEV2I6cn74J4mXHZbh5wdoK7v0OA6DuSf5S47dNTMXc/6/4XiOEs+bNp3/aqu
xP3BftVf//8aAcVpxH+t430Mq/y0xfqfSB1z6Tp8wiMZfy/5OmXELIXZ4vjC1G0Z
GFqZKdN/NxJPodiibKjNdcXl6/VMzga6cfReh6+f8yteW1oSTQ1SJlcm/glgNSXH
sQFe0egCgXVKpXeaN6pq
=NrAi
-----END PGP SIGNATURE-----

--JYK4vJDZwFMowpUq--
