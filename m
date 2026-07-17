Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFC53FA5FE
	for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 16:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784306060; cv=none; b=kGyihEDSv4gosk0/H6i/BqCPEmoHfatdkjTpK73YdYe+qrdA2yNc2stgyGs8n8EklfqLJ3Q88iMTLpmLjKAI6EdevlVyVP0G8IXFElDUUTp3N/rB5V+veBAo2UIl6w6AqLu23o+MAHSD8dFFw6Zc3SOORRlSurCkPOI0KW8pJrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784306060; c=relaxed/simple;
	bh=6wnDDJQBQfpjll1dAST5KuLlqAlQD+gfIzZDEDQKs6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MGmlppWNkVMOZ+pecLQ323HLti+ihq1IPONINT7KpI71xDMapQYY4NubAboAnYP8QF8/Vutc/zqAIQFm4FXAPfghHTYEsY+zwNvaYIzzEeGc3Q/BXsrj7/krYI0C/S/6f/oQ3Si6mqxTnn/zWyP4DhIDKww/b1Zg2OCC/Ak4JHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LetJwMu4; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LetJwMu4"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-80e2cfe6918so39090297b3.0
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 09:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784306056; x=1784910856; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SN6iKB84XjlCdyQZDXiTIhq7M2trG088S3ZqcAJw8RI=;
        b=LetJwMu4heHGTkO9n0+tizadoIYlVjFv8exTgBmshyKjC07HVJ+polcD/CB531vB2A
         KWF9iCfpo0/qOS+NFk4aDL6Hr9cV1i5TDHPHZ1dpproD6FbcWopBaAqXMfxIuQ2UPQ9S
         T2+7oHMdeoiLCnjw+eJB+Va7Gw0ov2wCCC1S8/iUbT+ODf55IV2dLyQvdMUbWuu3UAK2
         3xStBpkSevm2TAnyg8ASRtOkmNQJDovCS+lRpn5V8VWVuZCJFDTDMvh1P6hL/f8m2Qoj
         8SknQvy23JyEa/VR+y5jpxqY4kv7V0WP6Vfb1utu6puMaWfjDwFmlSML+REx3o5KilRJ
         tzkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784306056; x=1784910856;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SN6iKB84XjlCdyQZDXiTIhq7M2trG088S3ZqcAJw8RI=;
        b=kUkzH2W3oQqhADCSb3yfowOJQKvUxia4b8ObwHxPEQoP+O2b4wssSFsCNkPZ4us7PZ
         jaZEH2Nsd5nGjChg6r2RjFzy85K5IBIeBmRWVsA6X3zXv1SH9lzCOsp4qpG0C/0mN3rG
         bhSUgsvtPu6BrCut5BWl0CgZy085QWDngUVm0BrMbwdQHTtMTT/BmXpzVvMQbQBjTbx/
         aaCY4yhE9HSkbgC+/WKY/fMd93BoaFVUfJD63FqBRrIFpxf9qN8TW6fZBWuSdF01/6YW
         j12TCx9Nj+Aeu74rLIV0Ws4pZBmPmm30wZhU2o3VhGj3MJcpA7u7lBMlc/b2YhvRIa/h
         7/dA==
X-Forwarded-Encrypted: i=1; AHgh+RoIZQvHnD5xLO1NIBgRxrtnS6lc1jtrF2pnpWJ+l/mZa5X1mu0KPE9wwWlBjTokyNewiB9oWgCboDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVaYAixrVzvU3TB2OtjuboRusi+twsVmQ4Klw3u9xFj6+qZ0CT
	6jRy5AJ3pMxp5OQfRKfYe2zuQ3/K76sU+pU6+gnZlSEMZdnhu8WqaBsq
X-Gm-Gg: AfdE7cnCA8LH0SV0yz4vUy9pMlPIZIOfktMDWkY+tTSea0Lw7IQupPIWodUoiWXUaKr
	NyELPhccOCkog5MhlVUv0kvL0AZkCkkknwpu7WC+zHwQ7M5uFm0i2Bq4tUs/iziHLAf98VcTn9c
	6sED0sHSRmz2WznRz6Tzy+I8xUA3JFsdd4CylH62hPoZwHLeyeQBUsAqF/HeUJnkWergpbE0QsJ
	S+TyeTtJW0kayPcz3e+6fdmpM0aeDMJWwNeUXlxd3xCDBZ0PcbDslgvbGnP7019UPYY6x2h7Cwx
	CbftvDXVoH4PZf1UI4UUcXioZJkw7q7ohJ8QbAMSC7XWX2agNAAF6yzdu4YxDK7bV0UXH8AkCkz
	FxBxhQKJNZlbae0zrVxdgH0hOS3/djyB1l6FN9kxbJM8l4pdMVVx0tEWm1VBPZRVry+JYxvL+R3
	sRXtKV/YRL5bA=
X-Received: by 2002:a05:690c:6107:b0:81e:bbcd:f5c3 with SMTP id 00721157ae682-81ef25e16eamr11174017b3.36.1784306056131;
        Fri, 17 Jul 2026 09:34:16 -0700 (PDT)
