Return-Path: <amsfield22@gmail.com>
Date: Tue, 20 Sep 2016 12:50:00 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: daniel.baluta@gmail.com, Ico Doornekamp <ico@pruts.nl>,
	linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: accel: sca3000_core: Fix superfluous indent white
 space
Message-ID: <20160920194959.GA5382@d830.WORKGROUP>
References: <20160909174414.31002-1-ico@pruts.nl>
 <95f27ba9-d54c-3dad-6b33-217010ce55bd@kernel.org>
 <1473522932-sup-4169@pruts.nl>
 <50ce9913-92cc-8e1b-f8eb-2faec769622a@kernel.org>
 <1473530764-sup-9251@pruts.nl>
 <bf8b4602-e470-60e4-c378-e2bbe22a4c88@kernel.org>
 <20160913192229.GA3846@d830.WORKGROUP>
 <dea17b69-e830-51df-8648-a52972a53ded@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <dea17b69-e830-51df-8648-a52972a53ded@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Sun, Sep 18, 2016 at 11:53:09AM +0100, Jonathan Cameron wrote:
> On 13/09/16 20:22, Alison Schofield wrote:
> > On Tue, Sep 13, 2016 at 06:37:17PM +0100, Jonathan Cameron wrote:
> >> On 10/09/16 19:16, Ico Doornekamp wrote:
> >>> * On 2016-09-10 18:26:45 +0200, Jonathan Cameron wrote:
> >>>  
> >>>> Another good one is to find things in staging drivers that we now
> >>>> have IIO_INFO_* elements for.
> >>>>
> >>>> For example in sca3000 I see there is an explicit attribute defined that
> >>>> could be replaced by IIO_INFO_SAMPLING_FREQUENCY being added in the
> >>>> relevant masks and appropriate sections added to the read_raw
> >>>> and write_raw callbacks.
> >>>>
> >>>> Not a trivial job, but not too hard to figure out perhaps?
> > 
> > Not trying to hijack Ico's work ;) but wondering if this task, applied to
> > staging drivers, would be good to offer to this round of Outreachy
> > applicants as a small coding task?
> There are probably other cases still out there.  Wouldn't guarantee they
> are all in staging either!
> 
> Commenting out the relevant macros in include/linux/iio/sysfs.h is
> a good way to find these.  The whole shared_by_... stuff is
> 'relatively recent' so quite a few drivers predate it.
> 
> Good to get them cleaned up and it's not a bad step up from
> white space fixes (as Ico has just demonstrated ;)
> 
> Thanks,
> 
> Jonathan
> 

OK, it's out there as a task for Outreachy applicants.
Hopefully you'll see some incoming shortly.
(https://kernelnewbies.org/IIO_tasks)
alisons


> > 
> > alisons
> > 
> >>>
> >>> Not too hard, although I'm not able to actually run and test due to lack
> >>> of hardware.
> >> That's fine. This one is my driver (rather needing some care and attention)
> >> and I have the hardware still.  It's somewhat of a pain to fire up so
> >> I might do this one just on review but we'll see how busy I am at the weekend.
> >>>
> >>>> + a good step up from white space patches.
> >>>
> >>> I do hope the Little Penguin agrees on this :)
> >> Should do!
> >>>
> >>>> Guess maybe that needs to be a bit later if you are ploughing through
> >>>> the eudyptula-challenge (though that didn't exist when I got started
> >>>> so I don't know what order they do stuff in!)
> >>>
> >>> I have no clue: I'm trying to stick to the steps and not peek ahead.
> >>>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
