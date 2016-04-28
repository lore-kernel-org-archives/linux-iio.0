Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:35808 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810AbcD1Hr5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 28 Apr 2016 03:47:57 -0400
Received: by mail-ob0-f171.google.com with SMTP id n10so30769385obb.2
        for <linux-iio@vger.kernel.org>; Thu, 28 Apr 2016 00:47:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5720B9DA.1000409@parrot.com>
References: <cover.1461056711.git.gregor.boirie@parrot.com>
	<CACRpkdZxE4Z6f_0uVV0sD5EUxEigzbMvWRD+MTDWNZbuauVweg@mail.gmail.com>
	<CACRpkdZ=DSEKi6dOBuxA23ivsQYsoigvG_cC11HR-66aN_BUpQ@mail.gmail.com>
	<5720B9DA.1000409@parrot.com>
Date: Thu, 28 Apr 2016 09:47:56 +0200
Message-ID: <CACRpkdY08X6O=OukhngMR_EKp-gsy=_H7dp1ifm9P7yFto4PLw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/9] iio:st_sensors: fixes and lps22hb pressure sensor
From: Linus Walleij <linus.walleij@linaro.org>
To: Gregor Boirie <gregor.boirie@parrot.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Denis Ciocca <denis.ciocca@st.com>,
	Giuseppe Barba <giuseppe.barba@st.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Apr 27, 2016 at 3:08 PM, Gregor Boirie <gregor.boirie@parrot.com> wrote:

> Many thanks for taking time to test this. ~95 kPa seems rather a small value
> to me.
>
> For reference, it seems 950 hPa at sea level would be found under a...
> hurricane !
> (may vary with location)
>
> Does it match with your local weather forecast / report ?

Hmmmm no :)

Checking with local weather site it should be ~1006 hPa.

Do you think the sensor is just badly calibrated?

I tested now with another sensor on the Snowball board.
It gives (after scaling):

101.4
28.8
101.9
28.8
101.9
29.5

This sensor seems more accurate wrt pressure.
However here instead the temperature seems bananas,
this is a Swedish office, we don't have ~30degrees here...
And it's not the board is just turned on so I don't think it's
that warm. One sensor gives believeable pressure, the other
gives believeable temperature...

The data sheet says this sensor is calibrated for two
pressure+temperature combinations at manufacturing.
I wonder if there are "secret registers" in the device that
can update the calibration...

Anyways, the measures are not totally off scale so
I guess they are in the right ballpark. And these patches
makes it work better for sure.

Yours,
Linus Walleij
