Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:32789 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750792AbaEXKU0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 24 May 2014 06:20:26 -0400
Message-ID: <538072D1.6020406@kernel.org>
Date: Sat, 24 May 2014 11:22:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: linux-iio@vger.kernel.org, pmeerw@pmeerw.net
Subject: Re: [PATCH] iio: Add ABI documentation for proximity
References: <1399114623-14921-1-git-send-email-jic23@kernel.org>
In-Reply-To: <1399114623-14921-1-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/05/14 11:57, Jonathan Cameron wrote:
> From: Peter Meerwald <pmeerw@pmeerw.net>
>
> has been in use for a long time, but never documented
> proximity is unit-less, except otherwise stated, see e.g.
> the as3935 driver where it is meter
>
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
I'm going to assume no one minds the changes that I made to Peter's original patch.
Applied to the togreg branch of iio.git

Thanks,

Jonathan
> ---
>   Documentation/ABI/testing/sysfs-bus-iio | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index a9757dc..738b56f 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -895,6 +895,19 @@ Description:
>   		on-chip EEPROM. After power-up or chip reset the device will
>   		automatically load the saved configuration.
>
> +What:		/sys/.../iio:deviceX/in_proximity_raw
> +What:		/sys/.../iio:deviceX/in_proximity_input
> +What:		/sys/.../iio:deviceX/in_proximityY_raw
> +KernelVersion:	3.4
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Proximity measurement indicating that some
> +		object is near the sensor, usually be observing
> +		reflectivity of infrared or ultrasound emitted.
> +		Often these sensors are unit less and as such conversion
> +		to SI units is not possible.  Where it is, the units should
> +		be meters.
> +
>   What:		/sys/.../iio:deviceX/in_illuminanceY_input
>   What:		/sys/.../iio:deviceX/in_illuminanceY_raw
>   What:		/sys/.../iio:deviceX/in_illuminanceY_mean_raw
>

