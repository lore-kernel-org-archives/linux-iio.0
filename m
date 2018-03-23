Return-Path: <SRS0=FfDz=GN=huawei.com=jonathan.cameron@kernel.org>
Date: Fri, 23 Mar 2018 13:14:01 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Peter Rosin <peda@axentia.se>
CC: <linux-kernel@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	"Peter Meerwald-Stadler" <pmeerw@pmeerw.net>, Rob Herring
	<robh+dt@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>, "David S.
 Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij
	<linus.walleij@linaro.org>, "Randy Dunlap" <rdunlap@infradead.org>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH 0/3] iio: add unit converter
Message-ID: <20180323141401.000031cc@huawei.com>
In-Reply-To: <20180319170246.26830-1-peda@axentia.se>
References: <20180319170246.26830-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
List-ID: <linux-iio@vger.kernel.org>

On Mon, 19 Mar 2018 18:02:43 +0100
Peter Rosin <peda@axentia.se> wrote:

> Hi!
> 
> This moves the iio-mux driver to a new category, since I think
> it will be the single driver in that category forever, and now
> I'm adding a new driver that is somewhat similar in nature...
> 
> But that rename is not very interesting, it's just reshuffling.
> It's the new driver that I need. Specifically, I need to allow
> linear scaling and modification of the type of an io-channel.
> I don't know exactly how that is accomplished in the best way,
> but this is what I came up with.
> 
> The use cases are an ADC hooked up to measure a "big" voltage by
> looking at the midpoint of a voltage divider, and an ADC used
> to measure the current by looking at the voltage over a resistor.
> 
> Comments?
It is pretty much how I would have implemented it as well.

Will probably do a detailed review over the weekend.
Not convinced entirely on the 'wrapper' naming though.
Will think about it...

Jonathan

> 
> Cheers,
> Peter
> 
> Peter Rosin (3):
>   iio: rename the multiplexer category to wrapper
>   dt-bindings: iio: wrapper: add io-channel-unit-converter
>   iio: wrapper: unit-converter: new driver
> 
>  .../{multiplexer => wrapper}/io-channel-mux.txt    |   0
>  .../iio/wrapper/io-channel-unit-converter.txt      |  84 +++++++
>  MAINTAINERS                                        |  11 +-
>  drivers/iio/Kconfig                                |   2 +-
>  drivers/iio/Makefile                               |   2 +-
>  drivers/iio/multiplexer/Makefile                   |   6 -
>  drivers/iio/{multiplexer => wrapper}/Kconfig       |  13 +-
>  drivers/iio/wrapper/Makefile                       |   7 +
>  drivers/iio/{multiplexer => wrapper}/iio-mux.c     |   0
>  drivers/iio/wrapper/iio-unit-converter.c           | 268 +++++++++++++++++++++
>  10 files changed, 381 insertions(+), 12 deletions(-)
>  rename Documentation/devicetree/bindings/iio/{multiplexer => wrapper}/io-channel-mux.txt (100%)
>  create mode 100644 Documentation/devicetree/bindings/iio/wrapper/io-channel-unit-converter.txt
>  delete mode 100644 drivers/iio/multiplexer/Makefile
>  rename drivers/iio/{multiplexer => wrapper}/Kconfig (53%)
>  create mode 100644 drivers/iio/wrapper/Makefile
>  rename drivers/iio/{multiplexer => wrapper}/iio-mux.c (100%)
>  create mode 100644 drivers/iio/wrapper/iio-unit-converter.c
> 
