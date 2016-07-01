Return-Path: <pmeerw@pmeerw.net>
Date: Fri, 1 Jul 2016 17:03:03 +0200 (CEST)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: "Andrew F. Davis" <afd@ti.com>
cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: dac: mcp4725: Remove unneeded conversions to bool
In-Reply-To: <20160701143352.17224-1-afd@ti.com>
Message-ID: <alpine.DEB.2.02.1607011700150.7271@pmeerw.net>
References: <20160701143352.17224-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>


> Found with scripts/coccinelle/misc/boolconv.cocci.

I'd argue that

        pd = (inbuf[0] >> 1) & 0x3;
        if (pd) {
                data->powerdown = true;
                data->powerdown_mode = pd - 1;
        } else {
                data->powerdown = false;
                data->powerdown_mode = 2; /* largest register to gnd */
        }

is less compact but probably easier to read/understand;

> Signed-off-by: Andrew F. Davis <afd@ti.com>

but I'm fine with the proposed patch as well to make cocci happy

regards, p.

> ---
>  drivers/iio/dac/mcp4725.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
> index cca935c..c3bb3fd 100644
> --- a/drivers/iio/dac/mcp4725.c
> +++ b/drivers/iio/dac/mcp4725.c
> @@ -361,7 +361,7 @@ static int mcp4725_probe(struct i2c_client *client,
>  		return err;
>  	}
>  	pd = (inbuf[0] >> 1) & 0x3;
> -	data->powerdown = pd > 0 ? true : false;
> +	data->powerdown = pd > 0;
>  	data->powerdown_mode = pd ? pd - 1 : 2; /* largest register to gnd */
>  	data->dac_value = (inbuf[1] << 4) | (inbuf[2] >> 4);
>  
> 

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
