Return-Path: <SRS0=JnkZ=YW=sang-engineering.com=wsa-dev@kernel.org>
Date: Sun, 8 Jan 2017 11:51:29 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Jonathan Corbet <corbet@lwn.net>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v7 00/12] mux controller abstraction and iio/i2c muxes
Message-ID: <20170108105129.GB1983@katana>
References: <1483532187-28494-1-git-send-email-peda@axentia.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rS8CxjVDS/+yyDmU"
In-Reply-To: <1483532187-28494-1-git-send-email-peda@axentia.se>
List-ID: <linux-iio@vger.kernel.org>


--rS8CxjVDS/+yyDmU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi peda,

> One thing that I would like to do, but don't see a solution
> for, is to move the mux control code that is present in
> various drivers in drivers/i2c/muxes to this new minimalistic
> muxing subsystem, thus converting all present i2c muxes (but
> perhaps not gates and arbitrators) to be i2c-mux-simple muxes.

In a few lines, what is preventing that?

> I'm using an rwsem to lock a mux, but that isn't really a
> perfect fit. Is there a better locking primitive that I don't
> know about that fits better? I had a mutex at one point, but
> that didn't allow any concurrent accesses at all. At least
> the rwsem allows concurrent access as long as all users
> agree on the mux state, but I suspect that the rwsem will
> degrade to the mutex situation pretty quickly if there is
> any contention.

Maybe ask this question in a seperate email thread on lkml cc-ing the
locking gurus (with a pointer to this thread)?

> Also, the "mux" name feels a bit ambitious, there are many muxes
> in the world, and this tiny bit of code is probably not good
> enough to be a nice fit for all...

"... and it probably never will support anything other than
AT-harddisks, as that's all I have..." ;))

Thanks for this work!

   Wolfram


--rS8CxjVDS/+yyDmU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYchmxAAoJEBQN5MwUoCm2gFIP/0GpXL7VKltrawDMyuTZj01/
Z8AsmTkIMEnoVXBYoKHVyr2BkNoYZtNlJ+NZQD0KeZUC9fKJzfJCTYTS7LEgwSs9
67zMTOsfP2nK40gBjr6dR0aoOsxpYe0gaJtNR7Y3VFt0+ZqyumOsRKL8izpaugt2
f3kR/yOP/7r8lwtYDBfFAssJAWxnOStnrTAv2gYmWscPzJJFK1S7kQzzUtpfzkJL
fnnRm7yCQ+WGxTZxTAWyPaRVUjdFZmRsk3+jWMm5xrdeLeyp+csg+6FEqoe2dRy+
+xszr7HcBv5ueiP0cDTGJ7g1gSWCsxS6QyjBC8uZhsvK8GF66g7HUGJJupyoFjSX
hsMDYfEVrrVC2IUjioyDn6J4d9XKsu0md0qWUlzoPzxuy+YRdb8tOQ41xMD9a9+m
fX8Rk0MQ3UnSUhCXs8XanJ+E7Z5eHD3b0LA7CyAt+RrVBBlMAbzecKNecw12aj6+
KfX4stC++AH/jZhb4ZGogmKBDEe24nAQWqLxuDRg8kZAzLhjIZUQ83QSZYUmcS0O
UKEjesO/kHSlPjqJhcnzSmBk2LAdIZ86ccKVqHB23RqWDuRViMaSNQpbtvvo2E4/
cHgcK96uhgNTLLWL4Xn0oYWWlM0rfl9Rtk1NR7qxb3ek0oLNYaTds0ylFMwVyY+p
tbXixbqM1q+KK37bY1M1
=Kqrn
-----END PGP SIGNATURE-----

--rS8CxjVDS/+yyDmU--
