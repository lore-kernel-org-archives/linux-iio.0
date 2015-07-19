Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47530 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752466AbbGSNr6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 19 Jul 2015 09:47:58 -0400
Message-ID: <55ABAA8B.3080706@kernel.org>
Date: Sun, 19 Jul 2015 14:47:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Martin Kepplinger <martink@posteo.de>, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, mfuzzey@parkeon.com,
	roberta.dobrescu@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com,
	mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org
CC: devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	christoph.muellner@theobroma-systems.com,
	Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Subject: Re: [PATCH 8/8] iio: mma8452: add devicetree property to allow all
 pin wirings
References: <1436186062-5766-1-git-send-email-martink@posteo.de> <1436186062-5766-9-git-send-email-martink@posteo.de>
In-Reply-To: <1436186062-5766-9-git-send-email-martink@posteo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/07/15 13:34, Martin Kepplinger wrote:
> For the devices supported by the mma8452 driver, two interrupt pins are
> available to route the interrupt signals to. By default INT1 is assumed.
> 
> This adds a simple boolean DT property, for users to configure it for
> INT2, if that is the wired interrupt pin for them.
> 
> This is important for everyone to be able to use this driver, no matter
> how their chip is wired.
> 
> Since this doesn't change the default behaviour, it doesn't break anything
> for existing users.
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
The whole series looks good to me.  Just want those acks from Peter and / or
Martin before I apply it.

Thanks,

Jonathan
> ---
>  Documentation/devicetree/bindings/iio/accel/mma8452.txt |  2 ++
>  drivers/iio/accel/mma8452.c                             | 14 ++++++++------
>  2 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/mma8452.txt b/Documentation/devicetree/bindings/iio/accel/mma8452.txt
> index 8d98e05..9bad1fc 100644
> --- a/Documentation/devicetree/bindings/iio/accel/mma8452.txt
> +++ b/Documentation/devicetree/bindings/iio/accel/mma8452.txt
> @@ -10,6 +10,7 @@ Optional properties:
>  
>    - interrupt-parent: should be the phandle for the interrupt controller
>    - interrupts: interrupt mapping for GPIO IRQ
> +  - use_int2: assume interrupt pin wired to INT2 instead of INT1
>  
>  Example:
>  
> @@ -18,4 +19,5 @@ Example:
>  		reg = <0x1d>;
>  		interrupt-parent = <&gpio1>;
>  		interrupts = <5 0>;
> +		use_int2;
>  	};
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 2b8ed67..f8ba146 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -1105,12 +1105,14 @@ static int mma8452_probe(struct i2c_client *client,
>  		int enabled_interrupts = MMA8452_INT_TRANS |
>  					 MMA8452_INT_FF_MT;
>  
> -		/* Assume wired to INT1 pin */
> -		ret = i2c_smbus_write_byte_data(client,
> -						MMA8452_CTRL_REG5,
> -						supported_interrupts);
> -		if (ret < 0)
> -			return ret;
> +		/* Assume wired to INT1 pin, except "use_int2" is found in DT */
> +		if (!of_property_read_bool(client->dev.of_node, "use_int2")) {
> +			ret = i2c_smbus_write_byte_data(client,
> +							MMA8452_CTRL_REG5,
> +							supported_interrupts);
> +			if (ret < 0)
> +				return ret;
> +		}
>  
>  		ret = i2c_smbus_write_byte_data(client,
>  						MMA8452_CTRL_REG4,
> 

