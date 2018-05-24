Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:35103 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751791AbeEXFb6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 24 May 2018 01:31:58 -0400
Received: by mail-it0-f66.google.com with SMTP id q72-v6so861877itc.0
        for <linux-iio@vger.kernel.org>; Wed, 23 May 2018 22:31:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180522181209.22f48606@archlinux>
References: <CAJCx=g=9XoXygjdQ9r410jerbtDxOvUtN0a+KAdnj2OAb_1WGg@mail.gmail.com>
 <20180520171116.1fc57939@archlinux> <CAJCx=gk83MPeCCsQuXx-QpTVVO1RACR6d=pp2BLD3PDEDm0jOQ@mail.gmail.com>
 <20180522181209.22f48606@archlinux>
From: Matt Ranostay <matt.ranostay@konsulko.com>
Date: Thu, 24 May 2018 13:31:57 +0800
Message-ID: <CAJCx=gms57sFgy7R-gtofFwy_dsJ_XuWb6NcYSpeDAZ4Lqs81g@mail.gmail.com>
Subject: Re: [RFC] Spectral ID sensor + floating point questions
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, May 23, 2018 at 1:12 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> On Mon, 21 May 2018 13:56:16 +0800
> Matt Ranostay <matt.ranostay@konsulko.com> wrote:
>
>> On Mon, May 21, 2018 at 12:11 AM, Jonathan Cameron <jic23@kernel.org> wrote:
>> > On Sun, 20 May 2018 22:21:03 +0800
>> > Matt Ranostay <matt.ranostay@konsulko.com> wrote:
>> >
>> >> Jonathan et all,
>> >>
>> >> Currently looking at ams AS7262 Spectral ID sensor, and thinking about
>> >> adding support to enable a project I'm working on.
>> >>
>> >> But I noticed it is a bit odd in that outputs data for the 6 color
>> >> channels in either a) raw 16-bit ADC values b) or calibration adjusted
>> >> values (factory calibration) but are presented as 32-bit single
>> >> precision floats.
>> >>
>> >> Clearly the latter data is  much more useful but of course it is a
>> >> floating point which isn't exactly the ideal in the kernel and there
>> >> isn't a precedent in iio (that I know of) for such values.
>> >>
>> >> Datasheet: https://www.mouser.com/ds/2/588/AS7262_DS000486_2-00-1082195.pdf
>> >>
>> >> Any thoughts, or suggestions?
>> >
>> > Hmm. Will need to think about this a little, but from a very high
>> > level look at the datasheet and you description, there is nothing technically
>> > stopping us supporting devices that do standards compliant floating point.
>> >
>> > The only similar case we have run into in the past was the mess of the HID
>> > sensor spec which could in theory change range over time and report it
>> > via the event path.  Thankfully I don't think we have ever seen a part
>> > that actually does this. That was tricky because it wasn't in a standard
>> > format and so pretty much required in kernel reformatting.
>> >
>> > As this is real floating point, we probably just want to pass it straight
>> > through to userspace using the buffered interface and a suitable
>> > description of the type.
>> >
>>
>> What would you recommend for naming?  IIO_VAL_FLOAT, IIO_VAL_SINGLE, or etc?
> We might have weird float lengths etc so howabout the IEEE standard in the
> name?
>

So I assume like IIO_VAL_IEEE754 ?

>>
>>
>> > What we can't sensibly do is any in kernel consumers (as they'd have
>> > to do fp maths) or anything involving maths in kernel on these.
>> >
>> > We could do read_raw support with a suitable float to str function if
>> > it is potentially useful...
>>
>> Actually after thinking about this we wouldn't need this because
>> reading one channel
>> is useless, you need all six channels from the same sample reading to
>> have a valid data.
>>
>> Which is nice to not need to hack a float_to_str() function in for the
>> time being.
>>
>> >
>> > So I'm not totally against the idea.
>> >
>> > However, we do need better description of light channels as giving
>> > them colors is only going to get us so far as these devices expand
>> > their number of channels and bring in the frequency range for each.
>> > Go for generality when you work this one out.
>>
>> Yeah not sure what to do here.. my first instinct is to just use the
>> IIO_LIGHT with no modifiers
>> since it is up to userspace to know what channels map to what on which
>> AS726x part.
>
> I think we should describe it.  Treat it a bit like the low / high
> pass filters and come up with some descriptive stats that we export
> to userspace for each channel.

Been out of the loop for bit so which drivers do this now? :)

Also one important note is the AS7261 outputs in tri-stimulus XYZ (CIE
1931) format, and which I have little
clue how one could make descriptive stats for that.

>
>>
>> >
>> > Fun looking part. I hope you go ahead with this one.
>> >
>> > Jonathan
>> >
>> >>
>> >> Thanks,
>> >>
>> >> Matt
>> >
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
