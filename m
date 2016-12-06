Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:48686 "EHLO pmeerw.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753296AbcLFLZ7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 6 Dec 2016 06:25:59 -0500
Date: Tue, 6 Dec 2016 12:25:49 +0100 (CET)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Thierry Escande <thierry.escande@collabora.com>
cc: Jonathan Cameron <jic23@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: core: Add double tap as possible gesture
In-Reply-To: <1480929198-13671-3-git-send-email-thierry.escande@collabora.com>
Message-ID: <alpine.DEB.2.02.1612061223550.29508@pmeerw.net>
References: <1480929198-13671-1-git-send-email-thierry.escande@collabora.com> <1480929198-13671-3-git-send-email-thierry.escande@collabora.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> This adds the IIO_MOD_DOUBLE_TAP entry to the iio_modifier enum and the
> corresponding "double_tap" string to the iio_modifier_names array.

I don't think we should have gestures as channel modifiers

probably a middle layer between IIO and input subsystem is needed (could 
be in userspace?)
 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
> ---
>  drivers/iio/industrialio-core.c | 1 +
>  include/uapi/linux/iio/types.h  | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index fc340ed..82ce05f 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -120,6 +120,7 @@ static const char * const iio_modifier_names[] = {
>  	[IIO_MOD_Q] = "q",
>  	[IIO_MOD_CO2] = "co2",
>  	[IIO_MOD_VOC] = "voc",
> +	[IIO_MOD_DOUBLE_TAP] = "double_tap",
>  };
>  
>  /* relies on pairs of these shared then separate */
> diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
> index 22e5e58..47d2768 100644
> --- a/include/uapi/linux/iio/types.h
> +++ b/include/uapi/linux/iio/types.h
> @@ -80,6 +80,7 @@ enum iio_modifier {
>  	IIO_MOD_CO2,
>  	IIO_MOD_VOC,
>  	IIO_MOD_LIGHT_UV,
> +	IIO_MOD_DOUBLE_TAP,
>  };
>  
>  enum iio_event_type {
> 

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
