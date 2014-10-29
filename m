Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:50758 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932834AbaJ2Obg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 29 Oct 2014 10:31:36 -0400
Received: from mfilter32-d.gandi.net (mfilter32-d.gandi.net [217.70.178.163])
	by relay5-d.mail.gandi.net (Postfix) with ESMTP id BB57741C054
	for <linux-iio@vger.kernel.org>; Wed, 29 Oct 2014 15:31:33 +0100 (CET)
Received: from relay5-d.mail.gandi.net ([217.70.183.197])
	by mfilter32-d.gandi.net (mfilter32-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id HXV38q336A6n for <linux-iio@vger.kernel.org>;
	Wed, 29 Oct 2014 15:31:32 +0100 (CET)
Received: from nuvo (mon69-7-83-155-44-161.fbx.proxad.net [83.155.44.161])
	(Authenticated sender: hadess@hadess.net)
	by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 437B241C064
	for <linux-iio@vger.kernel.org>; Wed, 29 Oct 2014 15:31:32 +0100 (CET)
Message-ID: <1414593052.2406.37.camel@hadess.net>
Subject: Kernel wishlist item: Better IIO API
From: Bastien Nocera <hadess@hadess.net>
To: linux-iio@vger.kernel.org
Date: Wed, 29 Oct 2014 15:30:52 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hey,

I've posted this a couple of days ago:
http://www.hadess.net/2014/10/a-gnome-kernel-wishlist.html
along with a mail to LKML:
http://thread.gmane.org/gmane.linux.kernel/1810083

I've recently added to my list an item about IIO:
https://wiki.gnome.org/BastienNocera/KernelWishlist

Are there any plans for a better API for the IIO subsystem? The API
might be good enough to drive from shell scripts, or helpers that only
need to work with one variant of a device, but my attempts at trying to
use the IIO subsystem to provide an accelerometer to do automatic
display rotation[1] showed that the API is really cumbersome.

The code I wrote spends most of its time creating sysfs paths, reading
values in different formats, and mangling filenames[2].

Is an ioctl-based API planned? Something where I could get/set
structures to gather metadata about the device, and set it up easily, so
reading data from it is easier?

Cheers

PS: I plan on updating my Kionix driver posted here:
http://thread.gmane.org/gmane.linux.kernel.iio/13793
once I've had the opportunity to double-check it works with the
aforementioned code.

[1]: https://github.com/hadess/iio-sensor-proxy
[2]: https://github.com/hadess/iio-sensor-proxy/blob/master/iio-sensor-proxy.c#L331

