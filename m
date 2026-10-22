Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792641303;
	b=ae0osQEwBPvCjMklCRuA2D3gxB6AvuwyDZ0IMz1FEPv7wDuPZ6AlMintQsJJd2+s09bb
	 aLYPEo6zCf3lBOdipREGnYcPBRU12i3e2l10rqHA34v8N3zA82YJOGgr7ngThWV/hDeBc
	 HB1i+o+5gRiJHLrycygYasDTUM7LfvWMR0fbqa2VWB6KZfP0SGx7P0Bk1SyzwweepDJn+
	 BwR2DNS/hW1nFw4/NkJeRqbDgSkd99vttk1eY2yB22paRz2II+ZXGfTcSsozf4XBLGVNf
	 EoB6cZdh9KdJ7RlQlYvl+dwYRJTMmOnt4ZbwbZJA0ICSP9edIhN5pCuj7ZfHzVbz6kg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792641303;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=/7mlgXJErE8xX5o3nFwIM/2IadSxoaDFzAkWIJSoFos=;
	b=uzR8uLIXGoedr5pGTGLfucX2p99DrqSuBM1coqlv+jXCpKZ2VctB1QGudZ7l/YyyB3Uy
	 4hB5mYzoE1fdBMhWbJ88WADRtvz2vchMA0OkkOi2TtD+HxiTSlEGevkWv17yZx2MnMbxq
	 IY9sMuncu2kSdV2wJzQ1t5daR3yy2GPqNTyiRTLtoiM0zIhbv0Dgrc+AIAU0LRgOC9uGe
	 nf8LtrmgbkaEfpjraI3ZAKvMcO3jK3IhOML8veAeF1Q7JPrsNoQiXTe12n2r68R5xHrr7
	 dy993cl5JdAK/VzGX99qdTXuVlIzFKIauF/GeDSPX4QXg5rdJkrpSiPnzl1Ks/o0NxQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="CAGBZZl/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5077D606A319
	for <linux-iio@vger.kernel.org>; Thu, 22 Oct 2026 03:55:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5077D606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CAGBZZl/
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a20568c8c0so2163975e9.1
        for <linux-iio@vger.kernel.org>; Wed, 21 Oct 2026 20:55:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792641302; cv=none;
        d=google.com; s=arc-20260327;
        b=KGp8KLTNiQseZroLXbk8AqQ5X268QUcCBIQVE9zr//biwgMWYcJak5qVmamxpOuiJ5
         CvFenGYtdtpgLfvAsfQeoJUnecN0hr3sEn2ji0GrdvjkOU2lHDCFKtSy+N0dcsLuF+/5
         uia5v6hkqLzrh5vPY8CbuEJmCOHi3KiqYGj4DRKDfAHK3AGaNxPGi4GO7+95FZK3SkiI
         lO592yxu0LVrb2WjMCQ6D1Za6uuiH97cMel05HixQq5ucsBScmeWjMHUEkrHleB9uAtF
         odzHDUpwGspXhC1SPBiIYmzOXp4MR2lRiH+bzVcMV4drWTRcYDB0lAA7I46fSkusk+n6
         h32w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=/7mlgXJErE8xX5o3nFwIM/2IadSxoaDFzAkWIJSoFos=;
        fh=npSOCoPgWXHE3nR2xvTiannofPmWmz72QFkUr7vahQ0=;
        b=sXyyI0sUpLAk/vGI3Dd+yHuae97zHEUy1YVw/HEVSs+VroRuveFn24Hh9BBBQWG+Xe
         hTatsnnUU6ZBRBaFOgkFKtsimx0GfwuH7nXfKTaJGKPtPuuU9IifQk1F9XwnLhhyjB4R
         fHUlvoYVa8TIUFv/OlXugI7argQjUZm0/EvgHs2AadwHNQube74J2UNqmcr46FGuj5HD
         pRoHNe1iFvv0GVAcMJmyaivMD+lLyyw9pWAgZ2UCVTy9b6EE6SQqvgeHLKP59wCv5NTY
         A7Oa2ljFhizhTw3d4aKfMdaDgo2mdcfg+U9z6wkD4ATkhWuO+hDaQKk290Hd7xfmDhj1
         Nopw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792641302; x=1793246102; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/7mlgXJErE8xX5o3nFwIM/2IadSxoaDFzAkWIJSoFos=;
        b=CAGBZZl//w+SKdzOATkvV28W0KF+cy3EYK8+Iyn/ZcSCT0c83x2jUjU7tzRzZqKZTj
         n5chEs9lEIn4RIIQgNXGOtcm0Kp+LB/wKYJCXLEjV4JaBRs4jNp4RtIhL0ptO0IPn5uB
         87mksnkHaI1jtTU7RMumel+2MvXjjoYR5WHHGXXpsIq74SIfEvGgLYMeAq+LVZArT23I
         m8IUOY7AbNHV5poCI0ZwGbTt73jE64CSy0Nc/sKpH2wWXaS8gSdXQutrDZD+0neIj1+r
         11aoIi2MV4uIZk54lbnqnl3KqHYFa3yraN4CoMSH0QLB4RwuFyMgtheQ59LHUlGF2Q/C
         f9Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792641302; x=1793246102;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/7mlgXJErE8xX5o3nFwIM/2IadSxoaDFzAkWIJSoFos=;
        b=dPAnQN0uHu8GP2iPT0xBZpyIxetFtd1we9ZTSL8VCB+4JWNV/2iIr/gMgXOse99i1W
         MoiObUAosAETamCwAoKBPMKx0U9y32Fv84Yv4neztdO8GKRHL6s+AIy9U7eaxHDWb6rh
         iDJrOpQBPOepzPkHTATXu8GHmU9IPJyVG+bBhJWF+O3VIeSgLE1hWogEJBpG1VCw7lcb
         1dgGvjU92UTwTKh1My/KRAdCzmORavFdUkObO9v53EOhzVLDcmvyOiyxnO/+/AkhxyBv
         PDz4k5FWxUM/X5uWvWkxKOW4qahX9OMnGmg8p3CHg24QXYZDjsFyByHsd+9lejHmKo2x
         Bb0A==
