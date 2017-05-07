Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57560 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756552AbdEGWLH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 May 2017 18:11:07 -0400
Subject: Re: [PATCH v2 3/3] iio: tools: generic_buffer: increase trigger
 length
To: Eugen Hristev <eugen.hristev@microchip.com>,
        nicolas.ferre@microchip.com, alexandre.belloni@free-electrons.com,
        linux-iio@vger.kernel.org, lars@metafoo.de,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: ludovic.desroches@microchip.com
References: <1493900000-26220-1-git-send-email-eugen.hristev@microchip.com>
 <1493900000-26220-4-git-send-email-eugen.hristev@microchip.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <c02626ec-4580-ef36-3b38-535e18531473@kernel.org>
Date: Sun, 7 May 2017 16:03:01 +0100
MIME-Version: 1.0
In-Reply-To: <1493900000-26220-4-git-send-email-eugen.hristev@microchip.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/05/17 13:13, Eugen Hristev wrote:
> Increased trigger length to 64 in order to cope with trigger names
> like fc030000.adc-dev0-external-rising
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Might as well change this now.

Applied to the togreg branch of iio.git.

Thanks,

Jonathan
> ---
>  Changes in v2:
>  - Modified trigger name length to 64
> 
>  tools/iio/iio_utils.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/iio/iio_utils.h b/tools/iio/iio_utils.h
> index 780f201..8b379da 100644
> --- a/tools/iio/iio_utils.h
> +++ b/tools/iio/iio_utils.h
> @@ -13,7 +13,7 @@
>  #include <stdint.h>
>  
>  /* Made up value to limit allocation sizes */
> -#define IIO_MAX_NAME_LENGTH 30
> +#define IIO_MAX_NAME_LENGTH 64
>  
>  #define FORMAT_SCAN_ELEMENTS_DIR "%s/scan_elements"
>  #define FORMAT_TYPE_FILE "%s_type"
> 

