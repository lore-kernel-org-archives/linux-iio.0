Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55795 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750751AbbAAMTT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 1 Jan 2015 07:19:19 -0500
Message-ID: <54A53B45.7080007@kernel.org>
Date: Thu, 01 Jan 2015 12:19:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	linux-iio@vger.kernel.org
CC: octavian.purdila@intel.com, daniel.baluta@intel.com,
	lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
	pmeerw@pmeerw.net
Subject: Re: [PATCH v2] iio: frequency: ad9523: Increase sleep time in ad9523_store_eeprom
References: <1419965074-3929-1-git-send-email-roberta.dobrescu@gmail.com>
In-Reply-To: <1419965074-3929-1-git-send-email-roberta.dobrescu@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 30/12/14 18:44, Roberta Dobrescu wrote:
> This patch increases sleep time in ad9523_store_eeprom to 20ms since
> it isn't timing critical. It fixes the following checkpatch.pl warning:
> WARNING: msleep < 20ms can sleep for up to 20ms
> 
> Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
Applied to the togreg branch of iio.git - initially pushed out as testing
for the autobuilders to play.
> ---
> Changes since v1:
> 	* Increase sleep time in msleep instead of using usleep_range
> 	* Change subject and commit message accordingly
> 
>  drivers/iio/frequency/ad9523.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.c
> index 7c5245d..50ed8d1 100644
> --- a/drivers/iio/frequency/ad9523.c
> +++ b/drivers/iio/frequency/ad9523.c
> @@ -445,7 +445,7 @@ static int ad9523_store_eeprom(struct iio_dev *indio_dev)
>  
>  	tmp = 4;
>  	do {
> -		msleep(16);
> +		msleep(20);
>  		ret = ad9523_read(indio_dev,
>  				  AD9523_EEPROM_DATA_XFER_STATUS);
>  		if (ret < 0)
> 

