Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:48195 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933246AbbA1Ukn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 28 Jan 2015 15:40:43 -0500
Received: by mail-wi0-f181.google.com with SMTP id fb4so15218852wid.2
        for <linux-iio@vger.kernel.org>; Wed, 28 Jan 2015 12:40:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1420570433.4459.105.camel@spandruv-desktop.jf.intel.com>
References: <1419122556-8100-1-git-send-email-octavian.purdila@intel.com>
	<1419122556-8100-6-git-send-email-octavian.purdila@intel.com>
	<54A96870.1000206@kernel.org>
	<1420570433.4459.105.camel@spandruv-desktop.jf.intel.com>
Date: Wed, 28 Jan 2015 11:22:22 +0200
Message-ID: <CAE1zotKSo0yH96TcejmrrPbG=_vfBSN=dEWQJXkxg9H_QGLWjQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/11] iio: bmc150: refactor slope duration and
 threshold update
From: Octavian Purdila <octavian.purdila@intel.com>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Laurentiu Palcu <laurentiu.palcu@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Jan 6, 2015 at 8:53 PM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Sun, 2015-01-04 at 16:21 +0000, Jonathan Cameron wrote:
> > On 21/12/14 00:42, Octavian Purdila wrote:
> > > Move the slope duration and threshold update in separate functions
> > > to reduce code duplicate between chip init and motion interrupt setup.
> > >
> > > The patch also moves the update from the motion interrupt setup
> > > function to the write event function so that we can later refactor the
> > > interrupt code.
> > The side effect of this is that these will get updated at a different
> > point in time from before.  Previously these values would only get
> > updated when the event was enabled (or the trigger).  So to change
> > them a disable / enable cycle was needed. Now they happen the moment
> > they are relevant.
> >
> > I prefer the new option, but it is an ABI change (be it one most people
> > won't notice!)
> I did purposely this way.
> IMO when user is changing critical parameters he should disable and re
> enable to avoid undesirable side effects.
> We have similar situation in other  thermal drivers where user can
> change policy parameters. Initially we let them change while zone is
> enabled (system is armed), this led to undesirable side effects due to
> race conditions.
>

We already have a check that prevents the change while the event is
active. We could add a check for the data motion trigger as well, to
avoid the above scenario.

Alternatively I can rewrite the patch to keep the current behavior and
update the parameters when we enable the trigger.

Which one sounds better?
