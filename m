Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44499 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752002AbbJCLQK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 3 Oct 2015 07:16:10 -0400
Subject: Re: [PATCH 0/6] fixes, cleanup and improvements for m62332
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
References: <cover.1440459082.git.knaack.h@gmx.de> <55E46C08.80602@kernel.org>
 <CALT56yOWN5U5gcmGo=PfGBDUxMpNpVDhUYshF3B+KV39598Qqw@mail.gmail.com>
 <55F3FAD1.1040703@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <560FB8F7.4000500@kernel.org>
Date: Sat, 3 Oct 2015 12:16:07 +0100
MIME-Version: 1.0
In-Reply-To: <55F3FAD1.1040703@kernel.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/09/15 11:13, Jonathan Cameron wrote:
> On 31/08/15 17:09, Dmitry Eremin-Solenikov wrote:
>> Hello,
>>
>> 2015-08-31 18:00 GMT+03:00 Jonathan Cameron <jic23@kernel.org>:
>>> On 28/08/15 22:59, Hartmut Knaack wrote:
>>>> A set of patches to address some issues I spotted during review.
>>>>
>>>> Hartmut Knaack (6):
>>>>   iio:dac:m62332: share scale and offset
>>>>   iio:dac:m62332: shutdown on remove
>>>>   iio:dac:m62332: use ARRAY_SIZE
>>>>   iio:dac:m62332: drop unrequired variable
>>>>   iio:dac:m62332: address some style issues
>>>>   iio:dac:m62332: use dynamic scale
>>>>
>>>>  drivers/iio/dac/m62332.c | 63 +++++++++++++++++++++++++-----------------------
>>>>  1 file changed, 33 insertions(+), 30 deletions(-)
>>>>
>>> Other than letting this series sit on the list a few days longer,
>>> for Dmitry or others to take a look at it, I'm happy with this series.
>>
>> The changes look good, however I'd like to test them on my hardware first.
>>
> Hi Dmitry,
> 
> Sorry I'd forgotten you sent this so have just backed out the first couple
> for now.  Any idea when you might get a chance to test these out?  We
> aren't in a rush given timing relative to the cycle, but always
> good to have some idea of how long things are likely to take!
> 
Hi Dmitry,

Any timescale on running the tests you wanted to on these?
If I don't hear from you before next weekend, I'll probably pick them up
and we can deal with any issues they are in.

Jonathan

