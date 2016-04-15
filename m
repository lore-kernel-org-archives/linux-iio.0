Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.aswsp.com ([193.34.35.150]:47697 "EHLO mail.aswsp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751242AbcDOOfd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 15 Apr 2016 10:35:33 -0400
Date: Fri, 15 Apr 2016 16:35:26 +0200
From: Gregor Boirie <gregor.boirie@parrot.com>
To: Crestez Dan Leonard <leonard.crestez@intel.com>
CC: Lars-Peter Clausen <lars@metafoo.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: generic_buffer and 24 bits samples
Message-ID: <20160415143525.GA4020@geburah.sephiroth>
References: <570FB712.5070903@parrot.com>
 <570FBE87.9050006@metafoo.de>
 <5710BADC.3000000@intel.com>
 <5710C2E6.2080303@metafoo.de>
 <5710E746.1080102@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
In-Reply-To: <5710E746.1080102@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Apr 15, 2016 at 04:06:14PM +0300, Crestez Dan Leonard wrote:
[snip...]
> The only drivers that seem to use an unusual storagebits value are
> st_pressure (the one that this thread is about) and AD5791 which doesn't
> seem to actually expose buffer support.
> 
> There is also the curious case of AD7303 which specifies realbits and
> storage bits as the char value '8', again without exposing buffer support.
> 
> Perhaps storagebits=24 in st_pressure should be considered a bug. Maybe try
> to modify this to 32 and check the readings?
I'll take care of st_pressure since I'm currently working on a patch series. I
don't have AD7303 device however.
Regards.
> 
> I don't have any of these devices.
> 
> Regards,
> Leonard
