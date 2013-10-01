Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:45807 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751783Ab3JAIoY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 1 Oct 2013 04:44:24 -0400
Date: Tue, 1 Oct 2013 10:44:22 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 01/15] staging:iio:hmc5843: Add pointer to i2c client
 to data struct
In-Reply-To: <524A988E.4040707@kernel.org>
Message-ID: <alpine.DEB.2.01.1310011042260.2833@pmeerw.net>
References: <1379619360-8150-1-git-send-email-pmeerw@pmeerw.net> <1379619360-8150-2-git-send-email-pmeerw@pmeerw.net> <523D78EB.9070205@kernel.org> <524A988E.4040707@kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> I clearly have too much time on my hands this morning.  Pesky teachers strike and kid
> still asleep ;)
> Anyhow have fixed the wrong paramter up and applied to the togreg branch of iio.git

opposite is true for me at the moment; I have yet to fix up the suggested 
scale vs. calibscale cleanup

I think the broken code gets removed in the next commit anyway

regards, p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
