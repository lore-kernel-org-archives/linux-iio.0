Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34754 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754144Ab1LAVRj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 1 Dec 2011 16:17:39 -0500
Message-ID: <4ED7EF01.9090107@kernel.org>
Date: Thu, 01 Dec 2011 21:17:53 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org, Michael.Hennerich@analog.com
Subject: Re: [PATCH 4/7] staging:iio: make iio_sw_buffer_preenable much more
 general.
References: <1322399412-21622-1-git-send-email-jic23@kernel.org> <1322399412-21622-5-git-send-email-jic23@kernel.org> <4ED35310.9010805@metafoo.de>
In-Reply-To: <4ED35310.9010805@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

...
>> +int iio_sw_buffer_preenable(struct iio_dev *indio_dev)
>> +{
>> +	struct iio_buffer *buffer = indio_dev->buffer;
>> +	const struct iio_chan_spec *ch;
>> +	unsigned bytes = 0;
>> +	int length, i;
>> +	dev_dbg(&indio_dev->dev, "%s\n", __func__);
>> +
>> +	/* How much space will the demuxed element take? */
>> +	for_each_set_bit(i, buffer->scan_mask,
>> +			 indio_dev->masklength) {
>> +		ch = iio_find_channel_from_si(indio_dev, i);
>> +		length = ch->scan_type.storagebits/8;
>> +		if (bytes % length)
>> +			bytes += length - bytes % length;
> 
> bytes = ALIGN(bytes, length); would probably make it more obvious what is
> going on here.
Good idea. Thanks.
