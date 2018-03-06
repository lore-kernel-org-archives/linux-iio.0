Return-Path: <SRS0=3Fnu=F4=oracle.com=dan.carpenter@kernel.org>
Date: Tue, 6 Mar 2018 16:53:14 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        daniel.baluta@nxp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] staging:iio:meter: Aligns open parenthesis
Message-ID: <20180306135314.vxngtgj6yxomasm2@mwanda>
References: <cover.1520338980.git.rodrigosiqueiramelo@gmail.com>
 <284b70f83bac86ec5f0048b957ec2f679ca8ab99.1520338980.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <284b70f83bac86ec5f0048b957ec2f679ca8ab99.1520338980.git.rodrigosiqueiramelo@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

On Tue, Mar 06, 2018 at 09:26:07AM -0300, Rodrigo Siqueira wrote:
> @@ -63,7 +63,7 @@ int ade7758_probe_trigger(struct iio_dev *indio_dev)
>  	int ret;
>  
>  	st->trig = iio_trigger_alloc("%s-dev%d",
> -					spi_get_device_id(st->us)->name,
> +				     spi_get_device_id(st->us)->name,
>  					indio_dev->id);
                                        ^^^^^^^^^^^^^
The "indio_dev->id" needs to be aligned as well.

>  	if (!st->trig) {
>  		ret = -ENOMEM;

regards,
dan carpenter
