Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46875 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbeKBXG1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 2 Nov 2018 19:06:27 -0400
Received: by mail-qk1-f195.google.com with SMTP id q1so3074673qkf.13
        for <linux-iio@vger.kernel.org>; Fri, 02 Nov 2018 06:59:13 -0700 (PDT)
Subject: Re: [PATCH v2 2/6] staging:iio:ad2s90: Make probe handle spi_setup
 failure
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
References: <20181027020005.3140-1-matheus.bernardino@usp.br>
 <20181027020005.3140-3-matheus.bernardino@usp.br>
 <20181028164329.57162e06@archlinux>
From: Matheus Tavares <matheus.bernardino@usp.br>
Message-ID: <7e9048ff-186f-0ed3-35fc-4e8ffa595c70@usp.br>
Date: Fri, 2 Nov 2018 10:59:06 -0300
MIME-Version: 1.0
In-Reply-To: <20181028164329.57162e06@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


On 10/28/18 1:43 PM, Jonathan Cameron wrote:
> On Fri, 26 Oct 2018 23:00:01 -0300
> Matheus Tavares <matheus.bernardino@usp.br> wrote:
>
>> Previously, ad2s90_probe ignored the return code from spi_setup, not
>> handling its possible failure. This patch makes ad2s90_probe check if
>> the code is an error code and, if so, do the following:
>>
>> - Call dev_err with an appropriate error message.
>> - Return the spi_setup's error code, aborting the execution of the
>> rest of the function.
>>
>> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
>> ---
>>   drivers/staging/iio/resolver/ad2s90.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
>> index 11fac9f90148..d6a42e3f1bd8 100644
>> --- a/drivers/staging/iio/resolver/ad2s90.c
>> +++ b/drivers/staging/iio/resolver/ad2s90.c
>> @@ -88,7 +88,12 @@ static int ad2s90_probe(struct spi_device *spi)
>>   	/* need 600ns between CS and the first falling edge of SCLK */
>>   	spi->max_speed_hz = 830000;
>>   	spi->mode = SPI_MODE_3;
>> -	spi_setup(spi);
>> +	ret = spi_setup(spi);
>> +
>> +	if (ret < 0) {
>> +		dev_err(&spi->dev, "spi_setup failed!\n");
>> +		return ret;
>> +	}
> I would have reordered this first to be before the iio_device_register call.
> The reason being that it would avoid this comment.
>
> Drop the return ret out of the block above and return ret unconditionally.
>
> I don't mind too much as I know this is moving later, but I only know that
> because of the earlier discussion ;)  Few reviewers read the whole patch
> set before responding to the early patches - it's just too much like hard
> work.  So if you can do things in an order that minimizes standard responses
> then that's great.
>
> Patch is fine though - could be solved by a comment in the intro that
> says the code in question will move in patch X.


Ok! As a newcomer I'm not sure about the right way to add this comment. 
Should I add it to the patch message or after the --- ? Also, how do I 
reference patch X? Just giving the number of the patch in this series?

An alternative to adding the comment would be to drop the return ret, 
and reinsert it in the next patch. Dosen't seem so good, to me, but 
would avoid the problem you presented. What would be better?


Matheus.


>
> Jonathan
>>   
>>   	return 0;
>>   }
