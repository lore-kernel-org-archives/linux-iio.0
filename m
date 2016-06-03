Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:27826 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750707AbcFCEBx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 3 Jun 2016 00:01:53 -0400
Message-ID: <1464926476.17438.13.camel@linux.intel.com>
Subject: Re: [RFC 0/4] Intel Integrated Sensor Hub Support (ISH)
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: Atri Bhattacharya <badshah400@aim.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Date: Thu, 02 Jun 2016 21:01:16 -0700
In-Reply-To: <1464922240.3161.2.camel@aim.com>
References: <1464668878-17113-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <1464788204.3917.9.camel@aim.com> <loom.20160602T052411-711@post.gmane.org>
	 <1464853729.2640.8.camel@aim.com>
	 <1464886187.3970.55.camel@linux.intel.com>
	 <1464896535.3470.4.camel@aim.com>
	 <1464897626.3970.60.camel@linux.intel.com>
	 <1464903962.3970.64.camel@intel.com> <1464906577.3007.2.camel@aim.com>
	 <1464907711.3970.70.camel@linux.intel.com>
	 <1464922240.3161.2.camel@aim.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 2016-06-03 at 04:50 +0200, Atri Bhattacharya wrote:
> On Thu, 2016-06-02 at 15:48 -0700, Srinivas Pandruvada wrote:
> > On Fri, 2016-06-03 at 00:29 +0200, Atri Bhattacharya wrote:
> > > Hi Srinivas,
> > > 
> > > On Thu, 2016-06-02 at 21:44 +0000, Pandruvada, Srinivas wrote:
> > > > 
> > > > On Thu, 2016-06-02 at 13:00 -0700, Srinivas Pandruvada wrote:
> > > > > 
> > > > > Hi,
> > > > > 
> > > > > Thanks for your help in evaluation.
> > > > > 
> > > > > 
> > > > > [...]
> > > > > 
> > > > > The iio sensor proxy starts too soon. So I recommended to
> > > > > wait
> > > > > for
> > > > > mult-user target before start. I think developer is
> > > > > considering.
> > > > > 
> > > > Add after "Description" in the section [Unit] in systemd unit
> > > > file
> > > > /usr/lib/systemd/system/iio-sensor-proxy.service
> > > > 
> > > > After=multi-user.target
> > > > 
> > > > Your rotation should work on Yoga 260. I tried on Fedora 23.
> > > > 
> > > It does! Thank you so much for this tip. Well, it doesn't work
> > > again
> > > after suspend/wakeup but I will let you know if that issue gets
> > > fixed
> > > after the patched kernel finishes building.
> > The problem is iio_proxy keeps open the IIO file handles, but ISH
> > FW
> > is
> > will powerup again after suspend, which causes issue. So may be by
> > systemd magic stop the service and start again on resume.
> > 
> > I am working on this. So probably in RFC v2, I will have some fix.
> > 
> 
> One thing I just noticed is that the iio device number change after a
> suspend/wakeup cycle. For e.g., immediately after booting the
> in_accel_?_raw files are located in the dir
> /sys/bus/iio/devices/iio\:device0/
> but after a suspend/wakeup the in_accel files have moved to
> /sys/bus/iio/devices/iio\:device3/
> instead. No idea if this is relevant or not, just thought I should
> let
> you know.
Yes. That will happen because the device will be removed and probed
again.

Thanks,
Srinivas


> 
> -- 
> Atri Bhattacharya
> Fri  3 Jun 04:47:15 CEST 2016
> 
> Sent from openSUSE Tumbleweed (20160531) (x86_64) on my laptop.
