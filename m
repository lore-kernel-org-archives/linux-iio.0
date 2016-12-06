Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:49702 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751201AbcLFAKr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 5 Dec 2016 19:10:47 -0500
Date: Mon, 5 Dec 2016 19:10:45 -0500
From: Brian Masney <masneyb@onstation.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, lars@metafoo.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        ldewangan@nvidia.com, pmeerw@pmeerw.net, knaack.h@gmx.de
Subject: Re: [PATCH 12/19] staging: iio: isl29028: fix comparison between
 signed and unsigned integers
Message-ID: <20161206001045.GA29358@basecamp.onstation.org>
References: <1480817983-32359-1-git-send-email-masneyb@onstation.org>
 <1480817983-32359-13-git-send-email-masneyb@onstation.org>
 <20161205205339.GC31243@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161205205339.GC31243@mwanda>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Dec 05, 2016 at 11:53:39PM +0300, Dan Carpenter wrote:
> On Sat, Dec 03, 2016 at 09:19:36PM -0500, Brian Masney wrote:
> > Fixed warning found by make W=2 to reduce the amount of build noise:
> > 
> > warning: comparison between signed and unsigned integer expressions
> > [-Wsign-compare]
> 
> Ugh...  Please don't do work arounds for nonsense warnings.  W=2 is so
> stupid.  Better to just grep -v this warning instead of trying to please
> a broken static analysis.  Warnings like this are why it's disabled by
> default.

Hi Dan,
   I would normally agree, however there could be a case where this
warning flags a legitimate issue. It is obviously not an issue in this
case. Since I'm already working on cleaning up this driver to move it
out of staging, I figured that I would make sure that it builds cleanly
with W=2. This was the only warning found in that driver. The
change is harmless in my opinion and it may eliminate a nonsense warning
for someone else down the road when doing security audits.

   This driver doesn't need much to move it out of staging. Most of the
patches in this series were trivial cleanups and not interesting at all.
Since I already have one of these devices, I figured that I'd do the
grunt work to get it out of staging. My goal with the upcoming final
patch that moves it out of staging is to reduce the amount of code churn
in the driver once it graduates from staging.

Brian