X-Gm-Message-State: AFq9FYIWcwxc/pHKq6mxOknUtqWU254pUdRJXSARdyJwKwu3RHMbzEt0
	GJdiARJAEwdQgCGM06V+3sqqQafCysN6Am9pyp5YXsYq+h+yuuzZqqBGz2CIlCVVSVfKFTOtnxC
	eG2XcIj2gmQThgkLh1Sqh1p6ZurTt01I=
X-Gm-Gg: AYBFou3PwPEloQkLYF0mj0gZyPZaqrnqpScTKP3JWxg9ccSeNXdYBrzQVZaOY9/PRgl
	60Q6nt/gCnZCPnBRb+xmLgiZqXJN1OWgWq+TmKguzVomUIgElUisk7e4NfaQN0uJFG5xUG0m6HI
	fcGtijFAMdJsV1aRH8i2IFE5n8pTmK0O0SM1PXmwrVbPD9tnwOPVri8L0KNYdb8bw/1ALePtmrT
	U+m9JXAjEJItATjUqib3FaTVgw+RQVE+AnpJFl4EYF1b3+Gi9buA+F9Kexw4RfwiotUBaJfn2N3
	kUG+drG6tHswauWbzGC5Bn2j4OmJlLtpd58IzOkrzpZiIAfFrKilgmA7prctNW8tNNIrRJNmNPN
	fJ6tqgV0K6kdP62eC1CSXbgEiPRxQYIEYLActIg==
X-Received: by 2002:a05:600c:6097:b0:4a1:e69d:90e8 with SMTP id
 5b1f17b1804b1-4a1fdd44d02mr77592175e9.22.1792641301532; Wed, 21 Oct 2026
 20:55:01 -0700 (PDT)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Viral Patel <viral8854@gmail.com>
Date: Thu, 22 Oct 2026 09:24:50 +0530
X-Gm-Features: AclHuK86GA8xQQUJ5Va-YAnsnwRCUxOWK9bKR76ObS9toEpCtM8qEUJMfLzwUz8
Message-ID: <CAFkCdFwEOUq1nG42GPDHHMLDoVEWJQ63bJd2tPTJ30AKvdKn2A@mail.gmail.com>
Subject: [RFC] iio: magnetometer: Infineon TLE493D-W2B6 support - new driver
 or extend tlv493d?
To: Jonathan Cameron <jic23@kernel.org>, Dixit Parmar <dixitparmar19@gmail.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, joshua.crofts1@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Jonathan, Dixit, all,

I'm planning to add support for the Infineon TLE493D-W2B6 3D Hall
sensor (automotive-grade, AEC-Q100), a second-generation sibling of
the TLV493D-A1B6 handled by drivers/iio/magnetometer/tlv493d.c.
Before writing code, I'd like your view on driver structure.

The X/Y/Z data packing is the same (12-bit two's complement, MSBs in
0x00-0x02, LSB nibbles in 0x04/0x05), but most other things differ:

 - I2C protocol: addressed writes (trigger bits + register address)
   instead of a raw stream to a separate write-register space; reads
   use a 1-byte mode (PR bit) to read from 0x00 without an address
 - Register map: one unified map 0x00-0x16 (config, mode, wake-up
   thresholds, diagnostics, version)
 - Parity: mandatory odd parity bits (FP over MOD1/MOD2, CP over the
   config/wake-up registers); a wrong FP makes the sensor flag itself
   defective until reset
 - Data validity: Diag register (PD0/PD3 flags, frame counter, bus
   parity) instead of the channel bits used by tlv493d
 - Temperature: 10-bit, different encoding and scale/offset
 - Modes: master-controlled, low-power with 8 update rates
   (0.05 Hz-770 Hz), fast mode; full/short magnetic range
 - Reset: dedicated I2C reset sequence (FF, FF, 00, 00 frames)

Given that, my plan is a new driver (e.g. tle493d.c) targeting the
W2B6 first, leaving tlv493d.c unchanged. The same register map is
shared by other second-generation parts (TLE493D-A2B6,
TLI493D-W2BW), which could be added later once verified.

Questions:
 1. New driver vs. extending tlv493d.c - any preference?
 2. Naming: tle493d.c, or a family name such as tlx493d.c?

I have a TLE493D-W2B6 Shield2Go board on order and will test on a
Raspberry Pi 5 before sending patches.

Thanks,
Viral
