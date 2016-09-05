Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58106 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932605AbcIEUTT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Sep 2016 16:19:19 -0400
Subject: Re: [PATCH] iio: accel: mxc6255 add support for the mxc6225
To: Hans de Goede <hdegoede@redhat.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Teodora Baluta <teodora.baluta@intel.com>
References: <20160904173532.18994-1-hdegoede@redhat.com>
Cc: linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <7b90317d-363d-d690-a8ac-61fbc3a0acf8@kernel.org>
Date: Mon, 5 Sep 2016 21:19:16 +0100
MIME-Version: 1.0
In-Reply-To: <20160904173532.18994-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/09/16 18:35, Hans de Goede wrote:
> The mxc6225 is fully compatible with the existing mxc6255 driver,
> add support for it.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Ah well. Can't find any docs on this on via google so I'll take
your word for it :)

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/accel/mxc6255.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/mxc6255.c b/drivers/iio/accel/mxc6255.c
> index 97ccde7..50343a7 100644
> --- a/drivers/iio/accel/mxc6255.c
> +++ b/drivers/iio/accel/mxc6255.c
> @@ -26,6 +26,7 @@
>  #define MXC6255_REG_YOUT		0x01
>  #define MXC6255_REG_CHIP_ID		0x08
>  
> +#define MXC6225_CHIP_ID			0xe5
>  #define MXC6255_CHIP_ID			0x05
>  
>  /*
> @@ -154,7 +155,11 @@ static int mxc6255_probe(struct i2c_client *client,
>  		return ret;
>  	}
>  
> -	if (chip_id != MXC6255_CHIP_ID) {
> +	switch (chip_id) {
> +	case MXC6225_CHIP_ID:
> +	case MXC6255_CHIP_ID:
> +		break;
> +	default:
>  		dev_err(&client->dev, "Invalid chip id %x\n", chip_id);
>  		return -ENODEV;
>  	}
> @@ -171,12 +176,14 @@ static int mxc6255_probe(struct i2c_client *client,
>  }
>  
>  static const struct acpi_device_id mxc6255_acpi_match[] = {
> +	{"MXC6225",	0},
>  	{"MXC6255",	0},
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(acpi, mxc6255_acpi_match);
>  
>  static const struct i2c_device_id mxc6255_id[] = {
> +	{"mxc6225",	0},
>  	{"mxc6255",	0},
>  	{ }
>  };
> 

