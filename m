Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750950AbdKSP5P (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Nov 2017 10:57:15 -0500
Date: Sun, 19 Nov 2017 15:32:02 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v3 4/5] iio: proximity: sx9500: Add another ACPI ID
Message-ID: <20171119153202.18b36e34@archlinux>
In-Reply-To: <20171103130340.42459-4-andriy.shevchenko@linux.intel.com>
References: <20171103130340.42459-1-andriy.shevchenko@linux.intel.com>
        <20171103130340.42459-4-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri,  3 Nov 2017 15:03:39 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Add new ACPI ID for sx9500 as had been found on prototype board.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied to the togreg branch of iio.git and pushed out
as testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/proximity/sx9500.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
> index 3cf054155779..640ea08cd3b2 100644
> --- a/drivers/iio/proximity/sx9500.c
> +++ b/drivers/iio/proximity/sx9500.c
> @@ -1048,6 +1048,7 @@ static const struct dev_pm_ops sx9500_pm_ops = {
>  
>  static const struct acpi_device_id sx9500_acpi_match[] = {
>  	{"SSX9500", 0},
> +	{"SASX9500", 0},
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(acpi, sx9500_acpi_match);

