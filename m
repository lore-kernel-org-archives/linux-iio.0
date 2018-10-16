Return-Path: <SRS0=axBZ=M4=oracle.com=dan.carpenter@kernel.org>
Date: Tue, 16 Oct 2018 15:44:04 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Gabriel Capella <gabriel@capella.pro>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH] staging: iio: adc: Add comments to prevent checks
 corrections
Message-ID: <20181016124404.fyzau4pd7wq6r7js@mwanda>
References: <20181015212521.GA24512@mantaray>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181015212521.GA24512@mantaray>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Oct 15, 2018 at 06:25:21PM -0300, Gabriel Capella wrote:
> This patch adds 3 comments in 2 different files.
> These comments warn to don't correct the checks of type:
> "CHECK: spaces preferred around that '-'"
> 
> Signed-off-by: Gabriel Capella <gabriel@capella.pro>
> ---
>  drivers/staging/iio/adc/ad7192.c  | 1 +
>  drivers/staging/iio/adc/ad7280a.c | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> index acdbc07fd259..786ace19c240 100644
> --- a/drivers/staging/iio/adc/ad7192.c
> +++ b/drivers/staging/iio/adc/ad7192.c
> @@ -354,6 +354,7 @@ ad7192_show_scale_available(struct device *dev,
>  	return len;
>  }
>  
> +/* Do not put spaces around the hyphen. #checkpatch.pl */
>  static IIO_DEVICE_ATTR_NAMED(in_v_m_v_scale_available,
>  			     in_voltage-voltage_scale_available,
>  			     0444, ad7192_show_scale_available, NULL, 0);

No one will read that...  :(  It has to be on the same line.

regards,
dan carpenter
