Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA852949E0
	for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 16:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784306229; cv=none; b=NAglDXAxhm9iqhFjt2rDihsBZbuX8gtZcPvcCyrRFIdYaDloinii20STrnc/A0VmWtRx6bAsENHKw0ZoN0OO9Z5V+HYq5B6vbNhjJTBEJVL1yyTzMwjG1fWwBh4rh5uVPKeJahYo1Zyqd9mBg7u4FvL1DwiMQWHsdTQJOAB0PAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784306229; c=relaxed/simple;
	bh=tGwzjYdByfoFaIh4ZwoemqEAXz0OnUd03AbzuPL+9IA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A11N1CAskrtaSP1O6qWy7Fb77sbGeFxwq1mBdJ2YTVUqe5D95lMlZWd90F7mVU9osDW8nJbfiStrBuBONMKQNmwX69IB9PssmdzQT0JzV4yFQ5e8fSpLD/boi8iSzY0xbBqDZPsIf4jXe4a/AFdUhI98DBNE5Duc50gwH7BNIn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MdnY9X4k; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdnY9X4k"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-81ef8255cccso5499957b3.0
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 09:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784306227; x=1784911027; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UnLMXcEn62d3oMMgJrrwZa8KdOiLTui4IgFDQmHHq2Q=;
        b=MdnY9X4kK+T4/S8xOTzaGcXE9dlGmdzSmL05goIEj6wxQ31qXSVnZ4Uy1QMoKgYO80
         zcsLn2xF8Kn6zdZqDvWAV/wLGH9lszWgjXIlnWOudlgDx9ArctXvtLwQ3ozzXUlhBF1v
         Qsiq3e/N3pmCxPPMUV8dg/CkcXBbU9a8aV0Tvl+W5IeL72o/hQc87Zf9SlYtki3TlVG0
         araiNYR3XkLMp80xYF54ymSkyVjfEhNF0BdM9Ktgr6vQEU2ehG+R8pfsLqjbk18dgtVX
         KVEdsZwnGXxEk+raHLsBBVu+Qzux/mZfpHa7riZ0bI8aHZSGX0QvYegeMgyXa9P+LHUg
         3/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784306227; x=1784911027;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UnLMXcEn62d3oMMgJrrwZa8KdOiLTui4IgFDQmHHq2Q=;
        b=pZBzwSD6JCDyagzJdiTM8EgzI0I7Oii2URmzpl9TM8ZWfU+eArkkyLiZUq9kQyGlg9
         ZiFBixx8GERWvK1bRYj9BqXrG2y+5CzuzM6OK6TFVcTnF2uORMu3MoqVO6vkpzAwfORC
         TNIFLfDcuoo4Zro3v7WWhlN5HOoj6SDiqSDSNMdrl8efZXX+C91oZJ5sIt6wqRbNvY5f
         tdchxsRff3Stza1NoL/dQZujknFiVoYvDEKkBQd/mfXNR8LQcjcK6QKLJjPUJe3UBlqM
         PLC73ksCdnH1UXzev8C4aFOJKdmRckArwp0gEWNXSalQnpLykMKqysYmvMWPL0qniqzL
         pljA==
X-Forwarded-Encrypted: i=1; AHgh+RpLZXVsr8RRhl7N53W4JlICUSqikV6eprhnsyGSfBUKblDVk3MYibj+C+YCKaCVQYx2EvlBoClTSZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZIrfl11qUa+GxRLcJZ9huWN//wSXy5JtoqatXk4UIOlj0fcCs
	RxJ8Lm838hcb8ddrucsJnFv2Z9WLMMxZus20pp1wgmTGFVMbRshur8W7
X-Gm-Gg: AfdE7cmuQHBAyTQv0YOZ+LCFEwP2Dcm/lw9hi0Wh2/rvNXyApeNQCZ1wnNznKTAYfWl
	H2R3mcx4AWp+fuZqj1giKoUwBUNOLHPOzseaRfuQE6Pkc8N0E2rLdDO4aPs/gnbqtK+b+tCiaHA
	ubcurroTp7jO+eimDDJME0ITdf1FBU1+2xHVuBJ/RDnqBohwZ/SPB2bCkEWlgvqW1JfN4/BCMF1
	ZzdesY+Bhf3nVBwljHKGe9HqTZxRdkbg2R1hpXdF/IZb1tACSFHsDzCie0xBHeal94zp5tXmsmL
	+zf8I6582G7r3GLKfgBwtjGXbqs2lHsPkuwls97iMOyNqi7HAfUc3NyYDtakKXtejPQLg4TU/ie
	8LYg3v4MpUdKt5ch5uGb3uQx7jsmypuATJQwifFEXPwGS5oS6vlLmrzpRgYzFdoc7uwcGgz6mzQ
	U9mvYJN9eMGqE=
