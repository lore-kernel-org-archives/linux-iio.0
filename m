Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A463EFD03
	for <linux-iio@vger.kernel.org>; Thu, 11 Jun 2026 12:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781180936; cv=none; b=dHt9YvYJhnxLEfUhgW/zBWBQwO5p0NmN1RUiRmD01lAMi4rHFcL/U82LtGL7B6InUpWvyQelnEYFeR/FLhDslMHvi6HcT6NFFysDIn4hwy4PjmvQdBIpmnrUyTXvw52XBeGhAertVHNu7gbkJ3LpvrW3E3NvKXmtUY2NgcJ4tiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781180936; c=relaxed/simple;
	bh=Vog3orhtjCmeZ4R+XwXGNT+9nl/x2XuiLD+3swCGZXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VuNtbzdhvZ80PBAbkk9GWBplJ+WPWyUJIF25NFXbrGWQf3D+N+WwU1LCSULl8x3jV4nAKzqa2YSKid2Y3fMaOZrcroH2l/072plXaSw/qmXnYSAmL1xtEPCcmJ/AG6l6DE0H/W6634GoMmrv5DwfUMaQggk+usw54rWsp1LNs0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j5ez26Iu; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5ez26Iu"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490c0c92cffso57171845e9.2
        for <linux-iio@vger.kernel.org>; Thu, 11 Jun 2026 05:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781180933; x=1781785733; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=azzjerS/pmX26lFb1rlIgG6tYeB2JmthSTl26maBKMw=;
        b=j5ez26IuHLivizoOyo43BVMJ5pTHwph5LS1r2wTG/xk7WDoU5sPy9uhE+xE84owxsm
         1aMJj1ySPCsk0uDrt8Oi4/g7EkcXJ/EqrOjdRKFahVRm1aLTr1jDhKauwxusAIQ1JYCs
         lCamKDlFPCJx6xk/UkoOQP/XOOD3r8jQHD8t/viblBBEKDlswNQ9KrkqOnmqp0uA1Fu2
         xDt+XpoaKT6FmVZbNtA46kNl8DCMeAWqTzybA5tPJ6Lj+TWymgXEZ1+ZUGwbhDINvlLj
         dQdVZbgXpUk7Tai6GjlBVFfa0DA4JNV4TP494ySiXmtqCOB0pWiY/t05r87ixEvbinup
         rwuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781180933; x=1781785733;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=azzjerS/pmX26lFb1rlIgG6tYeB2JmthSTl26maBKMw=;
        b=sFGF/5xF6ISRVqEGZ1vb82q9IFoFWrgqc9n2hClePtIOWN8l2oiXI0Y9XqYG1Fbb9F
         Md8GyKZQuvLo2Z0gojl8uSwtLKdoCBpNGx1fbQpscFK/uSLv0TkjTLoMPFvBWnSBTJG6
         0OK8xlQ7U3mhjwaw0u1gG5ngYmhkE2PT3gTBgRenVor/SSMZv9DSBXlIDIbD+ySWlFBc
         Bvar2ljv6dFG8olfZdNCGM18IVa9ZnonKQ2gOH7sgy2/fF68UhrpjPcZyBT89+kfIYad
         2CZz8yX+eff8BBSLY5SWivhIP4hLNZhBNgRSxzxBmru1IC0mOhv22woe1BJOHYUre/Rf
         Sg8g==
X-Forwarded-Encrypted: i=1; AFNElJ9xaQ+82fYyTqas65nmPXg9vuvEqU5GQONIpD8zvB/RGztW9I/Wzsad5I/LdEdgqL+U8Ci/Fejlhgs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1sNKLMMsmQ+YbHdCGykO1gE5C9GpIY7dWQ+OHatxvIuBAWUE4
	LlESp6r7LCTwTBfaxji6zTt2IbeylOQTa+kom0d51nev4HVvWp33iaR+
