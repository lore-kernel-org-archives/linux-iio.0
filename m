Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42764 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753262AbbFUJsg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 21 Jun 2015 05:48:36 -0400
Message-ID: <55868872.5030406@kernel.org>
Date: Sun, 21 Jun 2015 10:48:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCHv2] iio: light: isl29125: Add scale_available information
References: <1434837098-30771-1-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1434837098-30771-1-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/06/15 22:51, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Applied to the togreg branch of iio.git - initially pushed out as
testing etc etc.

Thanks

Jonathan
> ---
> v1 didn't even compile, sorry
> 
>  drivers/iio/light/isl29125.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/iio/light/isl29125.c b/drivers/iio/light/isl29125.c
> index c82f4a6..b3cbbe8 100644
> --- a/drivers/iio/light/isl29125.c
> +++ b/drivers/iio/light/isl29125.c
> @@ -197,9 +197,21 @@ done:
>  	return IRQ_HANDLED;
>  }
>  
> +static IIO_CONST_ATTR(scale_available, "0.005722 0.152590");
> +
> +static struct attribute *isl29125_attributes[] = {
> +	&iio_const_attr_scale_available.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group isl29125_attribute_group = {
> +	.attrs = isl29125_attributes,
> +};
> +
>  static const struct iio_info isl29125_info = {
>  	.read_raw = isl29125_read_raw,
>  	.write_raw = isl29125_write_raw,
> +	.attrs = &isl29125_attribute_group,
>  	.driver_module = THIS_MODULE,
>  };
>  
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-iio" in
