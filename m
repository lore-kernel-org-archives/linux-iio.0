Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:42721 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756770Ab2FOMqw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 15 Jun 2012 08:46:52 -0400
Message-ID: <4FDB2EBA.1090808@cam.ac.uk>
Date: Fri, 15 Jun 2012 13:46:50 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/6] iio: iio/machine.h typo
References: <1339714260-8361-1-git-send-email-pmeerw@pmeerw.net> <1339714260-8361-3-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1339714260-8361-3-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


There I go inventing more words ;)
> Signed-off-by: Peter Meerwald<pmeerw@pmeerw.net>
Acked-by: Jonathan Cameron <jic23@kernel.org>
>
> ---
>   include/linux/iio/machine.h |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/iio/machine.h b/include/linux/iio/machine.h
> index 0b1f19b..400a453 100644
> --- a/include/linux/iio/machine.h
> +++ b/include/linux/iio/machine.h
> @@ -14,7 +14,7 @@
>    *			This is matched against the datasheet_name element
>    *			of struct iio_chan_spec.
>    * @consumer_dev_name:	Name to uniquely identify the consumer device.
> - * @consumer_channel:	Unique name used to idenitify the channel on the
> + * @consumer_channel:	Unique name used to identify the channel on the
>    *			consumer side.
>    */
>   struct iio_map {

