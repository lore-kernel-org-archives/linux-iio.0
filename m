Return-Path: <jic23@cam.ac.uk>
Message-ID: <4FD7218D.3080506@cam.ac.uk>
Date: Tue, 12 Jun 2012 12:01:33 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: iio: vcnl4000 ALS/proximity driver
References: <1339367961-22456-1-git-send-email-pmeerw@pmeerw.net> <4FD635A0.7050507@kernel.org> <alpine.DEB.2.01.1206112328220.30702@pmeerw.net> <3a7abb16-df44-4b5b-9651-d0399659c4af@email.android.com> <4FD6F477.9030506@kernel.org> <alpine.DEB.2.01.1206121022210.23868@pmeerw.net>
In-Reply-To: <alpine.DEB.2.01.1206121022210.23868@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 6/12/2012 10:48 AM, Peter Meerwald wrote:
> Hello,
>
>>>> Am I missing documentation somewhere?
>>>>
>>> Documentation/ABI/testing/sysfs-bus-iio.
>> + drivers/staging/iio/documentation/sysfs-* for other bits and bobs. Mostly it
>> should be fairly obvious how stuff lines up.
>
> well, the last statement should be up to the user of the documentation,
> not the creator ;)
True enough.
>
>>>> some comments in iio/types.h iio/iio.h would avoid guesswork...
>> ah, there were.  That comment is out of date.  This sort of thing is why
>> we try to keep minimal commenting in there unless absolutely necessary.
>
> is the What: line in sysfs-bus-iio supposed to be comprehensive?
Yes.  All sysfs entries should be documented.
If a specific varient of a general element should be in sysfs-bus-iio
If class specific (e.g. only make sense for light sensors) should be
in sysfs-bus-iio-light etc. If device specific (and these take a fair
bit of persuation to be let in) should be in sysfs-bus-iio-light-tsl2563 
etc.
>
> I am worried because concepts are explained redundantly in sysfs-bus-iio
> for particular channel types; one such concept is that a raw
> value can/shall be modified by userspace by offset and scale
Good to clean those up, but they must be documented in those file.  It's
pretty much a kernel rule. Those docs are for writers of userspace code
as well. They shouldn't have to go dig in headers to find this stuff out.
>
> this could be easily (?) done near the iio_chan_info_enum definition in
> iio.h

it would be nice to do it there, but the abi docs are the definitive source.
>
> sysfs-bus-iio documents what you might see in the wild but not how to
> get there
true.
>
>> I suppose we could put a reference to say see the docs files...
>
> I have seen the doc, but I find it hard to deduce the concepts from a
> collection of sysfs file names
>
> it is not clear/obvious how to arrive at
> /sys/.../iio:deviceX/in_capacitanceY-in_capacitanceZ_raw or
Nice complex case...
> /sys/bus/iio/devices/iio:deviceX/out_voltageY&Z_raw
err. that's curious. You can't set that...  Goes to show I should review
changes to this file more carefully. I just shouted down adding the 
stuff that would provide that precisely because it made no sense.
>
> in iio.h:
>   * @channel:		What number or name do we wish to assign the channel.
>
> what is meant by 'name' here?
Oops. Comment has rotted.  Drop the name bit if you fancy doing a patch.
>
> so channel is a numerical identifier that is appended to the channel name
> if indexed is 1?
yes.
>
> * @indexed:		Specify the channel has a numerical index. If not,
>   *			the value in channel will be suppressed for attribute
>   *			but not for event codes. Typically set it to 0 when
>   *			the index is false.
>
> I am not sure what an 'attribute code' is (sysfs name?)
attribute name  (which is just a sysfs name as you call it) Again,
could do with fixing.
> I am not sure what 'index is false' means
index  == 0; Oops, more good points. Thanks!

Given you are doing an excellent job, feel free to send patches.
>
>
> regards, p.
>
