Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E8436F8E6
	for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2026 15:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790780479; cv=none; b=jr/OP/zi7DuHuQiTkBd3zoU1dx1aOUh9TGEV2Jmv4qblK6KvA6ps/VG4V4k0Gi8ToJlJZ9mDWDQHEv7nKHLjiISKCFsTkENVO94FrD56K4MQDOg0KkieOxIN29WV+60n7HM28nlj5oll1ho6ENgDsO4/OIN3ic0GkMMEqQ5KdHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790780479; c=relaxed/simple;
	bh=JD1fgY+7J4x4sU5fNLsBwey7gYe20nmvoZ5i5mL0c5k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VB1SzD3v5lCfV7OObD956te2fhomskFFTuHe7ZG9eegN3SlqLiU8B7+9+qbVhm9uqcs2LtvFSH9dASacU2gKZdnyWv4T/qEVIIIHbeygRDhHex5qsj/23Xi3z2xJdQUc+EV7uadB6fFlsaMLfxWwfFjHXmeNw8jzUfplQeI//eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I56aTj2f; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I56aTj2f"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d391aso41793915e9.2
        for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2026 08:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790780472; x=1791385272; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AFMWPn5IoBx9VRgYwRavNR0oKcAnfF+3nBU45SDbhVg=;
        b=I56aTj2fFytE/XlxHxTk/cMvj1IGvSqcWGDE0mbwMBxtJG5rZCdSorZZ3mXhbOTDnl
         JUgA/AmAhCiLtovV95XlnLgkFsQQNw4zAAlOZT2wylGahRcLqLTWQwu9qFqnMKrU83ee
         60qfnpfiZsaPpqLmxItW+aRB4SLSTT92pL+wxmPYU21MF3ZrHLE9pXpfgT1xbevaxbph
         Z8MxW9NtuPi3jpzQauMHs4a5mNe6NarDg5c9fC133aV9XLvDDda6XnWWLgaW++lHlC+2
         PMjjeEuHKyFZqnDxZ+pr/vOIyX+wvNr6aNccrGWOfWuYvi30+K+GO9FIBsju42UAOsF/
         z7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790780472; x=1791385272;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AFMWPn5IoBx9VRgYwRavNR0oKcAnfF+3nBU45SDbhVg=;
        b=ldGhg82seTOpQ7It4lwKamYe+WekGuymXtTSs2/6LRWFgEziJClXvkrWsP5h7RblIe
         tn05Yn5dS77+PsrtitiOY+29fTbbGOgVeekQb/nlGqFeQwnYohhb8Fd+jzcVftK8XM5+
         aAQNOvTlBWJ04595PfxCnnJlv4RtcyL9p71UrfZqqivBpc6Vx/DI/+oE1o0CKHaYrrFZ
         Y1+pkqCtu7sgQ019kipO7dYkIQgeisGKps3HHP+PhRfVeE/kUzlcGO6FyLEFzYynCk03
         Qzv8xHffFKieUNNO20N5GpYwxpTciZD/vkXgviFePE9IDjLv9Ercni79Tsw2HQxnQc+9
         CMTw==
X-Forwarded-Encrypted: i=1; AKwUvByXb/A4IgsdEOI0JZt9ieoSayPDj18eM4dzxXOmEmSMpOmugpPelcp8juNsLsoVppeRe7R4YCZMxPA=@vger.kernel.org
X-Gm-Message-State: AFuF++mrglmTwWBmGAvKlLwTelwROCqRBVJPfE2tJNvLsFSftjEzQdnv
	HoxpX67yn4ojFSywK3+rb/QeCiOPkNfBQNeCSZpmaaRMaGnkhQXXHFX1
X-Gm-Gg: AYBFou22o+HavOAaYBR4TYbR0TePLzCwMy0JQp4LUUJZBHhLwDypgXkenBOZLPG6UIe
	2waQJy7tIip7PbDvp540aCKtq64pNBcMA+Z6RbvaTZmTHTaddzQQSylc4vKfa8cjyqetYFzlvo7
	sMNPJv2/yxN/ATUZ9ijSzSuk+5S24IMOS1fK0hgsTtVnFiWU/FuUhuRSMcE6A+Q5RsCFTP0nm8B
	4EZnaizOflSxCVJ79NhNBNQBIGGnLz1QBhqtmAw5ecCvMkvAVRfkhNI4bPJZCLfWGHNp68PWZvR
	mXOlZgDKhzlg+cp6Z2rytW7Bt8ZZr9JAAw/Ffvnc+uQ/yzzwU5WAabAqJwltmEB9swMLoEZtwGf
	zA65v3O7c2E1PB1wGq+Crx/Hyo6f7mTtYsVI2kWAS8lD7UVyDLthj5bJqI9auGv4JPKqPW9NJdB
	patktppf0NAbzxyhJ/liVTFeB/WGfFP9/PSO7qh8CFJQqMO0T5ZHnjmOgt2DcV94rsYSXsKnPPV
	FZcWCT6xgL+ipezO3BYUIh4mkOAxB2d0PUtdVLV93+OZ/qaTti1sWI+bUmkOcDHQCnznS9zAYzc
	rKPD9tBeCMHnL7AkLzMw9H7t3F5u4b1bti92bGnSa9KMmVFW/0t/teIAsX1cZgtdab9sAXzGt/w
	iyOf+gTkD+I3IDMpyScPCzGhZmDb/4AZzNnUX4ihILZ9vWp1GMqyVwroTQ2kLA4sEGKCR78qd1x
	tOvdYg
X-Received: by 2002:a05:600c:3144:b0:4a0:1c0e:b136 with SMTP id 5b1f17b1804b1-4a01c0ec65fmr23274685e9.29.1790780471473;
        Wed, 30 Sep 2026 08:01:11 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01ccd1566sm17376225e9.2.2026.09.30.08.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 08:01:11 -0700 (PDT)
Date: Wed, 30 Sep 2026 17:01:10 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "Maxime Coquelin" <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Marek Vasut
 <marex@nabladev.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 Cheick Traore <cheick.traore-ext@st.com>
Subject: Re: [PATCH v3 06/15] iio: adc: stm32-adc: add vreg enable option to
 manage diversity
Message-ID: <20260930170110.00005b71@gmail.com>
In-Reply-To: <20260930-adc-stm32mp25-v1-v3-6-406834430d72@foss.st.com>
References: <20260930-adc-stm32mp25-v1-v3-0-406834430d72@foss.st.com>
	<20260930-adc-stm32mp25-v1-v3-6-406834430d72@foss.st.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Sep 2026 16:18:27 +0200
Fabrice Gasnier <fabrice.gasnier@foss.st.com> wrote:

> Add a boolean (has_vregen) in adc configuration structure to prevent
> setting the reserved bit (CR_ADVREGEN bit 28) on STM32MP2 SoCs.
> This bit is present on earlier stm32h7, stm32mp13 and stm32mp15.
> No functional change intended.
> 
> Co-developed-by: Cheick Traore <cheick.traore-ext@st.com>
> Signed-off-by: Cheick Traore <cheick.traore-ext@st.com>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> ---

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
