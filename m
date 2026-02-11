Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5223328E0
	for <linux-iio@vger.kernel.org>; Wed, 11 Feb 2026 12:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770811822; cv=none; b=V3RG0ft9Q2kRBZVnlljeHvfIBqZexJ9hB5alprAntwh9WUI4LyeElIsubniUwkUo5OrSjPnHYq3CjI0i8ImgQefxA6Z3SNXK9TKzStxMerS+iAldE8iSPY3W6y8GjoeWWBU69+3RYzb+6hvK++ZFgaDoOjZiezadDm1JOf/N7C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770811822; c=relaxed/simple;
	bh=utn3XwOpWurKgubYBtZ684X93Erh30fOChOZ829PatU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ktN3ERt6XMfLgtojUMHSlrxmuG/QocN9NLAlC5tnMsPqRI8hFMHtqJ+ICynpW2ewUTw14oUmjvzZ6fVkiLLnFbgJl/GhnBR9ptA291nGLCGPcsekC+YdnHF1Loup2Uz+xbV+KW0Yv6JU98nJ1exHeBlggZ34SoW2sNgvBsb7BKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FPWTTVV4; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPWTTVV4"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4359249bbacso565208f8f.0
        for <linux-iio@vger.kernel.org>; Wed, 11 Feb 2026 04:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770811820; x=1771416620; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qtsVjI2BnkequBe3oD3S5ISrfMB8iEq+0jmS+b7f7kU=;
        b=FPWTTVV4xEfqG805bXED60AmFv334Iqy0NYr+SbKcKzgQwfsZEZcLCrCWz88ImNrl4
         /XTuauj1wbVAJxbvgROkwrO+FXfKeblSXyJ+OgaK7IAgE5drlYG47jp7yEFWuG8W/xY8
         gvqB233+OvrevDX6nd/caQ8H257Xb6lAENC1cb0iN5FOR4DiFs8oZwhOL40MWafZQe04
         1v1uljd01joJJ24vnlmsKv+K+ww7CZSHpejVGhKyA0g50u7g7N/is67QLgapKlm6d31o
         hiTz21FEhRgwgVSR7CZNH4YytcueC9ZVTQzAb8qLMlrt0nFud5Wi61LClx7w+gkSPKyg
         0ufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770811820; x=1771416620;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qtsVjI2BnkequBe3oD3S5ISrfMB8iEq+0jmS+b7f7kU=;
        b=QoANdRZ4BbA4WwCLRSg4eHXKZq/BiSBs0Z7TYdCa0Q0lEiQoyzSzSC0NErm9d6o3yn
         Jkj+x/Ib7NJQHcOn/5/Fz087aGfN+EqPAmkVrgGvfNN8jXnKaBT6EdQ4gCD+v1OAH/VG
         SAHPz5ueiGTjDsxkU0pY2unTz5/zaSiHLQfvRSmgX3xFhxCEwMZ0PFR8NZYtzz4zTBxw
         IWfMUWOn8SGpbI5dLZSMhqOAH6G6DdKeScf/XX3vnbM22IwwU7UYgMaBdWAgEJnakL0A
         rhdp3yN4PC8NIku9+THZwQe32SKWz5CX4+auZJgQ5ClN0l4Wwjdxmp66xXCWALggqqw0
         sY3w==
X-Forwarded-Encrypted: i=1; AJvYcCWd8wOH3s4ES/FRFYhg8+RPQK2023MnyyFwwqyTUslQPqWObjj804z+WDHFcZaPybesiI5Qv8wpL5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkJXtbO4MnlwahW1QgQ82hsZ69kExLT8pLqThTeMoe8Ob/8GyQ
	Grqm8mImmQVB5kQ9vK+i1HmjFZdf6GgE7kbFifOfybzQOHTOOx3xok2+
X-Gm-Gg: AZuq6aIDPsDvzuWc1ejoJD/f15LyvfQ8iUHTElqtBbhOaYVJtaCoHcA2vfYJBdhgLeg
	F9NID68RRp1/F2y//9/j81yTNcKiAI/TP6aMX9QoFeIjvlt5T0sGmrYTizoeVv8BpJNnUtuiZB0
	K/mg/OdUO6WQOCNrmRDFDMzJXef38rl8Hq9UJtVptYyAq2yAZlHBV70mVNevs3PGBIH0H3Z+10W
	eC/Giu6DsfoQUC57c9CO0Pj0L5ilN25lMcO5f0f0bYUgbE/h6Lsv+BLYi4+A1YpNPBEQf+/8mu0
	JbdZbgMep6pUnjiV51aBQ8RT1O340DYIoc9glMA9U6TcUzTG12ayXXkx/P4SVe99HdYgOF467iP
	Ig8lElh1vCMtuicznTHIzc7X7G6XwOPb+mOR8lkoYprj5ITekajAtdjkB/GntPXiRvVznIWhYN7
	yMTofLyyLuRJ9qIHofc4IEESn68PwOkc7zdk3DsKRaL6x7Kl1melfx7/SsUZhr86jtzkniKBAvw
	DwDspE8dY3ldrmb
X-Received: by 2002:a05:6000:1786:b0:437:686d:aece with SMTP id ffacd0b85a97d-43779ed492dmr9824184f8f.30.1770811819597;
        Wed, 11 Feb 2026 04:10:19 -0800 (PST)
Received: from RDEALENC-L01.ad.analog.com ([24.206.116.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783e3a9acsm4158387f8f.30.2026.02.11.04.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 04:10:18 -0800 (PST)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Wed, 11 Feb 2026 12:10:11 +0000
To: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	rodrigo.alencar@analog.com
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v4 07/11] iio: amplifiers: ad8366: refactor device
 resource management
Message-ID: <whgxbva3eeushqmj57xsk2q5kv3pmrffu2fzgmxyynvvzb4fyr@25arbt3bqulm>
References: <20260210-iio-ad8366-update-v4-0-15505f7b15b4@analog.com>
 <20260210-iio-ad8366-update-v4-7-15505f7b15b4@analog.com>
 <aYuPhB_e14orrZ64@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYuPhB_e14orrZ64@smile.fi.intel.com>

On 26/02/10 10:05PM, Andy Shevchenko wrote:
> On Tue, Feb 10, 2026 at 07:42:07PM +0000, Rodrigo Alencar via B4 Relay wrote:
> 
> > Adhere modern device resource management with the following:
> > - Voltage regulator managed and enabled internally;
> > - IIO device registration handled with devm_iio_device_register();
> > - removal of goto's from the probe function;
> > - ad8366_remove() removed as it is not needed anymore;
> > 
> > With the drop of goto's dev_err_probe() is used to report probe errors.
> 
> I think the regulator change should be split and go before the previous patch,
> because that one affects the ordering in the error path and remove stage.

OK, that can be done, but the same way, the error check would change as
well as the dev_err_probe() args, not seeing much benefit there as the same
lines will have to be touched anyways.

-- 
Kind regards,

Rodrigo Alencar
