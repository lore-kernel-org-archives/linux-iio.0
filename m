Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43130 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887AbbKHN3E (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 8 Nov 2015 08:29:04 -0500
Subject: Re: [PATCH] iio:dac: fix i2c_master_send return code misuse
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>
References: <1445963139-2158-1-git-send-email-jeff.dagenais@gmail.com>
 <1445963139-2158-2-git-send-email-jeff.dagenais@gmail.com>
 <5638C45E.8010209@metafoo.de> <20151104011026.GA39311@dtor-ws>
Cc: Jean-Francois Dagenais <jeff.dagenais@gmail.com>,
	linux-iio@vger.kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net,
	Michael.Hennerich@analog.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <563F4E1A.2020201@kernel.org>
Date: Sun, 8 Nov 2015 13:28:58 +0000
MIME-Version: 1.0
In-Reply-To: <20151104011026.GA39311@dtor-ws>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/11/15 01:10, Dmitry Torokhov wrote:
> On Tue, Nov 03, 2015 at 03:27:42PM +0100, Lars-Peter Clausen wrote:
>> Hi,
>>
>> On 10/27/2015 05:25 PM, Jean-Francois Dagenais wrote:
>>> Contrary to most kernel functions, successful call to
>>> i2c_master_send returns the number or written bytes,not 0.
>>>
>>> However, these callers return the value as is without converting
>>> the return style to conform to the expected standard.
>>>
>>> Signed-off-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
>>
>> Thanks for the patch.
>>
>>> ---
>>>  drivers/iio/dac/ad5064.c  |  5 ++++-
>>>  drivers/iio/dac/ad5446.c  |  4 +++-
>>>  drivers/iio/dac/max517.c  |  6 ++++--
>>>  drivers/iio/dac/max5821.c |  8 ++++++--
>>>  drivers/iio/dac/mcp4725.c | 10 ++++++++--
>>>  5 files changed, 25 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/iio/dac/ad5064.c b/drivers/iio/dac/ad5064.c
>>> index c067e68..0ff1107 100644
>>> --- a/drivers/iio/dac/ad5064.c
>>> +++ b/drivers/iio/dac/ad5064.c
>>> @@ -598,10 +598,13 @@ static int ad5064_i2c_write(struct ad5064_state *st, unsigned int cmd,
>>>  	unsigned int addr, unsigned int val)
>>>  {
>>>  	struct i2c_client *i2c = to_i2c_client(st->dev);
>>> +	int res;
>>>  
>>>  	st->data.i2c[0] = (cmd << 4) | addr;
>>>  	put_unaligned_be16(val, &st->data.i2c[1]);
>>> -	return i2c_master_send(i2c, st->data.i2c, 3);
>>> +	res = i2c_master_send(i2c, st->data.i2c, 3);
>>> +
>>> +	return res == 3 ? 0 : res;
>>>  }
>>
>> The ad5064 is already fixed in Jonathan's tree.
>>
>>>  
>>>  static int ad5064_i2c_probe(struct i2c_client *i2c,
>>> diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
>>> index 07e17d7..9a49941 100644
>>> --- a/drivers/iio/dac/ad5446.c
>>> +++ b/drivers/iio/dac/ad5446.c
>>> @@ -512,7 +512,9 @@ static int ad5622_write(struct ad5446_state *st, unsigned val)
>>>  	struct i2c_client *client = to_i2c_client(st->dev);
>>>  	__be16 data = cpu_to_be16(val);
>>>  
>>> -	return i2c_master_send(client, (char *)&data, sizeof(data));
>>> +	int res = i2c_master_send(client, (char *)&data, sizeof(data));
>>> +
>>> +	return res == sizeof(data)? 0 : res;
>>
>> This still returns the wrong if res is between 0 and sizeof(data)-1. You
>> need something like
>>
>> 	if (res == sizeof(data))
>> 		return 0
>> 	else if (res >= 0)
>> 		return -EIO;
>> 	else
>> 		return res;
>>
>> Same is true for all the other drivers patched.
>>
>> I really wish we could fix this in the I2C core to avoid having to copy and
>> paste the same error handling to each driver.
>>
>> There was this patch[1], but it looks like it was never followed by a v2.
>> Dmitry I'm curious, what happened to that patch?
> 
> Fell through the cracks I'm afraid. I think facility like this is still
> needed as majority of the drivers do not care about short reads in the
> slightest.
> 
Would be great to pick it up again if you have the time!

Jonathan
