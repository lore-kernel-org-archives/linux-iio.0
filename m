Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51336 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750849AbaECKnf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 3 May 2014 06:43:35 -0400
Message-ID: <5364C8B5.5080404@kernel.org>
Date: Sat, 03 May 2014 11:45:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/4] iio: Add ABI documentation for illuminance
References: <1399046089-6616-1-git-send-email-pmeerw@pmeerw.net> <1399046089-6616-3-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1399046089-6616-3-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/05/14 16:54, Peter Meerwald wrote:
> has been in use for a long time, but never documented;
> state that this measurement should be in lux (drivers may feel
> different about this)
>
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
I agree that it should be in Lux.

Note that I was sure this was documented somewhere so went looking.
It was under drivers/staging/iio/Documentation/sysfs-bus-iio-light

Description agrees with yours so this patch is fine, but we should
drop the version in staging in favour of this.
Note that quite a few elements in that staging file are unlikely to
ever make it out of staging as they currently stand!

Thanks and applied to the togreg branch of iio.git

J

> ---
>   Documentation/ABI/testing/sysfs-bus-iio | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 9669c1f..a9757dc 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -895,6 +895,15 @@ Description:
>   		on-chip EEPROM. After power-up or chip reset the device will
>   		automatically load the saved configuration.
>
> +What:		/sys/.../iio:deviceX/in_illuminanceY_input
> +What:		/sys/.../iio:deviceX/in_illuminanceY_raw
> +What:		/sys/.../iio:deviceX/in_illuminanceY_mean_raw
> +KernelVersion:	3.4
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Illuminance measurement, units after application of scale
> +		and offset are lux.
> +
>   What:		/sys/.../iio:deviceX/in_intensityY_raw
>   What:		/sys/.../iio:deviceX/in_intensityY_ir_raw
>   What:		/sys/.../iio:deviceX/in_intensityY_both_raw
>

