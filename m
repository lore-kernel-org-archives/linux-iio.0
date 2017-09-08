Return-Path: <SRS0=S94w=AJ=huawei.com=jonathan.cameron@kernel.org>
Date: Fri, 8 Sep 2017 10:32:57 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
CC: Himanshi Jain <himshijain.hj@gmail.com>,
        <outreachy-kernel@googlegroups.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <jic23@kernel.org>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <gregkh@linuxfoundation.org>,
        <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Staging: iio: adc: Added Space around binary op.
Message-ID: <20170908103257.00002165@huawei.com>
In-Reply-To: <DEB4AC67-43D5-40F9-9495-DB4966A07661@jic23.retrosnub.co.uk>
References: <20170908044752.GA6199@himanshi-Inspiron-5558>
	<DEB4AC67-43D5-40F9-9495-DB4966A07661@jic23.retrosnub.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
List-ID: <linux-iio@vger.kernel.org>

On Fri, 8 Sep 2017 07:29:06 +0100
Jonathan Cameron <jic23@jic23.retrosnub.co.uk> wrote:

> On 8 September 2017 05:47:52 BST, Himanshi Jain <himshijain.hj@gmail.com> wrote:
> >Added space around(one on each side of) binary
> >operator(-) as preferred according to kernel
> >coding style.
> >
> >Signed-off-by: Himanshi Jain <himshijain.hj@gmail.com>  
> 
> Take a closer look at that macro. It isn't doing what you think...  
> To give a hint, changing this breaks userspace.

Ok, I'm bored of this particular one coming up. When you have
worked out what is going on Himanshi, would you mind putting
together a patch adding a comment describing why it is a bad
idea to 'fix' this?  That would be a very useful patch as
far as I'm concerned :)

There aren't that many cases of this in IIO so adding a comment
on each of them is probably reasonable just to avoid wasting
people's time on fixing them! (I think we have had more than
5 such goes this year so far...)

Jonathan

> 
> Jonathan
> 
> 
> >---
> > drivers/staging/iio/adc/ad7192.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/drivers/staging/iio/adc/ad7192.c
> >b/drivers/staging/iio/adc/ad7192.c
> >index d11c6de..1aee662 100644
> >--- a/drivers/staging/iio/adc/ad7192.c
> >+++ b/drivers/staging/iio/adc/ad7192.c
> >@@ -341,7 +341,7 @@ static int ad7192_setup(struct ad7192_state *st,
> > }
> > 
> > static IIO_DEVICE_ATTR_NAMED(in_v_m_v_scale_available,
> >-			     in_voltage-voltage_scale_available,
> >+			     in_voltage - voltage_scale_available,
> > 			     0444, ad7192_show_scale_available, NULL, 0);
> > 
> > static IIO_DEVICE_ATTR(in_voltage_scale_available, 0444,  
> 
