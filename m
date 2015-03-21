Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:38374 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751523AbbCUQPI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 21 Mar 2015 12:15:08 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glki-linux-iio@m.gmane.org>)
	id 1YZM3E-0006Uk-Uy
	for linux-iio@vger.kernel.org; Sat, 21 Mar 2015 17:15:05 +0100
Received: from 93-172-178-90.bb.netvision.net.il ([93-172-178-90.bb.netvision.net.il])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-iio@vger.kernel.org>; Sat, 21 Mar 2015 17:15:04 +0100
Received: from elad by 93-172-178-90.bb.netvision.net.il with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-iio@vger.kernel.org>; Sat, 21 Mar 2015 17:15:04 +0100
To: linux-iio@vger.kernel.org
From: Elad Alfassa <elad@fedoraproject.org>
Subject: Re: Kernel wishlist item: Better IIO API
Date: Sat, 21 Mar 2015 16:08:57 +0000 (UTC)
Message-ID: <loom.20150321T160224-902@post.gmane.org>
References: <1414593052.2406.37.camel@hadess.net>			 <5451221D.6000301@metafoo.de> <1414604035.2406.41.camel@hadess.net>		 <54512640.3040505@metafoo.de> <1414604840.2406.43.camel@hadess.net>	 <54513238.6050903@metafoo.de> <1415909105.30887.3.camel@hadess.net> <5469214A.9000203@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Jonathan Cameron <jic23@...> writes:
[snip]
> > - on some variants, tweak the hysteresis [2] to trigger changes
> interesting one. - Note I personally don't mind fixes for firmware bugs
> in kernel - if there is a simple way of identifying parts with the problem.

Late followup, but (hopefully) better than nothing:

I have such device that has the hysteresis issue.

I don't know if there's a sure way to identify devices with this issue...
either automatically tweak the hysteresis when getting EAGAIN, or keep a
list of USB device IDs which require the hysteresis fix and apply them
automatically. Does this make sense? 

I would really prefer that this sort of fix will live in the kernel and not
in any userspace utility that might want to use the sensors.


> > [2]:
https://github.com/hadess/iio-sensor-proxy/issues/1#issuecomment-54536393





