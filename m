Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727622AbeKKWh5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Nov 2018 17:37:57 -0500
Date: Sun, 11 Nov 2018 12:49:22 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matt Walker <mattofak@gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IIO: extend dac/MCP4922 to MCP49x1 devices
Message-ID: <20181111124827.26b7e086@archlinux>
In-Reply-To: <20181108203655.17448-1-mattofak@gmail.com>
References: <20181108203655.17448-1-mattofak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu,  8 Nov 2018 15:36:53 -0500
Matt Walker <mattofak@gmail.com> wrote:

> Extend the existing dual channel MCP4922 DAC driver to single channel
> MCP49x1 devices. These devices are simple and write only. The most
> significant bit of the transfer dictates what channel to write to.
> 
> Although there is no danger in writing to the non existant channel in
> the single channel devices, it's better to not register it at all.
> Therefore extend the driver to know how many channels a device has at
> probe time based on the ID table.
Definitely!
> 
> Signed-off-by: Matt Walker <mattofak@gmail.com>
Hi Matt,

Patch looks good, but I think this is now become complex enough we should
be looking at a level of indirection to give us something more extensible
on the long run.

See inline,

Thanks,

Jonathan

> ---
>  drivers/iio/dac/mcp4922.c | 30 ++++++++++++++++++++++++------
>  1 file changed, 24 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/dac/mcp4922.c b/drivers/iio/dac/mcp4922.c
> index b5190d1dae8e..094f7dd560ca 100644
> --- a/drivers/iio/dac/mcp4922.c
> +++ b/drivers/iio/dac/mcp4922.c
> @@ -29,8 +29,11 @@
>  #define MCP4922_NUM_CHANNELS	2
>  
>  enum mcp4922_supported_device_ids {
> +	ID_MCP4901,
>  	ID_MCP4902,
> +	ID_MCP4911,
>  	ID_MCP4912,
> +	ID_MCP4921,
>  	ID_MCP4922,
>  };
>  
> @@ -115,10 +118,22 @@ static int mcp4922_write_raw(struct iio_dev *indio_dev,
>  	}
>  }
>  
> -static const struct iio_chan_spec mcp4922_channels[3][MCP4922_NUM_CHANNELS] = {
> -	[ID_MCP4902] = { MCP4922_CHAN(0, 8),	MCP4922_CHAN(1, 8) },
> -	[ID_MCP4912] = { MCP4922_CHAN(0, 10),	MCP4922_CHAN(1, 10) },
> -	[ID_MCP4922] = { MCP4922_CHAN(0, 12),	MCP4922_CHAN(1, 12) },
> +static const unsigned int mcp4922_channel_counts[6] = {
> +	[ID_MCP4901] = 1,
> +	[ID_MCP4902] = 2,
> +	[ID_MCP4911] = 1,
> +	[ID_MCP4912] = 2,
> +	[ID_MCP4921] = 1,
> +	[ID_MCP4922] = 2,
> +};
> +
> +static const struct iio_chan_spec mcp4922_channels[6][MCP4922_NUM_CHANNELS] = {
> +	[ID_MCP4901] = { MCP4922_CHAN(0, 8),  {} },
> +	[ID_MCP4902] = { MCP4922_CHAN(0, 8),  MCP4922_CHAN(1, 8) },
> +	[ID_MCP4911] = { MCP4922_CHAN(0, 10), {} },
> +	[ID_MCP4912] = { MCP4922_CHAN(0, 10), MCP4922_CHAN(1, 10) },
> +	[ID_MCP4921] = { MCP4922_CHAN(0, 12), {} },
> +	[ID_MCP4922] = { MCP4922_CHAN(0, 12), MCP4922_CHAN(1, 12) },
>  };
It is getting to the point where a spot of indirection would make for a cleaner
result and prove easier to build on for future additions.

struct mcp4922_data {
	static const struct iio_chan_spec *channels;
	int num_channels;
};

//could use macros to simplify this but probably not worth it as only 3 copies.
static const struct iio_chan_spec mcp4902_channels[] = {
	MCP4922_CHAN(0, 8), MCP3922_CHAN(1, 8),
};

static const struct mcp4922_data[] = {
	[ID_MCP4901] = { mcp4902_channels, 1 },
	[ID_MCP4902] = { mcp4902_channels, 2 },
	... 
};


>  
>  static const struct iio_info mcp4922_info = {
> @@ -166,7 +181,7 @@ static int mcp4922_probe(struct spi_device *spi)
>  	indio_dev->info = &mcp4922_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->channels = mcp4922_channels[id->driver_data];
> -	indio_dev->num_channels = MCP4922_NUM_CHANNELS;
> +	indio_dev->num_channels = mcp4922_channel_counts[id->driver_data];
>  	indio_dev->name = id->name;
>  
>  	ret = iio_device_register(indio_dev);
> @@ -197,8 +212,11 @@ static int mcp4922_remove(struct spi_device *spi)
>  }
>  
>  static const struct spi_device_id mcp4922_id[] = {
> +	{"mcp4901", ID_MCP4901},
>  	{"mcp4902", ID_MCP4902},
> +	{"mcp4911", ID_MCP4911},
>  	{"mcp4912", ID_MCP4912},
> +	{"mcp4921", ID_MCP4921},
>  	{"mcp4922", ID_MCP4922},
>  	{}
>  };
> @@ -215,5 +233,5 @@ static struct spi_driver mcp4922_driver = {
>  module_spi_driver(mcp4922_driver);
>  
>  MODULE_AUTHOR("Michael Welling <mwelling@ieee.org>");
> -MODULE_DESCRIPTION("Microchip MCP4902, MCP4912, MCP4922 DAC");
> +MODULE_DESCRIPTION("Microchip MCP49xx DAC");
That wild card seems far to likely to hit devices it doesn't support
and end up causing confusion.  The usual nasty trick here is to
say something like

Microchip MCP4902 and similar DACs.

>  MODULE_LICENSE("GPL v2");
