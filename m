Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.58.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793699620;
	b=nRA7CWvPjI10COXy/8/WUQcVX/2KfquZiZDlIplKnjAPeDhkSvh/FM9GxCsi6/wn4R09
	 AM+C18aHceOQcEka4qMZsLdmgD4i+O05PINiAL++UazUw0bdDc/QA/4se1I9HwtlWJit5
	 Lxbadx3z4Rx/RID6thAq5v0oc2j3iVDdDaoq2K1zsVLj5Ht0mGW+ua8HbwWCtk5JMR/YE
	 8aV15H0tZosGn7hZ89NUIYFDw+LKTQ/3Xf25z+3sMlHr9K4YsMxO6h9V44P0VNYyEBKDe
	 Vb1sRgPITsyYW8BI0uEhrkV3IG+LnKyhwKWYOMc0YfUW6eXj5z/8jfuL7qPc5FbZD4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793699620;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=exuUVrZEzA5+Clh7tzMZyi/JBKCYe76w9r6sEUWqx6M=;
	b=HlytfLaQ12WlOyv8pqrYgbNVb7BDij1Sj22m80Kt51hD4ErMEWc3/KcSH56F6AzUpDoV
	 XxklgBKNbJa0ZPhCiu7akX0cm0IVEPdnmBQ77fQBkQXv7y/65wJconN2s7E89WZYWeaQK
	 dZQTjZDuOcBUXIkwq0ACuv3gpByDNYySDL0OkWcpTOgNjI07yHXvJFNkzlKO56+KHsjlL
	 5TarUOywCkBYqqi6+ug+OSSQ/clOxd4I+yZapCJ3pi6I48lBmz+5JOBmRZKIWqeqSPIuw
	 VSO0QpGK6CzBmEkviVaZh9zZR1mbzYyWNgw0JtwWAC7aypQG6Gb14Y4yrOFY8deNdvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=rPxgZSle;
	arc=none smtp.remote-ip=162.62.58.211
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F120A606D802;
	Tue,  3 Nov 2026 09:53:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F120A606D802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=rPxgZSle
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793699606; bh=exuUVrZEzA5+Clh7tzMZyi/JBKCYe76w9r6sEUWqx6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=rPxgZSle8nDOKptywmWbOo0z8RQ3mCDoGToo1AGOo0lRHC5vhQFlXeejPPN6cN9MA
	 9NBZ3MZiVaq2/5FHBGuNpvM9Bv6aJyR3hTS8FjXIF6W68J5AsXSxSbrkWn8MsYwcYo
	 UwcXoG4ZNNWAN04+No32w2/wu9ScEzdkl4iaZvPY=
Received: from shuai-VMware-Virtual-Platform.. ([218.28.192.28])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id D563F852; Tue, 03 Nov 2026 17:53:22 +0800
X-QQ-mid: xmsmtpt1793699602td0red6kd
Message-ID: <tencent_173B7731E90B9624F9F82613DC3031B70907@qq.com>
X-QQ-XMAILINFO: M07Ulnfy3VHKaC+H0tf4KCWjgzzzUw8hDxsxEI2gxvotU7+hRHwycOPVkOx2oT
	 U5ys/Cz/e69cQee+tNseErHvnO81TO8tQyWRyu8KlKcmvXvfNlFe6OXXf9RrysGhnBZlCpDQqWtL
	 RQijzEpKYUc6uPDXuN5T3tMpQNlmdKQZHXu4BUkP7SUWl0umrUwbRkb5LgswdDDn6H4RUa0clWyu
	 2TPJm+v5ugYa4Pxb5sSpBylPnxqVL2tkKmve0+6Lx5QKnjtZIQU4zuh6lJf3zcysxVxoOt9w///x
	 BVdf4KsULJ138dM6RaT8ZRKVkYWGDQMvCDBlUBks1AKsR/ah03oGSdnynxyHkyoTrmf45Dx/eLVd
	 iq2oXUL4j6hgpwKEi/fCBxN6kpF1ISCjOg4G/5313dE7b9Sggcfs7hD8wgZYFcHNNPTQdHzXu10K
	 /bRNGj9hLgcY8SDfCfWutZL0Bt03VkQJT4h51KzozPZd5yRsSRBFqdmDQ3NK3hVjOyKzSCoDNsiV
	 8opEGCHuRGMt1OIZEeV7kUQShMKg8Uq0KxZ+h/hesM3pJC4OtjVMmao6Ud+IAmNN5H4vyEtru8Zb
	 yIti6IKLmLSfjxAYDCllF8eFycihYFCSm4eMK1XnrFzqgDrwfvarMtXIDCeXSlCRfKT9C9oyMGPK
	 WsIr6R2svBOxoMRmT0A/DONZxSbJnVlcPnh7chV8Jd8gh7RBs9linMoJgU8ZPSlRHgK2tP5tcbcT
	 COcvXmo6riN7Bru2P1ipuY27DkJ+eKfxPR1PWx3eVg2izsrimhMcPz/GXTfPlvSo6EwtP/x6F6vN
	 U4Ls19KlLAdCIX/cRL154u7meTEN7FRUZKUoVEp8RfHSYkK/LeQJY3CF2bEfMikRydXKDbIqPI/h
	 NX6jsTL/dUN/2gNrkyQWc75aaErMY5FgF+Pbp23tOCl9n5L2pTSllLOed0yVTxIUphatUjStIlc7
	 f5etLVsfTixJiJ/leLP1MAf2lyhZRFKVAIVtBe6en+nnMQv4ocDJlJuX9OQqRmzFPboor/eAXDBj
	 +d7GosoY2Jbqhc62nwmoqjabP7wo7e6z0DTNUXqIonpAbXQEVGKbaxoAtTi/z7XO1YaEy8+rLteA
	 wZ+ucu
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: Shuai Liu <847807867@qq.com>
To: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Cc: Shuai Liu <847807867@qq.com>,
	Igor Korotin <igor.korotin@linux.dev>,
	Danilo Krummrich <dakr@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	Alice Ryhl <aliceryhl@google.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Mark Brown <broonie@kernel.org>,
	Brandon StJohn <branstj@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v6 0/4] iio: position: add Rust driver for ams AS5600
