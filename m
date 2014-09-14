Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56593 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752766AbaINTyy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 14 Sep 2014 15:54:54 -0400
Message-ID: <5415F286.6050405@kernel.org>
Date: Sun, 14 Sep 2014 20:54:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/3] iio:kxcjk-1013: Correct error messages
References: <1405370318-19699-1-git-send-email-pmeerw@pmeerw.net> <1405370318-19699-2-git-send-email-pmeerw@pmeerw.net> <53C46095.9020002@linux.intel.com> <53CBF3A1.6030508@kernel.org>
In-Reply-To: <53CBF3A1.6030508@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/07/14 17:51, Jonathan Cameron wrote:
> On 14/07/14 23:58, Srinivas Pandruvada wrote:
>> On 07/14/2014 01:38 PM, Peter Meerwald wrote:
>>> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
>>> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> This one doesn't apply cleanly on top of Srinivas' patches that I took
> earlier today.  I'll hold it for now as it's not as urgent as the next
> one and sort it out after Srinivas' series is all in place.
> 
No longer relevant as far as I can see so dropped.
> J
>>> ---
>>>   drivers/iio/accel/kxcjk-1013.c | 6 +++---
>>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
>>> index 72a6dbb..a11588c 100644
>>> --- a/drivers/iio/accel/kxcjk-1013.c
>>> +++ b/drivers/iio/accel/kxcjk-1013.c
>>> @@ -144,7 +144,7 @@ static int kxcjk1013_chip_ack_intr(struct kxcjk1013_data *data)
>>>
>>>       ret = i2c_smbus_read_byte_data(data->client, KXCJK1013_REG_INT_REL);
>>>       if (ret < 0) {
>>> -        dev_err(&data->client->dev, "Error writing reg_int_rel\n");
>>> +        dev_err(&data->client->dev, "Error reading reg_int_rel\n");
>>>           return ret;
>>>       }
>>>
>>> @@ -183,7 +183,7 @@ static int kxcjk1013_chip_init(struct kxcjk1013_data *data)
>>>       ret = i2c_smbus_write_byte_data(data->client, KXCJK1013_REG_CTRL1,
>>>                       ret);
>>>       if (ret < 0) {
>>> -        dev_err(&data->client->dev, "Error reading reg_ctrl\n");
>>> +        dev_err(&data->client->dev, "Error writing reg_ctrl1\n");
>>>           return ret;
>>>       }
>>>
>>> @@ -337,7 +337,7 @@ static int kxcjk1013_get_acc_reg(struct kxcjk1013_data *data, int axis)
>>>       ret = i2c_smbus_read_word_data(data->client, reg);
>>>       if (ret < 0) {
>>>           dev_err(&data->client->dev,
>>> -            "failed to read accel_%c registers\n", 'x' + axis);
>>> +            "failed to read accel_%c register\n", 'x' + axis);
>>>           return ret;
>>>       }
>>>
>>>
>> Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>>
> 
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