X-Gm-Gg: Acq92OH9ay/DNq4UMgGIC3VBX+rfyt3FRjECKlOfQ8eQCUF7XYUwMR42XAaxNLYL1S4
	gm5XSbvt2KCVoYCJkKZSuNDc0RNq/99lN0uXkfxGbXI3QGRLQCLp3dEqEDKhY3itNRVuORtNSkP
	kparzbXZdzKa+BXGGysoCYlqGUso4zyUdw8p7yQg1pY6bnJf6hpSOcBVi2Jd/ldToRPKhrhOuH6
	RdtXZ/LNIE2p/mBzvJtPRoLdjr64znEO4KLZnAv7ieY3wDipgGN4o20mEkvIY3FRMoB3BZErEWW
	YY6ciksHZGYsM8SsNr5RxKRPgkoPw1di7c20ehwdXBQVOrXuRDKBuXa7bHj1ZOalsxkgsFLJYgY
	WpOMf1iITp8B2NDRmJl/o6CoFtp8OwJ4PGTTgWalbKtmE/L0mXmuDB2fZ+S9n2hIMsHWr3J47DT
	efaANx8WGnLsvAYt/ELw0HKwnIYw==
X-Received: by 2002:a05:600c:4f95:b0:490:bbc4:76a6 with SMTP id 5b1f17b1804b1-490e5619b2emr32867615e9.21.1781180933181;
        Thu, 11 Jun 2026 05:28:53 -0700 (PDT)
Received: from nsa ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e52a54a1sm43212745e9.3.2026.06.11.05.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 05:28:52 -0700 (PDT)
Date: Thu, 11 Jun 2026 13:29:53 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: "Paller, Kim Seer" <KimSeer.Paller@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, "Sa, Nuno" <Nuno.Sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, "Hennerich, Michael" <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux <linux@analog.com>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 3/3] iio: dac: ad3530r: Add support for AD3532R/AD3532
Message-ID: <aiqqIz8wiVjauCai@nsa>
References: <20260604-iio-ad3532r-support-v1-0-c3552f9031de@analog.com>
 <20260604-iio-ad3532r-support-v1-3-c3552f9031de@analog.com>
 <20260605142428.5cd21b26@jic23-huawei>
 <SJ2PR03MB71394BC5D4E680A96F950732F91B2@SJ2PR03MB7139.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SJ2PR03MB71394BC5D4E680A96F950732F91B2@SJ2PR03MB7139.namprd03.prod.outlook.com>

On Thu, Jun 11, 2026 at 07:04:37AM +0000, Paller, Kim Seer wrote:
> > > @@ -445,7 +704,7 @@ static int ad3530r_setup(struct ad3530r_state *st,
> > > int external_vref_uV)  static const struct regmap_config
> > ad3530r_regmap_config = {
> > >  	.reg_bits = 16,
> > >  	.val_bits = 8,
> > > -	.max_register = AD3530R_MAX_REG_ADDR,
> > > +	.max_register = AD3532R_MAX_REG_ADDR,
> > 
> > What happens if we read off the end (via debugfs) for the smaller parts?
> 
> I tested reading registers at 0x1000 and above on AD3531R it just
> returns 0xFF and no crash. Should I add a per-chip regmap_config to limit
> the exposed register space?

Personally, that would make sense to me.

- Nuno Sá

> 
> > >  };
> > >
> > >  static const struct iio_info ad3530r_info = { @@ -514,6 +773,8 @@
> > > static const struct spi_device_id ad3530r_id[] = {
> > >  	{ "ad3530r", (kernel_ulong_t)&ad3530r_chip },
> > >  	{ "ad3531", (kernel_ulong_t)&ad3531_chip },
> > >  	{ "ad3531r", (kernel_ulong_t)&ad3531r_chip },
> > > +	{ "ad3532", (kernel_ulong_t)&ad3532_chip },
> > > +	{ "ad3532r", (kernel_ulong_t)&ad3532r_chip },
> > 
> > Add a precursor patch to switch this to named initializers. Otherwise this will
> > clash with the work Uwe is doing to ensure these are all done that way.
> > 
> > >  	{ }
> > >  };
> > >  MODULE_DEVICE_TABLE(spi, ad3530r_id); @@ -523,6 +784,8 @@ static
> > > const struct of_device_id ad3530r_of_match[] = {
> > >  	{ .compatible = "adi,ad3530r", .data = &ad3530r_chip },
> > >  	{ .compatible = "adi,ad3531", .data = &ad3531_chip },
> > >  	{ .compatible = "adi,ad3531r", .data = &ad3531r_chip },
> > > +	{ .compatible = "adi,ad3532", .data = &ad3532_chip },
> > > +	{ .compatible = "adi,ad3532r", .data = &ad3532r_chip },
> > >  	{ }
> > >  };
> > >  MODULE_DEVICE_TABLE(of, ad3530r_of_match);
> > >
> 
