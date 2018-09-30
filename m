Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:37760 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbeI3VyV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Sep 2018 17:54:21 -0400
Date: Sun, 30 Sep 2018 16:20:33 +0100
In-Reply-To: <CAL_JsqLNGua++ESBgf5qSqoLdLwq8awyFr29pYR=JVBOwX3eAg@mail.gmail.com>
References: <20180918082422.13050-1-songqiang1304521@gmail.com> <20180918082422.13050-2-songqiang1304521@gmail.com> <20180922160523.16b399fc@archlinux> <20180926224618.GA32126@bogus> <20180928093618.GA24536@Eros> <CAL_JsqLpNiGdK9hWTGWZwgbgRr8DNF=XvKGUx=oS2jTJ61yhFg@mail.gmail.com> <20180929121034.6c5e5826@archlinux> <CAL_JsqLNGua++ESBgf5qSqoLdLwq8awyFr29pYR=JVBOwX3eAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [PATCH v6 2/2] iio: proximity: vl53l0x: add interrupt support
To: Rob Herring <robh@kernel.org>, Jonathan Cameron <jic23@kernel.org>
CC: Song Qiang <songqiang1304521@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andreas Klinger <ak@it-klinger.de>, linux-iio@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Message-ID: <7BD7DB08-A320-4088-AE9D-2E4788BC0F1C@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 30 September 2018 00:49:43 BST, Rob Herring <robh@kernel.org> wrote:
>On Sat, Sep 29, 2018 at 6:10 AM Jonathan Cameron <jic23@kernel.org>
>wrote:
>>
>> On Fri, 28 Sep 2018 18:52:13 -0500
>> Rob Herring <robh@kernel.org> wrote:
>>
>> > On Fri, Sep 28, 2018 at 4:36 AM Song Qiang
><songqiang1304521@gmail.com> wrote:
>> > >
>> > > On Wed, Sep 26, 2018 at 05:46:18PM -0500, Rob Herring wrote:
>> > > > On Sat, Sep 22, 2018 at 04:05:23PM +0100, Jonathan Cameron
>wrote:
>> > > > > On Tue, 18 Sep 2018 16:24:22 +0800
>> > > > > Song Qiang <songqiang1304521@gmail.com> wrote:
>> > > > >
>> > > > > > The first version of this driver issues a measuring request
>and polling
>> > > > > > for a status register in the device for measuring
>completes.
>> > > > > > vl53l0x support configuring GPIO1 on it to generate
>interrupt to
>> > > > > > indicate that new measurement is ready. This patch adds
>support for
>> > > > > > using this mechanisim to reduce cpu cost.
>> > > > > >
>> > > > > > Signed-off-by: Song Qiang <songqiang1304521@gmail.com>
>> > > > > Hi Song.
>> > > > >
>> > > > > Looks correct in principal but a few things to tidy up before
>> > > > > this is ready to apply.
>> > > > >
>> > > > > Also we have an unrelated change in here to check the devices
>ID.
>> > > > > That should be in it's own patch.
>> > > > >
>> > > > > Thanks,
>> > > > >
>> > > > > Jonathan
>> > > > > > ---
>> > > > > >  .../bindings/iio/proximity/vl53l0x.txt        |  14 +-
>> > > >
>> > > > This should have been split with the complete binding in one
>patch
>> > > > rather than piecemeal driver feature by feature.
>> > > >
>> > >
>> > > Hi Rob,
>>
>> Hi Rob, Song,
>>
>> > >
>> > > A few days ago when I was submitting this driver, I didn't do it
>very
>> > > well, the function of this driver is limited. I added interrupt
>support
>> > > the next day after you acked my first patch. I thought it's not
>polite
>> > > to add something after someone acked that patch, so I send the
>interrupt
>> > > support as a second patch. The first patch is merged to togreg
>now, but
>> > > this doesn't. I don't know when can I add new functions to the
>code that
>> > > just merged to togreg branch, could you offer some suggestions?
>> >
>> > You just needed to state why you didn't add a ack. But really, just
>> > don't send things except as RFC until they are "done".
>>
>> The RFC bit actually disagree on.  This driver could be considered
>'done'
>> with just patch 1.  The driver worked, it was useful. When the early
>> versions of that patch came out Song had no idea how much work it
>would
>> be to add interrupt support.  As it turns out it was simple - it
>often isn't :(
>
>I meant specifically in the context of this getting revised within a
>number of days. I agree that drivers don't have to be complete, but
>bindings should be as complete as possible. You can't foresee
>everything, but I don't think that applies in this case.
>
>> > What to do next depends on Jonathan and whether he wants a
>follow-up
>> > patch or he will drop the first one.
>>
>> Yeah. I should have picked up on the binding in the second patch and
>merged
>> it.  I'd seen the first patch a few times before so was happy with it
>and
>> applied before actually looking at the second.
>>
>> If they had come in separate series in my view the partial binding
>then
>> extend with 'optional' elements is fine.  The number of times I've
>discovered
>> issues with documentation of hardware that would have made any
>binding written
>> from the docs wrong is non trivial. So in my view it is always a
>gamble to
>> write bindings until you have tested they work.  I have not problem
>with
>> people who are confident and want to add them from the start though.
>
>Well, if they were broken is some way, I don't think backwards
>compatibility matters and we can still fix things. I'm not talking
>about complex cases here. It is pretty trivial to determine whether a
>device has an interrupt or not.
>
>>
>> Obviously this only works for optional elements.
>>
>> So follow up patch for 'optional' stuff is fine by me.  The only real
>> issue to my mind here is that they were in the same series, so we
>should
>> have seen a separate precursor patch giving the binding for all of
>it.
>
>Certainly, that can't be avoided sometimes and is fine. It's really
>the time frame for this particular case and reviewer bandwidth.

Agreed. The timing wasn't ideal (in this limited sense)  Song got this done much faster than I normally expect
when someone says, I'll do this later! 

Thanks for clarifying.

Jonathan
>
>Rob

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
