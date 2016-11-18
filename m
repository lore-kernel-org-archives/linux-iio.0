Return-Path: <masneyb@onstation.org>
Date: Fri, 18 Nov 2016 09:03:26 -0500
From: Brian Masney <masneyb@onstation.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Jon Brenner <jbrenner@taosinc.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Eva Rachel Retuya <eraretuya@gmail.com>, linux-iio@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [patch] iio: tsl2583: off by one in
 in_illuminance_lux_table_store()
Message-ID: <20161118140326.GA20458@basecamp.onstation.org>
References: <20161118115153.GC3281@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161118115153.GC3281@mwanda>
List-ID: <linux-iio@vger.kernel.org>

On Fri, Nov 18, 2016 at 02:51:54PM +0300, Dan Carpenter wrote:
> The value[] array has "max_ints" elements so this should be >= instead
> of >.
> 
> Fixes: ac4f6eee8fe8 ("staging: iio: TAOS tsl258x: Device driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/drivers/iio/light/tsl2583.c b/drivers/iio/light/tsl2583.c
> index 0b87f6a..faef6bd 100644
> --- a/drivers/iio/light/tsl2583.c
> +++ b/drivers/iio/light/tsl2583.c
> @@ -580,7 +580,7 @@ static ssize_t in_illuminance_lux_table_store(struct device *dev,
>  	 * and the last table entry is all 0.
>  	 */
>  	n = value[0];
> -	if ((n % 3) || n < 6 || n > max_ints) {
> +	if ((n % 3) || n < 6 || n >= max_ints) {
>  		dev_err(dev,
>  			"%s: The number of entries in the lux table must be a multiple of 3 and within the range [6, %d]\n",
>  			__func__, max_ints);

Hi Dan,
   Good catch! I believe that this should use a different fix though.
The definition of value in in_illuminance_lux_table_store() should be
changed from:

int value[TSL2583_MAX_LUX_TABLE_ENTRIES * 3];

to:

int value[(TSL2583_MAX_LUX_TABLE_ENTRIES * 3) + 1];

This will allow storing the extra integer from get_options() containing
the integer count.

Otherwise, with your propsed change, someone would only be able to use
9 entries in the device lux table rather than the 10 that are set aside.

Also, this may be (well is) nit picking, but I had [6, 33] in the error
message to mark the range as inclusive on both ends. If it was exclusive
on the upper end, then the error message should have also been changed
to be [6, 33).

Brian
