Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-230.synserver.de ([212.40.185.230]:1042 "EHLO
	smtp-out-230.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752442AbbHOUFS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 15 Aug 2015 16:05:18 -0400
Message-ID: <55CF9B79.60400@metafoo.de>
Date: Sat, 15 Aug 2015 22:05:13 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>, Joe Perches <joe@perches.com>,
	devel@driverdev.osuosl.org,
	Michael Hennerich <Michael.Hennerich@analog.com>
CC: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/19] staging: iio: Remove unnecessary externs
References: <cover.1439241825.git.joe@perches.com> <fba2902597293652f4d8561730c0cf16cd4369a0.1439241825.git.joe@perches.com> <55CA424F.1030704@metafoo.de> <55CF99A1.1000701@kernel.org>
In-Reply-To: <55CF99A1.1000701@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/15/2015 09:57 PM, Jonathan Cameron wrote:
> On 11/08/15 19:43, Lars-Peter Clausen wrote:
>> On 08/10/2015 11:51 PM, Joe Perches wrote:
>>> Using 'extern' is not necessary for function prototypes.
>>>
>>> Signed-off-by: Joe Perches <joe@perches.com>
>>
>> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
>>
> Applied to the togreg branch of iio.git.  4.4 material now
> probably.

Greg already picked the patch up earlier today on his own.

