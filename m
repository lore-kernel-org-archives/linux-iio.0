Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34361 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932467AbdBQUwt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Feb 2017 15:52:49 -0500
Date: Fri, 17 Feb 2017 12:52:44 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Welling <mwelling@ieee.org>,
        Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila@nextfour.com>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Igor Grinberg <grinberg@compulab.co.il>,
        "Andrew F. Davis" <afd@ti.com>, Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alexander Stein <alexander.stein@systec-electronic.com>,
        Eric Engestrom <eric@engestrom.ch>,
        Hans de Goede <hdegoede@redhat.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Petr Cvek <petr.cvek@tul.cz>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Nick Dyer <nick@shmanahar.org>,
        Siebren Vroegindeweij <siebren.vroegindeweij@hotmail.com>,
        Michel Verlaan <michel.verl@gmail.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        letux-kernel@openphoenux.org, linux-iio@vger.kernel.org,
        kernel@pyra-handheld.com
Subject: Re: [PATCH v9 2/8] drivers:input:tsc2007: check for presence and
 power down tsc2007 during probe
Message-ID: <20170217205244.GG13050@dtor-ws>
References: <cover.1482936802.git.hns@goldelico.com>
 <f39f47ebef2224bd73e114ee529768756bb8972a.1482936802.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f39f47ebef2224bd73e114ee529768756bb8972a.1482936802.git.hns@goldelico.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Dec 28, 2016 at 03:53:17PM +0100, H. Nikolaus Schaller wrote:
> 1. check if chip is really present and don't succeed if it isn't.
> 2. if it succeeds, power down the chip until accessed
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

Applied, thank you.

> ---
>  drivers/input/touchscreen/tsc2007.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/tsc2007.c b/drivers/input/touchscreen/tsc2007.c
> index c1d9593..76b462b 100644
> --- a/drivers/input/touchscreen/tsc2007.c
> +++ b/drivers/input/touchscreen/tsc2007.c
> @@ -529,6 +529,14 @@ static int tsc2007_probe(struct i2c_client *client,
>  
>  	tsc2007_stop(ts);
>  
> +	/* power down the chip (TSC2007_SETUP does not ACK on I2C) */
> +	err = tsc2007_xfer(ts, PWRDOWN);
> +	if (err < 0) {
> +		dev_err(&client->dev,
> +			"Failed to setup chip: %d\n", err);
> +		return err;	/* usually, chip does not respond */
> +	}
> +
>  	err = input_register_device(input_dev);
>  	if (err) {
>  		dev_err(&client->dev,
> -- 
> 2.7.3
> 

-- 
Dmitry
