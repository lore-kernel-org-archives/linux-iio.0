Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49309 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752878AbbHOUdY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 15 Aug 2015 16:33:24 -0400
Subject: Re: [PATCH 05/19] staging: iio: Remove unnecessary externs
To: Lars-Peter Clausen <lars@metafoo.de>,
	Joe Perches <joe@perches.com>, devel@driverdev.osuosl.org,
	Michael Hennerich <Michael.Hennerich@analog.com>
References: <cover.1439241825.git.joe@perches.com>
 <fba2902597293652f4d8561730c0cf16cd4369a0.1439241825.git.joe@perches.com>
 <55CA424F.1030704@metafoo.de> <55CF99A1.1000701@kernel.org>
 <55CF9B79.60400@metafoo.de>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55CFA212.3030904@kernel.org>
Date: Sat, 15 Aug 2015 21:33:22 +0100
MIME-Version: 1.0
In-Reply-To: <55CF9B79.60400@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/08/15 21:05, Lars-Peter Clausen wrote:
> On 08/15/2015 09:57 PM, Jonathan Cameron wrote:
>> On 11/08/15 19:43, Lars-Peter Clausen wrote:
>>> On 08/10/2015 11:51 PM, Joe Perches wrote:
>>>> Using 'extern' is not necessary for function prototypes.
>>>>
>>>> Signed-off-by: Joe Perches <joe@perches.com>
>>>
>>> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
>>>
>> Applied to the togreg branch of iio.git.  4.4 material now
>> probably.
> 
> Greg already picked the patch up earlier today on his own.
Thanks,
Dropped it from my branch as hadn't pushed out yet.

Jonathan
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

