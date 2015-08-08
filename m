Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57945 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754097AbbHHLYU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 8 Aug 2015 07:24:20 -0400
Subject: Re: [PATCH v2 6/7] iio:accel:stk8312: code style cleanup
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
References: <cover.1438204273.git.knaack.h@gmx.de>
 <8fe5c22241a358293759f8e25e9773999cbb362f.1438204273.git.knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Tiberiu Breana <tiberiu.a.breana@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55C5E6E2.5070101@kernel.org>
Date: Sat, 8 Aug 2015 12:24:18 +0100
MIME-Version: 1.0
In-Reply-To: <8fe5c22241a358293759f8e25e9773999cbb362f.1438204273.git.knaack.h@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/07/15 22:39, Hartmut Knaack wrote:
> Adjust some indentation issues to make checkpatch.pl happy in strict mode.
> 
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
Applied.
> ---
>  drivers/iio/accel/stk8312.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c
> index 8b9b3815aac2..39eb9f4ea5c0 100644
> --- a/drivers/iio/accel/stk8312.c
> +++ b/drivers/iio/accel/stk8312.c
> @@ -157,8 +157,7 @@ static int stk8312_otp_init(struct stk8312_data *data)
>  	if (ret < 0)
>  		goto exit_err;
>  
> -	ret = i2c_smbus_write_byte_data(data->client,
> -			STK8312_REG_AFECTRL, ret);
> +	ret = i2c_smbus_write_byte_data(data->client, STK8312_REG_AFECTRL, ret);
>  	if (ret < 0)
>  		goto exit_err;
>  	msleep(150);
> @@ -458,7 +457,7 @@ static irqreturn_t stk8312_trigger_handler(int irq, void *p)
>  		data->buffer[2] = buffer[2];
>  	} else {
>  		for_each_set_bit(bit, indio_dev->active_scan_mask,
> -			   indio_dev->masklength) {
> +				 indio_dev->masklength) {
>  			ret = stk8312_read_accel(data, bit);
>  			if (ret < 0) {
>  				mutex_unlock(&data->lock);
> 

