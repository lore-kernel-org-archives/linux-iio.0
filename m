Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ea0-f176.google.com ([209.85.215.176]:58540 "EHLO
	mail-ea0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760167Ab3EBSgJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 2 May 2013 14:36:09 -0400
From: Tomasz Figa <tomasz.figa@gmail.com>
To: Naveen Krishna Ch <naveenkrishna.ch@gmail.com>
Cc: linux-iio@vger.kernel.org,
	"linux-samsung-soc@vger.kernel.org"
	<linux-samsung-soc@vger.kernel.org>, jic23@cam.ac.uk,
	Naveen Krishna <naveen@chromium.org>,
	Naveen Krishna Chatradhi <ch.naveen@samsung.com>,
	Doug Anderson <dianders@chromium.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2] iio: adc: exynos_adc: Handle timeout issues
Date: Thu, 02 May 2013 20:36:02 +0200
Message-ID: <1807373.1S4VcvAmeI@flatron>
In-Reply-To: <CAHfPSqCc81765zQVur=AtW2Cf+taYef=LYJK008i03cmYPu0WQ@mail.gmail.com>
References: <1365048389-6364-1-git-send-email-naveenkrishna.ch@gmail.com> <2062773.qUuSzV6t0U@flatron> <CAHfPSqCc81765zQVur=AtW2Cf+taYef=LYJK008i03cmYPu0WQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thursday 02 of May 2013 11:22:27 Naveen Krishna Ch wrote:
> On 2 May 2013 11:10, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> > Hi Naveen,
> > 
> > On Thursday 02 of May 2013 11:01:03 Naveen Krishna Chatradhi wrote:
> >> From: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
> >> 
> >> This patch does the following
> >> 1. use wait_for_completion_timeout instead of
> >> 
> >>    wait_for_completion_interruptible_timeout
> >> 
> >> 2. Reset software if a timeout happens.
> >> 3. Also reduce the timeout to 100milli secs
> > 
> > I wonder what this patch is trying to fix. In what conditions can an
> > ADC conversion time out?
> > 
> > Sorry if it was already explained in discussion. Still, I think that
> > commit message of a patch should explain why it is needed.
> 
> The discussion started with a bug reported by Dan Carpenter
> http://www.gossamer-threads.com/lists/linux/kernel/1693284?page=last
> 
> and during the discussion we found out the return cases of
> wait_for_completion_interruptible_timeout() were not handled properly.
> so we implemented hw_reset during the error cases.
> 
> As such ISR only does a regiser access.  Which may never timeout.
> This patch reduces the timeout and removes the use of interruptible.
> As, ADC's ISR would be too fast to handle the interruptible operation.
> 
> Now i see, there is nothing much this driver is fixing.
> As you suggest, the subject can be little less harsh.

OK, thanks for the explanation.

Best regards,
Tomasz

