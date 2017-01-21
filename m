Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34800 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751017AbdAUNMP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Jan 2017 08:12:15 -0500
Subject: Re: [PATCH] iio: health: afe4403: retrieve a valid iio_dev in
 suspend/resume
To: "Andrew F. Davis" <afd@ti.com>,
        Alison Schofield <amsfield22@gmail.com>
References: <20170115035141.GA19547@d830.WORKGROUP>
 <9fc37bb7-0a0c-cf68-51e5-c91d096262d7@ti.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <21e9df05-1918-cb17-d83a-e2c36e70851b@kernel.org>
Date: Sat, 21 Jan 2017 13:12:00 +0000
MIME-Version: 1.0
In-Reply-To: <9fc37bb7-0a0c-cf68-51e5-c91d096262d7@ti.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/01/17 16:38, Andrew F. Davis wrote:
> On 01/14/2017 09:51 PM, Alison Schofield wrote:
>> The suspend/resume functions were using dev_to_iio_dev() to get
>> the iio_dev. That only works on IIO dev's.  Replace it with spi
>> functions to get the correct iio_dev.
>>
>> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
> 
> Was this found with an automated tool? If not, it might be nice to have
> a Coccinelle style check for this. Anyway for this and the afe4404
> version patch:
> 
> Acked-by: Andrew F. Davis <afd@ti.com>
Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan
> 
>> ---
>>  drivers/iio/health/afe4403.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iio/health/afe4403.c b/drivers/iio/health/afe4403.c
>> index 9a08146..6bb23a4 100644
>> --- a/drivers/iio/health/afe4403.c
>> +++ b/drivers/iio/health/afe4403.c
>> @@ -422,7 +422,7 @@ MODULE_DEVICE_TABLE(of, afe4403_of_match);
>>  
>>  static int __maybe_unused afe4403_suspend(struct device *dev)
>>  {
>> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>> +	struct iio_dev *indio_dev = spi_get_drvdata(to_spi_device(dev));
>>  	struct afe4403_data *afe = iio_priv(indio_dev);
>>  	int ret;
>>  
>> @@ -443,7 +443,7 @@ static int __maybe_unused afe4403_suspend(struct device *dev)
>>  
>>  static int __maybe_unused afe4403_resume(struct device *dev)
>>  {
>> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>> +	struct iio_dev *indio_dev = spi_get_drvdata(to_spi_device(dev));
>>  	struct afe4403_data *afe = iio_priv(indio_dev);
>>  	int ret;
>>  
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

