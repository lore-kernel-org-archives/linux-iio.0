Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45726 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717AbbGSJhr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 19 Jul 2015 05:37:47 -0400
Message-ID: <55AB6FE9.7070605@kernel.org>
Date: Sun, 19 Jul 2015 10:37:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Marek Vasut <marex@denx.de>, Stefan Wahren <stefan.wahren@i2se.com>
CC: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?windows-1252?Q?Kristina_Mart=9Aenko?=
	<kristina.martsenko@gmail.com>,
	Fabio Estevam <fabio.estevam@freescale.com>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH 5/6] iio: mxs-lradc: reorder header includes
References: <1437222646-8742-1-git-send-email-stefan.wahren@i2se.com> <1437222646-8742-6-git-send-email-stefan.wahren@i2se.com> <201507181737.53760.marex@denx.de>
In-Reply-To: <201507181737.53760.marex@denx.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/07/15 16:37, Marek Vasut wrote:
> On Saturday, July 18, 2015 at 02:30:45 PM, Stefan Wahren wrote:
>> This patch reorder the header includes alphabetically.
> 
> You call that operation "sort" :)
> 
> Best regards,
> Marek Vasut
> 
Hmm.. I can't say I'm particularly keen on this patch. To 
my mind having headers in order doesn't matter as sometimes
the grouping is providing information in of itself.  Still
doesn't look that interesting here and as it's part of a good
series, I'll take it.

Just thought I'd be marginally grumpy about it ;)

Applied.
Jonathan
