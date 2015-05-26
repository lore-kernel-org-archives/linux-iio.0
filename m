Return-Path: <mwelling79@gmail.com>
Sender: Michael Welling <mwelling79@gmail.com>
Date: Tue, 26 May 2015 15:53:10 -0500
From: Michael Welling <mwelling@ieee.org>
To: Felipe Balbi <balbi@ti.com>
Cc: "Franklin Cooper Jr." <fcooper@ti.com>, dmitry.torokhov@gmail.com,
	vigneshr@ti.com, bgriffis@ti.com, jic23@kernel.org,
	wsa@the-dreams.de, linux-input@vger.kernel.org,
	GWilson@sakuraus.com, linux-iio@vger.kernel.org
Subject: Re: AM335x touchscreen issues
Message-ID: <20150526205310.GA2104@deathray>
References: <20150526181157.GA8009@deathray>
 <20150526183713.GU26599@saruman.tx.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150526183713.GU26599@saruman.tx.rr.com>
List-ID: <linux-iio@vger.kernel.org>

On Tue, May 26, 2015 at 01:37:13PM -0500, Felipe Balbi wrote:
> Hi,
> 
> On Tue, May 26, 2015 at 01:11:57PM -0500, Michael Welling wrote:
> > Greetings,
> > 
> > I have been porting Linux to a new AM3554 based SoM and have found issues
> > with the touchscreen reporting touch releases repeatedly to userspace
> > without actually touching the screen when running ts_calibrate, ts_test
> > or other graphical touchscreen applications.
> > 
> > This started happening after updating pulling recent changes.
> 
> Can you bisect and find the offending commit ? Which recent changes are
> you talking about ?

Sorry that it took so long to find the offending commit, it appears that
the issue occurs on my 4.3" display but not on my 7" display. I first
performed the git bisect on the 7" display which ended up being fruitless.

Then I switched over the the 4.3" display and found the commit which starts
having the issue.

michael@deathray:~/projects/linux/linux-torvalds$ git bisect start HEAD v3.18 -- drivers/input/touchscreen/ti_am335x_tsc.c
.
.
michael@deathray:~/projects/linux/linux-torvalds$ git bisect bad
344d635b9a41b19837ccf8083a99ea688027019c is the first bad commit
commit 344d635b9a41b19837ccf8083a99ea688027019c
Author: Brad Griffis <bgriffis@ti.com>
Date:   Tue Feb 3 11:44:12 2015 -0800

    Input: ti_am335x_tsc - remove udelay in interrupt handler
    
    TSC interrupt handler had udelay to avoid reporting of false pen-up
    interrupt to user space. This patch implements workaround suggesting in
    Advisory 1.0.31 of silicon errata for am335x, thus eliminating udelay and
    touchscreen lag. This also improves performance of touchscreen and
    eliminates sudden jump of cursor at touch release.
    
    IDLECONFIG and CHARGECONFIG registers are to be configured with same values
    in order to eliminate false pen-up events. This workaround may result in
    false pen-down to be detected, hence considerable charge step delay needs
    to be added. The charge delay is set to 0xB000 (in terms of ADC clock
    cycles) by default.
    
    TSC steps are disabled at the end of every sampling cycle and EOS bit is
    set. Once the EOS bit is set, the TSC steps need to be re-enabled to begin
    next sampling cycle.
    
    Signed-off-by: Brad Griffis <bgriffis@ti.com>
    [vigneshr@ti.com: Ported the patch from v3.12 to v3.19rc1]
    Signed-off-by: Vignesh R <vigneshr@ti.com>
    Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hope this sheds some light.

> 
> > It has also been confirmed to be happening on the beagle bone black:
> > http://www.spinics.net/lists/linux-iio/msg18580.html
> > 
> > If you look further into this thread you will see a workaround patch that
> > I came up with:
> > http://www.spinics.net/lists/linux-iio/msg18583.html
> > 
> > Though this fix stops the reported events in userspace, interrupts are
> > still occuring repeatedly.
> > 
> > Does anyone have any suggestions beyond what I have done to remedy this
> > issue?
> 
> yeah, it sounds similar to what Franklin has been working on.
> 
> Franklin, any comments ?
> 
> -- 
> balbi
