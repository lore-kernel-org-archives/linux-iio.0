Return-Path: <srinivas.pandruvada@linux.intel.com>
Message-ID: <1424189936.2136.294.camel@spandruv-DESK3.jf.intel.com>
Subject: Re: [PATCH v2 1/2] HID: hid-sensor-hub: Enhance get feature report
 API
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: Jiri Kosina <jkosina@suse.cz>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org, borneo.antonio@gmail.com
Date: Tue, 17 Feb 2015 08:18:56 -0800
In-Reply-To: <alpine.LNX.2.00.1502171338390.2279@pobox.suse.cz>
References: 
	<1421455165-3944-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <1421455165-3944-2-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <54CE018F.9010600@kernel.org>
	 <alpine.LNX.2.00.1502171338390.2279@pobox.suse.cz>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Hi Jiri,
On Tue, 2015-02-17 at 13:39 +0100, Jiri Kosina wrote: 
> On Sun, 1 Feb 2015, Jonathan Cameron wrote:
> 
> > On 17/01/15 00:39, Srinivas Pandruvada wrote:
> > > Some hid sensor feature report can contain more than one reports.
> > > This API can now support receiving multiple values from the feature
> > > report.
> > > Also update the parameters in the users of this API.
> > > 
> > > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Oops, commented on old version.
> > Acked-by: Jonathan Cameron <jic23@kernel.org>
> 
> I don't seem to have been CCed on v2 submission of this series. Srinivas, 
> could you please resend to me with Jonathan's ack added?
I will resend by addressing comments and adding ack.

Thanks,
Srinivas

> 
> -- 
> Jiri Kosina
> SUSE Labs
