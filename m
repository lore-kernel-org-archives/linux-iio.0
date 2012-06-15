Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:43539 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756770Ab2FOMsE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 15 Jun 2012 08:48:04 -0400
Message-ID: <4FDB2F02.9070401@cam.ac.uk>
Date: Fri, 15 Jun 2012 13:48:02 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/6] iio: cleanup sysfs-bus-iio-light-lm3533-als
References: <1339714260-8361-1-git-send-email-pmeerw@pmeerw.net> <1339714260-8361-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1339714260-8361-2-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 6/14/2012 11:50 PM, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald<pmeerw@pmeerw.net>
should cc the author.  They might be particularly
attached to that blank line :)

Acked-by: Jonathan Cameron <jic23@kernel.org>
>
> ---
>   .../ABI/testing/sysfs-bus-iio-light-lm3533-als     |    3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-light-lm3533-als b/Documentation/ABI/testing/sysfs-bus-iio-light-lm3533-als
> index 694a52c..22c5ea6 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio-light-lm3533-als
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-light-lm3533-als
> @@ -14,7 +14,6 @@ KernelVersion:	3.5
>   Contact:	Johan Hovold<jhovold@gmail.com>
>   Description:
>   		Get the hysteresis for thresholds Y, that is,
> -
>   		threshY_hysteresis = threshY_raising - threshY_falling
>
>   What:		/sys/.../events/illuminance_threshY_falling_value
> @@ -31,7 +30,7 @@ Description:
>   		threshY_raising.
>
>   		These thresholds correspond to the eight zone-boundary
> -		registers (boundaryY_{low,high}) and defines the five light
> +		registers (boundaryY_{low,high}) and define the five light
>   		zones.
>
>   What:		/sys/bus/iio/devices/iio:deviceX/in_illuminance0_zone

