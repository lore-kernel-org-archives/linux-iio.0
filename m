Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13490357CED
	for <linux-iio@vger.kernel.org>; Sat,  4 Jul 2026 16:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783183840; cv=none; b=qOj+iW6wXG5w3/TbWViXvRM11e2cNph5upwlhtB+d9/7NZJXTx3HLdqEPKBBUlpuTDQhFNaz9tkFR8jPQxk3WwgPlMqcagUIMsGs76YJyWT8Y7NthaKKPsjfXuIH9As2XFkC6rMF8Lcmv3FK3aTIhU8yEJlsZB47VfMqyftlOq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783183840; c=relaxed/simple;
	bh=I4w7J78soOjJ0QUV6I0ifDS+Q+5IOOM3fxCKJ+hVduw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YBALazLNgS+5JHm0nn2CwI2ND8HtWjJY6oQWw7rpCDmqDPUDMGT1KfzEAkEz0/mkvqJPMaP+C/7w/ByJWyiyRLKjp1H5e4Q+ZH3P3dw3lPw7uw8EQW7zujjhR/27QKYaVCn7klXu1mMfnG/gYfSq7FsuKCxeyrEVTuj07eNdxbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=KGIVjtDh; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="KGIVjtDh"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7e9fa42f08cso1026076a34.1
        for <linux-iio@vger.kernel.org>; Sat, 04 Jul 2026 09:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783183837; x=1783788637; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r/gEBWdH2YbusOaxF2AVLiisIf8zHaMmjVT4xSj8PXs=;
        b=KGIVjtDhSG+kReS0uIixBDUPdCC0wM05UXt5tWRk0oHxz1iqW7xAnZDjkVlLpzaQy6
         rTurFDpmEfqO8QfjPIWOJgRRqzLm8D4JlPvSBYhw+vhCwKP83RrBphshgMv9C7mEPCvh
         48qUsxEbi63Nr6sBUPx6rHf5nQjf4MtLmWjDZ9kpUqc456fsiom4RbjTRyyH1P70NsYP
         grsOPaqf54MsYZZ8MN/PBKFl8E43QEdy8hNH/QV+SFPkM64i0h636DYr2hfd+i7KtwTj
         bVvpqqdONNZkOK1wqYNi4s4JUY/55RNmFcWG8sFT0Tv9ktTjO4FuG5mXdZOLNvXb2YL5
         ceNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783183837; x=1783788637;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r/gEBWdH2YbusOaxF2AVLiisIf8zHaMmjVT4xSj8PXs=;
        b=fDqA0OTo30MmK6oBYDfx0hp9zufSmPJGk1nsdSEo4oSAZ2kIoGDX/633T2Eaga7LZ+
         eGPqRicyiVJrM6MZMK6ciU3hR4g5H+lK+xZHee/75NR6Htob6ZU0SGVy2Kr96WjJ4s/W
         PJm5cj/6bdVLaVTr5qTnCgG4TXQVuqnUq+nmc1q+Kh1P6jm+KlvPKLlNRcCI7Aad+o2R
         2RT9HUAwsSw4K0osrmA0aFTPnZxO0te7iKYLavopENlVjFgrVRrGsgMdAoMRB2FHKeVL
         RZvrnYh3W1Cfrc+MdJIRamGawWIDNKCC4VwIfgle5uTGgWBjvVvHwIFCS7b6B3NzQaVZ
         8h1A==
X-Forwarded-Encrypted: i=1; AFNElJ/3/BDXEn4tyHbRUOq33k/fm/6kjqwvoC082rJSyuVI3OWJy2RXUYYSKxonq1G0PuP+q3j9srv+2bQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzLFjBqPkLq8ygn9XM4BtpuhuYCSrwe6XR4iP98jKDE3aQNGeX
	im8yw1kCou7nFovENeN6exXJ0cpXkrK6m0pXtX+HUE5Nl7LF/oRVG/RdcBW27fBXSfc=
X-Gm-Gg: AfdE7cnywDDEoHw8waiwG3c9ZMWvsrLnAnZaR6jElwcSyEt4gRkLSz+Hq2GIiaCE10D
	HOBlHpEGN0iNoHXhZ3Q35BfFSUZTplx8hkyQiCBNscMI3hmvMsJ/AnV8ff9P9A6I6DsjB5QUlXG
	v6QZUurJRrAlBcuhmjOUUtC2in/TUMeFn3GPjMV3yqefXPYDOwEl876qFGx24omxdvzBzS63mmB
	BGYD57QfR9w7PL5UNIVTfzi6Bye0MPPxbDtlBJM23kQ8r1m26qnlZFI0yyEKDKDglvVMW70rfa0
	iRqtZZZBQbHZWvzkC1UGF67T2qiEDkgISCmU5/dfL/4irXuCSeV28INBf4580b9ETeXb0yAbWb/
	m6gYu0slu1SUYvw4ZfJpV4qaXlGlMw6uefOeo+tKazHzKqNHFRquMBxl8m9gMmHs37gJn6tAZkF
	YZgynGF/0/bqZVQxsYuMbvHGMj/qQaI7vyLhv26q5ma7QVGN9XqkOp8wI4zj8P7r0=
