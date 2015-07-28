Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:6709 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932320AbbG1Nvx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jul 2015 09:51:53 -0400
From: "Breana, Tiberiu A" <tiberiu.a.breana@intel.com>
To: Hartmut Knaack <knaack.h@gmx.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: RE: [PATCH 6/7] iio:accel:stk8312: code style cleanup
Date: Tue, 28 Jul 2015 13:45:00 +0000
Message-ID: <4586F61A4A291F4DA44D32824E7C0F4022187F18@IRSMSX109.ger.corp.intel.com>
References: <cover.1437955135.git.knaack.h@gmx.de>
 <e385d57dcb753a56fdee5be5ddb4fb963f502b9c.1437955135.git.knaack.h@gmx.de>
In-Reply-To: <e385d57dcb753a56fdee5be5ddb4fb963f502b9c.1437955135.git.knaack.h@gmx.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

> -----Original Message-----
> From: Hartmut Knaack [mailto:knaack.h@gmx.de]
> Sent: Tuesday, July 28, 2015 1:49 AM
> To: linux-iio@vger.kernel.org
> Cc: Jonathan Cameron; Lars-Peter Clausen; Peter Meerwald; Breana, Tiberiu
> A
> Subject: [PATCH 6/7] iio:accel:stk8312: code style cleanup
> 
> Adjust some indentation issues to make checkpatch.pl happy in strict mode.
> 
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>

Comment inline.

> ---
>  drivers/iio/accel/stk8312.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c index
> e3624e2b3ec4..b059a6cabfbb 100644
> --- a/drivers/iio/accel/stk8312.c
> +++ b/drivers/iio/accel/stk8312.c
> @@ -157,8 +157,7 @@ static int stk8312_otp_init(struct stk8312_data *data)
>  	if (ret < 0)
>  		goto exit_err;
> 
> -	ret = i2c_smbus_write_byte_data(data->client,
> -			STK8312_REG_AFECTRL, ret);
> +	ret = i2c_smbus_write_byte_data(data->client,
> STK8312_REG_AFECTRL,
> +ret);

On a single line, this write op would take up 81 chars.
I think it's best to just add 2 tabs to the 2nd line.

>  	if (ret < 0)
>  		goto exit_err;
>  	msleep(150);
> @@ -453,7 +452,7 @@ static irqreturn_t stk8312_trigger_handler(int irq, void
> *p)
>  		data->buffer[2] = buffer[2];
>  	} else {
>  		for_each_set_bit(bit, indio_dev->active_scan_mask,
> -			   indio_dev->masklength) {
> +				 indio_dev->masklength) {
>  			ret = stk8312_read_accel(data, bit);
>  			if (ret < 0) {
>  				mutex_unlock(&data->lock);
> --
> 2.4.6

