Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51357 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750960AbaECKqn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 3 May 2014 06:46:43 -0400
Message-ID: <5364C971.7000702@kernel.org>
Date: Sat, 03 May 2014 11:48:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/4] iio: Add ABI documentation for proximity
References: <1399046089-6616-1-git-send-email-pmeerw@pmeerw.net> <1399046089-6616-4-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1399046089-6616-4-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/05/14 16:54, Peter Meerwald wrote:
> has been in use for a long time, but never documented
> proximity is unit-less, except otherwise stated, see e.g.
> the as3935 driver where it is meter
>
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Again this is documented in the staging docs.  I'd argue that the _input
form should be used if we are in meters, otherwise if scale free (like it
almost always is) then it should be the _raw form.

Still we can always evolve the docs!

Applied to the togreg branch of iio.git

Thanks,

J
> ---
>   Documentation/ABI/testing/sysfs-bus-iio | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index a9757dc..ed202b3 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -895,6 +895,16 @@ Description:
>   		on-chip EEPROM. After power-up or chip reset the device will
>   		automatically load the saved configuration.
>
> +What:		/sys/.../iio:deviceX/in_proximity_raw
> +What:		/sys/.../iio:deviceX/in_proximity_input
> +What:		/sys/.../iio:deviceX/in_proximityY_raw
> +KernelVersion:	3.4
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Unit-less proximity measurement indicating that some
> +		object is near the sensor, usually be observing
> +		reflectivity of infrared or ultrasound emitted.
> +
>   What:		/sys/.../iio:deviceX/in_illuminanceY_input
>   What:		/sys/.../iio:deviceX/in_illuminanceY_raw
>   What:		/sys/.../iio:deviceX/in_illuminanceY_mean_raw
>

