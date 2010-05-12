Return-Path: <21cnbao@gmail.com>
MIME-Version: 1.0
In-Reply-To: <4BE994F4.4030608@cam.ac.uk>
References: <AANLkTinVNqGBQqVaitQHwxmh_EVzkNhLNpl1Fzyc0eTC@mail.gmail.com>
	<4BE93FF2.9020605@cam.ac.uk> <AANLkTikhQp8XjgfDfdK_TZwmDjRuFq6QUp0yVX5S4w1O@mail.gmail.com>
	<4BE994F4.4030608@cam.ac.uk>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 12 May 2010 21:41:23 +0800
Message-ID: <AANLkTiliCyze4-gAW3AyjC7y8Y99VdVsJXZX2wjjRuds@mail.gmail.com>
Subject: Re: adis16220 capture event
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Wed, May 12, 2010 at 1:33 AM, Jonathan Cameron <jic23@cam.ac.uk> wrote:
> On 05/11/10 16:07, Barry Song wrote:
>> On Tue, May 11, 2010 at 7:30 PM, Jonathan Cameron <jic23@cam.ac.uk> wrot=
e:
>>>
>>> On 05/11/10 08:59, Barry Song wrote:
>>>> Jonathan,
>>>> adis16260 in drivers/staging/iio/gyro/ has been ready too.
>>>> Do you have time to take a look at the datasheet of adis16220? I think
>>>> it is much different. The chip has no register to show the current
>>>> sample value. It only has a capture buffer mode. =C2=A0For every captu=
re(by
>>>> manual or by period at least 1 second), the ADIS16220 produces and
>>>> stores 1024
>>>> samples of acceleration and analog input channel data into the capture
>>>> buffers. It has no a fixed frequency to sample, by depends on user
>>>> commands or timer to trigger a capture.
>>>
>>> I've been waiting for a device like this to be supported :)
>>>
>>>> I think current iio doesn't support it at all:
>>>> 1. sysfs node is useless to show current value
>>> Indeed so don't supply one. =C2=A0All the sysfs interfaces are optional=
 and should
>>> only be supplied where they make sense.
>>>> 2. it doesn't sample periodically, so ring is useless too.
>>> Agreed that the ring buffer you have been using for the others is
>>> inappropriate. However, what you have below looks very like a
>>> hardware buffer (see the accel/sca3000_ring.c for an example).
>>>> Its work flow is:
>>>> capture -> 1024 data -> capture -> 1024 data -> capture -> 1024 data .=
...
>>>> I want to add a binary sysfs node for capture buffer.
>>> No. This really isn't a single value so it won't be accepted for mainli=
ne.
>> binary sysfs node is not a single value but a document which can hold
>> much data. some devices like i2c eeprom are using bin_attribute to
>> support read and write a big memory.
> I agree it happens. =C2=A0The general view is very anti doing this howeve=
r.
> Chrdev's are definitely the way to go for large data drops like this.
>>
>>> =C2=A0Every time, users
>>>> begin a capture, after finishing, read 1024 data from the binary node.
>>>>
>>>> Do you have any idea?
>>> Yes. I'd set the whole thing up as a hardware buffer. As an aside, we
>>> really need to get the word 'ring' out of the code at some point given
>>> quite a few implementations aren't going to be rings.
>> i don't think it is a hardware ring buffer.
> No indeed, it isn't. It is however a hardware buffer of data capture at a
> number of time instances. =C2=A0The data isn't a single time point, but r=
ather
> a set over a period of time. =C2=A0This is what I meant about the problem=
 with
> the word 'ring'. The intention was always to support other types of buffe=
r,
> very much including the type we have here. =C2=A0This actually looks almo=
st
> exactly like a non periodic trigger (e.g. gpio etc) filling a fifo,
> be it with a large number of samples over a period around the current tim=
e.
>
> Just because most of our uses so far are periodic, there is no inherent
> reason why they all should be. =C2=A0For a while I considered implementin=
g
> all event's coming from the devices as triggers but decided it was better
> to stick to only the obvious ones (datardy) so as to keep things simple
> when people were implementing the simpler drivers (without buffering).
>
>>every-time, data number is
>> fixed 1024 for a capture event. Without periodic input, a binary node
>> should be enough for this.
> That depends on how often you device is likely to trigger. Also there is
> the question of generality. =C2=A0We will get other devices like this. So=
me of
> them are going to trigger rather quickly.
>
> By all means put it in as a binary sysfs attribute for now, but take into
> account that it may well be unacceptable to upstream. =C2=A0I'm yet to be
> convinced this isn't a hardware buffer looking just like any other, be
> it with slightly odd triggering. =C2=A0Perhaps this is one to work on at =
a
> later date.
There has been a tested driver adis16220 in blackfin tree. there i
built 3 binary node for capture buffer accel/ain1/ain2. everyone is
2048B. A typical usage is like:

