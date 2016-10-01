Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43908 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750850AbcJALJf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Oct 2016 07:09:35 -0400
Subject: Re: [PATCH] iio: Declare event_attrs field of iio_info structure as
 const
To: Bhumika Goyal <bhumirks@gmail.com>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1475315838-15366-1-git-send-email-bhumirks@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <743239c7-8341-6fdf-b493-ac98a4853322@kernel.org>
Date: Sat, 1 Oct 2016 12:09:14 +0100
MIME-Version: 1.0
In-Reply-To: <1475315838-15366-1-git-send-email-bhumirks@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/10/16 10:57, Bhumika Goyal wrote:
> The event_attrs field of iio_info structure is only initialized once
> whenever an object of iio_info is created. After that this field
> is never modified again anywhere in the kernel. So, declare event_attrs
> field of iio_info as a const struct attribute_group.
> Checked for occurences throughout the kernel using grep and
> coccinelle.
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Clearly this becomes more interesting when the follow up patches
making ever event_attr group we can constant. 
Looking forward to those ;)


Jonathan
> ---
>  include/linux/iio/iio.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index b4a0679..4591d8e 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -381,7 +381,7 @@ struct iio_dev;
>   **/
>  struct iio_info {
>  	struct module			*driver_module;
> -	struct attribute_group		*event_attrs;
> +	const struct attribute_group	*event_attrs;
>  	const struct attribute_group	*attrs;
>  
>  	int (*read_raw)(struct iio_dev *indio_dev,
> 

