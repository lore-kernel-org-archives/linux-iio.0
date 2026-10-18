Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D29427603F;
	Sun, 18 Oct 2026 23:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792366544; cv=none; b=srZGgy7SkM3OYptllu6EBFYgLyL5gaz3XXDpNCmyJ4DKGznMyYQbLXbzZjlpy/W4L0KGe+iYyPHuEfMKrdHjyQT7fGfQA6zObn2OcWF7Q58/Fq/veCrg6F8f2IDuiOVs8YCk49tmSrFDnQ0nJKajHNw//qQlk+tfgVoyW5nzFfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792366544; c=relaxed/simple;
	bh=snoflEx/q8vayezJt95DyHxVw+uoK4j4eNOwlls+J1o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aggiUlsDZqKGDzI1hV7iLXwsNIdTkhLoZ/B0SWdSNssN3NDTTViyGbYmm5tTb7x9ji+1CZ7QfWEXASfhOXHLo/rD6roaQyZV/pmSIJ6d3+GUJYHUo7aYdhzQ4QYUOj4FYkOU30W7Uvkwzf4wEd6OynNPrMMNwH+9CiFrWu9BmKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wez2HOfo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wez2HOfo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 559671F000C4;
	Sun, 18 Oct 2026 23:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792366543;
	bh=DqFqrz+5RnxxxPjeHegXNpR9f1B3r0EVBiH+BJlB7yE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Wez2HOfoFU4XTOe6YBt3+wOwOwc/WebQBLERf13nobmiQlB3vu07JOCiUo6VhiooW
	 FckmMczvz15qF6Gd71fg0dmgcmmT8GHAnj3Hi9yqRZFF2qAX4WCMxqUjofBf2L4p0d
	 3rCAj4yM2BZ1YotRpc1T7dcKml+wUB8JZGKFU0bd4HQDIHOibmMfC0e/n+z/oZm2EG
	 5TWSUTn5ghO/a00LFqmSO5YDOtCxNTWB+3NU56E40q880emHEZ1J6Imc5cdR9mIsjS
	 GUGRLRMj08XvAOdwigFR9+1oSrRdDoW1C26SYq2TpgdYqgUeXEht4Vz8yYeIdLp8E4
	 xcFVJDBqZw89A==
Date: Mon, 19 Oct 2026 00:35:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Michal Simek
 <michal.simek@amd.com>, Conall O'Griofa <conall.ogriofa@amd.com>,
 <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <git@amd.com>, Sai Krishna Potthuri
 <sai.krishna.potthuri@amd.com>
Subject: Re: [PATCH v4 15/15] iio: adc: xilinx-xadc: Add I2C interface
 support
Message-ID: <20261019003537.617423a8@jic23-hlaptop>
In-Reply-To: <20261005094205.1045874-16-dileepkumar.nagavarapu@amd.com>
References: <20261005094205.1045874-1-dileepkumar.nagavarapu@amd.com>
	<20261005094205.1045874-16-dileepkumar.nagavarapu@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 Oct 2026 15:12:05 +0530
Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com> wrote:

> Add I2C interface support for Xilinx System Management Wizard IP along
> with the existing AXI memory-mapped interface. This support enables
> monitoring the voltage and temperature on UltraScale+ devices where the
> System Management Wizard is connected via I2C.
> 
> Key changes:
> - Implement 32-bit DRP (Dynamic Reconfiguration Port) packet format
>   as per Xilinx PG185 specification.
> - Add separate I2C probe with xadc_i2c_of_match_table to handle same
>   compatible string ("xlnx,system-management-wiz-1.3") on I2C bus.
> - Add NULL checks for get_dclk_rate callback function in sampling rate
>   functions to support interfaces without clock control
> - Create separate iio_info structure(xadc_i2c_info) without event
>   callbacks for I2C devices
> - Add xadc_i2c_transaction() function to handle I2C read/write operations
> - Add XADC_TYPE_US_I2C type to distinguish I2C interface from AXI
> - Defer XADC hardware initialization until first device access, since the
>   I2C path reaches the PL SysMon indirectly through a platform controller
>   DRP bridge that may not yet be operational at probe() time. Initializing
>   on first read/write instead avoids probe failures caused by transient
>   unavailability of that downstream path.
> 
> Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> Signed-off-by: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
Hi Dileep,

Various comments inline - mostly stuff where we can make things
a little more readable or extensible.

Jonathan

> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> index 2addb61cf5b1..80199c4ddf69 100644
> --- a/drivers/iio/adc/xilinx-xadc-core.c
> +++ b/drivers/iio/adc/xilinx-xadc-core.c
> @@ -227,7 +227,7 @@ static int xadc_power_adc_b(struct xadc *xadc, unsigned int seq_mode)
>  	 * non-existing ADC-B powers down the main ADC, so just return and don't
>  	 * do anything.
>  	 */
> -	if (xadc->ops->type == XADC_TYPE_US)
> +	if (xadc->ops->type == XADC_TYPE_US || xadc->ops->type == XADC_TYPE_US_I2C)
>  		return 0;
Maybe add what ever this is similar to below. If it's in the ops structure
we avoid having to add new types like this.

>  
>  	/* Powerdown the ADC-B when it is not needed. */
> @@ -249,7 +249,7 @@ static int xadc_get_seq_mode(struct xadc *xadc, unsigned long scan_mode)
>  	unsigned int aux_scan_mode = scan_mode >> 16;
>  
>  	/* UltraScale has only one ADC and supports only continuous mode */
> -	if (xadc->ops->type == XADC_TYPE_US)
> +	if (xadc->ops->type == XADC_TYPE_US || xadc->ops->type == XADC_TYPE_US_I2C)
>  		return XADC_CONF1_SEQ_CONTINUOUS;

Perhaps add this to the ops structure as well as a field called something like
bool continuous_only;

>  
>  	if (xadc->external_mux_mode == XADC_EXTERNAL_MUX_DUAL)

