Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794645331;
	b=dLLYoWEqk9R2/+x2/yiDVw364nUt+Kv9r6efenq2qaNqR1/e4QEEQcLJjZ8CK0zoPIkf
	 yo0F4rGBff+B1i444SnVdCvXFS5lzgoPfATCx5YR6FgYf2bWmKXegJ9qYfzubu5CS9jkn
	 2teIdPeuzNSjUgVLG/rIeHdOBG1OPFiFFGCpvzbdafESHgfZ3IYfLjBqD1ZZiqnUsTWmW
	 9jSYynejJudevge7zHuK6mymGutzLWXwpL3BkR5SoEno7epU9/vP+e6HB4vaUXsvMpYe1
	 41N7OplMXKdSTFLgiS0X4xFMr5w3vbiPNEQG1WxA8CrP8PKlGRm4daD87Z73Cmg8yog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794645331;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=yfnJG4iiDKKQuxyCDYfideniNtJsvgutAwnUooh0Jdk=;
	b=EX7EyG/RT3K7l1yDzn21JPap0EoejKtsp/O7ftRD8K8SGCHKwGDb/PoS7x0utBgWAZch
	 XdesMLkelspmEbp8sD7AMP53FKEx25YIGkBUlBMeyE7wgD6KW6rD4oSt+yU26oZCn/AlJ
	 yqY2ABYvCvQ1NlJxaMVUtN+1rwYmFurjlBbVBm4lqcuexCmRLw1aVhKLSI6dbImvhFUF7
	 ZAvwSX6xoZpAZUTFzK/tIbCUuc9usMOUP5R3jlsiOQdKuaNZUbEAXqDlM/7lhOzQR4nCL
	 qydgbBC0zebPNLv0sWjyGFZAMCrRLOYVAP+gON6/3b44MtL/YufdXE2NlsHCR11a7HA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y37AXEGZ;
	arc=none smtp.remote-ip=209.85.167.49
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68416606A329
	for <linux-iio@vger.kernel.org>; Sat, 14 Nov 2026 08:35:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68416606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y37AXEGZ
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5c1465bbbdaso1909984e87.3
        for <linux-iio@vger.kernel.org>; Sat, 14 Nov 2026 00:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794645329; x=1795250129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yfnJG4iiDKKQuxyCDYfideniNtJsvgutAwnUooh0Jdk=;
        b=Y37AXEGZNRjjow8p4LgjZLoRKWt+vX4mg8SYvuImT7FGNVyGidP9cBiU+r9aFgF/Yk
         APWWK33jwEvWKXta0k6KDONTButeyotr3NxYw05JrR9yVuPscVHnKuuaKSwyqY87IvAZ
         f0clJOvbwYnoDcdd2V8hHQs+lUqQ9EKgm/h6fUsnrrZ3QVo8TxEDcrj0ZxFIXJJntXPU
         2wQ0t9E2rUx5W1SnFl1JVxao7ECM8XiXbyLpN6PGyQV0Ezph2uKLrCpUUgjKy0aLhmXq
         A8nMvYmMfMSW7YkUUHEd7/vSv9ZOhTX6HGsYZV7J4USXZmbpEg6e8kSbiLzLfaFLv3ZB
         QEMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794645329; x=1795250129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yfnJG4iiDKKQuxyCDYfideniNtJsvgutAwnUooh0Jdk=;
        b=k6py7ZxJlAoRWsUnkTP6MnaO1SDkiziamLYl+ssAD7nDjF+89oVtn4BjH/O/5E4tQI
         uh4v6fZI90ol5DELRUpmAnLENfGxi5EwkPDeKqseTs0PoroCqTT/tPDglcnlEIQrWYRy
         VolMa3jdzcZJcxEzH13vGgaj3fYRj7pXEUqRBtxjqAWzUeg+3FVRe8g/r9zpKHJ1/E8o
         tGan2bGNWNTMmZUve2uEzw17jjawEMGaex07hSwvfVI/ydX+MXFaWcp3tVCoC79hUCIz
         XEJn1Tt5Y68QosE03IcTOJD+kF9NbMFuPuouAa9/0U6EKsu6CIzLyS3wo0BvTYXVxFjb
         tXpw==
