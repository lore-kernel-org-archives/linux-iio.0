Return-Path: <glikely@secretlab.ca>
Sender: Grant Likely <glikely@secretlab.ca>
Date: Mon, 2 Jan 2012 01:58:51 -0700
From: Grant Likely <grant.likely@secretlab.ca>
To: Olof Johansson <olof@lixom.net>
Cc: Jonathan Cameron <jic23@cam.ac.uk>, Greg Kroah-Hartman <gregkh@suse.de>,
	linux-iio@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Subject: Re: [PATCH] staging:iio: isl29018: add of_match table for
 device-tree probing
Message-ID: <20120102085851.GL18381@ponder.secretlab.ca>
References: <1324608283-3128-1-git-send-email-olof@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1324608283-3128-1-git-send-email-olof@lixom.net>
List-ID: <linux-iio@vger.kernel.org>

On Thu, Dec 22, 2011 at 06:44:43PM -0800, Olof Johansson wrote:
> As simple as can be right now; just one ID and no custom properties to parse.
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
>  drivers/staging/iio/light/isl29018.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
> index 849d6a5..38ec52b 100644
> --- a/drivers/staging/iio/light/isl29018.c
> +++ b/drivers/staging/iio/light/isl29018.c
> @@ -592,11 +592,18 @@ static const struct i2c_device_id isl29018_id[] = {
>  
>  MODULE_DEVICE_TABLE(i2c, isl29018_id);
>  
> +static const struct of_device_id isl29018_of_match[] = {
> +	{ .compatible = "invn,isl29018", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, isl29018_of_match);
> +
>  static struct i2c_driver isl29018_driver = {
>  	.class	= I2C_CLASS_HWMON,
>  	.driver	 = {
>  			.name = "isl29018",
>  			.owner = THIS_MODULE,
> +			.of_match_table = isl29018_of_match,
>  		    },
>  	.probe	 = isl29018_probe,
>  	.remove	 = __devexit_p(isl29018_remove),
> -- 
> 1.7.8.GIT
> 
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
