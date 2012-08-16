Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:60929 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753320Ab2HPT3V (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 16 Aug 2012 15:29:21 -0400
From: Marek Vasut <marex@denx.de>
To: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 2/3 V3] IIO: Add basic MXS LRADC driver
Date: Thu, 16 Aug 2012 21:29:11 +0200
Cc: linux-iio@vger.kernel.org, Juergen Beisert <jbe@pengutronix.de>,
	"Lars-Peter Clausen" <lars@metafoo.de>,
	Shawn Guo <shawn.guo@linaro.org>, Wolfgang Denk <wd@denx.de>
References: <1344784918-32352-1-git-send-email-marex@denx.de> <1344784918-32352-3-git-send-email-marex@denx.de> <502D482D.8070606@kernel.org>
In-Reply-To: <502D482D.8070606@kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201208162129.11486.marex@denx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Dear Jonathan Cameron,

> On 08/12/2012 04:21 PM, Marek Vasut wrote:
> > This driver is very basic. It supports userland trigger, buffer and
> > raw access to channels. The support for delay channels is missing
> > altogether.
> 
> All looks good to me. Merge to togreg branch of iio.git will send on
> to Greg sometime in next few days.

Yay, thanks! :-)

Besides, Jonathan, Lars, thanks a lot for helping me understanding the 
subsystem!

[...]

Best regards,
Marek Vasut
