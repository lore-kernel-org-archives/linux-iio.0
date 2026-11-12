Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794520943;
	b=meCyThpXs4fNd6uBMEuzsNoIQ2NB9tUZmme/nAxHDPd9f5tRA+QjsHYAf9IWByVnSghD
	 kTwzqnY7EttFUEXhhGvwV3M+TgSIdeeIh6sphdFH9enlwhemMgpHAEycO6TvLhOsCnNlF
	 ZXDOptVzRXsu0HYYBxFF2O5wlAB9AdxC9CI4yXaFT6526db3bYRdOQS/ASlezu5RLbI1f
	 8mAT2rBAElzSG/FtXCQuMIzSRHWsIBifPqUYjDtXAkUcV3Eq4CLxe1T0Yiad9kMJf3nOj
	 1295gkRDfduehYF6ZZ9LC9Ib8DYJvVtMxUd3xY4bV1KH0EsFehlQaIc3kI/yyFT7mdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794520943;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=KkjN1cxceCxoRkdu1/EYi0tZwQkA6fRy7dyW7MOKnbU=;
	b=lgN9Kkj14KnAQlPZZjbJeL637JTAanSfDo9AE7BgjkNF1m/bNCYTs9ApWY+5O2AXuq3g
	 xIroGh3ZdIopwy0g9hpxfqyPSTbOpGYrAWf/NuOZ2X4xSPUQZmSUZQNfj1tgAVT3oiE9d
	 OmK1pA8I9LjJDr8Z5KT4IGasdLp4tTcrJue6xAaZ/YGLoHaxVJypjsO2JsO+7bPxlNFz6
	 Bu8sNq62ouyNhKYsiDJ+xZo/yLibz1/No8++RWbaFRh38u2WgdHd3lwrWn6SZFPt4KZom
	 hRnpbp28FB4e1oN87znITh1Gny9iAAPownTAsAxSK9yzANtIYsZ3O63+sH9XyWoTj5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fTocFYkf;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FFD606A31C
	for <linux-iio@vger.kernel.org>; Thu, 12 Nov 2026 22:02:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1FFD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fTocFYkf
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso3394555e9.1
        for <linux-iio@vger.kernel.org>; Thu, 12 Nov 2026 14:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794520941; x=1795125741; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KkjN1cxceCxoRkdu1/EYi0tZwQkA6fRy7dyW7MOKnbU=;
        b=fTocFYkfKMlUAQIrkpvAt6eSIdot2UERMCemdv1uXBFQSWdfL0xxN07LmxCJrn7ppt
         9jaiDix5Mc7lPeMNttuBtDDgA7xRy6NirAbZg+PE27VmYUkbKbKEY4azF8LI79V8YMG0
         40pS7WX3Cynp2kEgjegcPQ6riZQ1/2UhmabGH0yZ2E6UQI8OVyT9xrWHyjKL/xhiL572
         d758c992jPKsARShBAzvi3HlqZ+IlhV8spirDHQFHWvOHoLBGUs1sbXgASQfang9fs28
         40K2WYmWTykI7YeAaTdtHFpez0L/dZkfdomSQ48GoLBiadoB4wgzKH9N2q1f7y0WHAgr
         1h+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794520941; x=1795125741;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KkjN1cxceCxoRkdu1/EYi0tZwQkA6fRy7dyW7MOKnbU=;
        b=F+xx4EGvtrLVNxkKfj6qEoykGEW0kspwKcUUmG9azqWSIGiVzZj49SA+GPOOsjaXs/
         OfLIHFGdQ5FVkvgidSbpVlXFYcDTFxnt8VviET2soWYIQyS0NeTYdwSxYwtXaWFFRBZI
         ge+DnQneFgL3aitI/wP2d3aqy2D938QGUasF+UQgDeWc2IFSTcLaZ05k3s2Z44CoR6Me
         sWPkTGixHAUWCdHjVR1wT1Cdcy7c7X3A5KR/+QA8PCmsL/IDHWqRGxeDh8XtvRr8Zsep
         Hc+IQ1GgF0f3f3lDmkPBOHBXWAg+Cbu59XqAW7LCtvoOCtw9c9OtQUsF7nZd3UXGl2RY
         fOYg==