X-Received: by 2002:a05:690c:6888:b0:81e:dc5a:a4f2 with SMTP id 00721157ae682-81ef26a5f43mr12401847b3.41.1784306227436;
        Fri, 17 Jul 2026 09:37:07 -0700 (PDT)
Received: from localhost ([2804:30c:1f09:b400:47f8:7933:2105:dd41])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81ef42c4ef3sm14017747b3.40.2026.07.17.09.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 09:37:06 -0700 (PDT)
Date: Fri, 17 Jul 2026 13:38:07 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, conor+dt@kernel.org,
	devicetree@vger.kernel.org, robh@kernel.org,
	linux-iio@vger.kernel.org, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v7 2/4] iio: adc: ltc2378: Add support for LTC2378-20 and
 similar ADCs
Message-ID: <alpab2gBs4nPDU5g@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1784235595.git.marcelo.schmitt@analog.com>
 <5108c89986ae8723139419058db1b2f2e74daff6.1784235595.git.marcelo.schmitt@analog.com>
 <20260716212838.95B3F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260716212838.95B3F1F000E9@smtp.kernel.org>

On 07/16, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The `LTC2378_DIFF_CHANNEL` macro defines an IIO channel that is intended to be differential but lacks the `.differential = 1`, `.indexed = 1`, `.channel = 0`, and `.channel2 = 1` attributes.
> --
> 
> --- Patch [2]: [PATCH v7 2/4] iio: adc: ltc2378: Add support for LTC2378-20 and similar ADCs ---
> commit 5710d5f25b45906977e2522567c1964b1d3219f8
> Author: Marcelo Schmitt <marcelo.schmitt@analog.com>
> 
> iio: adc: ltc2378: Add support for LTC2378-20 and similar ADCs
> 
> This commit adds a new driver for the Analog Devices LTC2378-20 and
> similar analog-to-digital converters.
> 
> > diff --git a/drivers/iio/adc/ltc2378.c b/drivers/iio/adc/ltc2378.c
> > new file mode 100644
> > index 0000000000000..5600c820c7f45
> > --- /dev/null
> > +++ b/drivers/iio/adc/ltc2378.c
> > @@ -0,0 +1,416 @@
> [ ... ]
> > +#define LTC2378_DIFF_CHANNEL(_sign, _real_bits, _storage_bits)			\
> > +{										\
> > +	.type = IIO_VOLTAGE,							\
> > +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |				\
> > +			      BIT(IIO_CHAN_INFO_SCALE),				\
> > +	.scan_index = 0,							\
> 
> [Severity: Medium]
> Does this macro need to set .differential = 1, .indexed = 1, .channel = 0,
> and .channel2 = 1? The name suggests these are differential channels, but
> without these attributes, the IIO ABI will expose them as single-ended
> (e.g., in_voltage_raw instead of in_voltage0-voltage1_raw).

For parts with multiple inputs and configurable differential channels (e.g.
AD4130-8, MCP3561/2/4R, NAFE13388 [1, 2, 3]), the voltageY-voltageZ ABI helps
clarifying what physical inputs make up a channel. For differential only parts,
the ABI seems to be flexible by only requiring a 'consistent labeling' (either
voltageY or voltageY-voltageZ IIUC). Will set the channel with the differential
ABI if maintainers believe that's the best way to have it. Might slightly tweak
the channel macros to keep .differential = 0 for pseudo-differential chips
(e.g.LTC2369-18).

[1]: https://www.analog.com/media/en/technical-documentation/data-sheets/ad4130-8.pdf
[2]: https://ww1.microchip.com/downloads/aemDocuments/documents/APID/ProductDocuments/DataSheets/MCP3561_2_4R-Data-Sheet-DS200006391C.pdf
[3]: https://www.nxp.com/docs/en/data-sheet/NAFE13388.pdf

> 
> > +	.scan_type = {								\
> > +		.format = _sign ? IIO_SCAN_FORMAT_SIGNED_INT :			\
> > +				  IIO_SCAN_FORMAT_UNSIGNED_INT,			\
> > +		.realbits = _real_bits,						\
> > +		.storagebits = _storage_bits,					\
> > +		.shift = _storage_bits - _real_bits,				\
> > +		.endianness = IIO_BE,						\
> > +	},									\
> > +}
> > +
> > +#define LTC2378_BIPOLAR_DIFF_CHANNEL(_real_bits)				\
> > +	LTC2378_DIFF_CHANNEL(1, _real_bits, (((_real_bits) > 16) ? 32 : 16))
> > +
> > +#define LTC2378_UNIPOLAR_DIFF_CHANNEL(_real_bits)				\
> > +	LTC2378_DIFF_CHANNEL(0, _real_bits, (((_real_bits) > 16) ? 32 : 16))
> > +
> [ ... ]
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/cover.1784235595.git.marcelo.schmitt@analog.com?part=2
