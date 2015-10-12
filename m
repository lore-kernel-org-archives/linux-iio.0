Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49545 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752530AbbJLQN3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 12 Oct 2015 12:13:29 -0400
In-Reply-To: <A04E1290-0840-4B33-835D-35607476352E@maplehightech.com>
References: <1444564511-30310-1-git-send-email-jic23@kernel.org> <561A4E8F.7020300@kernel.org> <59857F91-5574-4FD3-ACC9-E82814E601D2@maplehightech.com> <561A6448.5090505@kernel.org> <A04E1290-0840-4B33-835D-35607476352E@maplehightech.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH] iio:measurement specialties core: Fix endian sparse warnings.
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Mon, 12 Oct 2015 17:12:58 +0100
To: "ludovic.tancerel@maplehightech.com"
	<ludovic.tancerel@maplehightech.com>,
	Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org, kbuild-all@01.org,
	fengguang.wu@intel.com
Message-ID: <72A2CCB3-B985-490D-B2DC-CBA1D112F0A6@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 12 October 2015 10:36:06 BST, "ludovic.tancerel@maplehightech.com" <ludovic.tancerel@maplehightech.com> wrote:
>Hello Jonathan,
>
>I was able to test the patch, and checked items impacted with your
>change.
>>From my prospective it is ok to apply.
>
>Regards,
>Ludovic
Thanks

A formal Acked-by always appreciated with patches like this one...

