Return-Path: <SRS0=nxDZ=AG=metafoo.de=lars@kernel.org>
Subject: Re: [PATCH] iio: core: Return error for failed read_reg
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Matt Fornero <matt.fornero@mathworks.com>, linux-iio@vger.kernel.org
References: <20170905143410.29158-1-lars@metafoo.de>
Message-ID: <1fab0e99-d968-3f26-2bc0-76a677173110@metafoo.de>
Date: Tue, 5 Sep 2017 17:20:57 +0200
MIME-Version: 1.0
In-Reply-To: <20170905143410.29158-1-lars@metafoo.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 09/05/2017 04:34 PM, Lars-Peter Clausen wrote:
> From: Matt Fornero <matt.fornero@mathworks.com>
> 
> If an IIO device returns an error code for a read access via debugfs, it
> is currently ignored by the IIO core (other than emitting an error
> message). Instead, return this error code to user space, so upper layers
> can detect it correctly.
> 
> Signed-off-by: Matt Fornero <matt.fornero@mathworks.com>

Sorry, this should also have had:

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

> ---
>  drivers/iio/industrialio-core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 7a5aa127c52e..9c4cfd19b739 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -310,8 +310,10 @@ static ssize_t iio_debugfs_read_reg(struct file *file, char __user *userbuf,
>  	ret = indio_dev->info->debugfs_reg_access(indio_dev,
>  						  indio_dev->cached_reg_addr,
>  						  0, &val);
> -	if (ret)
> +	if (ret) {
>  		dev_err(indio_dev->dev.parent, "%s: read failed\n", __func__);
> +		return ret;
> +	}
>  
>  	len = snprintf(buf, sizeof(buf), "0x%X\n", val);
>  
> 
