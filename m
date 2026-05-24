Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70189126BF7
	for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 13:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779629322; cv=none; b=efuhUOUf6texyalxFOEANOigbPssD3SjuNiMqisZzGkyuLJYoQyDgmBB4BjAVydduhIO6yq2rWOGWA7ZmpNTx1Ak5MVJl58/izj9QBTJFwAGApOHy3YV8wi5pfLvsfB+tntF8S2NyW4/h+WdAKmHVJpYbt/fW2Dk7jw0Mo96rdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779629322; c=relaxed/simple;
	bh=HFe/kb/1zdkSbFNfPyXVpPzV9cgYhHCB1iyaej9AD00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dcu5xNNk5QMRySOuGKk/Y7k/mme+1UVds2v7omDoxtXXTF7Dt07ToE/GUcJ73pgFLzLKgOXClS2qqqkjHNa3FJR9yG8vWX7PqkBIzIMg8cKs+hHNKFnD5fNYxEGHEgLET8nfM5XcLJBlUn5dFGlwdvzyOhbRwaBqsjy4+hQjUjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DKWdwrFp; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKWdwrFp"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2bdeed4f717so45502615ad.0
        for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 06:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779629321; x=1780234121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KH21OWAYiQJp2mcLx53CxgVbtFXKc66MkLprzzmSzGs=;
        b=DKWdwrFpCHxids78RYvhuW2OTf+Aojlw03qChije8pMlCVfJya2QjoncrTRmJCK8lY
         GE55qpCPw4knmEUIyLGBfBHLI+sTCwMaPHHx3kWNI1AVb9Scx5OESjO1K7HrXzdGOA06
         8gJwTbQBdph2AWsqxxjklOfErw4EveFlijhFm7pib/2AGjTTVT8Kc6k+3EOEHlHiQo7U
         fiOg1Wyodlz7byrzAT1Ci/quf7j4+B42wdaXwE8U9SsODJXNGd0yfLkgTfWv/mOUjZcA
         F9Txlicano7VkZwVWFpgODLRpsufxwMceERPlCixiBF4kJUxqiy2tKQVGbZ7s04aHGpV
         5w7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779629321; x=1780234121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KH21OWAYiQJp2mcLx53CxgVbtFXKc66MkLprzzmSzGs=;
        b=Unco1VBPbrPpDHMWhUENu/eLgDkyTosdBYSieN8BSNdUndUmDkxcitKgZOKaRrMK1y
         IuUSoSEQkt9Zvx6zuSjjwiWciUjmk+ufjuVhjlpWG1xdaGZs6xzGDyQ/G+05bknzfLLH
         H6nCvpJ3DEjJOKjPDsxarTT6B22YFQZAdI7+kDxrDvBi8tVzshjpjkL5euqV2Ta0Kq+Q
         vNPjGAPL8BTK/QO5/C0b8SqyFLJ6tWaTzfhf83hvia/lKLg+zAgJLgIa3sTvTmkuv6oX
         8yxSlpb1sZVWZL1+9CFvgbYp8R2xg9txCQhVcs1szwcKUn2ULaHVb2mTvEznF14HOcjR
         MiJA==
X-Gm-Message-State: AOJu0YzEWQvVfmQ8yXY5yadUq0yBdpckdldUMt3fJmedRhjW78/yHcQ6
	1DRhdsjkyP9Uih3ya0RQfeBjPAMHBfrPG0XJCST12vgsUgCxG1tHZn/W
X-Gm-Gg: Acq92OHM7oo01G/W5JxMjq34/o8lBJQfQfVv8mcBRlQtZsTXgSY814nzwEUskPUesBB
	oRyOmJVctSJ94MrvxmVKL9puNuEo+/n8zu053VyvZm+NeRG2ELZz9/YC6wdUIbk08uNbIcMeytP
	YvzKzyCERc1GkKKdQOUUd5YTgvo73LutwvC5+DiXlTM6jiLnqw3wWEP7uviFHP9OjmQIkNplxPK
	SdiQUnmaXoEwHjaC2DsadHahVaL5YAkSIcVt7bxCN9twvTj5e4mDzaqTj3aiGl2UxFlmLNoL1A+
	e0SJkujtMf0zkZ+m03SF7bekDGeQp5GoltcQUeG0fvReR7QU88rmVIeWGR9ZY4AHdZxW/u+Fw1T
	lr9PrfaN00HDcT06QyMtBfVwcT0ZxISuoE+AgLvtiAbN6XnMLF3Ge2F1B0p2mtgoHzFKLhoaJsH
	KyWCFkO6n+X3L+Jx5AI2fFEbHU+cFURmhqim4FFn/Gh91mX6rc8L8aaMuygBDs7w==
X-Received: by 2002:a17:903:41c9:b0:2bd:5ab:af95 with SMTP id d9443c01a7336-2beb023584amr113265995ad.0.1779629320699;
        Sun, 24 May 2026 06:28:40 -0700 (PDT)
