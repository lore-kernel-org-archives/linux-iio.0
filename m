Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36113 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966413AbcKLRKK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Nov 2016 12:10:10 -0500
Subject: Re: [PATCH v3 16/28] staging: iio: tsl2583: updated code comment to
 match what the code does
To: Brian Masney <masneyb@onstation.org>
References: <1478769964-7065-1-git-send-email-masneyb@onstation.org>
 <1478769964-7065-17-git-send-email-masneyb@onstation.org>
 <67166adf-5a89-3283-8a16-9a0a9a57e770@kernel.org>
 <20161112165935.GB31082@basecamp.onstation.org>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org, lars@metafoo.de, pmeerw@pmeerw.net,
        knaack.h@gmx.de, linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <a3750918-41ef-4ceb-0276-ae27df1e3bb1@kernel.org>
Date: Sat, 12 Nov 2016 17:10:07 +0000
MIME-Version: 1.0
In-Reply-To: <20161112165935.GB31082@basecamp.onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/11/16 16:59, Brian Masney wrote:
> On Sat, Nov 12, 2016 at 04:36:37PM +0000, Jonathan Cameron wrote:
>> On 10/11/16 09:25, Brian Masney wrote:
>>> If channel 0 does not have any data, then the code sets the lux to zero.
>>> The corresponding comment says that the last value is returned. This
>>> updates the comment to correctly reflect what the code does.
>>>
>>> Signed-off-by: Brian Masney <masneyb@onstation.org>
>> Better perhaps to just return an error, -EAGAIN perhaps?
>> I'm not sure why it would not give a value.
> 
> This check is to avoid a division by zero. Here is the relevant code
> that wasn't shown in the diff:
> 
> 	if (!ch0) {
> 		/* have no data, so return 0 */
> 		ret = 0;
> 		chip->als_cur_info.lux = 0;
> 		goto done;
> 	}
> 
> 	/* calculate ratio */
> 	ratio = (ch1 << 15) / ch0;
> 
> Channel 0 is sensitive to both infrared and visible light. In total
> darkness, the sensor should return 0. Correct me if I am wrong, but
> I believe that returning 0 here is more correct than -EAGAIN.
> 
> Brian
> 
Fair enough I hadn't understood that.  Maybe expand the comment
to cover that?
