Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:19059 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751280AbcL3Qxy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 30 Dec 2016 11:53:54 -0500
Message-ID: <1483116610.27585.51.camel@linux.intel.com>
Subject: Re: sensor-hub: Move the memset to sensor_hub_get_feature()
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rrs@researchut.com, linux-iio <linux-iio@vger.kernel.org>
Date: Fri, 30 Dec 2016 08:50:10 -0800
In-Reply-To: <1483094837.11693.3.camel@researchut.com>
References: <1482925101.8484.1.camel@researchut.com>
         <1482931381.8484.3.camel@researchut.com>
         <1482943685.4497.19.camel@linux.intel.com>
         <1482945855.8484.8.camel@researchut.com>
         <1482946633.12558.1.camel@researchut.com>
         <1482947598.21657.1.camel@researchut.com>
         <1483032127.27585.13.camel@linux.intel.com>
         <1483032694.3173.3.camel@researchut.com>
         <1483094837.11693.3.camel@researchut.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 2016-12-30 at 16:17 +0530, Ritesh Raj Sarraf wrote:
> Hello Srini,
> 
> On Thu, 2016-12-29 at 23:01 +0530, Ritesh Raj Sarraf wrote:
> > 
> > On Thu, 2016-12-29 at 09:22 -0800, Srinivas Pandruvada wrote:
> > > 
> > > > 
> > > > If you need more information, please tell me.
> > > I tried on couple of systems with the patch. It seems to fix the
> > > issue.
> > > It is possible some low level power related changes have impacted
> > > this.
> > > Can you do bisect? I suggest just try 4.9-rc1. I think it will
> > > not work
> > > there probably.
> > Okay. Let me do a bisect on it. I'll ping back on this thread soon.
> Since yesterday's attempts, I haven't been able to reproduce the bug
> again, so
> far. Apart from re-building the kernel, I have also blacklisted the
> particular
> USB device from power savings (based on your hint). I don't know if
> disabling
> the power savings for that USB device is the cause for not seeing the
> issue, but
> so far, the device seems to report data.
> 
> Do you think power savings mode can impact these devices ? I know of
> USB plugged
> keyboard/mice to generally break, when enabling power savings mode.
> But I had
> hoped that in-built USB devices were immune to it.
> 
This is possible. If your remove from blacklist does it still work? May
be rebuild of kernel fixed this:-) 

Thanks,
Srinivas

> Thanks,
> Ritesh
> 
