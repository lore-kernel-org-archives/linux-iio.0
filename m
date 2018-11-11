Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:56388 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728585AbeKLAtX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 11 Nov 2018 19:49:23 -0500
Date: Sun, 11 Nov 2018 15:00:32 +0000
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc: "ilucas.ms@gmail.com" <ilucas.ms@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>
Subject: Re: Work plan on ad5933
Message-ID: <20181111150032.0a6a9a58@archlinux>
In-Reply-To: <09719f42c739655736a0d7ca6c07c74db0246b67.camel@analog.com>
References: <20181105185911.g5324s46ixlgbvxj@smtp.gmail.com>
        <09719f42c739655736a0d7ca6c07c74db0246b67.camel@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 7 Nov 2018 13:39:48 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Mon, 2018-11-05 at 16:59 -0200, Lucas Santos wrote:
> > Hello,
> >   
> 
> Hey,
> 
> Sorry for the late reply.
> I deferred answering your email, and nearly forgot.
> 
> 
> > I'm looking at the code of impedaance-analyzer/ad5933, trying to
> > understand
> > what is needed to move it to the main tree. I am part of a study group
> > and we
> > are willing to work on it.  
> 
> Cool :)
> Thanks
> 
> > 
> > We do not understand all the necessary steps yet, but we have some
> > guests. I'd
> > like to ask if we are on the right track. All feedback will be much
> > appreciated.
> > 
> > We understand that we should refactor the way the driver is designed. We
> > think
> > we should removed the delayed work pattern (events queue) and use IRQ
> > pattern
> > instead. Is that correct? Do we need to do any additional work?
> >   
> 
> I don't think the driver needs a re-design from that perspective (i.e.
> delayed-work to IRQ); especially, since there doesn't seem to be any pins
> that can be used to trigger any interrupts.
> I could be wrong about this, but that's my current understanding from the
> datasheet.
> 
> The driver does need some work to get out of staging.
> 
> First & foremost: finalize device-tree support ; and maybe remove the
> `ad5933_platform_data` altogether. I also wanted to do this, but Jonathan
> made some good points about my patches and I did not have time to re-spin.
> Basically what needs to be done is to replace the vref_mv with using a
> regulator and ext_clk_Hz using a clock framework.
> 
> Then, maybe add a `of_device_id` /`of_match_table`.
> 
> Check if the driver is properly adapted for both ad5933 and ad5934 (since
> it supports both) ; it could be that there are some differences between the
> 2 chips that need to be updated in the driver (I didn't look yet).
> 
> You could take a look at using the regmap I2C stuff that's in the kernel.
> I'm not sure if this makes sense to use/change in this driver, but it may
> make sense to investigate this, and if the overall benefits are obvious,
> this could go in. Since it is investigation work, you could be expected
> that the work doesn't get included in the kernel.
> 
> Definitely do some testing of some of the existing stuff; we did find some
> bugs in a few of our old drivers (mismatched reg values, or bit fields,
> erronous sequences, stuff like that).
> 
> I think the main thing to get this driver out of staging (at the moment) is
> just the device-tree support.
> 
> I'll ask around (in our office) to see if anyone else has other thoughts on
> this driver, but I think this would be mostly it.
There is the question of ABI for this one given we don't have an existing
impedance devices.   Perhaps propose some docs for what is there already
and we can discuss whether there are nicer ways of doing it?

There is implicit creation of the kfifo which I suspect can use some of
the triggered-buffer infrastructure for.

Thanks,

Jonathan

> 
> Thanks
> Alex
> 
> > Best regards,
> > Lucas
> >   
