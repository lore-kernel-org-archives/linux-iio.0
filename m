Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from omr-m016e.mx.aol.com ([204.29.186.16]:39375 "EHLO
	omr-m016e.mx.aol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752020AbcFBHyi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 2 Jun 2016 03:54:38 -0400
Message-ID: <1464853729.2640.8.camel@aim.com>
Subject: Re: [RFC 0/4] Intel Integrated Sensor Hub Support (ISH)
From: Atri Bhattacharya <badshah400@aim.com>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-iio@vger.kernel.org
Date: Thu, 02 Jun 2016 09:48:49 +0200
In-Reply-To: <loom.20160602T052411-711@post.gmane.org>
References: <1464668878-17113-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <1464788204.3917.9.camel@aim.com> <loom.20160602T052411-711@post.gmane.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 2016-06-02 at 03:27 +0000, Srinivas Pandruvada wrote:
> Atri Bhattacharya <badshah400@...> writes:
> 
> > 
> > Thanks a lot for adding support for this. I have a Lenovo Thinkpad
> > Yoga
> > 260, so I decided to give it a try. I used your patches on kernel
> > 4.6.0
> > and installed the patched kernel. Now, I see that the device is
> > recognised immediately. I use the iio-sensor-proxy application from
> > [1], and it now recognises the sensors. But changing orientation
> > doesn't seem to do anything, and moreover upon a wakeup from
> > suspend I
> > see the following messages on the journal:
> > 
> > Jun 01 15:15:09 tp-yoga260 kernel: [drm] RC6 on
> > Jun 01 15:15:09 tp-yoga260 kernel: hid-sensor-hub
> > 0044:8086:22D8.0001:
> > timeout waiting for response from ISHTP device
> > Jun 01 15:15:09 tp-yoga260 kernel: hid-sensor-hub
> > 0044:8086:22D8.0001:
> > timeout waiting for response from ISHTP device
> > Jun 01 15:15:09 tp-yoga260 kernel: hid-sensor-hub
> > 0044:8086:22D8.0001:
> > timeout waiting for response from ISHTP device
> > Jun 01 15:15:09 tp-yoga260 kernel: hid-sensor-hub
> > 0044:8086:22D8.0001:
> > timeout waiting for response from ISHTP device
> > Jun 01 15:15:09 tp-yoga260 kernel: hid-sensor-hub
> > 0044:8086:22D8.0001:
> > timeout waiting for response from ISHTP device
> > Jun 01 15:15:09 tp-yoga260 kernel: hid-sensor-hub
> > 0044:8086:22D8.0001:
> > timeout waiting for response from ISHTP device
> > Jun 01 15:15:09 tp-yoga260 kernel: hid-sensor-hub
> > 0044:8086:22D8.0001:
> > timeout waiting for response from ISHTP device
> > Jun 01 15:15:09 tp-yoga260 kernel: hid-sensor-hub
> > 0044:8086:22D8.0001:
> > timeout waiting for response from ISHTP device
> > Jun 01 15:15:09 tp-yoga260 kernel: hid-sensor-hub
> > 0044:8086:22D8.0002:
> > timeout waiting for response from ISHTP device
> > Jun 01 15:15:09 tp-yoga260 kernel: hid-sensor-hub
> > 0044:8086:22D8.0002:
> > timeout waiting for response from ISHTP device
> > Jun 01 15:15:09 tp-yoga260 kernel: hid-sensor-hub
> > 0044:8086:22D8.0002:
> > timeout waiting for response from ISHTP device
> > Jun 01 15:15:09 tp-yoga260 kernel: hid-sensor-hub
> > 0044:8086:22D8.0002:
> > timeout waiting for response from ISHTP device
> > Jun 01 15:15:09 tp-yoga260 kernel: PM: resume of devices complete
> > after
> > 37095.288 msecs
> > 
> > Also suspend and wakeup seems to be really slow now. Please let me
> > know
> > if there is any other info I can provide.
> > 
> > Thanks and best wishes.
> > 
> > [1] https://github.com/hadess/iio-sensor-proxy
> > 
> 
> Can you reply to all, so that I get email in my inbox?
> You will need this as you have older FW?
> 
> diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-
> hub.c
> index 3d5ba5b..658a607 100644
> --- a/drivers/hid/hid-sensor-hub.c
> +++ b/drivers/hid/hid-sensor-hub.c
> @@ -16,6 +16,7 @@
>   * 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
>   *
>   */
> +
>  #include <linux/device.h>
>  #include <linux/hid.h>
>  #include <linux/module.h>
> @@ -798,6 +799,9 @@ static const struct hid_device_id
> sensor_hub_devices[] = 
> {
>         { HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB,
> USB_VENDOR_ID_ITE,
>                         USB_DEVICE_ID_ITE_LENOVO_YOGA900),
>                         .driver_data = HID_SENSOR_HUB_ENUM_QUIRK},
> +       { HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB, 
> USB_VENDOR_ID_INTEL_0,
> +                       0x22D8),
> +                       .driver_data = HID_SENSOR_HUB_ENUM_QUIRK},
>         { HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB, HID_ANY_ID,
>                      HID_ANY_ID) },
>         { }
> 
> 

Thanks for your response, but this patch didn't help with the slow
suspend/wakeup problem or with making the device actually respond to
rotation or brightness changes. At this stage the sensor-hub seems to
be recognised just fine, but not to be working. Same messages as above
continue to show up in the journal.

Best wishes
-- 
Atri Bhattacharya
Thu  2 Jun 09:42:21 CEST 2016

Sent from openSUSE Tumbleweed (20160530) (x86_64) on my laptop.
