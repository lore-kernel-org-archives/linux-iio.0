Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:36126 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S970371AbdDTQGb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Apr 2017 12:06:31 -0400
MIME-Version: 1.0
In-Reply-To: <1492590045-17329-4-git-send-email-eugen.hristev@microchip.com>
References: <1492590045-17329-1-git-send-email-eugen.hristev@microchip.com> <1492590045-17329-4-git-send-email-eugen.hristev@microchip.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Thu, 20 Apr 2017 19:06:30 +0300
Message-ID: <CAEnQRZADGzSVJfTnd_L+aZ6uEiV5QntyF3mSWm8x0Wma4B3YJw@mail.gmail.com>
Subject: Re: [PATCH 3/3] iio: tools: generic_buffer: increase trigger length
To: Eugen Hristev <eugen.hristev@microchip.com>
Cc: nicolas.ferre@microchip.com, alexandre.belloni@free-electrons.com,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-arm-kernel@lists.infradead.org,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ludovic.desroches@microchip.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Apr 19, 2017 at 11:20 AM, Eugen Hristev
<eugen.hristev@microchip.com> wrote:
> Increased trigger length to 50 in order to cope with trigger names like
> fc030000.adc-dev0-external-rising
>
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
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

While at it, lets be brave and set it to 64. :)

Daniel.
