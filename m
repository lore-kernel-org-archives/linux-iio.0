Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:56113 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753857AbbGXSXr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 24 Jul 2015 14:23:47 -0400
Message-ID: <55B282A8.40903@gmx.de>
Date: Fri, 24 Jul 2015 20:23:36 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Irina Tirdea <irina.tirdea@intel.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] tools: iio: print error message when
 buffer enable fails
References: <1437744486-16456-1-git-send-email-irina.tirdea@intel.com> <1437744486-16456-3-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1437744486-16456-3-git-send-email-irina.tirdea@intel.com>
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Irina Tirdea schrieb am 24.07.2015 um 15:28:
> Running generic_buffer without enabling any channel of the
> sensor will fail without printing any error message.
> 
> Add an error message that indicates buffer enable failed.
> 
> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
Acked-by: Hartmut Knaack <knaack.h@gmx.de>
> ---
>  tools/iio/generic_buffer.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/iio/generic_buffer.c b/tools/iio/generic_buffer.c
> index 32f389eb..9f7b85b 100644
> --- a/tools/iio/generic_buffer.c
> +++ b/tools/iio/generic_buffer.c
> @@ -364,8 +364,11 @@ int main(int argc, char **argv)
>  
>  	/* Enable the buffer */
>  	ret = write_sysfs_int("enable", buf_dir_name, 1);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		fprintf(stderr,
> +			"Failed to enable buffer: %s\n", strerror(-ret));
>  		goto error_free_buf_dir_name;
> +	}
>  
>  	scan_size = size_from_channelarray(channels, num_channels);
>  	data = malloc(scan_size * buf_len);
> 

