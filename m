Return-Path: <SRS0=UH22=B7=linux.intel.com=andriy.shevchenko@kernel.org>
Message-ID: <1509554532.10233.171.camel@linux.intel.com>
Subject: Re: [PATCH v1] iio: proximity: sx9500: Fix typo in ACPI ID
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen
	 <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org
Date: Wed, 01 Nov 2017 18:42:12 +0200
In-Reply-To: <20171101163001.12388-1-andriy.shevchenko@linux.intel.com>
References: <20171101163001.12388-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Wed, 2017-11-01 at 18:30 +0200, Andy Shevchenko wrote:
> It seems no one before even tried this device on Intel based
> platforms.
> I suddenly realized that there is a typo by a) looking into prototype
> hardware, and b) googling for both variants (current and proposed).
> 
> Thus, fix a typo in the driver to enable this sensor.

I think to be on the safest side we may just add a new ID.

> 
> Fixes: 4193c0f1d863 ("iio: driver for Semtech SX9500 proximity
> solution")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/iio/proximity/sx9500.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/proximity/sx9500.c
> b/drivers/iio/proximity/sx9500.c
> index 53c5d653e780..8f417ccacf22 100644
> --- a/drivers/iio/proximity/sx9500.c
> +++ b/drivers/iio/proximity/sx9500.c
> @@ -1021,7 +1021,7 @@ static const struct dev_pm_ops sx9500_pm_ops = {
>  };
>  
>  static const struct acpi_device_id sx9500_acpi_match[] = {
> -	{"SSX9500", 0},
> +	{"SASX9500", 0},
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(acpi, sx9500_acpi_match);

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
