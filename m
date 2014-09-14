Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55617 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752707AbaINRVz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 14 Sep 2014 13:21:55 -0400
Message-ID: <5415CEB0.8070105@kernel.org>
Date: Sun, 14 Sep 2014 18:21:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Denis CIOCCA <denis.ciocca@st.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio:magnetometer: bugfix magnetometers gain values
References: <1410353737-17542-1-git-send-email-denis.ciocca@st.com>
In-Reply-To: <1410353737-17542-1-git-send-email-denis.ciocca@st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/09/14 13:55, Denis CIOCCA wrote:
> This patch fix gains values. The first driver was designed using
> engineering samples, in mass production the values are changed.
> 
> Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan
> ---
>  drivers/iio/magnetometer/st_magn_core.c | 52 +++++++++++++++++++--------------
>  1 file changed, 30 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
> index a4b6413..68cae86 100644
> --- a/drivers/iio/magnetometer/st_magn_core.c
> +++ b/drivers/iio/magnetometer/st_magn_core.c
> @@ -42,7 +42,8 @@
>  #define ST_MAGN_FS_AVL_5600MG			5600
>  #define ST_MAGN_FS_AVL_8000MG			8000
>  #define ST_MAGN_FS_AVL_8100MG			8100
> -#define ST_MAGN_FS_AVL_10000MG			10000
> +#define ST_MAGN_FS_AVL_12000MG			12000
> +#define ST_MAGN_FS_AVL_16000MG			16000
>  
>  /* CUSTOM VALUES FOR SENSOR 1 */
>  #define ST_MAGN_1_WAI_EXP			0x3c
> @@ -69,20 +70,20 @@
>  #define ST_MAGN_1_FS_AVL_4700_VAL		0x05
>  #define ST_MAGN_1_FS_AVL_5600_VAL		0x06
>  #define ST_MAGN_1_FS_AVL_8100_VAL		0x07
> -#define ST_MAGN_1_FS_AVL_1300_GAIN_XY		1100
> -#define ST_MAGN_1_FS_AVL_1900_GAIN_XY		855
> -#define ST_MAGN_1_FS_AVL_2500_GAIN_XY		670
> -#define ST_MAGN_1_FS_AVL_4000_GAIN_XY		450
> -#define ST_MAGN_1_FS_AVL_4700_GAIN_XY		400
> -#define ST_MAGN_1_FS_AVL_5600_GAIN_XY		330
> -#define ST_MAGN_1_FS_AVL_8100_GAIN_XY		230
> -#define ST_MAGN_1_FS_AVL_1300_GAIN_Z		980
> -#define ST_MAGN_1_FS_AVL_1900_GAIN_Z		760
> -#define ST_MAGN_1_FS_AVL_2500_GAIN_Z		600
> -#define ST_MAGN_1_FS_AVL_4000_GAIN_Z		400
> -#define ST_MAGN_1_FS_AVL_4700_GAIN_Z		355
> -#define ST_MAGN_1_FS_AVL_5600_GAIN_Z		295
> -#define ST_MAGN_1_FS_AVL_8100_GAIN_Z		205
> +#define ST_MAGN_1_FS_AVL_1300_GAIN_XY		909
> +#define ST_MAGN_1_FS_AVL_1900_GAIN_XY		1169
> +#define ST_MAGN_1_FS_AVL_2500_GAIN_XY		1492
> +#define ST_MAGN_1_FS_AVL_4000_GAIN_XY		2222
> +#define ST_MAGN_1_FS_AVL_4700_GAIN_XY		2500
> +#define ST_MAGN_1_FS_AVL_5600_GAIN_XY		3030
> +#define ST_MAGN_1_FS_AVL_8100_GAIN_XY		4347
> +#define ST_MAGN_1_FS_AVL_1300_GAIN_Z		1020
> +#define ST_MAGN_1_FS_AVL_1900_GAIN_Z		1315
> +#define ST_MAGN_1_FS_AVL_2500_GAIN_Z		1666
> +#define ST_MAGN_1_FS_AVL_4000_GAIN_Z		2500
> +#define ST_MAGN_1_FS_AVL_4700_GAIN_Z		2816
> +#define ST_MAGN_1_FS_AVL_5600_GAIN_Z		3389
> +#define ST_MAGN_1_FS_AVL_8100_GAIN_Z		4878
>  #define ST_MAGN_1_MULTIREAD_BIT			false
>  
>  /* CUSTOM VALUES FOR SENSOR 2 */
> @@ -105,10 +106,12 @@
>  #define ST_MAGN_2_FS_MASK			0x60
>  #define ST_MAGN_2_FS_AVL_4000_VAL		0x00
>  #define ST_MAGN_2_FS_AVL_8000_VAL		0x01
> -#define ST_MAGN_2_FS_AVL_10000_VAL		0x02
> -#define ST_MAGN_2_FS_AVL_4000_GAIN		430
> -#define ST_MAGN_2_FS_AVL_8000_GAIN		230
> -#define ST_MAGN_2_FS_AVL_10000_GAIN		230
> +#define ST_MAGN_2_FS_AVL_12000_VAL		0x02
> +#define ST_MAGN_2_FS_AVL_16000_VAL		0x03
> +#define ST_MAGN_2_FS_AVL_4000_GAIN		146
> +#define ST_MAGN_2_FS_AVL_8000_GAIN		292
> +#define ST_MAGN_2_FS_AVL_12000_GAIN		438
> +#define ST_MAGN_2_FS_AVL_16000_GAIN		584
>  #define ST_MAGN_2_MULTIREAD_BIT			false
>  #define ST_MAGN_2_OUT_X_L_ADDR			0x28
>  #define ST_MAGN_2_OUT_Y_L_ADDR			0x2a
> @@ -266,9 +269,14 @@ static const struct st_sensors st_magn_sensors[] = {
>  					.gain = ST_MAGN_2_FS_AVL_8000_GAIN,
>  				},
>  				[2] = {
> -					.num = ST_MAGN_FS_AVL_10000MG,
> -					.value = ST_MAGN_2_FS_AVL_10000_VAL,
> -					.gain = ST_MAGN_2_FS_AVL_10000_GAIN,
> +					.num = ST_MAGN_FS_AVL_12000MG,
> +					.value = ST_MAGN_2_FS_AVL_12000_VAL,
> +					.gain = ST_MAGN_2_FS_AVL_12000_GAIN,
> +				},
> +				[3] = {
> +					.num = ST_MAGN_FS_AVL_16000MG,
> +					.value = ST_MAGN_2_FS_AVL_16000_VAL,
> +					.gain = ST_MAGN_2_FS_AVL_16000_GAIN,
>  				},
>  			},
>  		},
> 
