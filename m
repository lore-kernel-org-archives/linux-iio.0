Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from h1446028.stratoserver.net ([85.214.92.142]:52460 "EHLO
	mail.ahsoftware.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754422Ab2LKSee (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 11 Dec 2012 13:34:34 -0500
Message-ID: <50C77CA9.2090803@ahsoftware.de>
Date: Tue, 11 Dec 2012 19:34:17 +0100
From: Alexander Holler <holler@ahsoftware.de>
MIME-Version: 1.0
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"matteo.dameno@st.com" <matteo.dameno@st.com>
Subject: Re: hid-sensor-hub and autoloading of HID sensor modules
References: <50C64F29.9030200@ahsoftware.de> <4FA419E87744DF4DAECD5BCE1214B7A91C96075E@ORSMSX108.amr.corp.intel.com> <50C6551B.1030107@ahsoftware.de> <4FA419E87744DF4DAECD5BCE1214B7A91C96077D@ORSMSX108.amr.corp.intel.com> <50C659C1.7060005@ahsoftware.de>
In-Reply-To: <50C659C1.7060005@ahsoftware.de>
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Am 10.12.2012 22:53, schrieb Alexander Holler:
> Am 10.12.2012 22:40, schrieb Pandruvada, Srinivas:
>> I mean if your patch is merged, when new kernel is synced in the product line, we can't depend on auto loading of hid-sensor-hub. So we need to do something similar as you suggested.
> 
> Those patches aren't meant for your product line (mor for 3.8). But
> hid-sensor-hub currently (as in 3.7-rc) doesn't load the necessary
> modules at all, only hid-sensor-hub is currently loaded automatically,
> not the other modules. That is at least what I've experienced here.

As I'm not sure if I could describe clearly what I meant to say, I try
it again: ;)

The problem that the necessary modules will not be loaded automatically
already exists in kernel 3.7. This is indepent of my proposed patches to
get rid of the vendor and device IDs and load hid-sensor-hub
automatically for all USB HID sensor hubs.

With or without my proposed patches, only hid-sensor-hub is loaded
automatically, but not the other drivers like hid-sensor-accel-3d,
hid-sensor-als, hid-sensor-gyro-3d or hid-sensor-magn-3d (if the are
build as modules).

Regards,

Alexander
