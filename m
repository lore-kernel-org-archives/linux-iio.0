Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752463AbeCXNdq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Mar 2018 09:33:46 -0400
Date: Sat, 24 Mar 2018 13:33:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        Jon.Brenner@ams.com
Subject: Re: [PATCH 02/11] staging: iio: tsl2x7x: correct interrupt handler
 trigger
Message-ID: <20180324133340.1b5f32e4@archlinux>
In-Reply-To: <20180321102912.5130-3-masneyb@onstation.org>
References: <20180321102912.5130-1-masneyb@onstation.org>
        <20180321102912.5130-3-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 21 Mar 2018 06:29:03 -0400
Brian Masney <masneyb@onstation.org> wrote:

> tsl2x7x_event_handler() was not called as expected when the device was
> asserting a hardware interrupt. This patch changes the interrupt line
> trigger from rising to falling.
I guess the original test board used for driver development must have
inverted this for some reason and hence was miss configured.

Anyhow, good catch.
Applied to the togreg branch of iio.git.

Thanks,

Jonathan

> 
> The driver was tested on a TSL2772 hooked up to a Raspberry Pi 2. The
> interrupt pin also had a 10K pull-up resistor per the requirements from
> the datasheet. The relevant device tree binding:
> 
> &i2c1 {
> 	tsl2772@39 {
> 		compatible = "amstaos,tsl2772";
> 		reg = <0x39>;
> 		interrupt-parent = <&gpio>;
> 		interrupts = <22 0x2>;
> 	};
> };
> 
> With this patch, iio_event_monitor now shows the events when the
> channels are outside the defined interrupt thresholds.
> 
> $ sudo ./iio_event_monitor tsl2772
> Found IIO device with name tsl2772 with device number 0
> Event: time: 1478193460053760446, type: proximity, channel: 0, evtype:
> thresh, direction: either
> ...
> Event: time: 1478193463020270185, type: illuminance, channel: 0, evtype:
> thresh, direction: either
> ...
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
>  drivers/staging/iio/light/tsl2x7x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index 82cf9d853b18..59921850a226 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -1763,7 +1763,7 @@ static int tsl2x7x_probe(struct i2c_client *clientp,
>  		ret = devm_request_threaded_irq(&clientp->dev, clientp->irq,
>  						NULL,
>  						&tsl2x7x_event_handler,
> -						IRQF_TRIGGER_RISING |
> +						IRQF_TRIGGER_FALLING |
>  						IRQF_ONESHOT,
>  						"TSL2X7X_event",
>  						indio_dev);

