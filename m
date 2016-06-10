Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:53426 "EHLO
	slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932188AbcFJObe (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 10 Jun 2016 10:31:34 -0400
Message-ID: <1465568791.7409.38.camel@hadess.net>
Subject: Re: [RFC 0/4] Intel Integrated Sensor Hub Support (ISH)
From: Bastien Nocera <hadess@hadess.net>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Grant Likely <grant.likely@secretlab.ca>
Cc: Jiri Kosina <jikos@kernel.org>, benjamin.tissoires@redhat.com,
	Jonathan Cameron <jic23@kernel.org>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	linux-iio@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	chaya.golan@intel.com, daniel.drubin@intel.com,
	Darren Hart <darren@dvhart.com>
Date: Fri, 10 Jun 2016 16:26:31 +0200
In-Reply-To: <1465566904.10525.11.camel@linux.intel.com>
References: <1464668878-17113-1-git-send-email-srinivas.pandruvada@linux.intel.com>	
	 <CACxGe6udQ9H5_OBg+h8BB4Bru5Air0LYxtGQkUvr91ebtUE+SA@mail.gmail.com>	
	 <1465509287.24319.3.camel@linux.intel.com>	
	 <CACxGe6vq-FDpjG8WtrraveQo+ZT3MHMDFzrA5-qqNLEwcbmNhw@mail.gmail.com>
	 <1465566904.10525.11.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 2016-06-10 at 06:55 -0700, Srinivas Pandruvada wrote:
> On Fri, 2016-06-10 at 10:44 +0100, Grant Likely wrote:
> [...]
> > 
> > Yes, I do see the in_*_raw_* files in sysfs, and I'm able to get
> > data
> > out of them. Gnome also seems to recognize that the accelerometers
> > are
> > there because it adds a rotation lock button to the system menu.
> > 
> > However, the events are getting through yet. It may be that I'm
> > missing something in my kernel config. I'm rebuilding the kernel
> > with
> > Debian's config for the 4.5.5 kernel as a quick sanity test. I'll
> > report back when I've tried.
> > 
> You need to add in /usr/lib/system/systemd/iio-sensor-*
> 
> After=multi-user.target
> 
> 
> This service starts too early.

Nobody has been able to explain to me why that would be a problem.

Can you back this up with some data? Does iio-sensor-proxy exit too
early? Does that leave time to the IIO sub-system to do some init work
it should already have done?

See also https://github.com/hadess/iio-sensor-proxy/issues/82

> > I'll also take some time and review the patch series later this
> > afternoon.
> 
> Atri Bhattacharya reported issues with suspend/resume. With my test
> patches it is fixed for him
> 
> If you want to hold on, I will repost with fixes for susend/resume.