Received: from localhost ([2804:30c:1f09:b400:47f8:7933:2105:dd41])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81efe45416fsm53397b3.6.2026.07.17.09.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 09:34:14 -0700 (PDT)
Date: Fri, 17 Jul 2026 13:35:14 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, robh@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v7 3/4] iio: adc: ltc2378: Enable high-speed data capture
Message-ID: <alpZwoau3QVPtBsP@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1784235595.git.marcelo.schmitt@analog.com>
 <564b975c2c62d28ee6733f86bd5632c41a7c80e4.1784235595.git.marcelo.schmitt@analog.com>
 <20260716212451.923951F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260716212451.923951F000E9@smtp.kernel.org>

On 07/16, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Integer divide-by-zero leading to kernel panic in `ltc2378_update_conversion_rate` when a sampling frequency of 1 Hz is requested and the PWM driver rounds the period length above 1 second.
> --
> 
> --- Patch [3]: [PATCH v7 3/4] iio: adc: ltc2378: Enable high-speed data capture ---
> commit ef54f2c79f2cac1649922032814adc7fcc5f9684
> Author: Marcelo Schmitt <marcelo.schmitt@analog.com>
> Subject: iio: adc: ltc2378: Enable high-speed data capture
> 
> This commit enables high-speed data capture for the ltc2378 ADC driver by
> utilizing SPI transfer offloading. It allows data acquisition at faster sample
> rates up to 2 MSPS.
> 
> > diff --git a/drivers/iio/adc/ltc2378.c b/drivers/iio/adc/ltc2378.c
> > index 5600c820c7f45..7d29f021cb7b4 100644
> > --- a/drivers/iio/adc/ltc2378.c
> > +++ b/drivers/iio/adc/ltc2378.c
> 
> [ ... ]
> 
> > +	/*
> > +	 * Configure SPI offload PWM trigger.
> > +	 * The trigger should fire after tBUSYLH + tCONV + tDSDOBUSYL.
> > +	 * Minimum time needed: TBUSYLH (13ns) + TCONV (part-specific) + TDSDOBUSYL (5ns)
> > +	 *
> > +	 * Use the same period as CNV PWM to avoid timing issues.
> > +	 * Convert back from period to frequency for the SPI offload API.
> > +	 */
> > +	offload_period_ns = cnv_wf.period_length_ns;
> > +	config.periodic.frequency_hz = div_u64(HZ_PER_GHZ, offload_period_ns);
> > +	min_read_offset = LTC2378_TBUSYLH_NS + st->info->tconv_ns + LTC2378_TDSDOBUSYL_NS;
> > +	offload_offset_ns = min_read_offset;
> > +	count = 100;
> > +	do {
> > +		config.periodic.offset_ns = offload_offset_ns;
> > +		ret = spi_offload_trigger_validate(st->offload_trigger, &config);
> > +		if (ret)
> > +			return ret;
> > +		offload_offset_ns += 10;
> > +	} while (count-- && config.periodic.offset_ns < min_read_offset);
> > +
> > +	/* Check the minimum CNV to SCLK delay is met */
> > +	if (config.periodic.offset_ns < min_read_offset)
> > +		return -EDOM;
> > +
> > +	/* Check the PWM periods remain the same */
> > +	offload_period_ns = div64_u64(HZ_PER_GHZ, config.periodic.frequency_hz);
> 
> [Severity: High]
> Could this result in a kernel panic due to an integer division by zero?
> 
> If a user writes 1 to the IIO in_voltage_sampling_frequency sysfs attribute,
> ltc2378_update_conversion_rate() is called with freq_Hz = 1, and the initial
> requested PWM period is calculated as 1,000,000,000 ns.
> 
> If the underlying hardware PWM driver rounds the period slightly upwards
> (e.g., to 1,000,000,001 ns) during pwm_round_waveform_might_sleep() due to
> clock granularity, offload_period_ns will exceed HZ_PER_GHZ.
> 
> This causes config.periodic.frequency_hz = div_u64(HZ_PER_GHZ, offload_period_ns)
> to evaluate to 0.
> 
> When div64_u64(HZ_PER_GHZ, config.periodic.frequency_hz) is subsequently called,
> it divides by zero.

If we have cnv_wf.period_length_ns == NSEC_PER_SEC + 1 after the offset_ns loop
and config.periodic.frequency_hz == 0 as suggested, then spi_offload_trigger_validate()
will fail the frequency_hz check and ltc2378_update_conversion_rate() errors
out with -EINVAL before reaching div64_u64(HZ_PER_GHZ, config.periodic.frequency_hz).
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/spi/spi-offload-trigger-pwm.c?h=v7.2-rc3#n48

> 
> > +	if (cnv_wf.period_length_ns != offload_period_ns)
> > +		return -EDOM;
> > +
> > +	st->offload_trigger_config = config;
> > +	st->cnv_wf = cnv_wf;
> > +	st->cnv_Hz = DIV_ROUND_CLOSEST_ULL(HZ_PER_GHZ, cnv_wf.period_length_ns);
> > +
> > +	return 0;
> > +}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/cover.1784235595.git.marcelo.schmitt@analog.com?part=3
