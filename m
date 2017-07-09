Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752267AbdGIRTQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 Jul 2017 13:19:16 -0400
Date: Sun, 9 Jul 2017 18:19:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        Jon.Brenner@ams.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/9] staging: iio: tsl2x7x: add of_match table for
 device tree support
Message-ID: <20170709181915.75fb62ad@kernel.org>
In-Reply-To: <20170706225626.6716-2-masneyb@onstation.org>
References: <20170706225626.6716-1-masneyb@onstation.org>
        <20170706225626.6716-2-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu,  6 Jul 2017 18:56:18 -0400
Brian Masney <masneyb@onstation.org> wrote:

> Add device tree support for the tsl2x7x IIO driver with no custom
> properties. The device tree documentation is in a separate commit so
> that the changes to trivial-devices.txt can go in via the device
> tree subsystem.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Mark Rutland <mark.rutland@arm.com>
> CC: devicetree@vger.kernel.org
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/light/tsl2x7x.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index 1467199..8148986 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -2026,6 +2026,21 @@ static struct i2c_device_id tsl2x7x_idtable[] = {
>  
>  MODULE_DEVICE_TABLE(i2c, tsl2x7x_idtable);
>  
> +static const struct of_device_id tsl2x7x_of_match[] = {
> +	{ .compatible = "amstaos,tsl2571" },
> +	{ .compatible = "amstaos,tsl2671" },
> +	{ .compatible = "amstaos,tmd2671" },
> +	{ .compatible = "amstaos,tsl2771" },
> +	{ .compatible = "amstaos,tmd2771" },
> +	{ .compatible = "amstaos,tsl2572" },
> +	{ .compatible = "amstaos,tsl2672" },
> +	{ .compatible = "amstaos,tmd2672" },
> +	{ .compatible = "amstaos,tsl2772" },
> +	{ .compatible = "amstaos,tmd2772" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, tsl2x7x_of_match);
> +
>  static const struct dev_pm_ops tsl2x7x_pm_ops = {
>  	.suspend = tsl2x7x_suspend,
>  	.resume  = tsl2x7x_resume,
> @@ -2035,6 +2050,7 @@ static const struct dev_pm_ops tsl2x7x_pm_ops = {
>  static struct i2c_driver tsl2x7x_driver = {
>  	.driver = {
>  		.name = "tsl2x7x",
> +		.of_match_table = tsl2x7x_of_match,
>  		.pm = &tsl2x7x_pm_ops,
>  	},
>  	.id_table = tsl2x7x_idtable,

