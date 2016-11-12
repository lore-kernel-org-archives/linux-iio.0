Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:33419 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966722AbcKLTll (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Nov 2016 14:41:41 -0500
Received: by mail-it0-f67.google.com with SMTP id c20so1561134itb.0
        for <linux-iio@vger.kernel.org>; Sat, 12 Nov 2016 11:41:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161112175619.GE7129@atomide.com>
References: <1478946096-1314-1-git-send-email-Nicolae_Rosia@mentor.com>
 <18487c16-04ee-b65a-c773-27a2965db8b3@kernel.org> <20161112175619.GE7129@atomide.com>
From: Nicolae Rosia <nicolae.rosia.oss@gmail.com>
Date: Sat, 12 Nov 2016 21:41:40 +0200
Message-ID: <CAKP5S=2fgmTVs8JW2QKcndFSRZWqX=vL4Qa2d2TxCLKaACL8bg@mail.gmail.com>
Subject: Re: [PATCH] iio: twl4030-madc: convert to DT only
To: Tony Lindgren <tony@atomide.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Nicolae Rosia <Nicolae_Rosia@mentor.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

> Yeah well mach-omap2 is all device tree only now. We still do have
> the platform_data init around in the unlikely case we still need
> to revert it for some regression. But I'm queuing patches for v4.10
> to drop the rest of the platform_data based init and will merge
> them assuming no problems.
>
> If this helps cleaning up the rest of the twl related code then
> sure makes sense to me. If this is not blocking other clean-up,
> maybe wait until v4.11 merge window to be safe on this one.
I may have rushed with this one then. I will repost it for v4.11, it's
not a blocker.

Regards,
Nicolae
