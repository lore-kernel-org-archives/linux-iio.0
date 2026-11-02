Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793593357;
	b=1Q5G9mXWQxPOL31MmYyElJFlxgJH7T8aDPjt7cf0L+GglaHFtjUJC+7jh1ELSQYEEtzc
	 ZNV2VbYzAxbq3D4ptfNYAZR4l/WsDROUuZN+1elp6j6WuPWvoCaKgihPfUSF5yP91BLLk
	 u1COL0Xiah1uFXm7oksYLO/q3by5OnLOh7cmtnrAVTi9Wf2k0qI5UFUBUw5LwCt7SLPdD
	 OWOys+wHYBXOBZvozI6QjIWeJRD8ZvAn+1+0Fn3/Svk+Sh7RaorTeiCELyQ0KMDS0f/Q3
	 Azw9hSYS8iRo8uNR7dqUIFY9XMd7M0kGVxHi60zOZkHzDKKrD7JAerQYkoVBmP7bcUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793593357;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=7fBV2sDWDd42yKkGMbmzSDyqUamFmlIf4ePGPhr2gNU=;
	b=NrzaYnhKY/+Ov6CE2TIkwY2Lg66rU5mdtqiqm2MkSEeiCeDtD6xeavjlRUMScUW6AgxN
	 F6D6OYR6O3On/q/rVhaNdq9ZELR2AtQONbQbVMmV2W5obq/b5bX1bqDmzVVkfiRkxUnRK
	 0UQquDU5yAS+N4bVgRSaFudBL18QHyKyDsU7yHGm+zJ2bfriwTbF6d2odES62AfyoERFp
	 NF4oBNLZfsO0TRxPacQ8G1l/5u3lBc1oCMAAeGqYCPTIa7K6tCu5IxLd4N0y/tF25KMI+
	 im40YS9uomalq4odZMH4oZlUApZWddEofbrv8h6L/2LhoKwHoDYG01Y3f7NJYIf9fSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qr72RAfl;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD4F606A329
	for <linux-iio@vger.kernel.org>; Mon,  2 Nov 2026 04:22:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FD4F606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qr72RAfl
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ad2b3b1c02so1326297a91.1
        for <linux-iio@vger.kernel.org>; Sun, 01 Nov 2026 20:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793593355; x=1794198155; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7fBV2sDWDd42yKkGMbmzSDyqUamFmlIf4ePGPhr2gNU=;
        b=qr72RAflN43iE2wCnD/SiaTuIYzM69wPZkhuE9LWLrvpY+7knB4fhdnYOw2YJAVKpc
         oOS1DCm4FamsaD4o8yStvCt0DUEHMPUc9ABWNpWwjHDWUSmDDydOVJGFO5hSGt6Gtui7
         RCJb4PK6zuGTQ1PqazSqF1qEpWAqgKkfePsgR5Rgf/Gr+srjazc9tzOY6VxqhiOZDQkc
         R06CC8790DJAbB0WXayZALn27bVUjwvvMEfU1KmSWX4U0H7Ml/UcIhgXLQryf8WV08tj
         7i3NSHtJIwBAhT/+gcqPeIRBkNjpMiYw3UfHp6p0W28mxIfPGK80/xcpFaGQjInAL2/O
         biLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793593355; x=1794198155;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7fBV2sDWDd42yKkGMbmzSDyqUamFmlIf4ePGPhr2gNU=;
        b=BBEeyKKelCFl7B9TyBZyKreXSdQUkLtdQ8koyKqapoFoGInxwYukSE1FGOAIUawdhA
         m46Pwrx37yMoLxTKPQL62QxYFZqrxklFGHI6lZtU6AIc1vJrXpj7G8eRWu7mhLtaOvpq
         IG/Czb9xrHTcuAB1a7UlwmRLK4atdFprSA0B8fMcMiziL26bZqEy4wsCnI1SaM/lEbm2
         wwR4GD0TRsjx0fhcNkSPBFrV+tV7yXV79SeUHoXqx2j7N2OckpsqwNwW2mJwVWOUVN5R
         nXEe56QLEC0NHqpDxpdAV8c0TGh8shpeISH4kZsaQvHYY/Lo6zXfYgyCdbPArh3Dr4V3
         89vQ==
