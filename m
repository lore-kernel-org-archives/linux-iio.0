Return-Path: <SRS0=SHBH=3H=jmondi.org=jacopo@kernel.org>
Date: Thu, 30 Mar 2017 15:30:46 +0200
From: jacopo <jacopo@jmondi.org>
To: Arushi Singhal <arushisinghal19971997@gmail.com>
Cc: outreachy-kernel@googlegroups.com, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: replace comma with a semicolon
Message-ID: <20170330133046.GA7900@w540>
References: <20170330124603.GA29301@arushi-HP-Pavilion-Notebook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20170330124603.GA29301@arushi-HP-Pavilion-Notebook>
List-ID: <linux-iio@vger.kernel.org>

Hi Arushi,
   thanks for your patch

On Thu, Mar 30, 2017 at 06:16:03PM +0530, Arushi Singhal wrote:
> Replace a comma between expression statements by a semicolon. This
> changes the semantics of the code, but given the current indentation
> appears to be what is intended.
> A simplified version of the Coccinelle semantic patch that performs this
> transformation is as follows:
> 
> // <smpl>
> @r@
> expression e1,e2;
> @@
> 
>  e1
> -,
> +;
>  e2;
> // </smpl>
> 

You can simply say that this fixes what appears to be a bug to me.
I wonder how this does even compile..

Jonathan, since I assume you picked this up and changed those 2 lines
(original patch here [1]), was this intentional?

Thanks
   j

[1] https://marc.info/?l=linux-iio&m=148475728729617&w=2

> Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
> ---
>  drivers/iio/adc/max11100.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/max11100.c b/drivers/iio/adc/max11100.c
> index 23c060e1b663..1180bcc22ff1 100644
> --- a/drivers/iio/adc/max11100.c
> +++ b/drivers/iio/adc/max11100.c
> @@ -124,8 +124,8 @@ static int max11100_probe(struct spi_device *spi)
>  	indio_dev->name = "max11100";
>  	indio_dev->info = &max11100_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> -	indio_dev->channels = max11100_channels,
> -	indio_dev->num_channels = ARRAY_SIZE(max11100_channels),
> +	indio_dev->channels = max11100_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(max11100_channels);
>  
>  	state->vref_reg = devm_regulator_get(&spi->dev, "vref");
>  	if (IS_ERR(state->vref_reg))
> -- 
> 2.11.0
> 
