Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:52215 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753040AbcE2S22 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 29 May 2016 14:28:28 -0400
Date: Sun, 29 May 2016 20:28:25 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: Documentation: fix in_*_scale kernel version
Message-ID: <20160529182825.GN3451@piout.net>
References: <1463923848-13157-1-git-send-email-alexandre.belloni@free-electrons.com>
 <97b740bd-9559-fbf0-d27f-3c512409226d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <97b740bd-9559-fbf0-d27f-3c512409226d@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/05/2016 at 17:59:33 +0100, Jonathan Cameron wrote :
> On 22/05/16 14:30, Alexandre Belloni wrote:
> > v3.21 doesn't exist, the first apparition of a in_.*_scale file was in v3.2
> > 
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Not that simple as this explicitly in_*_scale in the events directory.
> First instance of that is much newer.
> 
> This should probably be 4.0 - which fits with when the docs were added and this
> patch formed part of a series of enhancements for the mma8452 driver back then.
> 

True, I missed the events part of the directory. I'll switch that to
4.0.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
