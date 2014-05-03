Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51301 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012AbaECKh0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 3 May 2014 06:37:26 -0400
Message-ID: <5364C745.5000504@kernel.org>
Date: Sat, 03 May 2014 11:39:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: Add ABI documentation for object and ambient
 modifiers
References: <1399046226-6673-1-git-send-email-pmeerw@pmeerw.net> <1399046226-6673-3-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1399046226-6673-3-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/05/14 16:57, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Applied to the togreg branch of iio.git

Thanks,

> ---
>   Documentation/ABI/testing/sysfs-bus-iio | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 6b74691..ca3d3b7 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -114,14 +114,17 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_temp_raw
>   What:		/sys/bus/iio/devices/iio:deviceX/in_tempX_raw
>   What:		/sys/bus/iio/devices/iio:deviceX/in_temp_x_raw
>   What:		/sys/bus/iio/devices/iio:deviceX/in_temp_y_raw
> -What:		/sys/bus/iio/devices/iio:deviceX/in_temp_z_raw
> +What:		/sys/bus/iio/devices/iio:deviceX/in_temp_ambient_raw
> +What:		/sys/bus/iio/devices/iio:deviceX/in_temp_object_raw
>   KernelVersion:	2.6.35
>   Contact:	linux-iio@vger.kernel.org
>   Description:
>   		Raw (unscaled no bias removal etc.) temperature measurement.
>   		If an axis is specified it generally means that the temperature
>   		sensor is associated with one part of a compound device (e.g.
> -		a gyroscope axis). Units after application of scale and offset
> +		a gyroscope axis). The ambient and object modifiers distinguish
> +		between ambient (reference) and distant temperature for contact-
> +		less measurements. Units after application of scale and offset
>   		are milli degrees Celsius.
>
>   What:		/sys/bus/iio/devices/iio:deviceX/in_tempX_input
>

