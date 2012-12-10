Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from h1446028.stratoserver.net ([85.214.92.142]:43555 "EHLO
	mail.ahsoftware.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353Ab2LJVfV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 10 Dec 2012 16:35:21 -0500
Message-ID: <50C6551B.1030107@ahsoftware.de>
Date: Mon, 10 Dec 2012 22:33:15 +0100
From: Alexander Holler <holler@ahsoftware.de>
MIME-Version: 1.0
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"matteo.dameno@st.com" <matteo.dameno@st.com>
Subject: Re: hid-sensor-hub and autoloading of HID sensor modules
References: <50C64F29.9030200@ahsoftware.de> <4FA419E87744DF4DAECD5BCE1214B7A91C96075E@ORSMSX108.amr.corp.intel.com>
In-Reply-To: <4FA419E87744DF4DAECD5BCE1214B7A91C96075E@ORSMSX108.amr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Am 10.12.2012 22:22, schrieb Pandruvada, Srinivas:
> This will be a problem for current implementations, which are about to get shipped.
> Once I get chance, I will start looking at this idea. Meanwhile, you need to add hook to vendor and product id in the table.

Sorry, but I don't understand what that "shipped" has to do with the
implementation in the kernel. And I don't seen any problems as only the
implementation inside the kernel will change, nothing else.

Regards,

Alexander

> 
> Thanks,
> Srinivas
> 
> 
> -----Original Message-----
> From: Alexander Holler [mailto:holler@ahsoftware.de] 
> Sent: Monday, December 10, 2012 1:08 PM
> To: linux-iio@vger.kernel.org; linux-input@vger.kernel.org; Pandruvada, Srinivas; matteo.dameno@st.com
> Subject: hid-sensor-hub and autoloading of HID sensor modules
> 
> Hello,
> 
> as I've just posted a patch to get rid of the vendor and device IDs for USB HID sensor hubs, there is still one problem left: hid-sensor-hub doesn't automatically load the necessary drivers (if they are modules).
> 
> Here is a suggestion about how to solve that:
> 
> Create HID groups HID_GROUP_SENSOR_ACCEL, HID_GROUP_SENSOR_TIME, ...) for every type of (supported) sensor (instead of the one HID_GROUP_SENSOR_HUB), scan for their usage pages (e.g.
> HID_USAGE_SENSOR_ACCEL, HID_USAGE_SENSOR_TIME, ...) set the group and so load the final module and not hid-sensor-hub. hid-sensor-hub will then get loaded automatically.
> 
> As I don't have any real sensor hubs (and no business with them), I think others should implement such, if that idea got approved to make sense. ;) That just would be some few lines, but I couldn't test them with real-world stuff.
> 
> Regards,
> 
> Alexander
> 

