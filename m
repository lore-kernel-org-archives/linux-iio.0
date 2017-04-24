Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f172.google.com ([209.85.128.172]:33443 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1169081AbdDXLCo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Apr 2017 07:02:44 -0400
Received: by mail-wr0-f172.google.com with SMTP id w50so66048827wrc.0
        for <linux-iio@vger.kernel.org>; Mon, 24 Apr 2017 04:02:44 -0700 (PDT)
Date: Mon, 24 Apr 2017 12:02:39 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>, sre@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org,
        linux@armlinux.org.uk, maxime.ripard@free-electrons.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        icenowy@aosc.xyz, liam@networkimprov.net,
        thomas.petazzoni@free-electrons.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [GIT PULL] Immutable branch between MFD and IIO due for the
 v4.12 merge window
Message-ID: <20170424110239.cv5nylgvymhwvg4w@dell>
References: <20170404063441.7656-1-quentin.schulz@free-electrons.com>
 <20170411100528.2zif3fyi7uoyw33n@dell>
 <0f30afec-ff42-e125-96d6-35893324f7ef@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <0f30afec-ff42-e125-96d6-35893324f7ef@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 14 Apr 2017, Jonathan Cameron wrote:

> On 11/04/17 11:05, Lee Jones wrote:
> > Enjoy!
> > 
> > The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:
> > 
> >   Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-iio-v4.12
> > 
> > for you to fetch changes up to f2499ab450d3052097ba53a7d763f767935c0c59:
> > 
> >   iio: adc: add support for X-Powers AXP20X and AXP22X PMICs ADCs (2017-04-11 11:02:33 +0100)
> > 
> > ----------------------------------------------------------------
> > Immutable branch between MFD and IIO due for the v4.12 merge window
> > 
> > ----------------------------------------------------------------
> > Quentin Schulz (1):
> >       iio: adc: add support for X-Powers AXP20X and AXP22X PMICs ADCs
> > 
> >  drivers/iio/adc/Kconfig      |  10 +
> >  drivers/iio/adc/Makefile     |   1 +
> >  drivers/iio/adc/axp20x_adc.c | 617 +++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 628 insertions(+)
> >  create mode 100644 drivers/iio/adc/axp20x_adc.c
> > 
> Hi Lee, 
> 
> Thanks for doing this, but the reason it was going to go through your
> tree in the first place was a dependency on
> commit 4707274714ef ("mfd: axp20x: Correct name of temperature data ADC registers")
> 
> Not present in the immutable branch.
> 
> There isn't much time for anything else going on around this driver though
> so other than a possible merge conflict on the Kconfig and Makefile shouldn't
> matter if this just goes through mfd. (famous last words ;)

It's not as though you committed it to text and sent it out to a
public mailing list for us all to reference though is it?  Doh!

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
