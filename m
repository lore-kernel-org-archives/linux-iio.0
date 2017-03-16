Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtpauth-dc2.online.net ([62.210.16.40]:49459 "EHLO
        smtpauth-dc2-1.online.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751535AbdCPRMx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Mar 2017 13:12:53 -0400
Date: Thu, 16 Mar 2017 18:12:44 +0100
From: Miguel Robles <miguel.robles@farole.net>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] Staging: iio: frequency: use octal permissions instead
 of symbolic
Message-ID: <20170316171243.GA10334@miguel-Z170X-UD5-TH>
References: <1489672056-7957-1-git-send-email-miguel.robles@farole.net>
 <20170316140555.GB30080@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170316140555.GB30080@kroah.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Mar 16, 2017 at 11:05:55PM +0900, Greg KH wrote:
> On Thu, Mar 16, 2017 at 02:47:36PM +0100, Miguel Robles wrote:
> > Fix checkpatch warnings:
> > Symbolic permissions are not preferred. Consider using octal permissions.
> > 
> > Signed-off-by: Miguel Robles <miguel.robles@farole.net>
> > ---
> >  drivers/staging/iio/frequency/ad9832.c | 20 ++++++++++----------
> >  drivers/staging/iio/frequency/ad9834.c | 22 +++++++++++-----------
> >  drivers/staging/iio/frequency/dds.h    |  2 +-
> >  3 files changed, 22 insertions(+), 22 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> > index 8d40c8e..163a4ef 100644
> > --- a/drivers/staging/iio/frequency/ad9832.c
> > +++ b/drivers/staging/iio/frequency/ad9832.c
> > @@ -248,22 +248,22 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
> >   * see dds.h for further information
> >   */
> >  
> > -static IIO_DEV_ATTR_FREQ(0, 0, S_IWUSR, NULL, ad9832_write, AD9832_FREQ0HM);
> > -static IIO_DEV_ATTR_FREQ(0, 1, S_IWUSR, NULL, ad9832_write, AD9832_FREQ1HM);
> > -static IIO_DEV_ATTR_FREQSYMBOL(0, S_IWUSR, NULL, ad9832_write, AD9832_FREQ_SYM);
> > +static IIO_DEV_ATTR_FREQ(0, 0, 0200, NULL, ad9832_write, AD9832_FREQ0HM);
> > +static IIO_DEV_ATTR_FREQ(0, 1, 0200, NULL, ad9832_write, AD9832_FREQ1HM);
> > +static IIO_DEV_ATTR_FREQSYMBOL(0, 0200, NULL, ad9832_write, AD9832_FREQ_SYM);
> 
> Meta-comment, would a IIO_DEV_ATTR_WO_FREQ() and friends help out here?
> That way it's impossible to get the permission values incorrect.
>
Hi Greg

I Agree with it and regarding that the macros IIO_DEV_ATTR_[FREQ, FREQSYMBOL,
PHASE, PHASESYMBOL, PINCONTROL_EN, OUT_ENABLE, OUTY_ENABLE] are only used
with "0200" permission in ad9832.c and ad9834.c files.
So, if everyone is fine with it, I could rename these macros this way
IIO_DEV_ATTR_WO_***.

Miguel
> thanks,
> 
> greg k-h
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
