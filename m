Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEBD4E1413
	for <linux-iio@vger.kernel.org>; Fri, 16 Oct 2026 15:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792165719; cv=none; b=JLn3yRG8Lg+80jy0v1j7/iroyF9B5Sgom7NrB2RvaxFmC0FLJ0BQTW8i0oWw0NnzsM5kZSLaom/PphBG5OlXz9eaCSXPJzYcVqcZdedj/i/k8QHANdwNk5MZjMFeU7eMe2dmWqo0EKmaaWUPQTXErEjd9Z80/UBhH9kkRKpj+Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792165719; c=relaxed/simple;
	bh=17tedGYcRNdDnq1dKIJYkX8tB8XKf3YAkAWYjfskwm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AAt9JgPA/9dU0seCk2dLLbNbheZnN0oUstS7nl7MqPG0a8DaBiCAZ0sf9QSMUy/UJjppF1QO4bGj16S++H0WUAhve3TRSlChZegFrr+IegSzTVjqC92rA2FSTmITa+mbqdjgNC2CI93sYFCtNJoK7rKafApAhJ8lHtp8dREYNW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E7XHSded; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7XHSded"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-67989a2f9bfso100485d50.3
        for <linux-iio@vger.kernel.org>; Fri, 16 Oct 2026 08:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792165713; x=1792770513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=plcoVhgmwxTvzaBDkme5sEgwM7GIbrXBdBohLzMS+Gs=;
        b=E7XHSdedTdBbfvbXhK7qDQOcR00m0b8Q8VQmxbETZCxXEFgViVnzU7V+RRj8k4Osd+
         KupMFLy1C5WlNrkcZ/M5q9pe+NTwG0hIsOHSCqvgAIKag44xFGHhrGDgLZbAl6J6Mzin
         WlkgtR0wNvZH+ydGIdAq3gQOPFyUFDlcb0xKYdKwXVNNF3nSiAiBIFkegMpTK74JNatp
         r9C8ae/QRAJ3sEHRDB8OKsLRgUeL2d0R8K2wcEAGjgRo24H0ZmwTxQquL7j165gl2dEx
         stnWS7aaeFeo6S74b2vrzgtO/Xbxlxnzge5kmqjP1Q/n1MP7ZZP6/I1iq9NIGBXziI/k
         bHmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792165713; x=1792770513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=plcoVhgmwxTvzaBDkme5sEgwM7GIbrXBdBohLzMS+Gs=;
        b=cqsFlRyPltv29q83IqFhRr1QVjDC8K9MOxCqnXBnEN7gkAL2yALzvovxNcYHxeXVKx
         PdsrM3XZC9wc6/m7phW/X3FNep85ZlW8sk61ZatVPRGt8cNMVAKnuZ7To1mTUFgrG9w4
         VV1Zb3aKkrQgkrcXkh9XwxGEVA9TFbnkR+JTaNCxweweaTznwHmTRt0q3qKDJ32zAAwI
         WMK6d9y7bUuYo7HtFSBQQX5pp1xGFxWpgJja7zJcboAXmNhcoGz62RC00Wi/8igKM4Z+
         xGijVwP8CzzHI2BLCfSA13RTrc1PTZfcZaWpDlALmaG0NaIQtJl3v4eF/8dHCE8P3o9h
         e41g==
X-Forwarded-Encrypted: i=1; AKwUvByhUCB4QQ0N2HbfaopyoyfPWU6RN9F+Hz0eQhBi2yC0Sow/hHae6FHcrjFaEGZCf/lZxeFhJxGhwLA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLs99bExXcdLovU9dAYtwHKd4IFL3MoKElmKH1KYxg3iNG3f0zY
	SSHrRQ9OsABQfHIROQuPn35zbjaoQNirQNKO8va27NP5jkn82YpxhbXY
X-Gm-Gg: AYBFou2NrZ8zrxyZHpMYVUE6GFkUG5U1qiSPMdT8NiV5L/v1T9XHcUFtz49epM1nhJl
	znTIkDtpl6TW/ujkAZacNDRB+ayerPv7Cms85cDmb8MGLue2kqKIjy7QqRu915fuTcGJNlIK17k
	4LjiEj+IAXhdDW6QaC//f5qA0C697svjddZQW6/tWVnzVsfjRrmrYLQcpGSr/mXGiIP6CBxKoTq
	g+4k801h+JzBf7kg2cp+4B25H3C5wUMqlDcQpgwcvvkANnIB348kkXP0xMZgFTmY1AwZumdDNC9
	leeqaB7tHIpd1yL4lARQ2cDs0NNKMotlNTGPYO4cZlk2S6UYa/egepgt+zZEUkzz0rf7C9tjafV
	ngEe8MAL+SMdvFUdzc5l3/ypV/O0dkArCUPEShWe0BdH9rEePiZXNY356XALTehk08csx9o0SLf
	3AGUVsTjKovt0F/3O5J9r1G/4osHx/5eVw2gztYw4LZFjCp9MRnwvm0Osd7UXd8AR5TyOkdykm9
	RGy9jsM6AteQvZ0di3mLVZTXLcy14p/Q4ciZ0c=
