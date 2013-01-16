Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from eu1sys200aog113.obsmtp.com ([207.126.144.135]:42385 "EHLO
	eu1sys200aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757613Ab3APQaw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 16 Jan 2013 11:30:52 -0500
From: Denis CIOCCA <denis.ciocca@st.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: "jic23@kernel.org" <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Date: Wed, 16 Jan 2013 17:30:32 +0100
Subject: Re: [PATCH 1/9] iio:common: Add STMicroelectronics common library
Message-ID: <50F6D5A8.6050306@st.com>
References: <1358238660-14929-1-git-send-email-denis.ciocca@st.com>
 <1358238660-14929-2-git-send-email-denis.ciocca@st.com>
 <50F6B410.6040207@metafoo.de>
In-Reply-To: <50F6B410.6040207@metafoo.de>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Lars-Peter,

thank you very much for your review!

>> +int st_sensors_read_axis_data(struct iio_dev *indio_dev, u8 ch_addr, int *data)
>> +{
>> +	int err;
>> +	u8 outdata[ST_SENSORS_BYTE_FOR_CHANNEL];
>> +	struct st_sensor_data *sdata = iio_priv(indio_dev);
>> +
>> +	err = sdata->tf->read_multiple_byte(&sdata->tb, sdata->dev,
>> +			ch_addr, ST_SENSORS_BYTE_FOR_CHANNEL,
>> +						outdata, sdata->multiread_bit);
>> +	if (err < 0)
>> +		goto read_error;
>> +
>> +	*data = ((s16)le16_to_cpup((__le16 *)outdata));
>
> Either make outdata a __le16 or use get_unaligned_le16.

get_unaligned_le16 doesn't do what I have done?


Denis