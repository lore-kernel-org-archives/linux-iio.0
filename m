Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3877326738C
	for <linux-iio@vger.kernel.org>; Sun, 12 Apr 2026 15:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776007442; cv=none; b=BT3VQ/o3uZcmEVc69Wp+g/OJ+v6t3sVIc/SDqc33CVmmhBmIlPVZCi5kR8ybkC14s/6r6qyRg933n3N0/F40jbfpVzfticjLCzczjIYHDyUPDRhqWNdZQKp2aM+U1JWLGv5r4iFq+RP0TKscIv+ulpdhhl+6+4MHARiYi900V98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776007442; c=relaxed/simple;
	bh=FPGaXcfmabiar/rSfKoC9uPyexk+6LJ6+wVeLmoUHck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QNURHOZdaO/MfQvaXc85QtxD8jQiQgN0wXxKccl5VAWvVSoD7Ett1VhHdI+j1TAIdzZvv1Fmu24v4KSr5vIeNaRh4J2o98MxJ4RD2CFVTcIyt2rDb02ePNV0qnOdrWe+4+i0Db6lhvuOOcUmcSGzpTElMkzlH6OV/YcExWyXZiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=etSiLTQX; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etSiLTQX"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ab46931cf1so20186725ad.0
        for <linux-iio@vger.kernel.org>; Sun, 12 Apr 2026 08:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776007440; x=1776612240; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eN2oRsTXapnt91T3KeM7fJZ9SdeiVxJz/kxThQtQHW8=;
        b=etSiLTQXAyvEI4uXepshmaDaAJLp3Qs135jiOJxgtxghglDV7nG0nhpIvXt9wmQL+s
         A4EOfvjwDU4KXwKVVU8rg8MJcPqo8J9eXh5yNu2SUmKjNoUvpPeK/Pza3Ns46dMTMFCa
         z1P+55S0CZYrZrgx7FGky5wwPZQ2GUiCA6WOTFFKo+eUv5URGYguqnprEltWP5q/444K
         RVxnMetmXAKLLl4U43XpI8+T4NbemVB4rhd+1eMFTAWBArEyejbboKBXpdL6c3T92F+x
         ADVqaznQ0dWiJRP+BDAoz7jNCkb4yY+CgDgo7JHCWKDJY5MjEghcjWjx68iphn0ZXDkJ
         8HWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776007440; x=1776612240;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eN2oRsTXapnt91T3KeM7fJZ9SdeiVxJz/kxThQtQHW8=;
        b=Avq0LZP/9opm5DZTYig5wqjCw/tfS1KyNL0EAcR7PwWp3rftYj9IDQm/zNdLWBO5Uk
         eWyuP0KEsMXw8Ns5L7h2CfRvorBr7U/QeuG7W9T2AxHCgUSG5LpdIIlii0+LGDZjbqt7
         WSUcRvsQPEH7W7YICU8sxOidSsA8CJhghEsdVU2++dRhqyWBYR2Ll5Z0XJJ5l2zjFsnM
         SMVXPc55iQWQjmljlznqdd9LUGpKo/KZ2212OgvPwDKlZk2MgKW1C9Tm4WXctBW7gmOf
         rNaQtaFOc9YW9QBoY/7mRxqNY0ww2OMurRR0xlrw3B49hOgL+PKXLNMLmaU86uHhMOuC
         TK5A==
X-Forwarded-Encrypted: i=1; AFNElJ9If8dHdzRstm9ZpYZ9bye9Zt9y4kALLb6g1mC8dbDv5bz1HcNf/YtktjPqwOnVQRSstgaO1Rel7n0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3RvyMz4Rj/k+2tjrugyucascG6Y2VWMpWMgKzXG6Vo36XD9Rv
	LkWfUyJ3pgmqa7aLVeK/ZPQVjXaBGriC3Ehd4mpqZ6WCfkWmV2SjJtsbANLtx80tYw==
