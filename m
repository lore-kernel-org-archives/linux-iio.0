Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40925 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752652AbcBFRyM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 6 Feb 2016 12:54:12 -0500
Subject: Re: [PATCH 1/2] staging:iio:ad7606: Consolidate PM ops
To: Lars-Peter Clausen <lars@metafoo.de>
References: <1454668354-11450-1-git-send-email-lars@metafoo.de>
 <56B5D783.6040504@kernel.org> <56B5D8E6.9060409@metafoo.de>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56B63341.10300@kernel.org>
Date: Sat, 6 Feb 2016 17:54:09 +0000
MIME-Version: 1.0
In-Reply-To: <56B5D8E6.9060409@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/02/16 11:28, Lars-Peter Clausen wrote:
> On 02/06/2016 12:22 PM, Jonathan Cameron wrote:
>> On 05/02/16 10:32, Lars-Peter Clausen wrote:
>>> Both the SPI and platform device driver for the ad7606 use the same set of
>>> PM ops. Consolidate them in the common part of the driver.
>>>
>>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>> Lars, this doesn't apply to the togreg branch.
>>
>> Looks like you are locally missing the patch:
>>
>> 0046a46a8f93f5b99b499118779521ba3b017d69
>> staging/ad7606: Actually build the interface modules 
> 
> Which is not yet in the public togreg branch. I'll rebase and resend next
> week when the public branch has been updated.
Odd... Pull request went out last weekend and hence even if I'd accidentally
kept it in testing until then it should have been in togreg last week.
Ah well, definitely is now as it's made it through to staging-next (and
Linux next). oops!

Jonathan

