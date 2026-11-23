Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795417293;
	b=UWinVxKTRnCGjZVBJvwDgETbgfJXizCrATq7Zj1Y9kcdd+XUjNv+2PRKznbhC9CgOfQa
	 c71JVU66Ae+a5gUHN7iXbnRYRmPod1AiI1hsVrHA9H2sBfWYkeyyBXSgSLLC7oqSVnW+j
	 hajnf7kFHJCt7bWdbgdUvtDTX6y6n3yDsr0peKWTlIB89C7MUeDaA5B7IWBG33FiXQgtv
	 q0CPuANU6Q7M50JXdApw0ZW9PyRSUxu8neDwDi/4V5RD4rcP0Vnj0i05wlTkm7FbXOrLe
	 hJ6+lTP9PawwfsGdoCPBgFd+3r8ylsp+9s8D7xvDiiPmyOAiWnwoOiIKOan8wX7p8WA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795417293;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=IEvJeXJOsH9S2fJ+fRG2KCQNfhieUtoOB+kM1PZCkvU=;
	b=c0e78f3SzzEQNLIBqbPAnHBjzwaPLw/nx4XtHmu9HtEA+RWlu3iTXqGEChzwcIAgeOtt
	 MQB8bAHWcoL+jMDR4r42YXU4W/N3xDcHZ6cRn3BfNcoqoyL0D0Ey3L3eTtET7xoGcEsLT
	 hXGyPH28thG/kFf1QD0pae3QHe3lkeF3dsq1TYVVWGJ0/31HeAshjFTPeC5TrSiWF9Yay
	 0yqpOhVHbahVGeDWlBdz011MhE2lNXpX5Df6w/7N8TWvZRY0Bp+8k7n6beOXttMtP6aev
	 UZDNSfjChhJRFEvZYbvLlgwKOY+baM+VHQYCtXIVc8Apu2Elv+EIUKaG9Bcllf0I0nQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="C/U0hB04";
	arc=none smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A813E606A31F
	for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 07:01:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A813E606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C/U0hB04
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c4cac7a7d3cso408848166b.3
        for <linux-iio@vger.kernel.org>; Sun, 22 Nov 2026 23:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795417291; x=1796022091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IEvJeXJOsH9S2fJ+fRG2KCQNfhieUtoOB+kM1PZCkvU=;
        b=C/U0hB04+pMFvd99SWH6Deft8IcvFt6LOZJuj4d/cxGdul8Lcbk65BFTXq0oe67VVa
         FVWjoEz+TlD1PhYTyNXPNV4absQQ9Q52q5KU/yyOkkbhURBVfWB0wM0ugOMLgRgOZVE5
         28rEfFhwVAhfcSwgWoEMaQobJtN4LSQ6dDSVm9V/mvSYKcoctFmGzmoGVeHhj8lDrAMp
         abaG2jP2+QWljp4iwVSgafSzcvwBnVeCAdQKoIvJUHasG/JTqnp5PDeS0dPztLorlMYD
         jQ07mkfyr159abwTtV8qQeu97/YPz40N68lGOO4hsTgSruVavGRd5SWDNLeOHFSvjgy7
         4qCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795417291; x=1796022091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IEvJeXJOsH9S2fJ+fRG2KCQNfhieUtoOB+kM1PZCkvU=;
        b=Fg4BglpBLYVdBgCi3CGq6/AztKhRD/fQsAS7p6Oy5mRjlEvUBsUtAE+Uf5LgonSgS9
         fkORcNqr1Gftta7XyvrL4SybYXbzPtucsv/A3kKOfXV72ERHFqE8dbxmtlAllvLG2T3K
         Uwh4E0aReCxZepf1QTzIfZhcRI1hqOf02eCQzgbG1i2JqwszZz3+zfdP7c5zF9pAL428
         mKJ6yRqJ7Q/3uemTdDRQfUAcOBE9FkSEeP4WxBwWHnid/1cpLwv8viH3CPe7kOHP5cKN
         JOI2oIzMhAXxRqU7OKAq9O1xrOYiu2gl/zFpkB6V2OQWTCLOuR0GB8DdMN0IFTK2gc5C
         UYlg==
