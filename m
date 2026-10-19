Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8062258278F
	for <linux-iio@vger.kernel.org>; Mon, 19 Oct 2026 14:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792420443; cv=none; b=rLW1aGeCqEj1sOyW2TjDKRzQ2pPKo1f9YBE0hmY8jL3jBJoofoevgyrgkT0/mZMATxKxsRT41t/DDmhHZw7tJX7tpqupbbJHOeg+YyhE2YS8mQzaNE6vsSARelHrQ3mTodRc1sWZpuojT12eVYMpNf7/7nflfmQqP6r5OI4swPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792420443; c=relaxed/simple;
	bh=WMSkP6NaFBqM3UEQAOodzeKmxxYYIbT2hmlz+EQiRWQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Rema3mbYhwdL1yYpY+bWdfznSv3/z7UBlxaL+AIogKkVHICuzzSZem5xjNklOv09TL5XiLnr4v2vvw6o7KDO1QiC9wrjUbPfQy3TJJSc2xOUK1FQyfFrGoqUO5h4Pg6DRnOjK6pOAXl5fEFA3XoeEWwMpGPA123hYLg53IytCUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cJkPGW7Y; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cJkPGW7Y"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48e0d1c095dso1162187f8f.1
        for <linux-iio@vger.kernel.org>; Mon, 19 Oct 2026 07:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792420440; x=1793025240; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vi+C8vmeCIBFWfg066o+hCBfKjs/sEi6qTNyg3C8MLE=;
        b=cJkPGW7Yg4+EQ2awTMxWA3DI09cQNt9ChAB2v2JRaPikXJcafqR1aavyMM6p1rfps9
         iyBAX7q1TgfJ6s4OXj12+kMtbK5gj+02aGRIuLDylWYb2dnJuGdLQ6hzPkEprlFFUFxD
         YnpTsjqroL08JtxZgd4LZiYWeHOFD4SAMLFwiFihnbEKf9K6IoMMTbLg/XGqZ10FJ/cu
         zhLTtXOjU+6Ebg3CpnA80Xg+3bggu8Y9dyStpIVjtXXZv8NqdCKXA0R2NYoe16HxDM0q
         jH+lOF4lqYkCNH2sP4yZ8ySeZQuAMl+8b4UkE7yg1+0jvTX8JZYZfdXt7JEOQu5BkoUz
         HeYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792420440; x=1793025240;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vi+C8vmeCIBFWfg066o+hCBfKjs/sEi6qTNyg3C8MLE=;
        b=jxw2PGc7uH77euH5tHc58xIF3OaAFt00NOe+DHjAnbWJw9l7vND2op9sHtzsES0TSs
         3UiTM5pEhZjLTbaut1vgfIbCPm9A7rpUaFoACCBmZA+2epIGfY3A8uMSDvd905aU/R5v
         NH2Xa21VST6KwdwV5ZWE+tLBizFUjvlpgSloR9W4rOxaW+VUpPOVT493HNwvofw1trE8
         B7eHAONFe2PDAc0oTBlP9l1zN8olJDjYMRWBUuEBRnWqyIKl6yk7F/FjdceVbukjn2gQ
         78n4PULNkbiCv2kqSTV11ZimvrJ0bXtZ/n+NOGbX8K0rbBGB9Zz9AJTZSRI4YgKBfKnW
         JkTg==
X-Forwarded-Encrypted: i=1; AKwUvByZJYt4HDhAQE2iJ0gI3k87ftgRPpqFet2YPoJd9DhG14nORERFzFNI6M86vmSJrNwyqjzM3WAf9IU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJHOmQUW3WprWF7O5daWl7s62nU18+cxYsocrU/GYwngyzYSyEh
	t21lYYt5uZhe5Eh/fsvyNUOXPXeEVnys0Kwcwk9KFuQwGlylXHpD40LooBQ9miI4Xwc=
X-Gm-Gg: AYBFou3s5dSZ3RYQE8eEbKgMGgCX9X20JDxUkSyeoxID8zf8tKXMc86Oz/jAT6u0FYz
	QZW1zmBlKgK2EEjalbq3xJG6pA/b507tIgW1e+EHagFaYkcFkUAJaNG81dhI/S4By8xIJAe5DlV
	1SsaIc6iZF0jbg730iyY87pVXpufzsjHeX715+F8IRTfRRPR7l4+ZZCJYcAcWGj5dzxSNxe+OUn
	5GHUQr122zAP7ENmaA5dNiRRtg4viJXARXPTDnpBVlEBBNB5zgbE4SfX1kQe8qOCi+0fwB2CaeX
	Fm36CvFpAdbblQAmx3gxHMXK+5VAvWDEZ3qjB/G/qwajGuUgdJn9vRBFRYdKtE8iVjg1CpipaGg
	JGGau8LXa+qwCT3hkq2jbLhQBQluXKPi+jKH565s84sj00OaGbEnjcgUiwEoDCFL5dJIrbNPf6M
	rtwTNs4ye6NfoF9X67eGLZ0vWjQLnwle3ATBFk0IiGnE5P2QtMrk+iVaAfN7c0dhDQUxvDUmWVk
	lsq/wYXFZUC7VEyorqDEM9L8TcdTYms6TQNK8tInnfLDKl63phwvQ==
