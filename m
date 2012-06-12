Return-Path: <jic23@cam.ac.uk>
Message-ID: <4FD73420.3020500@cam.ac.uk>
Date: Tue, 12 Jun 2012 13:20:48 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: iio: vcnl4000 ALS/proximity driver
References: <1339367961-22456-1-git-send-email-pmeerw@pmeerw.net> <4FD635A0.7050507@kernel.org> <alpine.DEB.2.01.1206112328220.30702@pmeerw.net> <3a7abb16-df44-4b5b-9651-d0399659c4af@email.android.com> <4FD6F477.9030506@kernel.org> <alpine.DEB.2.01.1206121022210.23868@pmeerw.net> <4FD7218D.3080506@cam.ac.uk> <alpine.DEB.2.01.1206121406410.23868@pmeerw.net>
In-Reply-To: <alpine.DEB.2.01.1206121406410.23868@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 6/12/2012 1:12 PM, Peter Meerwald wrote:
> Hello Jonathan,
>
>>> /sys/bus/iio/devices/iio:deviceX/out_voltageY&Z_raw
>> err. that's curious. You can't set that...  Goes to show I should review
>> changes to this file more carefully. I just shouted down adding the stuff that
>> would provide that precisely because it made no sense.
>
> I leave that to you
>
>>> in iio.h:
>>>    * @channel:		What number or name do we wish to assign the channel.
>>> what is meant by 'name' here?
>> Oops. Comment has rotted.  Drop the name bit if you fancy doing a patch.
>
> will do
>
>>> * @indexed:		Specify the channel has a numerical index. If not,
>>>    *			the value in channel will be suppressed for attribute
>>>    *			but not for event codes. Typically set it to 0 when
>>>    *			the index is false.
>>> I am not sure what an 'attribute code' is (sysfs name?)
>> attribute name  (which is just a sysfs name as you call it) Again,
>> could do with fixing.
>
> * @indexed:		Specify the channel has a numerical index. If not,
>   *			the channel index number will be suppressed for sysfs
>   *			attributes but not for event codes. Typically set it
>   *			to 0 when the index is 0.
>
>>> I am not sure what 'index is false' means
>> index  == 0; Oops, more good points. Thanks!
>
> or should it be 'Typically set it to 0 when the index is 0 and there is
> just one channel.'?
I'd just drop the typically bit entirely.... It's gibberish as you
pointed out...
>
> regards, p.
>
