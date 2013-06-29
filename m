Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41934 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752366Ab3F2JvM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 29 Jun 2013 05:51:12 -0400
Message-ID: <51CEAE0A.1020800@kernel.org>
Date: Sat, 29 Jun 2013 10:51:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org, Ge Gao <ggao@invensense.com>
Subject: Re: [PATCH 2/5] iio: use I2C_FUNC_SMBUS_I2C_BLOCK macro
References: <1372022900-18670-1-git-send-email-pmeerw@pmeerw.net> <1372022900-18670-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1372022900-18670-2-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/23/2013 10:28 PM, Peter Meerwald wrote:
> I do not see why the driver requires I2C_FUNC_SMBUS_I2C_BLOCK,
> actually only single bytes or words are transferred
Applied as is, but Ge, I would like you to answer Peter's question
about whether this is actually needed at all.

> 
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> Cc: Ge Gao <ggao@invensense.com>
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index fe4c61e..6a1ff80 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -663,8 +663,8 @@ static int inv_mpu_probe(struct i2c_client *client,
>  	int result;
>  
>  	if (!i2c_check_functionality(client->adapter,
> -					I2C_FUNC_SMBUS_READ_I2C_BLOCK |
> -					I2C_FUNC_SMBUS_WRITE_I2C_BLOCK)) {
> +		I2C_FUNC_SMBUS_I2C_BLOCK)) {
> +
>  		result = -ENOSYS;
>  		goto out_no_free;
>  	}
> 
