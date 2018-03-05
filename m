Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:47710 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752323AbeCEQar (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Mar 2018 11:30:47 -0500
Subject: Re: Work plan to move meter out of staging
To: Daniel Baluta <daniel.baluta@nxp.com>,
        "21cnbao@gmail.com" <21cnbao@gmail.com>,
        "rodrigosiqueiramelo@gmail.com" <rodrigosiqueiramelo@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>
References: <20180305140224.dgh3rcywgxgxsxbx@smtp.gmail.com>
 <1520259685.12790.12.camel@nxp.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <e876642e-0286-9602-884f-00f026d6873f@metafoo.de>
Date: Mon, 5 Mar 2018 17:30:41 +0100
MIME-Version: 1.0
In-Reply-To: <1520259685.12790.12.camel@nxp.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Adding Michael, he coordinates the ADI Linux effort.

On 03/05/2018 03:21 PM, Daniel Baluta wrote:
> 
> On Lu, 2018-03-05 at 11:02 -0300, Rodrigo Siqueira wrote:
>> Hi,
>>
>> Recently, I started to work on IIO subsystem, and I already have sent some
>> patches. Now, I want to move to the next step by working for helping to push
>> the meter module out of staging.
>>
>> In this sense, I am planning to do the following tasks:
>>
>> 1) Make meter checkpatch free
>>
>> I already made some checkpatch cleanups in this module, but it still have some
>> tiny things to fix. I already start to work on this task, and I will send a
>> patch series this week with the checkpatch fixes.
>>
>> 2) Code cleanups
>>
>> I noticed the code has some duplications and utilizes many magic numbers which
>> make difficult to read the code. In order to attempt to improve the code
>> readability, I am planning to work on the following tasks:
>>
>> * Part of the code that I believe that has some duplications that could be
>>   generalized:
>>  - ade7753_spi_write_reg_[0-9]+
>>  - ade7753_read_[0-9]+bit
>>  - ade7753_write_[0-9]+bit
>>  - ade7758_spi_write_reg_[0-9]+
>>  - ade7758_spi_read_reg_[0-9]+
>>  - ade7758_spi_read_[0-9]+bit
>>  - ade7758_spi_write_[0-9]+bit
>>  - ade7759_spi_read_reg_[0-9]+
>>
>> * I believe there is a vast number of macro that could be removed because it is
>>   used one or three times in the whole code. I think the direct use of
>>   IIO_DEVICE_ATTR can be better in these cases. This changes can solve some
>>   checkpatch problems, and improve the readability.
>>
>> * There are some magic numbers that I believe that came from the datasheet. I
>>   think that it is possible to use some defines to improve the readability in
>>   these cases.
>>
>> 3) Missing code
>>
>> These parts look much more fun to work. However, I do not fully understand the
>> IIO subsystem yet, and maybe I say something that does not make sense. So, If I
>> say something that does not make sense, please let me know.
>>
>> So, I believe the meter module still need some pieces of code. For example:
>>
>> * ade7754, ade7759, ade7854 - It does not have iio_chan_spec and
>>         											*_read_raw/*_write_raw
>>
>> * ade7758 - *_read_raw looks incomplete.
>>
>>
>> That's it.
>> Is my work plan to move meter out of staging make sense?
> 
> 
> Hi Rodrigo,
> 
> This looks like a good plan to me. 
> 
> Cc-ing Lars, maybe they have preparing something at Analog regarding this code.
> 
> thanks,
> Daniel.
> 

