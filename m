Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-070.synserver.de ([212.40.185.70]:1049 "EHLO
	smtp-out-070.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757037Ab3APRMI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 16 Jan 2013 12:12:08 -0500
Message-ID: <50F6DF9C.40703@metafoo.de>
Date: Wed, 16 Jan 2013 18:13:00 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Denis CIOCCA <denis.ciocca@st.com>
CC: "jic23@kernel.org" <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/9] iio:common: Add STMicroelectronics common library
References: <1358238660-14929-1-git-send-email-denis.ciocca@st.com> <1358238660-14929-2-git-send-email-denis.ciocca@st.com> <50F6B410.6040207@metafoo.de> <50F6D5A8.6050306@st.com>
In-Reply-To: <50F6D5A8.6050306@st.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/16/2013 05:30 PM, Denis CIOCCA wrote:
> Hi Lars-Peter,
> 
> thank you very much for your review!
> 
>>> +int st_sensors_read_axis_data(struct iio_dev *indio_dev, u8 ch_addr, int *data)
>>> +{
>>> +	int err;
>>> +	u8 outdata[ST_SENSORS_BYTE_FOR_CHANNEL];
>>> +	struct st_sensor_data *sdata = iio_priv(indio_dev);
>>> +
>>> +	err = sdata->tf->read_multiple_byte(&sdata->tb, sdata->dev,
>>> +			ch_addr, ST_SENSORS_BYTE_FOR_CHANNEL,
>>> +						outdata, sdata->multiread_bit);
>>> +	if (err < 0)
>>> +		goto read_error;
>>> +
>>> +	*data = ((s16)le16_to_cpup((__le16 *)outdata));
>>
>> Either make outdata a __le16 or use get_unaligned_le16.
> 
> get_unaligned_le16 doesn't do what I have done?

It does. But it takes a u8*. So you don't have to cast to __le16 *.

- Lars
