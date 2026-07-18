Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E841E7C2E
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 18:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784400452; cv=none; b=rHqEwDJPgB1KrK+LXwiHytbFuxADSRa67XZO0oF6XBJUmR8znYZKj6WErm5yYeF6HSieKn0xOHWy8KwerlNxzOBuY32Q701usujG8NO7fNWUSIzG60MBO/QeznYpzsVMpYRby9yK1/Gpjrckm1wpxUh/Zfgj1b1+rYZgL4iuXRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784400452; c=relaxed/simple;
	bh=5brdqZ/1wXfjtic17d235LNB+dpZfhc5OvtCZzsQ5RU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CEc8NTPLirmyml0hYD4CaqczIfi400iZf2sKAjPlGptrP5jbLyPr0o9wSh5WnWm1x5l0AVFeJllAcyZ4TFjSpp+lbmbzSNQY/ERIeSL1NLkUfeJXBdzRcMSG9X4NMA4DtFWiLrD9LWZ9KV5vJ6VYee+QcqOAkhd9lIfqsQYX1YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=POG7pQ8v; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POG7pQ8v"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-668432d50b0so943540d50.1
        for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 11:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784400449; x=1785005249; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fQTOmrHG5pvHqSModWaQQhiPltxOaTHtUmOHNGx1d18=;
        b=POG7pQ8v3KB/6vyUYyUYCxySdycEoBZzCBU2w0EMwOKUa5lE4Ewy46/ksux2jM4CzA
         aycdIaP/DMPLOH1lFGbB375owKzFI2cVYRI9r8QmaaDGo2AYAlKmUrznKcbpdQCtXRPO
         grwIO3fdv926fDBdLX/HIAkmogvd7RLEyIZhfE52ud1AtAg5iVcr0fD+nK26HEs1syAp
         AoRf/nJE56qG/4c1wyWroCrimPBStMPS4h+VRbVZkbrhdCMDCUS8N51RNvpG3WTIK4kp
         Kqp6IC5psFKHnN4P5QJgvTUYTFnKLlOGHQY8F3oB/ORd+l0KRlye1dsWDO6GWNOPWa9z
         jO8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784400449; x=1785005249;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fQTOmrHG5pvHqSModWaQQhiPltxOaTHtUmOHNGx1d18=;
        b=KLFmlrs7VVObcvSkw4I2YnBJyaBjDOzC3B3pNcyG3qw2JL3UPOwdnu357PgxFk7Q8E
         H3JtNOvwMdGvfnkKQwdL0HuAZ2e3oUMi+TyHTpclZ47m5XnSPvowzqOaHiKZ6MUsCeV9
         qJ/uWaLZjNfIZE8ckDJc5QnumPj8/prtNTf4SAWv9lGUwR2+nOR5ANCm1FPXQI7XO/Y4
         5SKtVWVNphxAp+ZNXmKg83fDpp/z2x9TYMUxoQkZMnYkPhSAn23uHOmCfWmJglUJHC3h
         5d3uEwzTiJHgsPOYMT1K2AnVi2JErA0VbSecgfygH3zm7szyhqxmcFyOLQp6YOCGc0pO
         l/Vw==
X-Forwarded-Encrypted: i=1; AHgh+RqEzUwGXjyFvvOHDu0dHvRbQzOXniys9mK5d7yEkZ9NGkaxUDDFpJCa39TAAnc5qgx+N3WD79rev/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJH6b3H9EeGeGLJLMyj19bR2a5zkKKOtsJH3/swh0h7ytiPXFR
	8Itd41A6sybATOe7p++Xf/+MpU2srjAtjKPZJ0DCpSiekNp2ehKRpU3c
X-Gm-Gg: AfdE7cnJ4F0yhiedBUYK25VtnopqGOeqM7s0kNyiegA/QZzH4h4d1mkokTX4/QX36Jb
	zsP4jCEtcTsJyV0qWv4jSWKg9ZYmSxo2Mq4qR5QmxH9bEmtNF5A/nHpFSAOWiCss7YCR4/M0sac
	l68v0jSc79pmbA6lxHEFgNF97TVTmz42mqwMw2DbvUMQbBYDtQ1W2Jo5VRZjFXho1mjTx+8nD8x
	5Pz/8a0hqA8tdEtoCYmxzPmE9+YKy6XA0H3jXLFxxbOknurWkgsAhsKicG5LAwVNEAwJ2DsKIq9
	CTthwu5SjM8zhBaSkNCmOFLuHZ+t7T5x2QAk+bgEPgH0PhBNdCfE75VUyG4qXQeJv7ZY/0RHnzk
	LRzFHSpgfeWp9tyHMSsyzX6xgp32rzB+xwB1Wj29zz6UXlxVIPiKEdAJNr4/Ydl+BF8cwhxmb4/
	541rtPGcHu3Q==
