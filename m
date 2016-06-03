Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:4376 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750707AbcFCECh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 3 Jun 2016 00:02:37 -0400
Message-ID: <1464926523.17438.14.camel@linux.intel.com>
Subject: Re: [RFC 0/4] Intel Integrated Sensor Hub Support (ISH)
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: Atri Bhattacharya <badshah400@aim.com>,
	linux-iio <linux-iio@vger.kernel.org>
Date: Thu, 02 Jun 2016 21:02:03 -0700
In-Reply-To: <1464923314.3200.3.camel@aim.com>
References: <1464668878-17113-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <1464788204.3917.9.camel@aim.com> <loom.20160602T052411-711@post.gmane.org>
	 <1464853729.2640.8.camel@aim.com>
	 <1464886187.3970.55.camel@linux.intel.com>
	 <1464896535.3470.4.camel@aim.com>
	 <1464897626.3970.60.camel@linux.intel.com>
	 <1464923314.3200.3.camel@aim.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 2016-06-03 at 05:08 +0200, Atri Bhattacharya wrote:
> On Thu, 2016-06-02 at 13:00 -0700, Srinivas Pandruvada wrote:
> >  
> > I see. Can you add the following change and try?
> > diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> > b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> > index e4d00d2..f241e1f 100644
> > --- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> > +++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> > @@ -199,6 +199,7 @@ static int ish_resume(struct device *device)
> >         struct ishtp_device *dev = pci_get_drvdata(pdev);
> >  
> >         disable_irq_wake(pdev->irq);
> > +       ish_hw_start(dev);
> >         ishtp_send_resume(dev);
> >         dev->suspend_flag = 0;
> > 
> > 
> > 
> 
> This patch causes a kernel crash reliably when trying to wakeup from
> suspending laptop a second time during a single boot session. Journal
> logs attached. 
Thanks. I have addressed this.

-Srinivas

> 
> -- 
> Atri Bhattacharya
> Fri  3 Jun 05:01:36 CEST 2016
> 
> Sent from openSUSE Tumbleweed (20160531) (x86_64) on my laptop.
