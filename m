Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:33020 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760128AbbA3JXE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 30 Jan 2015 04:23:04 -0500
Date: Fri, 30 Jan 2015 12:22:50 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [patch] iio: imu: adis16400: Fix sign extension
Message-ID: <20150130092250.GK6507@mwanda>
References: <20150130083058.GD21357@mwanda>
 <54CB41F9.1060800@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <54CB41F9.1060800@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Jan 30, 2015 at 09:34:01AM +0100, Lars-Peter Clausen wrote:
> On 01/30/2015 09:30 AM, Dan Carpenter wrote:
> >Because of C's type promotion rules, the code shifts in
> >"((val16 & 0xFFF) << 4) >> 4;" cancel each other out and they're a
> >no-op.
> >
> >The intention here was to sign-extend then 11th bit so we can use the
> >sign_extend32() function.
> >
> >Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> >---
> >Please review this carefully.  I'm pretty sure it's correct but this is
> >the first time I've ever used the sign_extend32() function.
> 
> Hi,
> 
> Rasmus already fixed this a couple of days ago.
> 
> Thanks,
> - Lars

Oh.  Good.  I was CC'd on the other one that he fixed so I went looking
for other bugs and I found this one.

Rasmus, are you using a static checker?  Which one?

regards,
dan carpenter