>  
>  struct iio_dev *xadc_device_setup(struct device *dev, int size, const struct xadc_ops **ops)
> @@ -784,7 +797,11 @@ struct iio_dev *xadc_device_setup(struct device *dev, int size, const struct xad
>  		return ERR_PTR(-ENOMEM);
>  
>  	indio_dev->name = xadc_type_names[(*ops)->type];
> -	indio_dev->info = &xadc_info;
> +	if ((*ops)->type == XADC_TYPE_US_I2C)

Why not put the info in the ops structure?  Then you can set it
unconditionally here.  Generally matching a 'type' ends up
messier than just adding more stuff to the type specific structure.

> +		indio_dev->info = &xadc_i2c_info;
> +	else
> +		indio_dev->info = &xadc_info;

> diff --git a/drivers/iio/adc/xilinx-xadc-i2c.c b/drivers/iio/adc/xilinx-xadc-i2c.c
> new file mode 100644
> index 000000000000..cee2f7b3f9bd
> --- /dev/null
> +++ b/drivers/iio/adc/xilinx-xadc-i2c.c

> +
> +#include <linux/iio/iio.h>
> +
> +#include "xilinx-xadc.h"
> +
> +#define XADC_I2C_READ_DATA_SIZE		2
> +#define XADC_I2C_WRITE_DATA_SIZE	4	/* 32-bit DRP packet */
Hmm. Put this as a terminating entry in an enum with the DRP elements
below. The it becomes clear how they are associated with each other.

> +#define XADC_I2C_INSTR_READ		BIT(2)
> +#define XADC_I2C_INSTR_WRITE		BIT(3)
> +
> +#define XADC_I2C_DRP_DATA0_MASK		GENMASK(7, 0)
> +#define XADC_I2C_DRP_DATA1_MASK		GENMASK(15, 8)
> +#define XADC_I2C_DRP_ADDR_MASK		GENMASK(7, 0)
All of these seem unnecessary. See below
> +
> +/* Byte offsets within the 32-bit DRP packet, per Xilinx PG185 */
> +#define XADC_I2C_DRP_DATA_LOW		0
> +#define XADC_I2C_DRP_DATA_HIGH		1
> +#define XADC_I2C_DRP_ADDR		2
> +#define XADC_I2C_DRP_INSTR		3

> +
> +static int xadc_i2c_read_transaction(struct xadc *xadc, unsigned int reg, u16 *val)
> +{
> +	struct xadc_i2c *xadc_i2c = container_of(xadc, struct xadc_i2c, xadc);
> +	u8 write_buffer[XADC_I2C_WRITE_DATA_SIZE] = { 0 };

Might as well set the values you have below here rather than init to 0 and then
override.

> +	struct i2c_client *client = xadc_i2c->client;
> +	u8 read_buffer[XADC_I2C_READ_DATA_SIZE];
> +	int ret;
> +
> +	write_buffer[XADC_I2C_DRP_ADDR] = FIELD_GET(XADC_I2C_DRP_ADDR_MASK, reg);
As below. Not seeing much value in this FIELD_PREP as the reg should always fit

I think?

> +	write_buffer[XADC_I2C_DRP_INSTR] = XADC_I2C_INSTR_READ;
> +
> +	ret = i2c_master_send(client, write_buffer, XADC_I2C_WRITE_DATA_SIZE);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = i2c_master_recv(client, read_buffer, XADC_I2C_READ_DATA_SIZE);
> +	if (ret < 0)
> +		return ret;
> +
> +	*val = FIELD_PREP(XADC_I2C_DRP_DATA0_MASK, read_buffer[XADC_I2C_DRP_DATA_LOW]) |
> +	       FIELD_PREP(XADC_I2C_DRP_DATA1_MASK, read_buffer[XADC_I2C_DRP_DATA_HIGH]);
	*val = get_unaligned_le16(&read_buffer[XADC_I2C_DRP_DATA_LOW]);

> +
> +	return 0;
> +}
> +
> +static int xadc_i2c_write_transaction(struct xadc *xadc, unsigned int reg, u16 val)
> +{
> +	struct xadc_i2c *xadc_i2c = container_of(xadc, struct xadc_i2c, xadc);
> +	struct i2c_client *client = xadc_i2c->client;
> +	u8 write_buffer[XADC_I2C_WRITE_DATA_SIZE];
> +	int ret;
> +
> +	/* low byte of the 16-bit DRP data value */
> +	write_buffer[XADC_I2C_DRP_DATA_LOW] = FIELD_GET(XADC_I2C_DRP_DATA0_MASK, val);
> +	/* high byte of the 16-bit DRP data value */
> +	write_buffer[XADC_I2C_DRP_DATA_HIGH] = FIELD_GET(XADC_I2C_DRP_DATA1_MASK, val);

	put_unaligned_le16(val, &write_buffer[XADC_I2C_DRP_DATA_LOW]);
and no comments needed.

> +	write_buffer[XADC_I2C_DRP_ADDR] = FIELD_GET(XADC_I2C_DRP_ADDR_MASK, reg);

Given this is just a clamp to size of something that I assume always fits,
I'd drop the FIELD_PREP as providing no value.

> +	write_buffer[XADC_I2C_DRP_INSTR] = XADC_I2C_INSTR_WRITE;
> +
> +	ret = i2c_master_send(client, write_buffer, XADC_I2C_WRITE_DATA_SIZE);

I guess in this particular case we know what the i2c master is so can assume
this never runs short?  (in practice they never do but I think the interface
allows for that case).

> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}



> +
> +static int xadc_i2c_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	unsigned int conf0, bipolar_mask;
> +	const struct xadc_ops *ops;
> +	struct iio_dev *indio_dev;
> +	struct xadc_i2c *xadc_i2c;
> +	struct xadc *xadc;
> +	int ret;
> +
> +	indio_dev = xadc_device_setup(dev, sizeof(*xadc_i2c), &ops);
> +	if (IS_ERR(indio_dev))
> +		return PTR_ERR(indio_dev);
> +
> +	xadc_i2c = iio_priv(indio_dev);
> +	xadc_i2c->client = client;
> +	xadc = &xadc_i2c->xadc;

It might be worth a little helper for here...

> +	xadc->ops = ops;
> +
> +	ret = devm_mutex_init(dev, &xadc->mutex);
> +	if (ret)
> +		return ret;
> +
> +	spin_lock_init(&xadc->lock);

to here to initialize the xadc structure as I don't think
the individual drivers should really know about xadc->lock etc.


> +
> +	ret = xadc_device_configure(indio_dev, 0, &conf0, &bipolar_mask);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to setup the device\n");
> +
> +	xadc_i2c->conf0 = conf0;
> +	xadc_i2c->bipolar_mask = bipolar_mask;
> +	xadc_i2c->hw_initialized = false;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static const struct of_device_id xadc_i2c_of_match_table[] = {
> +	{
> +		.compatible = "xlnx,system-management-wiz-1.3",
> +		.data = &xadc_system_mgmt_wiz_i2c_ops,
> +	},
> +	{}
Trivial but local IIO preference is
	{ }

I wanted to standardise these on something, and happened to pick
that a few years back.

> +};
> +MODULE_DEVICE_TABLE(of, xadc_i2c_of_match_table);

