Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786563E0250
	for <linux-iio@vger.kernel.org>; Fri, 24 Apr 2026 14:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777042261; cv=none; b=sBnsMnsXJvVgqcacfHaSs3nzmFMnym6OZubyhJvoB/9MUv/1oOz3pO7My35VkybVcwZFigf6VBlYNryP4ZILRooZtGSnN5e6h2tgcbz0vONtaGbjjzCI3lKI5j9OvXdz9bQ1oP4fQTWqGHQ4jSqlNEwYoJurlKXwpc1ERyAPZTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777042261; c=relaxed/simple;
	bh=5DpfGg/7I3GkVZMMzWWKANoH36KXXpBqp0CbqHEpqqM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GttOr9LtJBsWreE01z2i5tn6GeVzusc4r4FNiOgzrcIyYiA+O0gDe+onkwXYRHU2SW7cCpbaIRwRDXVwahnsm1QgPBOgCNGlFiOQuLRRCryqmf0PD0k0tryhkLpI0yGqHVE31r2mbxNr6U/3krL1nbNqgmpx1q2R4/Q0KxQLEK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d8dBtik0; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8dBtik0"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-6221c7251d1so439679137.2
        for <linux-iio@vger.kernel.org>; Fri, 24 Apr 2026 07:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777042259; x=1777647059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SBAWISZQQ83B65zp3ZGw7r9K/PhyBwFKKHiTM7zEE8s=;
        b=d8dBtik0Wi2WX9fYplTr1J5vYxjM5ADq55TEHUXUwHS9NwhvPg+t7YdNG4txUCB42W
         KMc6/OxMWVZuVwojSfwW1n3d59v+hXy92Djl6DMDzFeK2STgOEJIZ8uKl+9dRsAgYRRz
         wyp/mnlhIqfrVPRpaPeVdFdBIsGnVo2MIBmMy4np5tEDBf8kXG4AoIq/pa41xyzHYzuE
         gCEFsLIDufzX9kbBUBmY6iBcxl2l/gg2kikD0Z2iutF/wOzDE30FeT5mQLyxKmnm4lFn
         ugu1XxES3ZuL0syK7bBbnm/eZu3hTlReuc8RMc2h930+SRHIzcSztqI1FIC08bxxJZWI
         RCpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777042259; x=1777647059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SBAWISZQQ83B65zp3ZGw7r9K/PhyBwFKKHiTM7zEE8s=;
        b=cSHhx40zjSSZ4v+J+9ndoGyoeClIZsRZR2sUmT802wEqsDwpDgVlerrP2yUS299IOB
         1/ITHHDEINzbCnIE1dZQpaXEfZc+J+98c/DLDKM8XhqS6oU5rjryeZbqCQaUtLOBxP9Z
         k94VGxGus2/gUGd0iXEUUxJx5O82uZdC7t1CQUXT45bKcPOae9kmM8wZ5VDJimIBwCWY
         1lf9t34UvEoqsIEULXTnGoKa8sr38WMYBGDLNFr1dnKPo46zOBzWrG6y/c4TKD9X2gSY
         xmkjkN1dgggykgXMCDSJqCc3zM/+3plSucPBCPr0mPWPdITb7tgt6gnXnDOBrQkzVtE8
         QErw==
X-Forwarded-Encrypted: i=1; AFNElJ+zG+GxlnIOp+H0qkYba3brJks0LILOKFt4pBgugauHSZALpZax1rw72+zoMlA543qFf9ifLcAWuL0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw45E5mHZRj73k0QI9Thy8ZF2wOA24KNAH4RRJhn7sN5+B1bgSS
	AGOfu1HgZRXDU1cB1CKjfuL4lW8fmSKgSSsQNLhKP/9eW+9BM8iu+ov1
