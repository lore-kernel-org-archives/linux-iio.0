Return-Path: <dan.carpenter@oracle.com>
Date: Wed, 27 May 2015 12:35:28 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Daniel Baluta <daniel.baluta@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Tiberiu Breana <tiberiu.a.breana@intel.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [patch] iio: light: signedness bug in stk3310_write_raw()
Message-ID: <20150527093528.GG11734@mwanda>
References: <20150527082425.GB19423@mwanda>
 <CAEnQRZABSZh+XtoufmS2n_oFeEgB6z0bx+CxXEk+f6=tOcSXDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAEnQRZABSZh+XtoufmS2n_oFeEgB6z0bx+CxXEk+f6=tOcSXDA@mail.gmail.com>
List-ID: <linux-iio@vger.kernel.org>

On Wed, May 27, 2015 at 12:31:26PM +0300, Daniel Baluta wrote:
> On Wed, May 27, 2015 at 11:24 AM, Dan Carpenter
> <dan.carpenter@oracle.com> wrote:
> > "index" needs to be signed for the error handling to work.
> >
> > Fixes: be9e6229d676 ('iio: light: Add support for Sensortek STK3310')
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> Hi Dan,
> 
> Did you find this with a tool?

Yeah.  This is a Smatch thing.

regards,
dan carpenter
