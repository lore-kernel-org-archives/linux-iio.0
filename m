Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:40516 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752817Ab3LXBua (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 23 Dec 2013 20:50:30 -0500
From: Marek Vasut <marex@denx.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCHv5 RESEND 0/4] iio: mxs-lradc: add support to optional divider_by_two
Date: Tue, 24 Dec 2013 02:50:00 +0100
Cc: Jonathan Cameron <jic23@kernel.org>, lars@metafoo.de,
	harald@ccbib.org, hector.palacios@digi.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1387820884-28140-1-git-send-email-alexandre.belloni@free-electrons.com> <201312231954.36124.marex@denx.de> <52B88D5C.4080402@free-electrons.com>
In-Reply-To: <52B88D5C.4080402@free-electrons.com>
MIME-Version: 1.0
Message-Id: <201312240250.00629.marex@denx.de>
Content-Type: Text/Plain;
  charset="us-ascii"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Monday, December 23, 2013 at 08:22:04 PM, Alexandre Belloni wrote:
> On 23/12/2013 19:54, Marek Vasut wrote:
> > On Monday, December 23, 2013 at 06:48:00 PM, Alexandre Belloni wrote:
> >> Hello,
> >> 
> >> This is v5 of the patchset that adds support to the optional
> >> divider_by_two of LRADC channels.
> >> 
> >> Changes since v4:
> >>  - moved enum mxs_lradc_divbytwo to the third patch
> >>  - added a fourth patch to convert is_divided to a bitmap. I did that in
> >>  a
> >>  
> >>    separated patch for review and copyright attribution purposes.
> >> 
> >> This was tested on a custom i.MX28 platform.
> >> 
> >> Alexandre Belloni (1):
> >>   iio: mxs-lradc: convert is_divided to a bitmap
> >> 
> >> Hector Palacios (3):
> >>   iio: mxs-lradc: add scale attribute to channels
> >>   iio: mxs-lradc: add scale_available file to channels
> >>   iio: mxs-lradc: add write_raw function to modify scale
> >>  
> >>  drivers/staging/iio/adc/mxs-lradc.c | 222
> >> 
> >> +++++++++++++++++++++++++++++++++++- 1 file changed, 219 insertions(+),
> >> 3 deletions(-)
> > 
> > Why is there a resend please ?
> 
> I don't know how but I screwed Jonathan's mail address. As he is the
> main maintainer, I though it would be a good idea to get his attention.

Ah, now I see that ^C there :)

btw. I wish you a Merry Christmas and a happy New Year, guys!

Best regards,
Marek Vasut
