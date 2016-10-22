Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53678 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935413AbcJVRPR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 Oct 2016 13:15:17 -0400
Subject: Re: [PATCH 2/2] staging: iio: ad7606: rework regulator handling
To: Lars-Peter Clausen <lars@metafoo.de>,
        Eva Rachel Retuya <eraretuya@gmail.com>,
        linux-iio@vger.kernel.org
References: <1476968903-15771-1-git-send-email-eraretuya@gmail.com>
 <1476968903-15771-3-git-send-email-eraretuya@gmail.com>
 <e610e89b-0fd9-37db-7b38-ccccc912101b@metafoo.de>
Cc: Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <14c9c764-1178-e1d9-8962-a220a935405a@kernel.org>
Date: Sat, 22 Oct 2016 18:15:15 +0100
MIME-Version: 1.0
In-Reply-To: <e610e89b-0fd9-37db-7b38-ccccc912101b@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/10/16 14:20, Lars-Peter Clausen wrote:
> On 10/20/2016 03:08 PM, Eva Rachel Retuya wrote:
>> Currently, this driver ignores all errors from regulator_get(). The way
>> it is now, it also breaks probe deferral (EPROBE_DEFER). The correct
>> behavior is to propagate the error to the upper layers so they can
>> handle it accordingly.
>>
>> Rework the regulator handling so that it matches the standard behavior.
>> If the specific design uses a static always-on regulator and does not
>> explicitly specify it, regulator_get() will return the dummy regulator.
>>
>> Suggested-by: Lars-Peter Clausen <lars@metafoo.de>
>> Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
> 
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
> 
> Thanks.
> 
Applied to the togreg branch of iio.git and pushed out as
testing for the autobuilders to play with it.

Thanks

Jonathan
