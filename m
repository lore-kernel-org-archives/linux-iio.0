Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:48040 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964787Ab2HQDC3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 16 Aug 2012 23:02:29 -0400
Received: by obbuo13 with SMTP id uo13so4616013obb.19
        for <linux-iio@vger.kernel.org>; Thu, 16 Aug 2012 20:02:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201208170457.03686.marex@denx.de>
References: <1344784918-32352-1-git-send-email-marex@denx.de>
	<1344784918-32352-4-git-send-email-marex@denx.de>
	<20120817024821.GA24335@S2101-09.ap.freescale.net>
	<201208170457.03686.marex@denx.de>
Date: Fri, 17 Aug 2012 11:02:28 +0800
Message-ID: <CAAQ0ZWROobdtFkzn9Sr7v5B29zYTQ5YEUZV59kkNE_yv6qbmgQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] IIO: arm: Add LRADC to i.MX28 dts
From: Shawn Guo <shawn.guo@linaro.org>
To: Marek Vasut <marex@denx.de>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Juergen Beisert <jbe@pengutronix.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Wolfgang Denk <wd@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17 August 2012 10:57, Marek Vasut <marex@denx.de> wrote:
> Thanks ... still, is there some key for those tags? Or do you invent them at
> random and then let people guess what's right? Some git grep on Documentation
> directory gets me nothing.
>
There is no official document for this.  But generally, each subsystem
has a convention on the subject prefix, so that the output of git
commands like git pull, git shortlog looks consistent on the patch
subject, and more importantly people can easily know subsystem the
patch touches.

The convention for patches touching arch/arm is "ARM: ".

Regards,
Shawn