X-Forwarded-Encrypted: i=1; AL+hErGu1JP+EnSc/NWCf7NPAV9mkTfFN0WnFmg8mar4BF6MBaaptZRXAqlOEp3zjNSPmy6VW2H5Y0am3Wc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8M98swRmAHcEwrdx2TS536olZOh0zzO3YTBuumgm78/MXbe111
	T6WiPgaAb8W/thO1SJumk5WJCIV6GmOg1RYsunaOyJ9wbCo5WMffSqns
X-Gm-Gg: AZFdTZeVVo0SW6GSd8AC3DVepYzzdyd6y+6vK3oy6nElVoyBLZLtFXIHCpsvvxPWoNi
	I9d/04RE5yTxQL1WwH/UxHd6l9s3bxYL/BHX6ecb3u7g7aespjL7JaMZ0Krew4xWwkza1QSojLz
	uICHI7ipaa/dKZ8RUmFe4b951aHbfiiE3bCyZ13bU6F71raU6GzBxUJX8lkM56pjBvbd0hxZ4Vc
	hD+N9hN1A5XX+SFd9LFZmEd1yi1B3bviHd8u8JdsgOfuRek1np3Peln9P61nI+fNw0FPUuVCOXa
	74KVUND9Ts3d4bUGEfcDK3xmG/cuuGzS99EVe20D4XKxSnXYcjbCYc52xhgcQBW3MvavZqqcVN5
	EGkr2lV+gUgf73ujZ/OzXTAVZxyH/ouxPJqKq9XD8ZVZVuKupwdXzjHCNxwQrMbvwdqMG1VJKNs
	6q6AMkFFqeJ/wF5Fy+V4bUiPHDtnHqcHtqVbAFIY1j/zrXwZgGe5lnLfSB34kPt9Vl8G2d9A4fG
	gUJVwUmHclHCE8xJczjkS6EGBk9EibJwaSn/xO6a0LcvaUkYO746YdKWQtN3iwEFbKbGIutuZ6T
	osnfVedfW7d9ZpXnghlO5DlKmawl/jj82JG7
X-Received: by 2002:a17:907:e00b:20b0:c4d:22e2:1a2b with SMTP id a640c23a62f3a-c513a47e2ffmr543211566b.1.1795417290844;
        Sun, 22 Nov 2026 23:01:30 -0800 (PST)
Received: from fedora ([154.182.66.143])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab658e2d60sm20779007f8f.3.2026.11.22.23.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 23:01:30 -0800 (PST)
From: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	giorgitchankvetadze1997@gmail.com,
	amin.gattout@gmail.com,
	antoniu.miclaus@analog.com,
	gregkh@linuxfoundation.org,
	mripard@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Abdelnasser Hussein <abdelnasserhussein11@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v5 1/8] iio: adc: at91_adc: skip unpopulated triggers on teardown
Date: Mon, 23 Nov 2026 09:00:54 +0200
Message-ID: <20261123070101.53868-2-abdelnasserhussein11@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261123070101.53868-1-abdelnasserhussein11@gmail.com>
References: <20261123070101.53868-1-abdelnasserhussein11@gmail.com>
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

The driver keeps an array of triggers and leaves the slots for external
triggers unpopulated (NULL) when the "atmel,adc-use-external-triggers"
property is not set.  Both the error rollback path in
at91_adc_trigger_init() and at91_adc_trigger_remove() walk the whole
array and call iio_trigger_unregister() and iio_trigger_free() on every
entry, including the empty ones, which dereferences NULL.

Skip unpopulated trigger slots in both loops.

Make a minimal fix to simplify backporting. Moving over to device managed
cleanup will shortly remove this code.

Fixes: 0e589d5fb317 ("ARM: AT91: IIO: Add AT91 ADC driver.")
Cc: stable@vger.kernel.org
Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
---
 drivers/iio/adc/at91_adc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 0ac74ad92fca..9ecf8ca362f5 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -660,6 +660,9 @@ static int at91_adc_trigger_init(struct iio_dev *idev)
 
 error_trigger:
 	for (i--; i >= 0; i--) {
+		if (!st->trig[i])
+			continue;
+
 		iio_trigger_unregister(st->trig[i]);
 		iio_trigger_free(st->trig[i]);
 	}
@@ -673,6 +676,9 @@ static void at91_adc_trigger_remove(struct iio_dev *idev)
 	int i;
 
 	for (i = 0; i < st->caps->trigger_number; i++) {
+		if (!st->trig[i])
+			continue;
+
 		iio_trigger_unregister(st->trig[i]);
 		iio_trigger_free(st->trig[i]);
 	}
-- 
2.56.0

