Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:56252 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757968Ab2EINdF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 9 May 2012 09:33:05 -0400
Date: Wed, 9 May 2012 15:33:04 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
cc: linux-iio@vger.kernel.org, jic23@kernel.org, lars@metafoo.de
Subject: Re: iio: v2, add support for HMC5883/HMC5883L to HMC5843 driver
In-Reply-To: <CAM=Q2cuuki_4jJoCdLOrdHVVk-yKSOyaLL3dcbY_SzxJXvt8Kg@mail.gmail.com>
Message-ID: <alpine.DEB.2.01.1205091524570.5308@pmeerw.net>
References: <1336515606-12364-1-git-send-email-pmeerw@pmeerw.net> <CAM=Q2cuuki_4jJoCdLOrdHVVk-yKSOyaLL3dcbY_SzxJXvt8Kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

> > the driver has a severe limitation: X/Y/Z must ALL be read to allow new
> > data to become available (the device goes into a locked state until all
> > are read)

> Thats a limitation comming from the data sheet right?

yes, it affects all devices (hmc5843/5883/5883l)

> Are you suggesting a read all and report only requested?
> to work round that.

probably yes

I brought it up to see if there are ideas for a solution; maybe the issue 
is more common and this should be solved at iio core level?

with individual reads for X/Y/Z there is no guarantee that all values come 
from the same measurement cycle ('atomic read')

the hmc58x3 'solves' this with the lock logic and introduces another issue

maybe iio should only allow reads to all data elements at once?

regards, p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
