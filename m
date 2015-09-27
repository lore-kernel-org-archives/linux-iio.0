Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36688 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755611AbbI0NqP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 27 Sep 2015 09:46:15 -0400
Subject: Re: [PATCH 1/2] Staging: iio: cdc: Prefer using the BIT macro
To: Lars-Peter Clausen <lars@metafoo.de>,
	Shraddha Barke <shraddha.6596@gmail.com>
References: <1443201782-25863-1-git-send-email-shraddha.6596@gmail.com>
 <1443201782-25863-2-git-send-email-shraddha.6596@gmail.com>
 <5606D264.6080503@metafoo.de>
Cc: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5607F322.8040504@kernel.org>
Date: Sun, 27 Sep 2015 14:46:10 +0100
MIME-Version: 1.0
In-Reply-To: <5606D264.6080503@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 26/09/15 18:14, Lars-Peter Clausen wrote:
> On 09/25/2015 07:23 PM, Shraddha Barke wrote:
>> Replace bit shifting on 1 with the BIT(x) macro
>>
>> Signed-off-by: Shraddha Barke <shraddha.6596@gmail.com>
> 
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
> 
This is a good little patch, so applied to the togreg branch
of iio.git.  This will get initially pushed out as testing
and the branch will get rebased onto Greg KH's staging-next
branch sometime soon.

However, I think there are some other places the BIT macro
can be correctly used in this driver if you are willing to take
it further.

Note that you can only do these by checking the datasheet to be
sure we aren't writing part of a large field in the register!

In the status register the bottom for bits are single bit fields.


#define AD7746_STATUS_EXCERR		(1 << 3)
#define AD7746_STATUS_RDY		(1 << 2)
#define AD7746_STATUS_RDYVT		(1 << 1)
#define AD7746_STATUS_RDYCAP		(1 << 0)

As are the cap setup register bits

#define AD7746_CAPSETUP_CAPEN		(1 << 7)
#define AD7746_CAPSETUP_CIN2		(1 << 6) /* AD7746 only */
#define AD7746_CAPSETUP_CAPDIFF		(1 << 5)
#define AD7746_CAPSETUP_CACHOP		(1 << 0)

Some of the vt setup register are also single bits but as that register
is a more complex mess and some other bits are hard to define macros
for perhaps leave it alone.  It's another one arguing in favour of
a ZERO(bit) macro but I fear persuading people of that will be an uphill
struggle :(

Anyhow the two registers mentioned above are a clear cut as the one you've
done so perhaps tidy those up as well?

Thanks,

Jonathan

