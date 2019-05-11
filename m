Return-Path: <SRS0=0vE5=TL=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF47C04AB1
	for <linux-iio@archiver.kernel.org>; Sat, 11 May 2019 12:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9CDD208C0
	for <linux-iio@archiver.kernel.org>; Sat, 11 May 2019 12:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="cdvmuM6L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbfEKMiU (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 11 May 2019 08:38:20 -0400
Received: from first.geanix.com ([116.203.34.67]:42852 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726240AbfEKMiU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 11 May 2019 08:38:20 -0400
Received: from [192.168.100.11] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id 2D2339D3;
        Sat, 11 May 2019 12:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1557578238; bh=UC/puYH+wt85IV2W4tZCv0pxU6/8sAVbfby7+26BUjM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=cdvmuM6L27/g3WTP/lo+ZXg8e5CrD12GVZg/xzqF3/VnUiqcK64lcH3af7/SyPehK
         ht31pyBdAuogPKL6ey8zo3/VKCrWEM8PVown56DoibSLg5VO15Ndvm0MNCy4wxpsP6
         zasDvtzRky0PMPU17Zh7asIcoFBVobOOH9kDl26stM7v0talE78QIjm1hae/q1/Mt/
         2k5YXsq/odNIIsd21pdPQzOiig5MSm9XuE/ZeGVfntw/c3WGTQLQFXXtEcqykkD8GO
         Ihpb2s2nd8EMil+FHYI8JjXMJQzVldcSD+Zr2/2t30Pg8UIzk9LKh+/zBn4J2Xqpm0
         /ydjut3GCCVYA==
Subject: Re: [PATCH 2/2] iio: imu: st_lsm6dsx: add iio trigger and buffer
 support
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, martin@geanix.com,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Denis CIOCCA <denis.ciocca@st.com>
References: <20190507080225.108000-1-sean@geanix.com>
 <20190507080225.108000-2-sean@geanix.com> <20190511123755.2d220233@archlinux>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <893b615d-693a-3a48-9c91-97559bd247e1@geanix.com>
Date:   Sat, 11 May 2019 14:38:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190511123755.2d220233@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 11/05/2019 13.37, Jonathan Cameron wrote:
> On Tue,  7 May 2019 10:02:25 +0200
> Sean Nyekjaer <sean@geanix.com> wrote:
> 
>> This adds support for using iio triggers, this is needed because
>> our hardware guys forgot to connect the irq pins from imu device
>> to the SoC.
>>
>> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> Hi Sean
> 
> A small question on the size of the buffer needed inline.  Otherwise looks
> good to me.
>> ---
>>   drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 37 ++++++++++++++++++++
>>   1 file changed, 37 insertions(+)
>>
>> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
>> index 1ca69598678f..65ab853202de 100644
>> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
>> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
>> @@ -40,8 +40,11 @@
>>   #include <linux/kernel.h>
>>   #include <linux/module.h>
>>   #include <linux/delay.h>
>> +#include <linux/iio/buffer.h>
>>   #include <linux/iio/iio.h>
>>   #include <linux/iio/sysfs.h>
>> +#include <linux/iio/trigger_consumer.h>
>> +#include <linux/iio/triggered_buffer.h>
>>   #include <linux/pm.h>
>>   #include <linux/regmap.h>
>>   #include <linux/bitfield.h>
>> @@ -945,6 +948,30 @@ static int st_lsm6dsx_init_hw_timer(struct st_lsm6dsx_hw *hw)
>>   	return 0;
>>   }
>>   
>> +static irqreturn_t st_lsm6dsx_trigger_handler(int irq, void *p)
>> +{
>> +	struct iio_poll_func *pf = p;
>> +	struct iio_dev *indio_dev = pf->indio_dev;
>> +	struct st_lsm6dsx_sensor *sensor = iio_priv(indio_dev);
>> +	u16 buffer[4 * sizeof(s64)/sizeof(u16)];
> The size may well be correct, but that particular way of expressing it doesn't make
> it terribly clear.
> 
> It seems a bit large... You need the space for the timestamp, so it needs to be
> padded to a u64, but that would still require your other channels to need
> more than 2*sizeof(s64)/sizeof(u16) u16s which is 9 or more of them.
Right now we have u16[16], so that quite at bit large :-)

So maybe something like:
/* 3x s16 + 1x s16(padding) + 1x s64 timestamp */
u16 buffer[2 * sizeof(s64)/sizeof(u16)];
Would do it?

> 
>> +	int tmp, bit;
>> +
>> +	memset(buffer, 0, sizeof(buffer));
>> +
>> +	for_each_set_bit(bit, indio_dev->active_scan_mask, indio_dev->masklength) {
>> +		st_lsm6dsx_read_oneshot(sensor,
>> +					indio_dev->channels[bit].address, &tmp);
>> +		buffer[bit] = tmp;
>> +	}
As you pointed out in the
"[PATCH 1/2] iio: adc: ti-ads8688: save values correct in buffer"
When taking this approach it will not shift down.
>> +
>> +	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
>> +					   iio_get_time_ns(indio_dev));
>> +
>> +	iio_trigger_notify_done(indio_dev->trig);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>>   static int st_lsm6dsx_init_device(struct st_lsm6dsx_hw *hw)
>>   {
>>   	u8 drdy_int_reg;
>> @@ -1093,6 +1120,16 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id, const char *name,
>>   		err = st_lsm6dsx_fifo_setup(hw);
>>   		if (err < 0)
>>   			return err;
>> +	} else {
>> +		for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
>> +			err = devm_iio_triggered_buffer_setup(hw->dev,
>> +					hw->iio_devs[i], NULL,
>> +					st_lsm6dsx_trigger_handler, NULL);
>> +			if (err < 0) {
>> +				dev_err(hw->dev, "iio triggered buffer setup failed\n");
>> +				return err;
>> +			}
>> +		}
>>   	}
>>   
>>   	for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
> 
