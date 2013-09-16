Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:44694 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751310Ab3IPH6d (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 16 Sep 2013 03:58:33 -0400
Date: Mon, 16 Sep 2013 09:58:29 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 04/27] iio: Add iio_push_buffers_with_timestamp()
 helper
In-Reply-To: <5236B8BA.5050402@kernel.org>
Message-ID: <alpine.DEB.2.01.1309160955230.31656@pmeerw.net>
References: <1379263880-18405-1-git-send-email-lars@metafoo.de> <1379263880-18405-4-git-send-email-lars@metafoo.de> <5236B8BA.5050402@kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> Interesting.  Whilst this obviously results in the removal of a lot of
> repeated code, I am nervous about introducing the 'hidden' requirement
> that the data buffer passed in must be bigger than is 'apparently' used
> in the code calling this. I'm not sure what the right answer is though.

maybe add some iio magic that always allocs the buffer dynamically based 
on the channel definition/scan_bytes

regards, p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
