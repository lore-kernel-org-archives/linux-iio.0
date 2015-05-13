Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:35633 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754248AbbEMSD2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 13 May 2015 14:03:28 -0400
MIME-Version: 1.0
In-Reply-To: <55538D1A.80500@kernel.org>
References: <1429174868-11953-1-git-send-email-robert.dolca@intel.com>
 <1429174868-11953-2-git-send-email-robert.dolca@intel.com>
 <554CD236.4000404@kernel.org> <555230B0.3050700@metafoo.de>
 <55524F4C.90604@kernel.org> <5552FD16.9050306@metafoo.de> <55538D1A.80500@kernel.org>
From: Robert Dolca <robert.dolca@gmail.com>
Date: Wed, 13 May 2015 21:03:06 +0300
Message-ID: <CAFPB+YdgLBo8zfTYgxGm=_n7cxdUTpzK92HekMiHOH=d5t_vcw@mail.gmail.com>
Subject: Re: [PATCH RFC 1/3] iio: Add symlink to triggers in the device's
 trigger folder
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Robert Dolca <robert.dolca@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Denis CIOCCA <denis.ciocca@st.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, May 13, 2015 at 8:42 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On 13/05/15 08:28, Lars-Peter Clausen wrote:
> > On 05/12/2015 09:06 PM, Jonathan Cameron wrote:
> >> On 12/05/15 17:56, Lars-Peter Clausen wrote:
> >>> On 05/08/2015 05:11 PM, Jonathan Cameron wrote:
> >>>> On 16/04/15 05:01, Robert Dolca wrote:
> >>>>> This patch adds a new function called iio_trigger_register_with_dev
> >>>>> which is a wrapper for iio_trigger_register. Besides the iio_trigger
> >>>>> struct this function requires iio_dev struct. It adds the trigger in
> >>>>> the device's trigger list and saves a reference to the device in the
> >>>>> trigger's struct.
> >>>>>
> >>>>> When the device is registered, in the trigger folder of the device
> >>>>> (where current_trigger file resides) a symlink is being created for
> >>>>> each trigger that was registered width iio_trigger_register_with_dev.
> >>>>>
> >>>>>    # ls -l /sys/bus/iio/devices/iio:device0/trigger/
> >>>>> total 0
> >>>>> -rw-r--r--    1 root     root          4096 Apr 16 08:33 current_trigger
> >>>>> lrwxrwxrwx    1 root     root             0 Apr 16 08:33 trigger0 -> ../../trigg
> >>>>> er0
> >>>>>
> >>>>> This should be used for device specific triggers. Doing this the user space
> >>>>> applications can figure out what if the trigger registered by a specific device
> >>>>> and what should they write in the current_trigger file. Currently some
> >>>>> applications rely on the trigger name and this does not always work.
> >>>>>
> >>>>> This implementation assumes that the trigger is registered before the device is
> >>>>> registered. If the order is not this the symlink will not be created but
> >>>>> everything else will work as before.
> >>>>>
> >>>>> Signed-off-by: Robert Dolca <robert.dolca@intel.com>
> >>>> I was rather hoping we'd get a few more comments on this.
> >>>> In principle I like the idea, but it's new ABI and does make life
> >>>> a tiny bit more complex, so what do people think?
> >>>>
> >>>> Few trivial code comments inline.
> >>>
> >>> I don't think it adds more information. Both the trigger and the
> >>> device get registered for the same parent device, so you can already
> >>> easily find the trigger for a device by going to the parent device
> >>> and taking a look at the triggers registered by the parent device.
> >> I had the same thought. The question is whether the slightly gain in
> >> simplicity for userspace is worth it...  I'm undecided at the moment.
> >
> > As you may have guessed by now I'm always quite conservative when it
> > comes to introducing new ABI. Simply because we have to maintain it
> > forever, the less stuff to maintain forever the better.
> >
> > Hence I think all new ABI needs a compelling reason, e.g. like a
> > improvement in performance. And of course this patch slightly
> > simplifies things, but in my opinion not enough to justify a ABI
> > extension. We can always find ways to simplify the interface, but the
> > metric for ABI should be whether the simplification actually matters.
> > In this case I don't think it does, finding the trigger for a device
> > is not really hot-path. The amount of time saved will be disappear in
> > the noise.
> >
> > And in my opinion applications shouldn't directly use the low-level
> > ABI but rather use middle-ware libraries/frameworks, like e.g.
> > libiio, and that's where you'd hide the complexities of a operation.
> >
> > - Lars
> I'll go with Lars response on this one.  Not worth the hassle.
> That's the nature of an RFC of course!
>
> Jonathan

Would it be acceptable to add the symlinks without adding a new API?
When a trigger is registered you could use the common parent to get a
pointer to the iio_dev and then create the symlink. This is a little
bit complicated but I think it can be done.

Robert
