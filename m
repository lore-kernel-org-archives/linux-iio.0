Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:53667 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751694AbbFEOjE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 5 Jun 2015 10:39:04 -0400
From: Marek Vasut <marex@denx.de>
To: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH] iio: mxs-lradc: add datasheet name for every usable channel
Date: Fri, 5 Jun 2015 16:38:59 +0200
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	"Lars-Peter Clausen" <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Kristina =?utf-8?q?Mart=C5=A1enko?=
	<kristina.martsenko@gmail.com>,
	Fabio Estevam <fabio.estevam@freescale.com>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
References: <1433443471-16970-1-git-send-email-stefan.wahren@i2se.com> <201506051543.09533.marex@denx.de> <5571AAAF.8040409@i2se.com>
In-Reply-To: <5571AAAF.8040409@i2se.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201506051638.59949.marex@denx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Friday, June 05, 2015 at 03:57:03 PM, Stefan Wahren wrote:
> Am 05.06.2015 um 15:43 schrieb Marek Vasut:
> > On Thursday, June 04, 2015 at 08:44:31 PM, Stefan Wahren wrote:
> >> In order to provide a channel name to in kernel consumers add the
> >> datasheet names for every usable AD channel.
> > 
> > Hi!
> > 
> > Did you check those channel names for both MX28 and MX23? Note
> > that they do differ IIRC ;-)
> 
> Sorry for being so stupid to rely on the comments.

Somehow, I feel bad reading this sentence -- esp. since those comments
are most likely my doing ;-/

> But do you agree to add datasheet names?

Sure, why not.

Best regards,
Marek Vasut
