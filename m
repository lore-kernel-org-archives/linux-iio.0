Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:37373 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757312AbaKTKGy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 20 Nov 2014 05:06:54 -0500
Date: Thu, 20 Nov 2014 12:07:47 +0200
From: Vlad Dogaru <vlad.dogaru@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	mranostay@gmail.com
Subject: Re: [PATCH 0/2] iio: driver for Semtech SX9500
Message-ID: <20141120100747.GJ6904@vdogaru>
References: <1416237169-10707-1-git-send-email-vlad.dogaru@intel.com>
 <alpine.DEB.2.02.1411171622140.3424@pmeerw.net>
 <546BC201.10405@kernel.org>
 <546BC450.7000000@kernel.org>
 <20141119135738.GG6904@vdogaru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141119135738.GG6904@vdogaru>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Nov 19, 2014 at 03:57:38PM +0200, Vlad Dogaru wrote:
> On Tue, Nov 18, 2014 at 10:12:32PM +0000, Jonathan Cameron wrote:
> > On 18/11/14 22:02, Jonathan Cameron wrote:
> > > On 17/11/14 15:25, Peter Meerwald wrote:
> > >>
> > >>> The device does not estimate distance, it only outputs a single bit which
> > >>> indicates proximity.  We use 0 to mean that an object is close and 1 otherwise,
> > >>> sort of an uncalibrated distance.  From what I understand in the ABI
> > >>> specification, this is allowed.
> > >>
> > >> perhaps the input subsystem would be a better fit for this driver/device?
> > >> what is it typically used for?
> 
> We have this part listed under "proximity sensors", so I thought it
> belongs in iio.  We don't have a device that actually uses the SX9500,
> I'm using an evaluation board and an I2C bridge right now :)
> 
> > > Whilst it may be the case that this particular one might have a reasonable
> > > home in input, these are often integrated with ambient light sensors
> > > and as such we already have a quite a few proximity sensors in IIO...
> > > 
> > > Interestingly there is one obvious proximity sensor in input and that
> > > is a dual ambient light/ proximity part though I can't see any way
> > > of reading the light side of it.  Interesting...
> > Note that, given it describes itself as a button trip I can entirely see
> > your point with this one!  I wrote my reply before opening the datasheet.
> > oops.
> > 
> > The device does seem to provide access to measurements related to
> > the capacitance sensed so might be rather more flexible than just
> > a button though.
> 
> I kept away from the measurements because they look like uncalibrated
> information.  Then again, so is "0/1", as I mentioned initially.

To add to this:  the device senses proximity, not just touch.  I figured
it would be used in mobile devices, e.g. for shutting off the screen
when talking on the phone.  Moreover, Android supports proximity sensors
that only report "near/far" values.

> Would you find it acceptable to expose the raw measures through
> in_priximity0_raw, and keep the events as they are?  That way the raw
> readings can give some basic indication of distance, while still being
> able to use the events for near/far notification.
