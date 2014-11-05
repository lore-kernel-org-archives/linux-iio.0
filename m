Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44668 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751223AbaKES1m (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 5 Nov 2014 13:27:42 -0500
Message-ID: <545A6C19.2030803@kernel.org>
Date: Wed, 05 Nov 2014 18:27:37 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Darshana Padmadas <darshanapadmadas@gmail.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: Add ABI documentation for scaled voltage
References: <1415204291-25376-1-git-send-email-darshanapadmadas@gmail.com>
In-Reply-To: <1415204291-25376-1-git-send-email-darshanapadmadas@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/11/14 16:18, Darshana Padmadas wrote:
> This patch adds an entry in ABI documentation for in_voltage-voltage_scale.
> It has at least one user driver, adis16220, in accel driver.
> 
> Signed-off-by: Darshana Padmadas <darshanapadmadas@gmail.com>
Thanks,

Applied to the togreg branch of iio.git

Thanks,
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index d760b02..0640118 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -251,6 +251,7 @@ Description:
>  What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_scale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_supply_scale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_scale
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltage-voltage_scale
>  What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_scale
>  What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_scale
>  What:		/sys/bus/iio/devices/iio:deviceX/in_accel_scale
> 
