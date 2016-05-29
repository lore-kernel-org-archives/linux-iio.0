Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33533 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752025AbcE3AAa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 29 May 2016 20:00:30 -0400
Received: by mail-lf0-f65.google.com with SMTP id w16so10566936lfd.0
        for <linux-iio@vger.kernel.org>; Sun, 29 May 2016 17:00:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160529203336.GA2409@d830.WORKGROUP>
References: <1464317706-25569-1-git-send-email-mranostay@gmail.com>
 <6902c38d-0b3a-9d8c-02cf-29806c195dda@kernel.org> <20160529203336.GA2409@d830.WORKGROUP>
From: Matt Ranostay <mranostay@gmail.com>
Date: Sun, 29 May 2016 16:59:49 -0700
Message-ID: <CAKzfze_waK14yae7+Kgm-kAiGpZ5mOBA37kcoQSHyMJnVUO10w@mail.gmail.com>
Subject: Re: [PATCH] iio: humidity: hdc100x: fix IIO_TEMP channel reporting
To: Alison Schofield <amsfield22@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, May 29, 2016 at 1:33 PM, Alison Schofield <amsfield22@gmail.com> wrote:
> On Sun, May 29, 2016 at 07:46:47PM +0100, Jonathan Cameron wrote:
>> On 27/05/16 03:55, Matt Ranostay wrote:
>> > IIO_TEMP channel was being incorrectly reported back as Celsius when it
>> > should have been milliCelsius.
>> >
>> > Signed-off-by: Matt Ranostay <mranostay@gmail.com>
>> Applied to fixes-togreg-post-rc1 and marked for stable.
>>
>> Thanks,
>>
>> Jonathan
>
>
> Hi Matt, I tried testing this one out and it looks good, but led me
> to more questions ;)
>
> (fyi: this is one of the first hw sensors I got, and as you can guess
> by the other work, we didn't realize it already had a driver, hence,
> using it as a learning experience.)
>
> Summary of this long msg is:
> - this fix correcting the temp scale works fine
> - questioning what driver is providing as "raw" data for both temp & humid
> - humidity calc seems off
>
> Here's my path: I read the raw temp, look at the data sheet calculation,
> and expect to be able to plug the raw reading sysfs provides into that
> equation and come up with the actual temp.  I can't do that because the
> raw data the driver is provided is not so 'raw'.  The driver is stripping
> away the extraneous bits and providing 14bits of actual temp data from the
> 16bit temp register as 'raw'. I get that and can see how that might be the
> right thing to do, but not so sure, since I just got bit by it.  Should the
> driver be providing the real raw register data and doing all the munging via
> scale and offset. Do some users want to get that raw number, look at the
> datasheet, and do the work themselves?
>
> The temp calcs seem close enough:
> 16 bit raw: 24929, 14 bit raw: 6232
>
> $ cat in_temp_raw in_temp_offset in_temp_scale
> 6232
> -3971.879096
> 10.070800781
>
> Grabbed both - 16 bit raw: 24929, 14 bit raw: 6232
>
> 14Bit way using scale & offset:
> (6232 - 3971.879096) * 10.070800781 / 1000 = 22.761227365
>
> 16Bit way using datasheet equation:
> (24929/65536 * 165) -40 = 22.763748163
>
>
Yeah can't expect it be 100% correct with scaling values and floating
points. Also the offset is with the scale applied.

> Now, onto the humidity - not close, am I doing this right?
> Since my trusty Bionaire humidity sensor says 32% I'm
> thinking the datasheet calc is correct.
>
> $ cat in_humidityrelative_raw in_humidityrelative_scale
> 5075
> 0.010000
>
> Again, grabbed both - 16 bit raw: 20303, 14 bit raw: 5075
>
> 14Bit way using scale:
> 5075 * 0.01 = 50.75

Yeah probably another oops on my part... seems I really shouldn't be
shifting >>2 in the read function for both
"The humidity register is a 16-bit result register in binary format
(the 2 LSBs D1 and D0 are always 0)."

Clearly only used the high resolution mode in both cases... I'll do a
quick fix and send it out... however since I don't think I actually
have this sensor anymore I'll need a Tested-by from you..

Thanks,

Matt

>
> 16Bit way using datasheet equation:
> 20303/65536 * 100% = 30.98
>
> That's all I have.  Let me know if I can do anything more with it.
> Thanks,
> alisons
>
>> > ---
>> >  drivers/iio/humidity/hdc100x.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
>> > index fa47676..7e73c56 100644
>> > --- a/drivers/iio/humidity/hdc100x.c
>> > +++ b/drivers/iio/humidity/hdc100x.c
>> > @@ -211,7 +211,7 @@ static int hdc100x_read_raw(struct iio_dev *indio_dev,
>> >             return IIO_VAL_INT_PLUS_MICRO;
>> >     case IIO_CHAN_INFO_SCALE:
>> >             if (chan->type == IIO_TEMP) {
>> > -                   *val = 165;
>> > +                   *val = 165000;
>> >                     *val2 = 65536 >> 2;
>> >                     return IIO_VAL_FRACTIONAL;
>> >             } else {
>> >
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
