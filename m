Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from axentia.se ([87.96.186.132]:46046 "EHLO EMAIL.axentia.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751231AbcDAFxV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 1 Apr 2016 01:53:21 -0400
From: Peter Rosin <peda@axentia.se>
To: Jonathan Cameron <jic23@kernel.org>,
	Slawomir Stepien <sst@poczta.fm>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"knaack.h@gmx.de" <knaack.h@gmx.de>,
	"lars@metafoo.de" <lars@metafoo.de>,
	"pmeerw@pmeerw.net" <pmeerw@pmeerw.net>
Subject: RE: [PATCH] iio: potentiometer: mcp4531: use pointer to access
 model parameters
Date: Fri, 1 Apr 2016 05:51:15 +0000
Message-ID: <6604872ea82842589376a2d2bc902822@EMAIL.axentia.se>
References: <20160324160601.GA7819@x220> <56F8FBD9.6030805@kernel.org>
In-Reply-To: <56F8FBD9.6030805@kernel.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Jonathan Cameron wrote:
> On 24/03/16 16:06, Slawomir Stepien wrote:
> > Use const pointer to element from model configuration array rather then array
> > index, as it will not change anyway.
> > 
> > Signed-off-by: Slawomir Stepien <sst@poczta.fm>
> Applied to the togreg branch of iio.git - initially pushed out as testing
> for the autobuilders to play with it.  Thanks for cleaning this up.

I guess it's too late, but FWIW,

Signed-off-by: Peter Rosin <peda@axentia.se>

Cheers,
Peter (mcp4531 maintainer)
