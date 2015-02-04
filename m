Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60608 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162079AbbBDSku (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 4 Feb 2015 13:40:50 -0500
Message-ID: <54D24F21.4010603@kernel.org>
Date: Wed, 04 Feb 2015 16:56:01 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>,
	=?UTF-8?B?VXJzIEbDpHNzbGVy?= <urs.fassler@bytesatwork.ch>
CC: Michael.Hennerich@analog.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: ad5686: fix optional reference voltage declaration
References: <54CFA1E7.4020907@bytesatwork.ch> <54CFB84C.7090503@metafoo.de>
In-Reply-To: <54CFB84C.7090503@metafoo.de>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/02/15 17:47, Lars-Peter Clausen wrote:
> On 02/02/2015 05:12 PM, Urs Fässler wrote:
>> When not using the "_optional" function, a dummy regulator is returned
>> and the driver fails to initialize.
>>
>> Signed-off-by: Urs Fässler <urs.fassler@bytesatwork.ch>
> 
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
> 
> Thanks.
> 
> Added Jonathan to Cc.
Applied to fixes-togreg (will hit git.kernel.org at the weekend
as I am travelling, and Greg / Mainline after the merge window)
Marked for stable.

Jonathan