Received: from 192.168.1.3 ([2001:448a:2003:4286:c553:4edf:bb9:bbd2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb56f4343sm91197175ad.36.2026.05.24.06.28.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 24 May 2026 06:28:40 -0700 (PDT)
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Igor Korotin <igor.korotin.linux@gmail.com>,
	Brandon Saint-John <branstj@gmail.com>,
	Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Subject: [RFC PATCH v3 1/4] i2c: rust: implement kernel::io::Io trait for I2cClient
Date: Sun, 24 May 2026 20:28:20 +0700
Message-ID: <20260524132824.54918-2-muchamadcoirulanwar@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20260524132824.54918-1-muchamadcoirulanwar@gmail.com>
References: <20260524132824.54918-1-muchamadcoirulanwar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the Io trait for I2cClient per the agreed-upon direction
for I2C register access abstractions. This provides try_read8() and
try_read16() with automatic offset validation via io_addr().

I2cClient now implements IoCapable<u8> and IoCapable<u16> with
maxsize=256 (SMBus command byte range 0x00-0xFF).

Link: https://lore.kernel.org/rust-for-linux/20260131-i2c-adapter-v1-4-5a436e34cd1a@gmail.com/
Signed-off-by: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
---
 rust/kernel/i2c.rs | 76 +++++++++++++++++++++++++++++++---------------
 1 file changed, 51 insertions(+), 25 deletions(-)

diff --git a/rust/kernel/i2c.rs b/rust/kernel/i2c.rs
index 6eaea1158fda..cdbef6cfa344 100644
--- a/rust/kernel/i2c.rs
+++ b/rust/kernel/i2c.rs
@@ -14,6 +14,7 @@
     devres::Devres,
     driver,
     error::*,
+    io::{Io, IoCapable},
     of,
     prelude::*,
     sync::aref::{
@@ -477,30 +478,6 @@ impl<Ctx: device::DeviceContext> I2cClient<Ctx> {
     fn as_raw(&self) -> *mut bindings::i2c_client {
         self.0.get()
     }
-
-    /// Reads a single byte from a register via SMBus.
-    pub fn smbus_read_byte_data(&self, reg: u8) -> Result<u8> {
-        // SAFETY: `self.as_raw()` is a valid pointer to a `struct i2c_client`
-        // by the type invariant of `I2cClient`.
-        let ret = unsafe { bindings::i2c_smbus_read_byte_data(self.as_raw(), reg) };
-        if ret < 0 {
-            Err(Error::from_errno(ret))
-        } else {
-            Ok(ret as u8)
-        }
-    }
-
-    /// Reads a 16-bit word from a register via SMBus.
-    pub fn smbus_read_word_data(&self, reg: u8) -> Result<u16> {
-        // SAFETY: `self.as_raw()` is a valid pointer to a `struct i2c_client`
-        // by the type invariant of `I2cClient`.
-        let ret = unsafe { bindings::i2c_smbus_read_word_data(self.as_raw(), reg) };
-        if ret < 0 {
-            Err(Error::from_errno(ret))
-        } else {
-            Ok(ret as u16)
-        }
-    }
 }
 
 // SAFETY: `I2cClient` is a transparent wrapper of `struct i2c_client`.
@@ -614,5 +591,54 @@ fn drop(&mut self) {
 unsafe impl Send for Registration {}
 
 // SAFETY: `Registration` offers no interior mutability (no mutation through &self
-// and no mutable access is exposed)
+// and no mutable access is exposed).
 unsafe impl Sync for Registration {}
+
+impl<Ctx: device::DeviceContext> IoCapable<u8> for I2cClient<Ctx> {}
+impl<Ctx: device::DeviceContext> IoCapable<u16> for I2cClient<Ctx> {}
+
+impl<Ctx: device::DeviceContext> Io for I2cClient<Ctx> {
+    #[inline]
+    fn addr(&self) -> usize {
+        0
+    }
+
+    #[inline]
+    fn maxsize(&self) -> usize {
+        256
+    }
+
+    #[inline]
+    fn try_read8(&self, offset: usize) -> Result<u8>
+    where
+        Self: IoCapable<u8>,
+    {
+        let reg = self.io_addr::<u8>(offset)? as u8;
+        // SAFETY: `self.as_raw()` returns a valid pointer to a `struct i2c_client`
+        // as guaranteed by the type invariant of `I2cClient`. `reg` is bounds-checked
+        // by `io_addr()` above (offset + 1 <= 256).
+        let ret = unsafe { bindings::i2c_smbus_read_byte_data(self.as_raw(), reg) };
+        if ret < 0 {
+            Err(Error::from_errno(ret))
+        } else {
+            Ok(ret as u8)
+        }
+    }
+
+    #[inline]
+    fn try_read16(&self, offset: usize) -> Result<u16>
+    where
+        Self: IoCapable<u16>,
+    {
+        let reg = self.io_addr::<u16>(offset)? as u8;
+        // SAFETY: `self.as_raw()` returns a valid pointer to a `struct i2c_client`
+        // as guaranteed by the type invariant of `I2cClient`. `reg` is bounds-checked
+        // by `io_addr()` above (offset + 2 <= 256).
+        let ret = unsafe { bindings::i2c_smbus_read_word_data(self.as_raw(), reg) };
+        if ret < 0 {
+            Err(Error::from_errno(ret))
+        } else {
+            Ok(ret as u16)
+        }
+    }
+}
-- 
2.50.0

