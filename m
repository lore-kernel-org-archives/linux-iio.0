Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43033 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752487Ab3F2MX6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 29 Jun 2013 08:23:58 -0400
Message-ID: <51CED1DD.1080102@kernel.org>
Date: Sat, 29 Jun 2013 13:23:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 4/4] iio: move ABI specification for store_eeprom; is
 used by ad9523, mcp4725 and ds1077 devices
References: <1372023020-18742-1-git-send-email-pmeerw@pmeerw.net> <1372023020-18742-4-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1372023020-18742-4-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/23/2013 10:30 PM, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git
> ---
>  Documentation/ABI/testing/sysfs-bus-iio                  | 8 ++++++++
>  Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9523 | 8 --------
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 0af1af0..d43ca5c 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -793,3 +793,11 @@ Contact:	linux-iio@vger.kernel.org
>  Description:
>  		This attribute is used to read the amount of quadrature error
>  		present in the device at a given time.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/store_eeprom
> +KernelVersion:	3.4.0
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Writing '1' stores the current device configuration into
> +		on-chip EEPROM. After power-up or chip reset the device will
> +		automatically load the saved configuration.
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9523 b/Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9523
> index 2ce9c3f..a91aeab 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9523
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9523
> @@ -18,14 +18,6 @@ Description:
>  		Reading returns either '1' or '0'. '1' means that the
>  		pllY is locked.
>  
> -What:		/sys/bus/iio/devices/iio:deviceX/store_eeprom
> -KernelVersion:	3.4.0
> -Contact:	linux-iio@vger.kernel.org
> -Description:
> -		Writing '1' stores the current device configuration into
> -		on-chip EEPROM. After power-up or chip reset the device will
> -		automatically load the saved configuration.
> -
>  What:		/sys/bus/iio/devices/iio:deviceX/sync_dividers
>  KernelVersion:	3.4.0
>  Contact:	linux-iio@vger.kernel.org
> 
