Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:33476 "EHLO
	slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754128AbcDNMUO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 14 Apr 2016 08:20:14 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	by slow1-d.mail.gandi.net (Postfix) with ESMTP id C982847F1A7
	for <linux-iio@vger.kernel.org>; Thu, 14 Apr 2016 14:16:58 +0200 (CEST)
Message-ID: <1460636212.5584.3.camel@hadess.net>
Subject: Re: [PATCH] iio: add Capella CM3218 ambient light sensor driver.
From: Bastien Nocera <hadess@hadess.net>
To: "K. T." <capellamicro@gmail.com>
Cc: linux-iio@vger.kernel.org, Kevin Tsai <ktsai@capellamicro.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Date: Thu, 14 Apr 2016 14:16:52 +0200
In-Reply-To: <CAHvdCWhHzsuRZ0Kj9BbOSBoCQswR-=vrQErDG9J57yDaE30+2A@mail.gmail.com>
References: <1460381347-26873-1-git-send-email-hadess@hadess.net>
	 <1460384362.2370.0.camel@hadess.net>
	 <CAHvdCWhHzsuRZ0Kj9BbOSBoCQswR-=vrQErDG9J57yDaE30+2A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hey Kevin,

On Wed, 2016-04-13 at 11:44 -0700, K. T. wrote:
> Hi Bastien,
> 
> What do you mean "doesn't survive"?  Can you read the sensor data or
> data is not change?  I use Shuttle XPC desktop to test sensor
> driver.  In my environment, suspend/resume works.  But,
> hibernate/resume may cause sensor won't update issue.  Let me know
> more detail about your issue and I will update driver.

I don't know how I tested it, but it seems to work as expected now. I
tested it by suspending and resuming, and the first time I tested, I
couldn't get any more data out of it, not sure why.

It might have been a problem in iio-sensor-proxy, which is due a clean
up anyway, so let me retract my retraction :)

If anyone has comments about the driver, let me know, and I'll work
with Kevin to get those sorted out.

Cheers
