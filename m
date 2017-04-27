Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37613 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161849AbdD0FTk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Apr 2017 01:19:40 -0400
Subject: Re: [PATCH 3/3] iio: tools: generic_buffer: increase trigger length
To: Eugen Hristev <eugen.hristev@microchip.com>,
        nicolas.ferre@microchip.com, alexandre.belloni@free-electrons.com,
        linux-iio@vger.kernel.org, lars@metafoo.de,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: ludovic.desroches@microchip.com
References: <1492590045-17329-1-git-send-email-eugen.hristev@microchip.com>
 <1492590045-17329-4-git-send-email-eugen.hristev@microchip.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <b9f248a1-b65a-5e23-421c-4b8256cdddd6@kernel.org>
Date: Thu, 27 Apr 2017 06:19:35 +0100
MIME-Version: 1.0
In-Reply-To: <1492590045-17329-4-git-send-email-eugen.hristev@microchip.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/04/17 09:20, Eugen Hristev wrote:
> Increased trigger length to 50 in order to cope with trigger names like
> fc030000.adc-dev0-external-rising
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
This is fine (though I'd go bigger as Daniel suggested)
I'll pick it up with the revised series.

thanks,

Jonathan
> ---
>  tools/iio/iio_utils.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/iio/iio_utils.h b/tools/iio/iio_utils.h
> index 780f201..9d59771 100644
> --- a/tools/iio/iio_utils.h
> +++ b/tools/iio/iio_utils.h
> @@ -13,7 +13,7 @@
>  #include <stdint.h>
>  
>  /* Made up value to limit allocation sizes */
> -#define IIO_MAX_NAME_LENGTH 30
> +#define IIO_MAX_NAME_LENGTH 50
>  
>  #define FORMAT_SCAN_ELEMENTS_DIR "%s/scan_elements"
>  #define FORMAT_TYPE_FILE "%s_type"
> 

