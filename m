Return-Path: <SRS0=DWBw=3H=gmail.com=amsfield22@kernel.org>
Date: Thu, 30 Mar 2017 11:22:11 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: Arushi Singhal <arushisinghal19971997@gmail.com>
Cc: outreachy-kernel@googlegroups.com, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH] iio: adc: replace comma with a
 semicolon
Message-ID: <20170330182210.GA6160@d830.WORKGROUP>
References: <20170330124603.GA29301@arushi-HP-Pavilion-Notebook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170330124603.GA29301@arushi-HP-Pavilion-Notebook>
List-ID: <linux-iio@vger.kernel.org>

On Thu, Mar 30, 2017 at 06:16:03PM +0530, Arushi Singhal wrote:
> Replace a comma between expression statements by a semicolon. This
> changes the semantics of the code, but given the current indentation
> appears to be what is intended.

Hi Arushi,

Well, you've gotten a lot of comments on this one, and I too, couldn't
resist ;)  My comment is to test things like this out. Of course, you're
not going to go off and test the max11100 driver (BTW - driver name in
Subject line please), but you can write a simple C program to verify
the behavior of commas vs semi-colons in assignment statements.
That'll prove it to yourself, and then you can write the changelog
with confidence. (That this is cosmetic ;))

It's a useful habit to pick up.  When you see a code segment that
makes you wonder, you can often pluck it out of context and try
it in a simple c program.

alisons

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
> -- 
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20170330124603.GA29301%40arushi-HP-Pavilion-Notebook.
> For more options, visit https://groups.google.com/d/optout.
