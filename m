Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52264 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751927AbcFKQZc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 11 Jun 2016 12:25:32 -0400
Subject: Re: [PATCH 2/3] iio: mma8452: update device description in header
 comments
To: Martin Kepplinger <martink@posteo.de>
References: <1464958312-2720-1-git-send-email-martink@posteo.de>
 <1464958312-2720-2-git-send-email-martink@posteo.de>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <ebd14ff7-99c3-be1f-9876-57afa521758a@kernel.org>
Date: Sat, 11 Jun 2016 17:25:30 +0100
MIME-Version: 1.0
In-Reply-To: <1464958312-2720-2-git-send-email-martink@posteo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/06/16 13:51, Martin Kepplinger wrote:
> Signed-off-by: Martin Kepplinger <martink@posteo.de>
Applied.
> ---
>  drivers/iio/accel/mma8452.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 9e679af..4be2a18 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -1,12 +1,14 @@
>  /*
>   * mma8452.c - Support for following Freescale 3-axis accelerometers:
>   *
> - * MMA8451Q (14 bit)
> - * MMA8452Q (12 bit)
> - * MMA8453Q (10 bit)
> - * MMA8652FC (12 bit)
> - * MMA8653FC (10 bit)
> - * FXLS8471Q (14 bit)
> + * device name	digital output	7-bit I2C slave address (pin selectable)
> + * ---------------------------------------------------------------------
> + * MMA8451Q	14 bit		0x1c / 0x1d
> + * MMA8452Q	12 bit		0x1c / 0x1d
> + * MMA8453Q	10 bit		0x1c / 0x1d
> + * MMA8652FC	12 bit		0x1d
> + * MMA8653FC	10 bit		0x1d
> + * FXLS8471Q	14 bit		0x1e / 0x1d / 0x1c / 0x1f
>   *
>   * Copyright 2015 Martin Kepplinger <martink@posteo.de>
>   * Copyright 2014 Peter Meerwald <pmeerw@pmeerw.net>
> @@ -15,8 +17,6 @@
>   * the GNU General Public License.  See the file COPYING in the main
>   * directory of this archive for more details.
>   *
> - * 7-bit I2C slave address 0x1c/0x1d (pin selectable)
> - *
>   * TODO: orientation events
>   */
>  
> 

