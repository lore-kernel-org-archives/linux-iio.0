Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36495 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755319AbdBQEaO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Feb 2017 23:30:14 -0500
Received: by mail-pg0-f66.google.com with SMTP id a123so1012013pgc.3
        for <linux-iio@vger.kernel.org>; Thu, 16 Feb 2017 20:30:14 -0800 (PST)
Date: Thu, 16 Feb 2017 20:30:10 -0800
From: Alison Schofield <amsfield22@gmail.com>
To: Daniel Baluta <daniel.baluta@gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: Outreachy IIO - mentor wanted
Message-ID: <20170217043009.GA1943@d830.WORKGROUP>
References: <CAEnQRZBNC1bj75V0YN-Q0TPmGayzbQbQrvRW46hdfPWimTjNrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAEnQRZBNC1bj75V0YN-Q0TPmGayzbQbQrvRW46hdfPWimTjNrA@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Feb 16, 2017 at 03:24:03PM +0200, Daniel Baluta wrote:
> Hi all,
> 
> Does anyone want to mentor an intern for the Outreachy program?
> https://kernelnewbies.org/OutreachyIntro
> 
> IIO drivers are very good tasks for such an intern, I have been a mentor
> for the last 4 or 5 editions while working on:
> 
> * cleaning up drivers and moving them out of staging
> * enhancing the IIO dummy driver and moving it out of staging
> * creating drivers from scratch for simple devices
> 
> and it was a nice experience.
> 
> What a mentor should do?
> 
> In the pre-internship phase (14 February - 16 to March 30)
> 
> * review patches and guide applicants on how to find small kernel fixes
> * create small tasks for IIO [this can be mostly borrowed from last years] [1]
> * create a small description for the project and find a small
> device(s) for the project.
> 
> In the internship phase [ 3 months starting around May ]
> * help the intern with the setup and hardware
> * (bi)weekly meetings for guidance or just answer interns questions on email.
> * provide feedback to Outreachy on how the intern is doing.
> 
> Please let me know or Julia (Cc-ed) if you are interested.
> 
> The project doesn't necessary to be IIO related but it must be doable
> by a 3rd/4th
> year CS student with light kernel knowledge and good understanding of C.
> 
> thanks,
> Daniel.


I'd be interested in driving this but I don't have an actual project 
lined up to offer the applicants.  If someone has a project in mind
and wants to hand it off or co-mentor, let's chat.

I can do the tasks updates and have some small coding tasks queued
for the application period also.

As Daniel and I have experienced, working with the hardware is
the fun part for the intern, but getting the hardware can be a
challenge.  It would be good if you have a sensor in mind, that
you know is obtainable and the work will be applicable in the 
May-August timeframe.  That is - we don't want to plan for a sensor
and someone else submits support for it prior to the internship.

Other safer ideas (instead of brand new sensor) might be...
 - adding new features to an existing class of drivers where the
	intern may only need to verify it with one sensor. 
 - migrating another driver out of input/misc such as Eva is going
	right now with adxl345.
 - what else has been lingering on your todo/wish list ???

alisons

> 
> [1] https://kernelnewbies.org/IIO_tasks
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
