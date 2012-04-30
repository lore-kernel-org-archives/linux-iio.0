Return-Path: <dan.carpenter@oracle.com>
Date: Mon, 30 Apr 2012 23:18:56 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: joseph daniel <josephdanielwalter@gmail.com>
Cc: devel@driverdev.osuosl.org, Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wolfram Sang <w.sang@pengutronix.de>, linux-kernel@vger.kernel.org,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH] staging/iio/meter: fix the coding style problem
Message-ID: <20120430201855.GN6447@mwanda>
References: <1335813977-8096-1-git-send-email-josephdanielwalter@gmail.com>
 <20120430200444.GM6447@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120430200444.GM6447@mwanda>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Apr 30, 2012 at 11:04:44PM +0300, Dan Carpenter wrote:
> On Tue, May 01, 2012 at 01:26:17AM +0600, joseph daniel wrote:
> > 
> > Signed-off-by: joseph daniel <josephdanielwalter@gmail.com>
> > ---
> > Hi Lars,
> > 	Thanks for review. how about the below change?

Lar's review is the correct one.  It's cleaner to use
get_unaligned_be32().  You'll need to include <asm/unaligned.h>

regards,
dan carpenter
