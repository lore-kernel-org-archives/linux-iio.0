Return-Path: <pmeerw@pmeerw.net>
Date: Tue, 12 Jun 2012 11:48:14 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
cc: linux-iio@vger.kernel.org
Subject: Re: iio: vcnl4000 ALS/proximity driver
In-Reply-To: <4FD6F477.9030506@kernel.org>
Message-ID: <alpine.DEB.2.01.1206121022210.23868@pmeerw.net>
References: <1339367961-22456-1-git-send-email-pmeerw@pmeerw.net> <4FD635A0.7050507@kernel.org> <alpine.DEB.2.01.1206112328220.30702@pmeerw.net> <3a7abb16-df44-4b5b-9651-d0399659c4af@email.android.com> <4FD6F477.9030506@kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

Hello,

> > > Am I missing documentation somewhere?
> > > 
> > Documentation/ABI/testing/sysfs-bus-iio.
> + drivers/staging/iio/documentation/sysfs-* for other bits and bobs. Mostly it
> should be fairly obvious how stuff lines up.

well, the last statement should be up to the user of the documentation, 
not the creator ;)

> > > some comments in iio/types.h iio/iio.h would avoid guesswork...
> ah, there were.  That comment is out of date.  This sort of thing is why
> we try to keep minimal commenting in there unless absolutely necessary.

is the What: line in sysfs-bus-iio supposed to be comprehensive?

I am worried because concepts are explained redundantly in sysfs-bus-iio 
for particular channel types; one such concept is that a raw 
value can/shall be modified by userspace by offset and scale

this could be easily (?) done near the iio_chan_info_enum definition in 
iio.h

sysfs-bus-iio documents what you might see in the wild but not how to 
get there

> I suppose we could put a reference to say see the docs files...

I have seen the doc, but I find it hard to deduce the concepts from a 
collection of sysfs file names

it is not clear/obvious how to arrive at 
/sys/.../iio:deviceX/in_capacitanceY-in_capacitanceZ_raw or
/sys/bus/iio/devices/iio:deviceX/out_voltageY&Z_raw

in iio.h:
 * @channel:		What number or name do we wish to assign the channel.

what is meant by 'name' here? 

so channel is a numerical identifier that is appended to the channel name 
if indexed is 1?

* @indexed:		Specify the channel has a numerical index. If not,
 *			the value in channel will be suppressed for attribute
 *			but not for event codes. Typically set it to 0 when
 *			the index is false.

I am not sure what an 'attribute code' is (sysfs name?)
I am not sure what 'index is false' means


regards, p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
