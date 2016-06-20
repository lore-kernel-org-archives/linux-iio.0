Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50026 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752569AbcFTJ3b (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 20 Jun 2016 05:29:31 -0400
Date: Mon, 20 Jun 2016 11:29:28 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
cc: jic23@kernel.org, benjamin.tissoires@redhat.com,
	linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, chaya.golan@intel.com,
	daniel.drubin@intel.com, A.Bhattacharya@ulg.ac.be
Subject: Re: [PATCH 2/6] hid: intel_ish-hid: ISH Transport layer
In-Reply-To: <1466197963.24319.110.camel@linux.intel.com>
Message-ID: <alpine.LNX.2.00.1606201129060.6874@cbobk.fhfr.pm>
References: <1465647219-7798-1-git-send-email-srinivas.pandruvada@linux.intel.com>  <1465647219-7798-3-git-send-email-srinivas.pandruvada@linux.intel.com>  <alpine.LNX.2.00.1606172236520.6874@cbobk.fhfr.pm> <1466197963.24319.110.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 17 Jun 2016, Srinivas Pandruvada wrote:

> > > +config INTEL_ISH_HID_TRANSPORT
> > > +     bool
> > > +     default n
> > > +
> > > +config INTEL_ISH_HID
> > > +     bool "Intel Integrated Sensor Hub"
> > 
> > Why can't the transport driver be built as a module?
> In current use case for PM, we don't want anyone to unload and
> complain.

Sorry, I don't understand this explanation, could you please elaborate?

Thanks,

-- 
Jiri Kosina
SUSE Labs

