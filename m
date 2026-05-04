Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633843FADEF
	for <linux-iio@vger.kernel.org>; Mon,  4 May 2026 19:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777924670; cv=none; b=S7DPz+jHFtwJKE8pg8mdjZ8dgX/1qbLma5mO4PHq1inpUjU62tOsuGPA8yH0ML/UOVeCFrka48eYcBUT1kX0NYkF+J6FPBYNkKvNbciFUU5cQn4/cxOm67gw1P4Fln60ezKfnNZo0VnohLjaN0VmFZys6MD1R/G0r2b7BEXEiOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777924670; c=relaxed/simple;
	bh=sdAq1dg0+bPnSOklPmil9jaBFE9PIPl1bBIJtwpHO8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYnEywd0TvJzx02zbvJCdizmrJd8MxNiTjyviqOuvLEPGSOdCj7JJk3e4hvPSIIH3mGcchpRBRhdzjH+0q2USA9f7irNizeIbr1tarwRuj7Z1dcRgkT6uxI3+X99CSBdimLt4gkAUY5m41blGmooUVK9YWPR/kpe9AEggfkevMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=sXHRfMhv; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="sXHRfMhv"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-445795cf6f1so2658917f8f.1
        for <linux-iio@vger.kernel.org>; Mon, 04 May 2026 12:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777924667; x=1778529467; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pfzVxf9MxCl5JbzWkX8z2mAnOzxMNsJA4qw2p63tW68=;
        b=sXHRfMhv5j6bgg9gWzybrcXL0DjXsjj3BPZK1ux+4Hki67ZT2zo4fzICsOkH+H+5Xt
         +MA/xYS0449dLoXyIsQMH67+V04V33F3juJwmGpgUK//0GAcaXMwV4G7kh7ciNGIiZb6
         pi94Mrcoku981jXE/9CdRgcFkYRnGCRA+XbxqiC5GfpiWGlyUTAqppZkfHur1SbgXmig
         tIdPnMUSyKGMNTgEDf0X3ewh7XhKUdG7//ezA32n+KbGeI8upl4vf5YuZ5qIDMR03Hgi
         AGRW1eGJ7YV4rR9eDQVeQOsBPGegmTIiWGtGZjWffaB2Hz/RKkWW/N7j++OweXyoBVPk
         e8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777924667; x=1778529467;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pfzVxf9MxCl5JbzWkX8z2mAnOzxMNsJA4qw2p63tW68=;
        b=rM8RynMgLu/ZE9ggfVACL/qQAr1sivXV4Ta+vnLzXyRe4ecaWp4FzOwblM5BmmfJZw
         1MPDVlLo/fFPtJMkrg1okJgfUEnibwt2TwBhuwCGTFwph3ouGooNAlCfXS+phjTmnonh
         cetrd09jL70IhS4ZMl9pJEJWVhu/TYTS7h/mP2Xpud/r6G8ykMzcofqET1J9Z9uOug77
         L58biR7KF4tDGTTFXgYJfZV9s3HxgUmwJxDuBnbQoSXKW8LkX8HHf0FR1zEF/LdQaxPz
         cdbn+HiJ+vu9OpjGkrTXUR7AumHb+lWhwDMlvhMsVqtSDdPZqzfxoZmixezK0YAF8ddn
         hm1A==
X-Forwarded-Encrypted: i=1; AFNElJ8oZv+65Awjzq9qGkxHV/Km29yYW171hWqYUdIt35k5ZjH05VeC0gEQJrdUZUVHsaZGrjDivpmvNHg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2n7ds2qtUV+QJfWAO2rYzCAvlxD0YLP3U5Dxb6em02swtQhc/
	Z62tEa9RrcwwRrIQ2i1MeScZv7Y6fHwSRknoMDikff4DwULMGw4Xf7l8oHRbzRgSS5M=