X-Received: by 2002:a05:690c:e68e:b0:8b0:6617:e241 with SMTP id 00721157ae682-8b0f20752cfmr1168687b3.4.1792165713522;
        Fri, 16 Oct 2026 08:48:33 -0700 (PDT)
Received: from localhost.localdomain ([180.243.241.21])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b0e593c65bsm10882167b3.38.2026.10.16.08.48.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 16 Oct 2026 08:48:33 -0700 (PDT)
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Igor Korotin <igor.korotin@linux.dev>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Mark Brown <broonie@kernel.org>,
	Brandon StJohn <branstj@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v6 1/4] rust: io: add FallibleIoCapable
Date: Fri, 16 Oct 2026 22:48:16 +0700
Message-ID: <20261016154819.17936-2-muchamadcoirulanwar@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20261016154819.17936-1-muchamadcoirulanwar@gmail.com>
References: <20261016154819.17936-1-muchamadcoirulanwar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a fallible I/O capability for backends whose accesses may fail
independently of address validation.

Route try_read, try_write, try_write_reg, and try_update through the
fallible capability. Provide a blanket implementation for infallible
IoCapable backends so existing users retain their current behavior.

This allows transport-backed implementations such as I2C to expose only
fallible access while keeping infallible operations unavailable.

Link: https://lore.kernel.org/all/DJVQ852J7SOH.26YBIJTQ9B66G@kernel.org/
Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
---
 rust/kernel/io.rs | 66 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 46 insertions(+), 20 deletions(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 95f46bb75f9e..516895ca2082 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -276,6 +276,36 @@ pub trait IoCapable<T>: IoBackend {
     fn io_write<'a>(view: Self::View<'a, T>, value: T);
 }
 
