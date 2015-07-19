Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46040 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752819AbbGSKGa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 19 Jul 2015 06:06:30 -0400
Message-ID: <55AB76A3.7040507@kernel.org>
Date: Sun, 19 Jul 2015 11:06:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Irina Tirdea <irina.tirdea@intel.com>,
	Vlad Dogaru <vlad.dogaru@intel.com>
Subject: Re: [PATCH 5/8] iio:magnetometer:bmc150_magn: add error handling
 on gpio probe
References: <cover.1437090791.git.knaack.h@gmx.de> <655373255075b12f451e644d81b36aa0588aa9c1.1437090791.git.knaack.h@gmx.de>
In-Reply-To: <655373255075b12f451e644d81b36aa0588aa9c1.1437090791.git.knaack.h@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/07/15 09:52, Hartmut Knaack wrote:
> bmc150_magn_gpio_probe() may return some error codes, so better check
> them.
> 
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
Another kind of obvious improvement.  Obviously comments still welcome
from others.  Applied to the togreg branch of iio.git

Thanks,

Jonathan
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
>  
>  	if (client->irq > 0) {
>  		data->dready_trig = devm_iio_trigger_alloc(&client->dev,
> 

