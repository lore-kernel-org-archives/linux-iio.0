Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45048 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756606AbaEJKim (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 10 May 2014 06:38:42 -0400
Message-ID: <536E0215.8070708@kernel.org>
Date: Sat, 10 May 2014 11:40:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org
CC: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: always select ANON_INODES
References: <1399560433-1402630-1-git-send-email-arnd@arndb.de> <1399560990-1402858-1-git-send-email-arnd@arndb.de> <1399560990-1402858-12-git-send-email-arnd@arndb.de>
In-Reply-To: <1399560990-1402858-12-git-send-email-arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/05/14 15:56, Arnd Bergmann wrote:
> Without ANON_INODES, we get this build error:
>
> drivers/built-in.o: In function `iio_event_getfd':
> :(.text+0x14bf18): undefined reference to `anon_inode_getfd'
>
> All other users explicitly select this symbol, so we should
> do the same thing here.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: linux-iio@vger.kernel.org
Applied to the togreg branch of iio.git.

Thanks,
> ---
>   drivers/iio/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
> index 743485e..345395e 100644
> --- a/drivers/iio/Kconfig
> +++ b/drivers/iio/Kconfig
> @@ -4,6 +4,7 @@
>
>   menuconfig IIO
>   	tristate "Industrial I/O support"
> +	select ANON_INODES
>   	help
>   	  The industrial I/O subsystem provides a unified framework for
>   	  drivers for many different types of embedded sensors using a
>

