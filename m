Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8DE435A8A
	for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 13:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784122181; cv=none; b=hl6mIGV79k3fVnDsJFyA6m8K3FzJxdZY5vXIhEM+B/Lf6K6zar2wg9VoygyxRbeFxa1rvA3jt+n2FTaIg3+3SyJDiDaIkf3WrjYPlk3qhWnNFPNBmB5HC1z7WdRjxH2lRSOoCQ0JDpYa86mX6NhDPmKYm6d0xCHhCmZsPGv+Vqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784122181; c=relaxed/simple;
	bh=zRo/gK16oMS7vWD/0v0ZdzYrGb0S0hZPcGmBlokvCc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pXy5oqREK3vYEXWGab5p8RWCZ1tCcfZXYth7z/xmBQs4Jv8VhHz9MnPn6CiIGmmOhHBDgbK2NZvX+s6iYlZ/OvhI1CCMjFz+DuZVlJtCdEKfCexDXf4daZ1rIYP0lyho1We7eUXXIBQBceW4RZKMgpWTa07gz+2BpGt4mFMYDEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hPR1zZy4; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPR1zZy4"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493b27c7451so8442325e9.0
        for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 06:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784122176; x=1784726976; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fC/uQJ/wM6LfyAr0O1pyfwfICQNJXf2TkvnQK+M76HI=;
        b=hPR1zZy4M3LuHP21XWihI6AeAL8VIXcmNwNUtnN4SUCZjQncROFRPqgAzQvhlEoYeQ
         lP9tlVKpieD9v9jHgPk8VuthTpRQvi5qMu1PdT689AOe4zbBdog/hcs/uQRaAnhnuzeb
         JUW5pxBz3pabKUBzx/fdiAFrY+RVOJsL2XfBugyy92sFye9UvotJXkUHFL4UQ0J1fzkd
         nUjJQVY52tDwbCQiKo43QMWPch0IxZp75S9PgxnbHV+M/qY55UQ9OJMnVYZzANry0fIX
         o3wLCNF5QULucWjeTj63b6tCYbqx9FC0PUMJhVAwqBJJuNrnK3Hfl1rFxdHtNLcughx2
         oM1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784122176; x=1784726976;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fC/uQJ/wM6LfyAr0O1pyfwfICQNJXf2TkvnQK+M76HI=;
        b=in3qxXlidmd6zffNVmWQQoLnjDNK4IKrapw5lxoXEJnYDIoY9uV/agZCvjrgpweOVI
         1FW8FrM/xavVWMg5gFwcNtDvjpnAhrN4IQy+Nj5pRjaCX850TRoXrrEm3DMyc8a6klLd
         bZI738KaA0OFFYxDo4z+a30YuXo8wUmd4OBVkLZnWdbNLO0SbBvoSfm3hXelZhhp2V2c
         YuqPGtjGDJVkeF50EssaKwPTLwkdXMb9g2YxSAsEYJe94YvNKORQpAIP0CPASSHMqadA
         bpe0OaQArPJzoDtCyZRkzujhpqOjOXfnX9x8fg1Mo8U7kaqetK995HF1rqkxBthROe13
         xFEA==
X-Forwarded-Encrypted: i=1; AHgh+RrH/JeVdfNNgN6ENib/tuN/yPypw/JjCMuAttv32uBWnfnvaBO+O9m5OaPnm3N6oIyTsjFnmA3+CLA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxaEwl/xDYm2Cr15+/tNUxiOgnzlql8DkINNGmT5TWNrZTN1+H
	EjyLJYABrw3yXZ8VF6SGWC01acIwvAEKTqFOAsq8zEPFDJj3Qqb96fKT
X-Gm-Gg: AfdE7cmlMoPdGUWtHgw+8+rVW5VuJvVf8neIAfp2FSZAjBWJei/nTx0sXyAdr51MfmZ
	sEZvoXg0JJ2eKFcdZpaVVyr87Z6XBt5wC0JMhXbt9CXGVSQU7cdK8dZlunLskqC779MdXaWfVjk
	/Guw7UT6TZ5U+71G9RghRpzqoePIrEH12uCDoi9DycrLrU91ayNz7dErohLoW4Hne5v495Zfmxb
	EXA9A5nZfDu7BEKGGAJtdMyxYaDBXlgWL6DWJOyL74E50n0IVYyZQ0l1ZJbDyU/pojSAcOMKFp7
	tUtr1YdLXXZeGm6Ltnu+nEbO00nGNKF3BqaehS2HisZIhqoktf6yQ+Pq2j6zIVp0dfz6J+/Dzl9
	wkdju612tDs9lJN+gebBRC2Dt8lUeg7iSGOUzELpAnxCKfTWnZ2WBvjHScH7ID7ZJu9Xk0/tdiY
	pLkT8XjXXOkSM93p7+AB3WD+lJsgU=
X-Received: by 2002:a05:600c:4e16:b0:492:714d:8c4 with SMTP id 5b1f17b1804b1-49400818cd7mr135805335e9.11.1784122176062;
        Wed, 15 Jul 2026 06:29:36 -0700 (PDT)
Received: from NSA-L02.ad.analog.com ([137.71.226.102])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495087366c0sm274958745e9.7.2026.07.15.06.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 06:29:35 -0700 (PDT)
Date: Wed, 15 Jul 2026 15:29:32 +0200
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Janani Sunil <janani.sunil@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Marius Cristea <marius.cristea@microchip.com>, 
	Marcus Folkesson <marcus.folkesson@gmail.com>, Kent Gustavsson <kent@minoris.se>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Janani Sunil <jan.sun97@gmail.com>, linux-spi@vger.kernel.org, Kent Gustavsson <nedo80@gmail.com>
Subject: Re: [PATCH v6 1/5] spi: dt-bindings: Add spi-device-addr peripheral
 property
Message-ID: <lpbqk3wv6emhdtxhnczrgufzzxprcfpfgenfepnmzhzfj3b3ci@rdphuko7ikti>
References: <20260715-ad5529r-driver-v6-0-cfdf8b9f5ee3@analog.com>
 <20260715-ad5529r-driver-v6-1-cfdf8b9f5ee3@analog.com>
 <1c4af9b1-9937-4cbb-b57f-52ac575b8b89@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1c4af9b1-9937-4cbb-b57f-52ac575b8b89@sirena.org.uk>

On Wed, Jul 15, 2026 at 02:09:19PM +0100, Mark Brown wrote:
> On Wed, Jul 15, 2026 at 01:41:04PM +0200, Janani Sunil wrote:
> > Some SPI devices support sharing a single chip select across multiple
> > physical chips by encoding a device address in the SPI frame itself.
> > Add the generic spi-device-addr property for describing these hardware
> > addresses. The property is placed on the SPI peripheral node and may
> > contain multiple addresses.
> 
> This really isn't a generic SPI thing, if nothing else you need *far*
> more information in there about how exactly this would be put onto the
> bus.  If it belongs anywhere outside of the specific device's binding it
> feels like it might be regmap.

Just for some context,

For the analog chip, it can share the same CS line with another 3
identical chips. It has two pins that depending on how they are set act
as the device address (so only one replies to a given transfer -
naturally the peripheral driver needs to setup the correct transfer
and that depends on these pins setup and hence dt property). 

This property reflects that. Apparently some microchip chips are doing something
very similar so Conor proposed a generic property given that we would have at
least 3 users of it.

- Nuno Sá

