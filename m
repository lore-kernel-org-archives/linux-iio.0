Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794601065;
	b=atvQGdCbqm9hJiafAmQdTpmdiDnwEpZFgs2ddt/hGLDszzYqATfCOAFuyYhZio07meCE
	 yDreL1hAr5hLDhpJ/ApkI2iDu+d4VQYFzPBUZogoHTofKwts7P11XHS878fSRKPplJCuL
	 Qmeq6kuwQVXSMmCgkufruU7yhZvwP6yNh6zZnrMRFa+0VEWr5g/ggxIipQFfYT9EtPXUM
	 dX5wUq6yAdWYBg0KjV2JmiUPud0/vngux6bLol+GUXPsKWobfoOdXD69TtAJOU0QGsm5l
	 XJvRiQwc2uImsp3HEtY0aMT8514qqR/IzfoczCb4yqrcK14n1+DyBrpZZ4WWpoY1nEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794601065;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=FRvflSbgl0Z7xG/0mliZyvs/63qm34rb220QxXX8xtw=;
	b=TTvbXbwo4Tq0HyDg1OA8UyT3Ugy6Vl1SO+JmHksdA/z0TWQFw2MDu3x3AFwmQd6k++jh
	 gFkNqfzwR1TfhHAMTVKdcH9UXWHrWXyoW/oDbP25o6VLpK+v1y5dq0ovIFTN+3I/UYwWT
	 jqibOjgzNgMx94DxK+Th1qIVztlpNTzXnR/ri2U8g/vyvF9E3CuSo8hDBzgQqlRXePM0A
	 KnTeF/CV5c9Z8HCFQb2bnROxIqRqzg4MSkaPJQYJxTXLWnGjnWDrs5wg7wa1GMZtLOO6y
	 LkBoLT1dW3Dix4Qm4h9IpJBuvfaJF/FIwt7w9BLJ+yihPHET0mN+HOfXZnGFBEav5Eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f1YGr27B;
	arc=none smtp.remote-ip=209.85.167.54
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932F0606A33D
	for <linux-iio@vger.kernel.org>; Fri, 13 Nov 2026 20:17:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 932F0606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f1YGr27B
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5bfa7c09c9eso1583078e87.2
        for <linux-iio@vger.kernel.org>; Fri, 13 Nov 2026 12:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794601063; x=1795205863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FRvflSbgl0Z7xG/0mliZyvs/63qm34rb220QxXX8xtw=;
        b=f1YGr27BGAiQ1k/7gbgyOYz0GgvQ3N7ipameYPsZdesh99WEUSAbkcBhDjBq6Il8LT
         746FWwOQ3Ho6AMjFQTusNWvN5ZB5EHzHEyfhczcIvJqqK80ikUBW59sz31xozQNdWj5G
         JDuvGzoYJ/qrXxMOgoKdIEq16R8NljXiwjD0awprbDdDBB4gRpyGW1Nf9l15RqzSWrqu
         4BJLuUlRLLiT3KX0kEViASA19UexkpKuPWjDVJXfvqFOm5igU+SEB4/+zksxzSIYV531
         iSlAIVleXN0eRXl+/V1kcB7Oz9661sEjHZ1CgQpVq25/8CAkotXwUsoZvoPdeHQUUTOV
         Wr5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794601063; x=1795205863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FRvflSbgl0Z7xG/0mliZyvs/63qm34rb220QxXX8xtw=;
        b=KxdjYLmoBaO2PlCrQTxBFM28qro3bHX3DXAVzvbAA0C4wHQdHNxub9dQVI9ZL3gBGl
         RB0kxfVyMsKDINBejJwELMGjNee5rw2hESNzq0EAcjEKgjHbl0hQ6OMmemGfu7ExW2t/
         DoWzHrrRptuQFXNubH/B/9caK6bo1rDQHtgpY2PpNTW8Aw62AQSzZp69mZ55Ji5o1nkj
         A+vmmFozYimnt4gr2M+6MXw0/XzSihMCJiZIYIcKrMon9wincrbyYIBgf8xPqJgkCPNn
         2WSWLjY4chlFCBGm6nkyOTsKanuAZlIvWI+oGiZBeBEPENOUgaHXs8YpP5V4a1God7uu
         cKgA==
