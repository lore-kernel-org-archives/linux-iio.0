Return-Path: <rdunlap@xenotime.net>
Message-ID: <4FFD1458.6000404@xenotime.net>
Date: Tue, 10 Jul 2012 22:51:20 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
CC: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>,
 Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: linux-next: Tree for July 10 (iio)
References: <20120710174320.3b7dd806e20ee74ca1b1685f@canb.auug.org.au>
In-Reply-To: <20120710174320.3b7dd806e20ee74ca1b1685f@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 07/10/2012 12:43 AM, Stephen Rothwell wrote:

> Hi all,
> 
> Changes since 20120709:
> 



on x86_64:

drivers/iio/dac/ad5064.c: In function 'ad5064_i2c_write':
drivers/iio/dac/ad5064.c:132:2: error: implicit declaration of function 'i2c_master_send'




-- 

~Randy
