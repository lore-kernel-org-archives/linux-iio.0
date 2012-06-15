Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:44355 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756654Ab2FOMoA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 15 Jun 2012 08:44:00 -0400
Message-ID: <4FDB2E0F.4030904@cam.ac.uk>
Date: Fri, 15 Jun 2012 13:43:59 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 6/6] iio: iio/events.h typos
References: <1339714260-8361-1-git-send-email-pmeerw@pmeerw.net> <1339714260-8361-6-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1339714260-8361-6-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

You haven't signed off on this...

Other than the fact that typo's is rather generous for whole
missing words I'm happy with this ;)

Thanks,

Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>   include/linux/iio/events.h |    6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/iio/events.h b/include/linux/iio/events.h
> index b5acbf9..13ce220 100644
> --- a/include/linux/iio/events.h
> +++ b/include/linux/iio/events.h
> @@ -46,7 +46,7 @@ enum iio_event_direction {
>    * @diff:	Whether the event is for an differential channel or not.
>    * @modifier:	Modifier for the channel. Should be one of enum iio_modifier.
>    * @direction:	Direction of the event. One of enum iio_event_direction.
> - * @type:	Type of the event. Should be one enum iio_event_type.
> + * @type:	Type of the event. Should be one of enum iio_event_type.
>    * @chan:	Channel number for non-differential channels.
>    * @chan1:	First channel number for differential channels.
>    * @chan2:	Second channel number for differential channels.
> @@ -69,7 +69,7 @@ enum iio_event_direction {
>    * @chan_type:	Type of the channel. Should be one of enum iio_chan_type.
>    * @number:	Channel number.
>    * @modifier:	Modifier for the channel. Should be one of enum iio_modifier.
> - * @type:	Type of the event. Should be one enum iio_event_type.
> + * @type:	Type of the event. Should be one of enum iio_event_type.
>    * @direction:	Direction of the event. One of enum iio_event_direction.
>    */
>
> @@ -81,7 +81,7 @@ enum iio_event_direction {
>    * IIO_UNMOD_EVENT_CODE() - create event identifier for unmodified channels
>    * @chan_type:	Type of the channel. Should be one of enum iio_chan_type.
>    * @number:	Channel number.
> - * @type:	Type of the event. Should be one enum iio_event_type.
> + * @type:	Type of the event. Should be one of enum iio_event_type.
>    * @direction:	Direction of the event. One of enum iio_event_direction.
>    */
>

