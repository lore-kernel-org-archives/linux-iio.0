Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795208969;
	b=XZsYBCohakEVr+6Mw7fOYgvrSwVkTX7W3fk3Sh0pnvK7GWGf8vSkadexkiS0NSyp1J+L
	 nOjEcI7yLwTmVuf2YD+YeO3yOsF7gbC48xt8yn8b7lKzUM39YxgPWKIAmUXLnaYO0Wc57
	 JqsJ2zkPaNSMkQ8p5zm2HkgDCIHmGsq9kvR+OViPlvN2863kBlR1LCMq53ZlnG/7mb2s1
	 4beiotLZYVdLfG1gt6enATVs89wP/rewIiSF0ronq+4URnHYuh93xFe7lwsXlDQzh43Lj
	 aKnmL+Y+uLR/Za1sO9kRVAbC6bkVbkprR3rfFkvnG4CTqxMgP5rnR4bpWFaURgtyigg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795208969;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=kF5gL+pAF0me5uE64gOZsyv6XMkas8uXTYMZ5GaQlLE=;
	b=dRVaCyqcWfmHPKh4djXBqYvK59AZD00jta0CviyUmf9iR2P+zUnrxZqI9GHRKRG26dRc
	 5UbZCe4I0xtB/1ShCy2EEfwB+KYhmiyAc11+TILHyMeDiP5QmJrjEvWFycDHmXbzajQWr
	 QEvL3305DQAetJq3D1SidOsbK50nX2NY3C2hJlZeqqpuL48x/jmcfhuEckJbL0p8ou9DP
	 ZdEbMMZP6U8GBNXpF/VLc76OaypsHWtr3zjwDIr59uE+ezatZOTSoloFEWJ6gqjUEFpm1
	 EOEtdhetGzAocdH1XTsKtrahIXTszGphp0EVKDQmfW9SVoZf4RayHpJXhkkGoXG4Lyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V8cuOjOn;
	arc=none smtp.remote-ip=209.85.219.42
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E769606A6AA
	for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2026 21:09:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E769606A6AA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V8cuOjOn
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-9214032a2fdso4530576d6.0
        for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2026 13:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795208968; x=1795813768; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kF5gL+pAF0me5uE64gOZsyv6XMkas8uXTYMZ5GaQlLE=;
        b=V8cuOjOnrFKjTAd+YsHJNJfu+c6XpJRVVIzjHo0iOceh35i1Jfcn1jZDGvsKJvPGkZ
         cazh8MDebVVBnywrYU1sMPm1eegOVJqJoX54LIRZn2tqtLee5fXQQMusbTKxz6WP6ldq
         jlQ7zkWMfLZywrkZIg7T71OuOzUMzlQuFcMOMGzG7to7MSj2VgI4WxMcbi7WduPjbMbn
         5BwU32gSCek1QGiEiynDuKiAoZ3Jp83PUj89qNDw3oOhKTrcjpzKQB+On7g3+Tf2r8K0
         ZWySC1NjkCBaX5xKwr5yhg1Vy0KRm3OPj8Lfu2NlAWS8Ixm40hBsM3GKm1hHAk58L6pm
         pO3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795208968; x=1795813768;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kF5gL+pAF0me5uE64gOZsyv6XMkas8uXTYMZ5GaQlLE=;
        b=dAImQtYJD/0Ru9VFI7xnDeOt8S74RCVDOFt9NWM+EtF0Cco+p9jLciHVQIWqwzlDzn
         RSIL0O+Hcqy8F7aMX5Y07ktBssPd07oE95/OMAW90a82W6ppWOv0ZOl7SJOXFLDU4Kof
         Nk9+/jEFb5x+DmkPHdOl5Ov7ox3YXB1hw5vUxacIhWBpfEWY8wpXZwSLA79IZZCKnw42
         6zWdf17cAhgcHt8WAlCemueNuv4vNz1U1fkEiaFgIzlH81+WiXbOmjN+Cq90EmM4fwMh
         vzYLVmM+TQFwmBLoSVExgEPGttY2yC2t2s+HrdTR0TgnY3KBLEwzkYj4OoOIdqbNAF8J
         FGLg==
