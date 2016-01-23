Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40441 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753544AbcAWQ2p (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 23 Jan 2016 11:28:45 -0500
Subject: Re: [PATCH 2/3] iio: mma8452: whitespace cleanup
To: Martin Kepplinger <martink@posteo.de>, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net,
	christoph.muellner@theobroma-systems.com, mfuzzey@parkeon.com
References: <1452954922-2266-1-git-send-email-martink@posteo.de>
 <1452954922-2266-3-git-send-email-martink@posteo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56A3AA3B.8070704@kernel.org>
Date: Sat, 23 Jan 2016 16:28:43 +0000
MIME-Version: 1.0
In-Reply-To: <1452954922-2266-3-git-send-email-martink@posteo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/01/16 14:35, Martin Kepplinger wrote:
> Signed-off-by: Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Applied.
> ---
>  drivers/iio/accel/mma8452.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 77b71c2..843169e 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -85,8 +85,8 @@
>  #define  MMA8452_INT_FF_MT			BIT(2)
>  #define  MMA8452_INT_TRANS			BIT(5)
>  
> -#define  MMA8452_DEVICE_ID			0x2a
> -#define  MMA8453_DEVICE_ID			0x3a
> +#define MMA8452_DEVICE_ID			0x2a
> +#define MMA8453_DEVICE_ID			0x3a
>  #define MMA8652_DEVICE_ID			0x4a
>  #define MMA8653_DEVICE_ID			0x5a
>  
> 

