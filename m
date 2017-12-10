Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751743AbdLJThq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Dec 2017 14:37:46 -0500
Date: Sun, 10 Dec 2017 19:37:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-iio@vger.kernel.org, Gregor Boirie <gregor.boirie@parrot.com>
Subject: Re: [PATCH] iio: ABI: Fix name of timestamp sysfs file
Message-ID: <20171210193742.3bef9cba@archlinux>
In-Reply-To: <20171205105727.3737-1-linus.walleij@linaro.org>
References: <20171205105727.3737-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue,  5 Dec 2017 11:57:27 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> The name of the file is "current_timetamp_clock" not
> "timestamp_clock".
> 
> Fixes: bc2b7dab629a ("iio:core: timestamping clock selection support")
> Cc: Gregor Boirie <gregor.boirie@parrot.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Doh!  Applied to the togreg branch of iio.git and pushed out
as testing for the autobuilders to ignore it.

Jonathan
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 2e3f919485f4..fdec308a5041 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -32,7 +32,7 @@ Description:
>  		Description of the physical chip / device for device X.
>  		Typically a part number.
>  
> -What:		/sys/bus/iio/devices/iio:deviceX/timestamp_clock
> +What:		/sys/bus/iio/devices/iio:deviceX/current_timestamp_clock
>  KernelVersion:	4.5
>  Contact:	linux-iio@vger.kernel.org
>  Description:

