Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41598 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751356Ab2FRHjw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 18 Jun 2012 03:39:52 -0400
Message-ID: <4FDEDB46.7050702@kernel.org>
Date: Mon, 18 Jun 2012 08:39:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/4] iio: typo in iio_chan_spec.ext_info comment
References: <1339952599-22105-1-git-send-email-pmeerw@pmeerw.net> <1339952599-22105-4-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1339952599-22105-4-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 6/17/2012 6:03 PM, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald<pmeerw@pmeerw.net>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>   include/linux/iio/iio.h |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index ae0cad9..2afbb6f 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -214,7 +214,7 @@ ssize_t iio_enum_write(struct iio_dev *indio_dev,
>    * @event_mask:		What events can this channel produce.
>    * @ext_info:		Array of extended info attributes for this channel.
>    *			The array is NULL terminated, the last element should
> - *			have it's name field set to NULL.
> + *			have its name field set to NULL.
>    * @extend_name:	Allows labeling of channel attributes with an
>    *			informative name. Note this has no effect codes etc,
>    *			unlike modifiers.

