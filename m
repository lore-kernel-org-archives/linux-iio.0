Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59399 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752092AbbC1LAC (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 28 Mar 2015 07:00:02 -0400
Message-ID: <551689B0.2030903@kernel.org>
Date: Sat, 28 Mar 2015 11:00:00 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Haneen Mohammed <hamohammed.sa@gmail.com>,
	outreachy-kernel@googlegroups.com, linux-iio@vger.kernel.org,
	daniel.baluta@intel.com
Subject: Re: [PATCH] iio: Add ABI documentation for in_rot offset value
References: <1427500959-3404-1-git-send-email-hamohammed.sa@gmail.com>
In-Reply-To: <1427500959-3404-1-git-send-email-hamohammed.sa@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 28/03/15 00:02, Haneen Mohammed wrote:
> This patch adds ABI documentation entries for in_rot_offset.
> At least one user for these is present that is the  HID Sensors Driver.
> 
> Signed-off-by: Haneen Mohammed <hamohammed.sa@gmail.com>
Applied to the togreg branch of iio.git.
Will be initially pushed out as testing to allow other patches to
be build tested.

Thanks,

Jonathan
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 5cabafb..4736a34 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -254,6 +254,7 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_pressureY_offset
>  What:		/sys/bus/iio/devices/iio:deviceX/in_pressure_offset
>  What:		/sys/bus/iio/devices/iio:deviceX/in_humidityrelative_offset
>  What:		/sys/bus/iio/devices/iio:deviceX/in_magn_offset
> +What:		/sys/bus/iio/devices/iio:deviceX/in_rot_offset
>  KernelVersion:	2.6.35
>  Contact:	linux-iio@vger.kernel.org
>  Description:
> 

