Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9AE29BDBB
	for <linux-iio@vger.kernel.org>; Mon, 15 Jun 2026 07:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781508142; cv=none; b=mzXuSoACOWBUqPSIt41F9AIpDmKvjxGsyowANMl/JTw0xntJSYAQ0q1dbNkq0MhULc8v/FKHVpcp/SuXPemGFUEI333mCVvBtslU899ElxkTtUpSc8NLNQyzUgLdez+zuTfRcpBlriAqj0fETFx9q2Wtn0rQM4H+OT+ErJHL9uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781508142; c=relaxed/simple;
	bh=q/LjLwsNZeVWRdpomEsJmQRIeT+eVk51ndti/vp7ZJg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VrG/RlYx1/yuuOtiZWGvcULs5YxvE0cwkMoLIrPkluY3jp2SlP1y9wwh7zFrTt+sO2oGOISa7lZJJGyBIvrEQp1OPSwOHmvAX6/cWoXZxl55BiZLacW2ITPrRfRTGBKZRsBKw2vZffGcvyxQSpJNjRxa1IOTVMxxySPBfONEr/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LeirWdVV; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LeirWdVV"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49222b6e871so15612835e9.3
        for <linux-iio@vger.kernel.org>; Mon, 15 Jun 2026 00:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781508139; x=1782112939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dccX/noafFTQkYLMmmr9krd/IkjkNKqkd36N21cGVWk=;
        b=LeirWdVVNUvD6YWneBMXzByvudmuZ3qN0MPK1EYp+tDeb0xjQN0uzdR/5NQAKOIo8G
         vF9Pu+AbPbnIPycnKYLPsXk5kVJkMR5CKkuf7vmnvPVjZCN+rDo5/PMQ1Kxp38hsVuWp
         i9zhoJZqHWjd5F/9Mp0IJNCGfL3SyhpL2twjTnjQ9u/Bw7eXovSBMnViTkLHBq9wCuas
         fdZ92ZYUsx583zX7WTTnF5Uoq58tHSrbpfQ2spG/qbiSKLBeLOCmU8hQp3gFRj6NJ0NV
         zivEx7yNzBusAdJ0Mq/K25lhmVprVXdfBW6xEYz2roQCtFrdpqZJrzYN6ggNoIOO4oT4
         XSZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781508139; x=1782112939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dccX/noafFTQkYLMmmr9krd/IkjkNKqkd36N21cGVWk=;
        b=djUMNiOhrTAJln9agcrszflnEGk/qO2rYHwW00/cTlbD4hYBwu60zlLodMS/Uc1E3S
         DJFh/PBLKoX5gy634zIqElxXoQHpXDCsMW6LrLn784bZOhq4X21qFpptHAwfYKF/mJP5
         ozEzsKZ0kQNM1PSg3U7Sfre6setQ5MTalMSMphz25xayAWpBuUriXB4XCLyvXNxQ6WV2
         eqpTyeK6Rf/vKdJv9VKTElDtVB2NeRLVRkuvr4InEqKGnQVFhImZuFjybd+Rs/qyuZGS
         b5MQ6+4jMd7TA4C/dVgE/MbEgv/EiiYp994YdHWN0Aw1yMhTUt8ztF5fHnq/Y/FV35Ib
         TaZw==
X-Forwarded-Encrypted: i=1; AFNElJ/jcSaLqGsmqX5YkDSGCrCdl7S/9sFQZl5WYvXS5yIIgJ46gnBVdSU3NMPIkcm7qE88W0laYBDAD/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAoa8qrFs8F/KxLlcoDUBCwmIq3Vh0vU3pCn9EgM5ohtNwfn8D
	CuoTrE9D1hZfPuGWdIKud7/2nQmZnBTQBX14T53lFAuLOqeTw5TSE97U
X-Gm-Gg: Acq92OHKWatiwR8Ee1Aiv/hyOU3mvXAWEpY2Cp4a242bKexWLWmiYud47Fz6URCz2Jx
	NKtNEwKU8Vx0YUUFSFY57SX97jayR9zQOtK9Msgm4nbcwSmsV5TzZolNNJXCyJSGchh7LEBxByj
	4a+XbQUMopavdankuqZGDXHGL0ihtN0uMUiEB9sLUMVt3WGqbnEPpumocRXkfCR1gy+rDYF5S7X
	GfiRMTjl4WIB6q9MVVRUtq2e3ciUDgm1x83QNGmR9nQejGwFQCsIAViEc+NAd2qiw4pEMZbSkHf
	dsB9x+1K1BYZ1uJVGS6ZSevOE3sqlllpmmJhR6Vd8hPTZslKwMHsSP9j9IHlFPsyGv1RJsSOHq3
	v2YithgYUW6tEegWEv/k0dI5B+/IIW2vYxAhTEkgVngzLqLtXSeoP5lZ+SIPJwO1L5rieVFOTYm
	WN+ZywABmtuLj6ujWbTVlok9BiD+DEsk3/yGjPfdiwLGg9SvdqzkQOL+9rcrzPZ92HwyYsiJQSH
	bqGuXDARB8M4Ya4Y/eFBQX1+RsYT9EVgVjZpFX7FUdeqkJnQcM06u7Hu92CxrAClc9ZQqHqYrsE
	NIJEmUFbRmdyOQUwsTTsblikXx0aEsOZernYt3yEHUjFNSMMGkTcrFAKwpms1PlbGA==
X-Received: by 2002:a05:600c:3556:b0:490:b92f:ef5b with SMTP id 5b1f17b1804b1-490ec4d4f30mr164914315e9.13.1781508139308;
        Mon, 15 Jun 2026 00:22:19 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea95c512sm180246365e9.2.2026.06.15.00.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 00:22:19 -0700 (PDT)
Date: Mon, 15 Jun 2026 09:22:19 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux@analog.com>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] iio: dac: ad3530r: Refactor setup to
 table-driven register bank approach
Message-ID: <20260615092219.00007709@gmail.com>
In-Reply-To: <20260615-iio-ad3532r-support-v2-1-84a0af8b83fa@analog.com>
References: <20260615-iio-ad3532r-support-v2-0-84a0af8b83fa@analog.com>
	<20260615-iio-ad3532r-support-v2-1-84a0af8b83fa@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jun 2026 14:20:15 +0800
Kim Seer Paller <kimseer.paller@analog.com> wrote:

> @@ -344,7 +387,14 @@ static const struct ad3530r_chip_info ad3530r_chip = {
>  	.name = "ad3530r",
>  	.channels = ad3530r_channels,
>  	.num_channels = ARRAY_SIZE(ad3530r_channels),
> -	.sw_ldac_trig_reg = AD3530R_SW_LDAC_TRIG_A,
> +	.sw_ldac_trig_reg = ad3530r_trigger_sw_ldac_reg,
> +	.input_ch_reg = ad3530r_input_ch_reg,

You're overwriting this field below.

> +	.interface_config_a = ad3530r_if_config,
> +	.output_control = ad3530r_out_ctrl,
> +	.reference_control = ad3530r_ref_ctrl,
> +	.op_mode = ad3530r_op_mode,
> +	.num_banks = ARRAY_SIZE(ad3530r_if_config),
> +	.num_op_mode_regs = ARRAY_SIZE(ad3530r_op_mode),
>  	.input_ch_reg = ad3530r_input_ch_reg,

Slight issue, this will cause an error if compiled with W=1, as
you've already initialized this field earlier. Remove this line.


-- 
Kind regards

CJD
