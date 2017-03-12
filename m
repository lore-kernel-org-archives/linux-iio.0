Return-Path: <SRS0=yEHH=2V=lip6.fr=julia.lawall@kernel.org>
Date: Sun, 12 Mar 2017 23:28:20 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
To: sayli karnik <karniksayli1995@gmail.com>
cc: outreachy-kernel@googlegroups.com, Lars-Peter Clausen <lars@metafoo.de>,
    Michael Hennerich <Michael.Hennerich@analog.com>,
    Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
    Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH v2 2/2] staging: iio: ad9834: Remove
 unnecessary goto label and compress return logic
In-Reply-To: <59ddccc600cfd1594dcb4dadb44b80328fc06008.1489356140.git.karniksayli1995@gmail.com>
Message-ID: <alpine.DEB.2.20.1703122327350.7649@hadrien>
References: <cover.1489356140.git.karniksayli1995@gmail.com> <59ddccc600cfd1594dcb4dadb44b80328fc06008.1489356140.git.karniksayli1995@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>



On Mon, 13 Mar 2017, sayli karnik wrote:

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

Not such a good idea.  The function does some work, and there is no need
to repeat it.

julia

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
>
