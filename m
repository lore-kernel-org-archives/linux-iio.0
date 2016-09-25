Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36792 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938834AbcIYQoI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 25 Sep 2016 12:44:08 -0400
Subject: Re: [PATCH v2] iio: accel: Add driver for the MiraMEMS DA311 3-axis
 12-bit digital accelerometer
To: Lars-Peter Clausen <lars@metafoo.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald <pmeerw@pmeerw.net>
References: <20160922134229.773-1-hdegoede@redhat.com>
 <cb187395-d50d-ff10-c58e-7e68f5fab4f8@metafoo.de>
Cc: linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <e8cdc33b-5331-7e25-8bdb-823cd462644f@kernel.org>
Date: Sun, 25 Sep 2016 17:44:03 +0100
MIME-Version: 1.0
In-Reply-To: <cb187395-d50d-ff10-c58e-7e68f5fab4f8@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/09/16 16:11, Lars-Peter Clausen wrote:
> On 09/22/2016 03:42 PM, Hans de Goede wrote:
> [...]
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_RAW:
>> +		ret = i2c_smbus_read_word_data(data->client, chan->address);
>> +		if (ret < 0)
>> +			return ret;
>> +		/*
>> +		 * Values are 12 bits, stored as 16 bits with the 4
>> +		 * least significant bits always 0.
>> +		 */
>> +		*val = ((short)le16_to_cpu(ret)) >> 4;
> 
> I think the le16_to_cpu() is a leftover from the switch away from
> i2c_smbus_read_i2c_block_data(). i2c_smbus_read_word_data() already returns
> CPU endianess data. On a BE system le16_to_cpu() swaps the lower and upper
> bytes on a BE system. So you'd get the wrong value in that case.
Backed out.  Please check the scale value as well for v3.

Thanks,

Jonathan
> 
>> +		return IIO_VAL_INT;
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

