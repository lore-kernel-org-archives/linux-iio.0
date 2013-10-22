Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:56277 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754125Ab3JVT5H (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 22 Oct 2013 15:57:07 -0400
Date: Tue, 22 Oct 2013 21:57:06 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Harald Geyer <harald@ccbib.org>
cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: Add new driver dht11-gpio
In-Reply-To: <alpine.DEB.2.01.1310222030570.23009@pmeerw.net>
Message-ID: <alpine.DEB.2.01.1310222156170.23009@pmeerw.net>
References: <E1VYf74-0000gd-5Z@stardust.g4.wien.funkfeuer.at> <alpine.DEB.2.01.1310222030570.23009@pmeerw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> > +config DHT11_GPIO
> > +	tristate "DHT11 (and compatible sensors) driver"
> > +	help
> > +	  This driver supports reading data via a single interrupts

should probably depend on GENERIC_GPIO?

p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
