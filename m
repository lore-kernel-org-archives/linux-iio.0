Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326DC44A739
	for <linux-iio@vger.kernel.org>; Thu, 11 Jun 2026 19:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781205035; cv=none; b=JAd8ZElTGwjDxtN9Nraq7RDS2G/tMrbPqsT4d0Cxsz0yycehU1guQ2MwaFh7kZnZlgLIQWe6IotWwQTX3a9O7b45DsMbuFTf3WD8ODmyNSMmfVtdAQAt5sNuMIjOnNLmfOC6vsBpA8eL+NG8m9JLqu3GTNM51uHDd1Yhbqp59Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781205035; c=relaxed/simple;
	bh=0i91wvPsoFNz5NqYStg6Ytvr9GyMmPyJSl+LIKrKv/0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qP6kC23ODAMV/zm6Z94Y2MmW/8ufH+zHAqVJlU3uPQJK1PPhtK48OC2m77RHWk1GLATWJMF0oXfZ2iYlTky3vi6eC/l0xvk3dAdzpBzSP36E1aXovwHJHta0mPYZn8AjVX4JWrUBLV0lWODzLeqJwVkw9uLWoq/BXnCje3tVfUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWryWPyt; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWryWPyt"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8ccef9eabccso13064276d6.1
        for <linux-iio@vger.kernel.org>; Thu, 11 Jun 2026 12:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781205033; x=1781809833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1akxBa9Yj2eO0ezJOdd0PYMsv5JHqMaTxTbB2PVknqc=;
        b=PWryWPytKiNqSIwCJek3s5jXpIzc8dTdnKWtrb/UsrCbVZ/pjn5/aL11z2E/lSOt2M
         CzgeSqAMUZYnFteoc7fvhKVESI0W3NkYA1MTzooNi74PnKie0Y2MH9TTW+85ctWY9SPY
         JaCOfVWroKRHIuWg6GkEJQCCvIfk3QkOWRJmV2j/f1zisD+6c/0U9qfpsys3OxHrX++d
         4Wek+hV3aohJVK6AXfZhSQBgViA9eyaFNlD8q6cT1accQEGm2mkaPJLLegxaR19vMaGY
         ssn/TUAbwNxFM1FxqE5s35SFp7S1McJygBqUPNqlnQ9W7xUHHAMtp+JoWh34mFTSI7WY
         ycug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781205033; x=1781809833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1akxBa9Yj2eO0ezJOdd0PYMsv5JHqMaTxTbB2PVknqc=;
        b=oUJY+Y3EDFnxD9XNXGiQBI66kXUOYNzIra7kkVAixNT6ID+MaHdk5PxwXOxSGdvfds
         AtljYATOwHS7sqzzHUdYvv1xdHyGobYYJ/J2KGKwqHMN+sjOH9cGw0hGiKYYuF5zlxrh
         /QQhA/i2I0r3218j2kLKO3J3OzZcAxyfYbZADmoUciUz7r3xpEObXvrToENKC9gAhjTx
         tv4vAZsIVPZugdwLiFDFyUjVqtx0oj2frZzk4/qLS4MVmu1e+XHqfLAUDm7u0GOpdXO2
         HUiI9bAB8rBcUz9sppReL1TbarILQmLVevf+O3PEHQqDE7z5WcQ2+oUeFPrCSiUTfWL4
         W7tg==
X-Forwarded-Encrypted: i=1; AFNElJ+01bcFW40ec0plFXpF8bL0FlvekN+f0FCffw+3O5gvXwbUoaKx3pjeG9oSsQW00BJdBGLeY9BFYpY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrJzAz5duBGieIaQXBnTaB74xwGt0rdlRemP+G6xrim+4a/cuI
	BKyNxf6TQqW+uaCOH9bSsDr6SL2mURTtDWx/aVyaqusVrD1gY211gzKKXVYzEHZrmL8=
