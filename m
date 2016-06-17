Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:50319 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750725AbcFQVHc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 17 Jun 2016 17:07:32 -0400
Message-ID: <1466197745.24319.106.camel@linux.intel.com>
Subject: Re: [PATCH 2/6] hid: intel_ish-hid: ISH Transport layer
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: Jiri Kosina <jikos@kernel.org>
Cc: jic23@kernel.org, benjamin.tissoires@redhat.com,
	linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, chaya.golan@intel.com,
	daniel.drubin@intel.com, A.Bhattacharya@ulg.ac.be
Date: Fri, 17 Jun 2016 14:09:05 -0700
In-Reply-To: <alpine.LNX.2.00.1606172243590.6874@cbobk.fhfr.pm>
References: <1465647219-7798-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <1465647219-7798-3-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <alpine.LNX.2.00.1606172236520.6874@cbobk.fhfr.pm>
	 <alpine.LNX.2.00.1606172243590.6874@cbobk.fhfr.pm>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 2016-06-17 at 22:45 +0200, Jiri Kosina wrote:
> On Fri, 17 Jun 2016, Jiri Kosina wrote:
> 
> > > +struct ishtp_cl_device *ishtp_bus_add_device(struct ishtp_device
> *dev,
> > > +                                        uuid_le uuid, char
> *name)
> > > +{
> > 
> > Should be static.
> 
> Actually, going deeper into the code and trying to untangle all the 
> dependencies, there are quite a few more in other ipc.c, hid-
> client.c, 
> etc. Please fix that globally in the next iteration.
> 
Great. I ran sparse and identified few more. I will fix this is new
iteration.

One thing I am still wondering is that the current ISH model is built
in only. Some distros configure CONFIG_HID as module. So in Kconfig in 
drivers/hid/intel-ish-hid/, I need to add "select HID".
What do you think about this?

Unless you are in middle of review, I want to go ahead and send v2.


Thanks,
Srinivas

> Thanks,
> 
> -- 
> Jiri Kosina
> SUSE Labs
> 
