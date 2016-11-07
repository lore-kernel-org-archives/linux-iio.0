Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtpo.poczta.interia.pl ([217.74.65.206]:36334 "EHLO
        smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932411AbcKGRWI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Nov 2016 12:22:08 -0500
Date: Mon, 7 Nov 2016 17:46:41 +0100
From: Slawomir Stepien <sst@poczta.fm>
To: Peter Rosin <peda@axentia.se>
Cc: Daniel Baluta <daniel.baluta@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 1/8] iio:core: add a callback to allow drivers to
 provide _available attributes
Message-ID: <20161107164641.GA29162@x220.localdomain>
References: <1477262381-7800-1-git-send-email-peda@axentia.se>
 <1477262381-7800-2-git-send-email-peda@axentia.se>
 <CAEnQRZDgF-x6rNiS1Uv9Evdt1sVfUu9pMF98Z4=r-vKP52C1kA@mail.gmail.com>
 <62f150ba-abc0-8e45-1355-8a61354ee3e1@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <62f150ba-abc0-8e45-1355-8a61354ee3e1@axentia.se>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Nov 07, 2016 12:57, Peter Rosin wrote:
> On 2016-11-07 12:37, Daniel Baluta wrote:
> > On Mon, Oct 24, 2016 at 1:39 AM, Peter Rosin <peda@axentia.se> wrote:
> >> From: Jonathan Cameron <jic23@kernel.org>
> >>
> >> A large number of attributes can only take a limited range of values.
> >> Currently in IIO this is handled by directly registering additional
> >> *_available attributes thus providing this information to userspace.
> >>
> >> It is desirable to provide this information via the core for much the same
> >> reason this was done for the actual channel information attributes in the
> >> first place.  If it isn't there, then it can only really be accessed from
> >> userspace.  Other in kernel IIO consumers have no access to what valid
> >> parameters are.
> >>
> >> Two forms are currently supported:
> >> * list of values in one particular IIO_VAL_* format.
> >>         e.g. 1.300000 1.500000 1.730000
> >> * range specification with a step size:
> >>         e.g. [1.000000 0.500000 2.500000]
> >>         equivalent to 1.000000 1.5000000 2.000000 2.500000
> > 
> > Is there any driver using this format? :)
> 
> Yes, soon. Hopefully. See patch 3/8
> iio: mcp4531: provide range of available raw values
> https://patchwork.kernel.org/patch/9391283/

I would also like to add this to mcp4131.c and ds1803.c.

-- 
Slawomir Stepien
