Return-Path: <SRS0=dLTr=GF=oracle.com=dan.carpenter@kernel.org>
Date: Thu, 15 Mar 2018 15:11:15 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Barry Song <21cnbao@gmail.com>, John Syne <john3909@gmail.com>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        daniel.baluta@nxp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] staging:iio:ade7854: Add proper error handling
 condition
Message-ID: <20180315121115.iwkx2dfikgpjeeec@mwanda>
References: <cover.1521037060.git.rodrigosiqueiramelo@gmail.com>
 <72d5aaef3445edaca08498b4d7aaff19d4ac0232.1521037060.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <72d5aaef3445edaca08498b4d7aaff19d4ac0232.1521037060.git.rodrigosiqueiramelo@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

On Wed, Mar 14, 2018 at 03:12:18PM -0300, Rodrigo Siqueira wrote:
> There is some improper error handling for IRQ and device register.  This
> patch adds a proper verification. The IRQ correction was extracted from
> John Syne patches.
> 
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> Signed-off-by: John Syne <john3909@gmail.com>
> ---
>  drivers/staging/iio/meter/ade7854.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7854.c b/drivers/staging/iio/meter/ade7854.c
> index 09fd8c067738..49cbe365e43d 100644
> --- a/drivers/staging/iio/meter/ade7854.c
> +++ b/drivers/staging/iio/meter/ade7854.c
> @@ -436,7 +436,7 @@ static int ade7854_initial_setup(struct iio_dev *indio_dev)
>  
>  	/* Disable IRQ */
>  	ret = ade7854_set_irq(dev, false);
> -	if (ret) {
> +	if (ret < 0) {
>  		dev_err(dev, "disable irq failed");
>  		goto err_ret;
>  	}

Why is the original wrong?  It seems fine.

regards,
dan carpenter
