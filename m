Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:53855 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932478AbbFEN5J (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 5 Jun 2015 09:57:09 -0400
Message-ID: <5571AAAF.8040409@i2se.com>
Date: Fri, 05 Jun 2015 15:57:03 +0200
From: Stefan Wahren <stefan.wahren@i2se.com>
MIME-Version: 1.0
To: Marek Vasut <marex@denx.de>
CC: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	=?windows-1252?Q?Kristina_Mart=9Ae?= =?windows-1252?Q?nko?=
	<kristina.martsenko@gmail.com>,
	Fabio Estevam <fabio.estevam@freescale.com>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH] iio: mxs-lradc: add datasheet name for every usable channel
References: <1433443471-16970-1-git-send-email-stefan.wahren@i2se.com> <201506051543.09533.marex@denx.de>
In-Reply-To: <201506051543.09533.marex@denx.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Am 05.06.2015 um 15:43 schrieb Marek Vasut:
> On Thursday, June 04, 2015 at 08:44:31 PM, Stefan Wahren wrote:
>> In order to provide a channel name to in kernel consumers add the
>> datasheet names for every usable AD channel.
> Hi!
>
> Did you check those channel names for both MX28 and MX23? Note
> that they do differ IIRC ;-)

Sorry for being so stupid to rely on the comments.

But do you agree to add datasheet names?

Stefan

>
> Best regards,
> Marek Vasut


