Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D3A34D389
	for <linux-iio@vger.kernel.org>; Thu, 24 Sep 2026 13:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790255974; cv=none; b=pKYl3gLPFB7cKBHPptYlUCgWUArFhT1bzdVDX7ud25aIuUjjdan/kEuih31AgColsSFKCqyNarDebWgYOqu8IQiKbrVM3HRkbxOvpX7Qt8TNKfdujQdOeWrrBPrv7hNIdGR7AY3K4YwrMakYfQcKTC27nKsjXXmuGIj1zz6oMfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790255974; c=relaxed/simple;
	bh=Hk/Dt2k01tdiGA5+qEU3xv0Qf6fMEQqec9bNw5PVAdc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nCzSxuj+8Z3sSpH6s9EgDVEaexmKvhetLiaDwJY92eDMR1fOijeiP80U58N1kwJ7hJ8roQbWkS+P136EDRCYSbLC/kqOpY8d8wkJkSuWdWd26PXv/JOZIwC9ruZAKMyT/cPYii08hToubwzeuUy6Ps3368hRLR+Xrq7gB/n1sDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DUr+OGQq; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DUr+OGQq"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-48583cc7ab1so1186704f8f.2
        for <linux-iio@vger.kernel.org>; Thu, 24 Sep 2026 06:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790255970; x=1790860770; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZltodKwVC/1L3oIflvyPLA+UFOrcHNlQS3o0eumbalY=;
        b=DUr+OGQqke8is/gL/fzwJHu8yzI8YygZraZCvtPfCFZclLPijTp3PRyULpvQQI4y24
         kCmRe+QCMVq1hmFQUo2rxVHzze6/yuzGq7eKIVuNr8fqmMlEd34nlEtElWBMQmziMQce
         2dwqQuiMIvgO2g/1TZBZEEoiPCaPHThieud+/8D1k5z3+WxzBjJ/+oGOqnqMtakmZLlf
         VTI4AD7OeVCtfbOVd+fqjHF1KFjWJOhWrnhFdV3OkWtBZzsAm8YQlLYmN/x9665vro80
         Pvz3mfbPgrh7V0xyrMDbCcs3Q3emQVCbXsHSAjcva4VLLuy1npNFZKT8QL3UL5iey2Qe
         WBVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790255970; x=1790860770;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZltodKwVC/1L3oIflvyPLA+UFOrcHNlQS3o0eumbalY=;
        b=FEBXXot5krhvgzM2hlx/MUyY3ytgLNLByfwqfmt7R9GdFXlSzU0P9vnA3vinEjBvYq
         OC5YPnlyyquw89GaLBjYOECKqkfJYZ3MGmKgkUN87rcWcvveRxM6+zfEW3y0MWV5NlCa
         ak2XWo9qIgT6s+F8ULGR0mik/k10Dwbo2+nQjKEQFsIkB97ghBGMlwEf56cXYiwoShTm
         Ud6pMyMojYHcA510W1h6mumA+DTP61U/GaRB4eejr9Xla/nXKpgQRXthiIFl4JFME7Ij
         TbT+fExNBL2jK1WKm6Cx+w4nu+lKNrEWDY8aBjske7v0WxA+b/lOHPViMsf3zGo+tytT
         s8Lg==
X-Forwarded-Encrypted: i=1; AKwUvBwSsj76UntEnbARDrS32/mLDaQEu5wpCuBrPFWJXb96I0k99Bo7qTQ+/H8gJZE+XAUTWoyyA7XbQz4=@vger.kernel.org
X-Gm-Message-State: AFuF++lCkzXtBjUr9sjz9tqfUvIUw1/UguvAlgNAcb33Ba9jFS7zfdwR
	31SLxIAWSfh39bwxF/AUURITsxgGMXoB9P6kFq3gGt4Ibo877ylKLhlK
X-Gm-Gg: AYBFou273I4A0x9k1GBv+bc+a0iBvNedbp32UFshrnxxOJ1cfdWfaU4iZcwwjMjZjgR
	h/swAvsNo+Vbv/wRylvB8dBtbDsnxQrXVAFR6hSmoyVsb2KF6ycnkSbKfJ4QdD4EJIde7hLSIw0
	4Rwgt3T146807/mIugquh1TqCPmlyNcaArMhO9VHeTa2KrmrbAh6xzSpGbKI5fkNK1l6MDHSx2m
	dF/UMsZsViXY6E2VJMg2JS1HVw9zFC26zryKGdPt7B9dLRl0CpWTVYtt9IH05Bp+2aKm2fHk3BF
	0dXg99GPKc/ENzhd3zSoZ4mvktQW1D8RVSBk+E/fc40/k4+oe1eglDHY9WxbH/BjF/9lU7F3dnB
	u8tACPr+TZVtOUo0xcLsz9x9zEwRvjp7/B9+avaMm6Z7CA6N4ceEzIjIsjAhsd7hmJh9UVCFaOh
	L9eVm3L6BbxoJFjncvcoDvXuctuh1z39I2W6LrZDHcOPlG+wZ21P+b6orKAZHhzKVTV3upYsUsh
	nz+01BwDoSBNA0nVkoU6kH2LOnTVnr+nm3lcqcAL2UKNA1acL80bhcxe3WvB4DKf3NTBhmclyK+
	Zbd5KyuBGkJ67Rt6fU5dFn0YncES6N4DLkUnqUoqhjtWOULABLlWm/mFUdCB4gRQwIILy/gF83A
	/OG7CDpUvnop/YBPyT/WFYe2SiVDpC1pJDAe4mCRtkM+I+D5B7pE5G8NYPAwcxqVckbFE9+23Fa
	Qq7En8
X-Received: by 2002:a05:6000:610:b0:488:60ed:a359 with SMTP id ffacd0b85a97d-4887174be77mr4666700f8f.33.1790255970289;
        Thu, 24 Sep 2026 06:19:30 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48868486408sm13384846f8f.9.2026.09.24.06.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 06:19:30 -0700 (PDT)
Date: Thu, 24 Sep 2026 15:19:29 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v8 2/5] iio: dac: mcp47feb02: protect EEPROM store
 sequence with mutex
Message-ID: <20260924151929.000008ec@gmail.com>
In-Reply-To: <20260924-mcp47feb02_refactor-v8-2-17dc2ce3485e@microchip.com>
References: <20260924-mcp47feb02_refactor-v8-0-17dc2ce3485e@microchip.com>
	<20260924-mcp47feb02_refactor-v8-2-17dc2ce3485e@microchip.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Sep 2026 15:59:20 +0300
Ariana Lazar <ariana.lazar@microchip.com> wrote:

> Move the mutex lock into store_eeprom_store() to prevent race conditions
> when reading volatile registers and writing them to the EEPROM.
> 
> Fixes: bf394cc80369 ("iio: dac: adding support for Microchip MCP47FEB02")
> Closes: https://lore.kernel.org/all/20260819125128.970911F000E9@smtp.kernel.org/
> Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
> ---

You're missing a Reported-by tag for Sashiko, but perhaps Jonathan can
add it when applying.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
