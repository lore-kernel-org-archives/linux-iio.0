Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47880 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753417AbdCMUJi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Mar 2017 16:09:38 -0400
Subject: Re: [PATCH 2/2] staging: iio: adis16240: Group similar macros into
 enums
To: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>,
        lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org
References: <cover.1488730643.git.narcisaanamaria12@gmail.com>
 <0124358fa11efba9989ed7a7158e5fbcb63df835.1488730643.git.narcisaanamaria12@gmail.com>
Cc: outreachy-kernel@googlegroups.com, linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <cef22e44-1eca-a04a-000f-4f177a4e2ff6@kernel.org>
Date: Mon, 13 Mar 2017 20:09:30 +0000
MIME-Version: 1.0
In-Reply-To: <0124358fa11efba9989ed7a7158e5fbcb63df835.1488730643.git.narcisaanamaria12@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/03/17 16:26, Narcisa Ana Maria Vasile wrote:
> Group the scan indexes into an enum.
> 
> Signed-off-by: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
Applied.

Busy week / weekend so sorry for delay on these!

Jonathan
> ---
>  drivers/staging/iio/accel/adis16240.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16240.c b/drivers/staging/iio/accel/adis16240.c
> index 9690e46..4d8ee37 100644
> --- a/drivers/staging/iio/accel/adis16240.c
> +++ b/drivers/staging/iio/accel/adis16240.c
> @@ -192,12 +192,14 @@
>   * filling. This may change!
>   */
>  
> -#define ADIS16240_SCAN_ACC_X	0
> -#define ADIS16240_SCAN_ACC_Y	1
> -#define ADIS16240_SCAN_ACC_Z	2
> -#define ADIS16240_SCAN_SUPPLY	3
> -#define ADIS16240_SCAN_AUX_ADC	4
> -#define ADIS16240_SCAN_TEMP	5
> +enum adis16240_scan {
> +	ADIS16240_SCAN_ACC_X,
> +	ADIS16240_SCAN_ACC_Y,
> +	ADIS16240_SCAN_ACC_Z,
> +	ADIS16240_SCAN_SUPPLY,
> +	ADIS16240_SCAN_AUX_ADC,
> +	ADIS16240_SCAN_TEMP,
> +};
>  
>  static ssize_t adis16240_spi_read_signed(struct device *dev,
>  					 struct device_attribute *attr,
> 

