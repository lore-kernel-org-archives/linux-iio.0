Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56232 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932811AbbLSQp2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 19 Dec 2015 11:45:28 -0500
Subject: Re: [PATCH 1/3] iio: mma8452: remove unused register description
To: Martin Kepplinger <martink@posteo.de>, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net,
	christoph.muellner@theobroma-systems.com, mfuzzey@parkeon.com
References: <1450197901-9826-1-git-send-email-martink@posteo.de>
 <1450197901-9826-2-git-send-email-martink@posteo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <567589A6.3060005@kernel.org>
Date: Sat, 19 Dec 2015 16:45:26 +0000
MIME-Version: 1.0
In-Reply-To: <1450197901-9826-2-git-send-email-martink@posteo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/12/15 16:44, Martin Kepplinger wrote:
> Signed-off-by: Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Applied to the togreg branch of iio.git - initially pushed out as testing for the
autobuilders to play with it.

J
> ---
>  drivers/iio/accel/mma8452.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 116a6e4..162bbef 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -58,7 +58,6 @@
>  #define MMA8452_FF_MT_COUNT			0x18
>  #define MMA8452_TRANSIENT_CFG			0x1d
>  #define  MMA8452_TRANSIENT_CFG_HPF_BYP		BIT(0)
> -#define  MMA8452_TRANSIENT_CFG_CHAN(chan)	BIT(chan + 1)
>  #define  MMA8452_TRANSIENT_CFG_ELE		BIT(4)
>  #define MMA8452_TRANSIENT_SRC			0x1e
>  #define  MMA8452_TRANSIENT_SRC_XTRANSE		BIT(1)
> 

