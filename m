Return-Path: <SRS0=Wx2m=2V=gmail.com=amsfield22@kernel.org>
Date: Sun, 12 Mar 2017 15:27:39 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: sayli karnik <karniksayli1995@gmail.com>
Cc: outreachy-kernel@googlegroups.com, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH v2 2/2] staging: iio: ad9834: Remove
 unnecessary goto label and compress return logic
Message-ID: <20170312222738.GB14070@d830.WORKGROUP>
References: <cover.1489356140.git.karniksayli1995@gmail.com>
 <59ddccc600cfd1594dcb4dadb44b80328fc06008.1489356140.git.karniksayli1995@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <59ddccc600cfd1594dcb4dadb44b80328fc06008.1489356140.git.karniksayli1995@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Mar 13, 2017 at 03:49:13AM +0530, sayli karnik wrote:
> The patch removes excessive goto label and compresses return logic.
> 
> Signed-off-by: sayli karnik <karniksayli1995@gmail.com>
> ---
>  drivers/staging/iio/frequency/ad9834.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
> index 60461a6..18f3e8f 100644
> --- a/drivers/staging/iio/frequency/ad9834.c
> +++ b/drivers/staging/iio/frequency/ad9834.c
> @@ -147,9 +147,8 @@ static ssize_t ad9834_write(struct device *dev,
>  	int ret;
>  	unsigned long val;
>  
> -	ret = kstrtoul(buf, 10, &val);
> -	if (ret)
> -		goto error_ret;
> +	if (kstrtoul(buf, 10, &val))
> +		return kstrtoul(buf, 10, &val);

Will a smaller change suffice?

ret = kstrtoul(buf, 10, &val);
if (ret)
-	goto error_ret;
+	return ret;

alisons

>  
>  	mutex_lock(&st->lock);
>  	switch ((u32)this_attr->address) {
> @@ -211,7 +210,6 @@ static ssize_t ad9834_write(struct device *dev,
>  	}
>  	mutex_unlock(&st->lock);
>  
> -error_ret:
>  	return ret ? ret : len;
>  }
>  
> -- 
> 2.7.4
> 
> -- 
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/59ddccc600cfd1594dcb4dadb44b80328fc06008.1489356140.git.karniksayli1995%40gmail.com.
> For more options, visit https://groups.google.com/d/optout.
