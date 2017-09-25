Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout02.posteo.de ([185.67.36.66]:38998 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753824AbdIYGXx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 25 Sep 2017 02:23:53 -0400
Received: from submission (posteo.de [89.146.220.130])
        by mout02.posteo.de (Postfix) with ESMTPS id DB30420AEF
        for <linux-iio@vger.kernel.org>; Mon, 25 Sep 2017 08:23:51 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Mon, 25 Sep 2017 08:23:50 +0200
From: Martin Kepplinger <martink@posteo.de>
To: Harinath Nampally <harinath922@gmail.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        amsfield22@gmail.com
Subject: Re: [PATCH 0/3] This patchset refactors event related functions
In-Reply-To: <1506309333-1970-1-git-send-email-harinath922@gmail.com>
References: <1506309333-1970-1-git-send-email-harinath922@gmail.com>
Message-ID: <096ed3a299892f6f5fd92557607c2f72@posteo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Am 25.09.2017 05:15 schrieb Harinath Nampally:
> Harinath Nampally (3):
> Following 2 patches are for refactor:
>   iio: accel: mma8452: Rename time step look up struct     to generic
>     name as the values are same for all the events.
>   iio: accel: mma8452: Rename read/write event value     callbacks to
>     generic function name.
> Following patch adds new feature:
>   iio: accel: mma8452: Add single pulse/tap event detection     feature
>     for fxls8471.
> 

I guess it's fine for now, but please don't call your patchset "This 
patchset does...".
Just say "Refactor..." or whatever like you do in your patches.
