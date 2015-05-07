Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46172 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751638AbbEGXdl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 7 May 2015 19:33:41 -0400
Message-ID: <554B3ABB.7050306@kernel.org>
Date: Thu, 07 May 2015 11:13:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Michael Welling <mwelling@ieee.org>, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, san@rosetechnology.dk,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: mcp320x: Fix occasional incorrect readings
References: <1430930957-14588-1-git-send-email-mwelling@ieee.org>
In-Reply-To: <1430930957-14588-1-git-send-email-mwelling@ieee.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/05/15 17:49, Michael Welling wrote:
> Without the cacheline alignment, the readings will occasionally incorrectly
> return 0.
> 
> Signed-off-by: Michael Welling <mwelling@ieee.org>
Applied to the fixes-togreg branch of iio.git.  Not sure
when I'll be able to push this out publicly as travelling
/ working nights and generally having a silly week.

J
> ---
> 
> v2: Moved buffers to the end of the mcp320x struct per suggestion to keep
> them on their own cacheline.
> 
>  drivers/iio/adc/mcp320x.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
> index efbfd12..8d9c9b9 100644
> --- a/drivers/iio/adc/mcp320x.c
> +++ b/drivers/iio/adc/mcp320x.c
> @@ -60,12 +60,12 @@ struct mcp320x {
>  	struct spi_message msg;
>  	struct spi_transfer transfer[2];
>  
> -	u8 tx_buf;
> -	u8 rx_buf[2];
> -
>  	struct regulator *reg;
>  	struct mutex lock;
>  	const struct mcp320x_chip_info *chip_info;
> +
> +	u8 tx_buf ____cacheline_aligned;
> +	u8 rx_buf[2];
>  };
>  
>  static int mcp320x_channel_to_tx_data(int device_index,
> 

