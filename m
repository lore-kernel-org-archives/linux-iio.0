Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx-37.synserver.de ([212.40.180.155]:36780 "EHLO
	smtp-out-195.synserver.de" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757419AbcBDRiw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 4 Feb 2016 12:38:52 -0500
Subject: Re: [PATCH] iio: use boot time instead of realtime
To: Matt Ranostay <mranostay@gmail.com>, Keith Mok <ek9852@gmail.com>
References: <1454527777-16565-1-git-send-email-ek9852@Gmail.com>
 <CAKzfze-+mu7f0myNAcgwMDtfVpXbPJTE4jgQcSX0nNs4vH7RWQ@mail.gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <56B38C1C.3070104@metafoo.de>
Date: Thu, 4 Feb 2016 18:36:28 +0100
MIME-Version: 1.0
In-Reply-To: <CAKzfze-+mu7f0myNAcgwMDtfVpXbPJTE4jgQcSX0nNs4vH7RWQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/04/2016 01:36 AM, Matt Ranostay wrote:
> Seems like doing a blanket change like this would break a lot of
> drivers since it changes the core ABI

And I think the commit does not quite do what the description says.
ktime_get_real_ns() should account for the time when the system is in suspend.

Keith, please have a look at this discussion for a better approach to
solving this problem while keeping ABI compatibility:
http://marc.info/?l=linux-iio&m=145449725410306&w=2

Thanks for looking into this important issue.

- Lars

> 
> On Wed, Feb 3, 2016 at 11:29 AM, Keith Mok <ek9852@gmail.com> wrote:
>> From: Keith Mok <ek9852@gmail.com>
>>
>> Advanced sensor has fifo/ring buffer internally,
>> they can store data when the system is suspend,
>> we need a timestamp that is able to take into
>> account of the time when the system is suspend also.
>>
>> Signed-off-by: Keith Mok <ek9852@gmail.com>
>> ---
>>  include/linux/iio/iio.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
>> index b589411..7092877 100644
>> --- a/include/linux/iio/iio.h
>> +++ b/include/linux/iio/iio.h
>> @@ -286,7 +286,7 @@ static inline bool iio_channel_has_info(const struct iio_chan_spec *chan,
>>   **/
>>  static inline s64 iio_get_time_ns(void)
>>  {
>> -       return ktime_get_real_ns();
>> +       return ktime_get_boot_ns();
>>  }
>>
>>  /* Device operating modes */
>> --
>> 2.5.1
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

