Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49246 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751136AbcFQUpd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 17 Jun 2016 16:45:33 -0400
Date: Fri, 17 Jun 2016 22:45:31 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
cc: jic23@kernel.org, benjamin.tissoires@redhat.com,
	linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, chaya.golan@intel.com,
	daniel.drubin@intel.com, A.Bhattacharya@ulg.ac.be
Subject: Re: [PATCH 2/6] hid: intel_ish-hid: ISH Transport layer
In-Reply-To: <alpine.LNX.2.00.1606172236520.6874@cbobk.fhfr.pm>
Message-ID: <alpine.LNX.2.00.1606172243590.6874@cbobk.fhfr.pm>
References: <1465647219-7798-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1465647219-7798-3-git-send-email-srinivas.pandruvada@linux.intel.com> <alpine.LNX.2.00.1606172236520.6874@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 17 Jun 2016, Jiri Kosina wrote:

> > +struct ishtp_cl_device *ishtp_bus_add_device(struct ishtp_device *dev,
> > +					     uuid_le uuid, char *name)
> > +{
> 
> Should be static.

Actually, going deeper into the code and trying to untangle all the 
dependencies, there are quite a few more in other ipc.c, hid-client.c, 
etc. Please fix that globally in the next iteration.

Thanks,

-- 
Jiri Kosina
SUSE Labs

