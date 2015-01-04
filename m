Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48410 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751263AbbADLZU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 4 Jan 2015 06:25:20 -0500
Message-ID: <54A9231E.1090706@kernel.org>
Date: Sun, 04 Jan 2015 11:25:18 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Octavian Purdila <octavian.purdila@intel.com>,
	linux-iio@vger.kernel.org, lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 01/11] iio: buffer: fix custom buffer attributes copy
References: <1419122556-8100-1-git-send-email-octavian.purdila@intel.com> <1419122556-8100-2-git-send-email-octavian.purdila@intel.com>
In-Reply-To: <1419122556-8100-2-git-send-email-octavian.purdila@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 21/12/14 00:42, Octavian Purdila wrote:
> Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
Definitely looks like a bug has snuck in here.  Lars, it's your bit of code.
Want to just sanity check this fix before I apply it?

Thanks,

Jonathan
> ---
>  drivers/iio/industrialio-buffer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 2bd8d39..403b728 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -789,7 +789,7 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
>  	buffer->buffer_group.attrs[1] = &dev_attr_enable.attr;
>  	if (buffer->attrs)
>  		memcpy(&buffer->buffer_group.attrs[2], buffer->attrs,
> -			sizeof(*&buffer->buffer_group.attrs) * (attrcount - 2));
> +			sizeof(*&buffer->buffer_group.attrs) * attrcount);
>  	buffer->buffer_group.attrs[attrcount+2] = NULL;
>  
>  	indio_dev->groups[indio_dev->groupcounter++] = &buffer->buffer_group;
> 

