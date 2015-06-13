Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37892 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028AbbFMR4r (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 13 Jun 2015 13:56:47 -0400
Message-ID: <557C6EDD.4080808@kernel.org>
Date: Sat, 13 Jun 2015 18:56:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Adriana Reus <adriana.reus@intel.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: Documentation: Add additional *scale_available attributes
References: <1434124867-30071-1-git-send-email-adriana.reus@intel.com>
In-Reply-To: <1434124867-30071-1-git-send-email-adriana.reus@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/06/15 17:01, Adriana Reus wrote:
> Added some more *scale_available attributes to the list that
> are used in various drivers but were missiong from Documentation.
> 
> Signed-off-by: Adriana Reus <adriana.reus@intel.com>
Thanks. Applied to the togreg branch of iio.git
Will initially get pushed out as testing for the autobuilders
to ignore whilst testing whatever else is in there ;)

Jonathan
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index bbed111..666a341 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -413,6 +413,11 @@ Description:
>  		to compute the calories burnt by the user.
>  
>  What:		/sys/bus/iio/devices/iio:deviceX/in_accel_scale_available
> +What:		/sys/.../iio:deviceX/in_anglvel_scale_available
> +What:		/sys/.../iio:deviceX/in_magn_scale_available
> +What:		/sys/.../iio:deviceX/in_illuminance_scale_available
> +What:		/sys/.../iio:deviceX/in_intensity_scale_available
> +What:		/sys/.../iio:deviceX/in_proximity_scale_available
>  What:		/sys/.../iio:deviceX/in_voltageX_scale_available
>  What:		/sys/.../iio:deviceX/in_voltage-voltage_scale_available
>  What:		/sys/.../iio:deviceX/out_voltageX_scale_available
> 

