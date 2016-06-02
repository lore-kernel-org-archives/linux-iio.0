Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:23992 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752997AbcFBT6r (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 2 Jun 2016 15:58:47 -0400
Message-ID: <1464897626.3970.60.camel@linux.intel.com>
Subject: Re: [RFC 0/4] Intel Integrated Sensor Hub Support (ISH)
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: Atri Bhattacharya <badshah400@aim.com>,
	linux-iio <linux-iio@vger.kernel.org>
Date: Thu, 02 Jun 2016 13:00:26 -0700
In-Reply-To: <1464896535.3470.4.camel@aim.com>
References: <1464668878-17113-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <1464788204.3917.9.camel@aim.com> <loom.20160602T052411-711@post.gmane.org>
	 <1464853729.2640.8.camel@aim.com>
	 <1464886187.3970.55.camel@linux.intel.com>
	 <1464896535.3470.4.camel@aim.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

Thanks for your help in evaluation.

On Thu, 2016-06-02 at 21:42 +0200, Atri Bhattacharya wrote:
> Hi Srinivas,

> 
> On Thu, 2016-06-02 at 09:49 -0700, Srinivas Pandruvada wrote:
> > 
> > Hi,
> > On Thu, 2016-06-02 at 09:48 +0200, Atri Bhattacharya wrote:
> > > 
> > > On Thu, 2016-06-02 at 03:27 +0000, Srinivas Pandruvada wrote:
> > > > 
> > > > 
> > > > Atri Bhattacharya <badshah400@...> writes:
> > > > 
> > > > > 
> > > > > 
> > > > >  
> > [...]
> > > 
> > > > 
> > > > > 
> > > > > +
> > > >  #include <linux/device.h>
> > > >  #include <linux/hid.h>
> > > >  #include <linux/module.h>
> > > > @@ -798,6 +799,9 @@ static const struct hid_device_id
> > > > sensor_hub_devices[] = 
> > > > {
> > > >         { HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB,
> > > > USB_VENDOR_ID_ITE,
> > > >                         USB_DEVICE_ID_ITE_LENOVO_YOGA900),
> > > >                         .driver_data =
> > > > HID_SENSOR_HUB_ENUM_QUIRK},
> > > > +       { HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB, 
> > > > USB_VENDOR_ID_INTEL_0,
> > > > +                       0x22D8),
> > > > +                       .driver_data =
> > > > HID_SENSOR_HUB_ENUM_QUIRK},
> > > >         { HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB,
> > > > HID_ANY_ID,
> > > >                      HID_ANY_ID) },
> > > >         { }
> > > > 
> > > > 
> > > Thanks for your response, but this patch didn't help with the
> > > slow
> > > suspend/wakeup problem or with making the device actually respond
> > > to
> > > rotation or brightness changes. At this stage the sensor-hub
> > > seems
> > > to
> > > be recognised just fine, but not to be working. Same messages as
> > > above
> > > continue to show up in the journal.
> > > 
> > Looks like the system resume is getting timed out. I am looking at
> > possible issue on Yoga 260.
> > Meanwhile can you try:
> > - Raw reads (cat /sys/bus/iio/devices/iio:device (your device
> >  index)/in_accel_?_raw
> There are two sets of results:
> 
> 1. After a reboot but before suspend/wakeup
> 
> ~> for i in {1..5}; do printf "%d " `cat
> /sys/bus/iio/devices/iio\:device3/in_accel_?_raw`; echo; sleep 1;
> done
> 25684 -1033593 -456933 
> -347362 -1014062 -367090 
> -919628 -281640 -167871 
> -898143 278906 15722 
> -648143 683203 123144
> 
> 2. After susepend/wakeup, output from cat seems to take a long while
> (10+ sec for each cat call)
> 
> 0 0 0
> 0 0 0 and so on...
>  
> 
> > 
> > - The attached is a program. Don't start iio_sensor_proxy service.
> > Disable so that it doesn't start on boot and run
> > sensor_monitor -n accel_3d
> 1. Before suspend/wakeup: see attachment sensor-monitor_output1.txt
> 2. Post suspend/wakeup: 
> 
> /sys/bus/iio/devices/iio:device0 0.000000
> > 
> > > 
> > > 
> > > 
> > > 
> > > 
> > > 
> > > 
> > > 
> > > 
> > > 
> l,s,32,32,0
> <<
> > 
> > > 
> > > 
> l,s,32,32,0
> <<
> > 
> > > 
> > > 
> l,s,32,32,0
> <<
> /sys/bus/iio/devices/iio:device1 0.000000
> > 
> > > 
> > > 
> > > 
> > > 
> > > 
> > > 
> > > 
> > > 
> > > 
> > > 
> l,s,32,32,0
> <<
> > 
> > > 
> > > 
> l,s,32,32,0
> <<
> > 
> > > 
> > > 
> l,s,32,32,0
> <<
> /sys/bus/iio/devices/iio:device2 0.001000
> > 
> > > 
> > > 
> > > 
> > > 
> > > 
> > > 
> l,s,32,32,0
> <<
> /sys/bus/iio/devices/iio:device3 0.000009
> > 
> > > 
> > > 
> > > 
> > > 
> > > 
> l,s,32,32,0
> <<
> > 
> > > 
> > > 
> l,s,32,32,0
> <<
> > 
> > > 
> > > 
> l,s,32,32,0
> <<
> > 
> > > 
> > > 
> > > 
> > > 
> > > 
> > > 
> /sys/bus/iio/devices/iio:device4 0.000001
> > 
> > > 
> > > 
> > > 
> > > 
> > > 
> > > 
> > > 
> > > 
> l,s,32,32,0
> <<
> > 
> > > 
> > > 
> > > 
> l,s,32,32,0
> <<
> > 
> > > 
> > > 
> l,s,32,32,0
> <<
> > 
> > > 
> > > 
> l,s,32,32,0
> <<
> > 
> > > 
> > > 
> > > 
> > > 
> [It seems to hang at this stage, so I hit Ctrl-C finally after some
> waiting]
> 
I see. Can you add the following change and try?
diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
index e4d00d2..f241e1f 100644
--- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
+++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
@@ -199,6 +199,7 @@ static int ish_resume(struct device *device)
        struct ishtp_device *dev = pci_get_drvdata(pdev);
 
        disable_irq_wake(pdev->irq);
+       ish_hw_start(dev);
        ishtp_send_resume(dev);
        dev->suspend_flag = 0;

The iio sensor proxy starts too soon. So I recommended to wait for
mult-user target before start. I think developer is considering.

Thanks,
Srinivas

> Hope that helps.
> Best wishes.
> 
> -- 
> Atri Bhattacharya
> Thu  2 Jun 21:39:25 CEST 2016
> 
> Sent from openSUSE Tumbleweed (20160531) (x86_64) on my laptop.