X-Gm-Gg: AeBDieuJfwtJD/rpvLDkJzNLRLlS/Jzul9P8OZtSoUDvw+4CayiIUcMTaN7IDP6RsL1
	9QQ2FcmKkQzwq2F1ZvjDJtfsnZS+KQqsPFrGtF74UF3SythrWl63afmMowrJmCtp5ubEKxlNC1p
	1Xrux/SBXywZ85RXKJDK+9iy7hsbERtjjTeU1K/zUNMbUpVm8yvbsa3/BAQXhFmUd/e410lT0XQ
	fkVPtedO1DhYGtWn6r73Xt+EX06thGdHLqQ6WGmzV0ncnqfjPkVwJzjuWk3UKShqb9oxSlBZfg1
	o0tL86zpJqMGmZk6+ZnGXNuzr9JoemAFkieeNmCgNTracKBP94VSrw5PJOEL4Kv8cjiFtzQiis6
	xCl3a8z577dRHlzyzSJB+hzgwFCa583W/VcjTdE5/ibE0g+kYCbakfP7u15dJ0DsDHXp8UZ22Db
	Wm2DUt7ZKo4DHNcpfNLLjVGdIyf5l6hYatEoumFi26sUy7Zb3SlUYrJoNpCLEDf+QXxJAXJG8z5
	9A=
X-Received: by 2002:a67:e711:0:b0:604:f849:462e with SMTP id ada2fe7eead31-616f8182663mr15135336137.25.1777042259406;
        Fri, 24 Apr 2026 07:50:59 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-6174272f752sm11448711137.0.2026.04.24.07.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 07:50:58 -0700 (PDT)
Date: Fri, 24 Apr 2026 15:50:53 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Yury Norov <ynorov@nvidia.com>, Thomas Gleixner <tglx@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen	
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Andy Lutomirski	 <luto@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Jonathan Cameron	 <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=	 <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Ping-Ke Shih	 <pkshih@realtek.com>, Richard
 Cochran <richardcochran@gmail.com>, Andrew Lunn	 <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet	
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni	
 <pabeni@redhat.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Hans de Goede	 <hansg@kernel.org>, Linus
 Walleij <linusw@kernel.org>, Sakari Ailus	 <sakari.ailus@linux.intel.com>,
 Salah Triki <salah.triki@gmail.com>, Achim Gratz <Achim.Gratz@Stromeko.DE>,
 Ben Collins <bcollins@watter.com>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH 1/9] bitfield: add FIELD_GET_SIGNED()
Message-ID: <20260424155053.1a98bf61@pumpkin>
In-Reply-To: <6170788fcab2ec835597e3d7411928d36850c20a.camel@sipsolutions.net>
References: <20260417173621.368914-1-ynorov@nvidia.com>
	<20260417173621.368914-2-ynorov@nvidia.com>
	<6170788fcab2ec835597e3d7411928d36850c20a.camel@sipsolutions.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Apr 2026 10:43:08 +0200
Johannes Berg <johannes@sipsolutions.net> wrote:

...
> I (personally) tend to prefer the "__MAKE_OP" versions (*_get_bits()
> etc.), in particular because WiFi and firmware interfaces deal a lot
> with fixed endian fields.
> 
> Any chance it'd be simple to generate u32_get_bits_signed() etc.? Could
> be especially useful for le32_get_bits_signed() for example, to have the
> endian conversion built-in unlike FIELD_GET_SIGNED().

The problem is that the number of options explodes.
You need PREP/GET/GET_SIGNED functions x_64() x_64le() x_64be() x_32() x_32le()
x_32be() x_16le() and x_16be().
I make that 24 functions.
For UPDATE you also need x_16() and x_8() for another 10.
So at least 34 definitions - it is all getting silly.
(And I've excluded the pointless 8/16 bit functions where the result
is promoted to signed int.)

Then you have the problem that some (common) architectures don't have
byteswap instructions, but do have byteswapping memory accesses (maybe not
16bit). Which means that is it generally better to byteswap the value
before passing to FIELD_GET() and after building the full 'word' using
FIELD_PREP() (and just | for single bits).
(Except it is probably always better to byteswap constants.)

It is also worth nothing that FIELD_PREP() will reject requests to
fill signed fields with negative constants.

	David

> 
> johannes
> 