X-Forwarded-Encrypted: i=1; AKwUvBxNgbKPGnHvCA1N6E6QqCoDHYtEs8waPTnKwUIdW1UiFa631bWmEP+iPdBPbbnXIstCQH0VMG+4tMA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9dYWbJL82wFD9sGDr9g0s3NJG1A0iUuSUem8dKgKB38M+ZJ+S2
	VSbeqovycFvhqwfLfscu6rDJtktP9wDCrJJcdTCvgBJWLamCH/DaTIVe
X-Gm-Gg: AYBFou3TNwr5IrLmxu973Lg6fVGXsR+hoyivYb2lP/fQj3A7i/71YmmHnSk+/3/vv5O
	8Tm6/+Dae2fCZc1W7d0VDfXtMhxiwXbnpJWWTgDipKlsJ+tK0wxEDTZTj0+9dMF78KDcXrIHa1s
	u990Gd4ewwbqneQu9CemMYwPHN3bYX2nSWbT/IYKN1lAEdunrZzRR1Ikbhm/SuqiHDHBwi4w8N9
	NAdw0C14qyTnXzQNvXcN2mryMmUpeTqU2zqwAFEbHk5QKjFJ1mgSjLprcltwA6MrbqHACUlx3yQ
	73rDON+xtIpwgdci7i+FrmuxZquTbMRKoaTeQt+2Ob4bdCdm/XtMAhTeOu3EUkCluDHVEfQTipW
	j18pe5/ah/Qa4SKVyozX9Y97gyej8o5hYqhI3VtBqdKpafH5KO+tbPPYDWzequk48rfPWKgBJSL
	bz3jScaBNUt0f3W3x0UbKComAolEUcTG3E27P5SOI4DA2kQIYyI0QDvOZ9Jf9grwt2cJurGciTx
	fc7Ymln5n3CVLVLQydi1n2EjYQjCpXlwuKPLgrJh1gjA9Zslc4fiwMnVRq/poK/BrXrtur2wta9
	2aqrYBsA+PDI4si/sHt/Gek84b71lCeJU50fKuZQKJA85rDJ8+DUoKmGLuCyv6InT7lduvqVO7R
	7b0c=
X-Received: by 2002:a17:90b:3b51:b0:39e:6795:f7da with SMTP id 98e67ed59e1d1-3ae897c7d22mr7606558a91.19.1793593354591;
        Sun, 01 Nov 2026 20:22:34 -0800 (PST)
Received: from [172.19.1.42] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb096b4bcdsm2533701a12.5.2026.11.01.20.22.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Nov 2026 20:22:34 -0800 (PST)
Message-ID: <81173139-a43c-48a4-97c7-0a82de158b3e@gmail.com>
Date: Mon, 2 Nov 2026 12:22:28 +0800
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] iio: adc: Add Nuvoton MA35D1 EADC driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, cwweng@nuvoton.com
References: <20261030031501.130290-1-cwweng.linux@gmail.com>
 <20261030031501.130290-3-cwweng.linux@gmail.com>
 <20261101005312.1ec5e393@jic23-hlaptop>
