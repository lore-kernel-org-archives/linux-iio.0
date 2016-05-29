Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:33638 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932246AbcE2Q7h (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 29 May 2016 12:59:37 -0400
Subject: Re: [PATCH] iio: Documentation: fix in_*_scale kernel version
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
References: <1463923848-13157-1-git-send-email-alexandre.belloni@free-electrons.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <97b740bd-9559-fbf0-d27f-3c512409226d@kernel.org>
Date: Sun, 29 May 2016 17:59:33 +0100
MIME-Version: 1.0
In-Reply-To: <1463923848-13157-1-git-send-email-alexandre.belloni@free-electrons.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/05/16 14:30, Alexandre Belloni wrote:
> v3.21 doesn't exist, the first apparition of a in_.*_scale file was in v3.2
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Not that simple as this explicitly in_*_scale in the events directory.
First instance of that is much newer.

This should probably be 4.0 - which fits with when the docs were added and this
patch formed part of a series of enhancements for the mma8452 driver back then.

It's still pretty unusual to find this particular abi element.
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 3c6624881375..ca2d1a6135f1 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -724,7 +724,7 @@ What:		/sys/.../events/in_voltage_supply_scale
>  What:		/sys/.../events/in_temp_scale
>  What:		/sys/.../events/in_illuminance_scale
>  What:		/sys/.../events/in_proximity_scale
> -KernelVersion:	3.21
> +KernelVersion:	3.2
>  Contact:	linux-iio@vger.kernel.org
>  Description:
>                  Specifies the conversion factor from the standard units
> 

