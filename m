Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:46284 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756770Ab2FOMqJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 15 Jun 2012 08:46:09 -0400
Message-ID: <4FDB2E90.3090901@cam.ac.uk>
Date: Fri, 15 Jun 2012 13:46:08 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 4/6] iio: add IIO_ALTVOLTAGE to iio_event_monitor example
References: <1339714260-8361-1-git-send-email-pmeerw@pmeerw.net> <1339714260-8361-4-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1339714260-8361-4-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


Fair enough though would be good to have a comment that says
what driver actually sends altvoltage events...
On 6/14/2012 11:50 PM, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald<pmeerw@pmeerw.net>
Acked-by: Jonathan Cameron <jic23@kernel.org>
>
> ---
>   .../staging/iio/Documentation/iio_event_monitor.c  |    2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/staging/iio/Documentation/iio_event_monitor.c b/drivers/staging/iio/Documentation/iio_event_monitor.c
> index 2227584..4326e9e 100644
> --- a/drivers/staging/iio/Documentation/iio_event_monitor.c
> +++ b/drivers/staging/iio/Documentation/iio_event_monitor.c
> @@ -45,6 +45,7 @@ static const char * const iio_chan_type_name_spec[] = {
>   	[IIO_ANGL] = "angl",
>   	[IIO_TIMESTAMP] = "timestamp",
>   	[IIO_CAPACITANCE] = "capacitance",
> +	[IIO_ALTVOLTAGE] = "altvoltage",
>   };
>
>   static const char * const iio_ev_type_text[] = {
> @@ -92,6 +93,7 @@ static bool event_is_known(struct iio_event_data *event)
>   	case IIO_ANGL:
>   	case IIO_TIMESTAMP:
>   	case IIO_CAPACITANCE:
> +	case IIO_ALTVOLTAGE:
>   		break;
>   	default:
>   		return false;

