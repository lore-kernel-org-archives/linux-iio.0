Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33377 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751292AbdGOUFW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 15 Jul 2017 16:05:22 -0400
Date: Sat, 15 Jul 2017 22:05:18 +0200
From: Patrick <ctx.xda@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: jikos@kernel.org, benjamin.tissoires@redhat.com, jic23@kernel.org,
        srinivas.pandruvada@linux.intel.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] HID: Add quirk for Lenovo Yoga 910 with ITE Chips
Message-ID: <20170715200518.GA24502@foobar>
References: <20170715122721.6908-1-ctx.xda@gmail.com>
 <1500128998.2468.1.camel@hadess.net>
 <CAA7d1im1hxM13SrsF5pQsJmtugjT2CJZnJdmbC2KxL5_QPXd_Q@mail.gmail.com>
 <1500141490.2490.1.camel@hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1500141490.2490.1.camel@hadess.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Jul 15, 2017 at 07:58:10PM +0200, Bastien Nocera wrote:
> On Sat, 2017-07-15 at 19:52 +0200, Patrick Pedersen wrote:
> > On Sat, Jul 15, 2017 at 4:29 PM, Bastien Nocera <hadess@hadess.net>
> > wrote:
> > > On Sat, 2017-07-15 at 14:27 +0200, Patrick Pedersen wrote:
> > > > As with previous generations of this device (see https://patchwor
> > > k.ke
> > > > rnel.org/patch/7887361/), the ITE
> > > > HID Sensor Hub, responsible for the accelerometer and als sensor,
> > > > requires a quirk entry.
> > > >
> > > > Without the entry, the Sensor Hub can't be accessed and the
> > > kernel
> > > > fails to report any movements. As a result
> > > > iio-sensor-proxy receives no new data.
> > > >
> > > > It shall additionally be noted that the i2c-hid 'sleep' bug
> > > (present
> > > > since kernel ver. 4.3)
> > > > still affects the driver. This means that the sensor hub will not
> > > > report any movement, until
> > > > the device is suspended and resumed.
> > > >
> > > > Signed-off-by: Patrick Pedersen <ctx.xda@gmail.com>
> > > > ---
> > > >  drivers/hid/hid-ids.h        | 1 +
> > > >  drivers/hid/hid-sensor-hub.c | 3 +++
> > > >  2 files changed, 4 insertions(+)
> > > >
> > > > diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> > > > index 4f9a3938189a..b427a0bcfbe8 100644
> > > > --- a/drivers/hid/hid-ids.h
> > > > +++ b/drivers/hid/hid-ids.h
> > > > @@ -565,6 +565,7 @@
> > > >  #define USB_DEVICE_ID_ITE_LENOVO_YOGA   0x8386
> > > >  #define USB_DEVICE_ID_ITE_LENOVO_YOGA2  0x8350
> > > >  #define USB_DEVICE_ID_ITE_LENOVO_YOGA900     0x8396
> > > > +#define USB_DEVICE_ID_ITE_LENOVO_YOGA910     0x8186
> > > >
> > > >  #define USB_VENDOR_ID_JABRA          0x0b0e
> > > >  #define USB_DEVICE_ID_JABRA_SPEAK_410        0x0412
> > > > diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-
> > > sensor-
> > > > hub.c
> > > > index 4ef73374a8f9..85b8425483bd 100644
> > > > --- a/drivers/hid/hid-sensor-hub.c
> > > > +++ b/drivers/hid/hid-sensor-hub.c
> > > > @@ -820,6 +820,9 @@ static const struct hid_device_id
> > > > sensor_hub_devices[] = {
> > > >       { HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB,
> > > > USB_VENDOR_ID_ITE,
> > > >                       USB_DEVICE_ID_ITE_LENOVO_YOGA900),
> > > >                       .driver_data = HID_SENSOR_HUB_ENUM_QUIRK},
> > > > +     { HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB,
> > > > USB_VENDOR_ID_ITE,
> > > > +                     USB_DEVICE_ID_ITE_LENOVO_YOGA910),
> > > > +                     .driver_data = HID_SENSOR_HUB_ENUM_QUIRK},
> > > >       { HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB,
> > > > USB_VENDOR_ID_INTEL_0,
> > > >                       0x22D8),
> > > >                       .driver_data = HID_SENSOR_HUB_ENUM_QUIRK},
> > > 
> > > At this point, wouldn't it make sense to apply the quirk to *all*
> > > ITE
> > > devices in Lenovo Yoga laptops?
> > 
> > I'm not sure If I got your suggestion right.
> > 
> > Those laptops do not share the same ITE chip. ITE is simply 
> > the vendor/manufacturer of the hid sensor hub. All three defined 
> > yoga laptops use a different ITE sensor hub model.
> > 
> > To make this clear, my device, the 
> > Lenovo Yoga 910 uses a ITE8186, 
> > where the Yoga 900 uses a ITE8396, 
> > the Yoga 2 a ITE8350 and so on
> > 
> > Now what "could" me done, is to detect and set the quirk
> > automatically. 
> > This should be doable, as the Hardware PID corresponds to the 
> > model number of the Sensor Hub (ex. ITE8186 = PID 0x8186)
> 
> I'm saying that if the vendor of the device is USB_VENDOR_ID_ITE and
> the manufacturer of the hardware is Lenovo in the DMI information, and
> the model of hardware contains "Yoga", that HID_SENSOR_HUB_ENUM_QUIRK
> be applied automatically, instead of adding quirks one-by-one.

First of all, I would like to appologise that my previous reply was
not caught by the mailing list. I had a frustrating time getting
mutt to work and decided to use the gmail web interface. Turns out
that was a bad idea. Fortunately it seems like I got things right 
this time.

Now to the automated ITE chip detection you've proposed. I likely lack
the driver and kernel knowledge to implement a feature of such. In the 
upcoming days I will to do some research on the HID drivers and see what 
I can do. The goal of this patch was to simply fix the issue for my device,
not to find a new or different solution.

Patrick
