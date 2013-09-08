Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37869 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449Ab3IHNYn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 8 Sep 2013 09:24:43 -0400
Message-ID: <522C88B3.7070300@kernel.org>
Date: Sun, 08 Sep 2013 15:24:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/5] iio: refactor info mask and ext_info attribute creation.
References: <1376841012-7542-1-git-send-email-jic23@kernel.org> <1376841012-7542-3-git-send-email-jic23@kernel.org> <5228DA76.8080101@metafoo.de>
In-Reply-To: <5228DA76.8080101@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/05/13 20:24, Lars-Peter Clausen wrote:
> [...]
>> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
>> index cdb034d..ad59fee 100644
>> --- a/include/linux/iio/iio.h
>> +++ b/include/linux/iio/iio.h
>> @@ -38,6 +38,9 @@ enum iio_chan_info_enum {
>>       IIO_CHAN_INFO_HYSTERESIS,
>>   };
>>
>> +enum iio_shared_by { IIO_SEPARATE,
>> +             IIO_SHARED_BY_TYPE };
>> +
> 
> That's not kernel style formating, is it?
> 
> enum iio_shared_by {
>     IIO_SEPARATE,
>     IIO_SHARED_BY_TYPE,
> };
> 
> ... looks much better in my opinion
> 
Fair point, v3 coming up.

> [...]
> 
