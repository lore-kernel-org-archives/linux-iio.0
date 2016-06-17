Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48948 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750725AbcFQUnr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 17 Jun 2016 16:43:47 -0400
Date: Fri, 17 Jun 2016 22:43:43 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
cc: jic23@kernel.org, benjamin.tissoires@redhat.com,
	linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, chaya.golan@intel.com,
	daniel.drubin@intel.com, A.Bhattacharya@ulg.ac.be
Subject: Re: [PATCH 1/6] Documentation: hid: Intel ISH HID document
In-Reply-To: <1465647219-7798-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Message-ID: <alpine.LNX.2.00.1606172241480.6874@cbobk.fhfr.pm>
References: <1465647219-7798-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1465647219-7798-2-git-send-email-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 11 Jun 2016, Srinivas Pandruvada wrote:

> Document explaining ISH HID operation and implementation.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  Documentation/hid/intel-ish-hid.txt | 417 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 417 insertions(+)
>  create mode 100644 Documentation/hid/intel-ish-hid.txt
> 
> diff --git a/Documentation/hid/intel-ish-hid.txt b/Documentation/hid/intel-ish-hid.txt
> new file mode 100644
> index 0000000..2de0ab5
> --- /dev/null
> +++ b/Documentation/hid/intel-ish-hid.txt
> @@ -0,0 +1,417 @@
> +Intel Integrated Sensor Hub (ISH)
> +===============================
> +
> +A sensor hub enables the ability to offload sensor polling and algorithm
> +processing to a dedicated low power co-processor. This allows the core
> +processor to go into low power modes more often, resulting in the increased
> +battery life.
[ ... snip ... ]

What I would like to see added here is a bit more of a higher-level 
overview of the implementation.

It's a *lot* of new code. I am still trying to make my way through it. One 
thing that I am currently trying to figure out, and which, if documented, 
would be much easier to review, would be: my current understanding is that 
this is both transport (ll) driver and a kind-of a bus at the same time.

Could yo please put some more comprehensive overview of the overall 
architecture into the documentation?

Thanks,

-- 
Jiri Kosina
SUSE Labs

