Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:54106 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913AbcF0UH2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jun 2016 16:07:28 -0400
Subject: Re: [PATCH 1/1] iio: buffer-dma: Use ARRAY_SIZE in for loop range
To: Lars-Peter Clausen <lars@metafoo.de>,
	Phil Reid <preid@electromag.com.au>, knaack.h@gmx.de,
	pmeerw@pmeerw.net, linux-iio@vger.kernel.org
References: <1466997476-36746-1-git-send-email-preid@electromag.com.au>
 <5770D5DD.5070505@metafoo.de>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <bf46f05c-af41-a2c2-6a3e-0de65919df12@kernel.org>
Date: Mon, 27 Jun 2016 21:07:25 +0100
MIME-Version: 1.0
In-Reply-To: <5770D5DD.5070505@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/06/16 08:29, Lars-Peter Clausen wrote:
> On 06/27/2016 05:17 AM, Phil Reid wrote:
>> Use the ARRAY_SIZE macro in the for loops that access queue->fileio.blocks.
>> Macro is already used in a couple of places where this access occurs,
>> but range was hardcoded in these locations.
>>
>> Signed-off-by: Phil Reid <preid@electromag.com.au>
> 
> Looks good, thanks.
> 
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git - initially pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

