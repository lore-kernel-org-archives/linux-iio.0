Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:42387 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755641AbbG1N1x convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jul 2015 09:27:53 -0400
From: "Breana, Tiberiu A" <tiberiu.a.breana@intel.com>
To: Hartmut Knaack <knaack.h@gmx.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: RE: [PATCH 2/7] iio:accel:stk8312: check for invalid value
Date: Tue, 28 Jul 2015 13:27:50 +0000
Message-ID: <4586F61A4A291F4DA44D32824E7C0F4022187E91@IRSMSX109.ger.corp.intel.com>
References: <cover.1437955135.git.knaack.h@gmx.de>
 <f406a1b129207e44ed3c6a07a8d44e16f6f3f74f.1437955135.git.knaack.h@gmx.de>
In-Reply-To: <f406a1b129207e44ed3c6a07a8d44e16f6f3f74f.1437955135.git.knaack.h@gmx.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

> -----Original Message-----
> From: linux-iio-owner@vger.kernel.org [mailto:linux-iio-
> owner@vger.kernel.org] On Behalf Of Hartmut Knaack
> Sent: Tuesday, July 28, 2015 1:49 AM
> To: linux-iio@vger.kernel.org
> Cc: Jonathan Cameron; Lars-Peter Clausen; Peter Meerwald; Breana, Tiberiu
> A
> Subject: [PATCH 2/7] iio:accel:stk8312: check for invalid value
> 
> Revision 1.2 of the datasheet recommends on page 22 to only write non-zero
> values read from OTP register 0x70 into AFECTRL register.
> 
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>

+1

Reviewed-by: Tiberiu Breana <tiberiu.a.breana@intel.com>

> ---
>  drivers/iio/accel/stk8312.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c index
> c2bd1444d6da..6592be8e6377 100644
> --- a/drivers/iio/accel/stk8312.c
> +++ b/drivers/iio/accel/stk8312.c
> @@ -150,6 +150,8 @@ static int stk8312_otp_init(struct stk8312_data *data)
>  		goto exit_err;
> 
>  	ret = i2c_smbus_read_byte_data(client, STK8312_REG_OTPDATA);
> +	if (ret == 0)
> +		ret = -EINVAL;
>  	if (ret < 0)
>  		goto exit_err;
> 
> --
> 2.4.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in the body
> of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
