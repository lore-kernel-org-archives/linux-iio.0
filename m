Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx0b-001d2f02.pphosted.com ([148.163.159.190]:60987 "EHLO
        mx0a-001d2f02.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751447AbdECXU2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 3 May 2017 19:20:28 -0400
Received: from pps.filterd (m0089641.ppops.net [127.0.0.1])
        by mx0b-001d2f02.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v43Ml20a025900
        for <linux-iio@vger.kernel.org>; Wed, 3 May 2017 15:47:50 -0700
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp0114.outbound.protection.outlook.com [207.46.163.114])
        by mx0b-001d2f02.pphosted.com with ESMTP id 2a7r42g1pj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-iio@vger.kernel.org>; Wed, 03 May 2017 15:47:50 -0700
From: "Schaefer, Brandon" <brandon.schaefer@flukenetworks.com>
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Enabling auto-WAKE/SLEEP for mma8654 accelerometer
Date: Wed, 3 May 2017 22:47:48 +0000
Message-ID: <BN6PR12MB14426A9685B9A0E0C5E7DE3F90160@BN6PR12MB1442.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The driver mma8452.c currently does not and, from the commit logs, plan to =
support auto-WAKE/SLEEP functionality. I'm endeavoring on adding this suppo=
rt as it would be useful to allow the use of this device to wake the system=
 from suspend. In the current state of the driver, the device will go in to=
 standby (no measurements/interrupts being generated) due to runtime suspen=
d and suspend callbacks.

I've modified the driver to go into/out of auto-WAKE/SLEEP but it removes t=
he capability of Linux PM code suspending and resuming the device. I'm look=
ing for advice on how to make the current Linux power management code and t=
he auto-WAKE/SLEEP code coexist. Some options, both don't seem very reasona=
ble:
1) Optional device tree bindings for mma8652 that will enable auto-WAKE/SLE=
EP if present, otherwise rely on Linux PM.
a. DT bindings should be hw description only, using a DT binding to specify=
 configuration could be seen as unreasonable.
b. Examples of properties that can be configured for auto-WAKE/SLEEP mode: =
output data rate during sleep mode, delay till sleep, power mode of sleep (=
low-noise, normal, high, low-power), etc...
2) Configure device with linux PM on boot, but expose sysfs nodes to allow =
userspace to configure device and put into auto-WAKE/SLEEP. Also responsibl=
e for disabling the PM code that'll put the device into standby.
a. As noted in a commit to this driver, auto-WAKE/SLEEP is a bit complicate=
d and there is no current documented syfsfs inetrace

Any and all suggestions welcome,

Brandon

________________________________
________________________________


Please be advised that this email may contain confidential information. If =
you are not the intended recipient, please notify us by email by replying t=
o the sender and delete this message. The sender disclaims that the content=
 of this email constitutes an offer to enter into, or the acceptance of, an=
y agreement; provided that the foregoing does not invalidate the binding ef=
fect of any digital or other electronic reproduction of a manual signature =
that is included in any attachment.
