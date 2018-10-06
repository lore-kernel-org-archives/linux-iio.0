Return-Path: <SRS0=IyYF=MS=poczta.fm=sst@kernel.org>
Date: Sat, 6 Oct 2018 22:25:42 +0200
From: Slawomir Stepien <sst@poczta.fm>
To: Gabriel Capella <gabriel@capella.pro>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: adc: ad7280a: fix 2 checks
Message-ID: <20181006202542.GC5035@x220.localdomain>
References: <20181006162715.GA8476@mantaray>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20181006162715.GA8476@mantaray>
List-ID: <linux-iio@vger.kernel.org>

On paź 06, 2018 13:27, Gabriel Capella wrote:
> This patch does not change the logic, it only
> corrects the checkpatch checks.
> 
> The patch fixes 2 checks of type:
> "CHECK: spaces preferred around that '-'"

I've made the same mistake few days ago. This change is incorrect.
Please see: https://lore.kernel.org/patchwork/patch/635994/.

> Signed-off-by: Gabriel Capella <gabriel@capella.pro>
> ---
>  drivers/staging/iio/adc/ad7280a.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> index 58420dcb406d..a4b4f8678c56 100644
> --- a/drivers/staging/iio/adc/ad7280a.c
> +++ b/drivers/staging/iio/adc/ad7280a.c
> @@ -750,14 +750,14 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
>  }
>  
>  static IIO_DEVICE_ATTR_NAMED(in_thresh_low_value,
> -		in_voltage-voltage_thresh_low_value,
> +		in_voltage - voltage_thresh_low_value,
>  		0644,
>  		ad7280_read_channel_config,
>  		ad7280_write_channel_config,
>  		AD7280A_CELL_UNDERVOLTAGE);
>  
>  static IIO_DEVICE_ATTR_NAMED(in_thresh_high_value,
> -		in_voltage-voltage_thresh_high_value,
> +		in_voltage - voltage_thresh_high_value,
>  		0644,
>  		ad7280_read_channel_config,
>  		ad7280_write_channel_config,

-- 
Slawomir Stepien
