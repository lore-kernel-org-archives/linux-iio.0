Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428813AFCEA
	for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2026 21:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787174480; cv=none; b=HIC1oIWPSuKr+99zTljWfM3e6LLZJUCFrE8I9BzZB3+6CeBTwmt7rCfylVaGC37P8bp2YZY9f7pFUHryaAfsFwflq3N1opBqqAlaf6z6GkxO+HMYuo7NeqfGteXNKynafwA0sZ0qZMM34N+tfNozrQQLEimYXstlMAwBrQBPW1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787174480; c=relaxed/simple;
	bh=1sm5DJvN9JZq6zFJ3rudO9ha47L7zEKKAdXSC02I0m4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oc+85V7QOMcBFF1B/fgzFxiyIovyVuUvlH2rSksC09iRJYI0lzRNFfyLBetmSQP2lUDM3QE3ohhvUp5x6r9Qd+hZQ0v9wQVQGs5HdeI8frfSfiY6gCoMIfovmXYP+wHY2TqM/qmIKb9RusId1HygI+VBggTHg/wZP1J8m5bcJyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UcJ3oM6C; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hZbf4DBG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UcJ3oM6C";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hZbf4DBG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787174477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CqgpeVGn0RSIV25AilpufRbxuFATmlWL+zdwTTPB/B0=;
	b=UcJ3oM6Cf7nLH4G2483cLy169Onc0kriqtIPus+5WJdud1PKqDSBNvqarppljAdkmPzvnV
	1FRY6A4IYVJWN61uxnCVYbIopeSIOJejZwNgK+hnUoyedboSTj7yetAFLpr15cbzgBgWgN
	0tbEivoidLP3zceNKxPVt34HdsMRSu4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-OMQiKvgbMCewayfboSoewg-1; Wed, 19 Aug 2026 17:21:14 -0400
X-MC-Unique: OMQiKvgbMCewayfboSoewg-1
X-Mimecast-MFC-AGG-ID: OMQiKvgbMCewayfboSoewg_1787174474
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-936aa34873bso139254985a.3
        for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2026 14:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787174474; x=1787779274; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=CqgpeVGn0RSIV25AilpufRbxuFATmlWL+zdwTTPB/B0=;
        b=hZbf4DBGYedr+3yZZYyeMRt3r5Aaohe8avIvv5fmQ/okL4NbmjAzqXyI3UPyiI2CbJ
         v+15mmfBBBPt0fXT1H2uXW1ZtxATaPVt8SznQ6ih7SIPJL7cZWHSyLXCCupwXXTnI1mx
         RZ3NwUlLrDOEgJkjf7BbqC3pG7FFsTFPZ09S1o3vgN3J7EQ6/oCDTPU/HtHPVoVrrHFs
         DMYXx9lThQeDV35VFqOtDtW8jg4FlxB24rcTaPD5/52zESGuVsT9nXNbPmSC0KGk5Njt
         HxbDuWhlNHOd4329n9s70c6AQzjQWq+XPUatwIOT4ydNkZpMRP2OH2Xnfjq8LIVkaP4u
         +wvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787174474; x=1787779274;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CqgpeVGn0RSIV25AilpufRbxuFATmlWL+zdwTTPB/B0=;
        b=TkPI/2hAKIDE1pSl2EPleP/xeQSl/vdkuMmfRGcbbGJQImDqrO3+81YnLf7n2Dt4m8
         ns/m+wj9Vix1dscQJyeGCDOh2Wh1vSiM7R9I41kUfhmBnNVQ/iQgW2mriT78yOh1kdat
         VoNL1eQAgPAqsXrxN/uDBI+iwFC6YDjdKN7/UEInqetW88y2ABRBU/smfRmumsmyoNov
         +Sel13W1sEnJC1zvvnf8pGrPvpoJWUsDM/xsQqaiBRjgi6h/eGO7XdrxO9FF4m2zCeym
         ld6M0Wxwmm9+t1H36IIE78vcZ/5kH6rhwtmufZvZZ/RPr7qujVv6qxzRfPsDIDXPIWbc
         zU+Q==
