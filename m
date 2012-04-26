Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:35828 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753592Ab2DZNGm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 26 Apr 2012 09:06:42 -0400
Message-ID: <4F99485E.1030102@cam.ac.uk>
Date: Thu, 26 Apr 2012 14:06:38 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	devel@driverdev.osuosl.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add new Industrial I/O subsystem location
References: <1335440802-25450-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1335440802-25450-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 4/26/2012 12:46 PM, Lars-Peter Clausen wrote:
> Add the new out-of-staging IIO directory to the IIO MAINTAINERS file entry.
*laughs*  That was on my todo list but you beat me to it.
>
> Signed-off-by: Lars-Peter Clausen<lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>   MAINTAINERS |    1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2dcfca8..4893026 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3384,6 +3384,7 @@ IIO SUBSYSTEM AND DRIVERS
>   M:	Jonathan Cameron<jic23@cam.ac.uk>
>   L:	linux-iio@vger.kernel.org
>   S:	Maintained
> +F:	drivers/iio/
>   F:	drivers/staging/iio/
>
>   IKANOS/ADI EAGLE ADSL USB DRIVER

