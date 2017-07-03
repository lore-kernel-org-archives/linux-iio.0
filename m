Return-Path: <SRS0=2R62=6G=free-electrons.com=maxime.ripard@kernel.org>
Date: Mon, 3 Jul 2017 23:19:45 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	wens@csie.org, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	thomas.petazzoni@free-electrons.com
Subject: Re: [PATCH] iio: adc: sun4i-gpadc-iio: fix unbalanced irq
 enable/disable
Message-ID: <20170703211945.4vjnnjwl2lkcfr7u@flea>
References: <20170703130926.32315-1-quentin.schulz@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gintn6fb57sb33ds"
In-Reply-To: <20170703130926.32315-1-quentin.schulz@free-electrons.com>
List-ID: <linux-iio@vger.kernel.org>


--gintn6fb57sb33ds
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 03, 2017 at 03:09:26PM +0200, Quentin Schulz wrote:
> When initializing interrupts, the devm_request_any_context_irq will
> enable them right away. An atomic flag was set in sun4i_irq_init and read
> in the interrupt handler to make sure no unwanted interrupts were
> handled. If an unwanted interrupt occurred, the handler would disable
> the irq and return IRQ_HANDLED. However, at the end of sun4i_irq_init,
> the irq would be disabled as well, resulting in an unbalanced enable
> (since there are more disables than enables, the code enabling the
> interrupt would never be called).
>=20
> When reading the ADC or the temperature, the respective irq would be
> enabled in the read function and disabled in the irq handler. In the
> read function, we would wait for a completion (with a timeout) that will
> be set in the irq handler. However, if the completion is never set or if
> the wait for completion times out, the irq would not be disabled in the
> read function resulting in an unbalanced enable once the read function
> is called again (since there are 2+ enables for no disable).
>=20
> Moving disable_irq from the irq handler to the read function get rid of
> these two cases of unbalanced enable.
>=20
> Fixes: d1caa9905538 ("iio: adc: add support for Allwinner SoCs ADC")
>=20
> Reported-by: Andreas F=E4rber <afaerber@suse.de>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--gintn6fb57sb33ds
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZWrTxAAoJEBx+YmzsjxAg9iQP+gJs2ckTsE59nzE/HDhWsxMW
giFh6ZHgqw+af45YD3wdPnLTfzXV5XF/q0jfDWQQwe+N0roAgc01tJl6GgZM64gl
i9gw6C5sPmuz0oUptXbimhWCC3rxUBgFmM+F6xXyYkq6ujKBRRS5iW49O8N6f7Sd
DVE4Bn5mSDbesb8TGB5mIATjRtkgKHZnnGdQTv75uehKBTIHksp2St4gYdX3omiK
wZVtvhYciFvH/lHnPje/XfMgdQkYnRuCJMXRgaI4Z4+H7Tazm9cfLDY0C5ujzJMM
cN+gOIPOkNuOcY3s6sN2WkfV5zPYG+oyYDKSR0mSGSwV8BxbTWvYHLHTYEiAoaXt
POpdKG7zyrtfy00R+7ydQEDuDgKWGGlYERRRI1Efv77UJCaqytjGrqgpTgKCxt55
Nu1c8WmFGhFDrU1Sdf+1o7zjoy5v6BWQzU8zUQrnJNw/7covZNukIfCj4InvFBpk
tBUj0V0U1Ftpf2Kaa9Y2RXfs3VoPPBslWz2YIE86vuENrUglNFLRyMyCCh16Q5C5
do5EKIjNrwsoD3W7LtlzOeA4iH7XW1kvB+Y1l2KzOe+aQUA62m0k5NHr2Rar/iMo
FRn5a3roKim5oG48gRoOWeWyOnxlxoO9+yEHHFeXq0iMaML/KMcPRuUORKDueB1N
PHkDzHf9Q1D06SKTkszE
=f5zl
-----END PGP SIGNATURE-----

--gintn6fb57sb33ds--