X-Gm-Gg: AeBDiet8mBiQllpXeOcBZpM/U/mWvRKLXAXlL7mZaoTFuf27nd/6jDqXIhYP7z01B20
	mOGQGHMGRpQJ5L/02r+0nV94mQhp3fQMx4Idz3b7SkzUNyQkOb74FPPXTfH594Hw4BlbsFeBYmv
	8hK1fY71FToHhfnGF+A9tjj1MKnrscpGT4xj4ROCYpZx+CjXdqUbFGJq3gJDlUGU0CshTEhePez
	pt1RSHkUl7cytRHxWtHXXedoVU/OUh1f4n4ZGQdnu7rert8f3BIeKL5eRonuNRdqzeO0zU0t67U
	Tb31IZcDv0r3idIrVU51ADceQQJs2zG5dp3rx1GqE8JxafTg6gY3pWq55zEDhd+n4J5zBC45meu
	QNdS0XP8CCzMakD5tNkyJfx83WxY5U1iQR2npJPQk3VXCC1cT6KtFyTL24OR2gJlNBEIz8VlWUH
	8fYeBX8x493asVDZeMAdVDSN88IufkB5U2F7FfkJRlL399+SmMp49h1sCeI6IDSPf+J/kF
X-Received: by 2002:a17:902:c405:b0:2b0:c060:aab8 with SMTP id d9443c01a7336-2b2c727c147mr120611965ad.9.1776007440415;
        Sun, 12 Apr 2026 08:24:00 -0700 (PDT)
Received: from [192.168.1.45] ([101.0.62.225])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f099d6sm107845985ad.50.2026.04.12.08.23.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Apr 2026 08:23:59 -0700 (PDT)
Message-ID: <d47f93f4-e536-4fd4-a7c0-74d69f50fe55@gmail.com>
Date: Sun, 12 Apr 2026 20:53:58 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] iio: dac: mcp4821: add configurable gain support
To: David Lechner <dlechner@baylibre.com>, jic23@kernel.org
Cc: anshulusr@gmail.com, linux-iio@vger.kernel.org
References: <acYb1XOmw1yoyu_4@nik>
 <20260327061802.13043-1-nikhilgtr@gmail.com>
 <45f6a6dc-e027-4616-8cea-9be8d006521a@baylibre.com>
Content-Language: en-US
From: Nikhil Gautam <nikhilgtr@gmail.com>
In-Reply-To: <45f6a6dc-e027-4616-8cea-9be8d006521a@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi David,

Thanks a lot for the detailed review and suggestions.

I understand the issues you pointed out. I will resend the next revision
as a new thread instead of replying, to avoid breaking tooling.

I will also split the unrelated changes into separate patches, starting
with moving the state initialization, and handle spelling fixes
independently.

Regarding the gain handling, your suggestion to use an integer value
instead of a boolean makes sense. I will update the implementation to
store the gain directly and simplify the logic accordingly.

For the scale handling, I see that the attribute should reflect the
actual output scale rather than the internal gain. I will update
scale_available to return the correct values based on Vref and use
IIO_VAL_FRACTIONAL_LOG2 as suggested, ensuring consistency between
scale and scale_available. I am thinking to return (2048/4096) Values 
based on gain selected
instead (1/2) Values in scale_available, so that user will have clear 
picture which gain
to be selected, else for (1/2) Values he always has to refer the driver.

Let me know you inputs.

I will incorporate all of these changes and send a revised version shortly.

Thanks again for your guidance.

Best regards,

Nikhil


