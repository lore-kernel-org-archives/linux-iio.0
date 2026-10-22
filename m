Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792687502;
	b=2lmfZ5Vmwd3fzxf2g6w/3pM8/gEhDB23yxXrURMQ7+gbUK2T8BnVEsTaNBEFtx8xUITV
	 CRgJncuoR1t0fSAL9A2GwOJD1A75E2Z6V2j2IQ8yDNfLUV923P9E2YAnPejGZw/JQE+zk
	 UcJAsrpzdnHyZuoiDsCQeOo072Ynkbr+wj3GtqfEnpix38UGsPnytXJmHwLk11B0OIjr1
	 H1St4LXxsfyayG3Wo382gz7APK3YsCxPufCKcRQu0u9X25C4NSvUUGnHUYzCUrf/Vq8iN
	 ay3CxO5MTWnCPIx2HWYWgLfTszlTDIfKT9xpWMg9Ub2A4hPHzaKvEKJSG150EPXAcNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792687502;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=CzD89pGzOgOnG8GG0pKfl9YPmTEtR6RkDZF0eraj8Us=;
	b=pOjzz1p+bmY6TvomFz+iYnNJYtsiIJbBZ15/de5YqamPx90NxD/jBywSZL/YJ0ITAAmH
	 XIAvJFR6KA/qc0pxUmAuGAYBVabP3BmJjOstt2dWflaisGeHxmyLjCXRkXlGgCCbkzZPB
	 WnR0tPE07s0+PZoVV2pH5VMocN4Y6v1t4WBCdN+OKO6T9NncUL8LYUn/YSnyMUmTjnGZN
	 Q+vQzwxdC8YNja5oSnwOeMfipdkLwgXmxb+0gVnxMqHkI/OiVxPm/e6k6raLpNWLCinh4
	 jpAGbYkqCp5cl1RJFBcewG715tvJU+MvY38oftHzer2NZl34PAZJMScA7K55WKdIAyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=S80lluzC;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B565606A322
	for <linux-iio@vger.kernel.org>; Thu, 22 Oct 2026 16:45:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B565606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=S80lluzC
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-18cdcfc05ffso2323515c88.1
        for <linux-iio@vger.kernel.org>; Thu, 22 Oct 2026 09:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792687501; x=1793292301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CzD89pGzOgOnG8GG0pKfl9YPmTEtR6RkDZF0eraj8Us=;
        b=S80lluzC7icrs/ERi7dGlFC5QXVR2BCpoZU68Wn5HZxt55ADppNiFIU9geq7+fJVHr
         Ak1AlTlBn2Rjx6oDONicssTfvIKeQTHPXv53s9nmKLHDtjzZG9PM8sYoItMSnZmvlqsU
         3lL9UNsKIbm6woT18pVGhLK6WlwvjYD54kj742CDkoJPkFV09grXDci2gsbLlTsDjUq4
         J71JMzjJNPXaY7fk6QazAhnICbxG0uQYF+QE1CrquydvWJHooz+/efNoFYG9ukFmPKkU
         UGUUZpVB9wh4+EZcErazdk8fB1l3SXyYQOkhdtBQTWSJ6gs1Wtv0jMaAEiDqs4usAjhC
         SoWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792687501; x=1793292301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CzD89pGzOgOnG8GG0pKfl9YPmTEtR6RkDZF0eraj8Us=;
        b=t9ZV0J0jTVXyeIfQh/CacgZ8d7EthmkTxb3VRRmcUrJw70NZ4z3cf2ajnjru3LaBEt
         snC9x46m2u9PwN6tH3MrQBdScVBJ72M6stR3hlg7F/ZLQKcpU48phJ7zrPo7IgnN30DO
         /Dfe1qG2dD/1gdLocPLa4+7rhDYi2I6tS+QVuzkcYNRoZfgCbVV2MTocU8dx5cx6dzFB
         ThYqJResId/WJLIyn18+0yuSXUZhrgPImbZuSTfOnD/3xTfOvKml5if/Xs2RKy/Fspq1
         jEnJ3sl+jBKgBKTEqwQd+YiGeAqC/BtAr9njlW9pQ0Jt6YbyxKKJrBvf782pfSoWcSuc
         fmZg==
