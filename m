Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50476 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751850Ab3KQOQg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 17 Nov 2013 09:16:36 -0500
Message-ID: <5288DE14.1040407@kernel.org>
Date: Sun, 17 Nov 2013 15:17:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Andi Shyti <andi@etezian.org>, Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: Add Freescale MPL3115A2 pressure / temperature
 sensor driver
References: <1384285426-16191-1-git-send-email-pmeerw@pmeerw.net> <20131115103716.GA4134@jack.whiskey>
In-Reply-To: <20131115103716.GA4134@jack.whiskey>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/15/13 10:37, Andi Shyti wrote:
>> I2C-controlled MEMS sensor with 20-bit pressure measurement (pascal) and
>> 12-bit temperature measurement
>>
>> driver only exposes basic functionality, see TODO remarks
>> datasheet: http://cache.freescale.com/files/sensors/doc/data_sheet/MPL3115A2.pdf
>>
>> v2:
>> * store 20-bit value in 32-bit buffer element (instead of 24-bit)
>> * zero buffer to prevent kernel data leak to userspace
>> * fix mutex unlock in trigger handler (thanks Andi Shyti)
> 
> You're very welcome :)
> 
>> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
>> Cc: Andi Shyti <andi@etezian.org>
> 
> Look good to me as well, if you want you can add
> 
> Reviewed-by: Andi Shyti <andi@etezian.org>
Of course.  Thanks for the review. I am always happy to acknowledge
reviewers as they make life easier!

Applied to the togreg branch of iio.git - note that for now I'm pushing this out
to testing to get build test coverage before pushing to the togreg branch on
kernel.org

> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