X-Forwarded-Encrypted: i=1; AHgh+RobwJw9Kv+o9BiupN/DOn4lshZR1x1tQGYCIz6vmej111B3ZGL6C7UZ3U7xPeLnolpFo8mPDU7H2m0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCeQ/5wb37HomAZwQh+bBf6qU5hTOHADNbU3IST0jilquTA5ga
	wGjy6BluDn8gNrQNVSBsOuTb41AFywBYLklKyWKyYIPynxERFt4hMf5leEXhyAVfA+G5puSdaiZ
	9eX5Nz0mBjdKUFoLjd//8zoLOFv4dVjDRaWxoTg3w96JqjWPlRELe+ynAuRAPVQ==
X-Gm-Gg: AR+sD11v+S252ZXr4Zc2HFI2W04/1wg2BH22S/fduz6AnWfv6szbKuU+1uaWQlCQ9Y7
	jxZnlCb+hVRWNNqV/L1N+ZjObriArFhHLSAaIESMoLPZAQmgiMs0yqVFny2c2EuobFhsb28C2iK
	z2fsmAcy7wsCIHhr5qzRZ54NCgLiFi1rKVz1wHLf9GYRG30qkbSrhSx/FwwKpLIIoV+T0hYcKhe
	Gq2qqYeKCOHtTnKrB+NVEGooSj3EBlGFBmzUwDzj48u9YGfLHryyD04/VgJjZviko2FFnuaTPaa
	bYhh4jXG8Fv1ImDqIzqdMxrUfiFJJbXCVcH9Nhm8WISisT2Z77DXGQs5gbTASX6A08ad1EaSCO8
	Cx0GHvAoojSdnBt+1HmbOHEPBg3moGjE89E0=
X-Received: by 2002:a05:620a:6010:b0:937:139d:592c with SMTP id af79cd13be357-9371e67ddfemr822212785a.38.1787174473983;
        Wed, 19 Aug 2026 14:21:13 -0700 (PDT)
X-Received: by 2002:a05:620a:6010:b0:937:139d:592c with SMTP id af79cd13be357-9371e67ddfemr822206085a.38.1787174473413;
        Wed, 19 Aug 2026 14:21:13 -0700 (PDT)
Received: from redhat.com (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93720582980sm222991885a.33.2026.08.19.14.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 14:21:12 -0700 (PDT)
Date: Wed, 19 Aug 2026 17:21:10 -0400
From: Brian Masney <bmasney@redhat.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Tero Kristo <kristo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Nuno Sa <nuno.sa@analog.com>, Guenter Roeck <linux@roeck-us.net>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Sunny Luo <sunny.luo@amlogic.com>,
	Xianwei Zhao <xianwei.zhao@amlogic.com>,
	Mark Brown <broonie@kernel.org>, Kees Cook <kees@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
	linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-hwmon@vger.kernel.org, linux@analog.com,
	linux-iio@vger.kernel.org, linux-amlogic@lists.infradead.org,
	linux-spi@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH treewide 1/5] clk: ti: Make sure clk_init_data is fully
 initialized
Message-ID: <aoYeRqwY3SSZ2xDX@redhat.com>
References: <cover.1787165329.git.geert+renesas@glider.be>
 <e6f52b34163c8e708c1100107b437af0b3b049a6.1787165329.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6f52b34163c8e708c1100107b437af0b3b049a6.1787165329.git.geert+renesas@glider.be>
User-Agent: Mutt/2.4.0 (2026-06-19)

On Wed, Aug 19, 2026 at 09:05:15PM +0200, Geert Uytterhoeven wrote:
> The clk_init_data structure contains several mutually-exclusive members
> for different methods to specify the possible parents of a clock,
> prompting drivers to initialize only the members they need.  However,
> not initializing all members may cause subtle issues, which are only
> exposed when CONFIG_INIT_STACK_ALL_PATTERN or CONFIG_INIT_STACK_NONE is
> enabled.
> 
> _register_mux() fills in init.parent_data, and assumes that
> init.parent_names is NULL.  However, the latter in uninitialized, and
> thus may cause a crash.
> 
> Make sure all members are fully initialized, to fix such bugs, and to
> avoid future breakage when converting drivers to a different method for
> specifying the parents.
> 
> Fixes: 667f420c09f1417c ("clk: ti: mux: resolve parent clocks by DT index, not by name")
> Closes: https://lore.kernel.org/CAMuHMdU3yVqoyHC4eNF2NuYo8wy+6ODLoYat4R71X99Mxc_=kw@mail.gmail.com
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Brian Masney <bmasney@redhat.com>