X-Received: by 2002:a05:6830:381a:b0:7df:5fc:3fd8 with SMTP id 46e09a7af769-7eb7fd2c5d2mr2822485a34.1.1783183836823;
        Sat, 04 Jul 2026 09:50:36 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:4944:e714:93fc:9815? ([2600:8803:e7e4:500:4944:e714:93fc:9815])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7eb542936e6sm7552846a34.5.2026.07.04.09.50.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Jul 2026 09:50:36 -0700 (PDT)
Message-ID: <1493eed5-5bb8-4a2c-8f2d-8b4bc5dde157@baylibre.com>
Date: Sat, 4 Jul 2026 11:50:35 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/16] iio: frequency: ad9910: add RAM mode support
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>, rodrigo.alencar@analog.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-hardening@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <20260618-ad9910-iio-driver-v6-0-79125ffbe430@analog.com>
 <20260618-ad9910-iio-driver-v6-12-79125ffbe430@analog.com>
 <20260703040544.08a8ea5e@jic23-huawei> <ake_YWfvVC9RQ3wu@nsa>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <ake_YWfvVC9RQ3wu@nsa>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/3/26 9:09 AM, Nuno Sá wrote:
> On Fri, Jul 03, 2026 at 04:05:44AM +0100, Jonathan Cameron wrote:
>> On Thu, 18 Jun 2026 14:27:28 +0100
>> Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
>>
>>> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
>>>
>>> Add RAM control channel, which includes:
>>> - RAM data loading via firmware upload interface;
>>> - Per-profile configuration and DDS core parameter destination as firmware
>>>   metadata;
>>> - Profile switching relying on profile channels;
>>> - Sampling frequency control of the active profile;
>>> - ram-enable-aware read/write paths that redirect single tone
>>>   frequency/phase/amplitude access through reg_profile cache when RAM is
>>>   active;
>>>
>>> When RAM is enabled, the DDS profile parameters (frequency, phase,
>>> amplitude) for the single tone mode are sourced from a shadow register
>>> cache (reg_profile[]) since the profile registers are repurposed for RAM
>>> control.
>>>
>>> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
>>
>>> diff --git a/drivers/iio/frequency/ad9910.c b/drivers/iio/frequency/ad9910.c
>>> index 3fe97aa887c3..c4e179dda715 100644
>>> --- a/drivers/iio/frequency/ad9910.c
>>> +++ b/drivers/iio/frequency/ad9910.c
>>
>>> +static enum fw_upload_err ad9910_ram_fwu_write(struct fw_upload *fw_upload,
>>> +					       const u8 *data, u32 offset,
>>> +					       u32 size, u32 *written)
>>> +{
>>> +	const struct ad9910_ram_fw *fw_data = (const struct ad9910_ram_fw *)data;
>>> +	struct ad9910_state *st = fw_upload->dd_handle;
>>> +	int ret, ret2, idx, wcount;
>>> +	u64 tmp64, backup;
>>> +
>>> +	if (offset != 0)
>>> +		return FW_UPLOAD_ERR_INVALID_SIZE;
>>> +
>>> +	guard(mutex)(&st->lock);
>>> +
>>> +	if (st->ram_fwu_cancel)
>>> +		return FW_UPLOAD_ERR_CANCELED;
>>> +
>>> +	if (AD9910_RAM_ENABLED(st))
>>> +		return FW_UPLOAD_ERR_HW_ERROR;
>>> +
>>> +	for (idx = 0; idx < AD9910_NUM_PROFILES; idx++)
>>> +		st->reg_profile[idx] = get_unaligned_be64(&fw_data->profiles[idx]) |
>>> +				       AD9910_PROFILE_RAM_OPEN_MSK;
>>> +
>>> +	ret = ad9910_reg32_update(st, AD9910_REG_CFR1,
>>> +				  AD9910_CFR1_RAM_PLAYBACK_DEST_MSK |
>>> +				  AD9910_CFR1_INT_PROFILE_CTL_MSK,
>>> +				  get_unaligned_be32(&fw_data->cfr1), true);
>>> +	if (ret)
>>> +		return FW_UPLOAD_ERR_RW_ERROR;
>>> +
>>> +	wcount = get_unaligned_be16(&fw_data->wcount);
>>> +	if (!wcount) {
>>> +		*written = size;
>>> +		return FW_UPLOAD_ERR_NONE; /* nothing else to write */
>>> +	}
>>> +
>>> +	ret = ad9910_profile_set(st, st->profile);
>>> +	if (ret)
>>> +		return FW_UPLOAD_ERR_HW_ERROR;
>>> +
>>> +	/* backup profile register and update it with required address range */
>>> +	backup = st->reg[AD9910_REG_PROFILE(st->profile)].val64;
>>> +	tmp64 = AD9910_PROFILE_RAM_STEP_RATE_MSK |
>>> +		FIELD_PREP(AD9910_PROFILE_RAM_START_ADDR_MSK, 0) |
>>> +		FIELD_PREP(AD9910_PROFILE_RAM_END_ADDR_MSK, wcount - 1);
>>> +	ret = ad9910_reg64_write(st, AD9910_REG_PROFILE(st->profile), tmp64, true);
>>> +	if (ret)
>>> +		return FW_UPLOAD_ERR_RW_ERROR;
>>> +
>>> +	memcpy(&st->tx_buf[1], fw_data->words, wcount * AD9910_RAM_WORD_SIZE);
>>> +
>>> +	/* write ram data and restore profile register */
>>> +	ret = ad9910_spi_write(st, AD9910_REG_RAM,
>>> +			       wcount * AD9910_RAM_WORD_SIZE, false);
>>> +	ret2 = ad9910_reg64_write(st, AD9910_REG_PROFILE(st->profile), backup, true);
>>> +	if (ret || ret2)
>>> +		return FW_UPLOAD_ERR_RW_ERROR;
>>> +
>>> +	*written = size;
>>
>> I'd like a blank line here. Mostly to make that 'good' return more obvious.
>>
>>> +	return FW_UPLOAD_ERR_NONE;
>>> +}
>>
>>>  
>>> +static inline void ad9910_debugfs_init(struct ad9910_state *st,
>>> +				       struct iio_dev *indio_dev)
>>> +{
>>> +	struct dentry *d = iio_get_debugfs_dentry(indio_dev);
>>> +	char buf[64];
>>> +
>>> +	/*
>>> +	 * symlinks are created here so iio userspace tools can refer to them
>>> +	 * as debug attributes.
>>
>> Maybe worth a reference to appropriate ABI doc here (even if it is introduced
>> in a later patch)
> 
> I'm not so sure about these links. I mean, I definitely agree we should
> make it easy for userspace tools like libiio to be able to handle
> these kind of attributes but using debugfs is questionable to me. Pretty
> much because this is not a debug thing. It is a real setting for the
> driver so ideally we would be able to control it (using the existent
> tools) without enforcing one to mount debugfs (I know that most of the
> times it's always mounted but still feels wrong to tie "real
> functionality" to debugfs). 
> 
> Having said the above, some suggestions:
> 
> 1. Make the iio_dev the parent so that the attr name is just "ram" and
> it will be a subdir /sys/bus/iio/iio:deviceN/ram/.
> 2. Propose a new helper for the firmware_loader code so we can get
> struct device from struct fw_upload then we can easily create a sysfs
> symlink.
> 3. Name the attr as dev_name(iio_dev):attr so that it becomes
> iio:deviceN:attr_name.
> 
> Now that I think about it, 2. does not make much sense when compared to
> 1. And If I'm not missing anything both 1. and 3. can be sanely parsable
> from userspace (being 3. maybe a bit more reliable). And yes, both require
> user space tools (in this case libiio) to support a new type of
> attribute (firmware) but that is another problem.

I would say that udev should be used to find the firmware device from
userspace rather than creating symlinks. And you probably don't even
need udev if you already have the `iio-device:<ID>` value. The path
is always going to be `/sys/class/firmware/iio-device:<ID>:ram/`. It
seems like the same amount of work for usespace to computer the path
either way, so might as well keep it simple and leave out the symlink
stuff.

> 
> - Nuno Sá
>>
>>> +	 */
>>> +	snprintf(buf, sizeof(buf), "/sys/class/firmware/%s/loading", st->ram_fwu_name);
>>> +	debugfs_create_symlink("ram_loading", d, buf);
>>> +
>>> +	snprintf(buf, sizeof(buf), "/sys/class/firmware/%s/data", st->ram_fwu_name);
>>> +	debugfs_create_symlink("ram_data", d, buf);
>>> +}
>>> +
>>>  static int ad9910_probe(struct spi_device *spi)
>>>  {
>>>  	static const char * const supplies[] = {
>>> @@ -1561,7 +1876,25 @@ static int ad9910_probe(struct spi_device *spi)
>> ...
>>
>>> +	ad9910_debugfs_init(st, indio_dev);
>>
>> Blank line preferred before a simple return like this one.
>>
>>> +	return 0;
>>>  }
>>>  
>>>  static const struct spi_device_id ad9910_id[] = {
>>>
>>

