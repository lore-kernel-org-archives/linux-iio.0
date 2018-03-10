Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:44862 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932462AbeCJQfc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 10 Mar 2018 11:35:32 -0500
Date: Sat, 10 Mar 2018 16:35:27 +0000
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Daniel Baluta <daniel.baluta@gmail.com>
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        linux-iio@vger.kernel.org, Daniel Baluta <daniel.baluta@nxp.com>,
        graff.yang@gmail.com, davidjulianveenstra@gmail.com
Subject: Re: Work plan to move AD2S1210 out of staging
Message-ID: <20180310163527.702a6668@archlinux>
In-Reply-To: <CAEnQRZCYuP5K97=6uKJsepcQz+3gP9U67kZw7M8cd=gX3Cag6A@mail.gmail.com>
References: <20180309005200.pj6ez2xgrxjwhvxe@smtp.gmail.com>
        <CAEnQRZCYuP5K97=6uKJsepcQz+3gP9U67kZw7M8cd=gX3Cag6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 9 Mar 2018 10:04:02 +0200
Daniel Baluta <daniel.baluta@gmail.com> wrote:

> Hi Rodrigo,
> 
> Thanks for your effort on analyzing this.
> 
> On Fri, Mar 9, 2018 at 2:52 AM, Rodrigo Siqueira
> <rodrigosiqueiramelo@gmail.com> wrote:
> > Hi,
> >
> > Today I looked at the AD2S1210 code and datasheet. As a result, I present here
> > the following work plan for discussion:
> >
> > 0) Checkpach free
> >
> > There are just two 'CHECKs' in this module. Fix it is easy.  
> 
> Great.
> 
> >
> > 1) Update the channels definition
> >
> > After a first read of the datasheet, I believe the AD2S1210 need an update to
> > the iio_chan_spec already defined and also requires another channel for
> > velocity. I am not 100% sure, but I also think that other channels have to be
> > defined because of this chip has many features (absolute position and velocity,
> > system fault detect, programmable sinusoidal, etc.); however, I prefer to keep
> > things simple now.
> >  
> 
> > 2) Events for handling error detections
> >
> > The AD2S1210 provide many fault detection thresholds. The chip triggers some
> > faults, and I believe the AD2S1210 module can handle it with events interface.
> > If I am right, I to start by adding LOS  handler.
> >
> > 3) Use IIO ABI
> >
> > From what I understood from the documentation, I believe the write using sysfs
> > interface is not right. The AD2S1210 module should use iio_info for this tasks
> > (even for read). If I am right, I want to fix it.
> >
> > Is my work plan to move AD2S1210 out of staging make sense?  
> 
> Yup. It does makes sense.
> 
> For the moment no need to add new features. We should just concentrate
> on supporting the existing functionality but with the standard IIO interface.

I second this.  New features really require hardware to test.  We
can probably assume the driver as is more or less works (presumably
test hardware was originally available).  Careful review should
prevent us breaking the driver - this isn't always true for new features
where even the most careful datasheet reading may not pick up on some
nuance.

The chip is moderately cheap and easy to get hold of.  Resolvers are
not.

I don't know if Michael or anyone else has test access to the relevant
parts.

Jonathan

> 
> >
> > Finally, I want to work on AD2S1210, but David Veenstra has priority on
> > this task because he already expressed his interest in working on
> > AD2S1210 and AD2S1200.  I proposed to him that we divided this task in
> > two: I work in the  AD2S1210 and him in the AD2S1200.
> >
> > Best regards,
> > Siqueira
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html  
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

