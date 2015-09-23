Return-Path: <mwelling79@gmail.com>
Sender: Michael Welling <mwelling79@gmail.com>
Date: Wed, 23 Sep 2015 02:45:14 -0500
From: Michael Welling <mwelling@ieee.org>
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-iio@vger.kernel.org
Subject: Re: ADS1018 ADC driver
Message-ID: <20150923071958.GA30278@deathstar>
References: <20150921220648.GA12569@deathstar>
 <5600A924.1090303@roeck-us.net>
 <20150922012707.GA20799@deathstar>
 <5600B726.2010900@roeck-us.net>
 <2A0E464E-DAA5-4326-8E94-78F17913AD51@ieee.org>
 <131939B9-E3B7-4E98-B0E2-7DF8F2C081BC@jic23.retrosnub.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <131939B9-E3B7-4E98-B0E2-7DF8F2C081BC@jic23.retrosnub.co.uk>
List-ID: <linux-iio@vger.kernel.org>

On Wed, Sep 23, 2015 at 06:59:56AM +0100, Jonathan Cameron wrote:
> There is a rather slow process to separate entirely the back and front end
>  of IIO.  This would get you to what you are describing (with a bit of front end
>  work to set up the mapping to joystick axes).  This was driven initially by the soc
>  guys who have one multichannel ADC doing a dozen unconnected things. Mark Brown in particular.
> 
> Right now all IIO drivers still instantiate the userspace interface (for now users
>  who don't care ignore it). We then had in kernel channel mappings to allow client
>  drivers access to most OHIO hardware interfaces.  The classic example is iio-hwmon
>  though there are other users all over the place. The input bridge (which is too
>  simple to support you joystick example at the mo) has been languishing outside
> Mainline for years due issues with the mapping and instantiation interfaces.
>
 
This is further along than I realized.

Looking at inkern.c and drivers that use the interface should get me started.

I will also look further into the input bridge and uinput.

> Hopefully the addition of config fs support for instantiation of 'virtual'
>  hardware in IIO will finally give us a way around that.
> 
> Anyhow what works now:
> 
> 1. polled channel value and basic property reading (eg iio-hwmon)
>
> 2. Pushed (historically called buffered in IIO) data flows with channel demux (so clients only get a stream of data covering what they requested.  Actually the demux is widely used by the IIO frontend as well.
> 
> What is missing.
> 1. Event support for stuff like thresholds. Not hard to add but not done yet.  Could initially skip demuxing events and specify filtering must be done in the client.
> 
> Interface gets a little fiddly as necessary to lock which events are enabled in some
>  cases to stop another client disabling them as a side effect. Lots of hardware
>  has complex constraints on which events are enabled. Traditionally with only 
> one userspace this was userspace problem to deal with!
> 
> 2. Property range exporting. This is useful for IIO userspace as well.
> 
> 3. Allowing IIO on top of iio.
> 
> 4. Dropping always having IIO userspace.
> 
> Mostly this work has stalled as I have very little time to work on it anymore.
> If you are interested then ask for more details on any of the above.

First I will focus on constructing the new driver for the ADS1018.

Which of these missing pieces would find the most use?

> 
> >
> >>
> >>Guenter
>
