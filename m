Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:40050 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753560AbcHXLvT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 24 Aug 2016 07:51:19 -0400
Date: Wed, 24 Aug 2016 13:50:58 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Peter Rosin <peda@axentia.se>
Cc: jic23@jic23.retrosnub.co.uk, Jonathan Cameron <jic23@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, Nick Vaccaro <nvaccaro@google.com>,
        Ge Gao <ggao@invensense.com>, Anna Si <asi@invensense.com>,
        Nathan Royer <nroyer@invensense.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Crestez Dan Leonard <leonard.crestez@intel.com>,
        Daniel Baluta <daniel.baluta@intel.com>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: gyro: Add driver for the MPU-3050 gyroscope
Message-ID: <20160824115058.GA5190@katana>
References: <1471286287-25074-1-git-send-email-linus.walleij@linaro.org>
 <53008712-7c50-79db-07ab-3544902887e1@kernel.org>
 <285e7c3f-eedb-28ed-f651-926260d17a8a@axentia.se>
 <c45a4c34d8c980d20e790741f33961f7@jic23.retrosnub.co.uk>
 <ed7493a1-37e4-2291-c66e-11cb97b6e5e3@axentia.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
In-Reply-To: <ed7493a1-37e4-2291-c66e-11cb97b6e5e3@axentia.se>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Wolfram, is that ok with you? Or should I just bite the bullet and ask
> Stephen to include a brand new for-next branch from the i2c-mux repo
> instead?

I had a glimpse of the series in question and it looks good to me. Looks
like I'll pull it in today or tomorrow.

But it may be nice to have a branch in your mux-repo that people can
pull anyhow? I usually don't like pulling all of linux-next when I only
want one specific feature.


--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXvYoiAAoJEBQN5MwUoCm2MakQAKhI7Z2y4UrsK3XfXMPKWYnI
WvZ4MmpZcJDuUfeEcOnBImtFg0YdAKMwo8j4051SZ0Xul995Fcu6PrJzhKvu9W3P
/TrUzPbSrN/M0uf+o3WShXreG4B2lDu8MkVCUTa3s1XhNhJ0L66SDWxJP2Hv3c67
wjeYzspnza/xei7iYH/qhCZR/1kM3UNaIXLnAb3NNnCU9UXVbknKIo4ZHCplZ/4f
1E1GeBhwLb2laKGFwOpo6Oh9I9SmAnPWDUi/E4tvWX+evKurRmQt0QJVlGFikpv8
aDxZny8H9DBAeNuUCm+diNn8PjEhvL+ptZPQ9RssnDQL41osuutf4dwpefvcgX/x
mMMsFttgmAHY46xs77ZpR+UnJY9N28sj4TwaKLNcjF4uJ1B0giyZz5UD/2uJH3Az
VqUblqYHYPnu6mq4FqUJxFvTVRdo7Mw/KBNocHs9v0ohHovciCinTxPJA51sDv3P
cv7qBQPiEh7PEkSgr4c11q3Mk5wlj7gn0DToZHu+ZG45HpmX4f9dCawD10KX3kNd
Ggdhek7J1ipKHFkAaOG0e2E09Fl/NvhTUPkj7umqb2CFjbiNNCcZ8oJ4WCT/uOe6
29swHJnhKcqR2wCXAOy4onzB7d+MvYWrCKnAsbzZ8KpHD0Woo0/nWorNJAkh7bOr
fAMf776hqlGyFXogfbCw
=kzM1
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
