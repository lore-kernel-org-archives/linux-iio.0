Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751061AbdFTQPb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 20 Jun 2017 12:15:31 -0400
Date: Tue, 20 Jun 2017 17:15:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: accel: bmc150: Add support for BOSC0200 ACPI
 device id
Message-ID: <20170620171524.20fd7a70@kernel.org>
In-Reply-To: <20170619062225.3402-1-hdegoede@redhat.com>
References: <20170619062225.3402-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 19 Jun 2017 08:22:25 +0200
Hans de Goede <hdegoede@redhat.com> wrote:

> Add support for the BOSC0200 ACPI device id used on some x86 tablets.
> note driver_data is not set to a specific model, driver_data is not
> used anyways (instead detection is done on the chip_id reg) and the
> 2 tablets with a BOSC0200 ACPI device id I've have 2 different chips,
> one has a BMA250E, the other a BMA222E.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Applied to the togreg branch of iio.git. Initially pushed out as testing
for the autobuilders to play with it.

Unfortunately I'm travelling currently so may or may not get another pull
request in to Greg before the next merge window opens.

Jonathan
> ---
>  drivers/iio/accel/bmc150-accel-i2c.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/accel/bmc150-accel-i2c.c b/drivers/iio/accel/bmc150-accel-i2c.c
> index 8ca8041267ef..f85014fbaa12 100644
> --- a/drivers/iio/accel/bmc150-accel-i2c.c
> +++ b/drivers/iio/accel/bmc150-accel-i2c.c
> @@ -64,6 +64,7 @@ static const struct acpi_device_id bmc150_accel_acpi_match[] = {
>  	{"BMA250E",	bma250e},
>  	{"BMA222E",	bma222e},
>  	{"BMA0280",	bma280},
> +	{"BOSC0200"},
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(acpi, bmc150_accel_acpi_match);

