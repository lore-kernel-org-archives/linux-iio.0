Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AEF4CE67E
	for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2026 13:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790776304; cv=none; b=tP9J2PJBK5fIvKdiVopueZIVC7orOuuarUVn0m6qjDViukOiLiPgDtDqpRZkAJraLNX3MppfCkaeS8TylZa/XvuO3UD80WKU6hvWCFRJeVX8M8AnB6u802M9hrh8eP5Cl1ZLyF+d14IdTf532sABeincQIucjG2BrzGna8Z/wcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790776304; c=relaxed/simple;
	bh=+IoKX1KNbarkITcQFvbLMQ1gUQCVJ7Te+5R39GBUc8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RpPpzQEolb5bMuYUQXJ50jx538X+tEyytxwPCwVGo/N7AZymnclZ8u/5r/pA7NsLIZcKyg0LV9iWrMUAw0GeF295qkTyNatT+2/eMirfpoDyWGEH8jS72x4IPSe7YBGc3b5s7/+rw33MqeQVgF16gEXiqOgRNHUdCFqoDodjlrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UEpnlQWU; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEpnlQWU"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c29703cb796so751805166b.2
        for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2026 06:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790776289; x=1791381089; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+IoKX1KNbarkITcQFvbLMQ1gUQCVJ7Te+5R39GBUc8M=;
        b=UEpnlQWU19HF2YQ6+h1Givg34TXiGLbOzW1X5TAsNO+qgXzB6nlp2+YxTAQxC6ARu4
         mb6qF1MNsm+V+GYxSluqFvxyUHo8eu0yNKt73JIXRIOMkZ+EB2uYThMEFDlFO61lcsAo
         pJ44SFDQjoW6QEJIXDVzQcoTuEcupC6oRSSxbpLjvt/a9+yZbBeIL0UzzdI+TxB2FxnN
         Jem0kiPwC1pjSEjmXkgPlwKJjR8ZpCy6rVAgP+fz6TzeIOimk4wqkPq4ouXLeoVLvxa/
         SujQkiAwU+FFBJICduj0DBRHMCZ+7PP6kKnVISR4/4cTNeFgQ6bSmCeXDfS+wZZxBYXr
         BuEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790776289; x=1791381089;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+IoKX1KNbarkITcQFvbLMQ1gUQCVJ7Te+5R39GBUc8M=;
        b=rQwXqtl1pgHTwK98CUoWFviQ3H3GHpHfOmQxFv57PHxVhg74YNAluyc1zYlbyocKlu
         GxGhtMK+kSfnyrn8W9FqPIz6RsL4NjFn9OQr/Kj7wH3eI5K4iSfaB307NcYRoNdY1wS1
         OgigK/qGMWfANWvLGEUoDobrBSFcwTTnXYYcxbXsgk4XhAmcYZAg9ZgWwz/MLWir1o5R
         hwyoXhJ2PvoVyc0lR6OzlPj5adJ/K8X2/I05/MomheWK/HpPUxasZFG7GQKloDlfjLS/
         gczMg2oCAY5RTwuxCzZeyQGZw/+Rz5zj7t9YEHAdmriB0N+4rV9ZOUE8mVpRg18DCtiz
         dQpA==
X-Forwarded-Encrypted: i=1; AKwUvBy3fXq+aqX1Alh+Qul2L7+z0MZYKK2MExP/8sbNq11kiI3cpsvnTpFI/6gMwuApd+1e+JcbipTB/5Q=@vger.kernel.org
X-Gm-Message-State: AFuF++naoZ/qrYW6YftSqpeaPt0teDA+2HCd6gdVvwqG9tDqXROgzV8j
	Nu7F1PtA4gCRwOe9aWI4Onnx7/m3pCUqhClI2XcZKhvj+gTV27ciuuKe
X-Gm-Gg: AYBFou0nJJaJ+46ueZAwfRYaXnV8+YU11k38tKQ+aOhuv/we2ULFhTqj1jWV+dHIBnf
	Lo28FdHuYWiTbVRH7x+TpMsXvcmBQX+9/Y8G6UkHq7PtyCQSbfG+MGaQ7UT8BJU1Vc/AJJGBm6K
	5Jw3Nrk8dMootgUNDHkBPk+FVFvEOLe1HxRXQ4GnO7NBjX54QxnvnZUpJQa2AbVfn/zNcHMzCMt
	My54lRMZY/WMXQ2waVju8MerED971PwVxZAbDtIBVuN6p2fbK/NmHWAydfF4xStyyXXxfFHYSZW
	efUYLND/IgjSc+IHwTaCaSYZVtHfC1xVhTheYn4kWTI2fQ92EmN1VdSpMDTw2Ph4LpXCDaUbZ1m
	jj3btb18qsXBnzAJiDLk1l8j376nXuVqx9D3wIeOROmYc/ve4uFRzVj7+H6H/WUXVgrKafTcrfV
	peULiZDD/0S7B8SKWEpYp/sxs1kztz2XnWN6JTRbrEe0T0zd3fLddhdn/aIClnFSSNuMqu+2ojH
	WWEG66QDoPrxHT3cNxwKGEty/D816MrtaI=
X-Received: by 2002:a17:907:3f95:b0:c26:1648:a06c with SMTP id a640c23a62f3a-c2e23de0396mr133226666b.39.1790776289360;
        Wed, 30 Sep 2026 06:51:29 -0700 (PDT)
Received: from [172.24.138.145] ([137.71.226.102])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e31d867ffsm5456466b.59.2026.09.30.06.51.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 06:51:28 -0700 (PDT)
Message-ID: <a57399f0-4c47-4b32-bf6a-7761d9b57320@gmail.com>
Date: Wed, 30 Sep 2026 15:51:26 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/5] iio: dac: Add AD5529R DAC driver support
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Janani Sunil <janani.sunil@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Mark Brown <broonie@kernel.org>,
 Marius Cristea <marius.cristea@microchip.com>,
 Marcus Folkesson <marcus.folkesson@gmail.com>,
 Kent Gustavsson <kent@minoris.se>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-spi@vger.kernel.org,
 Kent Gustavsson <nedo80@gmail.com>
References: <20260715-ad5529r-driver-v6-0-cfdf8b9f5ee3@analog.com>
 <20260715-ad5529r-driver-v6-5-cfdf8b9f5ee3@analog.com>
 <arzTnOTaL97GudZM@ashevche-desk.local>
Content-Language: en-US
From: Janani Sunil <jan.sun97@gmail.com>
In-Reply-To: <arzTnOTaL97GudZM@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/30/26 11:17, Andy Shevchenko wrote:
> On Wed, Jul 15, 2026 at 01:41:08PM +0200, Janani Sunil wrote:
>> Add support for AD5529R 16-channel, 12/16 bit Digital to Analog Converter
>> from Analog Devices.
>>
>> The device communicates over SPI and supports per-channel output range
>> configuration. An optional external 4.096V reference can be used in
>> place of the internal reference.
> You haven't added a given tag, why?
>
> In any case I have noticed that there are a number of (not so critical) issues
> are still exists, so I have to withdraw my tag. But please, answer the above Q.

I intentionally did not carry the Reviewed-by tag from V5, because V6 included substantial driver updates. I should have mentioned this in the cover letter, but I missed doing so.
Some of the points mentioned here have already been addressed in later revisions and are now present in Jonathan's testing branch. I will send a follow up patch for the reset of the items.

Best Regards,
Jan

