Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:34961 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752056Ab3GBQN1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 2 Jul 2013 12:13:27 -0400
From: Marek Vasut <marex@denx.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH] iio: mxs-lradc: Remove useless check in read_raw
Date: Tue, 2 Jul 2013 18:13:17 +0200
Cc: linux-iio@vger.kernel.org, otavio@ossystems.com.br,
	Jonathan Cameron <jic23@kernel.org>,
	Fabio Estevam <fabio.estevam@freescale.com>
References: <1372723722-13902-1-git-send-email-marex@denx.de> <201307021403.57543.marex@denx.de> <51D2CC68.1080808@free-electrons.com>
In-Reply-To: <51D2CC68.1080808@free-electrons.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201307021813.18019.marex@denx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Dear Alexandre Belloni,

> On 02/07/2013 14:03, Marek Vasut wrote:
> > Dear Alexandre Belloni,
> > 
> >> Dear Marek,
> >> 
> >> I don't seem to be hitting that issue. I'm using 3.10rc7. Do you know
> >> how to reproduce it ?
> > 
> > The check is just redundant, it's not a bug.
> 
> Ok, that's what I understood first but then got confused by reports of
> it solving a bug.

It cannot solve a thing. If it does, then we have a problem.

What kind of bug do you see ? How can I replicate it ? Can you send me a 
testcase?

Best regards,
Marek Vasut
