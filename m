Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751683AbdLBMTc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 2 Dec 2017 07:19:32 -0500
Date: Sat, 2 Dec 2017 12:19:27 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jeremy Cline <jeremy@jcline.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Lars Kellogg-Stedman <lars@oddbit.com>,
        Steven Presser <steve@pressers.name>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/2] iio: accel: bmc150: Check for a second ACPI device
 for BOSC0200
Message-ID: <20171202121927.3b7aa028@archlinux>
In-Reply-To: <0100016009e7c30a-407c2980-d8d5-4506-ab47-d0fb2fed481d-000000@email.amazonses.com>
References: <20171129223016.17848-1-jeremy@jcline.org>
        <0100016009e7c30a-407c2980-d8d5-4506-ab47-d0fb2fed481d-000000@email.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 29 Nov 2017 22:31:12 +0000
Jeremy Cline <jeremy@jcline.org> wrote:

> Some BOSC0200 acpi_device-s describe two accelerometers in a single ACPI
> device. Check for a companion device and handle a second i2c_client
> if it is present.

+ Mika and Wolfram - please cc them on anything odd and i2c / ACPI related.
(I like to share the pain)

My usual question, just out of curiosity as we have to cope with this
fun anyway.  Are you actually allowed to do this under the ACPI spec
or not?  I would assume an acpi device is supposed to be just that A
device...  I fall asleep every time I try to read that spec ;)

Ah well. Rant over :)  Oh for the server world where mostly you just
send a WTF to the bios writer and they fix it.

So how to do this cleanly.. hmm.

One minor comment inline.  Don't hide what we are doing with the
private data member in the structure.  There is no reason to not
give it a type.

At least this one is a reasonably small hack ;)

Jonathan
> 
> Signed-off-by: Jeremy Cline <jeremy@jcline.org>
> ---
>  drivers/iio/accel/bmc150-accel-i2c.c | 33 ++++++++++++++++++++++++++++++++-
>  drivers/iio/accel/bmc150-accel.h     |  1 +
>  2 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/bmc150-accel-i2c.c b/drivers/iio/accel/bmc150-accel-i2c.c
> index f85014fbaa12..c4557e18123c 100644
> --- a/drivers/iio/accel/bmc150-accel-i2c.c
> +++ b/drivers/iio/accel/bmc150-accel-i2c.c
> @@ -31,6 +31,10 @@
>  static int bmc150_accel_probe(struct i2c_client *client,
>  			      const struct i2c_device_id *id)
>  {
> +	int ret;
> +	struct acpi_device *adev;
> +	struct i2c_board_info board_info;
> +	struct bmc150_accel_data *data;
>  	struct regmap *regmap;
>  	const char *name = NULL;
>  	bool block_supported =
> @@ -47,12 +51,39 @@ static int bmc150_accel_probe(struct i2c_client *client,
>  	if (id)
>  		name = id->name;
>  
> -	return bmc150_accel_core_probe(&client->dev, regmap, client->irq, name,
> +	ret = bmc150_accel_core_probe(&client->dev, regmap, client->irq, name,
>  				       block_supported);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Some BOSC0200 acpi_devices describe 2 accelerometers in a single ACPI
> +	 * device, try instantiating a second i2c_client for an I2cSerialBusV2
> +	 * ACPI resource with index 1.
> +	 */
> +	adev = ACPI_COMPANION(&client->dev);
> +	if (adev && strcmp(acpi_device_hid(adev), "BOSC0200") == 0) {
> +		data = i2c_get_clientdata(client);
> +		memset(&board_info, 0, sizeof(board_info));
> +		strlcpy(board_info.type, "bma250e", I2C_NAME_SIZE);
> +		data->driver_priv = i2c_acpi_new_device(&client->dev,
> +							1, &board_info);
> +		/*
> +		 * Don't check for bosc0200 == NULL since most BOSC0200 ACPI
> +		 * devices describe only one i2c_client
> +		 */
> +	}
> +
> +	return ret;
>  }
>  
>  static int bmc150_accel_remove(struct i2c_client *client)
>  {
> +	struct bmc150_accel_data *data = i2c_get_clientdata(client);
> +
> +	if (data->driver_priv)
> +		i2c_unregister_device(data->driver_priv);
> +
>  	return bmc150_accel_core_remove(&client->dev);
>  }
>  
> diff --git a/drivers/iio/accel/bmc150-accel.h b/drivers/iio/accel/bmc150-accel.h
> index c38754452883..7f49a09b136f 100644
> --- a/drivers/iio/accel/bmc150-accel.h
> +++ b/drivers/iio/accel/bmc150-accel.h
> @@ -47,6 +47,7 @@ struct bmc150_accel_data {
>  	int ev_enable_state;
>  	int64_t timestamp, old_timestamp; /* Only used in hw fifo mode. */
>  	const struct bmc150_accel_chip_info *chip_info;
> +	void *driver_priv;

I'd be explicit about what this is rather than just calling it driver_priv.

Also patch 1 was entirely to expose this data element.  Adding simple
bmc150_get_second_device() / bcm150_set_second_device call would avoid that.

>  };
>  
>  struct regmap;

