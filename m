Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:46257 "EHLO pmeerw.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753944AbcL3VJ0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 30 Dec 2016 16:09:26 -0500
Date: Fri, 30 Dec 2016 22:09:21 +0100 (CET)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Marek Vasut <marek.vasut@gmail.com>
cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>
Subject: Re: [PATCH] iio: adc: Add Renesas GyroADC driver
In-Reply-To: <442f8085-110c-659d-d097-add788b8f291@gmail.com>
Message-ID: <alpine.DEB.2.02.1612302205210.3977@pmeerw.net>
References: <20161230191800.2532-1-marek.vasut@gmail.com> <alpine.DEB.2.02.1612302027480.3977@pmeerw.net> <442f8085-110c-659d-d097-add788b8f291@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> >> Add IIO driver for the Renesas RCar GyroADC block. This block is a
> >> simple 4/8-channel ADC which samples 12/15/24 bits of data every

> >> +		if (iio_buffer_enabled(indio_dev))
> >> +			return -EBUSY;
> > 
> > use iio_device_claim_direct_mode()
> 
> Why ? Do I really need the mutex locking here ?

no, not needed, since you do not support buffered mode yet; but neither do 
you need iio_buffer_enabled() 

p.

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
