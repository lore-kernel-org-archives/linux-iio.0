Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:49058 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755331Ab1ALL7g (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Jan 2011 06:59:36 -0500
Message-ID: <4D2D995E.6090505@cam.ac.uk>
Date: Wed, 12 Jan 2011 12:06:54 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Roland Stigge <stigge@antcom.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: Documentation update for outputs / dac
References: <4D2D8516.1040602@antcom.de>
In-Reply-To: <4D2D8516.1040602@antcom.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/12/11 10:40, Roland Stigge wrote:
> Attached is the documentation update for iio outputs / dac.
Hi Roland,

Any chance at all you can get git-send-email to work for you?
Saves me the step of pasting the attachment back into the email
every time!

More or less fine, couple of minor comments inline.

Thanks for doing this,

Jonathan
> iio: Documentation update for outputs / dac
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>
> 
> diff --git a/drivers/staging/iio/Documentation/sysfs-bus-iio b/drivers/staging/iio/Documentation/sysfs-bus-iio
> index 2dde97d..38b9813 100644
> --- a/drivers/staging/iio/Documentation/sysfs-bus-iio
> +++ b/drivers/staging/iio/Documentation/sysfs-bus-iio
> @@ -168,6 +168,7 @@ Description:
>  What:		/sys/bus/iio/devices/deviceX/inY_scale
>  What:		/sys/bus/iio/devices/deviceX/inY_supply_scale
>  What:		/sys/bus/iio/devices/deviceX/in_scale
> +What:		/sys/bus/iio/devices/deviceX/outY_scale
>  What:		/sys/bus/iio/devices/deviceX/accel_scale
>  What:		/sys/bus/iio/devices/deviceX/accel_peak_scale
>  What:		/sys/bus/iio/devices/deviceX/gyro_scale
> @@ -222,6 +223,25 @@ Description:
>  		If a discrete set of scale values are available, they
>  		are listed in this attribute.
>  
> +What:		/sys/bus/iio/devices/deviceX/outY_raw
> +KernelVersion:	2.6.37
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Raw (unscaled, no bias etc.) output voltage for
> +		channel Y. 

Get rid of this bit about named output. I'm not sure it makes sense to allow
this and I don't think we currently have an examples in tree.

> In special cases where the channel does not
> +		correspond to externally available output one of the named
> +		versions may be used. The number must always be specified and
> +		unique if the output corresponds to a single channel.
> +
> +What:		/sys/bus/iio/devices/deviceX/outY&Z&..._raw
Please avoid ... syntax, it makes it very difficult to search the file.
Just list the two case version
outY&Z_raw for now and we can document more advanced cases if they ever
show up as extra what entries.
> +KernelVersion:	2.6.37
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Raw (unscaled, no bias etc.) output voltage for an aggregate of
> +		channel Y, channel Z, etc.  This interface is available in cases
> +		where a single output sets the value for multiple channels
> +		simultaneously.
> +
>  What:		/sys/bus/iio/devices/deviceX/deviceX:eventY
>  KernelVersion:	2.6.35
>  Contact:	linux-iio@vger.kernel.org

