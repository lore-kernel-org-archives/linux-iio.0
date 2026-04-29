Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62763F786B
	for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 13:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777468975; cv=none; b=VfZTtODUvsV5v2WmoFrjbhmfYpszz9plxqLYs1EDoTftR1J0RHk8mB+M0N+nxEd4Z8VwkIZyzl9Fk9SD/NbEK8wjvOeusLg8u1IsmZpO/w1d/pNw5WdSEUW8jYSnWYuU1hNeZ9TiW14GFt2M1e3fKcU8MLlqgEOSQ39FVCyVoUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777468975; c=relaxed/simple;
	bh=01DQgwaJ3ce2HaFqHqFVOsD/TYkkeJShpzCaK3dyx4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GubsbOexza2d+ou5Lgl0h80jdnntNG8gf0rO/AUBeyI3WjQGXUK1trEl8ga6TAugF1dR63iJLNVq+QRUPvJy/fEHmsGjnAotFBTjL9Dn0TkLLNXFouAJZSPv4pxv89y1ElgfqBAhDL8zr4zC8KIm74l3I/F9qur9+UuMIGDWNns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EvMG5VKB; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvMG5VKB"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c76d797b180so8534034a12.2
        for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 06:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777468974; x=1778073774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZTB0k5HzoHvpW2eiYdnzwypWK5KqzxoJlBxqEnFu+U=;
        b=EvMG5VKByiGkhnQNWvlq+k0VssqHnbUaCTMi9hYZGr5HsGBTfAbPCehd6dav8zCxrT
         pEBNgmNaUjIMMJwpKrk+ON+TNvPiZNmzIgWnv67s3t0yQDwFeJHwxyKqcPzl8J5IF/5+
         CxAn3MHz3z38B8lSfbrrFwCOAGgRxi4AfcHvQz3y0VaOz8iAmMxexzltu/abDGMC5Bkb
         /gY5ZsB4GWg2EQN0HsqNGvJ9IE2htbmU3mySv2CaSNbo33rhwGC8Va9lzMGHvgWfmv8i
         1DuQkKsqmFFby4XI61DW8XFwUj8Kz2+SMcLm0MZ6d9PeZU1x/kUCZXYIgnEEp18tQBR9
         8ccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777468974; x=1778073774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DZTB0k5HzoHvpW2eiYdnzwypWK5KqzxoJlBxqEnFu+U=;
        b=DF/bNPwAwZJpyg4yW4GhhAst++ScvN+99tUemm8yGkz/gdGkmbpe+209plYc/j+nRE
         IhVbc6euMGMk3ANbUo6RJGx75CH4bnX4d+KaNnkVwAxPeQiy+PBnrQm0TgZnLvFqvG5R
         fkdP+hogVEU3/s9ShLHprQ28l+Az5mS1SWTyRIvukO/EzVzZlVfrBiUenp/1MZEkaf0+
         Tyta+Ip6rCKE9yl23lp1ksSdfmhEsx0x2syJ0s93bap9BasYQ/JA0ja3/neZRTlzj5s+
         W07AZIUB+cqe1j6wkIWTd8yhNvPpXPROS8qBaINATU2MEOFUR5njurh+eP20VXyrMvXW
         Lmyw==
X-Forwarded-Encrypted: i=1; AFNElJ8ctjMYrhhwFGFOpgvnN08UvM+x10rakICAb/P3Tf3qNzGupoJpk6NrM4bbWrEP9/yQjBsiFWx+I9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGWZXiyiFlCz6BoE9D+dA7c5tJXTOphNzCRBmIId2A16Y9eJQF
	Z0T0zdplAAh2nst7OwzEAL9s+9PXTX6Wvy/L2xOxZsT8Voeg6DASkjKg
