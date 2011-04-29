Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:57647 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753777Ab1D2MHG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 29 Apr 2011 08:07:06 -0400
Message-ID: <4DBAAA72.8030003@cam.ac.uk>
Date: Fri, 29 Apr 2011 13:09:22 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org, drivers@analog.com,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH 3/6] IIO: GYRO: ADXRS450: Add missing parity bit generation
References: <1304074721-18159-1-git-send-email-michael.hennerich@analog.com> <1304074721-18159-3-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1304074721-18159-3-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/29/11 11:58, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> Add missing parity bit generation. Failure to add the parity bit
> caused half of the register accesses to fail.
oops :)
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/gyro/adxrs450_core.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/staging/iio/gyro/adxrs450_core.c b/drivers/staging/iio/gyro/adxrs450_core.c
> index c02e3ef..5671276 100644
> --- a/drivers/staging/iio/gyro/adxrs450_core.c
> +++ b/drivers/staging/iio/gyro/adxrs450_core.c
> @@ -59,6 +59,9 @@ static int adxrs450_spi_read_reg_16(struct device *dev,
>  	st->tx[2] = 0;
>  	st->tx[3] = 0;
>  
> +	if (!(hweight32(be32_to_cpu(*(u32 *)st->tx)) & 1))
> +		st->tx[3]  |= ADXRS450_P;
> +
>  	spi_message_init(&msg);
>  	spi_message_add_tail(&xfers[0], &msg);
>  	spi_message_add_tail(&xfers[1], &msg);
> @@ -103,6 +106,10 @@ static int adxrs450_spi_write_reg_16(struct device *dev,
>  	st->tx[1] = reg_address << 1 | val >> 15;
>  	st->tx[2] = val >> 7;
>  	st->tx[3] = val << 1;
> +
> +	if (!(hweight32(be32_to_cpu(*(u32 *)st->tx)) & 1))
> +		st->tx[3]  |= ADXRS450_P;
> +
>  	spi_message_init(&msg);
>  	spi_message_add_tail(&xfers, &msg);
>  	ret = spi_sync(st->us, &msg);