Content-Language: en-US
From: Chi-Wen Weng <cwweng.linux@gmail.com>
In-Reply-To: <20261101005312.1ec5e393@jic23-hlaptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Jonathan Cameron 於 2026/11/1 上午 08:53 寫道:
> On Fri, 30 Oct 2026 11:15:01 +0800
> Chi-Wen Weng <cwweng.linux@gmail.com> wrote:
> 
>> From: Chi-Wen Weng <cwweng@nuvoton.com>
>>
>> Add an IIO driver for the Enhanced Analog-to-Digital Converter (EADC)
>> found on Nuvoton MA35D1 SoCs.
>>
>> The driver supports direct conversion and externally triggered buffered
>> capture using sample module 0. Both single-ended inputs and the four
>> fixed differential input pairs are supported.
>>
>> Use the internal 1.6 V reference when no external reference supply is
>> provided, and report the reference voltage through the IIO scale
>> interface.
>>
>> Use ADINT0 for conversion completion. Configure the interrupt source
>> and end-of-conversion position explicitly, and recover from conversion
>> timeouts by resetting the EADC control circuits, synchronizing the IRQ
>> and clearing stale conversion state before another conversion is
>> started.
>>
>> Reset the EADC control circuits during hardware initialization and
>> sanitize interrupt, compare and sample-module trigger configuration so
>> the driver does not depend on state left by firmware when the external
>> reset control is unavailable.
>>
>> Provide firmware-node channel translation so DT IIO consumers select
>> channels by the logical channel index described by the channel node's
>> reg property rather than by the position of the channel in the driver's
>> channel array.
>>
>> Add clock, optional reset and system sleep handling, and restore the
>> controller configuration after resume.
>>
>> Signed-off-by: Chi-Wen Weng <cwweng@nuvoton.com>
> Hi Chi-Wen
> 
> Various comments inline.
> 
> Thanks,
> 
> Jonathan
> 
>> diff --git a/drivers/iio/adc/ma35d1_eadc.c b/drivers/iio/adc/ma35d1_eadc.c
>> new file mode 100644
>> index 000000000000..9b6c38a66a66
>> --- /dev/null
>> +++ b/drivers/iio/adc/ma35d1_eadc.c
> 
> 
>> +
>> +static int ma35d1_adc_disable_irq(struct ma35d1_adc *adc)
>> +{
>> +	return regmap_clear_bits(adc->regmap, MA35D1_EADC_CTL, MA35D1_EADC_CTL_ADCIEN0);
>> +}
>> +
>> +static int ma35d1_adc_setup_reference(struct ma35d1_adc *adc)
>> +{
>> +	struct regmap *map = adc->regmap;
>> +	int ret;
>> +
>> +	/*
>> +	 * MA35D1 TRM EADC reference control: PDREF selects the external VREF
>> +	 * pin. With the internal reference selected, VREFSEL = 0 selects 1.6 V.
>> +	 */
>> +	if (adc->vref) {
> 
> With change below to use the read_voltage function this would then be
> using a flag set there.
> 
>> +		ret = regmap_set_bits(map, MA35D1_EADC_REFADJCTL,
>> +				      MA35D1_EADC_REFADJCTL_PDREF);
>> +		if (ret)
>> +			return ret;
>> +	} else {
>> +		ret = regmap_clear_bits(map, MA35D1_EADC_REFADJCTL,
>> +					MA35D1_EADC_REFADJCTL_PDREF);
>> +		if (ret)
>> +			return ret;
>> +
>> +		ret = regmap_update_bits(map, MA35D1_EADC_CTL,
>> +					 MA35D1_EADC_CTL_VREFSEL_MASK,
>> +					 MA35D1_EADC_CTL_VREFSEL_1V6);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	fsleep(MA35D1_EADC_REF_STABLE_US);
>> +
>> +	return 0;
>> +}
> 
> 
>> +static int ma35d1_adc_abort_conversion(struct ma35d1_adc *adc)
>> +{
>> +	struct regmap *map = adc->regmap;
>> +	int ret;
>> +	int err;
>> +
>> +	ret = ma35d1_adc_disable_irq(adc);
>> +
>> +	/*
>> +	 * Reset the EADC control circuits to terminate a conversion which may
>> +	 * still be in progress. EADCRST is cleared automatically by hardware
>> +	 * when the reset completes and the EADC register values are preserved.
>> +	 */
>> +	err = ma35d1_adc_reset_control(adc);
>> +	if (!ret)
>> +		ret = err;
> Why not just set ret directly for this one?
>> +
>> +	/* Drain an interrupt which may already have been latched by the GIC. */
>> +	synchronize_irq(adc->irq);
>> +
>> +	err = regmap_write(map, MA35D1_EADC_STATUS2,
>> +			   MA35D1_EADC_STATUS2_ADIF0);
> I don't mind going slightly over 80 chars. I would do so for the line above.
> 
>> +	if (!ret)
>> +		ret = err;
>> +
>> +	reinit_completion(&adc->completion);
> Why?  It is reinit at start of read conversion - why else do we need to
> do it?  Add a comment
> 
>> +
>> +	return ret;
>> +}
>> +
>> +static int ma35d1_adc_read_conversion(struct ma35d1_adc *adc,
>> +				      const struct iio_chan_spec *chan, u16 *raw)
>> +{
>> +	struct regmap *map = adc->regmap;
>> +	unsigned int val;
>> +	long timeout;
>> +	int ret;
>> +
>> +	reinit_completion(&adc->completion);
>> +
>> +	ret = regmap_write(map, MA35D1_EADC_STATUS2, MA35D1_EADC_STATUS2_ADIF0);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = ma35d1_adc_config_channel(adc, chan);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = regmap_set_bits(map, MA35D1_EADC_CTL, MA35D1_EADC_CTL_ADCIEN0);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = regmap_write(map, MA35D1_EADC_SWTRG, BIT(0));
>> +	if (ret)
>> +		goto disable_irq;
>> +
>> +	timeout = wait_for_completion_timeout(&adc->completion,
>> +					      MA35D1_EADC_TIMEOUT);
>> +	if (!timeout) {
>> +		ret = ma35d1_adc_abort_conversion(adc);
>> +		return ret ?: -ETIMEDOUT;
> 
> Timed out first, so I think that should be the return value
> even if the abort then failed.  Maybe an error print is
> more appropriate for a failed abort so we don't loose
> that extra info.
> 
>> +	}
>> +
>> +	ret = ma35d1_adc_disable_irq(adc);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = regmap_read(map, MA35D1_EADC_DAT(0), &val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (!(val & MA35D1_EADC_DAT_VALID))
>> +		return -EIO;
>> +
>> +	if (val & MA35D1_EADC_DAT_OV)
>> +		return -EOVERFLOW;
>> +
>> +	*raw = FIELD_GET(MA35D1_EADC_DAT_RESULT_MASK, val);
> 
> As below - I don't follow why we'd get 16 bits when I think
> all paths throw away everything above the 12th.
> 
>> +
>> +	return 0;
>> +
>> +disable_irq:
>> +	ma35d1_adc_disable_irq(adc);
>> +
>> +	return ret;
>> +}
>> +
>> +static irqreturn_t ma35d1_adc_isr(int irq, void *data)
>> +{
>> +	struct iio_dev *indio_dev = data;
>> +	struct ma35d1_adc *adc = iio_priv(indio_dev);
>> +	unsigned int status;
>> +	int ret;
>> +
>> +	ret = regmap_read(adc->regmap, MA35D1_EADC_STATUS2, &status);
>> +	if (ret || !(status & MA35D1_EADC_STATUS2_ADIF0))
>> +		return IRQ_NONE;
>> +
>> +	regmap_write(adc->regmap, MA35D1_EADC_STATUS2,
>> +		     MA35D1_EADC_STATUS2_ADIF0);
>> +	complete(&adc->completion);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static int ma35d1_adc_sign_extend(u16 raw)
>> +{
>> +	return sign_extend32(raw & MA35D1_EADC_DAT_RESULT_12BIT, 11);
> 
> If the result is always 12 bits, why is read_conversion returning 16?
> 
>> +}
>> +
>> +static int ma35d1_adc_read_raw(struct iio_dev *indio_dev,
>> +			       const struct iio_chan_spec *chan,
>> +			       int *val, int *val2, long mask)
>> +{
>> +	struct ma35d1_adc *adc = iio_priv(indio_dev);
>> +	u16 raw;
>> +	int ret;
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_RAW: {
>> +		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
>> +
> 
> No blank line here.  We want the acquire and the error check tightly
> coupled visually.
> 
>> +		if (IIO_DEV_ACQUIRE_FAILED(claim))
>> +			return -EBUSY;
>> +
>> +		guard(mutex)(&adc->lock);
>> +		if (adc->suspended)
>> +			return -EBUSY;
>> +
>> +		ret = ma35d1_adc_read_conversion(adc, chan, &raw);
>> +		if (ret)
>> +			return ret;
>> +
>> +		if (chan->differential)
>> +			*val = ma35d1_adc_sign_extend(raw);
>> +		else
>> +			*val = raw & MA35D1_EADC_DAT_RESULT_12BIT;
>> +
>> +		return IIO_VAL_INT;
>> +	}
>> +	case IIO_CHAN_INFO_SCALE:
>> +		*val = adc->vref_mV;
>> +		/* Differential mode has a VREF / 2048 LSB; single-ended uses /4096. */
>> +		*val2 = chan->differential ? 11 : 12;
>> +		return IIO_VAL_FRACTIONAL_LOG2;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +static int ma35d1_adc_update_scan_mode(struct iio_dev *indio_dev,
>> +				       const unsigned long *scan_mask)
>> +{
>> +	struct ma35d1_adc *adc = iio_priv(indio_dev);
>> +	const struct iio_chan_spec *scan_chan = NULL;
>> +	unsigned long bit;
>> +
>> +	for_each_set_bit(bit, scan_mask, iio_get_masklength(indio_dev)) {
> 	iio_for_each_active_channel()
> 
>> +		const struct iio_chan_spec *chan = &indio_dev->channels[bit];
>> +
>> +		if (chan->type == IIO_TIMESTAMP)
>> +			continue;
>> +
>> +		if (chan->type != IIO_VOLTAGE || scan_chan)
>> +			return -EINVAL;
>> +
>> +		scan_chan = chan;
> 
> This only makes sense if there is only one channel enabled.
> The driver needs to ensure that is the case (there is a standard
> validation callback for this).
> 
>> +	}
>> +
>> +	if (!scan_chan)
>> +		return -EINVAL;
>> +
>> +	adc->scan_chan = scan_chan;
>> +
>> +	return 0;
>> +}
> 
>> +
>> +static irqreturn_t ma35d1_adc_trigger_handler(int irq, void *p)
> This looks like the device only supports onehot channels (one at a time)
> That's fine but then you should have the callbacks or available_channels
> set to indicate that.
> 
>> +{
>> +	struct iio_poll_func *pf = p;
>> +	struct iio_dev *indio_dev = pf->indio_dev;
>> +	struct ma35d1_adc *adc = iio_priv(indio_dev);
>> +	IIO_DECLARE_BUFFER_WITH_TS(u16, scan, 1) = { };
> Where the timestamp location is fixed (if present) I prefer
> 	struct {
> 		u16 channel;
> 		aligned_s64 timestamp;
> 	} scan;
> 
> as it makes it easier to understand the layout. The macro
> is for the case where different numbers of channels can be enabled
> and there are enough of them to have the timestamp moving around
> depending on what is enabled.
> 
>> +	u16 raw;
>> +	int ret;
>> +
>> +	mutex_lock(&adc->lock);
>> +
>> +	if (!adc->suspended && adc->scan_chan) {
>> +		ret = ma35d1_adc_read_conversion(adc, adc->scan_chan, &raw);
>> +		if (!ret) {
>> +			scan[0] = raw & MA35D1_EADC_DAT_RESULT_12BIT;
>> +			iio_push_to_buffers_with_ts(indio_dev, scan, sizeof(scan),
>> +						    pf->timestamp);
>> +		}
>> +	}
>> +
>> +	mutex_unlock(&adc->lock);
>> +
>> +	iio_trigger_notify_done(indio_dev->trig);
>> +
>> +	return IRQ_HANDLED;
>> +}
> 
>> +
>> +static int ma35d1_adc_fwnode_xlate(struct iio_dev *indio_dev,
>> +				   const struct fwnode_reference_args *iiospec)
>> +{
>> +	unsigned int i;
>> +
>> +	if (iiospec->nargs != 1)
>> +		return -EINVAL;
>> +
>> +	for (i = 0; i < indio_dev->num_channels; i++) {
> 
> 	for (unsigned int i = 0; ..
> 
>> +		const struct iio_chan_spec *chan = &indio_dev->channels[i];
>> +
>> +		if (chan->type == IIO_VOLTAGE &&
>> +		    chan->channel == iiospec->args[0])
>> +			return i;
>> +	}
>> +
>> +	return -EINVAL;
>> +}
>> +
>> +static const struct iio_info ma35d1_adc_info = {
>> +	.read_raw = ma35d1_adc_read_raw,
>> +	.update_scan_mode = ma35d1_adc_update_scan_mode,
>> +	.fwnode_xlate = ma35d1_adc_fwnode_xlate,
>> +};
>> +
>> +static void ma35d1_adc_init_channel(struct iio_chan_spec *chan, u32 index,
> 
> As below.  Given C provides nice ways to set lots of structure elements
> helpers use those, rather than a fill the values in helper.
> 
>> +				    u32 vinp, u32 vinn,
>> +				    unsigned int scan_index,
>> +				    bool differential)
>> +{
>> +	chan->type = IIO_VOLTAGE;
>> +	chan->indexed = 1;
>> +	chan->channel = index;
>> +	chan->address = vinp;
>> +	chan->scan_index = scan_index;
>> +	chan->info_mask_separate =
>> +		BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE);
>> +	chan->scan_type.format = differential ? IIO_SCAN_FORMAT_SIGNED_INT :
>> +					      IIO_SCAN_FORMAT_UNSIGNED_INT;
>> +	chan->scan_type.realbits = 12;
>> +	chan->scan_type.storagebits = 16;
>> +	chan->scan_type.endianness = IIO_CPU;
>> +
>> +	if (differential) {
>> +		chan->differential = 1;
>> +		chan->channel2 = vinn;
>> +	}
>> +}
>> +
>> +static int ma35d1_adc_parse_channels(struct iio_dev *indio_dev,
>> +				     struct device *dev)
>> +{
>> +	DECLARE_BITMAP(used_regs, MA35D1_EADC_MAX_EXT_CHANNELS);
>> +	struct iio_chan_spec *channels;
>> +	unsigned int scan_index;
>> +	int num_channels;
>> +	int ret;
>> +
>> +	bitmap_zero(used_regs, MA35D1_EADC_MAX_EXT_CHANNELS);
>> +
>> +	num_channels = device_get_child_node_count(dev);
>> +	if (!num_channels)
>> +		return dev_err_probe(dev, -ENOENT, "no ADC channels configured\n");
>> +
>> +	if (num_channels > MA35D1_EADC_MAX_EXT_CHANNELS)
>> +		return dev_err_probe(dev, -EINVAL, "too many ADC channels\n");
>> +
>> +	channels = devm_kcalloc(dev, size_add(num_channels, 1),
>> +				sizeof(*channels), GFP_KERNEL);
>> +	if (!channels)
>> +		return -ENOMEM;
>> +
>> +	scan_index = 0;
>> +	device_for_each_child_node_scoped(dev, child) {
>> +		bool differential;
>> +		u32 reg;
>> +		u32 vinp;
>> +		u32 vinn;
> 
> Can combine these related u32s on oneline.
> 
>> +
>> +		ret = fwnode_property_read_u32(child, "reg", &reg);
>> +		if (ret)
>> +			return dev_err_probe(dev, ret,
>> +					     "missing channel reg property\n");
>> +
>> +		if (reg >= MA35D1_EADC_MAX_EXT_CHANNELS)
>> +			return dev_err_probe(dev, -EINVAL,
>> +					     "invalid ADC channel index %u\n", reg);
>> +
>> +		if (test_and_set_bit(reg, used_regs))
>> +			return dev_err_probe(dev, -EINVAL,
>> +					     "duplicate ADC channel index %u\n", reg);
>> +
>> +		if (fwnode_property_present(child, "single-channel")) {
>> +			ret = fwnode_property_read_u32(child, "single-channel",
>> +						       &vinp);
>> +			if (ret)
>> +				return dev_err_probe(dev, ret,
>> +						     "invalid single-channel for index %u\n",
>> +						     reg);
>> +
>> +			if (vinp >= MA35D1_EADC_MAX_EXT_CHANNELS)
>> +				return dev_err_probe(dev, -EINVAL,
>> +						     "invalid ADC input %u\n", vinp);
>> +
>> +			vinn = 0;
>> +			differential = false;
>> +		} else {
> 
> This will change to match my requests for the binding so I won't look too closely
> at it in this revision.
> 
>> +			if (reg >= 4)
>> +				return dev_err_probe(dev, -EINVAL,
>> +						     "invalid differential pair %u\n", reg);
>> +
>> +			vinp = reg;
>> +			vinn = reg + 4;
>> +			differential = true;
>> +		}
>> +
>> +		ma35d1_adc_init_channel(&channels[scan_index], reg, vinp, vinn,
>> +					scan_index, differential);
> get rid of this and fill the structure in directly in the two different
> paths above - so have a single ended copy of this and the slightly
> different one for the differential channels. Bit of duplication
> but simpler code by putting it all in one place.
> 
> 			channels[scan_index] = (struct iio_chan_spec) {
> 				.type = IIO_VOLTAGE,
> 				.indexed = 1,
> 				.channel = index,
> 				.address = vinp,
> 				.scan_index = scan_index,
> 				.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> 						      BIT(IIO_CHAN_INFO_SCALE);
> 				.scan_type = {
> 					.format = IIO_SCAN_FORMAT_UNSIGNED_INT,
> 					.realbits = 12,
> 					.storagebits = 16,
> 					.endianness = IIO_CPU,;
> 			};
> 		
>> +		scan_index++;
> 
>> +	}
>> +
>> +	channels[scan_index] = IIO_CHAN_SOFT_TIMESTAMP(scan_index);
> 
>> +
>> +	indio_dev->channels = channels;
>> +	indio_dev->num_channels = scan_index + 1;
>> +
>> +	return 0;
>> +}
>> +
>> +static int ma35d1_adc_init_vref(struct ma35d1_adc *adc, struct device *dev)
>> +{
>> +	int ret;
>> +
>> +	adc->vref = devm_regulator_get_optional(dev, "vref");
>> +	ret = PTR_ERR_OR_ZERO(adc->vref);
>> +	if (ret == -ENODEV) {
>> +		adc->vref = NULL;
>> +		adc->vref_mV = MA35D1_EADC_INTERNAL_VREF_mV;
>> +		return 0;
>> +	}
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "failed to get VREF supply\n");
>> +
>> +	ret = regulator_enable(adc->vref);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "failed to enable VREF supply\n");
>> +
>> +	ret = devm_add_action_or_reset(dev, ma35d1_adc_vref_disable, adc->vref);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = regulator_get_voltage(adc->vref);
> 
> There are plenty of examples of how to use devm_regulator_get_enable_read_voltage()
> with optional regulators in tree.  Follow one of those and this code will be a lot
> shorter.
> 
>> +	if (ret <= 0)
>> +		return dev_err_probe(dev, ret ?: -EINVAL,
>> +				     "failed to get VREF voltage\n");
>> +
>> +	adc->vref_mV = ret / (MICRO / MILLI);
>> +
>> +	return 0;
>> +}
> 
>> +static int ma35d1_adc_suspend(struct device *dev)
>> +{
>> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>> +	struct ma35d1_adc *adc = iio_priv(indio_dev);
>> +	int ret;
>> +
>> +	ret = iio_device_suspend_triggering(indio_dev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	mutex_lock(&adc->lock);
>> +
>> +	ret = ma35d1_adc_disable_irq(adc);
>> +	if (ret)
>> +		goto resume_triggering;
>> +
>> +	synchronize_irq(adc->irq);
>> +
>> +	ret = regmap_clear_bits(adc->regmap, MA35D1_EADC_CTL,
>> +				MA35D1_EADC_CTL_ADCEN);
>> +	if (ret)
> 
> If this fails, for consistency I think you should probably
> reenable the irq.  If not add a comment on your thinking for
> why.
> 
>   
>> +		goto resume_triggering;
>> +
>> +	adc->suspended = true;
>> +	clk_disable_unprepare(adc->clk);
>> +	mutex_unlock(&adc->lock);
>> +
>> +	return 0;
>> +
>> +resume_triggering:
>> +	mutex_unlock(&adc->lock);
>> +	iio_device_resume_triggering(indio_dev);
>> +
>> +	return ret;
>> +}
>> +
> 

Hi Jonathan,

Thank you for the detailed review.

I will address these comments in v4.

The channel parsing will be reworked together with the binding changes.
reg will remain the logical channel index, while single-channel and
diff-channels will describe the physical inputs. Accordingly, the IIO
channel specification will use channel/channel2 for the physical input
or differential pair, while address will keep the logical DT channel
index used for firmware-node translation.

I will also remove ma35d1_adc_init_channel() and initialize the
iio_chan_spec structures directly in the single-ended and differential
parsing paths.

Regarding the one-hot scan-mask handling, the MA35D1 hardware itself is
not limited to one sample module at a time. The EADC has one SAR
converter shared by multiple sample modules. Multiple sample modules can
be triggered together, after which the hardware priority arbitrator
performs their conversions sequentially.

The initial driver, however, currently uses only sample module 0 and
performs one voltage conversion for each buffered trigger. Therefore
the buffered interface exposed by this version of the driver supports
one active voltage channel per scan. I will make this limitation
explicit using the standard one-hot scan-mask validation callback and
use iio_for_each_active_channel() when selecting the active channel.
Support for using multiple sample modules for multi-channel buffered
scans can be added separately in the future.

Since the scan layout is therefore fixed to one u16 sample plus an
optional timestamp, I will replace IIO_DECLARE_BUFFER_WITH_TS() with a
fixed scan structure containing one u16 sample and an aligned timestamp.

For the conversion path I will make the returned ADC sample explicitly
12 bits. Differential values will then be sign-extended directly from
that 12-bit value, rather than carrying a 16-bit intermediate result
whose upper bits are discarded later.

For timeout recovery I will keep -ETIMEDOUT as the primary error. If
resetting or aborting the timed-out conversion fails, I will report that
separately instead of replacing the timeout return value. I will also
remove the redundant completion reinitialization from the abort path,
since the completion is reinitialized before each new conversion and
the abort path already synchronizes the IRQ.

I will simplify the optional VREF handling using
devm_regulator_get_enable_read_voltage() and keep a flag indicating
whether the external reference is in use.

Regarding the suspend error path, ADCIEN0 is only enabled while a
conversion is in progress and is normally disabled while the device is
idle. The suspend path holds the device lock after triggering has been
suspended, so there is no active conversion at that point. If disabling
ADCEN fails, leaving ADCIEN0 disabled therefore matches the normal idle
state, and the next conversion will enable it again. I will add a
comment to make this state transition clear rather than unconditionally
re-enabling the interrupt.

I will also take care of the smaller style points, including keeping the
direct-mode acquire and error check together, using a loop-local
variable in fwnode_xlate(), combining the related u32 declarations, and
avoiding unnecessary line wrapping.

Thanks,
Chi-Wen

