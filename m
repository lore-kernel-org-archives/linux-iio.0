Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA2F37998B
	for <linux-iio@vger.kernel.org>; Mon,  9 Feb 2026 14:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770647793; cv=none; b=hxqkThgCWikk1hqrEx3PX1l2vS1kdsawihB72L+1y2UIiVORcO3Wxb+6MptpTO17nvI7nv/BUxDQCwUj8K3lYsAnq2K15x9E1Saj8XzESxzbxCo5pqvk64/XvNMTullQMCPlu0VA/MUF/KNNaycXS6CUCnk52bCccD5XKkHpteU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770647793; c=relaxed/simple;
	bh=hp0VIwG+tZ4C/xAipi8SSeLZ0cZ7Avit/lMHmraD0wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KLU4pUdKgZ6e21Q7Nat1T5Rm5QTlAutvwQxFxTRoT0iC3jjrh60k0v/1mjMd643meCpP8eYdaGaVS5M8JM7n3OZQylvHVsYOjJeLEYpRHYqHVwfCR5jaNPuVu3E8wga12o7VhuxPX5GrVSlOQJ8ndlTDVUK8yvzXX95J6jhRiNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Er1I+l+i; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Er1I+l+i"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2b86d39cd50so1297937eec.0
        for <linux-iio@vger.kernel.org>; Mon, 09 Feb 2026 06:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770647793; x=1771252593; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZxW9LgCH07BdNp/H9r+dMXWuibZ85UcJq1iPgsYd5Oc=;
        b=Er1I+l+iJUM3BjJlVhftPTss6/TmesRIVac2Xmef6bX9T/tcv+tS2IMH8eNQjavIEP
         EBD1V/dfFcdgxWsKqsm40m/a8Z9G+/6g5ZbmkifWUYkXitnywRvrPj2QSugRDolFv3cz
         d2OI+VST7UFf4DguR0iHHBYx8o007jCZ8LhDjQLoaVzmAFAwO8rJNYIBcobeQZbupLaU
         LWt/XTg35I8EIgHLF92h7znOMP91zFCEeB/46ulWDFNv6ssmZXx4ZoTd9UL3Xi/6r6g1
         MXDV/Ni/AFrShuQbBKHGX14gnrwn09YW/N3aSeWr6aMsfgrJJH1cM3h2ufIo1Nf2YxGK
         u5pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770647793; x=1771252593;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZxW9LgCH07BdNp/H9r+dMXWuibZ85UcJq1iPgsYd5Oc=;
        b=iP3lvz20td23Ete5KwMz76trOPgsTcXmAp36y5yZzz9wJNSup3aDWR4f+GNc1iQPeG
         PYOVdKWmZ1ufEfjbZUqKkOh6sI0RENUqXxWqHqBp5dyRdKCMciBp7fQxNqtM10eFyO4k
         9sTW7UbcPJVmRU2JFSiOJ7CJfugV0cSUOw5/qTNlq8H6MfMbC9X2leoqDMEzsDGYmHSU
         /nMkHCzP/QW0HecsOGlxlPow+shVYQqGFQTRvRQF4sYfnC0D+tFH4T8pC0ruIY/S1UN+
         RzQxLvatsyKKVYT07lBShXH6oPSpqt/PHnhzbvgeFeICRX9Khp3KD47aXv6Ol15Lx9JV
         jNlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUU3Dv0eMJjudSnQbpYNgSVO+26MgQAuk9yHd9E3I3Qm1Rvv4mDR03/Ce/IpN0mtv1rc0HRMEgIdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfoGM0ZP1SdkuhSPGYVKTkgoGQbXKC09zgulTHmlaaXcEsMUW8
	JRQc+/KJMLNOlV6PkyItT+WVhUppOBkttcntLaaQooYItqk5VxdjuQkB
X-Gm-Gg: AZuq6aLYVmY7AwOh4buKuosATfD26OPh/iYW/UreOLsKp5xIrD6x9pzq/rxbTGAYfQM
	DOc4B29WaUiWx/WOD9+pu6stQnm0URF+BAmB7Ycbh29ErkN2ivAVI1po7PtWQnUJCBmvO9K1vMR
	b7G4GcWS3/QsxpaTNInDVuV8XbQC0jbVeAYr9HrmdtmX1XXCm0srBb54hYFgE1Quj2+ReEtkM/n
	bhguuQo+OAO44Ax91IEiVHIn7cvdJLcg8WAoilwrU27RHr/UsYKFXwJA5neBuJPJRNi7YX7yMMc
	6nJ551rykawB42aHctWxsHuTuDAP6rjq3eVtdvj9geY8f4TdV9dk481mT+qNVoU/5+86hgGC0EI
	5C4oK4euxB8FI0aEZ+RmaU8pmV4SEwuCZk/ME6awtSusdXNdfztmKCCB4nrquXKlM6ENWn1Wb2m
	lae85FxmPRiV+LE9YEOg+R
