Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45442 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751756AbbHBRhK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 2 Aug 2015 13:37:10 -0400
Subject: Re: [PATCH 6/6] include: linux: iio: Add missing kernel doc field
To: Cristina Opriceana <cristina.opriceana@gmail.com>
References: <cover.1437737942.git.cristina.opriceana@gmail.com>
 <d960cd2edacace9344f69ae131a1f399ce7a1f8f.1437737942.git.cristina.opriceana@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	daniel.baluta@intel.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55BE5544.1080500@kernel.org>
Date: Sun, 2 Aug 2015 18:37:08 +0100
MIME-Version: 1.0
In-Reply-To: <d960cd2edacace9344f69ae131a1f399ce7a1f8f.1437737942.git.cristina.opriceana@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/07/15 14:26, Cristina Opriceana wrote:
> Fix kernel doc for the iio_dev_attr structure by adding its missing field.
> 
> Signed-off-by: Cristina Opriceana <cristina.opriceana@gmail.com>
Applied to the togreg branch fo iio.git with one small change.
> ---
>  include/linux/iio/sysfs.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/iio/sysfs.h b/include/linux/iio/sysfs.h
> index 8a1d186..71fdd6f 100644
> --- a/include/linux/iio/sysfs.h
> +++ b/include/linux/iio/sysfs.h
> @@ -18,7 +18,8 @@ struct iio_chan_spec;
>   * struct iio_dev_attr - iio specific device attribute
>   * @dev_attr:	underlying device attribute
>   * @address:	associated register address
> - * @l:		list head for maintaining list of dynamically created attrs.
> + * @l:		list head for maintaining list of dynamically created attrs
> + * @c:		specification for the underlying channels
Only reflects the channel (rather than channels) which resulted in it's creation
(for shared channels the code is supposed to work with any of them being pointed
to here!)

Hence channels -> channel
>   */
>  struct iio_dev_attr {
>  	struct device_attribute dev_attr;
> 