X-Forwarded-Encrypted: i=1; AL+hErHmBnDFyFbN+VxVPtbZYXt2dsHlbZPKhxbH8cNDUwJbXAvLmLdsdZj3ESZWLl6pyLuggWgMkBdZaZc=@vger.kernel.org
X-Gm-Message-State: APuU4Z++Vd9sLVPyBAt2VaaCoDG8ysuNnPLpEcrfXfs5Hjux9bPu2REH
	lmPMDRHsIpeRgx5b232WXTGGjXhi4/qtSBKtMJKgpwD8M6WeIQHIlSDXJxDmMlF+pfA=
X-Gm-Gg: AYBFou2ZJgXxwXtE62ufdd81I4sZl8XZuSKqKYhG8Fl9IM52Fv1YT3keN2396KitJj6
	0M4oDyZDde+pZY3tnDgbCz4zHJTOWX8D9tqdV9lEBOLWDI6nV6FwKSJ3n86QV1nRSDacjJ15Rac
	Yw62vAOJEeyNFdjOIODnMAa6MhJVujSCSDaZSEuRAj/dUv8hfZw1TQTwdbYhIj/s/jjcH/+JXFe
	jsT3XyF6whNulGbhLeZtfG1hTp7n2xvfvCjuNmb3/kGfZD1hKIibk6Zg7HKxxW7e351Th8c0D7f
	Po/gf9OuUo7Q6pJHufBMPpMukJtxGqnm8cEmsjD/G0AJ07CIOKTFsjNZ6mcGh04W88u6W68vY48
	QOdpkZ6tJgsa/Bo4al1lmYNpUEwlWGk+nDW1lHZocKZLw2xfmhtylsuTLdzx2OouPGHVjzmD9GE
	8xEpi/DKP1aiNJUBlXnEPvr/oXNgS+Snpo9Wk2/oBqFccnCW1Eyjdcx0G9iuvRXtR2GZhAd4A27
	RguW7pwni0fFYliB4zaKdXifbWzf2DX75Roam/a4EvTCZNanGldsy0Y9rL3yNBroaMue7T1p24h
	l4YUvqo+XYLamlyNiSRfI2dHKbK3oYtk6rEqxSP9UZMxdr29/y/oiLToHCcY96pci1e6SjICFY+
	enwv6t1mpW4ZI7VPCOAZIh06YqrRrAuFrwnAjbYrJxpdKLlaxf2NvzfysSRQu+EgJEP6daIUYEY
	0TOtY++EFMKnrswQiTK0omVRZYmAkPxBm8ooRFCXi13g==
X-Received: by 2002:a05:701b:2704:b0:1b5:4f6d:8277 with SMTP id a92af1059eb24-1b5568e78b1mr3904504c88.26.1795208605472;
        Fri, 20 Nov 2026 13:03:25 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5566c1142sm8865172c88.2.2026.11.20.13.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 13:03:24 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Zheng Shuhao <viennaoffh@gmail.com>,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+fb951970a334aaff00ba@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] HID: hid-sensor-hub: avoid lock inversion in sensor_hub_remove()
Date: Sat, 21 Nov 2026 02:33:16 +0530
Message-ID: <20261120210317.184756-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261120121256.35339-1-ayaanmirzabaig85@gmail.com>
References: <20261120121256.35339-1-ayaanmirzabaig85@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, Nov 20, 2026 at 05:42:56PM +0530, Ayaan Mirza Baig wrote:
> Changes in v2:
>  - Pass 'data' instead of NUL to device_for_each_child() so
>    sensor_hub_finalize_pending_fn() does not dereference a NULL sd pointer.

...

>  	device_for_each_child(&hdev->dev, NULL,
>  			      sensor_hub_finalize_pending_fn);

This line is still unchanged context in v2, so NULL is still passed and
the callback still does spin_lock_irqsave(&sd->lock, flags) on a NULL
sd. The diffstat (4 insertions, 3 deletions) matches that: the only
removed lines are the lock/unlock pair and the flags variable. Perhaps
the change didn't make it into the commit before git format-patch?

Separately, Zheng Shuhao posted a fix for the same syzbot report:

  https://lore.kernel.org/all/20261120135005.566-1-viennaoffh@gmail.com/

It passes the hub data to the callback and also skips children without
platform_data (e.g. the HID battery power_supply child with
CONFIG_HID_BATTERY_STRENGTH=y), which would otherwise still be
dereferenced in sensor_hub_finalize_pending_fn(). It might be worth
agreeing between you which version goes forward.

Thanks,
Arnav
