Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555FE3290C2
	for <linux-iio@vger.kernel.org>; Fri, 24 Apr 2026 21:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777066641; cv=none; b=s12gaKZGCNPl4BMaTd+UKHTLxrpv9b9x7g9bOElOgOQpxiHs5zsolpviSJLrUpSPFvqlB4Mfe1siv3Az9lxNkvTE0dFVdxd4bVqkVIwVWehbryCusz0O46jnJVWUbLR0dXcnm9a52IFP9rsC8zFV+5f9eTNNJga6ArqZbv7gTRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777066641; c=relaxed/simple;
	bh=id1+Z0RiZnu9fcpdygHTv8Hyka13BoEKIX1ryJU4/AU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LWgOttN8iAyDeGUDxa9MRISTEd7NqL58aSZuB0VqJOu8HIZ8nfEGh6lssiedju0GXogdOiJRkMWHasn5XLANVHEfrQM1jd3jRZssUjWMH5aEr5GCK1zIALzfPdZCDoLP/crIO5twTxRfqIwqJC9OD3be7txlsT2xdU5+b5Be3K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=elJ7JsCX; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="elJ7JsCX"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48909558b3aso78431705e9.0
        for <linux-iio@vger.kernel.org>; Fri, 24 Apr 2026 14:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777066639; x=1777671439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ykeieCQiiUZi3J/2eeufITWyJmr5d8BX3l3RZUjInI=;
        b=elJ7JsCXqJWdvJle66uJiCMSLgrZivJZQPqvHT4akq6ynIrF3JAgq4mnxu4Uldqux4
         o3I/nDQBUtCVvt/YtDSGFbETohJ2ZKIonzDsMw9xgSt8kO+SzM2fWx0LjlOUr3kIj2bI
         4sVcyluttCkHiI0LgAq2e6JWRgrZOA7/u98ec6iic+yaYZo76QRDrYhwrNHAGgYj01pG
         oZ2caMsOXZdOic6AzK/dGarNuw2sMbil2PLjwEw/Jp05/QMgNPdjWS7mf9smswjbZ0z7
         F7vNG3QDUs4jgo9/EXZWksIJO1YeqOJbBuBmr68UjYC5LQrSwPvwQ6I5lykr0uVEtJU/
         RlOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777066639; x=1777671439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1ykeieCQiiUZi3J/2eeufITWyJmr5d8BX3l3RZUjInI=;
        b=JCkuurm2XVVsXdRngQk2A6dvGaVk7yA3rCT/gkio2Lvm5Lblot/uS+dvRtoJyeGq51
         vug044Em7IRDzKEXoPQ0fkGzUQutQCkhAB3Oie4FuzcUA4I/3OM6NGOOno0+7XZg0Tl/
         Sl9BdDTHtdBz+LH7xBEx6iMGU4t4gGrJnLKMtUSeNUcTkVv6i3FFRHRoJMMZAo6caygu
         ATa+UvUPPC5OVHkMGhFCZVrF4HFIKGpOrDGyh5BliNR8vVcMj1Dkqn0uA4rwGuuZFFtC
         hcH39X3O+MJ7g8roYspEfl4rj3CR/+0WSPC2yE2xCmVlxGn1tMM8b3HKvAZMO/PD5173
         hMqg==
X-Forwarded-Encrypted: i=1; AFNElJ8rFk6wkO7m50lF/dp81p0UYo2C7fu0Hj0dN4wwXmelVvZuseR7Vlkr0J9JH9LVEhzu+PAuJlEHu2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpeqWycckeZy8EpeJzaPBoaHPKKS7gGY3SmO69O4Ai5xSaFax8
	WC7Ey81L0q2WW1Ky5nbYFCSenAwVCujvglUWUuKbEjJlzGRnoN6AH6zB
X-Gm-Gg: AeBDiesNI8dWQXIo87zqoZgsIGRXCcpda2CYI0lCb0Dfz1he51hCP3+zAtNwIr+y1rl
	llElBezKGggxw/CGudqaCNJF+t6vmiRF95hhJM+f09nE3KPIwYs76E2L7wnkFFBjbio+sM7eJ9w
	Tw0sD6QrCNVaFrwz4+jG7IcH9pQQjF2CEpdoi2oF00qMZuKTXpUu42asMccdaEVzUGK53XLy9Wz
	ADVRpgcGtGpNQ2lrM0ZFEwtWlo9t59YLvkojpfsslrSl9Nkl+N/gZWoYj3pk7/TivsouniFiGqX
	2f5G3Mi3HNgqPfmegrtdnoyRVIeFIuJbBCrLryySnylfaAMiByshk0dH/7oqI1zKrqRLN8ew0fh
	dflUWpwhJrqiD5Vy46DJSaNsSvovzNSLOF2VCjrzbOPTtAOWTa3tVaCmaXZu+GGwpk5EvfKeoxT
	O633QcM0V2P8w0/v0g1ER/GZMGKnz/Qwzu1FSRRJ8Y3ja4zreubspcOaz6Oq1Zl6ggb+DMLuyq2
	kw=
X-Received: by 2002:a05:600c:37c4:b0:48a:5501:7995 with SMTP id 5b1f17b1804b1-48a55017b71mr283475335e9.18.1777066638544;
        Fri, 24 Apr 2026 14:37:18 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a5aa3ae83sm424493425e9.12.2026.04.24.14.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 14:37:18 -0700 (PDT)
Date: Fri, 24 Apr 2026 22:37:15 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Yury Norov <ynorov@nvidia.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, Thomas Gleixner
 <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Jonathan Cameron <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
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
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 linux-rtc@vger.kernel.org
Subject: Re: [PATCH 1/9] bitfield: add FIELD_GET_SIGNED()
Message-ID: <20260424223715.077288e8@pumpkin>
In-Reply-To: <aeub59FBHbCy-KKP@yury>
References: <20260417173621.368914-1-ynorov@nvidia.com>
	<20260417173621.368914-2-ynorov@nvidia.com>
	<6170788fcab2ec835597e3d7411928d36850c20a.camel@sipsolutions.net>
	<aeub59FBHbCy-KKP@yury>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Apr 2026 12:35:51 -0400
Yury Norov <ynorov@nvidia.com> wrote:

...
> > Any chance it'd be simple to generate u32_get_bits_signed() etc.? Could
> > be especially useful for le32_get_bits_signed() for example, to have the
> > endian conversion built-in unlike FIELD_GET_SIGNED().  
> 
> Maybe this:
> 
>         x = FIELD_GET_SIGNED(mask, le32_to_cpu(reg))

But if you are going to follow it by:
	  x1 = FIELD_GET_SIGNED(mask1, le32_to_cpu(reg))

you really want to to the byteswap once, best as:
	reg = le32_to_cpu(struct->member);

	David
	
> 
> Thanks,
> Yury
> 

