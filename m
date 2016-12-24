Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49742 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751152AbcLXKnU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 24 Dec 2016 05:43:20 -0500
In-Reply-To: <CAMuHMdXnzDUYcr8qiUTwE2peBdjwuVWPRUkms2J8AHFaQ=SHHQ@mail.gmail.com>
References: <1480432969-20913-1-git-send-email-bgolaszewski@baylibre.com> <44cce3d5-f65e-1a35-20a4-5eb9fda42312@metafoo.de> <CAMpxmJWDWk-mXUHHGEKm-VVwzqEGLDQjc274Xq+Qwc2eN=YbsQ@mail.gmail.com> <d4c7f1ca-49d4-7abe-bfc9-e1728f62a9fb@metafoo.de> <bf3dde7e-cee8-c54c-db93-447ffa063116@kernel.org> <CAMpxmJVJ+y9tRbRBsVg+i0EJO_6EFuvrypwC=ETnBWbMnxRFyg@mail.gmail.com> <c670d597-46b6-235f-545f-7136a3abff7f@metafoo.de> <CAMuHMdX3u4cb2Yq2+VV_eDUaw2EqiOjN2TorW+F5-39Mm=mXmQ@mail.gmail.com> <9609b56b-194c-9899-1142-ff2ee285c6bd@metafoo.de> <CAMuHMdXnzDUYcr8qiUTwE2peBdjwuVWPRUkms2J8AHFaQ=SHHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH] iio: misc: add a generic regulator driver
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Sat, 24 Dec 2016 10:43:13 +0000
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC: Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        linux-devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Patrick Titiano <ptitiano@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linus.walleij@linaro.org
Message-ID: <C587B7CE-0F74-4C2C-BCD6-0A753CF853A0@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 23 December 2016 12:56:11 GMT+00:00, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>Hi Lars,
>
>On Fri, Dec 23, 2016 at 12:35 PM, Lars-Peter Clausen <lars@metafoo.de>
>wrote:
>> On 12/23/2016 11:00 AM, Geert Uytterhoeven wrote:
>>> On Mon, Dec 12, 2016 at 6:15 PM, Lars-Peter Clausen
><lars@metafoo.de> wrote:
>>>> On 12/06/2016 12:12 PM, Bartosz Golaszewski wrote:
>>>>> We're already using libiio to read the measured data from the
>power
>>>>> monitor, that's why we'd like to use the iio framework for
>>>>> power-cycling the devices as well. My question is: would bridging
>the
>>>>> regulator framework be the right solution? Should we look for
>>>>> something else? Bridge the GPIO framework instead?
>>>>
>>>> I wouldn't necessaries create bridge, but instead just use the GPIO
>>>> framework directly.
>>>>
>>>> We now have the GPIO chardev interface which meant to be used to
>support
>>>> application specific logic that control the GPIOs, but where you
>don't want
>>>> to write a kernel driver.
>>>>
>>>> My idea was to add GPIOs and GPIO chips as high level object inside
>libiio
>>>> that can be accessed through the same context as the IIO devices.
>Similar to
>>>> the current IIO API you have a API for gpios that allows to
>enumerate the
>>>> GPIO devices and their pins as well as modify the pin state.
>>>
>>> That would mean libiio has access to all GPIOs, allowing a remote
>person
>>> to not only control through iiod the GPIOs for industrial control,
>but also the
>>> GPIOs not intended for export, right?
>>
>> Well, it is a policy question. Who gets access to what. Right now it
>is all
>> or nothing, a privileged application gets access to all
>devices/GPIOs, a
>> unprivileged application gets access to nothing. Same for GPIOs as
>well as
>> IIO devices.
>>
>> iiod at the moment does not have any access control at all, which in
>itself
>> is a problem. We need to add support for that at some point. I don't
>see an
>> issue with implementing a finer grained access scheme when we do so.
>E.g.
>> unprivileged applications only get access to certain pins.
>
>OK, so that's WIP.
>
>>> Having a separate GPIO switch driver avoids that, as DT (or some
>other means)
>>> can be used to specify and label the GPIOs for IIO use.
>>
>> Sure, functionally this would be equivalent, but we have to ask
>whether this
>> is the right way to use the DT. Is access policy specification part
>of the
>> hardware description? In my opinion the answer is no. At the hardware
>> description level there is no operating system, there is no userspace
>or
>> kernelspace, there is are no access levels. Putting the distinction
>between
>> a switch/regulator that can be controlled from userspace or can only
>be
>> controlled from kernel space into the DT would be a layering
>violation. It
>> is analogous to why we don't have spidev DT bindings. This is an
>issue that
>> needs to be solved at a higher level. In my opinion this level is a
>> cooperation between kernel- and userspace. Kernelspace offering an
>interface
>> to export a device for userspace access and userspace making use of
>that
>> interface to request access to a device. In a similar way to how vfio
>is
>> structured.
>
>I'm not advocating using DT for policy, only for hardware description.
>
>We have means (bindings) to describe GPIOs connected to LEDs and
>switches
>(incl. their labels), while you can control LEDs through plain GPIO
>sysfs
>export or chardev, too. It's just more error prone to use the latter.
>
>We do not have bindings to describe GPIOs connected to e.g. relays.
We should.
>
>Switching external devices (the internals of those devices not
>described
>itself in DT, like in an industrial context), sounds more like
>something to
>be handled by IIO, doesn't it?

Certainly, if there is known hardware to describe, we should endeavour to describe it.
Userspace interfaces are needed wherever we hit the boundary of what we can describe,
 whether because we are measuring things not in our control (e.g. what key is pressed on a
 keyboard) or because the next bit of hardware is interchangeable (e.g. your relay example, or
 this power switch).

The challenge is to structure the device model for the interchangeable edge case to be the
 same, more or less, as it would be if we knew what was hanging off the switch.
Hence, we either cut out early (gpio) or we attempt to put an appropriate consumer in place
 for the gpio (or possibly the power switch if we describe that). No problem at all in doing that
 last chunk with IIO or GPIO userspace as appropriate...

The challenge is that we are representing the fact the hardware is unknown in device tree.
Perhaps we need a way to make that explicit? Is there one already? Things like extcon do similar
 things I guess.
Same is true for regulators, when they are at the edge of the device...

On the binary channel types in IIO we have discussed this a fair bit in the past. There
Is a non trivial amount of work needed to do triggered input (demuxing to multiple consumers
In particular). 
Sysfs stuff would be simple but then it would really be gpio interface wrapped up a bit.
What IIO would bring to the mix ultimately is synchronized triggering of input and output.
(Speaking of which, Lars any progress on output buffers? Perhaps if we post that someone else might pick it up and run with it?)

One could argue the relay case is more of a mux than anything else so perhaps the ongoing
 generic mux subsystem discussion would be a good place to talk about that?

Interesting discussion, sorry it took me until my Christmas train journey to join in).

Linus, if you get a chance, you have probably thought more about gpio IIO interactions than I have!

Jonathan
>
>Gr{oetje,eeting}s,
>
>                        Geert
>
>--
>Geert Uytterhoeven -- There's lots of Linux beyond ia32 --
>geert@linux-m68k.org
>
>In personal conversations with technical people, I call myself a
>hacker. But
>when I'm talking to journalists I just say "programmer" or something
>like that.
>                                -- Linus Torvalds
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
