Return-Path: <jkosina@suse.cz>
Date: Mon, 17 Feb 2014 15:10:22 +0100 (CET)
From: Jiri Kosina <jkosina@suse.cz>
To: Jonathan Cameron <jic23@kernel.org>
cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
    linux-iio@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: hid-sensor-hub: Remove hard coded indexes
In-Reply-To: <52F619C9.8060701@kernel.org>
Message-ID: <alpine.LNX.2.00.1402171509530.1192@pobox.suse.cz>
References: <1390531822-7640-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1390531822-7640-2-git-send-email-srinivas.pandruvada@linux.intel.com> <alpine.LNX.2.00.1401291412230.21385@pobox.suse.cz> <52F619C9.8060701@kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

On Sat, 8 Feb 2014, Jonathan Cameron wrote:

> > > Remove the hard coded indexes, instead search for usage id and
> > > use the index to set the power and report state.
> > > This will fix issue, where the report descriptor doesn't contain
> > > the full list of possible selector for power and report state.
> > > 
> > > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Acked-by: Jonathan Cameron <jic23@kernel.org>
> > 
> > Jonathan, I'd probably take this together with the patch for HID API
> > change. Could you please provide your Ack/Signoff, and I'll take it
> > through my tree, if you agree?
> Agreed. Help yourself ;)

Thanks! Now applied.

> Thanks and sorry for the slow response.  Amazing the backlog that builds
> up if you take about 3 weeks out (more or less)

Yeah, it basically immediately destroys all the energy you gained during 
the time off :)

-- 
Jiri Kosina
SUSE Labs