Date: Tue,  3 Nov 2026 17:53:22 +0800
X-OQ-MSGID: <20261103095322.297395-1-847807867@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016154819.17936-1-muchamadcoirulanwar@gmail.com>
References: <20261016154819.17936-1-muchamadcoirulanwar@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Coirul,

Thanks for the series. I read through v6, including Igor's registration
rework proposal in this thread. The comments below do not overlap with
that rework and should carry over to v7 unchanged, as far as I can tell.

1. clippy warnings

`make LLVM=1 CLIPPY=1` reports four warnings on this series, which the
Rust CI gates on. Three are `clippy::ptr_as_ptr` in the IIO abstraction
and one is `clippy::useless_conversion` in the driver:

    --- a/rust/kernel/iio.rs
    +++ b/rust/kernel/iio.rs
    @@ -202,1 +202,1 @@
    -    let priv_ptr = unsafe { (*indio_dev).priv_ as *mut T };
    +    let priv_ptr = unsafe { (*indio_dev).priv_.cast::<T>() };

    (the same pattern at lines 334 and 397; line 334 is already inside
    an unsafe block and just needs `.cast::<T>()`)

    --- a/drivers/iio/position/as5600.rs
    +++ b/drivers/iio/position/as5600.rs
    @@ -133,1 +133,1 @@
    -                Ok(IioVal::Int(angle as i32))
    +                Ok(IioVal::Int(i32::from(angle)))

2. ignored doctest in the SMBus word helper

The example on `smbus_read_word_swapped()` (rust/kernel/i2c.rs:841) is
marked "ignore" and references driver-specific facts (the AS5600).
Ignored examples are not compiled or run by rusttest, so the helper
currently ships with no tested usage. A generic, compilable example
works here:

    --- a/rust/kernel/i2c.rs
    +++ b/rust/kernel/i2c.rs
    @@ -841,8 +841,15 @@
     /// ```
    -/// // AS5600 stores the 12-bit raw angle at command byte 0x0C with its
    -/// // high byte first, so the SMBus (low byte first) word result must
    -/// // be swapped.
    -/// let raw = client.smbus_read_word_swapped(0x0C)?;
    -/// # Ok::<(), Error>(())
    +/// use kernel::{i2c::I2cClient, prelude::*};
    +///
    +/// fn read_hi_first_register(client: &I2cClient<kernel::device::Bound>) -> Result<u16> {
    +///     // A device whose 16-bit register selected by command byte 0x0C
    +///     // transmits the high byte first needs the SMBus (low byte first)
    +///     // word swapped.
    +///     client.smbus_read_word_swapped(0x0C)
    +/// }
     /// ```

3. repeated unsafe blocks in the SMBus access helpers

Patch 2 implements the `FallibleIoCapable` impls for `u8`/`u16` with
five near-identical unsafe blocks wrapping `bindings::i2c_smbus_*`
calls plus error conversion. Extracting four small safe helpers would
put the safety argument in one place and turn each call site into a
one-liner:

    fn smbus_read_byte(client: &I2cClient<device::Bound>, reg: u8)
        -> Result<u8>;
    fn smbus_write_byte(client: &I2cClient<device::Bound>, reg: u8, value: u8)
        -> Result;
    fn smbus_read_word_data(client: &I2cClient<device::Bound>, reg: u8)
        -> Result<u16>;
    fn smbus_write_word_data(client: &I2cClient<device::Bound>, reg: u8, value: u16)
        -> Result;

For example, `io_try_write` for `u8` then reduces to
`smbus_write_byte(client, reg, value)`. Happy to send the full diff if
that is useful as a starting point.

With 1 and 2 applied (and 3 sketched on top), `make LLVM=1 CLIPPY=1
drivers/iio/position/as5600.o` builds with no warnings and the rusttest
doctests pass.

Thanks,
Shuai Liu

