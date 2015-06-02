Return-Path: <len.brown@intel.com>
From: "Brown, Len" <len.brown@intel.com>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"jic23@kernel.org" <jic23@kernel.org>
CC: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
Subject: RE: [PATCH v1] hid-sensor: Fix suspend/resume delay
Date: Tue, 2 Jun 2015 06:21:55 +0000
Message-ID: <1A7043D5F58CCB44A599DFD55ED4C948468918E0@fmsmsx115.amr.corp.intel.com>
References: <1433201787-22290-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <1433201787-22290-2-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1433201787-22290-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

This regression increased the resume time on my Dell XPS11 laptop by 8 seco=
nds.
This patch makes that regression go away.

I assume that this is targeted for .stable?

thanks,
Tested-by: Len Brown <len.brown@intel.com>
