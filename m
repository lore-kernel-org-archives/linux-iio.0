Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45462 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751434AbbHBRi4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 2 Aug 2015 13:38:56 -0400
Subject: Re: [PATCH v2 1/2] tools: iio: fix mask for 32 bit sensor data
To: Irina Tirdea <irina.tirdea@intel.com>, linux-iio@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>
References: <1437744486-16456-1-git-send-email-irina.tirdea@intel.com>
 <1437744486-16456-2-git-send-email-irina.tirdea@intel.com>
Cc: linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55BE55AE.1000001@kernel.org>
Date: Sun, 2 Aug 2015 18:38:54 +0100
MIME-Version: 1.0
In-Reply-To: <1437744486-16456-2-git-send-email-irina.tirdea@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/07/15 14:28, Irina Tirdea wrote:
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
> Acked-by: Hartmut Knaack <knaack.h@gmx.de>
Applied to the togreg branch of iio.git
Pushed out as testing for the autobuilders to completely
ignore this patch :)

Jonathan
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

