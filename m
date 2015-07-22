Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:55116 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236AbbGVSuX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 22 Jul 2015 14:50:23 -0400
Received: from mfilter16-d.gandi.net (mfilter16-d.gandi.net [217.70.178.144])
	by relay3-d.mail.gandi.net (Postfix) with ESMTP id C3AC5A80B0
	for <linux-iio@vger.kernel.org>; Wed, 22 Jul 2015 20:50:21 +0200 (CEST)
Received: from relay3-d.mail.gandi.net ([217.70.183.195])
	by mfilter16-d.gandi.net (mfilter16-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id kJtY8zmc-RI1 for <linux-iio@vger.kernel.org>;
	Wed, 22 Jul 2015 20:50:20 +0200 (CEST)
Received: from nuvo (mon69-7-83-155-44-161.fbx.proxad.net [83.155.44.161])
	(Authenticated sender: hadess@hadess.net)
	by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 5BEA8A80B4
	for <linux-iio@vger.kernel.org>; Wed, 22 Jul 2015 20:50:20 +0200 (CEST)
Message-ID: <1437590935.30706.106.camel@hadess.net>
Subject: bmc150_accel i2c-BMA250E:00: Invalid chip f8
From: Bastien Nocera <hadess@hadess.net>
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Date: Wed, 22 Jul 2015 20:48:55 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hey,

Running kernel 4.0.8 on a WinBook TW100 tablet, I get the error message
in the subject line when loading the bmc150_accel driver.

The 2 items in udev about that device:
P: /devices/LNXSYSTM:00/LNXSYBUS:00/80860F41:04/BMA250E:00
E: DEVPATH=/devices/LNXSYSTM:00/LNXSYBUS:00/80860F41:04/BMA250E:00
E: MODALIAS=acpi:BMA250E:BMA250E:
E: SUBSYSTEM=acpi

and:
P: /devices/platform/80860F41:04/i2c-12/i2c-BMA250E:00
E: DEVPATH=/devices/platform/80860F41:04/i2c-12/i2c-BMA250E:00
E: MODALIAS=acpi:BMA250E:BMA250E:
E: SUBSYSTEM=i2c

And the DSDT for the device:
https://people.gnome.org/~hadess/Winbook%20TW100%20DSDT.dsl

Any ideas what I should try (apart from a more recent kernel, I'm onto
that...)

Cheers
