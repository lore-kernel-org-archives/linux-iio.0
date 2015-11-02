Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:33641 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752246AbbKBSrf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 2 Nov 2015 13:47:35 -0500
Received: by lbbec13 with SMTP id ec13so95365171lbb.0
        for <linux-iio@vger.kernel.org>; Mon, 02 Nov 2015 10:47:34 -0800 (PST)
Received: from [192.168.1.100] (87-92-21-4.bb.dnainternet.fi. [87.92.21.4])
        by smtp.googlemail.com with ESMTPSA id bn6sm4140012lbc.10.2015.11.02.10.47.33
        for <linux-iio@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Nov 2015 10:47:33 -0800 (PST)
To: linux-iio@vger.kernel.org
From: =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= <dachaac@gmail.com>
Subject: IIO device indexing issue
Message-ID: <5637AFC5.7080007@gmail.com>
Date: Mon, 2 Nov 2015 20:47:33 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

When we were using kernel 3.2 and with that board files we just got IIO 
devices with static order so that we knew exactly what iio:device0 is.

Now with device tree that order is not so static anymore especially when 
using device overlays (have not yet tried that thou). If there would be 
deferred probe for the device then if we have multiple iio:device's then 
those could in theory be in any order.

In example libiio uses iio device index to open the IIO device. So the 
problem is to know what iio:device is what.

If we look files under /sys/bus/iio/iio:deviceX. They do not reveal what 
device this is (especially if there are multiple device of same type). 
There does not seem to be a way to give custom name for the iio device 
from device tree that could have been used as a cue.

Device tree aliases kinda sounded a good idea to try. Eg. define adc0 
alias and then link it to actual device node in tree.

Aliases could be found under /proc/device-tree/aliases. Looking at it 
shows what device tree node it is. However there does not seem to be 
actual link from any /proc/device-tree entries to kernel drivers exposed 
under sysfs. And even the path components in device tree are not in same 
format as in sysfs. So there is no 1:1 mapping possible here.

IIO devices in /sys/bus/iio/iio:deviceX seem to be symlinks to actual 
devices under /sys/devices and from there is physical path to the device 
and under that the IIO device with the same name as is under /sys/bus/iio.

So in theory we could make a mapping configuration file that specifies 
logical name for iio device and then physical parent path for the device 
and then find under it iio:device* files to determine what is the iio 
device index for this physical device. Then open IIO device with that 
index in example with libiio. Sounds a bit complex?

So did we miss something on how this should be defined/accessed or is 
there a slight issue here on how to identify iio devices?

Don't know how device tree overlays affect this if we first load device 
tree overlay with some configuration and then unload it and load another 
one with different configuration.

Thanks,
Vesa Jääskeläinen

