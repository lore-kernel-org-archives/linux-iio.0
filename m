Return-Path: <SRS0=Y9NC=5S=oracle.com=dan.carpenter@kernel.org>
Date: Tue, 13 Jun 2017 11:39:05 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lee Jones <lee.jones@linaro.org>, Marek Vasut <marex@denx.de>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: adc: mxs-lradc: Checking IS_ERR() instead of NULL
Message-ID: <20170613083905.7aiaxvfjg2ypkfq2@mwanda>
References: <20170426210349.sjmf65ck5awfgz22@mwanda>
 <13f3bcd0-c6c8-7abc-d732-91a19618f5a5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <13f3bcd0-c6c8-7abc-d732-91a19618f5a5@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Thu, Apr 27, 2017 at 07:21:09AM +0100, Jonathan Cameron wrote:
> On 26/04/17 22:03, Dan Carpenter wrote:
> > devm_ioremap() returns NULL on error.  It doesn't return error pointers.
> > 
> > Fixes: 6dd112b9f85e ("iio: adc: mxs-lradc: Add support for ADC driver")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > 
> Hi Dan,
> 
> Already another patch for this under review.  Open question there is whether
> devm_ioremap_resource is the way to go instead.
> 

I wasn't on that other thread...  Nothing appears to have happened with
this or the touchscreen bug either.

regards,
dan carpenter
