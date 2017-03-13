Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47861 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751621AbdCMUHF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Mar 2017 16:07:05 -0400
Subject: Re: [PATCH 1/2] staging: iio: adis16209: Group similar macros into
 enums
To: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>,
        lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org
References: <cover.1488730643.git.narcisaanamaria12@gmail.com>
 <50dc46612578fa9cf84d1b8243c86dbf0aace3a4.1488730643.git.narcisaanamaria12@gmail.com>
Cc: outreachy-kernel@googlegroups.com, linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <0fbfe447-8f1f-2f01-b45a-6ace780af12f@kernel.org>
Date: Mon, 13 Mar 2017 20:06:56 +0000
MIME-Version: 1.0
In-Reply-To: <50dc46612578fa9cf84d1b8243c86dbf0aace3a4.1488730643.git.narcisaanamaria12@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/03/17 16:26, Narcisa Ana Maria Vasile wrote:
> Group the scan indexes into an enum.
> 
> Signed-off-by: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/accel/adis16209.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16209.c b/drivers/staging/iio/accel/adis16209.c
> index 8ff537f..c28a099 100644
> --- a/drivers/staging/iio/accel/adis16209.c
> +++ b/drivers/staging/iio/accel/adis16209.c
> @@ -152,14 +152,16 @@
>  
>  #define ADIS16209_ERROR_ACTIVE          BIT(14)
>  
> -#define ADIS16209_SCAN_SUPPLY	0
> -#define ADIS16209_SCAN_ACC_X	1
> -#define ADIS16209_SCAN_ACC_Y	2
> -#define ADIS16209_SCAN_AUX_ADC	3
> -#define ADIS16209_SCAN_TEMP	4
> -#define ADIS16209_SCAN_INCLI_X	5
> -#define ADIS16209_SCAN_INCLI_Y	6
> -#define ADIS16209_SCAN_ROT	7
> +enum adis16209_scan {
> +	ADIS16209_SCAN_SUPPLY,
> +	ADIS16209_SCAN_ACC_X,
> +	ADIS16209_SCAN_ACC_Y,
> +	ADIS16209_SCAN_AUX_ADC,
> +	ADIS16209_SCAN_TEMP,
> +	ADIS16209_SCAN_INCLI_X,
> +	ADIS16209_SCAN_INCLI_Y,
> +	ADIS16209_SCAN_ROT,
> +};
>  
>  static const u8 adis16209_addresses[8][1] = {
>  	[ADIS16209_SCAN_SUPPLY] = { },
> 

