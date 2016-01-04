Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from h1.radempa.de ([176.9.142.194]:44402 "EHLO mail.cosmopool.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751417AbcADOiC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 4 Jan 2016 09:38:02 -0500
From: Harald Geyer <harald@ccbib.org>
To: Jonathan Cameron <jic23@kernel.org>
cc: linux-iio@vger.kernel.org,
	Jonathan Bell <jonathan@raspberrypi.org>,
	Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH 2/3] iio: dht11: Simplify decoding algorithm
In-reply-to: <568A5B02.9010601@kernel.org>
References: <1451485605-3441-1-git-send-email-harald@ccbib.org> <1451485605-3441-2-git-send-email-harald@ccbib.org> <568A5B02.9010601@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 04 Jan 2016 15:37:55 +0100
Message-Id: <E1aG6Gh-0000MG-Is@stardust.g4.wien.funkfeuer.at>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Jonathan Cameron writes:
> On 30/12/15 14:26, Harald Geyer wrote:
> > The new algorithm uses a 'one size fits em all' threshold, which should
> > be easier to understand and debug. I believe there are no regressions
> > compared to the old adaptive threshold algorithm. I don't remember why
> > I chose the old algorithm when I initially wrote the driver.
> > 
> > Signed-off-by: Harald Geyer <harald@ccbib.org>
> Hmm. Couple of trivial bits inline.
> 
> I'd like some tested-by's on this one if possible...
> 
> Such a 'fun' device ;)

On the up-side its working on poor and long wiring almost as well as
on good and short wiring ... ;)
 
> > -		timing[i] = t / timeres;
> > +		bits[i] = t > DHT11_THRESHOLD ? 1 : 0;
> t > DHT11_THRESHOLD is already going to give 0 or 1...

Thanks. I'll send a v2 after everybody has had enough time to test and
comment on the whole series.

Harald
