Return-Path: <SRS0=QN+I=GD=oracle.com=dan.carpenter@kernel.org>
Date: Tue, 13 Mar 2018 11:16:25 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh@kernel.org>, Paolo Cretaro <paolocretaro@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>, linux-iio@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: adc: meson-saradc: unlock on error in
 meson_sar_adc_lock()
Message-ID: <20180313081625.wscndeuo4yy6etw4@mwanda>
References: <20180308093153.GB16525@mwanda>
 <CAFBinCCV7ioofBc7MU6mr4JrVQPMZfMG-kFPB6bcFCJNoMrPPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAFBinCCV7ioofBc7MU6mr4JrVQPMZfMG-kFPB6bcFCJNoMrPPA@mail.gmail.com>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Mar 12, 2018 at 09:43:19PM +0100, Martin Blumenstingl wrote:
> Hi Dan,
> 
> On Thu, Mar 8, 2018 at 10:31 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > The meson_sar_adc_lock() function is not supposed to hold the
> > "indio_dev->mlock" on the error path.
> >
> > Fixes: 3adbf3427330 ("iio: adc: add a driver for the SAR ADC found in Amlogic Meson SoCs")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Acked-by: Martin Blumenstingl<martin.blumenstingl@googlemail.com>
> 
> (even if I might be too late already since Jonathan already applied this patch)
> 
> thank you for finding and fixing this!
> out of curiosity: did you find this with some tool (sparse?) or by
> looking at the code?
> 

This was some Smatch stuff that I haven't pushed.  I re-wrote the
locking check to use cross function analysis, and it actually warns
about the callers not meson_sar_adc_lock().  That code works ok
basically for locks but it generates a ton of false positives about
double unlocks so I haven't pushed it.

regards,
dan carpenter
