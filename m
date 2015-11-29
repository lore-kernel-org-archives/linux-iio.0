Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43768 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753061AbbK2OSf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 29 Nov 2015 09:18:35 -0500
Subject: Re: [PATCH 1/2] iio: adc: mcp3422: Add mcp3421 support
To: Sascha Hauer <s.hauer@pengutronix.de>, linux-iio@vger.kernel.org
References: <1448632372-5315-1-git-send-email-s.hauer@pengutronix.de>
 <1448632372-5315-2-git-send-email-s.hauer@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <565B0938.8010103@kernel.org>
Date: Sun, 29 Nov 2015 14:18:32 +0000
MIME-Version: 1.0
In-Reply-To: <1448632372-5315-2-git-send-email-s.hauer@pengutronix.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/11/15 13:52, Sascha Hauer wrote:
> The mcp3421 is the single channel variant of the mcp342x family. Support
> is straight forward, only the channels array has to be added for this
> chip.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Thanks

Applied to the togreg branch of iio.git - initially pushed out as testing.
Note that the branch will get rebased once the previous pull has unwound
itself.

Jonathan
> ---
>  drivers/iio/adc/mcp3422.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
> index 3555122..6eca7ae 100644
> --- a/drivers/iio/adc/mcp3422.c
> +++ b/drivers/iio/adc/mcp3422.c
> @@ -305,6 +305,10 @@ static const struct attribute_group mcp3422_attribute_group = {
>  	.attrs = mcp3422_attributes,
>  };
>  
> +static const struct iio_chan_spec mcp3421_channels[] = {
> +	MCP3422_CHAN(0),
> +};
> +
>  static const struct iio_chan_spec mcp3422_channels[] = {
>  	MCP3422_CHAN(0),
>  	MCP3422_CHAN(1),
> @@ -352,6 +356,10 @@ static int mcp3422_probe(struct i2c_client *client,
>  	indio_dev->info = &mcp3422_info;
>  
>  	switch (adc->id) {
> +	case 1:
> +		indio_dev->channels = mcp3421_channels;
> +		indio_dev->num_channels = ARRAY_SIZE(mcp3421_channels);
> +		break;
>  	case 2:
>  	case 3:
>  	case 6:
> @@ -383,6 +391,7 @@ static int mcp3422_probe(struct i2c_client *client,
>  }
>  
>  static const struct i2c_device_id mcp3422_id[] = {
> +	{ "mcp3421", 1 },
>  	{ "mcp3422", 2 },
>  	{ "mcp3423", 3 },
>  	{ "mcp3424", 4 },
> 

