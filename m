Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44967 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000AbbCIRMe (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 9 Mar 2015 13:12:34 -0400
Message-ID: <54FDD480.202@kernel.org>
Date: Mon, 09 Mar 2015 17:12:32 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	linux-iio@vger.kernel.org
CC: daniel.baluta@intel.com, octavian.purdila@intel.com,
	knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net
Subject: Re: [PATCH 1/5] staging: iio: Documentation: iio_event_monitor: Include
 linux/iio/types.h
References: <1424940567-24877-1-git-send-email-roberta.dobrescu@gmail.com> <1424940567-24877-2-git-send-email-roberta.dobrescu@gmail.com>
In-Reply-To: <1424940567-24877-2-git-send-email-roberta.dobrescu@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 26/02/15 08:49, Roberta Dobrescu wrote:
> By adding this line and installing the kernel headers with
> make headers_install, iio_event_monitor can be compiled without
> any hacks.
> 
> Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
Applied to the togreg branch of iio.git

Thanks,

Jonathan
> ---
>  drivers/staging/iio/Documentation/iio_event_monitor.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/iio/Documentation/iio_event_monitor.c b/drivers/staging/iio/Documentation/iio_event_monitor.c
> index 72c96aa..019a6e5 100644
> --- a/drivers/staging/iio/Documentation/iio_event_monitor.c
> +++ b/drivers/staging/iio/Documentation/iio_event_monitor.c
> @@ -28,6 +28,7 @@
>  #include <sys/ioctl.h>
>  #include "iio_utils.h"
>  #include <linux/iio/events.h>
> +#include <linux/iio/types.h>
>  
>  static const char * const iio_chan_type_name_spec[] = {
>  	[IIO_VOLTAGE] = "voltage",
> 

