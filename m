Return-Path: <knaack.h@gmx.de>
Message-ID: <55C4F7A3.8070404@gmx.de>
Date: Fri, 07 Aug 2015 20:23:31 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Linus Walleij <linus.walleij@linaro.org>,
 Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: generic_buffer: be helpful about enabling channels
References: <1438940245-18998-1-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1438940245-18998-1-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-iio@vger.kernel.org>

Linus Walleij schrieb am 07.08.2015 um 11:37:
> Currently if generic_buffer is invoked without first enabling any
> channels in scan_elements/*_en, it will fail unable to enable the
> buffer because bytes_per_datum inside the kernel will be zero if
> no channels are available.
> 
> It is implied that the user of the program should enable channels
> manually or with a script before executing generic_buffer.
> 
> Be more helpful by stopping execution if no enabled channels can
> be found, and print a helptext that will tell you what is wrong
> and what needs to be done.
> 

Hi Linus,
a few weeks ago we changed the behavior, so that such messages are
sent to stderr now. Please rebase on one of the IIO git branches
(like togreg, or testing).
Thanks,

Hartmut

> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  tools/iio/generic_buffer.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/tools/iio/generic_buffer.c b/tools/iio/generic_buffer.c
> index 4eebb6616e5c..10a74ca6818b 100644
> --- a/tools/iio/generic_buffer.c
> +++ b/tools/iio/generic_buffer.c
> @@ -299,6 +299,13 @@ int main(int argc, char **argv)
>  		printf("diag %s\n", dev_dir_name);
>  		goto error_free_triggername;
>  	}
> +	if (!num_channels) {
> +		printf("No channels are enabled, we have nothing to scan.\n");
> +		printf("Enable channels manually in " FORMAT_SCAN_ELEMENTS_DIR
> +		       "/*_en and try again.\n", dev_dir_name);
> +		ret = -ENOENT;
> +		goto error_free_triggername;
> +	}
>  
>  	/*
>  	 * Construct the directory name for the associated buffer.
> 