X-Forwarded-Encrypted: i=1; AKwUvBxWTEBm6k5WB1QPBjbK7wjbAwRDfUTsvQllRkbxv0H/RJGaqU5IfjqlOgPutg/DnZev1plkBf2aOOQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKxCVQTZQT1jlLMsvUZvtQ3awPWzc0o0pDrnmbAK/0eOplvjzOK
	WxX4bqF7gejtABEIyTEJibJgmj+JnYg++faVeJ0MYJz63gHWN0C4984n
X-Gm-Gg: AYBFou0PIgLiQbnqb0lHPtKTFzcgpojyTTcGBOh3q2y10aOPFw6pRgd3dFzmaNlGFGH
	IJL/Kgl+FlBXZtBiw5SUWQUmlmONsbeOZFM7PzJAXMpNmuCBT7HzNrGkop4ztecc0B+vYr0uewW
	TQ8mID2mneiCgBHHdFhpPz0yPEPqHSuh3g9hcOiE54y/R+AGofjhD9J9cpw2uau+7afKhfa7iJH
	7dmpW44zPtFbQOUjeyUhEXvZnuOpA97/kTp4TXbRcMWc3D65tKxcoYddY65vv/86m0k4HnDbDGf
	Wqjuo5liJ+/w/OhUp5I13NtFKMvAvHJjLSsrfAchm9B4Q8WS0ki6C0qWtoerPQtSdR+xfEQVQY+
	MpnEKf88IVS52wxWBsZ3qup0tl7O56By8ti0lMclfG13MNxloaPq1vKHzw4AFoZ1afb118pbgWG
	DRQpNSzj8JgjoPxaDNipytLOPvB+lB6oJpVlDKqIHj9KF5R10+VdKwPmaTzxDUlBS6Jr6TGRYsI
	ShWMQH1n4vQr5V0//EAf3knxO0X4rz4b+Zm6Ep8mwLb/SMgk1xqXrSoE2Trg5TfaozEoysxYGEc
	cdWm6meJL9cuUO1/CJase+qORUpBXhb9S1j36K2MOhqCNp/pNtPoYFD/09RYwHEqxbnWuR+Y8/X
	KWyamNnf9cIE=
X-Received: by 2002:a05:7023:a8b:b0:143:72b1:9004 with SMTP id a92af1059eb24-190a87a3b70mr7623767c88.45.1792687501102;
        Thu, 22 Oct 2026 09:45:01 -0700 (PDT)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903a180adasm15841782c88.8.2026.10.22.09.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 09:45:00 -0700 (PDT)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Frank Li <Frank.li@oss.nxp.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-iio@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: fsl-imx25-gcq: check the return value of the
Date: Thu, 22 Oct 2026 22:14:50 +0530
Message-ID: <20261022164452.201416-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <ato7b3ydggC9X0_-@ashevche-desk.local>
References: <20261021225450.628499-1-kapoorarnav43@gmail.com> <ato7b3ydggC9X0_-@ashevche-desk.local>
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

(Resending as plain text, my earlier reply was rejected by one of the
lists.)

On Thu, Oct 22, 2026 at 07:35:59PM +0300, Andy Shevchenko wrote:
> I consider this change an unneeded churn until you come up with real life
> example of how MMIO fails

You and Frank are right. The regmap here is a plain
devm_regmap_init_mmio() without a clock, so the accesses can't return an
error, and the uninitialized-data case can't happen either. Please drop
this patch.

Thanks to both of you for the review. And Andy, thank you for going
through all of my patches today, the feedback has been very helpful.

Arnav
