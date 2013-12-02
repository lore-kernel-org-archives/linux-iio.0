Return-Path: <jkosina@suse.cz>
Date: Mon, 2 Dec 2013 14:08:49 +0100 (CET)
From: Jiri Kosina <jkosina@suse.cz>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] HID: hid-sensor-hub: Add logical min and max
In-Reply-To: <5299CCAA.6090100@kernel.org>
Message-ID: <alpine.LNX.2.00.1312021408290.24931@pobox.suse.cz>
References: <1385590783-27604-1-git-send-email-srinivas.pandruvada@linux.intel.com> <5299CCAA.6090100@kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

On Sat, 30 Nov 2013, Jonathan Cameron wrote:

> On 11/27/13 22:19, Srinivas Pandruvada wrote:
> > Exporting logical minimum and maximum of HID fields as part of the
> > hid sensor attribute info. This can be used for range checking and
> > to calculate enumeration base for NAry fields of HID sensor hub.
> > 
> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Hi,  I would have preffred this being done in two patches, the first
> refactoring the function call and the second doing the min and max.
> 
> Anyhow, I'll take it anyway.
> 
> Applied to the togreg branch of iio.git.

Where is that? I don't seem to see it in 

	https://git.kernel.org/cgit/linux/kernel/git/jic23/iio.git/log/?h=togreg

-- 
Jiri Kosina
SUSE Labs
