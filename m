Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35302 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932195AbcCOWDT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 15 Mar 2016 18:03:19 -0400
Subject: Re: [PATCH] iio: ABI: Fix typo in in_proximity_raw description
To: Peter Meerwald <pmeerw@pmeerw.net>
References: <1457881342-15418-1-git-send-email-pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56E886A5.5080509@kernel.org>
Date: Tue, 15 Mar 2016 22:03:17 +0000
MIME-Version: 1.0
In-Reply-To: <1457881342-15418-1-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/03/16 15:02, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Applied, thanks.
> ---
>  Documentation/ABI/testing/sysfs-bus-iio |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 3c66248..17a9210 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -1233,7 +1233,7 @@ KernelVersion:	3.4
>  Contact:	linux-iio@vger.kernel.org
>  Description:
>  		Proximity measurement indicating that some
> -		object is near the sensor, usually be observing
> +		object is near the sensor, usually by observing
>  		reflectivity of infrared or ultrasound emitted.
>  		Often these sensors are unit less and as such conversion
>  		to SI units is not possible. Higher proximity measurements
> 

