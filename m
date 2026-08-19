Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C1D3B841D
	for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2026 21:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787174572; cv=none; b=iIpGJcLf8pRkyq8yAhNwONkTxY3fegjs5Q92PI0yVUsHo1z2rneOeHsqtkYMZ2G/1fHFATIOB+/ptxDgTAyThTzlReE3h1e6zC2l0LrYrWYsxg3ofk2iMYtdURGcXQMBryzdMunQ1TuomI3IhAqrXHeFJwE2rxF6fAEq8XFS8to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787174572; c=relaxed/simple;
	bh=SzUr6zig9u+8VJEkLvWpenZdKF09X36HV3SolVfmfk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hOWOJefDfkT2GKT+t9f6z62DHCCSp0KYVLe1A917Wvx5GvIhtK7ijG0kzlu/vUrbH0B5wzLBTX+nHqFMqGIHSJxfdlSdCdDNHn1yLbtqFYK7gYE+2XwWPDiaZruTKkaziuPElQbem3klm0/HuGx89G6USXzgPhHyUVr8tC73PJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FvuNhPZT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UHBonBcN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FvuNhPZT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UHBonBcN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787174566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rj/mRgeCj8M3kWXn8y1lXKamZftjeOSlfCZmQd+Kztk=;
	b=FvuNhPZTAZ2PK28rYi8GxEQfyEKF0XI1qEUvdUQXbGT4vGPnWyxOxCJTq3st7qU6ez8wBL
	Hnln3RsYuhExec2GI9L8GVKKpx/JWuZrcHYgDyjH0HTTNnq5FIUM9RTti6SkZZ798JqbnQ
	m1QZhgcU/W9olbrWcXVkV4pZhLgHlug=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-ET7cgLegOtqb3aInOO-M9A-1; Wed, 19 Aug 2026 17:22:45 -0400
X-MC-Unique: ET7cgLegOtqb3aInOO-M9A-1
X-Mimecast-MFC-AGG-ID: ET7cgLegOtqb3aInOO-M9A_1787174564
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-90a60102d6eso16759196d6.3
        for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2026 14:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787174564; x=1787779364; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=rj/mRgeCj8M3kWXn8y1lXKamZftjeOSlfCZmQd+Kztk=;
        b=UHBonBcNHqyKboom6YYt+t+ZK9mcVmi9cN0KODqFWGxuCu8/KOdMY7Ohc22sQO7iuO
         M4nJ2EDKe2ByFEhvifdxSk1qngxDudfryBdKJtudp1SyQV0/R4cHe/AvPqEdaWI6VIL6
         lgiF5sMDvLol52vny0cHgEwYNS2V2vB5S8Qkz6+ndaPUnxl/T3ncyKDFoszphPM5Ooud
         TGhQ2cLKd5ebRQ4gygtai7utvrZIHjVn2fczOjPvwY9xXqBigxAiHKzuOYYguQ0vrxEm
         OGUP5x6BkHENkSk8KHmla3HLPCF6dfoTBL8GnWF9ZS/plqAZMyjywbxEtn90ScpWc/3D
         9bBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787174564; x=1787779364;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rj/mRgeCj8M3kWXn8y1lXKamZftjeOSlfCZmQd+Kztk=;
        b=JUZZCh8sY+xtpqDjHxDaRAwgwoGyPhqQIENZ/N8giqzGIswx9V3W9zjFP/NIrYtAuB
         6A1QsWDhEJC7X23IrGkuEOO53SlCuzOQPgv65pYBxLwD91GI8g4tSe6tcVvFrQ+48EB3
         5plvkIcTsEk6B408jsJb6l/1Wlist2gjlRqm7L7CeqQRjmfW+sMNp9R16p9apfW0ntsD
         gPtM8Vqz/81O/FoZRLAIh2GRBx33uv/LoFY7jLQPe/2u5ckHKcmoHkYwswO9cPjJCEJI
         W+a/450WEf+xFYmF7reOAjuo894TvO42dN/Yx4ntQGZ2vOPdS4MdNteAZcN8hz+tztID
         hQaQ==
