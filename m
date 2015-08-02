Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45421 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810AbbHBRea (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 2 Aug 2015 13:34:30 -0400
Subject: Re: [PATCH 5/6] include: linux: iio: Fix function parameter name in
 kernel doc
To: Cristina Opriceana <cristina.opriceana@gmail.com>
References: <cover.1437737942.git.cristina.opriceana@gmail.com>
 <7461b4e6114a382e8669e132a8ef29c232b376c1.1437737942.git.cristina.opriceana@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	daniel.baluta@intel.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55BE54A5.6050702@kernel.org>
Date: Sun, 2 Aug 2015 18:34:29 +0100
MIME-Version: 1.0
In-Reply-To: <7461b4e6114a382e8669e132a8ef29c232b376c1.1437737942.git.cristina.opriceana@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/07/15 14:23, Cristina Opriceana wrote:
> Fix buffer name from kernel doc according to the function parameter.
> 
> Signed-off-by: Cristina Opriceana <cristina.opriceana@gmail.com>
Applied

Jonathan
> ---
>  include/linux/iio/consumer.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
> index 26fb8f6..fad5867 100644
> --- a/include/linux/iio/consumer.h
> +++ b/include/linux/iio/consumer.h
> @@ -100,7 +100,7 @@ void iio_channel_stop_all_cb(struct iio_cb_buffer *cb_buff);
>  
>  /**
>   * iio_channel_cb_get_channels() - get access to the underlying channels.
> - * @cb_buff:		The callback buffer from whom we want the channel
> + * @cb_buffer:		The callback buffer from whom we want the channel
>   *			information.
>   *
>   * This function allows one to obtain information about the channels.
> 