X-Received: by 2002:a05:6000:1003:b0:487:15a3:1cab with SMTP id ffacd0b85a97d-48e07fb2b28mr13519211f8f.18.1792420439452;
        Mon, 19 Oct 2026 07:33:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:3da2:14af:c1c3:cef8? ([2a01:e0a:106d:1080:3da2:14af:c1c3:cef8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd47104csm26302444f8f.8.2026.10.19.07.33.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 07:33:59 -0700 (PDT)
Message-ID: <4ea0f567-b090-46f5-a3ea-e5c3ac4f3d1f@linaro.org>
Date: Mon, 19 Oct 2026 16:33:55 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v3 3/3] iio: adc: add driver for the MAX34417 Four-Channel
 High Dynamic Range Power Accumulator
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org
References: <20261013-topic-sm8x50-iio-max34417-adc-v3-0-d3604ae4a229@linaro.org>
 <20261013-topic-sm8x50-iio-max34417-adc-v3-3-d3604ae4a229@linaro.org>
 <20261017234746.4af7b7f6@jic23-hlaptop>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20261017234746.4af7b7f6@jic23-hlaptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 10/18/26 00:47, Jonathan Cameron wrote:
> On Tue, 13 Oct 2026 16:07:13 +0200
> Neil Armstrong <neil.armstrong@linaro.org> wrote:
> 
>> The MAX34417 is a specialized current and voltage monitor used to
>> determine power consumption of portable systems. The driver support
>> getting the channels voltage, average power and accumulated average
>> power and energy over an I2C/SMBUS serial interface.
>>
>> The MAX34417 datasheet only specified on how to calculate the
>> accumulated average power, but with the Sample Per Second rate
>> we can easily get accumulated Energy in mJ.
>>
>> By default the IIO driver only supports single-shot Voltage
>> and Power sensing, but the accumulation can be enabled by
>> enabling the Energy IIO channel which then enables the
>> Continuous Accumulation Mode.
>>
>> The counter is common to all channels, so when reading a single
>> channel we will copy all accumulators to registers, so in order
>> to permit reading individual channels we must accumulate the
>> other channels in the driver when Continuous Accumulation Mode
>> is enabled.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> 
> Reminder to check sashiko.  I haven't looked at whether they
> are right this time.
> https://sashiko.dev/#/patchset/20261013-topic-sm8x50-iio-max34417-adc-v3-0-d3604ae4a229%40linaro.org
> 

I did and there's some good catches

>> diff --git a/drivers/iio/adc/max34417.c b/drivers/iio/adc/max34417.c
>> new file mode 100644
>> index 000000000000..00d7f20cd953
>> --- /dev/null
>> +++ b/drivers/iio/adc/max34417.c
> 
>> +/* TODO Implement trigger to update accumulator once and get all channels at once */
>> +
>> +static int max34417_reset_smm(struct max34417_data *max34417)
>> +{
>> +	u32 control;
>> +	int rc;
>> +
>> +	rc = regmap_read(max34417->regmap, MAX34417_CONTROL_REG, &control);
>> +	if (rc)
>> +		return rc;
>> +
>> +	/* Set SMM=0 to re-init the SMM mode */
>> +	control &= ~(MAX34417_CONTROL_SMM);
>> +	rc = regmap_write(max34417->regmap, MAX34417_CONTROL_REG, control);
>> +	if (rc)
>> +		return rc;
>> +
>> +	/* Reset accumulators after setting SMM=0 */
>> +	rc = regmap_write(max34417->regmap, MAX34417_UPDATE_REG, 1);
> return regmap_write()
> 
> Might as well save a few lines.
> 
>> +	if (rc)
>> +		return rc;
>> +
>> +	return 0;
>> +}
> 
> 
>> +
>> +static int max34417_check_ovf(struct max34417_data *max34417)
>> +{
>> +	u32 control;
>> +	int rc;
>> +
>> +	/* Check for overflow */
> 
> Given function name and the check below, not seeing value in this comment.
> 
>> +	rc = regmap_read(max34417->regmap, MAX34417_CONTROL_REG, &control);
>> +	if (rc)
>> +		return rc;
>> +
>> +	if (control & MAX34417_CONTROL_OVF) {
>> +		rc = regmap_write(max34417->regmap, MAX34417_CONTROL_REG,
>> +				  control & ~MAX34417_CONTROL_OVF);
>> +		if (rc)
>> +			return rc;
>> +
>> +		rc = regmap_write(max34417->regmap, MAX34417_UPDATE_REG, 1);
>> +		if (rc)
>> +			return rc;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +/*
>> + * Save all power accumulators and counter after each UPDATE command
>> + * since it will reset the internal registers for ALL channels,
>> + * so in order to not loose any captured data we retrieve all registers
>> + * and accumulate them in the context variables.
>> + * When user gets either power or energy, those variables content
>> + * will be returned and zero-ed to return the power accumulated
>> + * since last read for each separate channel.
>> + */
>> +static int max34417_save_accumulators(struct max34417_data *max34417)
>> +{
>> +	unsigned int i;
>> +	u64 acc_power;
>> +	u32 acc_count;
>> +	int rc;
>> +
>> +	rc = max34417_read_acc_count(max34417, &acc_count);
>> +	if (rc)
>> +		return rc;
>> +
>> +	for (i = 0; i < MAX34417_CHANNEL_COUNT; ++i) {
>> +		rc = max34417_read_acc_power(max34417, MAX34417_PWR_ACC_1_REG + i,
>> +					     &acc_power);
>> +		if (rc)
>> +			return rc;
>> +
>> +		max34417->acc_power[i] += acc_power;
>> +		max34417->acc_count[i] += acc_count;
>> +	}
>> +
>> +	/* Check for overflow */
>> +	rc = max34417_check_ovf(max34417);
> 
> return max34417_..
> 
>> +	if (rc)
>> +		return rc;
>> +
>> +	return 0;
>> +}
> 
> 
>> +
>> +static int max34417_setup_cam_mode(struct max34417_data *max34417, int val)
>> +{
>> +	u32 control;
>> +	int rc, i;
>> +
>> +	guard(mutex)(&max34417->lock);
>> +
>> +	rc = regmap_read(max34417->regmap, MAX34417_CONTROL_REG, &control);
>> +	if (rc)
>> +		return rc;
>> +
>> +	if (max34417->cam_mode && !val) {
>> +		/* SMM and CAM modes should not be enabled at the same time */
>> +		control &= ~(MAX34417_CONTROL_CAM | MAX34417_CONTROL_SMM);
> 
> The comment doesn't makes sense given neither are enabled.

It's just some phrases from the Datasheet to pin point the process, will drop

> 
>> +		rc = regmap_write(max34417->regmap, MAX34417_CONTROL_REG, control);
> 
> Feels like it would be cleaner as an update_bits() here and below rather than
> sharing that read above.

Yep will switch to _bits regmap ops

> 
>> +		if (rc)
>> +			return rc;
>> +
>> +		/*
>> +		 * If CAM mode must be set, the Control byte must be set to
>> +		 * desired values with CAM = 0, then followed by an UPDATE
>> +		 */
>> +		rc = regmap_write(max34417->regmap, MAX34417_UPDATE_REG, 1);
>> +		if (rc)
>> +			return rc;
>> +	} else if (!max34417->cam_mode && val) {
>> +		/*
>> +		 * After this, the CAM mode bit can be set and another
>> +		 * UPDATE must be sent.
>> +		 */
>> +		control |= MAX34417_CONTROL_CAM;
>> +		/* SMM and CAM modes should not be enabled at the same time */
>> +		control &= ~(MAX34417_CONTROL_SMM);
> 
> As above, perhaps an update_bits is simpler?
> 
>> +		rc = regmap_write(max34417->regmap, MAX34417_CONTROL_REG, control);
>> +		if (rc)
>> +			return rc;
>> +
>> +		rc = regmap_write(max34417->regmap, MAX34417_UPDATE_REG, 1);
>> +		if (rc)
>> +			return rc;
>> +
>> +		/* Reset counters and accumulators */
>> +		for (i = 0; i < MAX34417_CHANNEL_COUNT; ++i) {
>> +			max34417->acc_power[i] = 0;
>> +			max34417->acc_count[i] = 0;
>> +		}
>> +	}
>> +
>> +	max34417->cam_mode = val;
>> +
>> +	return 0;
>> +}
> 
> 
> 
>> +static int max34417_probe(struct i2c_client *client)
>> +{
>> +	struct device *dev = &client->dev;
>> +	struct max34417_data *max34417;
>> +	struct iio_dev *indio_dev;
>> +	struct regmap *regmap;
>> +	int rc, i;
>> +
>> +	regmap = devm_regmap_init_i2c(client, &max34417_regmap_config);
>> +	if (IS_ERR(regmap))
>> +		return dev_err_probe(dev, PTR_ERR(regmap), "regmap_init failed\n");
>> +
>> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*max34417));
>> +	if (!indio_dev)
>> +		return -ENOMEM;
>> +
>> +	rc = devm_regulator_get_enable(dev, "vdd");
>> +	if (rc)
>> +		return dev_err_probe(dev, rc, "failed to get vdd regulator\n");
>> +
>> +	rc = devm_regulator_get_enable(dev, "vio");
>> +	if (rc)
>> +		return dev_err_probe(dev, rc, "failed to get vio regulator\n");
>> +
>> +	max34417 = iio_priv(indio_dev);
>> +	max34417->regmap = regmap;
>> +	max34417->dev = dev;
>> +	max34417->indio_dev = indio_dev;
>> +	mutex_init(&max34417->lock);
>> +
>> +	/* Set default input correction for all channels */
>> +	for (i = 0; i < MAX34417_CHANNEL_COUNT; ++i)
>> +		max34417->input_correction[i] =
>> +			max34417_calc_input_correction(MAX34417_DEFAULT_RSENSE);
>> +
>> +	device_for_each_child_node_scoped(dev, node) {
>> +		u32 rsense, index;
>> +
>> +		if (!fwnode_property_present(node, "reg"))
>> +			return dev_err_probe(dev, -EINVAL, "missing reg property of %pfwP\n",
>> +					     node);
> 
> Bit unusual to check for a property that must be there.
> We tend to use present checks for optional properties. Is the
> following failure path not enough?

It should, I maybe added too much checks, will drop.

> 
>> +
>> +		rc = fwnode_property_read_u32(node, "reg", &index);
>> +		if (rc)
>> +			return dev_err_probe(dev, rc, "failure reading reg property of %pfwP\n",
>> +					     node);
>> +
>> +		if (index >= MAX34417_CHANNEL_COUNT)
>> +			return dev_err_probe(dev, -EINVAL, "invalid reg %d of %pfwP\n",
>> +					     index, node);
>> +
>> +		if (fwnode_property_present(node, "label")) {
>> +			rc = fwnode_property_read_string(node, "label",
>> +							 &max34417->input_label[index]);
>> +			if (rc)
>> +				return dev_err_probe(dev, rc,
>> +						"failure reading label property of %pfwP\n",
>> +						node);
>> +		}
>> +
>> +		if (fwnode_property_present(node, "shunt-resistor-micro-ohms")) {
>> +			rc = fwnode_property_read_u32(node, "shunt-resistor-micro-ohms",
>> +						      &rsense);
>> +			if (rc)
>> +				return dev_err_probe(dev, rc,
>> +						"failure reading shunt property of %pfwP\n",
>> +						node);
>> +
>> +			if (!rsense || rsense < MAX34417_MIN_RSENSE ||
> 
> Is !rsense useful given that is less than min?

Indeed. leftover from previous version

> 
>> +			    rsense > MAX34417_MAX_RSENSE)
>> +				return dev_err_probe(dev, -EINVAL,
>> +						     "invalid shunt value %d of %pfwP\n",
>> +						     rsense, node);
>> +
>> +			max34417->input_correction[index] =
>> +				max34417_calc_input_correction(rsense);
>> +		}
>> +	}
>> +
>> +	indio_dev->channels = max34417_channels;
>> +	indio_dev->num_channels = ARRAY_SIZE(max34417_channels);
>> +	indio_dev->name = "max34417";
>> +	indio_dev->info = &max34417_info;
>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>> +
>> +	rc = devm_iio_device_register(dev, indio_dev);
>> +	if (rc)
>> +		return rc;
>> +
>> +	/* Reset mode and set accumulator width to Wide */
> 
> The docs refer to this as choosing between the max34417 and the max34407.
> Any idea what that is going on about?  Is it that the setting this to 0 would
> make the device look just like the part with small accumulator?
> Seems like an easy win if you fancy adding support for that part as well as
> this would be the main difference I think (it's reserved on that part to 0)
> 
> Anyhow, just made me curious rather than a request to change anything!

Indeed, I don't feel confident enough to add max34407 support, but I can definitely
add a comment pointing this is the main difference between max34417 & max34407.

> 
>> +	rc = regmap_write(max34417->regmap, MAX34417_CONTROL_REG, MAX34417_CONTROL_MODE);
>> +	if (rc)
>> +		return dev_err_probe(max34417->dev, rc, "Error writing control register\n");
>> +
>> +	/* Reset the accumulators */
>> +	rc = regmap_write(max34417->regmap, MAX34417_UPDATE_REG, 1);
> 
> return regmap_write();
> 
> Though I'm not sure why you'd do these two after setting up the userspace
> interface (iio_device_register). Is there no potential race where something
> related to the accumulators gets read before they are reset?  Seems that would look
> a little more odd than the other way around where they aren't quite
> zero when they first become readable.

Yep, will move before,

Thanks,
Neil

> 
>> +	if (rc)
>> +		return rc;
>> +
>> +	return 0;
>> +}
> 

