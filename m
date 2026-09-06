Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE533B83FE
	for <linux-iio@vger.kernel.org>; Sun,  6 Sep 2026 10:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788689262; cv=none; b=uU3akGGnom+2AhXoSNNoquon3SNin3jbYknMl/sKpAJMz1y07vMcT0Fj9l5Z7kvDT0xawRV+5HMiPDiUeIDWeM7lGckmcTxRaiG9IlQwQyd9uehz+FAWE6JMby88C8olzQx5WLm3kMMmNLHT/f72C1ibNvtojOcTkwICSRyJ+2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788689262; c=relaxed/simple;
	bh=RnAEc+I+Cqq4lUTdx0Q5kkcBBZ8MAk4TasWgEbgmbEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CSVbk4X6zFrK1Yuomsn9TbZGmDrQbcqTdztWFntP1xlXaxiLEcDnpXOjk6Nb0c8IlpL3zIGYg5FfdkjSm4cIh7nWzxddakE4xnStEsIJYnS2MzhDAG//zDLaJTaULQ+ni5x++yFktAckM6wsJNn9X8jW325iHSV3wYPFQCh0OoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nwAJhsK5; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nwAJhsK5"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-39faf9e2c62so18121751fa.3
        for <linux-iio@vger.kernel.org>; Sun, 06 Sep 2026 03:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788689258; x=1789294058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mv5PZ/MVDDOKzC7mTafEfq3SK5tNJ8cn62CE8cNiWXg=;
        b=nwAJhsK5Wez74zvpOpUj/YJeAaHDQYQHYt0BZzS+u8Q5dAREwsDSHbALeHxflrAu7m
         wN8zPE44HP2KaVpGvjW8gxhBzzv4/2j7l8rLXmT44+yH7q0qu6XHls46LLuCP1ZwefM4
         j5DtDUHfxb8kJZxfF6Ggi1k+6js0WG0R6RPvs9mSpsf9U6Sky2jh6y7ILs4+J3ihzHbh
         GjrjZgZuLuQCeFZNs4gA4TJ7WOkEe4caqY9hEKJpE51RsWclf2V8+h6wjwkloiRV/YWc
         UuwUU8MT/rw004s09vW3IolddvdXA8teKIGEfo4sTdui1oTGnZMOSBuLeBeIf6oHxiSR
         WPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788689258; x=1789294058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mv5PZ/MVDDOKzC7mTafEfq3SK5tNJ8cn62CE8cNiWXg=;
        b=ZaR5vmC7WF+dNh2sAjBdblSTAkfN+8YdvxeW9uGELX0cpHCBuCXuMbyJnbg8LyI/sm
         as8J4fXY4bN+8E95KkNur1sB/B69WRfA/abSCNUYajwulHphZclpKCxka17MiUqP19oZ
         J94fIap0VSMDTAwudivPlZOTZ0yu36cfXp9NL2HseuJqZVMdIiCbIzs3mBhN3Fr/k79x
         GOHsd6OylSRPfFc2BZEMr/AU/N2DHlwxzsX0OeIkXSI2TSrBg+3Oyh6bZylmxJZAkiEM
         oSLRPqWjeVL8TYTwU1v7fiosrbf4OtIgEsPrlEQb6HAiI8M91E8L3FnReWBY5oglgc0i
         h2ZQ==
X-Forwarded-Encrypted: i=1; AKwUvBzNxagPaoRONtmJzIhhpEiECdK0e5HT234AZ0D2j0aC8X5Ai9iCieDnfEuw1JRhfvXhajW4B3ukaSQ=@vger.kernel.org
X-Gm-Message-State: AFuF++l+4wwk+MAEzdrRvacw85UgC7FO9TF/CXIvhCnA9eabHT8wqG9T
	ScFKzEfj77DGCQKiq2r1+Mc7002N3Ux7FqCIOlfZMOzMh8rI+ZVzw0BZ
X-Gm-Gg: AYBFou1F4A2QBKs83UpAu06DbsDLtRxyPCBU8mHHQzZAVY9bQIxXDa+g3nEkiTunpeO
	MsZKHFbiHBnv6N6Hm0HUoZ7jgXz2ftV/zPQ/MGcZ4g4Z8Z5hM7Jn0agz4AVirszLYRPx3b0FXp6
	uhrTX5VM12vZSh5f5ntE++enGW+lZEdJyPqX+95l9vU0rWVez77mdKSN1+Hb0aEdnLnm1kB/Kl+
	RDhSdgmm0FA0YxVKl1R8No2jJV1ZzHM9mJVBEG9xrqmDmWoyq4xBrgBNImg92sVPpkvQi7vwOGr
	l3KFYxy6VZND8Y2dYQBYHekiMSBcP3Am/ZZA9IXiQv4uaw6i7TgADdowh3p+G6lQ2/vAvF99Ki/
	NN2ELzDuF42NpXQYa8i9GcBu+YfMlIsPf1Vw3xirB6fq5mO84c42uRmmngAkYTXRyvf8VzAKtkT
	K6QV7izDWqnOXwJD63n+Aii0c0PPz1NuJlXdK1iBRM4Q+jPu3TNVSrdHcZVoZBp6bahWbjTSCBD
	dHuHsV7OokiC+naHb4ZZHKP2qm6xrsEkWcmvVkflcD5v6pFPW23xJIrIA4=
X-Received: by 2002:a05:651c:552:b0:3a3:74b9:8a78 with SMTP id 38308e7fff4ca-3a374b98afamr15556071fa.17.1788689257905;
        Sun, 06 Sep 2026 03:07:37 -0700 (PDT)
Received: from yantra.. (dsl-trebng21-58c187-236.dhcp.inet.fi. [88.193.135.236])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a3705a9b4asm21482421fa.31.2026.09.06.03.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 03:07:36 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Bill Wendling <morbo@google.com>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Joel Stanley <joel@jms.id.au>,
	Justin Stitt <justinstitt@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v6 5/6] iio: pressure: dps310: add hardware FIFO support
Date: Sun,  6 Sep 2026 13:07:29 +0300
Message-ID: <20260906100733.435411-1-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ao1i3hKEpAgHLICz@ashevche-desk.local>
References: <20260824201203.396651-6-zoone.rupert@gmail.com> <ao1i3hKEpAgHLICz@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 25 Aug 2026 12:39:42 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> I stopped here, I think you should understand what this code is all doing. Now
> it's an AI mess. Split this patch to a few smaller ones each of them you understand.

v7 splits this one into three:

  read buffered samples from the hardware FIFO
  derive the drain interval from the watermark
  implement .hwfifo_flush_to_buffer()

The timestamp estimation goes entirely, which Jonathan asked for. With 3/6
split as you asked, v7 is nine patches.

Retesting on the BeagleBone turned up a bug here: the drain discards the
compensation temperature when a batch pushes nothing, so a capture can fail
to start at all. 4 of 6 buffer enables produced nothing in 3 s at 32 Hz
pressure and 1 Hz temperature. Numbers in my reply to Jonathan on this
patch.

> Can _rate:s be negative?

No, both getters return BIT() of a three-bit field, so 1 to 128. Errors
come back through the return value.

> 30 * USEC_PER_MSEC

Pre-existing, like the min_t(s64, ...) from July. Both are in the cleanup
series rather than here.

Rupesh
