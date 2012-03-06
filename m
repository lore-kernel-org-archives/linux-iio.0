Return-Path: <rdunlap@xenotime.net>
Message-ID: <4F565CB0.8070301@xenotime.net>
Date: Tue, 06 Mar 2012 10:51:28 -0800
From: Randy Dunlap <rdunlap@xenotime.net>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
CC: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Jonathan Cameron <jic23@cam.ac.uk>,
 linux-iio@vger.kernel.org
Subject: Re: linux-next: Tree for Mar 6 (staging/iio)
References: <20120306180746.25c595babf8b5072366cdbec@canb.auug.org.au>
In-Reply-To: <20120306180746.25c595babf8b5072366cdbec@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 03/05/2012 11:07 PM, Stephen Rothwell wrote:

> Hi all,
> 
> Changes since 20120305:


When CONFIG_DEBUG_FS is not enabled:

drivers/staging/iio/industrialio-core.c:621:11: error: 'iio_read_channel_ext_info' undeclared (first use in this function)
drivers/staging/iio/industrialio-core.c:623:11: error: 'iio_write_channel_ext_info' undeclared (first use in this function)




-- 
~Randy
