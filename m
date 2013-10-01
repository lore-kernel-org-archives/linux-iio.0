Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51984 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751617Ab3JAIOX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 1 Oct 2013 04:14:23 -0400
Message-ID: <524A928B.4070500@kernel.org>
Date: Tue, 01 Oct 2013 10:14:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 07/18] staging:iio:lis3l02dq: Switch to new event config
 interface
References: <1380200317-19355-1-git-send-email-lars@metafoo.de> <1380200317-19355-7-git-send-email-lars@metafoo.de> <5249E55B.8040205@kernel.org> <524A7EEF.9030805@metafoo.de>
In-Reply-To: <524A7EEF.9030805@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/01/13 08:51, Lars-Peter Clausen wrote:
> On 09/30/2013 10:55 PM, Jonathan Cameron wrote:
>> On 09/26/13 13:58, Lars-Peter Clausen wrote:
>>> Switch the lis3l02dq driver to the new IIO event config interface as the old one
>>> is going to be removed.
>>>
>>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>> Hi Lars,
>>
>> As this one is in staging, lets take advantage of the fact that we now
>> have the ability to have shared elements.  It's an ABI change so I wouldn't
>> suggest this for drivers outside staging.
>>
>> The threshold value is shared by all channels (only one address to write) for each
>> of the two types.
> 
> Ok, I'll add that to the series, but as a separate patch. One patch for
> changing to the new API, one patch for changing the behavior.
> 
> - Lars
Great, thanks for doing this.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
