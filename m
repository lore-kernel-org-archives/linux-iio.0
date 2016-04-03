Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48786 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752555AbcDCJaH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 3 Apr 2016 05:30:07 -0400
Subject: Re: [PATCH] iio: potentiometer: mcp4531: use pointer to access model
 parameters
To: Peter Rosin <peda@axentia.se>, Slawomir Stepien <sst@poczta.fm>
References: <20160324160601.GA7819@x220> <56F8FBD9.6030805@kernel.org>
 <6604872ea82842589376a2d2bc902822@EMAIL.axentia.se>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"knaack.h@gmx.de" <knaack.h@gmx.de>,
	"lars@metafoo.de" <lars@metafoo.de>,
	"pmeerw@pmeerw.net" <pmeerw@pmeerw.net>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5700E29D.2030005@kernel.org>
Date: Sun, 3 Apr 2016 10:30:05 +0100
MIME-Version: 1.0
In-Reply-To: <6604872ea82842589376a2d2bc902822@EMAIL.axentia.se>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/04/16 06:51, Peter Rosin wrote:
> Jonathan Cameron wrote:
>> On 24/03/16 16:06, Slawomir Stepien wrote:
>>> Use const pointer to element from model configuration array rather then array
>>> index, as it will not change anyway.
>>>
>>> Signed-off-by: Slawomir Stepien <sst@poczta.fm>
>> Applied to the togreg branch of iio.git - initially pushed out as testing
>> for the autobuilders to play with it.  Thanks for cleaning this up.
> 
> I guess it's too late, but FWIW,
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
I haven't yet pushed it out as togreg (rather than testing) so nope, not too late.
Added to the patch.   Thanks

Jonathan
> 
> Cheers,
> Peter (mcp4531 maintainer)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

