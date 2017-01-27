Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.fastquake.com ([45.33.83.177]:35988 "EHLO
        mail.fastquake.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750900AbdA0BeU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Jan 2017 20:34:20 -0500
Date: Fri, 27 Jan 2017 01:33:43 +0000
From: John Brooks <john@fastquake.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Harald Geyer <harald@ccbib.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: dht11: Use usleep_range instead of msleep for start
 signal
Message-ID: <20170127013343.GA8964@oldkitsune.fastquake.com>
References: <20170118215008.GA12173@oldkitsune.fastquake.com>
 <E1cUAqD-0000MZ-0T@stardust.g4.wien.funkfeuer.at>
 <03e7614a-8f7f-e4f4-07cd-d1c591480239@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <03e7614a-8f7f-e4f4-07cd-d1c591480239@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Jan 22, 2017 at 01:36:47PM +0000, Jonathan Cameron wrote:
> Agreed.  Any chance you can do a bisection on this John?
> 
> Either way - defence in depth!
> Applied to the fixes-togreg branch of iio.git.
> 
> thanks,
> 
> Jonathan

It's my first bug fixing kernel patch; I'm very happy to see it applied :)

I would like to bisect this. It's a bit of a pain because I'll need to branch
and apply all the RPi kernel patches every step of the way. If I find the time,
I will do it.
