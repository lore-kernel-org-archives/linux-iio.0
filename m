Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:58322 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933813AbcKMQSD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Nov 2016 11:18:03 -0500
Date: Sun, 13 Nov 2016 11:18:00 -0500
From: Brian Masney <masneyb@onstation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org, lars@metafoo.de, pmeerw@pmeerw.net,
        knaack.h@gmx.de, linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
Subject: Re: [PATCH v4 26/26] staging: iio: tsl2583: move out of staging
Message-ID: <20161113161800.GA7421@basecamp.onstation.org>
References: <1478974781-1457-1-git-send-email-masneyb@onstation.org>
 <1478974781-1457-27-git-send-email-masneyb@onstation.org>
 <539c4034-fb5c-f92b-4bf3-31e31043f4ea@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <539c4034-fb5c-f92b-4bf3-31e31043f4ea@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Nov 13, 2016 at 12:57:25PM +0000, Jonathan Cameron wrote:
> On 12/11/16 18:19, Brian Masney wrote:
> > Move tsl2580, tsl2581, tsl2583 driver out of staging into mainline.
> > 
> > Signed-off-by: Brian Masney <masneyb@onstation.org>
> I had another read through on this one.  A few oddites.
> 
> I fixed up the indentation one way back in your patch fixing alignment.
> Made applying this patch more entertaining than it should have been but
> I think got that right in the end.
> 
> Can't find myself caring enough about the unused data element in that
> id table to hold this patch on that so...
> 
> Applied to the togreg branch of iio.git and pushed out as testing for
> the autobuilders to play with it.
> 
> Thanks for all your hard work on this!

Thanks Jonathan for all of your feedback and working with me on this. I
learned a lot cleaning up this driver.

I'm going to work on the ISL29028 light driver next since I have one
mounted on a breakout board. The driver appears to not need any major
work so it should be easy.

After that, I'm taking requests for an existing IIO staging driver to
clean up. I'm looking for a driver that needs more than just style
cleanups (like this driver that I just finished). Ideally, one where
a company or person could loan me the sensor. I'll mail it back when
I am finished. Otherwise, I'll see what I can pick up for low cost on
Digikey that has an existing staging driver that meets my criteria.

Brian