X-Gm-Gg: AeBDievSiczhjPnjBZk0ihkp4iCOpjqsMtifog78vu+06FcudMPOCs0i6G1y5WiuDvf
	4XH6vSL3IZtknpKiTxpUGsVicn8FslkT9UQ0l8ie+q63h97xrsAOaHh5xKOfRo2mNglLCgL8iGz
	CcRGU+d/Luz+9q0nEUm2MG+DCQ8efAlHLg3r9kFRmQFdne+gIxfFodLU2w5RuF42A1dCPdaaas9
	GdxnnJ1Xcb0VJ6+pTVtQD1aUMbZ5QNl3oBiELEoN+K4TDT/2C2UIVWKpNo3ztBNghw3V2WK7epx
	l8nphZmWf9ZwCRVbNPVg3B+rKZazPWsvmqedKzY87aSnaCxo+JVRpGil6eiEF88UbZJkZNpEZy8
	cStGvw6EW1irs0E7Nd+v1BLFgNBeaNmkpJDfSySPBRZCd2xTD+rhy0UW9t+gmS/caDW1G71wbPG
	uTEQ8tbZW5rw+KA1Xztv/FAOrbYoem3vs1d9fCzA+a+onoOwhkWXfqErt4smi1NsMtEtlPPKZfF
	Hj/+zzNRJ3Hg5p2Q28NZIYIFA==
X-Received: by 2002:a05:6a21:9981:b0:3a3:472b:2e6a with SMTP id adf61e73a8af0-3a39c058afcmr8013894637.18.1777468973973;
        Wed, 29 Apr 2026 06:22:53 -0700 (PDT)
Received: from localhost.localdomain ([2001:448a:2002:4381:3859:fd0d:505e:362c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834ed5cd407sm2091372b3a.13.2026.04.29.06.22.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 29 Apr 2026 06:22:53 -0700 (PDT)
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: branstj@gmail.com,
	lars@metafoo.de,
	ojeda@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	igor.korotin.linux@gmail.com,
	linux-kernel@vger.kernel.org,
	Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Subject: [RFC PATCH v2 1/4] i2c: rust: add smbus_read_byte_data and smbus_read_word_data
Date: Wed, 29 Apr 2026 20:22:27 +0700
Message-ID: <20260429132234.30514-2-muchamadcoirulanwar@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20260429132234.30514-1-muchamadcoirulanwar@gmail.com>
References: <20260429132234.30514-1-muchamadcoirulanwar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
---
 rust/kernel/i2c.rs | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/rust/kernel/i2c.rs b/rust/kernel/i2c.rs
index 7b908f0c5a58..6eaea1158fda 100644
--- a/rust/kernel/i2c.rs
+++ b/rust/kernel/i2c.rs
@@ -477,6 +477,30 @@ impl<Ctx: device::DeviceContext> I2cClient<Ctx> {
     fn as_raw(&self) -> *mut bindings::i2c_client {
         self.0.get()
     }
+
+    /// Reads a single byte from a register via SMBus.
+    pub fn smbus_read_byte_data(&self, reg: u8) -> Result<u8> {
+        // SAFETY: `self.as_raw()` is a valid pointer to a `struct i2c_client`
+        // by the type invariant of `I2cClient`.
+        let ret = unsafe { bindings::i2c_smbus_read_byte_data(self.as_raw(), reg) };
+        if ret < 0 {
+            Err(Error::from_errno(ret))
+        } else {
+            Ok(ret as u8)
+        }
+    }
+
+    /// Reads a 16-bit word from a register via SMBus.
+    pub fn smbus_read_word_data(&self, reg: u8) -> Result<u16> {
+        // SAFETY: `self.as_raw()` is a valid pointer to a `struct i2c_client`
+        // by the type invariant of `I2cClient`.
+        let ret = unsafe { bindings::i2c_smbus_read_word_data(self.as_raw(), reg) };
+        if ret < 0 {
+            Err(Error::from_errno(ret))
+        } else {
+            Ok(ret as u16)
+        }
+    }
 }
 
 // SAFETY: `I2cClient` is a transparent wrapper of `struct i2c_client`.
-- 
2.50.0

