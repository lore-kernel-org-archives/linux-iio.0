Return-Path: <jic23@kernel.org>
Message-ID: <4FFF2403.5090809@kernel.org>
Date: Thu, 12 Jul 2012 20:22:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Gerard Snitselaar <dev@snitselaar.org>, linux-kernel@vger.kernel.org,
 linux-next@vger.kernel.org, linux-iio@vger.kernel.org, jic23@cam.ac.uk,
 gregkh@linuxfoundation.org
Subject: Re: [PATCH] iio: dac: ad5064: fix section mismatch in ad5064_init()
 in linux-next
References: <1341979502-27440-1-git-send-email-dev@snitselaar.org> <4FFD23BA.8070502@metafoo.de>
In-Reply-To: <4FFD23BA.8070502@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 07/11/2012 07:56 AM, Lars-Peter Clausen wrote:
> On 07/11/2012 06:05 AM, Gerard Snitselaar wrote:
>> ad5064_init() calls ad5064_spi_unregister_driver() which is annotated
>> __exit.
>>
>> Signed-off-by: Gerard Snitselaar <dev@snitselaar.org>
> 
> Thanks,
> 
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
merged to fixes-togreg and pull request sent.
> 
>> ---
>>  drivers/iio/dac/ad5064.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/dac/ad5064.c b/drivers/iio/dac/ad5064.c
>> index aa739c4..6ec1319 100644
>> --- a/drivers/iio/dac/ad5064.c
>> +++ b/drivers/iio/dac/ad5064.c
>> @@ -582,7 +582,7 @@ static int __init ad5064_spi_register_driver(void)
>>  	return spi_register_driver(&ad5064_spi_driver);
>>  }
>>  
>> -static void __exit ad5064_spi_unregister_driver(void)
>> +static void ad5064_spi_unregister_driver(void)
>>  {
>>  	spi_unregister_driver(&ad5064_spi_driver);
>>  }
> 
