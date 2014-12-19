Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from h1.radempa.de ([176.9.142.194]:58943 "EHLO mail.cosmopool.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752432AbaLSMgA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 19 Dec 2014 07:36:00 -0500
From: Harald Geyer <harald@ccbib.org>
To: Varka Bhadram <varkab@cdac.in>
cc: linux-iio - ML <linux-iio@vger.kernel.org>,
	Richard Weinberger <richard@nod.at>
Subject: Re: Dht11 driver problem
In-reply-to: <5493BC70.1020006@cdac.in>
References: <5493BC70.1020006@cdac.in>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 19 Dec 2014 13:35:30 +0100
Message-Id: <E1Y1wmJ-00012E-2N@stardust.g4.wien.funkfeuer.at>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Varka,

Varka Bhadram writes:

> While reading the DHT11 data from sys file system, its failing.
> 
> Its failing because in probe function we register gpio as irq and
> after that while read raw making same pin as output.
> 
> Is there any updated patches to avoid this problem..?

Richard Weinberger is working on a patch series to work around this.
See https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg783710.html
for details.
 
> One more thing is that this driver is not available in IIO git tree.

I don't know what you are refering to here.

Harald
