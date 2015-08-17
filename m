Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:44712 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755237AbbHQM52 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 17 Aug 2015 08:57:28 -0400
Date: Mon, 17 Aug 2015 14:57:25 +0200
From: Antoine Tenart <antoine.tenart@free-electrons.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Antoine Tenart <antoine.tenart@free-electrons.com>
Subject: Re: [PATCH v2 7/8] iio:adc:berlin2-adc: enable interrupts with mutex
 locked
Message-ID: <20150817125725.GA3261@kwain>
References: <cover.1438035998.git.knaack.h@gmx.de>
 <0c150ffa3c97b5dc7b691efa8ba474e43c282519.1438035998.git.knaack.h@gmx.de>
 <55BC0ABF.5080204@gmx.de>
 <55CBB703.9050506@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <55CBB703.9050506@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Aug 12, 2015 at 10:13:39PM +0100, Jonathan Cameron wrote:
> On 01/08/15 00:54, Hartmut Knaack wrote:
> > Antoine, any opinion about this one?

Yes, sorry for the long delay... This is perfectly fine.

> > Hartmut Knaack schrieb am 28.07.2015 um 00:39:
> >> Move the call to enable channel interrupts into its _read() function to
> >> have it protected by a mutex. This ensures that only one channel is
> >> sampled at a time.
> >>
> >> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
> Looks fine to me and Antoine has had a while to confirm.
> 
> Applied to the togreg branch of iio.git

Thanks!

Antoine

-- 
Antoine Ténart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
