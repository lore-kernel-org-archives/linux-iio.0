Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:60395 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751316Ab3GaGy4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 31 Jul 2013 02:54:56 -0400
Message-ID: <51F8B4BE.8000308@metafoo.de>
Date: Wed, 31 Jul 2013 08:54:54 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Otavio Salvador <otavio@ossystems.com.br>
CC: Mario Domenech Goulart <mario@ossystems.com.br>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: RFC: driver for TI ADS124x ADC series
References: <877ggd2fkl.fsf@parenteses.org> <CAP9ODKqt35M833c990JhGeYvQJgK77_my01qdFwahF4xF-iEQw@mail.gmail.com>
In-Reply-To: <CAP9ODKqt35M833c990JhGeYvQJgK77_my01qdFwahF4xF-iEQw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/31/2013 12:46 AM, Otavio Salvador wrote:
> On Fri, Jul 26, 2013 at 6:10 PM, Mario Domenech Goulart
> <mario@ossystems.com.br> wrote:
>> Hi,
>>
>> We are working on a driver for TI ADS124x ADC series (ADS1246,
>> ADS1247 and ADS1248.  Datasheet: http://www.ti.com/litv/pdf/sbas426g)
>>
>> The attached patch is what we have so far.  It is by no means
>> finished.  We are actually submitting it in the hope you can
>> review it and provide feedback.
>>
>> Some observations and questions in advance:
>>
>> * we've set the chip to only convert on-demand.  I.e., it is not
>>    constantly converting.  Conversions are only performed when
>>    requested via sysfs.  We are not sure about the best approach
>>    with regard to that behavior.  Should it be constantly
>>    converting?
>>
>> * we've set the device as IIO_TEMP, although what is currently
>>    exposed in sysfs is voltage. The chip is targeted to
>>    temperature sensors, but the actual output of the ADC is
>>    voltage, so we don't know exactly what to use as type.
>>
>> * we are aware of some ugly hacks like wait_for_drdy. :-) What's
>>    the best approach to wait for the data ready signal?
>>
>> * in fact we've been mostly working with ADS1247 and haven't
>>    concentrated on supporting ADS1246 and ADS1248 for now, but we
>>    intend to do so.
>
> Could someone give us some feedback on this?
>
> We are really looking for some initial review on this patch so we can
> clean it up and do the need changes to send it for official review
> later.
>

Can you send the patch inline instead of as an attachment?

- Lars

