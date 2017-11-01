Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:42672 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932989AbdKARDs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 1 Nov 2017 13:03:48 -0400
Message-ID: <1509555817.10233.172.camel@linux.intel.com>
Subject: Re: [PATCH v2 1/2] iio: proximity: sx9500: Add another ACPI ID
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Date: Wed, 01 Nov 2017 19:03:37 +0200
In-Reply-To: <20171101165319.36033-1-andriy.shevchenko@linux.intel.com>
References: <20171101165319.36033-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 2017-11-01 at 18:53 +0200, Andy Shevchenko wrote:
> Add new ACPI ID for sx9500 as had been found on prototype board.
> 

Oops, old version, new commit message...


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