X-Gm-Gg: Acq92OELwpOTHlrEmgA4W6n1DreDL7CzQSdwbR/8MCaLqavyATQlSir+CdE9NJ1L++J
	M7BZ+cU/ITdXIKNHLlI94zSA82fTLeQgGQ/E0pQ95UDTEeKzr2jQglIX5LoWacwRIk5Fd7G9s06
	0KDuCH+uiMyx1CzUBNESAml5IvqfsTcdrGlBko9SvVqGIvnc14zY53ZykiEV4ecYyb1xq/YjfhH
	1DP7CX6lTGUxyUYI0RZGYcMq/sy0zamyseckJvrbzaw/5dGUlyBPTCfouBFVFX3PIunBEyqhPnR
	DHi50c73jJlkLtlgHz6rQgbgjxz0XbBIe4QOR7lCH+pPgmOcqnYjmbjPSXRnii4oDYac2cQOmvZ
	WLONVJSC5EkiwAdjAt0+LSz/Oj/bPKN/8QYsNoTuuZSZpLy3bpqTrP2h1AiCJ65hkr1SIy+EGXR
	Znuqnp0D03iIMK+DoazQuOhg/UqEwjyfqHrEGfyfmCczsqqNI=
X-Received: by 2002:a05:622a:c18:b0:517:5f11:b353 with SMTP id d75a77b69052e-517ef177b41mr47422321cf.41.1781205033020;
        Thu, 11 Jun 2026 12:10:33 -0700 (PDT)
Received: from louisarchdesktop ([2601:184:417f:5ad5:c570:9008:5a2b:8db7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb63e594sm1333661cf.8.2026.06.11.12.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 12:10:32 -0700 (PDT)
Date: Thu, 11 Jun 2026 15:10:26 -0400
From: Louis Adamian <adamianlouis@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: pressure: ms5637: Add variant specific
 temperature compensation
Message-ID: <20260611151026.4abf8804@louisarchdesktop>
In-Reply-To: <aimvBvJp8CsNKlPU@ashevche-desk.local>
References: <20260610020458.104818-1-adamianlouis@gmail.com>
	<20260610020458.104818-3-adamianlouis@gmail.com>
	<aimvBvJp8CsNKlPU@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jun 2026 21:37:58 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Jun 09, 2026 at 10:04:58PM -0400, Louis Adamian wrote:
> > Add correct temperature compensation for ms5637-30BA,
> > MS5803-01BA,02BA, 05BA, 14BA, 30BA, MS5837-30BA. The temperature
> > compensation formula is shared across these sensors but with
> > different constants. Add ms_tp_comp_consts to capture these
> > per-device differences. Add pressure variant specific pressure
> > scale variable.  
> 
> Is there SPI driver? If so, why only i2c is affected?

As Jonathan noted, there is no SPI driver currently and the
modified function is only used by i2c. 

> > +		s64 tmp = (s64)temp - 2000;  
> 
> Why casting?

This is extraneous, I will remove it.

> Overall this all needs a good comment or even comments to explain all
> calculations with the references to the respective sections / tables
> / pages in the datasheet.

I'll add comments here explaining the shared equations. There are
also references to the individual datasheets in the constant structures
because they differ per device.

> >  struct ms_tp_dev {
> >  	struct i2c_client *client;  
> 
> >  	const struct ms_tp_hw_data *hw;
> >  	u16 prom[MS_SENSORS_TP_PROM_WORDS_NB];
> >  	u8 res_index;
> > +	const struct ms_tp_comp_consts *comp_consts;  
> 
> Please, check with `pahole` if this is the best layout.

I will correct the packing on this per pahole's finding.
> >  struct ms_tp_data {
> >  	const char *name;
> >  	const struct ms_tp_hw_data *hw;
> > +	const struct ms_tp_comp_consts *comp_consts;
> >  };  
> 
> Can this be simply embedded into ms_tp_dev (and copied there if
> required)?

Copying in ms_tp_comp_consts provides no benefit over
referencing the pointer; the values are per-descriptor, not
per-instance and never modified. I'll keep the pointer (same as
ms_tp_hw_data).

> Have you considered to prepare the infrastructure in one patch and add
> the actual compensation data tables in another?

I can split this patch for V3 and I will fix the other formatting
issues.

Thanks,
Louis