X-Forwarded-Encrypted: i=1; AL+hErFT+pIuobreGDj7mkHzR2/Ck+GWrx/Yoa4dbojWLxTS7eca7PPNSozCBFGKFBUUU+DS1jBHggxV8Vo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8GEu0NMCVr60NDDl3/Dsh4ztPuzLTg4Cstj6RPgxgOV1RQaSb8
	MRpC/HNFh+HYGjOYq0g8b1zJO/P+2lAYCJCOpM4i82TzvRBld9O2y+48
X-Gm-Gg: AYBFou34fyJL9iYaguJW+gdGWvObcl8uWD280vEA71kR0nQmVy41+jBtBGjOVPEVC3T
	Iih5uxBRKb38bsTdmCCUBX0jCZjAG4SN/7fcFj4a9bj8z1F33xKK5Obsn5GJ6C9FQyypF8kdHKe
	5lvAE6rGjF0pc8VE6pImII4Dtdqbl3dNFE0T1k89DdmM6tCu6bDWXp1UfB7YCD3wdkIwYFDpQda
	2qeMRasKAuGd8nYTOnC/f4n26A/PluzMvtCUbNWZK+uOptMWBsFpr1zoDsKdWWLHnev6XD/HWBt
	mu+FexS1rTeHVTj2EL8EKCOqTvBkMfh+Minu3r4Qfq0NoDWBZioj7+TTcwEFFR9JWI4G9Ph3Bw9
	iVtaF4D/42JmAMHIeSi6/VQtXPUoLBCZtp9FyRPZ11weT6R/OqPJRwJwY/pUeTx7kh4cz0FGhRD
	UOABzR6XALIWctFgB25Sm0Tyc0bYNvbj+ygqQ+LggddUej0arRNFvqzAf6vDiK3DrqYAXX/6ZJ3
	eKpxeSy5n0jTwFIC05IPaHOhIa9rDDsRxz6dr/fDOb6ijwzTDLfbGSUP8EpqeEvpFbEfO1VwOJC
	6D7Ch/KQ0zepX+rOuMK19MN0Ti4gEjv7RczElFdV8srsuFLvQHdOfDuJwXp2zFwZDNEDkH4T164
	TN6xoq1DydB+ob9118i9IwNKJ4xAiYYduEeIzXw==
X-Received: by 2002:a05:6512:3a88:b0:5c1:488e:a069 with SMTP id 2adb3069b0e04-5c17079a9d0mr1861830e87.13.1794645329214;
        Sat, 14 Nov 2026 00:35:29 -0800 (PST)
Received: from yantra.. (nekmmqusxj170dz200l-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:b551:8edb:536d:8395])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c171356581sm1487024e87.66.2026.11.14.00.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 00:35:28 -0800 (PST)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: jic23@kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: Re: [PATCH v2] iio: pressure: dps310: don't wait for new temperature in trigger handler
Date: Sat, 14 Nov 2026 10:35:25 +0200
Message-ID: <20261114083525.11972-1-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261114013817.476f8fb9@jic23-hlaptop>
References: <20261113230241.82046-1-zoone.rupert@gmail.com> <20261114013817.476f8fb9@jic23-hlaptop>
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

On Sat, 14 Nov 2026 01:38:17 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> > Read pressure first and take the latest temperature, as a direct
> > pressure read already does. Wait for temperature only when pressure is
> > not in the scan. Read a temperature in probe, so there is a latest one
> > from the first scan on.
>
> That was potentially a while back.  Why not do it in preenable for the buffer?
> Will make the buffer start a bit slow but should 'work' from there on.

Probe value only lasts until the next temperature result. By the
time the buffer starts TMP_RDY is set, so first scan takes a new
temperature anyway (checked on the board, buffer enabled 5 s after
probe). The probe read also covers direct pressure reads.

Happy to move it to preenable if you prefer.

Thanks,
Rupesh
