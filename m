Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344714E0B98
	for <linux-iio@vger.kernel.org>; Mon, 21 Sep 2026 18:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790015464; cv=none; b=fgsjffgLIVaYkQVDtk7O0LQHKOms4GXf705mZyqKCmZoLRYCXRzZedD2b06ztUDbmYusNwWvZlX4dxhgtmAaeoAr2bc/vhCwnUR40N7dPIFqGPzO1KqxJ1P9D64WRY3HUIQZdwXQ9AKWP+/S5Wbaf9yGSf21O7IHCGoKn4W1D78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790015464; c=relaxed/simple;
	bh=TTaDVJxvd23TMPUHinu1BvIxlfSLR9eQbV5/IV4Szh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fcc+hvyklva1zAZguzN7FyeZqO41DqXKp0btacf5jVi/BE+q9JJ00A7TISdJ3WfLMnQAjnSM0SXOaV1hJMuNzB7h2EV+zpJ6ixjI5Gb/nQDjB9bREqymQ3L0S+OcUO5iIpPMRf5fts1oEfAbwMUZo5h5r8Wo7Qyd6Rnv+w0w8hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pEyLUGer; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pEyLUGer"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3a49a40209dso1036181fa.0
        for <linux-iio@vger.kernel.org>; Mon, 21 Sep 2026 11:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790015461; x=1790620261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cK98X0r3BDRCEVKy2aZh2DV2AxA23p29nMm/EUx3t08=;
        b=pEyLUGera5obyGqCVkZxERmBe387Qro3tAC2anEbF8GrILs4AyahMo1GNp143DPK0Z
         t85itCgNDErCbn+10oPaJ7mGPMBDXs0dWtwsLRD0zjv6bL44/yYM7Jd6m8xV0PzMSFJ+
         KTtJH0fT8JzUgwwS+1/ea8iln4BIbXZTY7rYMRxvAXvPdgIItucFjI9Sv+HNuuyaupZu
         3/eBeeC6V0gtq2PTxofhLNoGrOUemCLIsHqMdYUbIApvsRSDDwEHR4DFapL2Owu7WEai
         BkZivpZkHVLnpXnh5loCFOvsuqWU1hPvI9qVG+Uwct6N+x9sDC11MbgafZhlVTU66Gai
         B0og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790015461; x=1790620261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cK98X0r3BDRCEVKy2aZh2DV2AxA23p29nMm/EUx3t08=;
        b=ANcwKiEwxhUf/eMgZzj/fgjMLyTQpYLt2PuzUcAjnkxh8j4zJorMG0s6xJ7cNNmdSO
         yL4FsW1GkvkVDS0cH1lkp9KpFMb2vLrN+PcgyzAeGmHsa7R+CenH/nu8kqxYVZyBpaF3
         vNbmIGXfubnohRbnN7Lk4vnIZU1bgrQTxM2PgWLAgPaTFz8WGGIohuyUij7lD2uofd9y
         hiZlG0zdmhpZBiO7vIOk0jI1acEZL3P6jL4PXPw5lhMbUc4tH9SRY9fty0Jcn29E71al
         iQj5ssB153RNJkDrXC1OHxFk5g8b0BrjNZH897d/k0BNsp50PFBPZ+DV6hgr4ChXfeId
         wP2w==
X-Forwarded-Encrypted: i=1; AKwUvBxyXjiDhW1QeeKQ7CGN5qM4zdWTXuwUnxBYVfPNNsFmcfC0QkQ1KT6R5fbB6lGQMHENuj6chsBRj7s=@vger.kernel.org
X-Gm-Message-State: AFuF++mCev+TkST6nOHNDG13Le36p9Rfv3BgT+kLK/iSj8S4W0fLtJbB
	iWOd3J+rTOSdLQAL6K5wUgrPgwRBhIB4r14rA3dEUXwj2A48U4RbmehvsHvWbJIw
X-Gm-Gg: AYBFou0bv2GIoTRLHpAStEDu5Jx9xOKYJNJcCU5vAnvyJ84GEakFX9/8Yl+5QDaK7Z4
	lqodmm5t7bKrCAJFQ49LVwDAgZUvFgL1tw5D69uPxHP/5oF3B/awaP3iss88iS7rip1Cx7ebbga
	X3N9/HcjRqyxCJ/toV0l+hf0Tl7K9hcgV5nAwWxh1UjZcP5DQsq/EaqIiW1i4Xpyp7zl6dlG/6a
	/K5uN64tk/LBaT+AHccSd/E9MYw+Cs9TTAYRoNx8o+3Gu9dQl27+axIP5Zcm4i68OT/Qr64/6RF
	bosc4AnwegayZZkKJRmgRVqgMrs6PSHXvlvugNLlxqYBDj2kAs0bRc5hDES1rBfTJA0DT9HCLjz
	Xi4btCWxqf4FFNTk21BozKcDhuP+wLDGZRvdUYAVefblGa+Xwr6Z6x0YeqvXE42Dj2WLU+sN2uI
	UuwXj7YaOHsuVacT11hWN+2hYLqVVSoazjnFMLRA18iyKI6rrFatMXAxW5KPe86GALrnr5F1Lat
	z1vKNCHrNuyQF9ARX455w332gGC8ycUkjl0Si5g5hxJVVymHpszHdw9nKedvyJ7DUGa6HA=
X-Received: by 2002:a05:651c:1474:b0:3a5:d31c:71a8 with SMTP id 38308e7fff4ca-3a624c8eb8bmr1246471fa.3.1790015460867;
        Mon, 21 Sep 2026 11:31:00 -0700 (PDT)
Received: from yantra.. (dsl-trebng21-58c187-236.dhcp.inet.fi. [88.193.135.236])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a6075fcafbsm23739241fa.27.2026.09.21.11.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 11:31:00 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>,
	Bill Wendling <morbo@google.com>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Joel Stanley <joel@jms.id.au>,
	Justin Stitt <justinstitt@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v7 07/10] iio: pressure: dps310: read buffered samples from the hardware FIFO
Date: Mon, 21 Sep 2026 21:30:59 +0300
Message-ID: <20260921183059.231935-1-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178992913316.706584.7705975324672941059.b4-review@b4>
References: <20260918122517.377565-1-zoone.rupert@gmail.com> <20260918122517.377565-8-zoone.rupert@gmail.com> <178992913316.706584.7705975324672941059.b4-review@b4>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 20 Sep 2026 19:32:13 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> Given n is used in a couple of places, I'd keep the handling simple
> by doing it as
> 	for (i = 0, n = 0; i < DPS310_FIFO_DEPTH; i++, n++)

Gone down to one counter, since n only ever tracked i here. Patch 9 adds
a max_scans break after the store, where that form would lose the last
entry read, so there the test moved to the top of the loop.

> > +	data->fifo_hold = NULL;  
> 
> Why clear fifo_hold?  Nothing ever checks if it is NULL.

Nothing does, so the function had nothing left to do and both callers
just kfree() now. The clearing moved to the alloc side, otherwise a
pressure session followed by a temperature-only one double frees.

Rupesh
