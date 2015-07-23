Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.22]:57860 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753682AbbGWXGQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 23 Jul 2015 19:06:16 -0400
Message-ID: <55B1735B.5040706@gmx.de>
Date: Fri, 24 Jul 2015 01:06:03 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Irina Tirdea <irina.tirdea@intel.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] tools: iio: fix mask for 32 bit sensor data
References: <1437672172-21189-1-git-send-email-irina.tirdea@intel.com> <1437672172-21189-2-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1437672172-21189-2-git-send-email-irina.tirdea@intel.com>
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Irina Tirdea schrieb am 23.07.2015 um 19:22:
> When the the sensor data uses 32 bits out of 32, generic_buffer prints
> the value 0 for all data read.
> 
> In this case, the mask is shifted 32 bits, which is beyond the size of
> an integer. This will lead to the mask always being 0. Before printing,
> the mask is applied to the raw value, thus generating a final value of 0.
> 
> Fix the mask by shifting a 64 bit value instead of an integer.
> 
> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
Acked-by: Hartmut Knaack <knaack.h@gmx.de>
> ---
>  tools/iio/iio_utils.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
> index 1dcdf03..a95270f 100644
> --- a/tools/iio/iio_utils.c
> +++ b/tools/iio/iio_utils.c
> @@ -168,7 +168,7 @@ int iioutils_get_type(unsigned *is_signed, unsigned *bytes, unsigned *bits_used,
>  			if (*bits_used == 64)
>  				*mask = ~0;
>  			else
> -				*mask = (1 << *bits_used) - 1;
> +				*mask = (1ULL << *bits_used) - 1;
>  
>  			*is_signed = (signchar == 's');
>  			if (fclose(sysfsfp)) {
> 

