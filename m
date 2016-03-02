Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.aswsp.com ([193.34.35.150]:30864 "EHLO mail.aswsp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751350AbcCBOYN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 2 Mar 2016 09:24:13 -0500
Message-ID: <56D6F7B7.9070701@parrot.com>
Date: Wed, 2 Mar 2016 15:24:55 +0100
From: Gregor Boirie <gregor.boirie@parrot.com>
MIME-Version: 1.0
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
CC: <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Irina Tirdea <irina.tirdea@intel.com>,
	Cristina Moraru <cristina.moraru09@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Julia Lawall <Julia.Lawall@lip6.fr>
Subject: Re: [PATCH v1 6/6] iio:magnetometer:ak8975: triggered buffer support
References: <cover.1456916271.git.gregor.boirie@parrot.com> <a41adb99826589314dbbb11f72382a72ef6a2074.1456916271.git.gregor.boirie@parrot.com> <alpine.DEB.2.02.1603021218160.30181@pmeerw.net>
In-Reply-To: <alpine.DEB.2.02.1603021218160.30181@pmeerw.net>
Content-Type: text/plain; charset="iso-8859-15"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


On 03/02/2016 12:36 PM, Peter Meerwald-Stadler wrote:
> On Wed, 2 Mar 2016, Gregor Boirie wrote:
>
>> This will be used together with an external trigger (e.g hrtimer based
>> software trigger).
>> Samples of current acquisition round are cached in RAM in order to allow
>> simultaneous userspace access to buffer content and synchronous
>> "read_raw" API.
> comments below
>   
>> Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
>> ---
>>   drivers/iio/magnetometer/Kconfig  |   2 +
>>   drivers/iio/magnetometer/ak8975.c | 206 ++++++++++++++++++++++++++++++++------
>>   2 files changed, 178 insertions(+), 30 deletions(-)
[snip...]
>> +
>> +	/* Clamp to valid range. */
>> +	*axis = clamp_t(s16, le16_to_cpu((s16)ret), -def->range, def->range);
> this looks wrong; i2c_smbus_read_word_data() reads two bytes (on chip
> in little endian) and converts them to a word (in cpu endianness), so
> le16_to_cpu() in not necessary
>
> so NAK on patch 3/6
oops... silly mistake !
>> +	return 0;
>> +}
>> +
>> +/*
>> + * Retrieve raw flux value for one of the x, y, or z axis.
>> + */
>> +static int ak8975_read_axis(struct iio_dev *indio_dev, struct ak8975_data *data,
>> +			    int index, int *val)
>> +{
>> +	int ret;
>> +	s16 *axis = &data->buff[index];
>> +
>> +	mutex_lock(&data->lock);
>> +
>> +	if (!iio_buffer_enabled(indio_dev)) {
> most drivers return -EBUSY when buffering is enabled and a single read is
> performed
 From a previous discussion here:
http://www.spinics.net/lists/linux-iio/msg22948.html

 From my understanding I have 2 options here:
1) simply return EBUSY when buffering is enabled as you suggest ;
2) lock for exclusive bus access and serialize accesses between trigger 
handler
   and read_raw.

I can see no reason to prevent from concurrent access. I would prefere 
getting
rid of this overly complex "caching" stuff and implement point 2).
Unless somebody states otherwise, I will follow your guidance here.

[snip...]
>> -		*val2 = data->raw_to_gauss[chan->address];
>> +		*val2 = data->raw_to_gauss[chan->scan_index];
> read_raw() is about reading without buffering, but scan_index relates to
> buffering -- probably a reason to keep .address
ok.

[snip...]
> +static int ak8975_fetch_all(const struct i2c_client *client,
> +			    struct ak8975_data *data)
> +{
> +	int ret;
> +	s16 x, y, z;
> I'd rather not use the per-device cache/buffer; if buffer mode is enable,
> read_raw() simply returns -EBUSY
> why not use have a local variable here and save the copying?
>
>> +
>> +	ret = ak8975_start_read_axis(data, client);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/*
>> +	 * For each axis, read the flux value from the appropriate register
>> +	 * (the register is specified in the iio device attributes).
>> +	 * Use a temporary storage to preserve 3D coordinate consistency.
>> +	 */
> it is rather inefficient to set up three separate i2c transactions; can't
> the data be transferred in one go?
Agreed.
>
>> +	ret = ak8975_fetch_axis(client, data->def, 0, &x);
>> +	if (ret)
> fetch axis does
>
>> +		return ret;
>> +	ret = ak8975_fetch_axis(client, data->def, 1, &y);
>> +	if (ret)
>> +		return ret;
>> +	ret = ak8975_fetch_axis(client, data->def, 2, &z);
>> +	if (ret)
>> +		return ret;
>> +
>> +	data->buff[0] = x;
>> +	data->buff[1] = y;
>> +	data->buff[2] = z;
>> +
>> +	return 0;
>> +}
>> +
>> +static int ak8975_buffer_postenable(struct iio_dev *indio_dev)
>> +{
>> +	struct ak8975_data *data = iio_priv(indio_dev);
>> +	int ret;
>> +
>> +	/*
>> +	 * Update channels so that a client getting samples through read_raw
>> +	 * retrieves valid data when buffering has just been enabled but first
>> +	 * sampling round is not yet completed.
>> +	 */
> this function is not needed if -EBUSY is returned in read_raw when
> buffering is enabled
>
>
see above.
[snip...]

Thanks.
