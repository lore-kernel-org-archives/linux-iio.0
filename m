Return-Path: <rdunlap@xenotime.net>
Message-ID: <4E94AADA.4080204@xenotime.net>
Date: Tue, 11 Oct 2011 13:45:14 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
CC: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Jonathan Cameron <jic23@cam.ac.uk>,
 linux-iio@vger.kernel.org,
 "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
 Greg KH <gregkh@suse.de>
Subject: Re: linux-next: Tree for Oct 11 (iio/resolver)
References: <20111011201127.455df266dcbffb1d621f8576@canb.auug.org.au>
In-Reply-To: <20111011201127.455df266dcbffb1d621f8576@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 10/11/11 02:11, Stephen Rothwell wrote:
> Hi all,
> 
> The linux-next tree is now available from
> git://github.com/sfrothwell/linux-next.git as a temporary measure while
> the kernel.org servers are unavailable.
> 
> It may also turn up on git.kernel.org (depending on the mirroring).  The
> patch set is still absent, however.
> 
> Changes since 20111007:

When no GPIO support is enabled:

drivers/staging/iio/resolver/ad2s1210.c:657:14: error: array type has incomplete element type
drivers/staging/iio/resolver/ad2s1210.c:665:44: warning: type defaults to 'int' in type name
drivers/staging/iio/resolver/ad2s1210.c:665:44: warning: type defaults to 'int' in type name
drivers/staging/iio/resolver/ad2s1210.c:665:44: error: negative width in bit-field '<anonymous>'
drivers/staging/iio/resolver/ad2s1210.c:671:14: error: array type has incomplete element type
drivers/staging/iio/resolver/ad2s1210.c:679:34: warning: type defaults to 'int' in type name
drivers/staging/iio/resolver/ad2s1210.c:679:34: warning: type defaults to 'int' in type name
drivers/staging/iio/resolver/ad2s1210.c:679:34: error: negative width in bit-field '<anonymous>'



-- 
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
