Return-Path: <SRS0=yjIN=YX=gmail.com=robherring2@kernel.org>
Date: Mon, 9 Jan 2017 12:16:45 -0600
From: Rob Herring <robh@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH] iio: accel: st_accel: handle deprecated bindings
Message-ID: <20170109181645.lntlvawt26vsp4l2@rob-hp-laptop>
References: <20170105133233.24237-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170105133233.24237-1-linus.walleij@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

On Thu, Jan 05, 2017 at 02:32:33PM +0100, Linus Walleij wrote:
> The earlier deployed LIS3LV02DL driver had already defined a few
> DT bindings that need to be supported by the new more generic
> driver and listed as compatible but deprecated bindings in the
> documentation.
> 
> After this we can start to activate the new driver with the old
> systems where applicable.
> 
> As part of this enablement: make us depend on the old drivers
> not being in use so we don't get a kernel with two competing
> drivers.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  Documentation/devicetree/bindings/iio/accel/lis302.txt | 2 +-
>  Documentation/devicetree/bindings/iio/st-sensors.txt   | 2 ++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/iio/accel/Kconfig                              | 2 ++
>  drivers/iio/accel/st_accel_i2c.c                       | 5 +++++
>  drivers/iio/accel/st_accel_spi.c                       | 9 +++++++++
>  5 files changed, 19 insertions(+), 1 deletion(-)
