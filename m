Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47387 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751155AbbFGPTH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 7 Jun 2015 11:19:07 -0400
Message-ID: <556E1E03.1040106@kernel.org>
Date: Tue, 02 Jun 2015 22:20:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: "Brown, Len" <len.brown@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v1] hid-sensor: Fix suspend/resume delay
References: <1433201787-22290-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1433201787-22290-2-git-send-email-srinivas.pandruvada@linux.intel.com> <1A7043D5F58CCB44A599DFD55ED4C948468918E0@fmsmsx115.amr.corp.intel.com>
In-Reply-To: <1A7043D5F58CCB44A599DFD55ED4C948468918E0@fmsmsx115.amr.corp.intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/06/15 07:21, Brown, Len wrote:
> This regression increased the resume time on my Dell XPS11 laptop by 8 seconds.
> This patch makes that regression go away.
> 
> I assume that this is targeted for .stable?
> 
> thanks,
> Tested-by: Len Brown <len.brown@intel.com>
> 
Applied to the fixes-togreg branch of iio.git which will get pushed out
when I am back on a network.  Thanks for providing this number Len.
I've added a note to the commit to make it clear that the timing regression
was substantial and marked it for stable.

Thanks,

Jonathan
