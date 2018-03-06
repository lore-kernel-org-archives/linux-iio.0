Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-by2nam03on0080.outbound.protection.outlook.com ([104.47.42.80]:19632
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753401AbeCFLuo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 6 Mar 2018 06:50:44 -0500
Reply-To: <michael.hennerich@analog.com>
Subject: Re: Work plan to move meter out of staging
To: Lars-Peter Clausen <lars@metafoo.de>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "21cnbao@gmail.com" <21cnbao@gmail.com>,
        "rodrigosiqueiramelo@gmail.com" <rodrigosiqueiramelo@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <20180305140224.dgh3rcywgxgxsxbx@smtp.gmail.com>
 <1520259685.12790.12.camel@nxp.com>
 <e876642e-0286-9602-884f-00f026d6873f@metafoo.de>
From: Michael Hennerich <michael.hennerich@analog.com>
Message-ID: <f8f972b2-837d-b242-6fa3-40bf21952b0b@analog.com>
Date: Tue, 6 Mar 2018 12:53:47 +0100
MIME-Version: 1.0
In-Reply-To: <e876642e-0286-9602-884f-00f026d6873f@metafoo.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05.03.2018 17:30, Lars-Peter Clausen wrote:
> Adding Michael, he coordinates the ADI Linux effort.
> 
> On 03/05/2018 03:21 PM, Daniel Baluta wrote:
>>
>> On Lu, 2018-03-05 at 11:02 -0300, Rodrigo Siqueira wrote:
>>> Hi,
>>>
>>> Recently, I started to work on IIO subsystem, and I already have sent some
>>> patches. Now, I want to move to the next step by working for helping to push
>>> the meter module out of staging.
>>>
>>> In this sense, I am planning to do the following tasks:
>>>
>>> 1) Make meter checkpatch free
>>>
>>> I already made some checkpatch cleanups in this module, but it still have some
>>> tiny things to fix. I already start to work on this task, and I will send a
>>> patch series this week with the checkpatch fixes.
>>>
>>> 2) Code cleanups
>>>
>>> I noticed the code has some duplications and utilizes many magic numbers which
>>> make difficult to read the code. In order to attempt to improve the code
>>> readability, I am planning to work on the following tasks:
>>>
>>> * Part of the code that I believe that has some duplications that could be
>>>    generalized:
>>>   - ade7753_spi_write_reg_[0-9]+
>>>   - ade7753_read_[0-9]+bit
>>>   - ade7753_write_[0-9]+bit
>>>   - ade7758_spi_write_reg_[0-9]+
>>>   - ade7758_spi_read_reg_[0-9]+
>>>   - ade7758_spi_read_[0-9]+bit
>>>   - ade7758_spi_write_[0-9]+bit
>>>   - ade7759_spi_read_reg_[0-9]+
>>>
>>> * I believe there is a vast number of macro that could be removed because it is
>>>    used one or three times in the whole code. I think the direct use of
>>>    IIO_DEVICE_ATTR can be better in these cases. This changes can solve some
>>>    checkpatch problems, and improve the readability.
>>>
>>> * There are some magic numbers that I believe that came from the datasheet. I
>>>    think that it is possible to use some defines to improve the readability in
>>>    these cases.
>>>
>>> 3) Missing code
>>>
>>> These parts look much more fun to work. However, I do not fully understand the
>>> IIO subsystem yet, and maybe I say something that does not make sense. So, If I
>>> say something that does not make sense, please let me know.
>>>
>>> So, I believe the meter module still need some pieces of code. For example:
>>>
>>> * ade7754, ade7759, ade7854 - It does not have iio_chan_spec and
>>>          											*_read_raw/*_write_raw
>>>
>>> * ade7758 - *_read_raw looks incomplete.
>>>
>>>
>>> That's it.
>>> Is my work plan to move meter out of staging make sense?
>>
>>
>> Hi Rodrigo,
>>
>> This looks like a good plan to me.
>>
>> Cc-ing Lars, maybe they have preparing something at Analog regarding this code.
>>
>> thanks,
>> Daniel.

In general I think this is a great idea, however looking at it from a 
different angle -
Most of the supported metering circuits are already marked as not 
recommended for new designs.
While Analog Devices have a very strong product portfolio in the 
Metering IC space, all of the parts in
staging/iio/meter are from 2011 and before and have already seen 
multiple product iterations since then.
A major rework of these drivers might require testing, unfortunately 
these drivers were developed by a different team which now pursues 
different responsibilities.
So I won’t be able to test them again, and therefore I’m also a bit 
hesitant to lift them out of staging.


-- 
Greetings,
Michael

--
Analog Devices GmbH      Otl-Aicher Strasse 60-64      80807 München
Sitz der Gesellschaft München, Registergericht München HRB 40368,
Geschäftsführer: Peter Kolberg, Ali Raza Husain, Eileen Wynne
