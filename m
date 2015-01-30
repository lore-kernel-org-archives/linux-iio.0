Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:31816 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752195AbbA3KXx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 30 Jan 2015 05:23:53 -0500
Date: Fri, 30 Jan 2015 13:23:38 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [patch] iio: imu: adis16400: Fix sign extension
Message-ID: <20150130102338.GW6456@mwanda>
References: <20150130083058.GD21357@mwanda>
 <54CB41F9.1060800@metafoo.de>
 <20150130092250.GK6507@mwanda>
 <87r3ucty0k.fsf@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87r3ucty0k.fsf@rasmusvillemoes.dk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Jan 30, 2015 at 10:31:55AM +0100, Rasmus Villemoes wrote:
> On Fri, Jan 30 2015, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> 
> > Rasmus, are you using a static checker?  Which one?
> 
> Sort of:
> 
> https://github.com/Villemoes/linux-cocci/blob/master/misc/sign_extend.cocci
> 

Did you find the bug in fm10k_update_xc_addr_pf()?  That's the other bug
I found.

regards,
dan carpenter

