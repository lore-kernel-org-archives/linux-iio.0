Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:56644 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753860AbcJPCZR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 15 Oct 2016 22:25:17 -0400
Date: Sat, 15 Oct 2016 22:25:15 -0400
From: Brian Masney <masneyb@onstation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: Re: [PATCH v2 8/8] staging: iio: isl29018: move out of staging
Message-ID: <20161016022515.GA31998@basecamp.onstation.org>
References: <1476084002-29683-1-git-send-email-masneyb@onstation.org>
 <1476084002-29683-9-git-send-email-masneyb@onstation.org>
 <ca556582-a736-e6d3-36e1-72e649f51df1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ca556582-a736-e6d3-36e1-72e649f51df1@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Oct 15, 2016 at 04:15:57PM +0100, Jonathan Cameron wrote:
> On 10/10/16 08:20, Brian Masney wrote:
> > Move ISL29018/ISL29023/ISL29035 driver out of staging into mainline.
> > 
> > Signed-off-by: Brian Masney <masneyb@onstation.org>
> Applied to the togreg branch of iio.git and pushed out as testing
> for the autobuilders to play with it.
> 
> Thanks Brian for taking this one on and your hard work on getting
> these last few little issues sorted so it can graduate from staging.

Thanks, Jonathan for all of your feedback. I'm going to send you a patch
set sometime this week against the light/tsl2583.c driver to work
towards eventually moving it out of staging.

I also looked at the light/isl29028.c driver. It doesn't look like it
needs much to move out of staging. A few very minor code style cleanups,
and the device tree documentation. If you have time, could you take a
brief look to see if it needs any major changes? I'll be glad to take on
the grunt work to clean up that driver as well.

Brian

