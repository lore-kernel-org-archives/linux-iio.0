Return-Path: <Michael.Hennerich@analog.com>
Reply-To: <michael.hennerich@analog.com>
Subject: Re: [PATCH] iio: dac: fix off-by-one comparison and out-of-bounds
 write
References: <1464861990-9155-1-git-send-email-colin.king@canonical.com>
To: Colin King <colin.king@canonical.com>, Lars-Peter Clausen
	<lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack
	<knaack.h@gmx.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	<linux-iio@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>
From: Michael Hennerich <michael.hennerich@analog.com>
Message-ID: <57501038.1070207@analog.com>
Date: Thu, 2 Jun 2016 12:53:44 +0200
MIME-Version: 1.0
In-Reply-To: <1464861990-9155-1-git-send-email-colin.king@canonical.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 06/02/2016 12:06 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> The check on reg is off-by-one, it should be >= rather than >. Fix
> this to stop an out-of-bounds write to st->channel_modes[reg].
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

> ---
>   drivers/iio/dac/ad5592r-base.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/dac/ad5592r-base.c b/drivers/iio/dac/ad5592r-base.c
> index 948f600..69bde59 100644
> --- a/drivers/iio/dac/ad5592r-base.c
> +++ b/drivers/iio/dac/ad5592r-base.c
> @@ -525,7 +525,7 @@ static int ad5592r_alloc_channels(struct ad5592r_state *st)
>
>   	device_for_each_child_node(st->dev, child) {
>   		ret = fwnode_property_read_u32(child, "reg", &reg);
> -		if (ret || reg > ARRAY_SIZE(st->channel_modes))
> +		if (ret || reg >= ARRAY_SIZE(st->channel_modes))
>   			continue;
>
>   		ret = fwnode_property_read_u32(child, "adi,mode", &tmp);
>


-- 
Greetings,
Michael

--
Analog Devices GmbH      Otl-Aicher Strasse 60-64      80807 München
Sitz der Gesellschaft München, Registergericht München HRB 40368,
Geschäftsführer: Peter Kolberg, Ali Raza Husain, Eileen Wynne
