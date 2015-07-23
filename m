Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.22]:58688 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753765AbbGWXNa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 23 Jul 2015 19:13:30 -0400
Message-ID: <55B17515.7030508@gmx.de>
Date: Fri, 24 Jul 2015 01:13:25 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Irina Tirdea <irina.tirdea@intel.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] tools: iio: print error message when buffer
 enable fails
References: <1437672172-21189-1-git-send-email-irina.tirdea@intel.com> <1437672172-21189-3-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1437672172-21189-3-git-send-email-irina.tirdea@intel.com>
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Irina Tirdea schrieb am 23.07.2015 um 19:22:
> Running generic_buffer without enabling any channel of the
> sensor will fail without printing any error message.
> 
> Add an error message that indicates buffer enable failed.

Hi,
please make use of the error code stored in ret (with negative sign), as
in most cases the value of errno has already changed since the original
error has occurred.
Thanks,

Hartmut

> 
> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> ---
>  tools/iio/generic_buffer.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/iio/generic_buffer.c b/tools/iio/generic_buffer.c
> index 32f389eb..936469c 100644
> --- a/tools/iio/generic_buffer.c
> +++ b/tools/iio/generic_buffer.c
> @@ -364,8 +364,11 @@ int main(int argc, char **argv)
>  
>  	/* Enable the buffer */
>  	ret = write_sysfs_int("enable", buf_dir_name, 1);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		fprintf(stderr,
> +			"Failed to enable buffer: %s\n", strerror(errno));
>  		goto error_free_buf_dir_name;
> +	}
>  
>  	scan_size = size_from_channelarray(channels, num_channels);
>  	data = malloc(scan_size * buf_len);
> 

