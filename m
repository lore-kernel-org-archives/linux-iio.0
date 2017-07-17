Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751317AbdGQU4a (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 17 Jul 2017 16:56:30 -0400
Date: Mon, 17 Jul 2017 21:56:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Stefan =?UTF-8?B?QnLDvG5z?= <stefan.bruens@rwth-aachen.de>
Cc: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH 1/2] iio: Documentation: Add missing documentation for
 power attribute
Message-ID: <20170717215625.47ac633f@kernel.org>
In-Reply-To: <819f6f2699b34549becf3f7d8f565c19@rwthex-w2-b.rwth-ad.de>
References: <20170716233410.22880-1-stefan.bruens@rwth-aachen.de>
        <819f6f2699b34549becf3f7d8f565c19@rwthex-w2-b.rwth-ad.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 17 Jul 2017 01:34:09 +0200
Stefan Brüns <stefan.bruens@rwth-aachen.de> wrote:

> Commit c43a102e67db ("iio: ina2xx: add support for TI INA2xx Power Monitors")
> introduced the in_powerY_raw attribute, but omitted the corresponding
> documentation.
> 
> The description is correct for the INA2xx and the MAX9611 IIO drivers.
> 
> Signed-off-by: Stefan Brüns <stefan.bruens@rwth-aachen.de>
Applied to the togreg branch of iio.git - initially pushed out
as testing.

Thanks,

Jonathan
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 2db2cdf42d54..7eead5f97e02 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -119,6 +119,15 @@ Description:
>  		unique to allow association with event codes. Units after
>  		application of scale and offset are milliamps.
>  
> +What:		/sys/bus/iio/devices/iio:deviceX/in_powerY_raw
> +KernelVersion:	4.5
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Raw (unscaled no bias removal etc.) power measurement from
> +		channel Y. The number must always be specified and
> +		unique to allow association with event codes. Units after
> +		application of scale and offset are milliwatts.
> +
>  What:		/sys/bus/iio/devices/iio:deviceX/in_capacitanceY_raw
>  KernelVersion:	3.2
>  Contact:	linux-iio@vger.kernel.org

