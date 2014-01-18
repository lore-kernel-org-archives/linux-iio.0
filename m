Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37761 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753685AbaARLIl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 18 Jan 2014 06:08:41 -0500
Message-ID: <52DA60C7.5010808@kernel.org>
Date: Sat, 18 Jan 2014 11:08:55 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/6] staging:iio:accel:sca3000: Event_attribute_group
 seems to be missing for _info_with_temp
References: <1389648514-31429-1-git-send-email-pmeerw@pmeerw.net> <1389648514-31429-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1389648514-31429-2-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 13/01/14 21:28, Peter Meerwald wrote:
> issue introduced here 6fe8135f:
> staging:iio: implement an iio_info structure to take some of the constant elements out of iio_dev
>
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Applied to the togreg branch of iio.git.

Clearly we could have pushed this out as a fix, but given no one has commented on it and
the amount of other stuff you are cleaning up in the driver, I don't think it is terribly
urgent.  Hence can go through the slow route...

Jonathan
> ---
>   drivers/staging/iio/accel/sca3000_core.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
> index b627d8f..159272e 100644
> --- a/drivers/staging/iio/accel/sca3000_core.c
> +++ b/drivers/staging/iio/accel/sca3000_core.c
> @@ -1141,6 +1141,7 @@ static const struct iio_info sca3000_info = {
>   static const struct iio_info sca3000_info_with_temp = {
>   	.attrs = &sca3000_attribute_group_with_temp,
>   	.read_raw = &sca3000_read_raw,
> +	.event_attrs = &sca3000_event_attribute_group,
>   	.read_event_value = &sca3000_read_thresh,
>   	.write_event_value = &sca3000_write_thresh,
>   	.read_event_config = &sca3000_read_event_config,
>
