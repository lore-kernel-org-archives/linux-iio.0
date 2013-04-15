Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:61091 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752322Ab3DOQBl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 15 Apr 2013 12:01:41 -0400
Received: by mail-lb0-f171.google.com with SMTP id v10so4639301lbd.2
        for <linux-iio@vger.kernel.org>; Mon, 15 Apr 2013 09:01:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHfPSqAVUVdFwtMxJYCGaPv_+iO_GEc9_UGNXwuSj9uu_fB81g@mail.gmail.com>
References: <1363364801-23684-1-git-send-email-ch.naveen@samsung.com>
	<1365048389-6364-1-git-send-email-naveenkrishna.ch@gmail.com>
	<CAHfPSqAVUVdFwtMxJYCGaPv_+iO_GEc9_UGNXwuSj9uu_fB81g@mail.gmail.com>
Date: Mon, 15 Apr 2013 09:01:39 -0700
Message-ID: <CAD=FV=XnpWPFcDoQ1Pi+SkuWiemiY+6Z6ecQN+eDpfs4fW8+qw@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: exynos_adc: Handle timeout issues
From: Doug Anderson <dianders@chromium.org>
To: Naveen Krishna Ch <naveenkrishna.ch@gmail.com>
Cc: linux-iio <linux-iio@vger.kernel.org>,
	"linux-samsung-soc@vger.kernel.org"
	<linux-samsung-soc@vger.kernel.org>,
	Jonathan Cameron <jic23@cam.ac.uk>,
	Naveen Krishna Chatradhi <ch.naveen@samsung.com>,
	Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Naveen,

On Fri, Apr 12, 2013 at 9:36 PM, Naveen Krishna Ch
<naveenkrishna.ch@gmail.com> wrote:
> Can some one review this and get this fix into the tree.

I think the ball is in your court.  Lars responded to your RFC patch
here and requested that you do a reset of the bus in the case of being
interrupted.

https://lkml.org/lkml/2013/4/5/91

I made a comment about perhaps just using non-interruptable and then
shortening the timeout and Lars thought that would be OK.  ...but I've
since thought about it and I think Lars' suggestion is best.

The reason I no longer like my suggestion of just using a 1ms
non-interruptable tiemout is that I'm slightly worried about running
into some case where the interrupt gets blocked for a while and then
we get timeouts for no reasons.  Perhaps I'm worrying over nothing,
but Lars' suggestion doesn't have this issue.

-Doug
