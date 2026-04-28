Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D0B3F9F32
	for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 10:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777373027; cv=none; b=sFQh9gavMA5hNrb13/+gMWt3hAhW9XhrzhrF5i7pPdy5HLacqz66AMrGIPGXY3GnT2iwDea4fGdTmHmaJPl9qfYmBnoFrttMtcSCu9Aqceed8Gn+V3+pwXwYESqgsA2vRa3imikHsPWPvM99DIest9NTSGq7tAtrtaTeLDUKpEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777373027; c=relaxed/simple;
	bh=Txo9jXdDRugPyX7qmDybQ2dYpzzLy0YS2OMMBLInikE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RiKCgGR0u29WYd4hx8Byvkee5VhAk5yjgxAmRFYyiBKQt4bX6MSX2kviXWCMRTB8p/CnNdc7qP2ipaexldAoEYx007PakePnzVaxL9o+4qFEjOF3Iyizp9KYXnq8dWFmEfFisYKbAu+j5c4GFFwTRODVyOnV+LdQUSXzX2X4a2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OnXstZmN; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnXstZmN"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48a3e9862f0so60193065e9.1
        for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 03:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777373025; x=1777977825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hKtRqSF01B3I4gaZJfxuG2QF2TOpMdK++wbIpuZOUFw=;
        b=OnXstZmN7ww1Q4bhga8AwQWndl6j+ndOBx2NRQaG/ke7OEbOxNum8W/rv6iVgWWpsP
         q3CqBLQEPXY6iz2D7jDqte1G8jU5tZRYGnO5sYLmLOYq0HhrVh8lUNG2Pa+PTDRUbBj8
         yXvz1CKuvbjoMO/5hlzvifIjmBs1huNuA2I2nkMOI0UGUJStbkpc26sEi5r1jR65caUI
         rKz1BFO0+/M/uhxlM+PjQdZhsnYgbUuAwIfTbMeQZ7QefPDTYw6nsVY264kH03ze1LtD
         lTRdJn7H0otmTRynmseltG+hfSWaQ6x3nMXcRRDxxFzlXhbdE1cKgLGYcmyphB1lBzLY
         ZXsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777373025; x=1777977825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hKtRqSF01B3I4gaZJfxuG2QF2TOpMdK++wbIpuZOUFw=;
        b=s/q56upO5m49FR6ewCHRqGWKgmcAgeutoRLNF+9JJ0Gxb36IcjRgxOrwjXmvuLAuJ8
         MVqnHW8AEmhayeIqygApe84F0N+wuKkKaiYOw0TEQ0iFOvA8kgLoeC0IdTeQw/aF9Gey
         6PgcYmbAvJZaD1/+A6s/JyT6VdsoZcoRDdcCe1gT11veK9fM7eqIugEZRoX2IEuTFVSS
         /w4jQa4m+qzVrjjgBGnlbHBIVL6JfSaOK8M/eWaktPuO0YfcGwZX2Z4bKUJ7f4jGqyAY
         vfVPPcCOowjjsYmFH4Flqs4/Dhyj8/kovFQ8S62XkxFJ7Je3Nm8cYAZs17zlOyT4ctem
         C+eA==
X-Forwarded-Encrypted: i=1; AFNElJ9bCeLWaH82WIAdKFcsovsDKJzOVbnqnj1j2IE/L3whmVaYgVwsmhWe7p8wroY1KTl1W1fOhxCfSxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPyBa7MuPPFVcI50oVyDQf9Zdh9nkPve8OoEkcRX8A9AaS6+Ar
	Q2SaxxDvLXCsrJhUt+UBwrROT93/u9kNJ/Mhvm79zcGV5QomMehYQWOZ
