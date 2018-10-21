Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727336AbeJUXGn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 Oct 2018 19:06:43 -0400
Date: Sun, 21 Oct 2018 15:52:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Phil Reid <preid@electromag.com.au>,
        Nishad Kamdar <nishadkamdar@gmail.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: Re: [PATCH v2] staging: iio: ad7816: Switch to the gpio descriptor
 interface
Message-ID: <20181021155202.5fe5a49f@archlinux>
In-Reply-To: <e3d4308c-9608-db52-c51e-5bb5d126284a@metafoo.de>
References: <20181017144716.GA11485@nishad>
        <fdcb085c-cf34-3310-f5ab-5795d5997977@electromag.com.au>
        <e3d4308c-9608-db52-c51e-5bb5d126284a@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 18 Oct 2018 09:40:00 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 10/18/2018 09:28 AM, Phil Reid wrote:
> [...]
> >> +=C2=A0=C2=A0=C2=A0 chip->rdwr_pin =3D devm_gpiod_get(&spi_dev->dev, "=
rdwr", GPIOD_IN);
> >> +=C2=A0=C2=A0=C2=A0 if (IS_ERR(chip->rdwr_pin)) {
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D PTR_ERR(chip->rdwr=
_pin);
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(&spi_dev->dev, "Fa=
iled to request rdwr GPIO: %d\n",
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
t);
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >> -=C2=A0=C2=A0=C2=A0 gpio_direction_input(chip->rdwr_pin); =20
> >=20
> > The RD/WR pin is an input to the AD78xx. So this doesn't make sense bei=
ng
> > GPIOD_IN. =20
>=20
> One thing at a time. This patch is a straight forward conversion to the G=
PIO
> descriptor interface. It keeps the existing semantics of the driver as th=
ey are.
>=20
> Now these semantics are obviously wrong and should be fixed but that shou=
ld
> be a separate patch from changing the interface.
Agreed.  Useful to raise these issues however, and I've added a note to the
patch to bring this to anyone's attention should they be interesting.

Thanks,

Jonathan
