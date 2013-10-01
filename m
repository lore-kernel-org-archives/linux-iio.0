Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51973 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751617Ab3JAINp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 1 Oct 2013 04:13:45 -0400
Message-ID: <524A9264.5060603@kernel.org>
Date: Tue, 01 Oct 2013 10:14:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 25/25] iio: Update unit of the voltage scale in the documentation
References: <1380360717-26103-1-git-send-email-lars@metafoo.de> <1380360717-26103-25-git-send-email-lars@metafoo.de>
In-Reply-To: <1380360717-26103-25-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/28/13 10:31, Lars-Peter Clausen wrote:
> The documentation says that the result of raw * scale should be in microvolts,
> but in reallity all drivers actually report the scale so that the result is in
> millivolts. So update the documentation to match reallity.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
I've no idea how we ended up with this being wrong, but it does indeed need fixing!

Anyhow, applied to the togreg branch of iio.git

Thanks for a nice focussed, easy to review series,

Jonathan
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index ab1047c..2d736208 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -79,7 +79,7 @@ Description:
>  		correspond to externally available input one of the named
>  		versions may be used. The number must always be specified and
>  		unique to allow association with event codes. Units after
> -		application of scale and offset are microvolts.
> +		application of scale and offset are millivolts.
>  
>  What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY-voltageZ_raw
>  KernelVersion:	2.6.35
> @@ -90,7 +90,7 @@ Description:
>  		physically equivalent inputs when non differential readings are
>  		separately available. In differential only parts, then all that
>  		is required is a consistent labeling.  Units after application
> -		of scale and offset are microvolts.
> +		of scale and offset are millivolts.
>  
>  What:		/sys/bus/iio/devices/iio:deviceX/in_capacitanceY_raw
>  KernelVersion:	3.2
> 
