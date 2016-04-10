Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44410 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753496AbcDJPOO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 10 Apr 2016 11:14:14 -0400
Subject: Re: [PATCH v2 27/30] iio: use parity32 in adxrs450
To: Lars-Peter Clausen <lars@metafoo.de>, zengzhaoxiu@163.com,
	Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net
References: <57031D9D.801@gmail.com>
 <1459937776-8438-1-git-send-email-zengzhaoxiu@163.com>
 <570A6536.3000308@kernel.org> <570A662E.8030807@metafoo.de>
 <570A6D99.6000103@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <570A6DC3.3010903@kernel.org>
Date: Sun, 10 Apr 2016 16:14:11 +0100
MIME-Version: 1.0
In-Reply-To: <570A6D99.6000103@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/04/16 16:13, Jonathan Cameron wrote:
> On 10/04/16 15:41, Lars-Peter Clausen wrote:
>> On 04/10/2016 04:37 PM, Jonathan Cameron wrote:
>>> On 06/04/16 11:16, zengzhaoxiu@163.com wrote:
>>>> From: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
>>>>
>>>> Signed-off-by: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
>>> Applied to the togreg branch of iio.git as you seem to have addressed
>>> Lars' comments.
>>
>> The whole series needs to go through the same tree since the new functions
>> are introduced in the beginning.
> Yeah, I just realized that when my build test failed!
> 
> Acked-by: Jonathan Cameron <jic23@kernel.org>
Backed out of the togreg branch of iio.git...

oops and thanks Lars!
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

