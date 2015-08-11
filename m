Return-Path: <knaack.h@gmx.de>
Message-ID: <55CA3D04.6050005@gmx.de>
Date: Tue, 11 Aug 2015 20:20:52 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Linus Walleij <linus.walleij@linaro.org>,
 Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: generic_buffer: be helpful about enabling channels
References: <1439196908-5627-1-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1439196908-5627-1-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-iio@vger.kernel.org>

Linus Walleij schrieb am 10.08.2015 um 10:55:
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
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Hartmut Knaack <knaack.h@gmx.de>
> ---
> ChangeLog v1->v2:
> - Rebased on the "togreg" branch
> - Print errors to stderr as requested by Hartmut
> ---
>  tools/iio/generic_buffer.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/tools/iio/generic_buffer.c b/tools/iio/generic_buffer.c
> index 9f7b85bf6ada..01c4f67801e0 100644
> --- a/tools/iio/generic_buffer.c
> +++ b/tools/iio/generic_buffer.c
> @@ -328,6 +328,15 @@ int main(int argc, char **argv)
>  			"diag %s\n", dev_dir_name);
>  		goto error_free_triggername;
>  	}
> +	if (!num_channels) {
> +		fprintf(stderr,
> +			"No channels are enabled, we have nothing to scan.\n");
> +		fprintf(stderr, "Enable channels manually in "
> +			FORMAT_SCAN_ELEMENTS_DIR
> +			"/*_en and try again.\n", dev_dir_name);
> +		ret = -ENOENT;
> +		goto error_free_triggername;
> +	}
>  
>  	/*
>  	 * Construct the directory name for the associated buffer.
> 
