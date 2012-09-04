Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:53875 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756811Ab2IDLsR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 4 Sep 2012 07:48:17 -0400
Date: Tue, 4 Sep 2012 13:48:14 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Lars-Peter Clausen <lars@metafoo.de>
cc: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] staging:iio: Use iio_push_to_buffer
In-Reply-To: <1346758519-23942-1-git-send-email-lars@metafoo.de>
Message-ID: <alpine.DEB.2.01.1209041347230.11872@pmeerw.net>
References: <1346758288-20031-1-git-send-email-lars@metafoo.de> <1346758519-23942-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> Consistently use iio_push_to_buffer instead of manually calling the buffers
> store_to callback.

can we kill the timestamp parameter as an add-on patch?

thanks, p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
