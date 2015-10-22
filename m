Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50457 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965411AbbJVSXO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 22 Oct 2015 14:23:14 -0400
MIME-Version: 1.0
In-Reply-To: <1444914632-4486-1-git-send-email-martink@posteo.de>
References: <1444914632-4486-1-git-send-email-martink@posteo.de>
From: Rob Herring <robh+dt@kernel.org>
Date: Thu, 22 Oct 2015 13:22:50 -0500
Message-ID: <CAL_Jsq+cd0A7wczT-KC3TT_2UmZDqjr799uRMR_WA_JFfTw6dA@mail.gmail.com>
Subject: Re: [PATCH v4] iio: mma8452: support either of the available
 interrupt pins
To: Martin Kepplinger <martink@posteo.de>
Cc: Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Martin Fuzzey <mfuzzey@parkeon.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Oct 15, 2015 at 8:10 AM, Martin Kepplinger <martink@posteo.de> wrote:
> This change is important in order for everyone to be easily able to use the
> driver for one of the supported accelerometer chips!
>
> Until now, the driver blindly assumed that the INT1 interrupt line is wired
> on a user's board. But these devices have 2 interrupt lines and can route
> their interrupt sources to one of them. Now, if "INT2" is found and matches
> i2c_client->irq, INT2 will be used.
>
> The chip's default actually is INT2, which is why probably many boards will
> have it wired and can make use of this.
>
> Of course, this also falls back to assuming INT1, so for existing users
> nothing will break. The new functionality is described in the bindings doc.
>
> Signed-off-by: Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
> ---
> changelog:
> v4: use irq that matches client->irq, backwards compatible
> v3: correctly assign irq if both pins are described in DT
> v2: don't warn but normally handle if both pins are described in dts
>     thanks Mark Rutland
> v1: initial post
>
>  .../devicetree/bindings/iio/accel/mma8452.txt       |  6 ++++++

For the binding:

Rob Herring <robh@kernel.org>

>  drivers/iio/accel/mma8452.c                         | 21 +++++++++++++++------
>  2 files changed, 21 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/iio/accel/mma8452.txt b/Documentation/devicetree/bindings/iio/accel/mma8452.txt
> index e3c3746..3c10e85 100644
> --- a/Documentation/devicetree/bindings/iio/accel/mma8452.txt
> +++ b/Documentation/devicetree/bindings/iio/accel/mma8452.txt
> @@ -7,13 +7,18 @@ Required properties:
>      * "fsl,mma8453"
>      * "fsl,mma8652"
>      * "fsl,mma8653"
> +
>    - reg: the I2C address of the chip
>
>  Optional properties:
>
>    - interrupt-parent: should be the phandle for the interrupt controller
> +
>    - interrupts: interrupt mapping for GPIO IRQ
>
> +  - interrupt-names: should contain "INT1" and/or "INT2", the accelerometer's
> +                    interrupt line in use.
> +
>  Example:
>
>         mma8453fc@1d {
> @@ -21,4 +26,5 @@ Example:
>                 reg = <0x1d>;
>                 interrupt-parent = <&gpio1>;
>                 interrupts = <5 0>;
> +               interrupt-names = "INT2";
>         };
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 1eccc2d..116a6e4 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -29,6 +29,7 @@
>  #include <linux/iio/events.h>
>  #include <linux/delay.h>
>  #include <linux/of_device.h>
> +#include <linux/of_irq.h>
>
>  #define MMA8452_STATUS                         0x00
>  #define  MMA8452_STATUS_DRDY                   (BIT(2) | BIT(1) | BIT(0))
> @@ -1130,13 +1131,21 @@ static int mma8452_probe(struct i2c_client *client,
>                                            MMA8452_INT_FF_MT;
>                 int enabled_interrupts = MMA8452_INT_TRANS |
>                                          MMA8452_INT_FF_MT;
> +               int irq2;
>
> -               /* Assume wired to INT1 pin */
> -               ret = i2c_smbus_write_byte_data(client,
> -                                               MMA8452_CTRL_REG5,
> -                                               supported_interrupts);
> -               if (ret < 0)
> -                       return ret;
> +               irq2 = of_irq_get_byname(client->dev.of_node, "INT2");
> +
> +               if (irq2 == client->irq) {
> +                       dev_dbg(&client->dev, "using interrupt line INT2\n");
> +               } else {
> +                       ret = i2c_smbus_write_byte_data(client,
> +                                                       MMA8452_CTRL_REG5,
> +                                                       supported_interrupts);
> +                       if (ret < 0)
> +                               return ret;
> +
> +                       dev_dbg(&client->dev, "using interrupt line INT1\n");
> +               }
>
>                 ret = i2c_smbus_write_byte_data(client,
>                                                 MMA8452_CTRL_REG4,
> --
> 2.1.4
>
