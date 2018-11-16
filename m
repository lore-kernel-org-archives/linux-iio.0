Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtpo.poczta.interia.pl ([217.74.65.153]:50929 "EHLO
        smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727727AbeKPW20 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 16 Nov 2018 17:28:26 -0500
Date: Fri, 16 Nov 2018 13:16:38 +0100
From: Slawomir Stepien <sst@poczta.fm>
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, knaack.h@gmx.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/2] Use OF API to get the driver data
Message-ID: <20181116121638.GA10192@x220.localdomain>
References: <20181116094722.1070-1-sst@poczta.fm>
 <20181116114615.3caec263@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181116114615.3caec263@archlinux>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On lis 16, 2018 11:46, Jonathan Cameron wrote:
> On Fri, 16 Nov 2018 10:47:20 +0100
> Slawomir Stepien <sst@poczta.fm> wrote:
> 
> > This patch series will change how the driver finds out the device data. Now it
> > will first try to use OF API and then, if needed, fallback to the spi framework
> > capabilities.
> 
> Hi Slawomir.

Hi

> A quick process point.  The cover letter should definitely mention the driver
> the patch is changing.

Oops, sorry for that!

> iio:potentiometer:mcp4131: Use OF API to get the driver data.
> 
> No need to resend for that though, just one for future reference!
> 
> Thanks,
> 
> Jonathan
> > 
> > Slawomir Stepien (2):
> >   iio: potentiometer: mcp4131: use of_device_get_match_data()
> >   iio: potentiometer mcp4131: use spi_get_device_id() only when needed
> > 
> >  drivers/iio/potentiometer/mcp4131.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)

-- 
Slawomir Stepien