+/// Fallible counterpart of [`IoCapable`] for I/O backends where operations can fail at the
+/// transport level (e.g. I2C, SPI).
+///
+/// Infallible backends ([`IoCapable`] implementors) get this for free via blanket implementation.
+/// Fallible-only backends implement this trait directly without implementing [`IoCapable`]; the
+/// infallible [`Io::read`], [`Io::write`], and [`Io::update`] methods will then be unavailable,
+/// enforcing that callers use the `try_*` variants instead.
+pub trait FallibleIoCapable<T>: IoBackend {
+    /// Performs an I/O read of type `T` at `view` and returns the result, or an error if the
+    /// transport-level operation fails.
+    fn io_try_read<'a>(view: Self::View<'a, T>) -> Result<T>;
+
+    /// Performs an I/O write of `value` at `view`, or returns an error if the transport-level
+    /// operation fails.
+    fn io_try_write<'a>(view: Self::View<'a, T>, value: T) -> Result;
+}
+
+impl<B: IoCapable<T>, T> FallibleIoCapable<T> for B {
+    #[inline(always)]
+    fn io_try_read<'a>(view: Self::View<'a, T>) -> Result<T> {
+        Ok(Self::io_read(view))
+    }
+
+    #[inline(always)]
+    fn io_try_write<'a>(view: Self::View<'a, T>, value: T) -> Result {
+        Self::io_write(view, value);
+        Ok(())
+    }
+}
+
 /// Trait indicating that an I/O backend supports memory copy operations.
 pub trait IoCopyable: IoBackend {
     /// Copy contents of `view` to `buffer`.
@@ -645,7 +675,7 @@ fn copy_to_slice(self, data: &mut [u8])
     fn try_read8(self, offset: usize) -> Result<u8>
     where
         usize: IoLoc<Self::Target, u8, IoType = u8>,
-        Self::Backend: IoCapable<u8>,
+        Self::Backend: FallibleIoCapable<u8>,
     {
         self.try_read(offset)
     }
@@ -655,7 +685,7 @@ fn try_read8(self, offset: usize) -> Result<u8>
     fn try_read16(self, offset: usize) -> Result<u16>
     where
         usize: IoLoc<Self::Target, u16, IoType = u16>,
-        Self::Backend: IoCapable<u16>,
+        Self::Backend: FallibleIoCapable<u16>,
     {
         self.try_read(offset)
     }
@@ -665,7 +695,7 @@ fn try_read16(self, offset: usize) -> Result<u16>
     fn try_read32(self, offset: usize) -> Result<u32>
     where
         usize: IoLoc<Self::Target, u32, IoType = u32>,
-        Self::Backend: IoCapable<u32>,
+        Self::Backend: FallibleIoCapable<u32>,
     {
         self.try_read(offset)
     }
@@ -675,7 +705,7 @@ fn try_read32(self, offset: usize) -> Result<u32>
     fn try_read64(self, offset: usize) -> Result<u64>
     where
         usize: IoLoc<Self::Target, u64, IoType = u64>,
-        Self::Backend: IoCapable<u64>,
+        Self::Backend: FallibleIoCapable<u64>,
     {
         self.try_read(offset)
     }
@@ -685,7 +715,7 @@ fn try_read64(self, offset: usize) -> Result<u64>
     fn try_write8(self, value: u8, offset: usize) -> Result
     where
         usize: IoLoc<Self::Target, u8, IoType = u8>,
-        Self::Backend: IoCapable<u8>,
+        Self::Backend: FallibleIoCapable<u8>,
     {
         self.try_write(offset, value)
     }
@@ -695,7 +725,7 @@ fn try_write8(self, value: u8, offset: usize) -> Result
     fn try_write16(self, value: u16, offset: usize) -> Result
     where
         usize: IoLoc<Self::Target, u16, IoType = u16>,
-        Self::Backend: IoCapable<u16>,
+        Self::Backend: FallibleIoCapable<u16>,
     {
         self.try_write(offset, value)
     }
@@ -705,7 +735,7 @@ fn try_write16(self, value: u16, offset: usize) -> Result
     fn try_write32(self, value: u32, offset: usize) -> Result
     where
         usize: IoLoc<Self::Target, u32, IoType = u32>,
-        Self::Backend: IoCapable<u32>,
+        Self::Backend: FallibleIoCapable<u32>,
     {
         self.try_write(offset, value)
     }
@@ -715,7 +745,7 @@ fn try_write32(self, value: u32, offset: usize) -> Result
     fn try_write64(self, value: u64, offset: usize) -> Result
     where
         usize: IoLoc<Self::Target, u64, IoType = u64>,
-        Self::Backend: IoCapable<u64>,
+        Self::Backend: FallibleIoCapable<u64>,
     {
         self.try_write(offset, value)
     }
@@ -827,10 +857,10 @@ fn write64(self, value: u64, offset: usize)
     fn try_read<T, L>(self, location: L) -> Result<T>
     where
         L: IoLoc<Self::Target, T>,
-        Self::Backend: IoCapable<L::IoType>,
+        Self::Backend: FallibleIoCapable<L::IoType>,
     {
         let view = io_view::<Self, L::IoType>(self, location.offset())?;
-        Ok(Self::Backend::io_read(view).into())
+        Ok(Self::Backend::io_try_read(view)?.into())
     }
 
     /// Generic fallible write with runtime bounds check.
@@ -860,12 +890,11 @@ fn try_read<T, L>(self, location: L) -> Result<T>
     fn try_write<T, L>(self, location: L, value: T) -> Result
     where
         L: IoLoc<Self::Target, T>,
-        Self::Backend: IoCapable<L::IoType>,
+        Self::Backend: FallibleIoCapable<L::IoType>,
     {
         let view = io_view::<Self, L::IoType>(self, location.offset())?;
         let io_value = value.into();
-        Self::Backend::io_write(view, io_value);
-        Ok(())
+        Self::Backend::io_try_write(view, io_value)
     }
 
     /// Generic fallible write of a fully-located register value.
@@ -905,7 +934,7 @@ fn try_write_reg<T, L, V>(self, value: V) -> Result
     where
         L: IoLoc<Self::Target, T>,
         V: LocatedRegister<Self::Target, Location = L, Value = T>,
-        Self::Backend: IoCapable<L::IoType>,
+        Self::Backend: FallibleIoCapable<L::IoType>,
     {
         let (location, value) = value.into_io_op();
 
@@ -938,16 +967,13 @@ fn try_write_reg<T, L, V>(self, value: V) -> Result
     fn try_update<T, L, F>(self, location: L, f: F) -> Result
     where
         L: IoLoc<Self::Target, T>,
-        Self::Backend: IoCapable<L::IoType>,
+        Self::Backend: FallibleIoCapable<L::IoType>,
         F: FnOnce(T) -> T,
     {
         let view = io_view::<Self, L::IoType>(self, location.offset())?;
-
-        let value: T = Self::Backend::io_read(view).into();
+        let value: T = Self::Backend::io_try_read(view)?.into();
         let io_value = f(value).into();
-        Self::Backend::io_write(view, io_value);
-
-        Ok(())
+        Self::Backend::io_try_write(view, io_value)
     }
 
     /// Generic infallible read with compile-time bounds check.
-- 
2.50.0

