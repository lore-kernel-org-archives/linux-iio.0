Return-Path: <SRS0=KCKz=2M=the-dreams.de=wsa@kernel.org>
Date: Fri, 3 Mar 2017 17:52:47 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Peter Rosin <peda@axentia.se>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Jonathan Corbet <corbet@lwn.net>, linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v9 00/10] mux controller abstraction and iio/i2c muxes
Message-ID: <20170303165247.el4mcsmo4fbnkjir@ninjato>
References: <1486568517-6997-1-git-send-email-peda@axentia.se>
 <6d87465f-b983-3f62-c7cf-41ed4e50170d@axentia.se>
 <20170228171842.GA11127@kroah.com>
 <569c18b3-b1d8-f2e6-7fc4-897aa7df6775@axentia.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vvu4op7gukyogeiw"
In-Reply-To: <569c18b3-b1d8-f2e6-7fc4-897aa7df6775@axentia.se>
List-ID: <linux-iio@vger.kernel.org>


--vvu4op7gukyogeiw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Jonathan, Wolfram, do you have any preferences on how this should be
> coordinated regarding the new iio and i2c drivers (and iio changes)?

You got the acks, all is fine, I think.

> My plan is to at some point declare the branch immutable. Then both of
> you can pull it in. Or?=20

Yup, sounds good.

> But now that I think about it I wonder what the point is of having
> Greg pull it in also? Sure, third time's a charm and all that, but...

AFAIU, Greg will be your "upstream", so he should definately pull the
branch. I will just pull it in to avoid merge conflicts in my tree.
Or did I misunderstand your question?


--vvu4op7gukyogeiw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAli5n1AACgkQFA3kzBSg
KbY6Aw/9EwKWYKXpfLhfHTMt0GlzEO7d/msK1aPqQ7+r23Lm4UoVaDTjlf+f5TnU
zOCwwSb21oRcaRwlhJNNjcC9C5r4kRnv+wGTF34quGj0bmxgQbZrhynVNVulLclX
8S+WOqugjF9pi8B3UkURl5LX30zv0tfJUg7Ebv7Yhk1dXeVM9tCxjqD6Rkjy8NH3
WL1zS9aaDgiNAJz2tMOPdQnPilK216UPFdo+9UaUOFAVu0O2SiEciErTVaTQngL+
uag9m1Yx6V0kh9k8HpfjRUMuVIu/EFboTR+abpGRWvKc9C/Tqt5x5tVMlpRRVVr3
v3ZBBMiyheH9JAF9hkbTGhKm3VZ53gLM3mwRYMg7fecDP/QKceo4ITqqlElWHDVo
9dreH4ZFhROY7G+B11zdu/Ba/8sQud9x/jRrj0IxYHrF38jA/fWLsDuCvBPSFC5s
ZI5Sb54kF6Y9XrUICDX7neWUHWBU/5O+HKQA9tlq4eP1O8T1EFjJjkIqJrNRLBDR
lfihsKOErAV4R+UkeDa/qmGLWQeC00zehbdNBB1NDC94bydHcsG6fcY8l4ZzVPYh
TyvnQYjkVEUgVWBzxxWRAAru7h0MeHPX3n5UxddusKJqSuL6FOSyfzcfNzaSMN4h
VHEbhUIlK36gJAD20/R5l7/nPUxboBaLMgOduD9MhJc+TSiclcE=
=qJWE
-----END PGP SIGNATURE-----

--vvu4op7gukyogeiw--
