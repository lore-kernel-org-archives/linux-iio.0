Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751452AbdGAJXZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 Jul 2017 05:23:25 -0400
Date: Sat, 1 Jul 2017 10:23:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-iio@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [PATCH v2 1/2] iio: light: tcs3472: add link to datasheet
Message-ID: <20170701102321.618a6057@kernel.org>
In-Reply-To: <1498491895-19393-2-git-send-email-akinobu.mita@gmail.com>
References: <1498491895-19393-1-git-send-email-akinobu.mita@gmail.com>
        <1498491895-19393-2-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 27 Jun 2017 00:44:54 +0900
Akinobu Mita <akinobu.mita@gmail.com> wrote:

> Add a link to the TCS3472 datasheet in the AMS's website.
> 
> Cc: Peter Meerwald <pmeerw@pmeerw.net>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Applied.

Thanks,

Jonathan
> ---
>  drivers/iio/light/tcs3472.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/light/tcs3472.c b/drivers/iio/light/tcs3472.c
> index a9e153b..09e6ca5 100644
> --- a/drivers/iio/light/tcs3472.c
> +++ b/drivers/iio/light/tcs3472.c
> @@ -11,6 +11,8 @@
>   * 7-bit I2C slave address 0x39 (TCS34721, TCS34723) or 0x29 (TCS34725,
>   * TCS34727)
>   *
> + * Datasheet: http://ams.com/eng/content/download/319364/1117183/file/TCS3472_Datasheet_EN_v2.pdf
> + *
>   * TODO: interrupt support, thresholds, wait time
>   */
>  

