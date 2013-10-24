Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35727 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754628Ab3JXMwj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 24 Oct 2013 08:52:39 -0400
Message-ID: <52692653.1060508@kernel.org>
Date: Thu, 24 Oct 2013 14:53:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 8/9] iio: dac: mcp4725: Remove redundant code
References: <1382615615-20153-1-git-send-email-sachin.kamat@linaro.org> <1382615615-20153-8-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1382615615-20153-8-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/24/13 12:53, Sachin Kamat wrote:
> Remove an inconsequential print message and return directly
> thereby cleaning up some code.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Applied to the toreg branch of iio.git
(same comment on does anyone care about the message drop?)
> ---
>  drivers/iio/dac/mcp4725.c |    8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
> index d982752..9f57ae8 100644
> --- a/drivers/iio/dac/mcp4725.c
> +++ b/drivers/iio/dac/mcp4725.c
> @@ -320,13 +320,7 @@ static int mcp4725_probe(struct i2c_client *client,
>  	data->powerdown_mode = pd ? pd-1 : 2; /* 500kohm_to_gnd */
>  	data->dac_value = (inbuf[1] << 4) | (inbuf[2] >> 4);
>  
> -	err = iio_device_register(indio_dev);
> -	if (err)
> -		return err;
> -
> -	dev_info(&client->dev, "MCP4725 DAC registered\n");
> -
> -	return 0;
> +	return iio_device_register(indio_dev);
>  }
>  
>  static int mcp4725_remove(struct i2c_client *client)
> 
