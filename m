Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E220E353A62;
	Sat, 11 Jul 2026 10:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783764330; cv=none; b=t8Nn7aITDUgZ7zg+P01bIbBRWwevgJIAw8TzwQ3UJ5VYIZlw7x+Loki9rkmv9AQCtBreR5fDaiQa7dwNVrHVbItAHAVLfq1B3/OlkU+70CdKu3nHYC1GXDthEcTzqYdVVcfRuXy7b7vE4Q0F2UL9QWGBHvL9vAg7mDNeqtcnQ3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783764330; c=relaxed/simple;
	bh=XeqtZDBObbe74VEoiaORdWOe6v5UrT29UxzIDvBmrtk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Message-ID:Date:
	 Content-Type:MIME-Version; b=XKiIdkfXd1npdhK7WZ5QB9tXpLOJBkC1icsu9NyWYSneZ8TTmyc2NnnVHQKxuiLYFACI7f3jJyy+A1nbezkupdfNE4JsX0fgDFDveAk+N6JY7nDhuQ6zIZJcrJiXrCKE5bE4Gctdgi21dy+MtBPHUgsUrKVtCQWSAYvpjG49dQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WayvsVos; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WayvsVos"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783764316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iOE/Q2XSh0FcWlIlJBT2IIO2PedQr0Ik4Q0k8uUwmUs=;
	b=WayvsVosuY+Wv6qUD6Sc38b+E2zKMg4bLcm1+pWbFSx6HQSU0L/i50kNe6NknkWU7A+cBV
	puUVjfw6ad9X7tCAZBLsovKjoyuYhiWvJxEVIsYZxf/WKeGxhZfWV7e8naZUBePkR3FOLM
	Q89Ex9A25fERNAUU1fwUyxxRkDJnwrQ=
From: Igor Korotin <igor.korotin@linux.dev>
To: jic23@kernel.org, lars@metafoo.de
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-i2c@vger.kernel.org, andi.shyti@kernel.org,
 wsa+renesas@sang-engineering.com, ojeda@kernel.org, dakr@kernel.org,
 branstj@gmail.com, Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Subject: Re: [RFC PATCH v4 1/3] i2c: rust: implement SMBus read abstraction
 via kernel::io::Io for I2cClient
In-Reply-To: <20260707151542.91997-2-muchamadcoirulanwar@gmail.com>
References: <20260707151542.91997-1-muchamadcoirulanwar@gmail.com>
 <20260707151542.91997-2-muchamadcoirulanwar@gmail.com>
Message-ID: <178376430529.16552.7043868463863908196@linux.dev>
Date: Sat, 11 Jul 2026 11:05:05 +0100
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT

Thanks for reworking this to use `Io` as agreed -- the direction is right.
But I think the fix is incomplete, and it points at something I'd like
Danilo's take on.

try_read8()/try_read16() are overridden here with real errno handling,
bypassing IoCapable::io_read entirely -- necessary, since io_read's
signature (-> T, not Result<T>) can't carry a negative errno from
i2c_smbus_read_byte_data.

But that override only covers two of Io's entry points. The generic
try_read<T, L>, try_write<T, L>, try_update<T, L, F>, and try_write_reg
all still route straight through IoCapable::io_read/io_write and aren't
overridden here. Concretely:

- client.try_read::<u8, _>(offset) (as opposed to try_read8()) silently
  casts a negative errno to a garbage u8 on failure -- the exact bug
  try_read8() exists to avoid, reachable through a different, still-public
  method on the same type.
- try_write8()/try_write16() aren't overridden at all, so any write
  through them (or the generic try_write) discards the real SMBus return
  value and reports Ok(()) even when the transaction failed on the bus
  (NACK, arbitration loss, timeout).
- try_update() combines both problems in a single read-modify-write.

This driver only calls try_read8()/try_read16(), so AS5600 itself isn't
affected in practice. But the abstraction being introduced here would be
unsound the moment any write-capable consumer reaches for it -- and I
don't think patching try_write8/try_update one at a time is the right
fix, since it just leaves the same trap for whichever method nobody's
gotten around to overriding yet.

Danilo -- since using Io for I2C was originally your suggestion, I'd like
your read on this before we go further: IoCapable::io_read/io_write are
infallible by signature, which holds for MMIO/PCI-config (bounds-checked
implies success) but doesn't hold for a bus transaction -- I2C can
genuinely fail per-transfer regardless of address validity. Given that,
is Io/IoCapable the right abstraction for I2cClient to implement at all,
or does I2C need its own fallible-native interface rather than overriding
pieces of this one?

Cheers
Igor
