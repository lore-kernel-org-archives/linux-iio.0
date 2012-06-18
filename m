Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41585 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752633Ab2FRHjc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 18 Jun 2012 03:39:32 -0400
Message-ID: <4FDEDB32.6020308@kernel.org>
Date: Mon, 18 Jun 2012 08:39:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/4] iio: remove extra ; after function definition
References: <1339952599-22105-1-git-send-email-pmeerw@pmeerw.net> <1339952599-22105-6-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1339952599-22105-6-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 6/17/2012 6:03 PM, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald<pmeerw@pmeerw.net>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>   include/linux/iio/buffer.h |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
> index fb0fe46..ad4fb1a 100644
> --- a/include/linux/iio/buffer.h
> +++ b/include/linux/iio/buffer.h
> @@ -184,7 +184,7 @@ static inline int iio_buffer_register(struct iio_dev *indio_dev,
>   }
>
>   static inline void iio_buffer_unregister(struct iio_dev *indio_dev)
> -{};
> +{}
>
>   #endif /* CONFIG_IIO_BUFFER */
>

