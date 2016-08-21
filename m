Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52882 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752011AbcHUSg7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 Aug 2016 14:36:59 -0400
Subject: Re: [PATCH] iio: humidity: am2315: Select IIO_TRIGGERED_BUFFER to
 prevent build errors
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-iio@vger.kernel.org
References: <1471529118-81255-1-git-send-email-mika.westerberg@linux.intel.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Tiberiu Breana <tiberiu.a.breana@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <db3ee142-4395-eeb6-389d-918e857adca2@kernel.org>
Date: Sun, 21 Aug 2016 19:36:57 +0100
MIME-Version: 1.0
In-Reply-To: <1471529118-81255-1-git-send-email-mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/08/16 15:05, Mika Westerberg wrote:
> Commit 0d96d5ead3f7 ("iio: humidity: Add triggered buffer support for
> AM2315") added support for triggered buffers but those are only available
> when IIO_TRIGGERED_BUFFER is selected. Currently we get warnings like:
> 
>   drivers/iio/humidity/am2315.c: In function ‘am2315_trigger_handler’:
>   drivers/iio/humidity/am2315.c:186:2: error: implicit declaration of function
>     ‘iio_push_to_buffers_with_timestamp’ [-Werror=implicit-function-declaration]
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   cc1: some warnings being treated as errors
>   scripts/Makefile.build:289: recipe for target 'drivers/iio/humidity/am2315.o' failed
> 
> Furthermore linking the kernel executable fails because triggered buffer
> functions are never build.
> 
> Fix this by selecting IIO_TRIGGERED_BUFFER and IIO_BUFFER when the driver is
> enabled.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Hi Mika,

I already have a patch queued up for this bug.  Just been on holiday so
running a bit behind with getting things upstream. Should go in the
next few days.

Jonathan
> ---
>  drivers/iio/humidity/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/humidity/Kconfig b/drivers/iio/humidity/Kconfig
> index 738a86d9e4a9..d04124345992 100644
> --- a/drivers/iio/humidity/Kconfig
> +++ b/drivers/iio/humidity/Kconfig
> @@ -6,6 +6,8 @@ menu "Humidity sensors"
>  config AM2315
>      tristate "Aosong AM2315 relative humidity and temperature sensor"
>      depends on I2C
> +    select IIO_BUFFER
> +    select IIO_TRIGGERED_BUFFER
>      help
>        If you say yes here you get support for the Aosong AM2315
>        relative humidity and ambient temperature sensor.
> 

