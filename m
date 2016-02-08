Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37916 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754857AbcBHSew (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 8 Feb 2016 13:34:52 -0500
Subject: Re: [PATCH] iio: Fix documentation for iio_dev mlock
To: Daniel Baluta <daniel.baluta@intel.com>
References: <1454943795-7582-1-git-send-email-daniel.baluta@intel.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56B8DFCA.9010807@kernel.org>
Date: Mon, 8 Feb 2016 18:34:50 +0000
MIME-Version: 1.0
In-Reply-To: <1454943795-7582-1-git-send-email-daniel.baluta@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/02/16 15:03, Daniel Baluta wrote:
> mlock *must* be used by core and drivers to protect access
> to devices state changes.
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
Applied. Thanks for cleaning this up.

Jonathan
> ---
> At a first glance there are few places where access to iio_dev
> state changes are done without mlock protection. Will fix them
> with follow up patches.
> 
>  include/linux/iio/iio.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index b589411..ce9e9c1 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -448,7 +448,7 @@ struct iio_buffer_setup_ops {
>   * @buffer:		[DRIVER] any buffer present
>   * @buffer_list:	[INTERN] list of all buffers currently attached
>   * @scan_bytes:		[INTERN] num bytes captured to be fed to buffer demux
> - * @mlock:		[INTERN] lock used to prevent simultaneous device state
> + * @mlock:		[DRIVER] lock used to prevent simultaneous device state
>   *			changes
>   * @available_scan_masks: [DRIVER] optional array of allowed bitmasks
>   * @masklength:		[INTERN] the length of the mask established from
> 

