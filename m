Return-Path: <SRS0=CFMa=FG=oracle.com=dan.carpenter@kernel.org>
Date: Mon, 12 Feb 2018 15:53:12 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: 21cnbao@gmail.com, jic23@kernel.org, devel@driverdev.osuosl.org,
        lars@metafoo.de, Michael.Hennerich@analog.com,
        linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, pmeerw@pmeerw.net, knaack.h@gmx.de
Subject: Re: [PATCH 2/4] staging: iio: accel: Remove unnecessary comments and
 add suitable suffix
Message-ID: <20180212125312.cjo76spuu6agjawc@mwanda>
References: <1518436499-8584-1-git-send-email-himanshujha199640@gmail.com>
 <1518436499-8584-3-git-send-email-himanshujha199640@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1518436499-8584-3-git-send-email-himanshujha199640@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Feb 12, 2018 at 05:24:57PM +0530, Himanshu Jha wrote:
> Remove some unnecessary comments by giving appropriate name to macros.
> Therefore, add _REG suffix for control registers. Also, align function
> arguments to match open parentheses using tabs.
> Group the control register and register field macros together.
> 
> Blank line before some returns improves code readability.
> 
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>

The most obvious response is that this needs to be broken up into
multiple patches.

I think I liked almost all the comments...

> -/* Output, power supply */
> -#define ADIS16201_SUPPLY_OUT     0x02
> +#define ADIS16201_SUPPLY_OUT_REG		0x02

To me it seems useful to know that we're talking about the power supply.

Adding _REG to the name seems not terribly useful and it makes the name
longer so we're going to run into the 80 character limit.  I just
checked and this patch does add some checkpatch warnings.

But aligning the arguments is fine, deleting unused macros is fine,
adding blank lines is fine.

>  static int adis16201_probe(struct spi_device *spi)
>  {
> -	int ret;
> -	struct adis *st;
>  	struct iio_dev *indio_dev;
> +	struct adis *st;
> +	int ret;

Making this reverse Christmas tree is fine.  But these things should all
be done in separate patches.

regards,
dan carpenter
