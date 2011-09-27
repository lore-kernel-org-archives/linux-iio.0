Return-Path: <maxime.ripard@free-electrons.com>
Message-ID: <4E81F2EE.4010402@free-electrons.com>
Date: Tue, 27 Sep 2011 17:59:42 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: linux-iio@vger.kernel.org,
 "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: Re: Questions about IIO drivers
References: <4E81D71C.3050805@free-electrons.com> <4E81DD94.6020406@cam.ac.uk>
In-Reply-To: <4E81DD94.6020406@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,

On 27/09/2011 16:28, Jonathan Cameron wrote:
>> I'm currently writing a driver for the ADCs present in Atmel AT91 SoC
>> using iio. I will of course submit it once it is ready.
>>
>> For now, I have the basic integration into iio, and I am beginning to
>> integrate the hardware logic in it. However, this integration raises few
>> questions, and I didn't found any answers to it. (The dummy driver is of
>> great help btw)
> cool.  Any feedback on that particularly welcome given we haven't merged
> it yet.

Well, it addresses the beginner questions quite well in my opinion,
apart from triggers maybe. Adding triggers could maybe be a good idea.

>>   - While the registers are all the same on the AT91 platform for the
>> ADCs, the number of channels available is not the same from one board to
>> another. For now, I'm declaring the number of channels available through
>> the board definition and platform_data, and I'm declaring the channels
>> to iio using :
>>
>> 	idev->channels = kzalloc(sizeof(struct iio_chan_spec) * nb_chan,
>> 				 GFP_KERNEL);
>> 	for(i = 0; i < nb_chan; i++) {
>> 		struct iio_chan_spec *chan = idev->channels + i;
>> 		chan->type = IIO_IN;
>> 		chan->indexed = 1;
>> 		chan->channel = i;
>> 	}
>>
>> While it seems to work nicely, it generates a warning, as iio_dev's
>> channels field is declared const. Is there a better solution ?
> 
> As an aside
> IIO_IN -> IIO_VOLTAGE. I've push a patch to GregKH today that scraps
> IIO_IN once and for all.
> 
> Are you using the latest published tree (currently on github)?

Yep, I've seen that, but I've branched from 3.1-rc6. I've rebased on top
of your github tree.

> There's at least one driver that does the same in tree and it doesn't
> give a warning (there were some core changes to avoid it).  ad7280a.
> 
> The other option is to have a single array of all channels and set
> num_channels lower than the size of the array. Couple of drivers
> do that for some of the parts they support.

Ok, thanks, I'll check this out.

>>   - For now, I don't really want to rely on hardware triggers, but
>> instead use only software triggers. I've taken a look to sysfs triggers,
>> and while the module for sysfs trigger is compiled and loaded, and added
>> to the platform_devices of the board, the file trigger_now is nowhere to
>> be found. I guess that I need to declare triggers in my driver, but I
>> have found no clue on how to do that. How can we achieve it ?
> Hmm.. clearly need some documentation for that driver.
> 
> What you should have is a directory called:
> /sys/bus/iio/devices/iio_sysfs_trigger (it's a rather 'unusual device').
> 
> In there are the userspace controls for creating and destroying sysfs
> triggers.
> 
> echo N to > add_trigger and you should find it has created a trigger
> called sysfstrigN the controls for which (including the trigger_now) file
> can be found in /sys/bus/iio/devices/triggerY (where Y is id of the
> trigger - counting from 0).

Ok, now I see the trigger_now file :)

But I guess that the driver still have to register this trigger, right ?

Thanks,

-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
