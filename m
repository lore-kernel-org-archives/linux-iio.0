Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56585 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752211Ab3IUK7P (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 21 Sep 2013 06:59:15 -0400
Message-ID: <523D8A27.4010403@kernel.org>
Date: Sat, 21 Sep 2013 12:59:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 09/10] iio:buffer: Add proper locking for iio_update_buffers()
References: <1379534574-11213-1-git-send-email-lars@metafoo.de> <1379534574-11213-9-git-send-email-lars@metafoo.de> <523A0CCE.3010003@metafoo.de>
In-Reply-To: <523A0CCE.3010003@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/18/13 21:27, Lars-Peter Clausen wrote:
> [...]
>> +int iio_update_buffers(struct iio_dev *indio_dev,
>> +               struct iio_buffer *insert_buffer,
>> +               struct iio_buffer *remove_buffer)
>> +{
>> +    int ret;
>> +
>> +    mutex_lock(&indio_dev->info_exist_lock);
>> +    mutex_lock(&indio_dev->mlock);
>> +
>> +    if (indio_dev->info == NULL)
>> +        return -ENODEV;
> 
> Yea, ok that happens when send patches way to late in the evening. Of course we still need to unlock here...
Any reason not to do the indio_dev->info test before locking in the first place?
> 
>> +    ret = __iio_update_buffers(indio_dev, insert_buffer, remove_buffer);
>> +
>> +    mutex_unlock(&indio_dev->mlock);
>> +    mutex_unlock(&indio_dev->info_exist_lock);
>> +
>> +    return ret;
>> +}
> 
