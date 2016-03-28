Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45665 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752345AbcC1Oca (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 28 Mar 2016 10:32:30 -0400
Subject: Re: [PATCH] iio: buffer: add missing descriptions in
 iio_buffer_access_funcs
To: Luis de Bethencourt <luisbg@osg.samsung.com>,
	linux-kernel@vger.kernel.org
References: <1458736481-8928-1-git-send-email-luisbg@osg.samsung.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56F9407B.3010308@kernel.org>
Date: Mon, 28 Mar 2016 15:32:27 +0100
MIME-Version: 1.0
In-Reply-To: <1458736481-8928-1-git-send-email-luisbg@osg.samsung.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/03/16 12:34, Luis de Bethencourt wrote:
> The members buffer_group and attrs of iio_buffer_access_funcs have no
> descriptions for the documentation. Adding them.
> 
> Fixes: 08e7e0adaa17 ("iio: buffer: Allocate standard attributes in the core")
> Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
Applied - thanks for clearing that up.

Jonathan
> ---
> Hi,
> 
> I noticed these warnings when running make htmldocs:
> .//include/linux/iio/buffer.h:114: warning: No description found for parameter 'buffer_group'
> .//include/linux/iio/buffer.h:114: warning: No description found for parameter 'attrs'
> 
> 
> Thanks,
> Luis
> 
>  include/linux/iio/buffer.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
> index 2ec3ad5..70a5164 100644
> --- a/include/linux/iio/buffer.h
> +++ b/include/linux/iio/buffer.h
> @@ -83,10 +83,12 @@ struct iio_buffer_access_funcs {
>   * @access:		[DRIVER] buffer access functions associated with the
>   *			implementation.
>   * @scan_el_dev_attr_list:[INTERN] list of scan element related attributes.
> + * @buffer_group:	[INTERN] attributes of the buffer group
>   * @scan_el_group:	[DRIVER] attribute group for those attributes not
>   *			created from the iio_chan_info array.
>   * @pollq:		[INTERN] wait queue to allow for polling on the buffer.
>   * @stufftoread:	[INTERN] flag to indicate new data.
> + * @attrs:		[INTERN] standard attributes of the buffer
>   * @demux_list:		[INTERN] list of operations required to demux the scan.
>   * @demux_bounce:	[INTERN] buffer for doing gather from incoming scan.
>   * @buffer_list:	[INTERN] entry in the devices list of current buffers.
> 

