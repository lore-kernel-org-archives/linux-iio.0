Return-Path: <robin.muellerbady@gmail.com>
MIME-Version: 1.0
Sender: robin.muellerbady@gmail.com
In-Reply-To: <51CEAB8D.8030201@kernel.org>
References: <CACRdhnBWk8Vi1fD6+6LknnLoPb8dLBEq3wrMXLofVrqQEEuaFA@mail.gmail.com>
 <51CEAB8D.8030201@kernel.org>
From: =?UTF-8?B?Um9iaW4gTcO8bGxlci1CYWR5?= <mueller-bady@linux.com>
Date: Sun, 30 Jun 2013 10:27:13 +0200
Message-ID: <CACRdhnDrGn6fk0BYLBczDrFJGG4wP3h2+SyYQeqsUMW9q_bdgw@mail.gmail.com>
Subject: Re: Start writing new IIO drivers
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Thank you very much for your recommendations!
I had some bad experiences using a cross compiler for ARM while I
tried to build a "Linux from scratch". But I will try it again and
hopefully save some time ;-)

Thank you,

Robin

2013/6/29 Jonathan Cameron <jic23@kernel.org>:
> On 06/28/2013 10:28 AM, Robin M=C3=BCller-Bady wrote:
>> Hi,
>>
>> I'm currently writing userspace software in python and c for using
>> (mainly I2C) sensors, e.g. MPL115A2 barometric pressure, on a
>> raspberry pi.
> Excellent!
>
>> I now want to port them to the IIO subsystem but I still require some he=
lp.
>> * Is there any good documentation on writing those drivers ? I'm
>> currently working through examples in the current git kernel version
>> with assistance of the IIO Introductory slides from Maxime Ripard
>> "IIO, a new kernel subsystem" but these examples are, in my opinion,
>> rather difficult.
>
> Saddly the nature of kernel driver development is that it is hard to put
> together simple examples (or perhaps I'm just no good at doing so).
> I'd personally start by taking a basic driver, (perhaps accel/kxsd9)
> and making sure you understand what each step is doing.
>
> Note this won't be a trivial exercise as you will want to drill down
> through a lot of the function calls to really get the hang of it.
> Another option is to first of all play with the dummy driver without the
> events or buffer enabled.  That is there to in a sense act as documentati=
on
> of how to do basic stuff.
>
>> * As raspbian (raspberry pi specific debian version) comes with a
>> precompiled kernel 3.6.9, several features of IIO seem to be not yet
>> included. Compiling a kernel natively on the raspi is no fun (700MHz
>> ARM), so I don't want to make any mistake with the configs.
> Silly question but has no one provided an appropriate cross compiler?
> I certainly don't do my arm builds on an arm processor - have a nice
> fast intel one for building stuff.  Obviously my appologies if all you
> have to hand is a raspberry pi, in which case I hope you also have a
> good book to read.
>
> If I were you I would spend some time working out how to do a full cross =
compile
> from scratch of a more recent kernel.  I see from a quick google that
> lots of people are saying 'but it is so much easier to build directly on =
the
> pi'.  All I can say is they have clearly never built anything of any size=
 with
> an frequency.  Also doing kernel development on anything more than a few
> months old just leads to a world of pain and makes it much harder to get
> help as it's not what everyone else is working with.
>
>> Which
>> kernel options of the current stable kernel do I require for IIO/I2C
>> Sensor communication ?
> Should just need relevant i2c bus support (if you can enable the actual
> i2c bus driver then you'll have all the dependencies), core IIO and the
> driver you want to use. Again if you enable the driver you should be fine
> and it should not be available unless i2c support is present.
>
>>
>> Thank you very much in advance!
> Good luck,
>
> Feel free to post any questions you have about specific aspects as you
> get going.
>>
>> Regards,
>>
>> Robin
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