X-Gm-Gg: AeBDieuR6MFQI46ifyKUnmrb7C8R0ba7t/EpbEdNZb6q6X8vkHTwnua/m8ZOlkmozZN
	AWTqaN027vnAvUYPrp2FIeFjeXkyTWhUHo1tSyqiH3uaYq7gBwOl3Hgs0EVdyyhvO5yxLVy5uIU
	M1xpDyXAHq3L6B1MMa/yibg8WCfvk7PBril2FmdLnIEKt9N0XsD8zulcwuDzU/oonHAH7/mmxoP
	hplwttfO7yq+SF8W0a5vpDgArfXdUSkocqUbV2RULOnc/RnN2eH4Ln5++eCQrktjtdVmq+wRXPa
	kG6rqsq65DV3CouxzN2fFA2x/w+5ipmRXB8TQlXXL//PO8GJ73dlJQPtUij4T4nttrvNpyMlAPU
	g/Shd69BvNE5RfgIbq98ooEqUAyXrNOT/3qdYWV7Gty+96BeyqlVZoBYYLQFjqIkcp7QzJPne48
	kR+w7InHvQ25yZZHavPuEWZGNVFnJJ+wSVxoBvzxlQtrAC65Y=
X-Received: by 2002:a05:6000:2f82:b0:43c:fa96:d939 with SMTP id ffacd0b85a97d-45005c81608mr489564f8f.22.1777924666722;
        Mon, 04 May 2026 12:57:46 -0700 (PDT)
Received: from archlinux ([2a07:7e81:7daa:0:62cf:84ff:feee:627])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4500d734654sm373291f8f.12.2026.05.04.12.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 12:57:46 -0700 (PDT)
Date: Mon, 4 May 2026 21:57:45 +0200
From: Angelo Dureghello <adureghello@baylibre.com>
To: Angelo Dureghello <angelo@kernel-space.org>
Cc: Greg Ungerer <gerg@linux-m68k.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Steven King <sfking@fdwdc.com>, Arnd Bergmann <arnd@arndb.de>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	Greg Ungerer <gerg@uclinux.org>, linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 00/10] add mcf54415 DAC driver
Message-ID: <p2pkvbvj2ksdws3rsrt4d3gqjvkmgwt4gvc2jwjkc7dhybqibd@lhfsyf33ba46>
Mail-Followup-To: Angelo Dureghello <angelo@kernel-space.org>, 
	Greg Ungerer <gerg@linux-m68k.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Steven King <sfking@fdwdc.com>, Arnd Bergmann <arnd@arndb.de>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	Greg Ungerer <gerg@uclinux.org>, linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
References: <20260504-wip-stmark2-dac-v1-0-874c36a4910d@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504-wip-stmark2-dac-v1-0-874c36a4910d@baylibre.com>

Hi,

just seen i sent with git send-email configured with my private email.
Will fix the sender email to BayLibre in v2.

Regards,
angelo

On 04.05.2026 19:16, Angelo Dureghello wrote:
> This patchset adds a minimalistic DAC driver for the NXP mcf54415/6/7/8
> builtin DACs.
> 
> Currently the driver enables the raw write only. Feature as dma, sync, or
> format are not supoprted for this version.
> 
> Additional options suppoerted by the DAC module will be added to the driver
> later on, as needed.
> 
> The same patchset prepares the m68k/coldfire architecture to support
> the driver.
> 
> ---
> Angelo Dureghello (10):
>       m68k: mcf5441x: fix clocks numbering
>       m68k: mcf5441x: add clock for DAC channel 1
>       m68k: mcf5441x: setup DAC clock name as per driver name
>       m68k: defconfig: update stmark2 defconfig
>       m68k: add DAC modules base addresses
>       m68k: mcf5441x: add CCM registers
>       m68k: mcf5441x: add CCR MISCCR2 bitfields
>       m68k: stmark2: add mcf5441x DAC platform devices
>       m68k: stmark2: enable DACs outputs
>       iio: dac: add mcf54415 DAC
> 
>  arch/m68k/coldfire/m5441x.c         |  21 ++--
>  arch/m68k/coldfire/stmark2.c        |  42 ++++++++
>  arch/m68k/configs/stmark2_defconfig |   2 +
>  arch/m68k/include/asm/m5441xsim.h   |  40 ++++++++
>  drivers/iio/dac/Kconfig             |  10 ++
>  drivers/iio/dac/Makefile            |   1 +
>  drivers/iio/dac/mcf54415_dac.c      | 200 ++++++++++++++++++++++++++++++++++++
>  7 files changed, 307 insertions(+), 9 deletions(-)
> ---
> base-commit: 8b4b975922f607411217c81942e82f1d206ebc61
> change-id: 20260430-wip-stmark2-dac-7060f49dd94f
> 
> Best regards,
> --  
> Angelo Dureghello <adureghello@baylibre.com>
> 
