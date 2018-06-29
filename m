Return-Path: <SRS0=4lva=JP=oracle.com=dan.carpenter@kernel.org>
Date: Fri, 29 Jun 2018 10:45:33 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Karim Eshapa <karim.eshapa@gmail.com>
Cc: lars@metafoo.de, devel@driverdev.osuosl.org, Michael.Hennerich@analog.com,
        linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, pmeerw@pmeerw.net, knaack.h@gmx.de,
        jic23@kernel.org
Subject: Re: [PATCH 4/4] staging:iio:adc:ad7280a: Use GFP_ATOMIC in interrupt
 handler
Message-ID: <20180629074532.cbwwjx2lh6cc3f72@mwanda>
References: <20180628234928.4205-1-karim.eshapa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180628234928.4205-1-karim.eshapa@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

On Fri, Jun 29, 2018 at 01:49:28AM +0200, Karim Eshapa wrote:
> Use GFP_ATOMIC rather GFP_KERNEL in interrupt handler,
> as GFP_KERNEL may sleep according to slab allocator.
> 

This is a threaded IRQ so it can sleep.

You should always think about the impact of a bug.  If this were a bug
it would have showed up in testing right away.  Most of my patches are
in error handling and so the impact is zero unless you deliberately try
to inject errors that's why they can go undetected for years.

Also you should always use the Fixes tag to see how the patch was
introduced.  I often see bugs where the patch is new and it was
introduced by someone doing major subsystem cleanups and they don't have
the hardware so I know it hasn't been tested.  If the patch is a couple
years old and the bug is in the success path which every one tests then
I wonder if I am misreading the code somehow.

regards,
dan carpenter
