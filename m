Return-Path: <jkosina@suse.cz>
Date: Wed, 5 Sep 2012 11:37:31 +0200 (CEST)
From: Jiri Kosina <jkosina@suse.cz>
To: srinivas pandruvada <srinivas.pandruvada@intel.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org
Subject: Re: [PATCH 2/9] HID-Sensors: Documentation
In-Reply-To: <1346082597-768-3-git-send-email-srinivas.pandruvada@intel.com>
Message-ID: <alpine.LNX.2.00.1209051136560.11079@pobox.suse.cz>
References: <1346082597-768-1-git-send-email-srinivas.pandruvada@intel.com> <1346082597-768-3-git-send-email-srinivas.pandruvada@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

On Mon, 27 Aug 2012, srinivas pandruvada wrote:

[ ... snip ... ]
> +Core driver Interface
> +=====================
> +
> +Callback structure:
> +Each processing driver can use this structure to set some callbacks.
> +	int (*suspend)(..): Callback when HID suspend is received
> +	int (*resume)(..): Callback when HID resume is received
> +	int (*capture_sample)(..): Capture a sample for one of its data fields
> +	int (*send_event)(..): One complete event is received which can have
> +                               multiple data fields.

You definitely should mention here that this callback is not allowed to 
sleep.

-- 
Jiri Kosina
SUSE Labs
