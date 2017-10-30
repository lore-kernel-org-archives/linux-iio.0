Return-Path: <SRS0=p4YK=B5=metafoo.de=lars@kernel.org>
Subject: Re: [PATCH v3] iio : Add cm3218 smbus ara and acpi support
To: Marc CAPDEVILLE <m.capdeville@no-log.org>,
 Kevin Tsai <ktsai@capellamicro.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Wolfram Sang
 <wsa@the-dreams.de>, Hartmut Knaack <knaack.h@gmx.de>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20171027132051.sw5m5iboowlsrxxb@azrael>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <6ac0c8cf-3ee8-ccc0-75c6-ec87f127857a@metafoo.de>
Date: Mon, 30 Oct 2017 11:54:59 +0100
MIME-Version: 1.0
In-Reply-To: <20171027132051.sw5m5iboowlsrxxb@azrael>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 10/27/2017 03:20 PM, Marc CAPDEVILLE wrote:
> On asus T100, Capella cm3218 chip is implemented as ambiant light
> sensor. This chip expose an smbus ARA protocol device on standard
> address 0x0c. The chip is not functional before all alerts are
> acknowledged.
> On asus T100, this device is enumerated on ACPI bus and the description
> give tow I2C connection. The first is the connection to the ARA device

two

> and the second gives the real address of the device.

Is there a document somewhere describing what this ARA stuff is and how it
works? Is this "Project ARA"?

> 
> So, on device probe,If the i2c address is the ARA address and the
> device is enumerated via acpi, we lookup for the real address in
> the ACPI resource list and change it in the client structure.
> if an interrupt resource is given, and only for cm3218 chip,
> we declare an smbus_alert device.
> 
> Signed-off-by: Marc CAPDEVILLE <m.capdeville@no-log.org>
[...]
> +/* Get the real i2c address from acpi resources */
> +static int cm3218_acpi_get_address(struct i2c_client *client)
> +{
> +	int ret;
> +	struct acpi_device *adev;
> +	LIST_HEAD(res_list);
> +	struct resource_entry *res_entry;
> +	struct acpi_resource *ares;
> +	struct acpi_resource_i2c_serialbus *sb;
> +
> +	adev = ACPI_COMPANION(&client->dev);
> +	if (!adev)
> +		return -ENODEV;
> +
> +	ret = acpi_dev_get_resources(adev,
> +				     &res_list,
> +				     cm3218_filter_i2c_address,
> +				     client);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* get first resource */
> +	res_entry = list_entry(&res_list, struct resource_entry, node);
> +	ares = (struct acpi_resource *)res_entry->res;
> +	sb = &ares->data.i2c_serial_bus;
> +
> +	/* set i2c address */
> +	client->addr = sb->slave_address;
> +	client->flags &= ~I2C_CLIENT_TEN;

I'm not convinced overwriting the address and flags is legal. Those are
owned by the I2C core and should be read-only in the client driver. Maybe
use i2c_new_dummy() to create a device for the new address?

> +	if (sb->access_mode == ACPI_I2C_10BIT_MODE)
> +		client->flags |= I2C_CLIENT_TEN;
> +
> +	acpi_dev_free_resource_list(&res_list);
> +
> +	return 0;
> +}
[...]
