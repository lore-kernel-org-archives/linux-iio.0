Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:35098 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083AbbILPtG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 12 Sep 2015 11:49:06 -0400
Date: Sat, 12 Sep 2015 08:49:05 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Shraddha Barke <shraddha.6596@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Julia Lawall <julia.lawall@lip6.fr>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Andreas Dilger <andreas.dilger@intel.com>,
	Ian Abbott <abbotti@mev.co.uk>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] Staging: iio: cdc: Prefer using the BIT macro
Message-ID: <20150912154905.GC29944@kroah.com>
References: <1441902761-11190-1-git-send-email-shraddha.6596@gmail.com>
 <55F3F49D.9000201@kernel.org>
 <CAO393ABYMQof2s-R3E1GPS5c9OZDFN_VhidCaXS6HHULcd0zXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAO393ABYMQof2s-R3E1GPS5c9OZDFN_VhidCaXS6HHULcd0zXg@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Sep 12, 2015 at 04:47:23PM +0530, Shraddha Barke wrote:
> 
> 
> On Sat, Sep 12, 2015 at 3:17 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> 
>     On 10/09/15 17:32, Shraddha Barke wrote:
>     > This patch replaces bit shifting on 1 with the BIT(x) macro
>     >
>     > This was done with coccinelle:
>     > @@ int g; @@
>     >
>     > -(1 << g)
>     > +BIT(g)
>     >
>     > Signed-off-by: Shraddha Barke <shraddha.6596@gmail.com>
>     Something odd happened here as this is only a small proportion of the cases
>     that should be updated in this file.  There's one at the bottom of the
>     patch for starters!
> 
> 
> I didn't apply BIT(x) for mixed cases.I think I should drop this patch
> altogether but
> Greg has added it. Will it cause problems ? :(

Greg can always drop it :)
