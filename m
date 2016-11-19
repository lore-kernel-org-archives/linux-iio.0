Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36302 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750958AbcKSSMe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 19 Nov 2016 13:12:34 -0500
Date: Sat, 19 Nov 2016 10:12:29 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Welling <mwelling@ieee.org>,
        Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila@nextfour.com>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Igor Grinberg <grinberg@compulab.co.il>,
        Sebastian Reichel <sre@kernel.org>,
        "Andrew F. Davis" <afd@ti.com>, Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Sangwon Jee <jeesw@melfas.com>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, letux-kernel@openphoenux.org,
        linux-iio@vger.kernel.org, kernel@pyra-handheld.com
Subject: Re: [PATCH v6 2/8] drivers:input:tsc2007: send pendown and penup
 only once like ads7846(+tsc2046) driver does
Message-ID: <20161119181229.GA20446@dtor-ws>
References: <cover.1477557860.git.hns@goldelico.com>
 <5e961a92f11b1509bd0effb96ef560f19839aa9d.1477557860.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5e961a92f11b1509bd0effb96ef560f19839aa9d.1477557860.git.hns@goldelico.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Oct 27, 2016 at 10:44:15AM +0200, H. Nikolaus Schaller wrote:
> this should reduce unnecessary input events.

The duplicates will be filtered out by the input core anyway. I like to
keep the drivers simple.

Thanks.

> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  drivers/input/touchscreen/tsc2007.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/tsc2007.c b/drivers/input/touchscreen/tsc2007.c
> index c1d9593..e9d5086 100644
> --- a/drivers/input/touchscreen/tsc2007.c
> +++ b/drivers/input/touchscreen/tsc2007.c
> @@ -94,6 +94,7 @@ struct tsc2007 {
>  
>  	wait_queue_head_t	wait;
>  	bool			stopped;
> +	bool			pendown;
>  
>  	int			(*get_pendown_state)(struct device *);
>  	void			(*clear_penirq)(void);
> @@ -227,7 +228,11 @@ static irqreturn_t tsc2007_soft_irq(int irq, void *handle)
>  				sx, sy, rt);
>  
>  			/* report event */
> -			input_report_key(input, BTN_TOUCH, 1);
> +			if (!ts->pendown) {
> +				input_report_key(input, BTN_TOUCH, 1);
> +				ts->pendown = true;
> +			}
> +
>  			touchscreen_report_pos(ts->input, &ts->prop,
>  						(unsigned int) sx,
>  						(unsigned int) sy,
> @@ -250,9 +255,13 @@ static irqreturn_t tsc2007_soft_irq(int irq, void *handle)
>  
>  	dev_dbg(&ts->client->dev, "UP\n");
>  
> -	input_report_key(input, BTN_TOUCH, 0);
> -	input_report_abs(input, ABS_PRESSURE, 0);
> -	input_sync(input);
> +	if (ts->pendown) {
> +		input_report_key(input, BTN_TOUCH, 0);
> +		input_report_abs(input, ABS_PRESSURE, 0);
> +		input_sync(input);
> +
> +		ts->pendown = false;
> +	}
>  
>  	if (ts->clear_penirq)
>  		ts->clear_penirq();
> -- 
> 2.7.3
> 

-- 
Dmitry