On 12-04-2026 01:18 am, David Lechner wrote:
> Please don't send new revisions in reply to previous revisions. It breaks
> some tools. Always start a new thread for a new revision.
>
> On 3/27/26 1:18 AM, Nikhil Gautam wrote:
>> Add support for configuring the DAC gain using the GA bit.
>> Expose gain control via IIO_CHAN_INFO_CALIBSCALE.
>>
>> Scale is updated dynamically based on selected gain:
>> - 1x gain → 2.048V full-scale
>> - 2x gain → 4.096V full-scale
>>
>> Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
>> ---
>> Changes in v2:
>> - Drop header reordering
>> - Move MCP4821_GAIN_ENABLE define before MCP4802_SECOND_CHAN
>> - Use IIO_CHAN_INFO_SCALE instead of CALIBSCALE since full scale changes
>> - Restore original -EINVAL handling in default cases
>>
>> Changes in v3:
>> - Restored NULL check in indio_dev alloc
>> ---
>>   drivers/iio/dac/mcp4821.c | 103 ++++++++++++++++++++++++++++++--------
>>   1 file changed, 82 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/iio/dac/mcp4821.c b/drivers/iio/dac/mcp4821.c
>> index 748bdca9a964..9160812219f9 100644
>> --- a/drivers/iio/dac/mcp4821.c
>> +++ b/drivers/iio/dac/mcp4821.c
>> @@ -12,7 +12,6 @@
>>    *	MCP48x2: https://ww1.microchip.com/downloads/en/DeviceDoc/20002249B.pdf
>>    *
>>    * TODO:
>> - *	- Configurable gain
>>    *	- Regulator control
>>    */
>>   
>> @@ -26,12 +25,32 @@
>>   #include <linux/unaligned.h>
>>   
>>   #define MCP4821_ACTIVE_MODE BIT(12)
>> +#define MCP4821_GAIN_ENABLE BIT(13)
>>   #define MCP4802_SECOND_CHAN BIT(15)
>>   
>> -/* DAC uses an internal Voltage reference of 4.096V at a gain of 2x */
>> -#define MCP4821_2X_GAIN_VREF_MV 4096
>> +/* DAC uses an internal Voltage reference of 2.048V */
>> +#define MCP4821_VREF_MV 2048
>>   
>> -enum mcp4821_supported_drvice_ids {
>> +/*
>> + * MCP48xx DAC output:
>> + *
>> + * Vout = (Vref * D / 2^N) * G
>> + *
>> + * where:
>> + *  - Vref = 2.048V (internal reference)
>> + *  - N = DAC resolution (12 bits for MCP4821)
>> + *  - G = gain selection:
>> + *        1x when GA bit = 1
>> + *        2x when GA bit = 0 (default)
>> + *
>> + * Therefore full-scale voltage is:
>> + *  - 1x gain: 2.048V
>> + *  - 2x gain: 4.096V
>> + *
>> + * Scale = Vfull-scale / 2^N
>> + */
>> +
>> +enum mcp4821_supported_device_ids {
> Unrelated change. Spelling error should be fixed in a separate patch.
>
>>   	ID_MCP4801,
>>   	ID_MCP4802,
>>   	ID_MCP4811,
>> @@ -43,6 +62,7 @@ enum mcp4821_supported_drvice_ids {
>>   struct mcp4821_state {
>>   	struct spi_device *spi;
>>   	u16 dac_value[2];
>> +	bool gain_1x;
>>   };
>>   
>>   struct mcp4821_chip_info {
>> @@ -57,6 +77,7 @@ struct mcp4821_chip_info {
>>   		.channel = (channel_id),                              \
>>   		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),         \
>>   		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
>> +		.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE), \
>>   		.scan_type = {                                        \
>>   			.realbits = (resolution),                     \
>>   			.shift = 12 - (resolution),                   \
>> @@ -122,8 +143,13 @@ static int mcp4821_read_raw(struct iio_dev *indio_dev,
>>   		state = iio_priv(indio_dev);
>>   		*val = state->dac_value[chan->channel];
>>   		return IIO_VAL_INT;
>> +
>>   	case IIO_CHAN_INFO_SCALE:
>> -		*val = MCP4821_2X_GAIN_VREF_MV;
>
>> +		state = iio_priv(indio_dev);
> I would start with a separate patch to move setting state to where it
> is declared so that we don't have to duplicate this line in each case.
>
>
>> +		if (state->gain_1x)
>> +			*val = MCP4821_VREF_MV;
>> +		else
>> +			*val = MCP4821_VREF_MV * 2;
> Why not make the variable store the gain value instead of being bool?
>
> Then this can just be:
>
> 		*val = MCP4821_VREF_MV * state->gain;
>
>>   		*val2 = chan->scan_type.realbits;
>>   		return IIO_VAL_FRACTIONAL_LOG2;
>>   	default:
>> @@ -140,34 +166,66 @@ static int mcp4821_write_raw(struct iio_dev *indio_dev,
>>   	__be16 write_buffer;
>>   	int ret;
>>   
>> -	if (val2 != 0)
>> -		return -EINVAL;
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_RAW:
>>   
>> -	if (val < 0 || val >= BIT(chan->scan_type.realbits))
>> -		return -EINVAL;
>> +		if (val2 != 0)
>> +			return -EINVAL;
>>   
>> -	if (mask != IIO_CHAN_INFO_RAW)
>> -		return -EINVAL;
>> +		if (val < 0 || val >= BIT(chan->scan_type.realbits))
>> +			return -EINVAL;
>> +
>> +		write_val = MCP4821_ACTIVE_MODE | val << chan->scan_type.shift;
>> +		if (chan->channel)
>> +			write_val |= MCP4802_SECOND_CHAN;
>> +		if (state->gain_1x)
>> +			write_val |= MCP4821_GAIN_ENABLE;
>>   
>> -	write_val = MCP4821_ACTIVE_MODE | val << chan->scan_type.shift;
>> -	if (chan->channel)
>> -		write_val |= MCP4802_SECOND_CHAN;
>> +		write_buffer = cpu_to_be16(write_val);
>> +		ret = spi_write(state->spi, &write_buffer, sizeof(write_buffer));
>> +		if (ret) {
>> +			dev_err(&state->spi->dev, "Failed to write to device: %d", ret);
>> +			return ret;
>> +		}
>>   
>> -	write_buffer = cpu_to_be16(write_val);
>> -	ret = spi_write(state->spi, &write_buffer, sizeof(write_buffer));
>> -	if (ret) {
>> -		dev_err(&state->spi->dev, "Failed to write to device: %d", ret);
>> -		return ret;
>> +		state->dac_value[chan->channel] = val;
>> +		return 0;
>> +
>> +	case IIO_CHAN_INFO_SCALE:
>
>> +		if (val == 1)
>> +			state->gain_1x = true;
>> +		else if (val == 2)
>> +			state->gain_1x = false;
>> +		else
>> +			return -EINVAL;
> And this can be:
>
> 		if (!in_range(val, 1, 2))
> 			return -EINVAL;
>
> 		state->gain = val;
>
>> +		return 0;
>> +	default:
>> +		return -EINVAL;
>>   	}
>> +}
>>   
>> -	state->dac_value[chan->channel] = val;
>> +static const int mcp4821_gain_avail[] = {1, 2};
> The attribute is the scale attribute, not gain, so these need to
> be: { MCP4821_VREF_MV, 2 * MCP4821_VREF_MV } combined with...
>
>>   
>> -	return 0;
>> +static int mcp4821_read_avail(struct iio_dev *indio_dev,
>> +			      struct iio_chan_spec const *chan,
>> +			      const int **vals, int *type, int *length,
>> +			      long info)
>> +{
>> +	switch (info) {
>> +	case IIO_CHAN_INFO_SCALE:
>> +		*vals = mcp4821_gain_avail;
>> +		*type = IIO_VAL_INT;
> ... IIO_VAL_FRACTIONAL_LOG2.
>
> The idea is that the scale_available attribute should return the same
> values as the scale attribute.
>
>> +		*length = 2;
>> +		return IIO_AVAIL_LIST;
>> +	default:
>> +		return -EINVAL;
>> +	}
>>   }
>>   
>>   static const struct iio_info mcp4821_info = {
>>   	.read_raw = &mcp4821_read_raw,
>>   	.write_raw = &mcp4821_write_raw,
>> +	.read_avail = &mcp4821_read_avail,
>>   };
>>   
>>   static int mcp4821_probe(struct spi_device *spi)
>> @@ -183,6 +241,9 @@ static int mcp4821_probe(struct spi_device *spi)
>>   	state = iio_priv(indio_dev);
>>   	state->spi = spi;
>>   
>> +	/* default gain is 2x as GA bit is active low*/
>> +	state->gain_1x = false;
>> +
>>   	info = spi_get_device_match_data(spi);
>>   	indio_dev->name = info->name;
>>   	indio_dev->info = &mcp4821_info;
