Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:34816 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755278Ab2I0SXF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 27 Sep 2012 14:23:05 -0400
Received: by dady13 with SMTP id y13so449264dad.19
        for <linux-iio@vger.kernel.org>; Thu, 27 Sep 2012 11:23:05 -0700 (PDT)
Date: Thu, 27 Sep 2012 11:23:01 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Senna Tschudin <peter.senna@gmail.com>,
	Marek Vasut <marex@denx.de>, trivial@kernel.org,
	jic23@cam.ac.uk, michael.hennerich@analog.com,
	w.sang@pengutronix.de, sfr@canb.auug.org.au, pmeerw@pmeerw.net,
	shubhrajyoti@ti.com, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] drivers/staging/iio: Remove unnecessary semicolon
Message-ID: <20120927182301.GA24086@kroah.com>
References: <1348748175-11803-1-git-send-email-peter.senna@gmail.com>
 <1348752425-12818-1-git-send-email-peter.senna@gmail.com>
 <201209271544.06716.marex@denx.de>
 <CA+MoWDokfgH45TzB+bBqVasd67isq5sStXyRrLh-863V_DjUaA@mail.gmail.com>
 <506498F3.5050901@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <506498F3.5050901@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Sep 27, 2012 at 08:20:35PM +0200, Lars-Peter Clausen wrote:
> On 09/27/2012 04:40 PM, Peter Senna Tschudin wrote:
> >>
> >> The semantic patch is missing again ;-)
> > 
> > I know. The problem is that some people do not like to see semantic
> > patches on the message, so I do not include it always... 
> 
> But this is really the most important part of the commit message for
> auto-generated patches. How can I reproduce the changes made by the commit.
> Just "Found by http://coccinelle.lip6.fr/" is kind of pointless in my opinion.

I agree, please put the semantic stuff in the patch, like others do.

greg k-h
