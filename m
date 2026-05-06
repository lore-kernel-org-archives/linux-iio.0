Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BFF40629B
	for <linux-iio@vger.kernel.org>; Wed,  6 May 2026 10:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778062679; cv=pass; b=ZC2U0jr3mo+hPV4DlkQ498mIasKsu8O/hqegrfySi6liRlmtLvQJEXssCvOLDcndTaE7tkx5HIjJ0onn6qBvTcK3nwJjgspmLmoXz5lO51LCK4mzokDJ/MUhm0AW9mnj7VxYB5gXusWcnkOwcz1/NkoN9MF1nIwfiFWvHlInFA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778062679; c=relaxed/simple;
	bh=Tbd1N6dtU3/R1l+tgM4hL42gavBGXHDfwcSwHDeD5zM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aeK0Fh9YZUEQQqwayn6OImCIj63zHvAPfs5TgDhLrPsMsSOFiOEDFc9/4ifczEV8zIg9XdZHNgnGcagcwDxQPOhllcIo7GQeNHO1AR4FOD9fLiz1+YR+tOfcr4nt01Q2S5qFwOoNrjicmXOJpN27VjGu/IQnGkg3i/BKKOc4T10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qdCD6Lty; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qdCD6Lty"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43d75312379so475142f8f.1
        for <linux-iio@vger.kernel.org>; Wed, 06 May 2026 03:17:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778062675; cv=none;
        d=google.com; s=arc-20240605;
        b=dy+QARFVRpEbzSuIYcFRlIM2gV8/hXl9mQYW077GxqJdOfmZhUFLPi9gVW6G+0MSSG
         +lhn7Uq7d/nKdo7TIo5DKs86XenJjBicPOUShDfVqXylBfJ4RAAQqnwBVj2TJgPwhOAR
         y1BMLn8gtoAdi4lesvjjom8Yh0/nC+OMb7BFsf3um7qwMBEQ4YQLbjDC1A67I6DHNaeF
         ZoC9AGqBMiW58TDthA3YBOY2bYNgZuUIgecMm5JpZYls/BOamFC8VbwUtikevLsD6Dt1
         kDBgJbHx8U8oynXYhJEUJ6dZzVkSnWahlzC+cHmdTdfBu0NvxAbP/W4X58u52TU4YRuG
         mgVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1HRuS0rC12hfnQ2X/1gNT3jcYoikvAFQ+fKE7DTm+XA=;
        fh=5xLb/Xlxu4Pa/5TxO+dXIQZse7/VLyvTy5JQ9Pz8+e0=;
        b=g328cqziv76Lfgrk40x7a0j0j/CgZyGBa4oK73M1bQ94DPH+IJUw7jJWoSsUWs2H6u
         uqkWj+PIqlkZgFBKouuJzMjDvP4DyghnXpxaD0Ue0++AlTuVIxi8wH966Ys7GTJ+6u/I
         y0aoxaIxCmncfc+X+AyIo9OpmHFhepdWB5ElCMI45UxkMAsXTn7ItOWVJFzON9CaXmTs
         cG+O3tD503+4TMINSpEbYkDdtwU3I+Mjn/p1I1o1x4amRulUyf9WtpWFLsErzz8kh8Qe
         Sz8ZQCfSMiR78+23ycx7IeRSiBIP95LAvyBscmTH4J1InEvibiQ6YysRzwaAG4Jhf9k3
         jy4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778062675; x=1778667475; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1HRuS0rC12hfnQ2X/1gNT3jcYoikvAFQ+fKE7DTm+XA=;
        b=qdCD6LtyjpkWAebmqVFpx/2QJU4rTVuHos+r/A1hI664v+1+Mr/1N4dO2EAh4juTCg
         /UgVbNup5b//GYnI7Hc4WbJiTFohbpheTVgSv6477T4ga39Cxp4buzm0IefDYcqfXU4L
         XA0lexQLwrKdm7b6YZABfcFYGFRz/GwrNS7aqymM/rOGBvNqAQ/jFtwFiW9KVZJRTY6F
         vak4U5Bgqdfga5b+jn2mLceBOBy1/i9QImYkMjeOSsjpDMG2Etv/pP48YIg4mW4J6g+P
         8F/TDk2dx1nTSDsODs8gLN89AJK/ho51MFcYfRBgVXG2O3cyDOlFJQV3Li8xFNNFzXQG
         GpaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778062675; x=1778667475;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1HRuS0rC12hfnQ2X/1gNT3jcYoikvAFQ+fKE7DTm+XA=;
        b=KSX8w4O5q4/vtKiW5sTbJKSovaZcvxE3gj374e+cmTvsp8qwb90kXTHKMpazOdSzgI
         0GnuzwxqSG5oJ9rTtfxdfJUW3MRg706x+7Td0ZGcAcw8y7t7NALtz7xq5ecbAIORUcED
         Y5z5GP8GMqCd25OZiW5M7wtqaczG21EA5jdTMH58lauUw9G19S1F7IWUkqX/hUpqB7Fh
         KGOWDutAaXhuahx4JuwIuouroDdwx2rX6GZNZkC7wO9IgOsq3NfVLXMYU70e0imci2PD
         3yAoqThiJl/MqFNAGagmKcK6KGWNe9HInY8zv7sARm/QrGGXn97kbr9wi2oKn8XLPvaF
         u0rQ==