X-Received: by 2002:a05:690c:9a8f:b0:7ff:19d6:74ee with SMTP id 00721157ae682-81ef28589d4mr26330087b3.33.1784400449216;
        Sat, 18 Jul 2026 11:47:29 -0700 (PDT)
Received: from localhost ([2804:30c:90d:6100:8a69:5cf5:f1f8:a1e1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81ef4279508sm33890157b3.26.2026.07.18.11.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 11:47:28 -0700 (PDT)
Date: Sat, 18 Jul 2026 15:48:29 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: sashiko-reviews@lists.linux.dev,
	Marcelo Schmitt <marcelo.schmitt@analog.com>, conor+dt@kernel.org,
	devicetree@vger.kernel.org, robh@kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v7 2/4] iio: adc: ltc2378: Add support for LTC2378-20 and
 similar ADCs
Message-ID: <alvKfTS8Kj1MF3db@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1784235595.git.marcelo.schmitt@analog.com>
 <5108c89986ae8723139419058db1b2f2e74daff6.1784235595.git.marcelo.schmitt@analog.com>
 <20260716212838.95B3F1F000E9@smtp.kernel.org>
 <alpab2gBs4nPDU5g@debian-BULLSEYE-live-builder-AMD64>
 <20260718024628.3e2872ca@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260718024628.3e2872ca@jic23-huawei>

TL;DR: Will switch to voltageY-voltageZ ABI.

On 07/18, Jonathan Cameron wrote:
> On Fri, 17 Jul 2026 13:38:07 -0300
> Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:
> 
> > On 07/16, sashiko-bot@kernel.org wrote:
> > > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > > - [Medium] The `LTC2378_DIFF_CHANNEL` macro defines an IIO channel that is intended to be differential but lacks the `.differential = 1`, `.indexed = 1`, `.channel = 0`, and `.channel2 = 1` attributes.
> > > --
> > > 
> > > --- Patch [2]: [PATCH v7 2/4] iio: adc: ltc2378: Add support for LTC2378-20 and similar ADCs ---
> > > commit 5710d5f25b45906977e2522567c1964b1d3219f8
> > > Author: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > > 
> > > iio: adc: ltc2378: Add support for LTC2378-20 and similar ADCs
> > > 
> > > This commit adds a new driver for the Analog Devices LTC2378-20 and
> > > similar analog-to-digital converters.
> > >   
> > > > diff --git a/drivers/iio/adc/ltc2378.c b/drivers/iio/adc/ltc2378.c
> > > > new file mode 100644
> > > > index 0000000000000..5600c820c7f45
> > > > --- /dev/null
> > > > +++ b/drivers/iio/adc/ltc2378.c
> > > > @@ -0,0 +1,416 @@  
> > > [ ... ]  
> > > > +#define LTC2378_DIFF_CHANNEL(_sign, _real_bits, _storage_bits)			\
> > > > +{										\
> > > > +	.type = IIO_VOLTAGE,							\
> > > > +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |				\
> > > > +			      BIT(IIO_CHAN_INFO_SCALE),				\
> > > > +	.scan_index = 0,							\  
> > > 
> > > [Severity: Medium]
> > > Does this macro need to set .differential = 1, .indexed = 1, .channel = 0,
> > > and .channel2 = 1? The name suggests these are differential channels, but
> > > without these attributes, the IIO ABI will expose them as single-ended
> > > (e.g., in_voltage_raw instead of in_voltage0-voltage1_raw).  
> > 
> > For parts with multiple inputs and configurable differential channels (e.g.
> > AD4130-8, MCP3561/2/4R, NAFE13388 [1, 2, 3]), the voltageY-voltageZ ABI helps
> > clarifying what physical inputs make up a channel. For differential only parts,
> > the ABI seems to be flexible by only requiring a 'consistent labeling' (either
> > voltageY or voltageY-voltageZ IIUC). Will set the channel with the differential
> > ABI if maintainers believe that's the best way to have it. Might slightly tweak
> > the channel macros to keep .differential = 0 for pseudo-differential chips
> > (e.g.LTC2369-18).
> 
> Whilst I get your point on differential only cases not really requiring the
> specification of two inputs, I think that does provide a simple indication
> to users that they are differential channel.
Agree. The first ADCs I've worked with were single-ended so having to provide
the negative input when working with differential ones was something noticeable
to me. Though, one applications engineer once called me out for the
voltageY-voltageZ naming arguing that a differential channel provided only one
input to his application and thus it should be labeled only 'voltageY' or even
just 'voltage'. Despite understanding that argument, I share the opinion 
that an indication of differential channel is helpful. Anyways, besides the
possibility for application to display channel names differently in user space,
I see we now have .read_label so the whole discussion seems pointless.

> 
> I would prefer that we make them 'look' like differential channels so make up
> a suitable number for the negative side.

Would it make sense to adjust the ABI doc to encourage the dual numbering for
differential channels? So I don't fall the temptation of single index in the
future :)

Thanks,
Marcelo
