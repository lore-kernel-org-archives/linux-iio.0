Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:43931 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585AbbAJRaP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 10 Jan 2015 12:30:15 -0500
Date: Sat, 10 Jan 2015 09:30:14 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Daniel Baluta <daniel.baluta@intel.com>, linux-iio@vger.kernel.org,
	rafael.j.wysocki@intel.com
Subject: Re: [PATCH] iio kmx61 / PM: Replace CONFIG_PM_RUNTIME with CONFIG_PM
Message-ID: <20150110173014.GA7488@kroah.com>
References: <1420796370-12158-1-git-send-email-daniel.baluta@intel.com>
 <54B0FFDB.1020402@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <54B0FFDB.1020402@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Jan 10, 2015 at 10:32:59AM +0000, Jonathan Cameron wrote:
> On 09/01/15 09:39, Daniel Baluta wrote:
> > After commit b2b49ccbdd54 (PM: Kconfig: Set PM_RUNTIME if PM_SLEEP is
> > selected) PM_RUNTIME is always set if PM is set, so #ifdef blocks
> > depending on CONFIG_PM_RUNTIME may now be changed to depend on
> > CONFIG_PM.
> > 
> > Replace CONFIG_PM_RUNTIME with CONFIG_PM everywhere under
> > drivers/iio/imu/kmx61.c
> > 
> > Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
> Thanks Daniel, glad you tracked this down.  I was wondering why
> the autobuilders were happy but it broke for Greg! (short memory
> sometimes, given that patch was only a month ago).
> 
> Greg, as my tree is currently behind the point where Rafael did the big
> patch series to fix this (and hence doesn't have the precursor patch)
> there are two obvious solutions - either I rebase, or you take
> this one patch directly as a merge fix.
> 
> Which would you prefer?

I can take this one on top of your tree if you ack it, that sould solve
the issue.

thanks,

greg k-h
