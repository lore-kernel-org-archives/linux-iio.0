Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-038.synserver.de ([212.40.185.38]:1080 "EHLO
	smtp-out-047.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752523Ab3LPIyy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 16 Dec 2013 03:54:54 -0500
Message-ID: <52AEC019.1020002@metafoo.de>
Date: Mon, 16 Dec 2013 09:55:53 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org, pmeerw@pmeerw.net,
	o.v.kravchenko@globallogic.com, stigge@antcom.de
Subject: Re: [PATCH 00/24] Drop the IIO_ST macro for setting scan_type elements.
References: <1386787542-19666-1-git-send-email-jic23@kernel.org>
In-Reply-To: <1386787542-19666-1-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/11/2013 07:45 PM, Jonathan Cameron wrote:
> This macro is no longer fit for purpose given it doesn't allow the endianness
> of the element to be set. Missuse of the macro has also been responsible for
> a couple of bugs including some fixed in this series.
> 
> If everyone is happy I'll be apply the fixes through the fixes-togreg branch
> and follow up with the others after those have worked their way through.
> 
> Please do check the fixes in particular as I'm not entirely sure they are
> correct (particularly the ad7887 which gave me a headache on a train last
> night at the end of a very long day).
> 

Looks all good to me, except for the ad799x.

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

One minor nitpick though. I think the proper indention is

	{
		.foo = bar,
	}

instead of

	{
		.foo = bar,
		}
- Lars

> Thanks,
> 
> Jonathan
> 
> Jonathan Cameron (24):
>   staging:iio:mag:hmc5843 fix incorrect endianness of channel as a
>     result of missuse of the IIO_ST macro.
>   iio:imu:adis16400 fix pressure channel scan type
>   iio:adc:ad7887 Fix channel reported endianness from cpu to big endian
>   iio:accel:bma180 replaces IIO_ST macro with explicit entries to struct
>     scan_type
>   iio:mag:mag3110 replaces IIO_ST macro with explicit entries to struct
>     scan_type
>   iio:dac:ad5064 replaces IIO_ST macro with explicit entries to struct
>     scan_type
>   iio:dac:ad5360 replaces IIO_ST macro with explicit entries to struct
>     scan_type
>   iio:dac:ad5380 replaces IIO_ST macro with explicit entries to struct
>     scan_type
>   iio:dac:ad5421 replaces IIO_ST macro with explicit entries to struct
>     scan_type
>   iio:dac:ad5446 replaces IIO_ST macro with explicit entries to struct
>     scan_type
>   iio:dac:ad5449 replaces IIO_ST macro with explicit entries to struct
>     scan_type
>   iio:dac:ad5504 replaces IIO_ST macro with explicit entries to struct
>     scan_type
>   iio:dac:ad5624r replaces IIO_ST macro with explicit entries to struct
>     scan_type
>   iio:dac:ad5686 replaces IIO_ST macro with explicit entries to struct
>     scan_type
>   iio:dac:ad5755 replaces IIO_ST macro with explicit entries to struct
>     scan_type
>   iio:dac:ad5764 replaces IIO_ST macro with explicit entries to struct
>     scan_type
>   iio:dac:ad5791 replaces IIO_ST macro with explicit entries to struct
>     scan_type
>   iio:dac:max517 drop specification of scan type as unused in this
>     driver.
>   iio:dac:mcp4725 drop specification of scan type as unused in this
>     driver.
>   iio:light:adjd_s311 replaces IIO_ST macro with explicit entries to
>     struct scan_type
>   iio:light:tcs3472 replaces IIO_ST macro with explicit entries to
>     struct scan_type
>   staging:iio:ad7606 replaces IIO_ST macro with explicit entries to
>     struct scan_type
>   staging:iio:ad799x replaces IIO_ST macro with explicit entries to
>     struct scan_type
>   iio:drop IIO_ST macro
> 
>  drivers/iio/accel/bma180.c                 |  7 ++++++-
>  drivers/iio/adc/ad7887.c                   | 16 ++++++++++++++--
>  drivers/iio/dac/ad5064.c                   |  7 ++++++-
>  drivers/iio/dac/ad5360.c                   |  7 ++++++-
>  drivers/iio/dac/ad5380.c                   |  7 ++++++-
>  drivers/iio/dac/ad5421.c                   |  6 +++++-
>  drivers/iio/dac/ad5446.c                   |  9 +++++++--
>  drivers/iio/dac/ad5449.c                   |  7 ++++++-
>  drivers/iio/dac/ad5504.c                   |  6 +++++-
>  drivers/iio/dac/ad5624r_spi.c              |  7 ++++++-
>  drivers/iio/dac/ad5686.c                   |  9 +++++++--
>  drivers/iio/dac/ad5755.c                   |  7 ++++++-
>  drivers/iio/dac/ad5764.c                   |  7 ++++++-
>  drivers/iio/dac/ad5791.c                   |  9 +++++++--
>  drivers/iio/dac/max517.c                   |  1 -
>  drivers/iio/dac/mcp4725.c                  |  1 -
>  drivers/iio/imu/adis16400_core.c           |  7 ++++++-
>  drivers/iio/light/adjd_s311.c              |  7 ++++++-
>  drivers/iio/light/tcs3472.c                |  7 ++++++-
>  drivers/iio/magnetometer/mag3110.c         |  6 +++++-
>  drivers/staging/iio/adc/ad7606_core.c      |  7 ++++++-
>  drivers/staging/iio/adc/ad799x_core.c      |  8 +++++++-
>  drivers/staging/iio/magnetometer/hmc5843.c |  7 ++++++-
>  include/linux/iio/iio.h                    | 16 ++++++++++------
>  24 files changed, 145 insertions(+), 33 deletions(-)
> 

