Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B9031A56D
	for <linux-iio@vger.kernel.org>; Sat,  3 Oct 2026 13:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791034841; cv=none; b=ZP09AA8akRLji9dZ5YrbiKDteDxTaA02LCLaX1BLukW9+lj5fCqmR/WE6ipZkRLgsubXnr76kfMQ5zTbAO8cL2yhw0BZDMMB18acEYxU7s915guhArqsoe5GzElr9fe+bWjt24ked00oZy6S+ZyNnZYytakOGRfgg7SQOhUFVzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791034841; c=relaxed/simple;
	bh=scWvonkIMb4s+tS2t+toyt1cD7sbFm8lBtOqKc6GUiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I4aeMeKZ7qZKP8eQh5MCcSfP3vaUvCsVu0rFSYCr9t1+1KDLIxcZOzJjAgdaHDeGolEknwjPcNk3opJJAvu/NVXbKiLwm+v7zE1wumMwXQhInL/SOrAYEJi17c+OAKPHL3GcW6s52cXRuAV2zsoLBcYOQ1W8AV4hPzRvysQv3g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o3Wlr4SB; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o3Wlr4SB"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f635552aso252349f8f.2
        for <linux-iio@vger.kernel.org>; Sat, 03 Oct 2026 06:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791034838; x=1791639638; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FoOR1sSt+pDsAfLanTtWSwHkmRCh3ZSjNZ3m9qdSlo4=;
        b=o3Wlr4SBll4ZLrDEvnIuiFUJfhKDFNHVGGEtcQdZeCoXXs9ZvqfQC0PNOYbVPufIie
         CCOrLscokj+z18Bqpwf2TmqXlYELWPXK3QDfFG+b3rdICzJWsQrhTuRc1EB1Nu7fWj/9
         vdIco/cad83FrO6WFCk6RgNs+CD1wiU6NwSghRJggKQcRZOfJY9MjwFr99NU+UAXZXzf
         SCxjrvMLK00qX5rBSmmReWvPtKTnT2U4uXVsenJT+gYu35cmdxKEQMobBOX0SjldMygK
         bUbZIzy6i/wmULXN4X3Eqi2tnFwwey5W9yLfcVCgIork9Vzg28G/cf0VwTSirhJcdL5y
         mYEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791034838; x=1791639638;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FoOR1sSt+pDsAfLanTtWSwHkmRCh3ZSjNZ3m9qdSlo4=;
        b=YDBF5thXk2xy663pUKKRlGf7Gse96HuK/hzF1UWfRVz2gPfl1DhLngGmmwU1NJZpGz
         g9Kqvekwn10pwlvy6WitBtxfCr2BjY00E5qqGUsPNdqBjNL0+XICRXTwmNSt5YJVMJBR
         xPfHs/v+BRf3TCF7WCetmK8C9//QdO+twBfeJRugDgRU3sK9D7VUJOAwaiVh0q9tR8ek
         6BiJkuiMApZKaimPbD9rasKzt2s+k7z04nDWGyKQ0dcEmikrItDnwwao0AbMikwpD2ww
         +gBDOBKzeTU6KdNLMMjp2ml53DRVZOPQ0QWVwbRP0yvne0iFr5HMFCcW4IbZrD7rbtAc
         rvlQ==
X-Gm-Message-State: AFq9FYI6YuLQhIAcfM0mMG0YcUacQ3X2sbk/d/Ggep+QVycEESibFoAd
	pUF/Ali2ZoWf80Xl98MkVA6UNDr/RF9Z3Egs7bT8tun35fgYd6L24Y40
X-Gm-Gg: AYBFou3DS21xH0jk62s8/GtyEzxKpotZL3i9GrYUUOOCUEAYr+e1SO/FmFK1UhCGvil
	3MN0ZV00mOIkd/Hrn0WputByHMlWyu4s937TWTgyZGPrzBE9mJlm5+O1rNvKskaVnssedFeLsDM
	2+v7yz80cyP5EP7WYSd4YjqOrWJ0LRPRsUOUSeM4KI/tcmfNa2L4d3WaBOLXWXUo1Iz1YSsWk8d
	4rrNCx5+WTjzFyq9NrhhfQtLNOILCpUPT5YotVQsD4ePc/OScP8UwjR9zy9o2xdBV8ryiwbxfNy
	Aoz03wTYppWtXWsCo67tC42bzIWTP45u+pT4tfNg0BNzt90xqQr6uT9DD8JvFbqnJMzVlxYZ6CM
	PXJZHtIkYbdRnWj24MkjqA+hgVcUF/cXjDSRnbLyv/4GTkzoKIyW9qJUyW1oYbUJ708hQjpAT/Z
	iMTz6aAPfV95xGuQR3ktFJKv6ypmSV4qtHKfEs9RzFQBx8DBEkYW5lutdAv5tocLT3JoyjMl8M5
	T9KQ27Zco4QzybzY1b1HmxWdhf8Dj+kHi2RvAHurhaleg7fS230p7z3m1wD4w0xKRBfFwdCnMaY
	yRhgVCuQJxVweER1YN8J5J4vuTiDcWldICnpPk+kEm/4RhrwGhFrIwGS3+u2m7x3MKFaoLAZM0T
	kB+KFEkPlDzQwBFVjSbY31CGUfDArKGmQ2QVkV31nhm0XRWlF2RBCDvzOVFJQPFh1HEmLrw==
X-Received: by 2002:adf:f8c9:0:b0:48a:fb1c:c2a1 with SMTP id ffacd0b85a97d-48b1274245fmr6785320f8f.47.1791034837938;
        Sat, 03 Oct 2026 06:40:37 -0700 (PDT)
Received: from localhost ([213.194.212.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b38104f89sm13693015f8f.30.2026.10.03.06.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 06:40:37 -0700 (PDT)
Date: Sat, 3 Oct 2026 15:40:36 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Yuval Saar <thefireking@gmail.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, maxwell@maxwelld.cc
Subject: Re: [PATCH v3 0/2] iio: adc: mcp3422: chip info and read_avail()
Message-ID: <20261003154036.0000115b@gmail.com>
In-Reply-To: <20261003001647.1975549-1-thefireking@gmail.com>
References: <20260919195507.94130-1-thefireking@gmail.com>
	<20261003001647.1975549-1-thefireking@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  3 Oct 2026 03:16:45 +0300
Yuval Saar <thefireking@gmail.com> wrote:

> The MCP3422 family driver tells the parts apart with integer ids and
> a switch in probe, and it exposes the sampling-frequency and scale
> lists through custom sysfs show functions.
> 
> Move those differences into a per-chip structure, then publish the
> lists with read_avail() so the IIO core creates the attributes and
> in-kernel consumers can query them.
> 
> sampling_frequency_available stays shared by all.
> in_voltage_scale_available stays shared by type. Shared by direction
> would rename that file to in_scale_available.
> 
> No hardware. Each patch compiles. checkpatch --strict is clean, and
> the available-list text was checked against the IIO core formatters.
> 
> v3:
> - Split the chip-info change into its own precursor patch.
> - Drop the sample-rate defines that only repeated the numeric value.
> - Keep scale's available mask shared by type, so the sysfs name stays
>   in_voltage_scale_available.
> - Store scales as { integer, nano } pairs.
> v2: https://lore.kernel.org/linux-iio/20260921044709.27d59a97@jic23-hlaptop/
> v1: https://lore.kernel.org/linux-iio/20260919195507.94130-1-thefireking@gmail.com/
>

Do not send new versions as a reply to the previous version,
this messes up tooling like b4 and can appear obscured in people's
email clients.

-- 
Kind regards,
Joshua Crofts
