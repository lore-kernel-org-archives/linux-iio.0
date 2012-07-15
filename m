Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45758 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751698Ab2GOQeg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 15 Jul 2012 12:34:36 -0400
Message-ID: <5002F115.2010408@kernel.org>
Date: Sun, 15 Jul 2012 17:34:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: wharms@bfs.de
CC: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: fix pointer cast warning
References: <1342283004-15118-1-git-send-email-pmeerw@pmeerw.net> <5001A0FB.2010508@bfs.de>
In-Reply-To: <5001A0FB.2010508@bfs.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/14/2012 05:40 PM, walter harms wrote:
> 
> 
> Am 14.07.2012 18:23, schrieb Peter Meerwald:
>> fix compile warning reported by Fengguang Wu:
>>
>> drivers/iio/light/adjd_s311.c: In function 'adjd_s311_trigger_handler':
>> drivers/iio/light/adjd_s311.c:188:12: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>> drivers/iio/light/adjd_s311.c:188:4: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>>
>>    185              }
>>    186
>>    187              if (indio_dev->scan_timestamp)
>>  > 188                      *(s64 *)((phys_addr_t)data->buffer + ALIGN(len, sizeof(s64)))
>>    189                              = time_ns;
>>    190              iio_push_to_buffer(buffer, (u8 *)data->buffer, time_ns);
>>    191
>>
>> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
>> Reported-by: Fengguang Wu <fengguang.wu@intel.com>
merged this one and the other two. Thanks Peter and Fengguang.
>> ---
>>  drivers/iio/light/adjd_s311.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/light/adjd_s311.c b/drivers/iio/light/adjd_s311.c
>> index e485142..1cbb449 100644
>> --- a/drivers/iio/light/adjd_s311.c
>> +++ b/drivers/iio/light/adjd_s311.c
>> @@ -185,7 +185,7 @@ static irqreturn_t adjd_s311_trigger_handler(int irq, void *p)
>>  	}
>>  
>>  	if (indio_dev->scan_timestamp)
>> -		*(s64 *)((phys_addr_t)data->buffer + ALIGN(len, sizeof(s64)))
>> +		*(s64 *)((u8 *)data->buffer + ALIGN(len, sizeof(s64)))
>>  			= time_ns;
>>  	iio_push_to_buffer(buffer, (u8 *)data->buffer, time_ns);
>>  
> 
> a few lines below is an othern cast (u8 *)data->buffer, i do not see the rest of the code,
> but perhaps adding a helper will help here to improve readability ?
> 
> just my 2 cents,
> re,
>  wh
Not really in this case. This stuff is all here because we are
filling up a data record with different sized elements.
As most of them in this driver are 16 bit, the data->buffer is 16 bit
hence the need for these type casts.  Not sure where the phys_addr_t
misuse here first came from, but it's thankfully only in a couple of
drivers.

Jonathan


