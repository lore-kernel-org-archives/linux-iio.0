Return-Path: <glikely@secretlab.ca>
Sender: Grant Likely <glikely@secretlab.ca>
Date: Mon, 2 Jan 2012 01:58:27 -0700
From: Grant Likely <grant.likely@secretlab.ca>
To: Olof Johansson <olof@lixom.net>
Cc: Jonathan Cameron <jic23@cam.ac.uk>, Greg Kroah-Hartman <gregkh@suse.de>,
	linux-iio@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Subject: Re: [PATCH] staging:iio: ak8975: add of_match table for device-tree
 probing
Message-ID: <20120102085827.GK18381@ponder.secretlab.ca>
References: <1324608402-3241-1-git-send-email-olof@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1324608402-3241-1-git-send-email-olof@lixom.net>
List-ID: <linux-iio@vger.kernel.org>

On Thu, Dec 22, 2011 at 06:46:42PM -0800, Olof Johansson wrote:
> Just like isl29018; trivial addition. Using both asahi-kasei,ak8975 and
> the non-prefixed version (I couldn't figure out if Asahi Kasei had a
> stock symbol to use, I only found numerical indexes for their stock info).
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
>  drivers/staging/iio/magnetometer/ak8975.c |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/staging/iio/magnetometer/ak8975.c b/drivers/staging/iio/magnetometer/ak8975.c
> index 3158f12..d5ddac3 100644
> --- a/drivers/staging/iio/magnetometer/ak8975.c
> +++ b/drivers/staging/iio/magnetometer/ak8975.c
> @@ -564,9 +564,17 @@ static const struct i2c_device_id ak8975_id[] = {
>  
>  MODULE_DEVICE_TABLE(i2c, ak8975_id);
>  
> +static const struct of_device_id ak8975_of_match[] = {
> +	{ .compatible = "asahi-kasei,ak8975", },
> +	{ .compatible = "ak8975", },

Unless there is a really good reason for it, drop the non-prefixed version.

Otherwise it looks okay by me.

g.

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ak8975_of_match);
> +
>  static struct i2c_driver ak8975_driver = {
>  	.driver = {
>  		.name	= "ak8975",
> +		.of_match_table = ak8975_of_match,
>  	},
>  	.probe		= ak8975_probe,
>  	.remove		= __devexit_p(ak8975_remove),
> -- 
> 1.7.8.GIT
> 
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
