Return-Path: <broonie@sirena.org.uk>
Date: Wed, 11 Sep 2013 16:35:47 +0100
From: Mark Brown <broonie@kernel.org>
To: Lee Jones <lee.jones@linaro.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>, arnd@arndb.de,
	linux-iio@vger.kernel.org, linus.walleij@linaro.org,
	linux-kernel@vger.kernel.org, jic23@cam.ac.uk, denis.ciocca@st.com,
	linux-arm-kernel@lists.infradead.org
Message-ID: <20130911153547.GU29403@sirena.org.uk>
References: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
 <1378817379-8238-28-git-send-email-lee.jones@linaro.org>
 <43055af7-991f-4122-b308-a3dcddbbb72a@email.android.com>
 <20130911071053.GD11227@lee--X1>
 <52301963.5030006@metafoo.de>
 <20130911072955.GG11227@lee--X1>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="e5zRiGm/7Jpxr3Pr"
In-Reply-To: <20130911072955.GG11227@lee--X1>
Subject: Re: [PATCH 27/38] iio: pressure-core: st: Give some indication if
 device probing was successful
List-ID: <linux-iio@vger.kernel.org>


--e5zRiGm/7Jpxr3Pr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 11, 2013 at 08:29:55AM +0100, Lee Jones wrote:

> Only if you print out every regulator, clock, GPIO pin and things of
> this nature. Key hardware blocks such as; SD, Flash, USB, Eth, HDMI,
> Audio, UART, GPIO and I2C controllers and Sensors I think deserve a
> one line "I'm here and working" message.

The usual rule people apply with this stuff is if the driver has read
back information it can display from the hardware (eg, a revision) then
that's OK.  Things that are likely to crash the system if they fail tend
to also be OK (this is why the regualtor API is quite chatty for
example, a lot of the things it does can cause an immediate crash).

--e5zRiGm/7Jpxr3Pr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSMI3KAAoJELSic+t+oim9X14P/2E+OPY2jRzMrKGXW10ENG/2
wFGvzxoMlWzWDCthzoO/oUr6ymY+GuTXaCgbZxSC5WpSKdM+LW0SfWJ/O97T57w/
yPaWLrPc29mQW+cs/8/sJtMFyeMEVkA83bn3b7QheXvNKj96haf+1vEGpZKMO2+Z
1+FzK8O1Z+7bX8GeHQWmEIxUsFdgZmqF60jAg5lNPuNZLg+x2dAk2cQDgjAb02M2
euJbqN95+jt5PkWiVF4uasnletSSeJZg0j4KkZ+A9Zhk3rRidfna0aqNG8vsdMju
OvnHQhU4XmqdTYDgWKqQYbyu1y+mVwiHpJfgSOfiqqRQnQwHkjGoScqBjT8fKzJh
FqJPbEvvNH1RP74Xa4tJ5yJdgMw9hBugdASfOOPfquep09bpHYyupG7SI0OsRoMW
n5uCAdk0zzBUErIktM26C69ps/icFQ0zdeQMVM58ngsEi1xWC+Bsw25dcqlQCVbC
6VERGBJec9ZWhUwUVsBcGkuWZZCEDs1WNFKZX4Yp8TN7a0QnfUjzzSESM2w2lgw6
9bQYTWGt7vgK+Mex/uIYfBRbSExkCOQm7gPwqQfF9PJ+1KCB0v38cAQBkm9r6ENw
18lf16Ksx4MdiAKNBuS5LFYVXeeCLQtX/sMje4sAmty1H2RuMjb6QX1vk/mv+kgU
aDVn71lJNRb40HG2BBKK
=tOhT
-----END PGP SIGNATURE-----

--e5zRiGm/7Jpxr3Pr--
