Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:38306 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759441AbbA1UlY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 28 Jan 2015 15:41:24 -0500
Message-ID: <1422465317.2136.12.camel@spandruv-DESK3.jf.intel.com>
Subject: Re: [PATCH v2 05/11] iio: bmc150: refactor slope duration and
 threshold update
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: Octavian Purdila <octavian.purdila@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Laurentiu Palcu <laurentiu.palcu@intel.com>
Date: Wed, 28 Jan 2015 09:15:17 -0800
In-Reply-To: <CAE1zotKSo0yH96TcejmrrPbG=_vfBSN=dEWQJXkxg9H_QGLWjQ@mail.gmail.com>
References: <1419122556-8100-1-git-send-email-octavian.purdila@intel.com>
	 <1419122556-8100-6-git-send-email-octavian.purdila@intel.com>
	 <54A96870.1000206@kernel.org>
	 <1420570433.4459.105.camel@spandruv-desktop.jf.intel.com>
	 <CAE1zotKSo0yH96TcejmrrPbG=_vfBSN=dEWQJXkxg9H_QGLWjQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 2015-01-28 at 11:22 +0200, Octavian Purdila wrote: 
> On Tue, Jan 6, 2015 at 8:53 PM, Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> >
> > On Sun, 2015-01-04 at 16:21 +0000, Jonathan Cameron wrote:
> > > On 21/12/14 00:42, Octavian Purdila wrote:
> > > > Move the slope duration and threshold update in separate functions
> > > > to reduce code duplicate between chip init and motion interrupt setup.
> > > >
> > > > The patch also moves the update from the motion interrupt setup
> > > > function to the write event function so that we can later refactor the
> > > > interrupt code.
> > > The side effect of this is that these will get updated at a different
> > > point in time from before.  Previously these values would only get
> > > updated when the event was enabled (or the trigger).  So to change
> > > them a disable / enable cycle was needed. Now they happen the moment
> > > they are relevant.
> > >
> > > I prefer the new option, but it is an ABI change (be it one most people
> > > won't notice!)
> > I did purposely this way.
> > IMO when user is changing critical parameters he should disable and re
> > enable to avoid undesirable side effects.
> > We have similar situation in other  thermal drivers where user can
> > change policy parameters. Initially we let them change while zone is
> > enabled (system is armed), this led to undesirable side effects due to
> > race conditions.
> >
> 
> We already have a check that prevents the change while the event is
> active. We could add a check for the data motion trigger as well, to
> avoid the above scenario.
> 
> Alternatively I can rewrite the patch to keep the current behavior and
> update the parameters when we enable the trigger.
> 
> Which one sounds better?
I prefer the second option.

Thanks,
Srinivas