X-Gm-Gg: AeBDievAAXodCxo9t3cHX6MfY7wdip5m2k5qyckggoi/lTYdaitrTpvaB0+HVMEwn2Z
	QVV197sHrdxeL+eLgkaFl7pyo/pNYpIyOKY8y6gszlcTWYesCbQIcdvBxFvpXKDKdhHE2dbUIqj
	HyAV8LcVVLFuyMgXJk+4S/Z1L27E8/T1/AEwt90tztbLpLN4WYV3OCpUt6GaZGSjnkmXIDe9Uco
	1C6I5PhbnZBEav6Ro3TXh6O7eB+f7mse/4X73CSau/O3ffJsFgk7nz62JKok+29nvhnba4NysIH
	Sb/X0n6c29qGfO+9hi4BANPHgACzEsG5BET7i42+E9dYXL37GsASjuFnay16jMGbLH/JQZlYpCG
	g2NBNxPWzBAcww1K8yGjywtKyBUQ1NRgPPPAUBw/QI1GVylCkudWcT17S0er1ibdi13TVHai2AY
	GPAxn2xsQ5CT0g35hnil9xtszjzwvMt1mFbim+YLWKsdTfPtjIJK0CU9QWqQsyOCpwBsPHf2IW5
	mA=
X-Received: by 2002:a05:600c:a08b:b0:48a:53cb:8604 with SMTP id 5b1f17b1804b1-48a78a536acmr28625155e9.14.1777373024680;
        Tue, 28 Apr 2026 03:43:44 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a77af28e6sm41696855e9.6.2026.04.28.03.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 03:43:44 -0700 (PDT)
Date: Tue, 28 Apr 2026 11:43:42 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Yury Norov <ynorov@nvidia.com>, Thomas Gleixner <tglx@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Andy
 Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Johannes Berg <johannes@sipsolutions.net>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Ping-Ke Shih
 <pkshih@realtek.com>, Richard Cochran <richardcochran@gmail.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Yury Norov <yury.norov@gmail.com>, Rasmus
 Villemoes <linux@rasmusvillemoes.dk>, Hans de Goede <hansg@kernel.org>,
 Linus Walleij <linusw@kernel.org>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Salah Triki <salah.triki@gmail.com>, Achim
 Gratz <Achim.Gratz@stromeko.de>, Ben Collins <bcollins@watter.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2 7/9] wifi: rtw89: switch to using FIELD_GET_SIGNED()
Message-ID: <20260428114342.0d674fd8@pumpkin>
In-Reply-To: <afBdXj_9r25Ssnz6@ashevche-desk.local>
References: <20260427214127.406067-1-ynorov@nvidia.com>
	<20260427214127.406067-8-ynorov@nvidia.com>
	<afBdXj_9r25Ssnz6@ashevche-desk.local>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Apr 2026 10:10:22 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Apr 27, 2026 at 05:41:24PM -0400, Yury Norov wrote:
> > Switch from sign_extend32(FIELD_GET()) to the dedicated
> > FIELD_GET_SIGNED() and don't calculate the fields length explicitly.  
> 
> ...
> 
> >  	for (i = 0; i < ADDC_T_AVG; i++) {
> >  		tmp = rtw89_phy_read32_mask(rtwdev, R_DBG32_D, MASKDWORD);
> > -		dc_re += sign_extend32(FIELD_GET(0xfff000, tmp), 11);
> > -		dc_im += sign_extend32(FIELD_GET(0xfff, tmp), 11);
> > +		dc_re += FIELD_GET_SIGNED(0xfff000, tmp);
> > +		dc_im += FIELD_GET_SIGNED(0xfff, tmp);  
> 
> In the same driver the GENMASK() is being used, why not  doing it here while at it?

To me those bit masks look more readable than the GENMASK() calls would be.

	David

> 
> >  	}  
> 
> ...
> 
> >  	for (i = 0; i < ADDC_T_AVG; i++) {
> >  		tmp = rtw89_phy_read32_mask(rtwdev, R_DBG32_D, MASKDWORD);
> > -		dc_re += sign_extend32(FIELD_GET(0xfff000, tmp), 11);
> > -		dc_im += sign_extend32(FIELD_GET(0xfff, tmp), 11);
> > +		dc_re += FIELD_GET_SIGNED(0xfff000, tmp);
> > +		dc_im += FIELD_GET_SIGNED(0xfff, tmp);
> >  	}  
> 
> Ditto, and it even looks like the same piece repeating twice in different
> compilation units of the same driver...
> 

