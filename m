Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:39972 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754897Ab2FTV7V (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 20 Jun 2012 17:59:21 -0400
Date: Wed, 20 Jun 2012 23:59:19 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Belisko Marek <marek.belisko@gmail.com>
cc: linux-iio@vger.kernel.org
Subject: Re: reading data from hmc5883
In-Reply-To: <CAAfyv36oD+mNrXhx1yDqnUpPT=Caecoc=oBhUTGjPNF9Rwdc3w@mail.gmail.com>
Message-ID: <alpine.DEB.2.01.1206202354580.13384@pmeerw.net>
References: <CAAfyv36oD+mNrXhx1yDqnUpPT=Caecoc=oBhUTGjPNF9Rwdc3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> IMO this is because hmc5883 don't have event_attrs set and then this fail.
> Not sure about that one but seems trigger is missing (hmc5883 use
> INDIO_DIRECT_MODE)

the hmc5843 driver does neither buffering nor events, could be added;
so you just read the iio:deviceX/in_magn_Y_raw devices

p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
