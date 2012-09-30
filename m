Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:52843 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751148Ab2I3LQ2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 30 Sep 2012 07:16:28 -0400
Date: Sun, 30 Sep 2012 13:16:26 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
cc: linux-iio@vger.kernel.org, 21cnbao@gmail.com,
	hennerich@blackfin.uclinux.org, marex@denx.de, lars@metafoo.de
Subject: Re: [PATCH 2/3] iio staging: make use of IIO_ST macro where easily
 possible
In-Reply-To: <50682076.7040306@kernel.org>
Message-ID: <alpine.DEB.2.01.1209301257320.8022@pmeerw.net>
References: <1348999545-19099-1-git-send-email-pmeerw@pmeerw.net> <1348999545-19099-2-git-send-email-pmeerw@pmeerw.net> <50682076.7040306@kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

> > saves a couple of lines for each .scan_type specification

> Sorry to say I'm against this patch as I would rather
> like to get rid of the IIO_ST macro entirely (pushing any
> such macros down into the drivers where relevant).

> The reason is precisely what you have been dealing with in
> your IIO_ST_BE patch. However thoroughly we specify a macro
> like this the chances of needing to extend it to cover new
> elements of the structure is extremely high.  When that
> happens we either end up with lots of variants of the macro
> like your IIO_ST_BE version or we end up having to add the
> additional parameters to every instance of the macro whether
> or not it matters for a particular driver.

I see the problem; the shift element (mostly 0) is an example of
a parameter that does not matter for most drivers

on the other hand, IIO_ST is quite sucessful in saving code/typing -- it 
just is not supposed to handle all initialization cases; and IIO_ST cannot 
be used for dynamic construction of channels anyway

p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
