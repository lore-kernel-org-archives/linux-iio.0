Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:39237 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752880Ab3GBRhG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 2 Jul 2013 13:37:06 -0400
From: Marek Vasut <marex@denx.de>
To: Otavio Salvador <otavio@ossystems.com.br>
Subject: Re: [PATCH] iio: mxs-lradc: Remove useless check in read_raw
Date: Tue, 2 Jul 2013 19:36:57 +0200
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Fabio Estevam <fabio.estevam@freescale.com>
References: <1372723722-13902-1-git-send-email-marex@denx.de> <201307021813.18019.marex@denx.de> <CAP9ODKoVcH9f-2KMzAbQrfgoFGhz2CU=zJVJu-M8dWcUN4s17w@mail.gmail.com>
In-Reply-To: <CAP9ODKoVcH9f-2KMzAbQrfgoFGhz2CU=zJVJu-M8dWcUN4s17w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201307021936.57756.marex@denx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Dear Otavio Salvador,

> On Tue, Jul 2, 2013 at 1:13 PM, Marek Vasut <marex@denx.de> wrote:
> > Dear Alexandre Belloni,
> > 
> >> On 02/07/2013 14:03, Marek Vasut wrote:
> >> > Dear Alexandre Belloni,
> >> > 
> >> >> Dear Marek,
> >> >> 
> >> >> I don't seem to be hitting that issue. I'm using 3.10rc7. Do you know
> >> >> how to reproduce it ?
> >> > 
> >> > The check is just redundant, it's not a bug.
> >> 
> >> Ok, that's what I understood first but then got confused by reports of
> >> it solving a bug.
> > 
> > It cannot solve a thing. If it does, then we have a problem.
> > 
> > What kind of bug do you see ? How can I replicate it ? Can you send me a
> > testcase?
> 
> As I said this code sometimes work. If you put a printf before this
> call it sometimes work. So I think we have a race somewhere.
> 
> When I were debugging this I found that when it works we have 10
> active channels, it seems.

Uh, the read_raw() should exit with -EBUSY, since the mutex_tryload() will fail 
iff buffered operation is in progress. Or what do you mean by having "10 active 
channels"?

Best regards,
Marek Vasut
