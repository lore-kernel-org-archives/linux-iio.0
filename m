Return-Path: <SRS0=QvXV=2R=axentia.se=peda@kernel.org>
Subject: Re: [PATCH] iio: multiplexer: fix unsigned check with less than zero
To: Colin King <colin.king@canonical.com>, Jonathan Cameron
	<jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen
	<lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	<linux-iio@vger.kernel.org>
References: <20170307150631.31043-1-colin.king@canonical.com>
CC: <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: Peter Rosin <peda@axentia.se>
Message-ID: <910dd7ee-9b07-4e43-6ba3-cf5736c94348@axentia.se>
Date: Wed, 8 Mar 2017 09:59:12 +0100
MIME-Version: 1.0
In-Reply-To: <20170307150631.31043-1-colin.king@canonical.com>
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-iio@vger.kernel.org>

On 2017-03-07 16:06, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Comparing a size_t with less than zero is always false as size_t
> is unsigned. The intent of the comparison was to check if the size
> was -1 (that is, undefined), so use that instead.
> 
> Detected by CoverityScan, CID#1415278 ("Unsigned compared against 0")
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Hi!

Oops, thanks for highlighting this! However, I think I prefer to instead
change the type of the struct mux_ext_info_cache member 'size' to ssize_t.
That way, there is no annoying explicit cast. And perhaps add an early
check

	if (len >= PAGE_SIZE)
		return -EINVAL;

to mux_write_ext_info (because the sysfs read function in use for iio ext
info can't handle more than a page anyway, IIUC). That way it is fairly
certain that the ssize_t type will always be big enough. :-)

So, I'm going send out a patch like that instead, unless someone happens to
beat me to it...

Cheers,
peda

> ---
>  drivers/iio/multiplexer/iio-mux.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/multiplexer/iio-mux.c b/drivers/iio/multiplexer/iio-mux.c
> index 94d40f9b..6c23033 100644
> --- a/drivers/iio/multiplexer/iio-mux.c
> +++ b/drivers/iio/multiplexer/iio-mux.c
> @@ -61,7 +61,7 @@ static int iio_mux_select(struct mux *mux, int idx)
>  
>  			cache = &child->ext_info_cache[i];
>  
> -			if (cache->size < 0)
> +			if (cache->size == (size_t)-1)
>  				continue;
>  
>  			ret = iio_write_channel_ext_info(mux->parent, attr,
> 