X-Received: by 2002:a05:693c:2d84:b0:2b7:b41:bbeb with SMTP id 5a478bee46e88-2b856723b28mr5265050eec.43.1770647790912;
        Mon, 09 Feb 2026 06:36:30 -0800 (PST)
Received: from localhost ([2804:30c:163a:1300:9b68:dd2c:feb4:459b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba6517c316sm3778411eec.3.2026.02.09.06.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 06:36:29 -0800 (PST)
Date: Mon, 9 Feb 2026 11:36:57 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, jic23@kernel.org,
	michael.hennerich@analog.com, nuno.sa@analog.com,
	eblanc@baylibre.com, dlechner@baylibre.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	corbet@lwn.net, Trevor Gamblin <tgamblin@baylibre.com>,
	Axel Haslam <ahaslam@baylibre.com>
Subject: Re: [PATCH v8 5/8] iio: adc: ad4030: Add SPI offload support
Message-ID: <aYnxCc1wv8MVfv2b@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1770403407.git.marcelo.schmitt@analog.com>
 <315c614e65e40634251e624d73d83fdea4c51c78.1770403407.git.marcelo.schmitt@analog.com>
 <aYiWA5ev2nPF8UxU@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYiWA5ev2nPF8UxU@smile.fi.intel.com>

On 02/08, Andy Shevchenko wrote:
> On Fri, Feb 06, 2026 at 04:01:33PM -0300, Marcelo Schmitt wrote:
> > AD4030 and similar ADCs can capture data at sample rates up to 2 mega
> > samples per second (MSPS). Not all SPI controllers are able to achieve such
> > high throughputs and even when the controller is fast enough to run
> > transfers at the required speed, it may be costly to the CPU to handle
> > transfer data at such high sample rates. Add SPI offload support for AD4030
> > and similar ADCs to enable data capture at maximum sample rates.
> 
> ...
> 
> > +static int ad4030_update_conversion_rate(struct ad4030_state *st,
> > +					 unsigned int freq_hz, unsigned int avg_log2)
> > +{
> > +	struct spi_offload_trigger_config *config = &st->offload_trigger_config;
> > +	unsigned int offload_period_ns, cnv_rate_hz;
> > +	struct pwm_waveform cnv_wf = { };
> > +	u64 target = AD4030_TCNVH_NS;
> > +	u64 offload_offset_ns;
> > +	int ret;
> > +
> > +	/*
> > +	 * When averaging/oversampling over N samples, we fire the offload
> > +	 * trigger once at every N pulses of the CNV signal. Conversely, the CNV
> > +	 * signal needs to be N times faster than the offload trigger. Take that
> > +	 * into account to correctly re-evaluate both the PWM waveform connected
> > +	 * to CNV and the SPI offload trigger.
> > +	 */
> > +	cnv_rate_hz = freq_hz << avg_log2;
> > +
> > +	cnv_wf.period_length_ns = DIV_ROUND_CLOSEST(NSEC_PER_SEC, cnv_rate_hz);
> 
> See below.
> 
> > +	/*
> > +	 * The datasheet lists a minimum time of 9.8 ns, but no maximum. If the
> > +	 * rounded PWM's value is less than 10, increase the target value by 10
> > +	 * and attempt to round the waveform again, until the value is at least
> > +	 * 10 ns. Use a separate variable to represent the target in case the
> > +	 * rounding is severe enough to keep putting the first few results under
> > +	 * the minimum 10ns condition checked by the while loop.
> > +	 */
> > +	do {
> > +		cnv_wf.duty_length_ns = target;
> > +		ret = pwm_round_waveform_might_sleep(st->cnv_trigger, &cnv_wf);
> > +		if (ret)
> > +			return ret;
> > +		target += AD4030_TCNVH_NS;
> > +	} while (cnv_wf.duty_length_ns < AD4030_TCNVH_NS);
> 
> Does the above have a side-effect on period_length_ns? If not, the below check
> should be moved up, otherwise here should be a short comment explaining the
> side-effect(s).

Yes, pwm_round_waveform_might_sleep() might round the period down. I'd add the
following comment to clarify that

	/*
	 * The CNV waveform period (period_length_ns) might get rounded down by
	 * pwm_round_waveform_might_sleep(). Check the resultant PWM period
	 * is not smaller than the minimum data conversion cycle time.
	 */
> > +	if (!in_range(cnv_wf.period_length_ns, AD4030_TCYC_NS, INT_MAX))
> > +		return -EINVAL;
> 

Best regards,
Marcelo
