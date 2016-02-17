Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56514 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965348AbcBQVLn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 17 Feb 2016 16:11:43 -0500
Subject: Re: [PATCH] iio: Fix typos in the struct iio_event_spec documentation
 comments
To: William Breathitt Gray <vilhelm.gray@gmail.com>, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net
References: <20160215174742.GA9872@sophia>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56C4E20D.9080508@kernel.org>
Date: Wed, 17 Feb 2016 21:11:41 +0000
MIME-Version: 1.0
In-Reply-To: <20160215174742.GA9872@sophia>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/02/16 17:47, William Breathitt Gray wrote:
> This patch fixes a few minor typos in the documentation comments for the
> scan_type member of the iio_event_spec structure. The sign member name
> was improperly capitalized as "Sign" in the comments. The storagebits
> member name was improperly listed as "storage_bits" in the comments. The
> endianness member entry in the comments was moved after the repeat
> member entry in order to maintain consistency with the actual struct
> iio_event_spec layout.
> 
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
Applied to the togreg branch of iio.git - initially pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  include/linux/iio/iio.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index ce9e9c1..b2b1677 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -180,18 +180,18 @@ struct iio_event_spec {
>   * @address:		Driver specific identifier.
>   * @scan_index:		Monotonic index to give ordering in scans when read
>   *			from a buffer.
> - * @scan_type:		Sign:		's' or 'u' to specify signed or unsigned
> + * @scan_type:		sign:		's' or 'u' to specify signed or unsigned
>   *			realbits:	Number of valid bits of data
> - *			storage_bits:	Realbits + padding
> + *			storagebits:	Realbits + padding
>   *			shift:		Shift right by this before masking out
>   *					realbits.
> - *			endianness:	little or big endian
>   *			repeat:		Number of times real/storage bits
>   *					repeats. When the repeat element is
>   *					more than 1, then the type element in
>   *					sysfs will show a repeat value.
>   *					Otherwise, the number of repetitions is
>   *					omitted.
> + *			endianness:	little or big endian
>   * @info_mask_separate: What information is to be exported that is specific to
>   *			this channel.
>   * @info_mask_shared_by_type: What information is to be exported that is shared
> 

