Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtpo.poczta.interia.pl ([217.74.65.208]:38308 "EHLO
	smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934130AbcCPUDx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 16 Mar 2016 16:03:53 -0400
Date: Wed, 16 Mar 2016 21:04:34 +0100
From: Slawomir Stepien <sst@poczta.fm>
To: Daniel Baluta <daniel.baluta@gmail.com>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: add driver for Microchip MCP414X/416X/424X/426X
Message-ID: <20160316200434.GC6212@x220>
References: <20160316113738.GB2445@x220>
 <alpine.DEB.2.02.1603161238590.30358@pmeerw.net>
 <20160316162544.GA6212@x220>
 <CAEnQRZAtpANGBsuYFuMD+tstrYc7YfeO117BYP-990vB144UbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAEnQRZAtpANGBsuYFuMD+tstrYc7YfeO117BYP-990vB144UbQ@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mar 16, 2016 20:28, Daniel Baluta wrote:
> On Wed, Mar 16, 2016 at 6:25 PM, Slawomir Stepien <sst@poczta.fm> wrote:
> > On Mar 16, 2016 13:30, Peter Meerwald-Stadler wrote:
> >> On Wed, 16 Mar 2016, Slawomir Stepien wrote:
> >>
> >> > The following functionalities are supported:
> >> >  - write, read from volatile and non volatile memory
> >> >  - increase and decrease commands
> >> >  - read from status register
> >> >  - write and read to tcon register
> >> >
> >> > Datasheet: http://ww1.microchip.com/downloads/en/DeviceDoc/22059b.pdf
> >
> > Thank you for all your comments.
> >
> >> the driver naming is a mess: the subject says MCP414X, the file name is
> >> mcp41xx, the DT compatible string says mcp4113x -- this does not match
> >
> > OK. I will change that to mcp414x in version 2.
> 
> Filename shouldn't be generic (e.g ending with xx). It should be a
> specific chip name
> (a good candidate is the first in alphabetical order), because there
> could be chips falling
> in the same name category but with a different driver.

OK got it. Please wait for the version 2.

-- 
Slawomir Stepien
