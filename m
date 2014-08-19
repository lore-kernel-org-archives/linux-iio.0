Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51688 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753627AbaHSTO3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 19 Aug 2014 15:14:29 -0400
Message-ID: <53F3A214.6080003@kernel.org>
Date: Tue, 19 Aug 2014 20:14:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add entry for Analog Devices IIO drivers
References: <1408349339-21757-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1408349339-21757-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/08/14 09:08, Lars-Peter Clausen wrote:
> Add Michael and myself as the maintainer for the Analog Devices IIO drivers.
> The entry matches on all files in drivers/staging/iio and drivers/iio/ starting
> with the 'ad' prefix, except for 'adjd' as that one is used by Avago
> Technologies.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git.

Thanks,

J
> ---
>  MAINTAINERS | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6d2c52e..894756c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -667,6 +667,16 @@ W:	http://blackfin.uclinux.org/
>  S:	Supported
>  F:	sound/soc/blackfin/*
>  
> +ANALOG DEVICES INC IIO DRIVERS
> +M:	Lars-Peter Clausen <lars@metafoo.de>
> +M: Michael Hennerich <Michael.Hennerich@analog.com>
> +W:	http://wiki.analog.com/
> +W:	http://ez.analog.com/community/linux-device-drivers
> +S:	Supported
> +F:	drivers/iio/*/ad*
> +X:	drivers/iio/*/adjd*
> +F:	drivers/staging/iio/*/ad*
> +F:	staging/iio/trigger/iio-trig-bfin-timer.c
> +
>  AOA (Apple Onboard Audio) ALSA DRIVER
>  M:	Johannes Berg <johannes@sipsolutions.net>
>  L:	linuxppc-dev@lists.ozlabs.org
> 
