Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3B347278C
	for <linux-iio@vger.kernel.org>; Mon,  6 Jul 2026 09:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783331165; cv=none; b=hW287VqoUEXFZSkeYJYdvcyIwq3ZfnoHrepo4mgu/Js4xL2VOnYGFvDpoGzF3nJur0nmLd/+Aq1jUAIAHL1NuRD2dGOYFHDyaiHCQDjecylaT5M8NuoiB6TppvC26iUR2Zcj5ctodRj+s5oYYJBV9RYdG5kemsbPz4+4+F31+Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783331165; c=relaxed/simple;
	bh=zDw0ABLub0kgFm+IA9IE6NYszy3Pq95vEScWSA+dnhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ajaCq6FjKOPn3pS5O2umcZ8t2IxNRGSWxvy20Mk77LfR8QJCXx67T6hFjMtjvm29E4D3JuFFKgCsqHVNai9QQUyxKZ78QlSVSQMvin8Qd8f5xQdSOqL/pz1RZstODpOGlUwC+M4ZvwVrEunQ4PFT71NL/dtdwTL5xtBNQeteuXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m7HKNewx; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7HKNewx"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-493b691cb44so19304525e9.0
        for <linux-iio@vger.kernel.org>; Mon, 06 Jul 2026 02:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783331158; x=1783935958; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/ujYMuu1OWSnbiAmz8ZNXJGcWE93aVNWAdKELmlJkJw=;
        b=m7HKNewxSSGBmTzR2gmUA2UURsCEGjhjxl1YFk1AshqSNelnllxGkY9DWE9k73czMD
         XfdGaggCpBHapMRsd5bsQVOcypEYJE5tmIqjfTIJdZK/d4rs89r8JnmFoKCFYC3osd1c
         K0zPADhcB6719Lnm1TKCturvMyH+4pQsm706814f8lj5Tt7fhyOzcYcAueVPGNvFJDjx
         wPlNlDpkKwoNJ6lgj3huhQmXXSaYtG/MkvcXP4zEt/KmXiIk0VJf3HtrV+OEswkN2Y+V
         cf/Jm5wOQ1P7aR9H84U45ytMcquN66X2OtAfjIh5qS2Rm+sj/apFuRa5gHoCQhI/TC7Q
         JyJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783331158; x=1783935958;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/ujYMuu1OWSnbiAmz8ZNXJGcWE93aVNWAdKELmlJkJw=;
        b=YgOcXn1JxoJKtFpXuxEHKbTBh6Ekd6R4LFZXENt94+baOmrrbA32hsLWR46cvkgzVJ
         vzIIEQWSWgYZ7Lc8g4jaZoQpRbPQ3elm/0kMkJ2u3G8BtUEHT5cSf+OFyk7b+ALyfraY
         XibPC+YWC029bR2P3yHm85CdYGGLmhWyWhtY0BGVzhlKKxgX3dPUY8vYei1l0DFTlTvv
         vsN0QBA2ZpLEL/WYuqL1qv3l9wf27dA1RvwWGE0+ezY9Db2af+Pvgh75xm8qA4q8XAvS
         aNmynGLH7vhsvcl22veAoxtvMHFjNkeiJl2+4wfEZlujZ4XcW0FF8EnJ8CUG4GyyvYWH
         8ABw==
X-Forwarded-Encrypted: i=1; AHgh+RrXcA2DYayh7DZEVkwNJ7mgV10OOcVQ0Z4PrsbqKPRXjT6QUeCYOsOJzJAEnM4mj7kZXKQGMXl/W18=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5gtTJhyErn58/5BMQpF5+RrnKkrqcc6xhjfL59C4PjkY+Edss
	hgn0uDbGE9GqGJPJXBhEP4A/xus/J0pk6Y7MsqQvC+tOzEe+dOluNJYM
X-Gm-Gg: AfdE7clO7ZPPy+elc4uGNjC+MeqWNKQMN9HFF/TEVq2s/UeC3o0//6LD+iHDLBpAAff
	noB+RUvLAUXbNF+ELulcl0tSZuKyDDO+cRmRuC33ilFP6RStPvyX4RtaSXsl+sEh3aTCDPOpRT2
	CIp7tfCiveq+ECZVlDko6KvyvPZjd73wNtzUjI8YU3bcEuPnWy58+iaFxhtQGOoTmK+YELhSpNQ
	6CzLuPmezffokWZpKRCOIEIV/dFSEPVJzwlJXV5at6LSD7PrXgS7zk9rd/RUoLRa4N7QQA+YXH2
	ORlym38LP9rmBIUR8XiYnAif5H+0uZNqkpuMMWpbiIhA013mgsDHSoXJusXwtFr6ko9Gvbt4y+h
	XCHgwgF8TlYaHKWdpTlvOw0tnmX8gxeDlqfQx8QVeTMEJZ0CtgDC5t/a1IIKtuUhplEg6CcqkId
	xVHW47
X-Received: by 2002:a05:600c:848c:b0:493:c862:3f2d with SMTP id 5b1f17b1804b1-493d11d3bf6mr110310105e9.5.1783331158069;
        Mon, 06 Jul 2026 02:45:58 -0700 (PDT)