X-Forwarded-Encrypted: i=1; AFNElJ8NlvNc5bh/LEuayRWX4iID2yR8Ti/feRacYG7OT/2zpPjxEyF1EB55/FRwDFiUb/2wbf9Kv7XHMrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMjvMLYIs9KhyECPP68hb93lGyZuNUM3suvfLe5ESWSP3Ylgc7
	32qXrKlBPL+9UX20c/btwNvWNw1lUU9Elf9SaDizGumlVKYERfiT1/35ZlbAEL9QftcbJyKoddR
	RlBhSjWQ+A0XWD653SvPsFWKMQjPe9YM=
X-Gm-Gg: AeBDieuWARQEHasQD64+hC5RpTrpf2pJewvJzAkFym30Kit0GWJrA+ijr8/hgjgM6ON
	1tbCJGIgAj27jUy5E5w0Y+hOZ/xjkKA+uCdCf5NRNqRdjj0A8UbaaWsL5bXOKrAqgybgEG/Zhc9
	wsiOqd7kUI6YEVq3ou+q7s3nyMEG3wP9M0yNtAYr1RhhX6RtLGYD56mNXHiCmO2VXaAFRS0bB9w
	fOe+WIWL8BlRskxQZyknRnfZ/9KL6gCeFCFQTFM0gggs4BC1hnYiatXhdSOcitCGAU6631+08SE
	w7EfDHRn+Pg3AF5iLJ9hBGzOAXFjKkfwdjpZQOBmQwK3iVQsRuCX2EqJD373gZTaKuJsVE7pDGG
	0VrJloIEZJqh/Bid5hYYsG7NqVclAy7lbamr19QO2t6znQzYRID+YZ57LlQ5DMcYOxhJhkBPt5Q
	x8laIU42gvUXU+uWUD
X-Received: by 2002:a05:6000:2089:b0:43e:531f:720c with SMTP id
 ffacd0b85a97d-45164cd1316mr4298537f8f.11.1778062674572; Wed, 06 May 2026
 03:17:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506095835.10112-1-salah.triki@gmail.com>
In-Reply-To: <20260506095835.10112-1-salah.triki@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Wed, 6 May 2026 12:17:42 +0200
X-Gm-Features: AVHnY4Jl5BYbftmEgbWcyWEMyuSJBv7AI4V8FlYLES8aWvwpY9NQJVSuZFG5YV8
Message-ID: <CALoEA-x9KRBu7=a4m4bxpp2c8o=MVqxr+ZpUNB8uga+XYeYX7g@mail.gmail.com>
Subject: Re: [PATCH v5] iio: humidity: ens210: Fix missing I2C functionality checks
To: Salah Triki <salah.triki@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 May 2026 at 12:13, Salah Triki <salah.triki@gmail.com> wrote:
>
> The ENS210 driver uses SMBus transactions (such as byte, word, and block
> data reads/writes) during the probe and measurement phases. However, the
> initial functionality check only validated a subset of these capabilities,
> which could lead to loading failures on adapters requiring SMBus
> emulation or native-only controllers.
>
> To ensure compatibility across a wide range of I2C adapters, modify the
> functionality check to verify if the adapter supports the required native
> operations or, failing that, supports the SMBus emulation layer.
>
> Fixes: c524fbca672e ("iio: humidity: Add support for ENS210")
> Signed-off-by: Salah Triki <salah.triki@gmail.com>
> ---

Please slow down, you've sent two versions in the past 30 minutes.

Alignment is fine, but refrain from sending patches that quickly.

-- 
Kind regards

CJD
