Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726003AbeIBNev (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 2 Sep 2018 09:34:51 -0400
Date: Sun, 2 Sep 2018 10:19:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Eugen Hristev <eugen.hristev@microchip.com>
Cc: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nicolas.ferre@microchip.com>
Subject: Re: [PATCH TRIVIAL] iio: fix position relative kernel version
Message-ID: <20180902101941.4c6534cf@archlinux>
In-Reply-To: <1535452234-13184-1-git-send-email-eugen.hristev@microchip.com>
References: <1535452234-13184-1-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 28 Aug 2018 13:30:34 +0300
Eugen Hristev <eugen.hristev@microchip.com> wrote:

> Position relative channel type was added in 4.19 kernel version
> 
> Fixes: "3055a6cfa04ba" ("iio: Add channel for Position Relative")
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>

Applied, thanks.

Jonathan
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index a5b4f22..8127a08 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -199,7 +199,7 @@ Description:
>  
>  What:		/sys/bus/iio/devices/iio:deviceX/in_positionrelative_x_raw
>  What:		/sys/bus/iio/devices/iio:deviceX/in_positionrelative_y_raw
> -KernelVersion:	4.18
> +KernelVersion:	4.19
>  Contact:	linux-iio@vger.kernel.org
>  Description:
>  		Relative position in direction x or y on a pad (may be
> -- 
> 2.7.4
> 
