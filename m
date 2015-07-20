Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:47819 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751534AbbGTRgm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jul 2015 13:36:42 -0400
From: "Tirdea, Irina" <irina.tirdea@intel.com>
To: Hartmut Knaack <knaack.h@gmx.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	"Dogaru, Vlad" <vlad.dogaru@intel.com>
Subject: RE: [PATCH 5/8] iio:magnetometer:bmc150_magn: add error handling on
 gpio probe
Date: Mon, 20 Jul 2015 17:36:39 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F2F06BB7E@irsmsx105.ger.corp.intel.com>
References: <cover.1437090791.git.knaack.h@gmx.de>
 <655373255075b12f451e644d81b36aa0588aa9c1.1437090791.git.knaack.h@gmx.de>
In-Reply-To: <655373255075b12f451e644d81b36aa0588aa9c1.1437090791.git.knaack.h@gmx.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



> -----Original Message-----
> From: Hartmut Knaack [mailto:knaack.h@gmx.de]
> Sent: 17 July, 2015 11:52
> To: linux-iio@vger.kernel.org
> Cc: Jonathan Cameron; Lars-Peter Clausen; Peter Meerwald; Tirdea, Irina; Dogaru, Vlad
> Subject: [PATCH 5/8] iio:magnetometer:bmc150_magn: add error handling on gpio probe
> 
> bmc150_magn_gpio_probe() may return some error codes, so better check
> them.
> 
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
> ---
>  drivers/iio/magnetometer/bmc150_magn.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
> index f1b6a4dc40ea..e1f804b2b244 100644
> --- a/drivers/iio/magnetometer/bmc150_magn.c
> +++ b/drivers/iio/magnetometer/bmc150_magn.c
> @@ -920,8 +920,13 @@ static int bmc150_magn_probe(struct i2c_client *client,
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->info = &bmc150_magn_info;
> 
> -	if (client->irq <= 0)
> +	if (client->irq <= 0) {
>  		client->irq = bmc150_magn_gpio_probe(client);
> +		if (client->irq < 0) {
> +			ret = client->irq;
> +			goto err_poweroff;
> +		}
> +	}

The error code for client->irq was not checked on purpose. We would like to be able to use this driver
even if the interrupt pin is not connected (reading from sysfs in poll mode or by using iio hrtimers). 

If the i2c core does not initialize the irq, we try to initialize it through ACPI in bmc150_magn_gpio_probe
and if that fails too we do not register the interrupt and iio trigger (see check for client->irq >0 below).
In this way we could still use the device even if we don't have interrupts.

> 
>  	if (client->irq > 0) {
>  		data->dready_trig = devm_iio_trigger_alloc(&client->dev,
> --
> 2.4.3

