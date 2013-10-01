Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52597 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752447Ab3JAIzA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 1 Oct 2013 04:55:00 -0400
Message-ID: <524A9C0F.4010609@kernel.org>
Date: Tue, 01 Oct 2013 10:55:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 04/15] staging:iio:hmc5843: Remove unused LSB register
 #defines
References: <1379619360-8150-1-git-send-email-pmeerw@pmeerw.net> <1379619360-8150-5-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1379619360-8150-5-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/19/13 20:35, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Applied, thanks.
> ---
>  drivers/staging/iio/magnetometer/hmc5843.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
> index faeb115..d953107 100644
> --- a/drivers/staging/iio/magnetometer/hmc5843.c
> +++ b/drivers/staging/iio/magnetometer/hmc5843.c
> @@ -29,16 +29,11 @@
>  #define HMC5843_CONFIG_REG_B			0x01
>  #define HMC5843_MODE_REG			0x02
>  #define HMC5843_DATA_OUT_X_MSB_REG		0x03
> -#define HMC5843_DATA_OUT_X_LSB_REG		0x04
>  #define HMC5843_DATA_OUT_Y_MSB_REG		0x05
> -#define HMC5843_DATA_OUT_Y_LSB_REG		0x06
>  #define HMC5843_DATA_OUT_Z_MSB_REG		0x07
> -#define HMC5843_DATA_OUT_Z_LSB_REG		0x08
>  /* Beware: Y and Z are exchanged on HMC5883 */
>  #define HMC5883_DATA_OUT_Z_MSB_REG		0x05
> -#define HMC5883_DATA_OUT_Z_LSB_REG		0x06
>  #define HMC5883_DATA_OUT_Y_MSB_REG		0x07
> -#define HMC5883_DATA_OUT_Y_LSB_REG		0x08
>  #define HMC5843_STATUS_REG			0x09
>  
>  enum hmc5843_ids {
> @@ -61,8 +56,6 @@ enum hmc5843_ids {
>   */
>  #define HMC5843_DATA_READY			0x01
>  #define HMC5843_DATA_OUTPUT_LOCK		0x02
> -/* Does not exist on HMC5883, not used */
> -#define HMC5843_VOLTAGE_REGULATOR_ENABLED	0x04
>  
>  /*
>   * Mode register configuration
> 
