Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from omr-m017e.mx.aol.com ([204.29.186.19]:49234 "EHLO
	omr-m017e.mx.aol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751274AbcFBTmm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 2 Jun 2016 15:42:42 -0400
Message-ID: <1464896535.3470.4.camel@aim.com>
Subject: Re: [RFC 0/4] Intel Integrated Sensor Hub Support (ISH)
From: Atri Bhattacharya <badshah400@aim.com>
To: linux-iio <linux-iio@vger.kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Date: Thu, 02 Jun 2016 21:42:15 +0200
In-Reply-To: <1464886187.3970.55.camel@linux.intel.com>
References: <1464668878-17113-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <1464788204.3917.9.camel@aim.com>
	 <loom.20160602T052411-711@post.gmane.org>
	 <1464853729.2640.8.camel@aim.com>
	 <1464886187.3970.55.camel@linux.intel.com>
Content-Type: multipart/mixed; boundary="=-SUaBscO/EWRFpOLslJdR"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--=-SUaBscO/EWRFpOLslJdR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Hi Srinivas,

On Thu, 2016-06-02 at 09:49 -0700, Srinivas Pandruvada wrote:
> Hi,
> On Thu, 2016-06-02 at 09:48 +0200, Atri Bhattacharya wrote:
> > On Thu, 2016-06-02 at 03:27 +0000, Srinivas Pandruvada wrote:
> > > 
> > > Atri Bhattacharya <badshah400@...> writes:
> > > 
> > > > 
> > > >  
> [...]
> > > > +
> > >  #include <linux/device.h>
> > >  #include <linux/hid.h>
> > >  #include <linux/module.h>
> > > @@ -798,6 +799,9 @@ static const struct hid_device_id
> > > sensor_hub_devices[] = 
> > > {
> > >         { HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB,
> > > USB_VENDOR_ID_ITE,
> > >                         USB_DEVICE_ID_ITE_LENOVO_YOGA900),
> > >                         .driver_data =
> > > HID_SENSOR_HUB_ENUM_QUIRK},
> > > +       { HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB, 
> > > USB_VENDOR_ID_INTEL_0,
> > > +                       0x22D8),
> > > +                       .driver_data =
> > > HID_SENSOR_HUB_ENUM_QUIRK},
> > >         { HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB,
> > > HID_ANY_ID,
> > >                      HID_ANY_ID) },
> > >         { }
> > > 
> > > 
> > Thanks for your response, but this patch didn't help with the slow
> > suspend/wakeup problem or with making the device actually respond
> > to
> > rotation or brightness changes. At this stage the sensor-hub seems
> > to
> > be recognised just fine, but not to be working. Same messages as
> > above
> > continue to show up in the journal.
> > 
> Looks like the system resume is getting timed out. I am looking at
> possible issue on Yoga 260.
> Meanwhile can you try:
> - Raw reads (cat /sys/bus/iio/devices/iio:device (your device
>  index)/in_accel_?_raw

There are two sets of results:

1. After a reboot but before suspend/wakeup

~> for i in {1..5}; do printf "%d " `cat
/sys/bus/iio/devices/iio\:device3/in_accel_?_raw`; echo; sleep 1; done
25684 -1033593 -456933 
-347362 -1014062 -367090 
-919628 -281640 -167871 
-898143 278906 15722 
-648143 683203 123144

2. After susepend/wakeup, output from cat seems to take a long while
(10+ sec for each cat call)

0 0 0
0 0 0 and so on...
 

> - The attached is a program. Don't start iio_sensor_proxy service.
> Disable so that it doesn't start on boot and run
> sensor_monitor -n accel_3d

1. Before suspend/wakeup: see attachment sensor-monitor_output1.txt
2. Post suspend/wakeup: 

/sys/bus/iio/devices/iio:device0 0.000000
>>
>>
>>
>>
>>
>>
>>
>>
>>
l,s,32,32,0
<<
>>
l,s,32,32,0
<<
>>
l,s,32,32,0
<<
/sys/bus/iio/devices/iio:device1 0.000000
>>
>>
>>
>>
>>
>>
>>
>>
>>
l,s,32,32,0
<<
>>
l,s,32,32,0
<<
>>
l,s,32,32,0
<<
/sys/bus/iio/devices/iio:device2 0.001000
>>
>>
>>
>>
>>
l,s,32,32,0
<<
/sys/bus/iio/devices/iio:device3 0.000009
>>
>>
>>
>>
l,s,32,32,0
<<
>>
l,s,32,32,0
<<
>>
l,s,32,32,0
<<
>>
>>
>>
>>
>>
/sys/bus/iio/devices/iio:device4 0.000001
>>
>>
>>
>>
>>
>>
>>
l,s,32,32,0
<<
>>
>>
l,s,32,32,0
<<
>>
l,s,32,32,0
<<
>>
l,s,32,32,0
<<
>>
>>
>>

[It seems to hang at this stage, so I hit Ctrl-C finally after some
waiting]

Hope that helps.
Best wishes.

-- 
Atri Bhattacharya
Thu  2 Jun 21:39:25 CEST 2016

Sent from openSUSE Tumbleweed (20160531) (x86_64) on my laptop.
--=-SUaBscO/EWRFpOLslJdR
Content-Disposition: attachment; filename="sensor-monitor_ouput1.txt"
Content-Type: text/plain; name="sensor-monitor_ouput1.txt"; charset="UTF-8"
Content-Transfer-Encoding: base64

L3N5cy9idXMvaWlvL2RldmljZXMvaWlvOmRldmljZTAgMC4wMDAwMDAKPj4KPj4KPj4KPj4KPj4K
Pj4KPj4KPj4KPj4KbCxzLDMyLDMyLDAKPDwKPj4KbCxzLDMyLDMyLDAKPDwKPj4KbCxzLDMyLDMy
LDAKPDwKL3N5cy9idXMvaWlvL2RldmljZXMvaWlvOmRldmljZTEgMC4wMDAwMDAKPj4KPj4KPj4K
Pj4KPj4KPj4KPj4KPj4KPj4KbCxzLDMyLDMyLDAKPDwKPj4KbCxzLDMyLDMyLDAKPDwKPj4KbCxz
LDMyLDMyLDAKPDwKL3N5cy9idXMvaWlvL2RldmljZXMvaWlvOmRldmljZTIgMC4wMDEwMDAKPj4K
Pj4KPj4KPj4KPj4KbCxzLDMyLDMyLDAKPDwKL3N5cy9idXMvaWlvL2RldmljZXMvaWlvOmRldmlj
ZTMgMC4wMDAwMDkKPj4KPj4KPj4KPj4KbCxzLDMyLDMyLDAKPDwKPj4KbCxzLDMyLDMyLDAKPDwK
Pj4KbCxzLDMyLDMyLDAKPDwKPj4KPj4KPj4KPj4KPj4KL3N5cy9idXMvaWlvL2RldmljZXMvaWlv
OmRldmljZTQgMC4wMDAwMDEKPj4KPj4KPj4KPj4KPj4KPj4KPj4KbCxzLDMyLDMyLDAKPDwKPj4K
Pj4KbCxzLDMyLDMyLDAKPDwKPj4KbCxzLDMyLDMyLDAKPDwKPj4KbCxzLDMyLDMyLDAKPDwKPj4K
Pj4KPj4KUmVhZCBidWZzaXplIDEyCmZyZWFkIHJldCA9IDEKRXZlbnQgKCAgICAgIDAuMjUsICAg
ICAtNi45NSwgICAgIC01Ljg1KQpSZWFkIGJ1ZnNpemUgMTIKZnJlYWQgcmV0ID0gMQpFdmVudCAo
ICAgICAtMC4wOSwgICAgIC02LjY3LCAgICAgLTUuMzYpClJlYWQgYnVmc2l6ZSAxMgpmcmVhZCBy
ZXQgPSAxCkV2ZW50ICggICAgICAwLjIxLCAgICAgLTYuODIsICAgICAtNS44NykKUmVhZCBidWZz
aXplIDEyCmZyZWFkIHJldCA9IDEKRXZlbnQgKCAgICAgIDAuMTQsICAgICAtNi43NCwgICAgIC01
LjcxKQpSZWFkIGJ1ZnNpemUgMTIKZnJlYWQgcmV0ID0gMQpFdmVudCAoICAgICAgMC4xNiwgICAg
IC02LjgxLCAgICAgLTUuODQpClJlYWQgYnVmc2l6ZSAxMgpmcmVhZCByZXQgPSAxCkV2ZW50ICgg
ICAgICAwLjEzLCAgICAgLTYuNzcsICAgICAtNS43NikKUmVhZCBidWZzaXplIDEyCmZyZWFkIHJl
dCA9IDEKRXZlbnQgKCAgICAgIDAuMTYsICAgICAtNi43OSwgICAgIC01LjgwKQpSZWFkIGJ1ZnNp
emUgMTIKZnJlYWQgcmV0ID0gMQpFdmVudCAoICAgICAgMC4xNiwgICAgIC02LjgxLCAgICAgLTUu
ODApClJlYWQgYnVmc2l6ZSAxMgpmcmVhZCByZXQgPSAxCkV2ZW50ICggICAgICAwLjE4LCAgICAg
LTYuNzUsICAgICAtNS44MCkKUmVhZCBidWZzaXplIDEyCmZyZWFkIHJldCA9IDEKRXZlbnQgKCAg
ICAgIDAuMTQsICAgICAtNi43NywgICAgIC01Ljc4KQpSZWFkIGJ1ZnNpemUgMTIKZnJlYWQgcmV0
ID0gMQpFdmVudCAoICAgICAgMC4xOCwgICAgIC02Ljc1LCAgICAgLTUuODQpClJlYWQgYnVmc2l6
ZSAxMgpmcmVhZCByZXQgPSAxCkV2ZW50ICggICAgICAwLjE4LCAgICAgLTYuNzksICAgICAtNS44
MCkKUmVhZCBidWZzaXplIDEyCmZyZWFkIHJldCA9IDEKRXZlbnQgKCAgICAgIDAuMTYsICAgICAt
Ni44MiwgICAgIC01Ljc1KQpSZWFkIGJ1ZnNpemUgMTIKZnJlYWQgcmV0ID0gMQpFdmVudCAoICAg
ICAgMC4xNiwgICAgIC02LjgxLCAgICAgLTUuNzMpClJlYWQgYnVmc2l6ZSAxMgpmcmVhZCByZXQg
PSAxCkV2ZW50ICggICAgICAwLjE2LCAgICAgLTYuNzcsICAgICAtNS43NSkKUmVhZCBidWZzaXpl
IDEyCmZyZWFkIHJldCA9IDEKRXZlbnQgKCAgICAgIDAuMTgsICAgICAtNi43OSwgICAgIC01Ljc4
KQpSZWFkIGJ1ZnNpemUgMTIKZnJlYWQgcmV0ID0gMQpFdmVudCAoICAgICAgMC4xOCwgICAgIC02
Ljc5LCAgICAgLTUuNzYpClJlYWQgYnVmc2l6ZSAxMgpmcmVhZCByZXQgPSAxCkV2ZW50ICggICAg
ICAwLjIzLCAgICAgLTYuODEsICAgICAtNS45MSkKUmVhZCBidWZzaXplIDEyCmZyZWFkIHJldCA9
IDEKRXZlbnQgKCAgICAgIDAuMTYsICAgICAtNi44MiwgICAgIC01LjY5KQpSZWFkIGJ1ZnNpemUg
MTIKZnJlYWQgcmV0ID0gMQpFdmVudCAoICAgICAgMC4xMywgICAgIC02Ljc3LCAgICAgLTUuNzMp
ClJlYWQgYnVmc2l6ZSAxMgpmcmVhZCByZXQgPSAxCkV2ZW50ICggICAgICAwLjIwLCAgICAgLTYu
NzksICAgICAtNS43NSkKUmVhZCBidWZzaXplIDEyCmZyZWFkIHJldCA9IDEKRXZlbnQgKCAgICAg
IDAuMjAsICAgICAtNi43OSwgICAgIC01LjgyKQpSZWFkIGJ1ZnNpemUgMTIKZnJlYWQgcmV0ID0g
MQpFdmVudCAoICAgICAgMC4yMCwgICAgIC02Ljc3LCAgICAgLTYuMTcpClJlYWQgYnVmc2l6ZSAx
MgpmcmVhZCByZXQgPSAxCkV2ZW50ICggICAgICAwLjE2LCAgICAgLTYuNzksICAgICAtNS44MikK
UmVhZCBidWZzaXplIDEyCmZyZWFkIHJldCA9IDEKRXZlbnQgKCAgICAgIDAuMTQsICAgICAtNi44
MiwgICAgIC01LjczKQpSZWFkIGJ1ZnNpemUgMTIKZnJlYWQgcmV0ID0gMQpFdmVudCAoICAgICAg
MC4wOSwgICAgIC02Ljc3LCAgICAgLTUuNzYpClJlYWQgYnVmc2l6ZSAxMgpmcmVhZCByZXQgPSAx
CkV2ZW50ICggICAgICAwLjEzLCAgICAgLTYuNzksICAgICAtNS43MykKUmVhZCBidWZzaXplIDEy
CmZyZWFkIHJldCA9IDEKRXZlbnQgKCAgICAgIDAuMTEsICAgICAtNi43NywgICAgIC01Ljc1KQpS
ZWFkIGJ1ZnNpemUgMTIKZnJlYWQgcmV0ID0gMQpFdmVudCAoICAgICAgMC4xNCwgICAgIC02Ljgx
LCAgICAgLTUuNzUpClJlYWQgYnVmc2l6ZSAxMgpmcmVhZCByZXQgPSAxCkV2ZW50ICggICAgICAw
LjE0LCAgICAgLTYuODEsICAgICAtNS43NikKUmVhZCBidWZzaXplIDEyCmZyZWFkIHJldCA9IDEK
RXZlbnQgKCAgICAgIDAuMjEsICAgICAtNi44MiwgICAgIC01Ljg3KQo=


--=-SUaBscO/EWRFpOLslJdR--

