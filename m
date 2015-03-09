Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42342 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095AbbCIK44 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 9 Mar 2015 06:56:56 -0400
Message-ID: <54FD7C75.3040703@kernel.org>
Date: Mon, 09 Mar 2015 10:56:53 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>
CC: linux-iio@vger.kernel.org, pmeerw@pmeerw.net, lars@metafoo.de,
	knaack.h@gmx.de, arnd@arndb.de, fengguang.wu@intel.com
Subject: Re: [PATCH] staging: iio: dummy: Fix undefined symbol build error
References: <1425896153-620-1-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1425896153-620-1-git-send-email-daniel.baluta@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/03/15 10:15, Daniel Baluta wrote:
> CONFIG_SIMPLE_DUMMY_BUFFER compiles in iio_simple_dummy_buffer.c file
> which uses functions from industrialio-trigger.c.
> 
> So, CONFIG_SIMPLE_DUMMY_BUFFER needs to select IIO_TRIGGER in order to
> avoid build error like this:
> 
>> ERROR: "iio_trigger_notify_done" [drivers/staging/iio/iio_dummy.ko] undefined!
>> ERROR: "iio_triggered_buffer_postenable" [drivers/staging/iio/iio_dummy.ko] undefined!
>> ERROR: "iio_triggered_buffer_predisable" [drivers/staging/iio/iio_dummy.ko] undefined!
>> ERROR: "iio_alloc_pollfunc" [drivers/staging/iio/iio_dummy.ko] undefined!
>> ERROR: "iio_dealloc_pollfunc" [drivers/staging/iio/iio_dummy.ko] undefined!
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
Thanks,

This one had me rather confused as well.

Anyhow, applied to the fixes-togreg branch of iio.git.
Will push out later today.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
> index fa38be0..2a15426 100644
> --- a/drivers/staging/iio/Kconfig
> +++ b/drivers/staging/iio/Kconfig
> @@ -38,6 +38,7 @@ config IIO_SIMPLE_DUMMY_EVENTS
>  config IIO_SIMPLE_DUMMY_BUFFER
>  	boolean "Buffered capture support"
>  	select IIO_BUFFER
> +	select IIO_TRIGGER
>  	select IIO_KFIFO_BUF
>  	help
>  	  Add buffered data capture to the simple dummy driver.
> 

