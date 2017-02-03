Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:36662 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752388AbdBCMcG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Feb 2017 07:32:06 -0500
Date: Fri, 3 Feb 2017 13:32:09 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Slawomir Stepien <sst@poczta.fm>
Cc: apw@canonical.com, joe@perches.com, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: Re: [RFC] Resolving "false positive" error message from checkpatch.pl
Message-ID: <20170203123209.GA32306@kroah.com>
References: <20170203101135.GA3663@x220.localdomain>
 <20170203102707.GA8330@kroah.com>
 <20170203121020.GA8635@x220.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170203121020.GA8635@x220.localdomain>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Feb 03, 2017 at 01:10:20PM +0100, Slawomir Stepien wrote:
> On Feb 03, 2017 11:27, Greg KH wrote:
> > On Fri, Feb 03, 2017 at 11:11:35AM +0100, Slawomir Stepien wrote:
> > > Hi all
> > > 
> > > There is a "false positive" error reported by checkpatch.pl:
> > > 
> > > ERROR: Use 4 digit octal (0777) not decimal permissions
> > > #272: FILE: drivers/staging/iio/meter/ade7759.c:272:
> > > +static IIO_DEV_ATTR_CH_OFF(1, S_IWUSR | S_IRUGO,
> > > +		ade7759_read_8bit,
> > > +		ade7759_write_8bit,
> > > +		ADE7759_CH1OS);
> > > 
> > > ERROR: Use 4 digit octal (0777) not decimal permissions
> > > #276: FILE: drivers/staging/iio/meter/ade7759.c:276:
> > > +static IIO_DEV_ATTR_CH_OFF(2, S_IWUSR | S_IRUGO,
> > > +		ade7759_read_8bit,
> > > +		ade7759_write_8bit,
> > > +		ADE7759_CH2OS);
> > > 
> > > The same for the file drivers/staging/iio/meter/ade7753.c.
> > > 
> > > We can see that this macro is matched by the pattern "IIO_DEV_ATTR_[A-Z_]+" from
> > > @mode_permission_funcs in checkpatch.pl.
> > > 
> > > My question is: how this should be fixed?
> > 
> > Why do you think this is a false-positive?
> 
> Because the 1st arg of that macro is not supposed to be a permissions flags.

Ah. I was thinking that the S_IWUSR needs to be replaced with an octal
value :)

thanks,

greg k-h