#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

int main(int argc,char **argv)
{
        int fd, ret;
        char buffer[2048];

        if((fd=3Dopen("/sys/class/iio/device0/accel_bin",O_RDONLY))=3D=3D-1=
) {
                printf("open /sys/class/iio/device0/accel_bin fail\n");
                exit(1);
        }

        ret =3D read(fd, buffer, 2048);
        if (ret < 0) {
                printf("read /sys/class/iio/device0/accel_bin fail\n");
                exit(1);
        } else {
                printf("read %d bytes from
/sys/class/iio/device0/accel_bin\n", ret);
        }

        close(fd);

        return 0;
}
and string node is still kept, which can be used to read the current
value in capture buffer. For example,
echo 100 > /sys/class/iio/device0/capture_count
cat /sys/class/iio/device0/accel   -> get 100nd data
cat /sys/class/iio/device0/accel   -> get 101nd data
cat /sys/class/iio/device0/accel   -> get 102nd data
cat /sys/class/iio/device0/adc1   -> get 103nd data
cat /sys/class/iio/device0/adc2   -> get 104nd data
...

>
> Jonathan
>>
>>>
>>> From the datasheet I see there are a couple of different ways to trigge=
r
>>> capture. =C2=A0I would be inclined to handle the manual mode via a trig=
ger.
>>> I think a general userspace manual trigger would be helpful anyway for
>>> testing other devices if nothing else. =C2=A0Probably just a sysfs attr=
ibute
>>> called capture_now that otherwise looks much like the gpio trigger.
>>>
>>> The timer option is more or less the equivalent of a conventional fixed
>>> frequency capture (be it with a lot of data per capture!). One could
>>> supply a trigger to indicate this has finished. Probably better to have
>>> the event in question come from the buffer event chrdev (see below).
>>>
>>> The last option of doing it based on an event is more interesting.
>>> The options that come to mind are:
>>>
>>> * A seperate trigger - You would need a way for other devices to know t=
he
>>> =C2=A0trigger has fired. This would pretty much require tying the alarm=
 in question
>>> =C2=A0to one of the gpio pins so as to pass the notification on. =C2=A0=
Perhaps this only
>>> =C2=A0happens if another device attaches to the trigger? (bit fiddly to=
 code).
>>>
>>> * Do it internally as control attributes of a new hardware buffer.
>>> =C2=A0If you are also supporting general alarm events the logic would g=
et a little
>>> =C2=A0complex as obviously these could be shared (event can trigger a b=
uffer fill
>>> =C2=A0as well as causing an external gpio interrupt).
>>>
>>> I would prefer the first option, but the second is fine for now if it i=
s
>>> easier to code up. =C2=A0The first allows us to say chain on a gyro to =
get
>>> additional info triggered off trigger events from adis16220. =C2=A0Clea=
rly
>>> there are a few complexities to be considered. =C2=A0For one thing the =
exact
>>> nature of the trigger consumer function would be different from the use=
rspace
>>> trigger (when it would cause a capture) to the event based triggers
>>> (where the capture would already have happened). =C2=A0This is actually=
 a case
>>> that needs better handling in some of the current drivers. =C2=A0In the=
ory
>>> with the lis3l02dq for example, one can trigger another device off it's
>>> datardy signal without actually triggering the lis3l02dq itself. =C2=A0=
This
>>> would result in no read of data and the datardy signal would not clear.
>>> Obviously this would be a pretty strange thing to do, but the interface
>>> does allow it and so it ought to be nicely handled. =C2=A0Currently it =
is not!
>>> That one has been at the bottom of the todo list for a long time.
>>>
>>> The new buffer would have an event chrdev from which a new type of even=
t
>>> can be read (not sure on naming, something like BUFFER_CAPTURE_EVENT_FI=
NISHED)
>>> It would also have an access chrdev as per the software ring you have
>>> been using so far. =C2=A0This access chrdev will read directly (via spi=
) from the
>>> buffer on the device. =C2=A0A while back there was some discussion abou=
t whether
>>> devices like these (with hardware buffering) should always feed into an
>>> intermediate software buffer. =C2=A0Personally I don't think they need =
to and
>>> if we decide otherwise this can always be added at a later date.
>>>
>>> Obviously there would be a number of new abi elements introduced that m=
ight
>>> well generalize over a range of devices, so if you go this way please p=
ropose
>>> them formally on the list (and possibly also lkml) for discussion.
>>>
>>> Thanks,
>>>
>>> Jonathan
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.html
>>
>
>
