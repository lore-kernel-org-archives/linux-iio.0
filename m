Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48981 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754608Ab3JBRjr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 2 Oct 2013 13:39:47 -0400
In-Reply-To: <524C55A0.30008@metafoo.de>
References: <1380256624-12588-1-git-send-email-sachin.kamat@linaro.org> <CAK9yfHx2dK1KSTQXoCtbhPaA9jYkyoC3_3NggAMio1TpPiY+9A@mail.gmail.com> <524C55A0.30008@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH v2 1/1] iio: core: Implement devm_iio_device_{register,unregister}
From: Jonathan Cameron <jic23@kernel.org>
Date: Wed, 02 Oct 2013 18:39:40 +0100
To: Lars-Peter Clausen <lars@metafoo.de>,
	Sachin Kamat <sachin.kamat@linaro.org>
CC: linux-iio@vger.kernel.org
Message-ID: <12c105d8-29b0-4914-ac8a-ce0d560d4274@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



Lars-Peter Clausen <lars@metafoo.de> wrote:
>On 10/02/2013 06:54 PM, Sachin Kamat wrote:
>> Hi,
>> 
>> On 27 September 2013 10:07, Sachin Kamat <sachin.kamat@linaro.org>
>wrote:
>>> Add device managed devm_iio_device_{register,unregister}()
>>> to automatically unregister IIO drivers thus leading to
>>> simplified IIO driver code.
>>>
>>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>>> Cc: Lars-Peter Clausen <lars@metafoo.de>
>>> ---
>>> Changes since v1:
>>> Incorporated review comments from Lars-Peter Clausen
>>> * Renamed variables
>>> * Fixed the broken implementation
>>> * Moved kernel doc from .h to .c file
>>> ---
>> 
>> Does this look good now?
>> 
>
>Yes, but I want to at least test it once before I ack it.

And I am waiting on Lars' ack before taking it :)
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
