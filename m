Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45859 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422AbbGSJpb (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 19 Jul 2015 05:45:31 -0400
Message-ID: <55AB71B9.8070307@kernel.org>
Date: Sun, 19 Jul 2015 10:45:29 +0100
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
Subject: Re: [PATCH V2 0/6] iio: mxs-lradc: Clean up and add datasheet names
References: <1437222646-8742-1-git-send-email-stefan.wahren@i2se.com> <201507181738.21236.marex@denx.de>
In-Reply-To: <201507181738.21236.marex@denx.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/07/15 16:38, Marek Vasut wrote:
> On Saturday, July 18, 2015 at 02:30:40 PM, Stefan Wahren wrote:
>> This patch series does some clean up in mxs-lradc and finally add the
>> datasheet names for every usable channel.
>>
>> Changes in V2:
>>   - remove confusing i.MX28 specific comments
>>   - fix some spelling errors
>>   - fix up includes
>>   - separate channel spec for i.MX23 and i.MX28
>>
>> Stefan Wahren (6):
>>   iio: mxs-lradc: clarify supported devices
>>   iio: mxs-lradc: fix some spelling errors
>>   iio: mxs-lradc: add missing include
>>   iio: mxs-lradc: remove unnecessary header includes
>>   iio: mxs-lradc: reorder header includes
>>   iio: mxs-lradc: add datasheet name for every usable channel
>>
>>  .../bindings/staging/iio/adc/mxs-lradc.txt         |    2 +-
>>  drivers/staging/iio/adc/mxs-lradc.c                |  122
>> +++++++++++++------- 2 files changed, 82 insertions(+), 42 deletions(-)
> 
> Entire series
> 
> Reviewed-by: Marek Vasut <marex@denx.de>
Thanks for looking through these. 

Just to let you know, there is currently a rather extended discussion going
on (as part of a suggested topic for the kernel summit) about when reviewed-by
tags are appropriate.

The general feeling is they must in someway indicate some substantial work.  Here
as a result I'd say it was appropriate for patch 6 whereas an Acked-by 
would be more appropriate for the cleanups (where there is nothing 'interesting').
I've left these as reviewed by for this set though!

Note to all reviewers I may also start added reviewed by tags that you haven't sent if
I happen to feel you made a big contribution to review of a patch, but perhaps haven't
revisited later versions.  I'll probably send out an email about this outside
of this thread at some point to get possible wider circulation.

Jonathan
> 
> Best regards,
> Marek Vasut
> 

