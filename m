Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from omr-a008e.mx.aol.com ([204.29.186.51]:53994 "EHLO
	omr-a008e.mx.aol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932337AbcFBWaF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 2 Jun 2016 18:30:05 -0400
Message-ID: <1464906577.3007.2.camel@aim.com>
Subject: Re: [RFC 0/4] Intel Integrated Sensor Hub Support (ISH)
From: Atri Bhattacharya <badshah400@aim.com>
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Date: Fri, 03 Jun 2016 00:29:37 +0200
In-Reply-To: <1464903962.3970.64.camel@intel.com>
References: <1464668878-17113-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <1464788204.3917.9.camel@aim.com>
	 <loom.20160602T052411-711@post.gmane.org>
	 <1464853729.2640.8.camel@aim.com>
	 <1464886187.3970.55.camel@linux.intel.com>
	 <1464896535.3470.4.camel@aim.com>
	 <1464897626.3970.60.camel@linux.intel.com>
	 <1464903962.3970.64.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Srinivas,

On Thu, 2016-06-02 at 21:44 +0000, Pandruvada, Srinivas wrote:
> On Thu, 2016-06-02 at 13:00 -0700, Srinivas Pandruvada wrote:
> > Hi,
> > 
> > Thanks for your help in evaluation.
> > 
> > 
> > [...]
> 
> > The iio sensor proxy starts too soon. So I recommended to wait for
> > mult-user target before start. I think developer is considering.
> > 
> Add after "Description" in the section [Unit] in systemd unit file
> /usr/lib/systemd/system/iio-sensor-proxy.service
> 
> After=multi-user.target
> 
> Your rotation should work on Yoga 260. I tried on Fedora 23.
> 

It does! Thank you so much for this tip. Well, it doesn't work again
after suspend/wakeup but I will let you know if that issue gets fixed
after the patched kernel finishes building.

Best wishes.
-- 
Atri Bhattacharya
Fri  3 Jun 00:27:09 CEST 2016

Sent from openSUSE Tumbleweed (20160531) (x86_64) on my laptop.
