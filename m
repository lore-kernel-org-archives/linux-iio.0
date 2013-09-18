Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:59769 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751339Ab3IRHlP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 18 Sep 2013 03:41:15 -0400
Date: Wed, 18 Sep 2013 09:41:14 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Lars-Peter Clausen <lars@metafoo.de>
cc: linux-iio@vger.kernel.org
Subject: Re: iio: adis16400 scan mask question
In-Reply-To: <523954C0.5000500@metafoo.de>
Message-ID: <alpine.DEB.2.01.1309180939180.13489@pmeerw.net>
References: <alpine.DEB.2.01.1309172323201.9630@pmeerw.net> <523954C0.5000500@metafoo.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

> > if (!(st->variant->flags & ADIS16400_NO_BURST))
> > 		indio_dev->available_scan_masks = adis16400_burst_scan_mask;
> > 
> > isn't the all-1 scan mask the same as not applying any scan mask?

> A scan mask where all bits are set means that sampling can only be done with
> all channels enabled at once. Userspace can still only select a subset of
> these channels and the kernel will take care of properly demuxing the stream.

ah, that's a pretty good reason
I discovered the demuxing code later-on

thanks, p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
