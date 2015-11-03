Return-Path: <lars@metafoo.de>
Message-ID: <5638C45E.8010209@metafoo.de>
Date: Tue, 03 Nov 2015 15:27:42 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jean-Francois Dagenais <jeff.dagenais@gmail.com>,
 linux-iio@vger.kernel.org
CC: jic23@kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net,
 Michael.Hennerich@analog.com,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] iio:dac: fix i2c_master_send return code misuse
References: <1445963139-2158-1-git-send-email-jeff.dagenais@gmail.com> <1445963139-2158-2-git-send-email-jeff.dagenais@gmail.com>
In-Reply-To: <1445963139-2158-2-git-send-email-jeff.dagenais@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

Hi,

On 10/27/2015 05:25 PM, Jean-Francois Dagenais wrote:
> Contrary to most kernel functions, successful call to
> i2c_master_send returns the number or written bytes,not 0.
> 
> However, these callers return the value as is without converting
> the return style to conform to the expected standard.
> 
> Signed-off-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>

Thanks for the patch.

> ---
>  drivers/iio/dac/ad5064.c  |  5 ++++-
>  drivers/iio/dac/ad5446.c  |  4 +++-
>  drivers/iio/dac/max517.c  |  6 ++++--
>  drivers/iio/dac/max5821.c |  8 ++++++--
>  drivers/iio/dac/mcp4725.c | 10 ++++++++--
>  5 files changed, 25 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5064.c b/drivers/iio/dac/ad5064.c
> index c067e68..0ff1107 100644
> --- a/drivers/iio/dac/ad5064.c
> +++ b/drivers/iio/dac/ad5064.c
> @@ -598,10 +598,13 @@ static int ad5064_i2c_write(struct ad5064_state *st, unsigned int cmd,
>  	unsigned int addr, unsigned int val)
>  {
>  	struct i2c_client *i2c = to_i2c_client(st->dev);
> +	int res;
>  
>  	st->data.i2c[0] = (cmd << 4) | addr;
>  	put_unaligned_be16(val, &st->data.i2c[1]);
> -	return i2c_master_send(i2c, st->data.i2c, 3);
> +	res = i2c_master_send(i2c, st->data.i2c, 3);
> +
> +	return res == 3 ? 0 : res;
>  }

The ad5064 is already fixed in Jonathan's tree.

>  
>  static int ad5064_i2c_probe(struct i2c_client *i2c,
> diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
> index 07e17d7..9a49941 100644
> --- a/drivers/iio/dac/ad5446.c
> +++ b/drivers/iio/dac/ad5446.c
> @@ -512,7 +512,9 @@ static int ad5622_write(struct ad5446_state *st, unsigned val)
>  	struct i2c_client *client = to_i2c_client(st->dev);
>  	__be16 data = cpu_to_be16(val);
>  
> -	return i2c_master_send(client, (char *)&data, sizeof(data));
> +	int res = i2c_master_send(client, (char *)&data, sizeof(data));
> +
> +	return res == sizeof(data)? 0 : res;

This still returns the wrong if res is between 0 and sizeof(data)-1. You
need something like

	if (res == sizeof(data))
		return 0
	else if (res >= 0)
		return -EIO;
	else
		return res;

Same is true for all the other drivers patched.

I really wish we could fix this in the I2C core to avoid having to copy and
paste the same error handling to each driver.

There was this patch[1], but it looks like it was never followed by a v2.
Dmitry I'm curious, what happened to that patch?

- Lars

[1] https://patchwork.ozlabs.org/patch/220915/