X-Forwarded-Encrypted: i=1; AHgh+RoJFxoEl7JwP2R63TfCW7f+t30+3UFPWnVTcCdZTM0o2m1IWoA2AUrpGxwAk0DyYfPVV6FX3sRpA34=@vger.kernel.org
X-Gm-Message-State: AFuF++mG/pnMAOApdMrqN7iXCaWX2etkX0xyyD3qszwjFjNmOLnFHCMT
	yo1UtOpr6kHB1CjtCYrbBAMwqZcpQOeZr//6CwFlPqJ0bV+wBLnMV/cBOy9UP4m+oFqStl6yPDQ
	SGmXR/MbfDBOm3BFBV3UEewQOxEBx2VTTw0XuknJc3HM7xDMbEEZxXKiEIA/+vXJBf23uZQ==
X-Gm-Gg: AR+sD11OjSidrTUb8iW6vTucwnKTQR2PRD/DYklvfFZFOGe/8j4yppkpFMJ31yYbf6S
	QnmAea/A2b8PPl2ZL4m2Hu7HW7Dvl7dHxZTnhS/bsO4sHT9/+KeB1ZrvVdwMOOnnEubt8kutZd0
	qV2j5XD1ZQ1MURAWCGg65nUkuYBHmXDuqyDzQe4UOpzRIAWnb/uBR9E9m0umQL4p2NeUCP6tiDR
	5Cn1LXfq7QeCPkYWWwMaNo++7I4QsPH8QSlqhwj7a8ae1zAmZjNXIp4Mrhp5s+wXj1VA5FCE8he
	TQuasxM9NuynchgCfYBQmwm8cHsReclhzDbQTSblElbF7D7Z0iAFVVd40/ruvyWOh68Uv4AVS1F
	Ai6Q3poyxmTcAYU8FOs/2T02z6Tjm+cP1y/4=
X-Received: by 2002:ad4:5dcd:0:b0:8c4:edb4:a44a with SMTP id 6a1803df08f44-90c5eaabae3mr79736386d6.23.1787174564248;
        Wed, 19 Aug 2026 14:22:44 -0700 (PDT)
X-Received: by 2002:ad4:5dcd:0:b0:8c4:edb4:a44a with SMTP id 6a1803df08f44-90c5eaabae3mr79735276d6.23.1787174563736;
        Wed, 19 Aug 2026 14:22:43 -0700 (PDT)
Received: from redhat.com (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c5eee16e0sm23636866d6.17.2026.08.19.14.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 14:22:43 -0700 (PDT)
Date: Wed, 19 Aug 2026 17:22:41 -0400
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
Subject: Re: [PATCH treewide 4/5] iio: frequency: adf4377: Make sure
 clk_init_data is fully initialized
Message-ID: <aoYeoSnvf5-l69lE@redhat.com>
References: <cover.1787165329.git.geert+renesas@glider.be>
 <302584628c4c0699239a0218376fe1c11cdc8944.1787165329.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <302584628c4c0699239a0218376fe1c11cdc8944.1787165329.git.geert+renesas@glider.be>
User-Agent: Mutt/2.4.0 (2026-06-19)

On Wed, Aug 19, 2026 at 09:05:18PM +0200, Geert Uytterhoeven wrote:
> The clk_init_data structure contains several mutually-exclusive members
> for different methods to specify the possible parents of a clock,
> prompting drivers to initialize only the members they need.  However,
> not initializing all members may cause subtle issues, which are only
> exposed when CONFIG_INIT_STACK_ALL_PATTERN or CONFIG_INIT_STACK_NONE is
> enabled.
> 
> adf4377_clk_register() fills in init.parent_data, and assumes that
> init.parent_names is NULL.  However, the latter in uninitialized, and
> thus may cause a crash.
> 
> Make sure all members are fully initialized, to fix such bugs, and to
> avoid future breakage when converting drivers to a different method for
> specifying the parents.
> 
> Fixes: 60e5448ddbec2dc2 ("iio: frequency: adf4377: add clk provider support")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Brian Masney <bmasney@redhat.com>