J
>
>
>> Le 11 oct. 2015 à 15:29, Jonathan Cameron <jic23@kernel.org> a écrit
>:
>> 
>> On 11/10/15 13:16, ludovic.tancerel@maplehightech.com wrote:
>>> Hello Jonathan
>>> 
>>> I often work on Sunday, so it is not a pb.
>>> 
>>> I apologize for not correcting this myself, I was not sure what had
>to be done …
>> That's quite alright.  I'm rubbish at spotting this particular issue
>in drivers
>> or we'd have dealt with it earlier + my sparse was out of date (now
>it reports
>> the same as the autobuilder one).
>> 
>>> I had a look and this looks ok.
>> Cool
>>> 
>>> I cannot test this today as I do not have access to HW, but can
>surely test the patch tomorrow morning.
>> I'll probably set up my pull request then but not actually send it
>until I get an OK from
>> you.
>>> 
>>> Thanks a lot for doing the change,
>>> regards,
>>> Ludo
>>> 
>>> 
>>> 
>>>> Le 11 oct. 2015 à 13:57, Jonathan Cameron <jic23@kernel.org> a
>écrit :
>>>> 
>>>> If anyone can take a quick look at this today (ideally Ludovic! but
>I appreciate it's a Sunday)
>>>> that would be great as this is stalling my sending pull request to
>Greg.
>>>> 
>>>> I 'might' apply it anyway on the basis it is straight forward but
>>>> nice to have a sanity check from someone!
>>>> 
>>>> Jonathan
>>>> 
>>>> 
>>>> On 11/10/15 12:55, Jonathan Cameron wrote:
>>>>> This patch changes various types to the appropriate endian
>specific
>>>>> versions.  Also introduces an additional local variable to avoid
>>>>> a single variable being used for both be and cpu endianness.
>>>>> 
>>>>> These aren't bugs as such, but clearing them up does make the code
>>>>> clearer.
>>>>> 
>>>>> Warning was:
>>>>> sparse warnings: (new ones prefixed by >>)
>>>>> 
>>>>>>> drivers/iio/common/ms_sensors/ms_sensors_i2c.c:126:9: sparse:
>cast to restricted __be32
>>>>>>> drivers/iio/common/ms_sensors/ms_sensors_i2c.c:126:9: sparse:
>cast to restricted __be32
>>>>>>> drivers/iio/common/ms_sensors/ms_sensors_i2c.c:126:9: sparse:
>cast to restricted __be32
>>>>>>> drivers/iio/common/ms_sensors/ms_sensors_i2c.c:126:9: sparse:
>cast to restricted __be32
>>>>>>> drivers/iio/common/ms_sensors/ms_sensors_i2c.c:126:9: sparse:
>cast to restricted __be32
>>>>>>> drivers/iio/common/ms_sensors/ms_sensors_i2c.c:126:9: sparse:
>cast to restricted __be32
>>>>>  drivers/iio/common/ms_sensors/ms_sensors_i2c.c:127:16: sparse:
>cast to restricted __be32
>>>>>  drivers/iio/common/ms_sensors/ms_sensors_i2c.c:127:16: sparse:
>cast to restricted __be32
>>>>>  drivers/iio/common/ms_sensors/ms_sensors_i2c.c:127:16: sparse:
>cast to restricted __be32
>>>>>  drivers/iio/common/ms_sensors/ms_sensors_i2c.c:127:16: sparse:
>cast to restricted __be32
>>>>>  drivers/iio/common/ms_sensors/ms_sensors_i2c.c:127:16: sparse:
>cast to restricted __be32
>>>>>  drivers/iio/common/ms_sensors/ms_sensors_i2c.c:127:16: sparse:
>cast to restricted __be32
>>>>>>> drivers/iio/common/ms_sensors/ms_sensors_i2c.c:208:18: sparse:
>incorrect type in assignment (different base types)
>>>>>  drivers/iio/common/ms_sensors/ms_sensors_i2c.c:208:18:   
>expected unsigned short [unsigned] [addressable] [usertype] send_buf
>>>>>  drivers/iio/common/ms_sensors/ms_sensors_i2c.c:208:18:    got
>restricted __be16 [usertype] <noident>
>>>>>>> drivers/iio/common/ms_sensors/ms_sensors_i2c.c:216:19: sparse:
>cast to restricted __be64
>>>>>>> drivers/iio/common/ms_sensors/ms_sensors_i2c.c:216:19: sparse:
>cast to restricted __be64
>>>>>>> drivers/iio/common/ms_sensors/ms_sensors_i2c.c:216:19: sparse:
>cast to restricted __be64
>>>>>>> drivers/iio/common/ms_sensors/ms_sensors_i2c.c:216:19: sparse:
>cast to restricted __be64
>>>>>>> drivers/iio/common/ms_sensors/ms_sensors_i2c.c:216:19: sparse:
>cast to restricted __be64
>>>>>>> drivers/iio/common/ms_sensors/ms_sensors_i2c.c:216:19: sparse:
>cast to restricted __be64
>>>>>>> drivers/iio/common/ms_sensors/ms_sensors_i2c.c:216:19: sparse:
>cast to restricted __be64
>>>>>>> drivers/iio/common/ms_sensors/ms_sensors_i2c.c:216:19: sparse:
>cast to restricted __be64
>>>>>>> drivers/iio/common/ms_sensors/ms_sensors_i2c.c:216:19: sparse:
>cast to restricted __be64
>>>>>>> drivers/iio/common/ms_sensors/ms_sensors_i2c.c:216:19: sparse:
>cast to restricted __be64
>>>>>  drivers/iio/common/ms_sensors/ms_sensors_i2c.c:230:18: sparse:
>incorrect type in assignment (different base types)
>>>>>  drivers/iio/common/ms_sensors/ms_sensors_i2c.c:230:18:   
>expected unsigned short [unsigned] [addressable] [usertype] send_buf
>>>>>  drivers/iio/common/ms_sensors/ms_sensors_i2c.c:230:18:    got
>restricted __be16 [usertype] <noident>
>>>>>  drivers/iio/common/ms_sensors/ms_sensors_i2c.c:239:19: sparse:
>cast to restricted __be64
>>>>>  drivers/iio/common/ms_sensors/ms_sensors_i2c.c:239:19: sparse:
>cast to restricted __be64
>>>>>  drivers/iio/common/ms_sensors/ms_sensors_i2c.c:239:19: sparse:
>cast to restricted __be64
>>>>>  drivers/iio/common/ms_sensors/ms_sensors_i2c.c:239:19: sparse:
>cast to restricted __be64
>>>>>  drivers/iio/common/ms_sensors/ms_sensors_i2c.c:239:19: sparse:
>cast to restricted __be64
>>>>>  drivers/iio/common/ms_sensors/ms_sensors_i2c.c:239:19: sparse:
>cast to restricted __be64
>>>>>  drivers/iio/common/ms_sensors/ms_sensors_i2c.c:239:19: sparse:
>cast to restricted __be64
>>>>>  drivers/iio/common/ms_sensors/ms_sensors_i2c.c:239:19: sparse:
>cast to restricted __be64
>>>>>  drivers/iio/common/ms_sensors/ms_sensors_i2c.c:239:19: sparse:
>cast to restricted __be64
>>>>>  drivers/iio/common/ms_sensors/ms_sensors_i2c.c:239:19: sparse:
>cast to restricted __be64
>>>>> 
>>>>> 
>>>>> Reported-by: kbuild test robot <fengguang.wu@intel.com>
>>>>> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
>>>>> ---
>>>>> drivers/iio/common/ms_sensors/ms_sensors_i2c.c | 29
>+++++++++++++-------------
>>>>> 1 file changed, 15 insertions(+), 14 deletions(-)
>>>>> 
>>>>> diff --git a/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
>b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
>>>>> index 056c4f3bf497..669dc7c270f5 100644
>>>>> --- a/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
>>>>> +++ b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
>>>>> @@ -106,7 +106,7 @@ int ms_sensors_convert_and_read(void *cli, u8
>conv, u8 rd,
>>>>> 				unsigned int delay, u32 *adc)
>>>>> {
>>>>> 	int ret;
>>>>> -	u32 buf = 0;
>>>>> +        __be32 buf = 0;
>>>>> 	struct i2c_client *client = (struct i2c_client *)cli;
>>>>> 
>>>>> 	/* Trigger conversion */
>>>>> @@ -186,8 +186,9 @@ static bool ms_sensors_crc_valid(u32 value)
>>>>> int ms_sensors_read_serial(struct i2c_client *client, u64 *sn)
>>>>> {
>>>>> 	u8 i;
>>>>> -	u64 rcv_buf = 0;
>>>>> -	u16 send_buf;
>>>>> +	__be64 rcv_buf = 0;
>>>>> +	u64 rcv_val;
>>>>> +	__be16 send_buf;
>>>>> 	int ret;
>>>>> 
>>>>> 	struct i2c_msg msg[2] = {
>>>>> @@ -213,18 +214,18 @@ int ms_sensors_read_serial(struct i2c_client
>*client, u64 *sn)
>>>>> 		return ret;
>>>>> 	}
>>>>> 
>>>>> -	rcv_buf = be64_to_cpu(rcv_buf);
>>>>> -	dev_dbg(&client->dev, "Serial MSB raw : %llx\n", rcv_buf);
>>>>> +	rcv_val = be64_to_cpu(rcv_buf);
>>>>> +	dev_dbg(&client->dev, "Serial MSB raw : %llx\n", rcv_val);
>>>>> 
>>>>> 	for (i = 0; i < 64; i += 16) {
>>>>> -		if (!ms_sensors_crc_valid((rcv_buf >> i) & 0xFFFF))
>>>>> +		if (!ms_sensors_crc_valid((rcv_val >> i) & 0xFFFF))
>>>>> 			return -ENODEV;
>>>>> 	}
>>>>> 
>>>>> -	*sn = (((rcv_buf >> 32) & 0xFF000000) |
>>>>> -	       ((rcv_buf >> 24) & 0x00FF0000) |
>>>>> -	       ((rcv_buf >> 16) & 0x0000FF00) |
>>>>> -	       ((rcv_buf >> 8) & 0x000000FF)) << 16;
>>>>> +	*sn = (((rcv_val >> 32) & 0xFF000000) |
>>>>> +	       ((rcv_val >> 24) & 0x00FF0000) |
>>>>> +	       ((rcv_val >> 16) & 0x0000FF00) |
>>>>> +	       ((rcv_val >> 8) & 0x000000FF)) << 16;
>>>>> 
>>>>> 	/* Read LSB part of serial number */
>>>>> 	send_buf = cpu_to_be16(MS_SENSORS_SERIAL_READ_LSB);
>>>>> @@ -236,15 +237,15 @@ int ms_sensors_read_serial(struct i2c_client
>*client, u64 *sn)
>>>>> 		return ret;
>>>>> 	}
>>>>> 
>>>>> -	rcv_buf = be64_to_cpu(rcv_buf) >> 16;
>>>>> -	dev_dbg(&client->dev, "Serial MSB raw : %llx\n", rcv_buf);
>>>>> +	rcv_val = be64_to_cpu(rcv_buf) >> 16;
>>>>> +	dev_dbg(&client->dev, "Serial MSB raw : %llx\n", rcv_val);
>>>>> 
>>>>> 	for (i = 0; i < 48; i += 24) {
>>>>> -		if (!ms_sensors_crc_valid((rcv_buf >> i) & 0xFFFFFF))
>>>>> +		if (!ms_sensors_crc_valid((rcv_val >> i) & 0xFFFFFF))
>>>>> 			return -ENODEV;
>>>>> 	}
>>>>> 
>>>>> -	*sn |= (rcv_buf & 0xFFFF00) << 40 | (rcv_buf >> 32);
>>>>> +	*sn |= (rcv_val & 0xFFFF00) << 40 | (rcv_val >> 32);
>>>>> 
>>>>> 	return 0;
>>>>> }
>>>>> 
>>>> 
>>> 
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-iio"
>in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> 
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio"
>in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
