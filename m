Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout02.posteo.de ([185.67.36.66]:54836 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753573AbdKNHWQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 14 Nov 2017 02:22:16 -0500
Received: from submission (posteo.de [89.146.220.130])
        by mout02.posteo.de (Postfix) with ESMTPS id 7DCA020C87
        for <linux-iio@vger.kernel.org>; Tue, 14 Nov 2017 08:22:14 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Tue, 14 Nov 2017 08:21:58 +0100
From: Martin Kepplinger <martink@posteo.de>
To: harinath Nampally <harinath922@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, knaack.h@gmx.de,
        lars@metafoo.de, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alison Schofield <amsfield22@gmail.com>
Subject: Re: [PATCH] iio: accel: mma8452: Add single pulse/tap event detection
In-Reply-To: <CAAGUq_qpe9JPp4pWR_vmo-MgWBDeWXz-+VsXHJNJ-ZtqnzB1Jw@mail.gmail.com>
References: <1510197177-9434-1-git-send-email-harinath922@gmail.com>
 <e89813c7-696a-bdb1-8452-3aa2886d2d9a@posteo.de>
 <CAAGUq_qpe9JPp4pWR_vmo-MgWBDeWXz-+VsXHJNJ-ZtqnzB1Jw@mail.gmail.com>
Message-ID: <a8b4fb5d90af4b5e9d08c9a86993fc72@posteo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Am 14.11.2017 05:36 schrieb harinath Nampally:
>> > This patch adds following related changes:
>> > - defines pulse event related registers
>> > - enables and handles single pulse interrupt for fxls8471
>> > - handles IIO_EV_DIR_EITHER in read/write callbacks (because
>> >   event direction for pulse is either rising or falling)
>> > - configures read/write event value for pulse latency register
>> >   using IIO_EV_INFO_HYSTERESIS
>> > - adds multiple events like pulse and tranient event spec
>> >   as elements of event_spec array named 'mma8452_accel_events'
>> >
>> > Except mma8653 chip all other chips like mma845x and
>> > fxls8471 have single tap detection feature.
>> > Tested thoroughly using iio_event_monitor application on
>> > imx6ul-evk board which has fxls8471.
>> >
>> > Signed-off-by: Harinath Nampally <harinath922@gmail.com>
>> > ---
>> What tree is this written against? It doesn't apply to the current 
>> -next
>> anyways.
> Thanks for the review.
> It is actually against 'testing' branch, I think two of my earlier
> patches are not yet applied to
> any branch, that might be reason this patch is not good against
> current -next or 'togreg'.
> 
>> I think the defintions would deserve to be in a separate patch, but
>> that's debatable.
> Yes, I would argue that definitions are not a logical change.
> 

I would argue definitions don't break the build and maybe slightly 
better
support features like bisect or revert :)

>> >               .type = IIO_EV_TYPE_MAG,
>> >               .dir = IIO_EV_DIR_RISING,
>> >               .mask_separate = BIT(IIO_EV_INFO_ENABLE),
>> > @@ -1139,6 +1274,15 @@ static const struct iio_event_spec mma8452_transient_event[] = {
>> >                                       BIT(IIO_EV_INFO_PERIOD) |
>> >                                       BIT(IIO_EV_INFO_HIGH_PASS_FILTER_3DB)
>> >       },
>> > +     {
>> > +             //pulse event
>> > +             .type = IIO_EV_TYPE_MAG,
>> > +             .dir = IIO_EV_DIR_EITHER,
>> > +             .mask_separate = BIT(IIO_EV_INFO_ENABLE),
>> > +             .mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
>> > +                                     BIT(IIO_EV_INFO_PERIOD) |
>> > +                                     BIT(IIO_EV_INFO_HYSTERESIS)
>> > +     },
>> >  };
>> >
>> >  static const struct iio_event_spec mma8452_motion_event[] = {
>> > @@ -1202,8 +1346,8 @@ static struct attribute_group mma8452_event_attribute_group = {
>> >               .shift = 16 - (bits), \
>> >               .endianness = IIO_BE, \
>> >       }, \
>> > -     .event_spec = mma8452_transient_event, \
>> > -     .num_event_specs = ARRAY_SIZE(mma8452_transient_event), \
>> > +     .event_spec = mma8452_accel_events, \
>> > +     .num_event_specs = ARRAY_SIZE(mma8452_accel_events), \
>> that would go in the mentioned separate renaming-patch
> OK so I will make a patch set; patch 1/2 to just rename
> 'mma8452_transient_event[]'
> to 'mma8452_accel_events[]'(without adding pulse event).
> and everything else would go in 2/2. Does that makes sense?
> 

It does to me.
