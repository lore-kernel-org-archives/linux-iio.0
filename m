Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:38022 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753751Ab1JXIva (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 24 Oct 2011 04:51:30 -0400
Received: from public by plane.gmane.org with local (Exim 4.69)
	(envelope-from <public@plane.gmane.org>)
	id 1RIGFk-0007R5-66
	for linux-iio@vger.kernel.org; Mon, 24 Oct 2011 10:51:28 +0200
Message-ID: <4EA52710.2060108@cam.ac.uk>
Date: Mon, 24 Oct 2011 09:51:28 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Maxin B John
	<public-maxin.john-Re5JQEeQqe8AvxtiuMwx3w@plane.gmane.org>
CC: Jonathan Cameron
	<public-jic23-KWPb1pKIrIJaa/9Udqfwiw@plane.gmane.org>,
	Dan Carpenter
	<public-error27-Re5JQEeQqe8AvxtiuMwx3w@plane.gmane.org>,
	Bryan Freed
	<public-bfreed-F7+t8E8rja9g9hUCZPvPmw@plane.gmane.org>,
	public-linux-kernel-u79uwXL29TY76Z2rM5mHXA@plane.gmane.org,
	Greg Kroah-Hartman <public-gregkh-l3A5Bk7waGM@plane.gmane.org>,
	public-linux-iio-u79uwXL29TY76Z2rM5mHXA@plane.gmane.org,
	Arnd Bergmann <public-arnd-r2nGTMty4D4@plane.gmane.org>,
	public-devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@plane.gmane.org,
	Amit Kucheria
	<public-amit.kucheria-LY4KaoCqKrnby3iVrkZq2A@plane.gmane.org>
Subject: Re: [PATCH] staging: iio: light: Fix compiler warning in tsl2563.c
References: <20110902094107.GA2846@maxin> <4E60B63C.1030101@cam.ac.uk> <CAMhs6Yzw3-CARTULhy4s-Re4Q82Ek9gZGUQtABLLs0PSArHCuw@mail.gmail.com>
In-Reply-To: <CAMhs6Yzw3-CARTULhy4s-Re4Q82Ek9gZGUQtABLLs0PSArHCuw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 10/22/11 06:15, Maxin B John wrote:
> Hi,
> 
> On Fri, Sep 2, 2011 at 1:55 PM, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org> wrote:
>> On 09/02/11 10:41, Maxin B. John wrote:
>>>> Don't overwrite the error code.  For example, the lower layers can
>>>> return -EAGAIN and that's more useful than just returning -EIO every
>>>> time.
>>> Ahh.. Thanks a lot for explaining this.
>>>
>>>> Your fix works, but it's not very clean.  Just add a "*id = ret;"
>>>> line before the "return 0;" and that's it.  (It doesn't make sense
>>>> to pass a pointer to "id" and not use it).
>>> Dan, yes, I agree with you. This fix is much much better than what I
>>> had in my mind.
>>>
>>>> Yikes - I wonder why my various compilers don't throw that up.
>>> I guess, in "iio-blue.git" tree, the 'id = 0' suppresses this warning.
>> That'd do it. oops.
>>
>> Ideally keep the white space but doesn't really matter. Either send on
>> to Greg directly or I'll add it to iio-blue and send on with the next fixes
>> series - probably this afternoon.
>>>
>>> Signed-off-by: Maxin B. John <maxin.john-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> Acked-by: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
>>
> 
> Sorry for the delay in replying to this mail. I am curious about the
> status of this patch. I couldn't locate this patch at  iio-blue.git as
> it is not present in kernel.org now
> (http://git.kernel.org/?p=linux/kernel/git/jic23/iio-blue.git;a=summary)
> Please ignore this mail if you have already added this patch to your tree.
Ah, sorry I slipped up here and should have noticed it didn't go directly to
Greg. Just to check, with everyone I have author as Dan, reporter as Maxin
and have signed off myself (it's going through my tree anyway now).

I think from looking back it was Dan's suggestion in response to Maxin's
patch.  Hence convention would be a sign off from Dan and perhaps an
Ack from Maxin?

Jonathan

>>From c33a01010decf686f5f2984d2ed04c1a70e18bc3 Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Mon, 24 Oct 2011 09:46:32 +0100
Subject: [PATCH] staging:iio:light:tsl2563 missing setting of id in get id
 function.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
Reported-by: Maxin B. John <maxin.john@gmail.com>
---
 drivers/staging/iio/light/tsl2563.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2563.c b/drivers/staging/iio/light/tsl2563.c
index 5cee5ca..45d04a1 100644
--- a/drivers/staging/iio/light/tsl2563.c
+++ b/drivers/staging/iio/light/tsl2563.c
@@ -227,6 +227,8 @@ static int tsl2563_read_id(struct tsl2563_chip *chip, u8 *id)
 	if (ret < 0)
 		return ret;
 
+	*id = ret;
+
 	return 0;
 }
 
-- 
1.7.7

