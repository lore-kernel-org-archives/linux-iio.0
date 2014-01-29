Return-Path: <jkosina@suse.cz>
Date: Wed, 29 Jan 2014 14:13:05 +0100 (CET)
From: Jiri Kosina <jkosina@suse.cz>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
cc: jic23@kernel.org, linux-iio@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: hid-sensor-hub: Remove hard coded indexes
In-Reply-To: <1390531822-7640-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Message-ID: <alpine.LNX.2.00.1401291412230.21385@pobox.suse.cz>
References: <1390531822-7640-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1390531822-7640-2-git-send-email-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

On Thu, 23 Jan 2014, Srinivas Pandruvada wrote:

> Remove the hard coded indexes, instead search for usage id and
> use the index to set the power and report state.
> This will fix issue, where the report descriptor doesn't contain
> the full list of possible selector for power and report state.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Jonathan, I'd probably take this together with the patch for HID API 
change. Could you please provide your Ack/Signoff, and I'll take it 
through my tree, if you agree?

Thanks.

-- 
Jiri Kosina
SUSE Labs
