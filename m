Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40350 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753122Ab2H1ToH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 28 Aug 2012 15:44:07 -0400
Message-ID: <503D1F85.8050806@kernel.org>
Date: Tue, 28 Aug 2012 20:44:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: fix spelling of subsystem
References: <1346101957-9413-1-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1346101957-9413-1-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/27/2012 10:12 PM, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
oops and merge to togreg branch.

Good spot ;)
> ---
>  drivers/iio/Kconfig         |    2 +-
>  drivers/staging/iio/Kconfig |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
> index d4984c8..56825e6 100644
> --- a/drivers/iio/Kconfig
> +++ b/drivers/iio/Kconfig
> @@ -1,5 +1,5 @@
>  #
> -# Industrial I/O subsytem configuration
> +# Industrial I/O subsystem configuration
>  #
>  
>  menuconfig IIO
> diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
> index 04cd6ec..ca56c75 100644
> --- a/drivers/staging/iio/Kconfig
> +++ b/drivers/staging/iio/Kconfig
> @@ -1,5 +1,5 @@
>  #
> -# Industrial I/O subsytem configuration
> +# Industrial I/O subsystem configuration
>  #
>  menu "IIO staging drivers"
>  	depends on IIO
> 
