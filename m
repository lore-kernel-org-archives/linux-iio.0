Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57888 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752174AbcGSFgZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 19 Jul 2016 01:36:25 -0400
Subject: Re: [PATCH 03/10] iio: core: Add double tap as possible gesture
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <1468825370-20075-1-git-send-email-enric.balletbo@collabora.com>
 <1468825370-20075-4-git-send-email-enric.balletbo@collabora.com>
Cc: Olof Johansson <olof@lixom.net>, Lee Jones <lee.jones@linaro.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Guenter Roeck <groeck@chromium.org>,
	Gwendal Grignou <gwendal@chromium.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <2e85b96a-4772-1c52-9963-efd788c460e8@kernel.org>
Date: Mon, 18 Jul 2016 14:54:39 +0100
MIME-Version: 1.0
In-Reply-To: <1468825370-20075-4-git-send-email-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/07/16 08:02, Enric Balletbo i Serra wrote:
> From: Gwendal Grignou <gwendal@chromium.org>
> 
> This is an interface change: however, the sysfs entry is based on string,
> so if other gestures are added on the trunk in the meantime, we will
> still be able to merge this change.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> Signed-off-by: Guenter Roeck <groeck@chromium.org>
> [enric: Rebased and resolved conflicts]
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
So you are creating an entire channel type for double tap?

Not keen on this I'm afraid.

The activity types in there are the moment are not events, but rather
attempts to estimate the 'likelihood' that a given activity is currently
being undertaken.

Hmm. Double tap is more of an event type.  It's one I've been wondering
how to describe for a while... At the end of the day it's just a
reasonably sophisticated filter - kind of a 'magic' version of Rate
of Change.  Unfortunately there isn't a clean mathematical definition
as it can be implemented in lots of ways.  

I guess the best may be to just have it as an event type on it's own...

What do others think?

Jonathan
> ---
>  drivers/iio/industrialio-core.c | 1 +
>  include/uapi/linux/iio/types.h  | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index e6319a9..f700e67 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -119,6 +119,7 @@ static const char * const iio_modifier_names[] = {
>  	[IIO_MOD_Q] = "q",
>  	[IIO_MOD_CO2] = "co2",
>  	[IIO_MOD_VOC] = "voc",
> +	[IIO_MOD_DOUBLE_TAP] = "double_tap",
>  };
>  
>  /* relies on pairs of these shared then separate */
> diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
> index b0916fc..c290167 100644
> --- a/include/uapi/linux/iio/types.h
> +++ b/include/uapi/linux/iio/types.h
> @@ -79,6 +79,7 @@ enum iio_modifier {
>  	IIO_MOD_CO2,
>  	IIO_MOD_VOC,
>  	IIO_MOD_LIGHT_UV,
> +	IIO_MOD_DOUBLE_TAP,
>  };
>  
>  enum iio_event_type {
> 