X-Forwarded-Encrypted: i=1; AL+hErF7HdNIH67RuYt7Hjw1L8oXjPhfPJIpkekZS26k1mJDnBZ3oQQ5/aQ+y2sCiN1h8ht3OGEAkUfhzKA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/YS4O0MAzV5r4I8N4lCHoIpIadj1rA7c25CxBi4HBANapLj1Ja
	gIFE9REUmt7UzmSqRma4A5N7MKb7HUizmTjpqs+nv1KSeBmSqj4LUgZt
X-Gm-Gg: AYBFou3DEAIlKkyMzJmOcFt2U5JonPfEG2OueZgwe5ZwvnA0JyCIEY//QFR/F5B3Z8f
	ZXTqMYPENsy6EcDCNWqN+n1aPN0N/rTX688HKK/jqOBiYhjxBGResqGcL5QpPgaSxI0IqiqbJzx
	IBBRwG0Rh+mfzvDeXncyBEtgGXTbRwgBw/S5bo1SxXJnR9Ja29bxaO0cy1yARsPU8tpj9m9tYRS
	Nu6f3r2tlTrIRBS7M/f6w47dOilXvfoGOsl2SKf0YpIrfqT9RpCGpKdL/Xjb1WfrYcJwghjBZmN
	f/Vh/4pEn+c9lAfUcmBHrDjx9K61z3pRXK/gsERRqgdiEK4N0qGSyZNM+JnuTj2t8Jsf/CCtKCa
	BnHFskhEW1en621b3ffqiXuSWYPlv/lSSqJwXpB50PX+PIyZRuPG74/FuZGMue77OS7+bcE/ZfA
	YWbP2ZD+mf6/QOTlW1Yl0NjPvoAfrRtGZZ0+J3jmVQJBfeJXHSCftXvkehHG3FAAaUWDqFjwVlP
	8b9zWAWJ87Q4/LK94ctdE7ocw19aO1PLKgP4yJF0B6XpjlGWBgu6K6dzaY75XlU6r/WqaoMD0ii
	zfGZfd0yToDA+7xXA3fat5Xh6y4FN4dZstebezU9ZSNmOD1HA599N1OTaC64XbAJkg==
X-Received: by 2002:a5d:5d07:0:b0:48f:e879:5890 with SMTP id ffacd0b85a97d-49c727d1ea8mr1719571f8f.32.1794520940752;
        Thu, 12 Nov 2026 14:02:20 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5d03b10fsm1796040f8f.1.2026.11.12.14.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 14:02:20 -0800 (PST)
Date: Thu, 12 Nov 2026 22:02:18 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Di Wu <diwux@google.com>,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 bleung@chromium.org, groeck@chromium.org, tzungbi@kernel.org,
 linux-iio@vger.kernel.org, chrome-platform@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: cros_ec: use sysfs_emit() in show callbacks
Message-ID: <20261112220218.1adae5e5@pumpkin>
In-Reply-To: <20261112020439.37b0da70@jic23-hlaptop>
References: <20261111072608.3490763-1-diwux@google.com>
	<avR-KT-6e77EexZn@ashevche-desk.local>
	<20261112020439.37b0da70@jic23-hlaptop>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Nov 2026 02:04:39 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Wed, 11 Nov 2026 16:39:37 +0200
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> 
> > On Wed, Nov 11, 2026 at 07:26:08AM +0000, Di Wu wrote:  
> > > Replace sprintf() and snprintf() with sysfs_emit() in the sysfs show
> > > and ext_info read callbacks. sysfs_emit() is aware of the sysfs buffer
> > > PAGE_SIZE limit and is the preferred helper for show callbacks.    
> > 
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > 
> > ...
> >   
> > > -	return sprintf(buf, "%d.%06u\n",
> > > -		       latency / 1000,
> > > -		       (latency % 1000) * 1000);
> > > +	return sysfs_emit(buf, "%d.%06u\n",
> > > +			  latency / 1000,
> > > +			  (latency % 1000) * 1000);    
> > 
> > As David said, since you touched these lines, make the less amount of them
> > while at it.
> > 
> > (But no need to resend, usually Jonathan is kind to tweak this small thing.)
> >   
> Done and applied.
> 
> 

I just looked at that line again.
Why is it multiplying the remainder by 1000?
It could be:
	return sysfs_emit(buf, "%d.%03u000\n", latency / 1000, latency % 1000);
if the 6 digits after the decimal point are required.

David
