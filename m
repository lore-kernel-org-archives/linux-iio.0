Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45525 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090AbbHBRq7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 2 Aug 2015 13:46:59 -0400
Subject: Re: [PATCH v2] tools: iio: iio_utils: Make calc_digits static
To: Daniel Baluta <daniel.baluta@gmail.com>,
	Joo Aun Saw <jasaw@dius.com.au>
References: <1438047973-5635-1-git-send-email-jasaw@dius.com.au>
 <CAEnQRZA5QaXmNjWJJuT+An12M5zmaTK4os7Catwf5H=ZWupgtA@mail.gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55BE5792.20108@kernel.org>
Date: Sun, 2 Aug 2015 18:46:58 +0100
MIME-Version: 1.0
In-Reply-To: <CAEnQRZA5QaXmNjWJJuT+An12M5zmaTK4os7Catwf5H=ZWupgtA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 28/07/15 09:15, Daniel Baluta wrote:
> On Tue, Jul 28, 2015 at 4:46 AM, Joo Aun Saw <jasaw@dius.com.au> wrote:
>> From: Joo Aun Saw <jasaw@dius.com.au>
>>
>> Signed-off-by: Joo Aun Saw <jasaw@dius.com.au>
> 
> Acked-by: Daniel Baluta <daniel.baluta@intel.com>
Applied.

Good little bits of cleanup.   Thanks

Jonathan
> 
>> ---
>>  tools/iio/iio_utils.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
>> index e9fbaf8..563d9f0 100644
>> --- a/tools/iio/iio_utils.c
>> +++ b/tools/iio/iio_utils.c
>> @@ -537,7 +537,7 @@ error_free_name:
>>         return ret;
>>  }
>>
>> -int calc_digits(int num)
>> +static int calc_digits(int num)
>>  {
>>         int count = 0;
>>
>> --
>> 1.9.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

