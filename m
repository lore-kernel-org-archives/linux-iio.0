Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45994 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882Ab3J3RNF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 30 Oct 2013 13:13:05 -0400
In-Reply-To: <CAK9yfHwNpWGLSCf6pGUfAz52OwB7DhYA12akw=gpZNJwwnraDQ@mail.gmail.com>
References: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org> <2b6c890f-c0e3-43a8-9687-f340c6050dcc@email.android.com> <CAK9yfHwNpWGLSCf6pGUfAz52OwB7DhYA12akw=gpZNJwwnraDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH Resend 00/33] iio: Implement and use devm_iio_device_register
From: Jonathan Cameron <jic23@kernel.org>
Date: Wed, 30 Oct 2013 17:12:58 +0000
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <cbef0086-083c-488f-9d55-9d1cdc51da54@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



Sachin Kamat <sachin.kamat@linaro.org> wrote:
>Hi Jonathan,
>
>On 29 October 2013 18:41, Jonathan Cameron <jic23@kernel.org> wrote:
>> Hi Sachin.
>>
>> It may be a few days before I get to thee bit as previously discussed
>at least some of these have simpler remove functions than they should
>have...
>>
>> As such I will push back on some of these ..
>>
>
>You could probably add the core patches first and then others on a
>case-by-case basis.
That is indeed my plan :)
>
>Regards,
>Sachin
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
