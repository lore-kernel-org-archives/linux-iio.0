Return-Path: <jkosina@suse.cz>
Date: Tue, 17 Feb 2015 13:39:06 +0100 (CET)
From: Jiri Kosina <jkosina@suse.cz>
To: Jonathan Cameron <jic23@kernel.org>
cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
    linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
    borneo.antonio@gmail.com
Subject: Re: [PATCH v2 1/2] HID: hid-sensor-hub: Enhance get feature report
 API
In-Reply-To: <54CE018F.9010600@kernel.org>
Message-ID: <alpine.LNX.2.00.1502171338390.2279@pobox.suse.cz>
References: <1421455165-3944-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1421455165-3944-2-git-send-email-srinivas.pandruvada@linux.intel.com> <54CE018F.9010600@kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

On Sun, 1 Feb 2015, Jonathan Cameron wrote:

> On 17/01/15 00:39, Srinivas Pandruvada wrote:
> > Some hid sensor feature report can contain more than one reports.
> > This API can now support receiving multiple values from the feature
> > report.
> > Also update the parameters in the users of this API.
> > 
> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Oops, commented on old version.
> Acked-by: Jonathan Cameron <jic23@kernel.org>

I don't seem to have been CCed on v2 submission of this series. Srinivas, 
could you please resend to me with Jonathan's ack added?

-- 
Jiri Kosina
SUSE Labs