X-Forwarded-Encrypted: i=1; AL+hErFAbsNiE4IrrPYXgrtKygmJ0FCG5+iyxcGOSTyMYvjS8Ata397BW4pSVeEddUb+9cugJyvjfmRQE6s=@vger.kernel.org
X-Gm-Message-State: APuU4Z8NhXDGQhsbUX0SrMPk4DMtE/dGiSdChY1xBlXhpxjaewoZ+CuU
	IiGGza7Xo3VZ1kIZH2d5TP9OFMB6l1SHbarqdjmgYCsw0JTMokcq8dXH
X-Gm-Gg: AYBFou1x8hh84BXsc+sCcMnLPuGUhejiDctnbZQqdWSQ2k7mgH8VGhoLCAxEdEUpwSL
	9tk9oWHOYjqo1pWqUWVZyk3fHIu1MYA9uH8n0PBMxc1lPLIJVHPJ4UX1j11rIIhwBZpgGKznxK5
	iDiTVhU/lD+PIfMg+WBuVPK/kKAhj/ZZGv93CVNNXnNxun2kHcJu5Ymxr/iuLbE7MdWqYvXxU9+
	LEwiKiePO0xmdCmZWCpmS/WB6g33F7v9shNGPRxQzaK0IaaW/coG9t2+idskchMk/QaC7Jrl3+B
	jfWqnW+fvXQcxyg6CeRCbBxFD9bmabW+fFSWJOP2xCJPoV7PH9+iQuT7S3pMmyueBCHd1V32172
	ixSn+yTTGxckTeYcYFBMqFSQzZtPbyZoSG10rOGuV5/uKXzigZvAys3pNpUyGPFtwedzOGa0TIT
	oViTXcUT7KXcqfYAUwr44czvJleGEp7uGSyXzxQWAXQF4CYIscybjac2vtpkXBwYIW0LGB7xzYL
	hWP3wzVVm3xcw1Ht9pXjhz9L2CF59oqK+QQPsHfgXqs6W1nxz88gSB4H74apTw/2jVMaMW+sjQ/
	ZNrZR/hh+r5HReq7h6wcJoRsnigARAxSGlAG4PEjNQM6pafjffas+PES2DoKSRLHRnxiHBIXjRI
	lT5PbqiwA38yPn5Byb/IXxmsjpcHEjIInG/A3Yg==
X-Received: by 2002:a05:6512:3e29:b0:5bf:a193:7a5b with SMTP id 2adb3069b0e04-5c1709c2eeamr1739274e87.34.1794601061732;
        Fri, 13 Nov 2026 12:17:41 -0800 (PST)
Received: from yantra.. (nekmmqsrubyk7w1qlch-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:2fd0:3310:f4e5:7f91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c171346e7dsm1057729e87.49.2026.11.13.12.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 12:17:41 -0800 (PST)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: kapoorarnav43@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: pressure: dps310: don't wait for new temperature in trigger handler
Date: Fri, 13 Nov 2026 22:17:36 +0200
Message-ID: <20261113201736.58553-1-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112214929.497589-1-kapoorarnav43@gmail.com>
References: <20261111195118.36853-1-zoone.rupert@gmail.com> <20261112214929.497589-1-kapoorarnav43@gmail.com>
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

On Fri, 13 Nov 2026 03:19:29 +0530
Arnav Kapoor <kapoorarnav43@gmail.com> wrote:

> Maybe I'm getting this wrong, but isn't there a case the new path
> doesn't cover? Nothing reads a temperature at probe, so if a pressure
> only buffer is enabled shortly after probe and the first pressure
> result is ready before any temperature result,
> dps310_refresh_temp_locked() finds TMP_RDY clear and the pressure is
> compensated with temp_raw still 0.

You're right. After a reset the chip has pressure ready about 3 ms
after measurement starts and temperature about 7 ms. On my board probe
takes longer than that, so I could only see it by dropping the first
temperature result in a test build. The first scan then reads 1.2 kPa
high.

> Would it make sense to do the same here with a flag set
> when a temperature has been read, and wait for one temperature in
> dps310_refresh_temp_locked() only while it's unset? That would cover
> direct pressure reads and after the first sample the scans stay at the
> pressure rate as your patch intends.

I'd rather read one temperature in probe. That covers direct reads
too, costs a few ms at most and needs no flag. I'll send v2 with that.

Thanks,
Rupesh
