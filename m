Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47553 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751900AbaAKMNV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 11 Jan 2014 07:13:21 -0500
Message-ID: <52D1356A.8010108@kernel.org>
Date: Sat, 11 Jan 2014 12:13:30 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/5] iio:magnetometer:mag3110: Report busy in _read_raw()
 / write_raw() when buffer is enabled
References: <1389391163-9622-1-git-send-email-pmeerw@pmeerw.net> <52D13408.4040103@kernel.org>
In-Reply-To: <52D13408.4040103@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 11/01/14 12:07, Jonathan Cameron wrote:
> On 10/01/14 21:59, Peter Meerwald wrote:
>> individual reads are not permitted concurrently with buffered reads
>>
> This isn't technically a requirement.  The reasoning behind doing it
> is normally that a userspace read could mess up the timing of a fixed
> frequency triggered signal.  I guess that's true here but is probably
> not a strong enough reason to make an ABI change.
>
> Perhaps an ammended description to describe the reasoning for not
> allowing it in this driver?
>
> While obscure this is an ABI change as reads that would previously
> have succeeded will fail (I doubt anyone will notice, but you never
> know...)
>
> The arguement for protecting against changes in the sampling frequency
> is perhaps a little stronger as that may cause nasty issues in the buffered
> read...

Ah, I'd forgotten we only merged this very recently.  I think this counts as a fix,
so will queue it up for after the merge window.  As the original ABI was never in
a release kernel we can change it without worrying ;)

There's a new temporary branch for iio.git containing this
fixes-for-3.14new


>> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
>> ---
>>   drivers/iio/magnetometer/mag3110.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/iio/magnetometer/mag3110.c b/drivers/iio/magnetometer/mag3110.c
>> index 4b65b6d..b88cb44 100644
>> --- a/drivers/iio/magnetometer/mag3110.c
>> +++ b/drivers/iio/magnetometer/mag3110.c
>> @@ -154,6 +154,9 @@ static int mag3110_read_raw(struct iio_dev *indio_dev,
>>
>>       switch (mask) {
>>       case IIO_CHAN_INFO_RAW:
>> +        if (iio_buffer_enabled(indio_dev))
>> +            return -EBUSY;
>> +
>>           switch (chan->type) {
>>           case IIO_MAGN: /* in 0.1 uT / LSB */
>>               ret = mag3110_read(data, buffer);
>> @@ -199,6 +202,9 @@ static int mag3110_write_raw(struct iio_dev *indio_dev,
>>       struct mag3110_data *data = iio_priv(indio_dev);
>>       int rate;
>>
>> +    if (iio_buffer_enabled(indio_dev))
>> +        return -EBUSY;
>> +
>>       switch (mask) {
>>       case IIO_CHAN_INFO_SAMP_FREQ:
>>           rate = mag3110_get_samp_freq_index(data, val, val2);
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
