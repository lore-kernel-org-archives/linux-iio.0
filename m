Return-Path: <lars@metafoo.de>
Message-ID: <5492FC53.5000100@metafoo.de>
Date: Thu, 18 Dec 2014 17:09:55 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Roberta Dobrescu <roberta.dobrescu@gmail.com>, jic23@kernel.org,
 linux-iio@vger.kernel.org
CC: octavian.purdila@intel.com, daniel.baluta@intel.com,
 Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net
Subject: Re: [PATCH 3/3] iio: frequency: Use usleep_range instead of msleep
References: <1418721107-5429-1-git-send-email-roberta.dobrescu@gmail.com> <1418721107-5429-4-git-send-email-roberta.dobrescu@gmail.com>
In-Reply-To: <1418721107-5429-4-git-send-email-roberta.dobrescu@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 12/16/2014 10:11 AM, Roberta Dobrescu wrote:
> This patch fixes the following checkpatch.pl warning:
> WARNING: msleep < 20ms can sleep for up to 20ms
>
> Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
> ---
>   drivers/iio/frequency/ad9523.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.c
> index 7c5245d..2e41ca5 100644
> --- a/drivers/iio/frequency/ad9523.c
> +++ b/drivers/iio/frequency/ad9523.c
> @@ -445,7 +445,7 @@ static int ad9523_store_eeprom(struct iio_dev *indio_dev)
>
>   	tmp = 4;
>   	do {
> -		msleep(16);
> +		usleep_range(16000, 17000);

I don't think this is exactly timing critical, things will work fine if this 
sleeps a bit longer. If you want to silence the warning for the sake of 
silencing the warning, maybe just replace it with a msleep(20).

>   		ret = ad9523_read(indio_dev,
>   				  AD9523_EEPROM_DATA_XFER_STATUS);
>   		if (ret < 0)
>