Received: from nsa ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c637bc21sm645014455e9.7.2026.07.06.02.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 02:45:57 -0700 (PDT)
Date: Mon, 6 Jul 2026 10:47:02 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>, rodrigo.alencar@analog.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v6 12/16] iio: frequency: ad9910: add RAM mode support
Message-ID: <akt3i_YxG-jF3IdJ@nsa>
References: <20260618-ad9910-iio-driver-v6-0-79125ffbe430@analog.com>
 <20260618-ad9910-iio-driver-v6-12-79125ffbe430@analog.com>
 <20260703040544.08a8ea5e@jic23-huawei>
 <ake_YWfvVC9RQ3wu@nsa>
 <1493eed5-5bb8-4a2c-8f2d-8b4bc5dde157@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1493eed5-5bb8-4a2c-8f2d-8b4bc5dde157@baylibre.com>

On Sat, Jul 04, 2026 at 11:50:35AM -0500, David Lechner wrote:
> On 7/3/26 9:09 AM, Nuno Sá wrote:
> > On Fri, Jul 03, 2026 at 04:05:44AM +0100, Jonathan Cameron wrote:
> >> On Thu, 18 Jun 2026 14:27:28 +0100
> >> Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> >>
> >>> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> >>>
> >>> Add RAM control channel, which includes:
> >>> - RAM data loading via firmware upload interface;
> >>> - Per-profile configuration and DDS core parameter destination as firmware
> >>>   metadata;
> >>> - Profile switching relying on profile channels;
> >>> - Sampling frequency control of the active profile;
> >>> - ram-enable-aware read/write paths that redirect single tone
> >>>   frequency/phase/amplitude access through reg_profile cache when RAM is
> >>>   active;
> >>>
> >>> When RAM is enabled, the DDS profile parameters (frequency, phase,
> >>> amplitude) for the single tone mode are sourced from a shadow register
> >>> cache (reg_profile[]) since the profile registers are repurposed for RAM
> >>> control.
> >>>
> >>> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> >>
> >>> diff --git a/drivers/iio/frequency/ad9910.c b/drivers/iio/frequency/ad9910.c
> >>> index 3fe97aa887c3..c4e179dda715 100644
> >>> --- a/drivers/iio/frequency/ad9910.c
> >>> +++ b/drivers/iio/frequency/ad9910.c
> >>
> >>> +static enum fw_upload_err ad9910_ram_fwu_write(struct fw_upload *fw_upload,
> >>> +					       const u8 *data, u32 offset,
> >>> +					       u32 size, u32 *written)
> >>> +{
> >>> +	const struct ad9910_ram_fw *fw_data = (const struct ad9910_ram_fw *)data;
> >>> +	struct ad9910_state *st = fw_upload->dd_handle;
> >>> +	int ret, ret2, idx, wcount;
> >>> +	u64 tmp64, backup;
> >>> +
> >>> +	if (offset != 0)
> >>> +		return FW_UPLOAD_ERR_INVALID_SIZE;
> >>> +
> >>> +	guard(mutex)(&st->lock);
> >>> +
> >>> +	if (st->ram_fwu_cancel)
> >>> +		return FW_UPLOAD_ERR_CANCELED;
> >>> +
> >>> +	if (AD9910_RAM_ENABLED(st))
> >>> +		return FW_UPLOAD_ERR_HW_ERROR;
> >>> +
> >>> +	for (idx = 0; idx < AD9910_NUM_PROFILES; idx++)
> >>> +		st->reg_profile[idx] = get_unaligned_be64(&fw_data->profiles[idx]) |
> >>> +				       AD9910_PROFILE_RAM_OPEN_MSK;
> >>> +
> >>> +	ret = ad9910_reg32_update(st, AD9910_REG_CFR1,
> >>> +				  AD9910_CFR1_RAM_PLAYBACK_DEST_MSK |
> >>> +				  AD9910_CFR1_INT_PROFILE_CTL_MSK,
> >>> +				  get_unaligned_be32(&fw_data->cfr1), true);
> >>> +	if (ret)
> >>> +		return FW_UPLOAD_ERR_RW_ERROR;
> >>> +
> >>> +	wcount = get_unaligned_be16(&fw_data->wcount);
> >>> +	if (!wcount) {
> >>> +		*written = size;
> >>> +		return FW_UPLOAD_ERR_NONE; /* nothing else to write */
> >>> +	}
> >>> +
> >>> +	ret = ad9910_profile_set(st, st->profile);
> >>> +	if (ret)
> >>> +		return FW_UPLOAD_ERR_HW_ERROR;
> >>> +
> >>> +	/* backup profile register and update it with required address range */
> >>> +	backup = st->reg[AD9910_REG_PROFILE(st->profile)].val64;
> >>> +	tmp64 = AD9910_PROFILE_RAM_STEP_RATE_MSK |
> >>> +		FIELD_PREP(AD9910_PROFILE_RAM_START_ADDR_MSK, 0) |
> >>> +		FIELD_PREP(AD9910_PROFILE_RAM_END_ADDR_MSK, wcount - 1);
> >>> +	ret = ad9910_reg64_write(st, AD9910_REG_PROFILE(st->profile), tmp64, true);
> >>> +	if (ret)
> >>> +		return FW_UPLOAD_ERR_RW_ERROR;
> >>> +
> >>> +	memcpy(&st->tx_buf[1], fw_data->words, wcount * AD9910_RAM_WORD_SIZE);
> >>> +
> >>> +	/* write ram data and restore profile register */
> >>> +	ret = ad9910_spi_write(st, AD9910_REG_RAM,
> >>> +			       wcount * AD9910_RAM_WORD_SIZE, false);
> >>> +	ret2 = ad9910_reg64_write(st, AD9910_REG_PROFILE(st->profile), backup, true);
> >>> +	if (ret || ret2)
> >>> +		return FW_UPLOAD_ERR_RW_ERROR;
> >>> +
> >>> +	*written = size;
> >>
> >> I'd like a blank line here. Mostly to make that 'good' return more obvious.
> >>
> >>> +	return FW_UPLOAD_ERR_NONE;
> >>> +}
> >>
> >>>  
> >>> +static inline void ad9910_debugfs_init(struct ad9910_state *st,
> >>> +				       struct iio_dev *indio_dev)
> >>> +{
> >>> +	struct dentry *d = iio_get_debugfs_dentry(indio_dev);
> >>> +	char buf[64];
> >>> +
> >>> +	/*
> >>> +	 * symlinks are created here so iio userspace tools can refer to them
> >>> +	 * as debug attributes.
> >>
> >> Maybe worth a reference to appropriate ABI doc here (even if it is introduced
> >> in a later patch)
> > 
> > I'm not so sure about these links. I mean, I definitely agree we should
> > make it easy for userspace tools like libiio to be able to handle
> > these kind of attributes but using debugfs is questionable to me. Pretty
> > much because this is not a debug thing. It is a real setting for the
> > driver so ideally we would be able to control it (using the existent
> > tools) without enforcing one to mount debugfs (I know that most of the
> > times it's always mounted but still feels wrong to tie "real
> > functionality" to debugfs). 
> > 
> > Having said the above, some suggestions:
> > 
> > 1. Make the iio_dev the parent so that the attr name is just "ram" and
> > it will be a subdir /sys/bus/iio/iio:deviceN/ram/.
> > 2. Propose a new helper for the firmware_loader code so we can get
> > struct device from struct fw_upload then we can easily create a sysfs
> > symlink.
> > 3. Name the attr as dev_name(iio_dev):attr so that it becomes
> > iio:deviceN:attr_name.
> > 
> > Now that I think about it, 2. does not make much sense when compared to
> > 1. And If I'm not missing anything both 1. and 3. can be sanely parsable
> > from userspace (being 3. maybe a bit more reliable). And yes, both require
> > user space tools (in this case libiio) to support a new type of
> > attribute (firmware) but that is another problem.
> 
> I would say that udev should be used to find the firmware device from
> userspace rather than creating symlinks. And you probably don't even
> need udev if you already have the `iio-device:<ID>` value. The path

Just one note. If you mean <ID> as the attr name the above will fail for
multiple instances of the same device. That's is why a proposed
dev_name(iio_dev) which I think it should reliable be iio:deviceN. 

I guess N might change so anyone hardcoding it might have surprises. But
properly done and we have a sane way to match the above with anything on
/sys/class/firmware/iio:deviceN:<attr>/

> is always going to be `/sys/class/firmware/iio-device:<ID>:ram/`. It
> seems like the same amount of work for usespace to computer the path
> either way, so might as well keep it simple and leave out the symlink
> stuff.

Yes, at least for libiio, `iio:deviceN` is already what we call the
device ID so we can match fw attrs against it and everything after the
last ':' is treated as the attr_name. 

We just need to keep in mind that if a second user of this stuff pops
up, we should add a new helper to enforce the ABI.

- Nuno Sá
> 
> > 
> > - Nuno Sá
> >>
> >>> +	 */
> >>> +	snprintf(buf, sizeof(buf), "/sys/class/firmware/%s/loading", st->ram_fwu_name);
> >>> +	debugfs_create_symlink("ram_loading", d, buf);
> >>> +
> >>> +	snprintf(buf, sizeof(buf), "/sys/class/firmware/%s/data", st->ram_fwu_name);
> >>> +	debugfs_create_symlink("ram_data", d, buf);
> >>> +}
> >>> +
> >>>  static int ad9910_probe(struct spi_device *spi)
> >>>  {
> >>>  	static const char * const supplies[] = {
> >>> @@ -1561,7 +1876,25 @@ static int ad9910_probe(struct spi_device *spi)
> >> ...
> >>
> >>> +	ad9910_debugfs_init(st, indio_dev);
> >>
> >> Blank line preferred before a simple return like this one.
> >>
> >>> +	return 0;
> >>>  }
> >>>  
> >>>  static const struct spi_device_id ad9910_id[] = {
> >>>
> >>
> 
