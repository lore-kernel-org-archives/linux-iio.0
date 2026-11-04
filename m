Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793821554;
	b=1Lrs+h6xl9sVw6Uu9lY6sXwh0/D0MtQ8lxaOY1HJIAR9Fo83jXFbrV8iSdM28b0fsLrw
	 CPzeUu6NSafnWs3PJE1hqtX4tQXTVvmEqQe5X8p540u74GM/zrZ8JImyq9g/a5LQWX+hw
	 lLQ6jtC8zpMmXVs8e4hoBzVTfWpz4oqtleaqbJx7ZpzYMTiMw1aFyx5+AUwYrAjYYTnsQ
	 BykkpqgHR1joP0l99kuPSTJko473PNbVcPwbu/00eNgwAS+LhR11GYtaO8DEcrUEgXK0G
	 +82EJXlSKxyK/qlFt7RSVub8aiBtvM/2uHPRwZi6DZsOeHXvZ/uZf7jhgNh5JfDVXCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793821554;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=EhMlWPoz5IUKIlQ1/wDPKCmLchJf0GRtbn42lO+mbmw=;
	b=lOoAZcin76hIuy6dP7YkDOOr9LzgNZWe7z9Uy2gxpraCMD3SgsCJaYi8RhXcRW1HI8nd
	 KqpTRp8Sj/HH+0PaN2ELbEFEe5FkOzmMPB5N9GGMtH9ltgywB2wkjU6S3ZjoXYznpHDCS
	 oE7azSTGjtWh5gzWV3o4obRZGFir+I4f1cJOC6+rbX6GFYgFJdb+rEo+0bJt65BaYI4i9
	 lP3g3UvrsaE2D9k2vdaMAKn0k9FTkW/Y1w98uCMr7XGlv81Nc/sv/UPRX5gnQMLSoJ438
	 2SEdj18/QSBUb1aBlPeQc1YkHW1C84BK+TQhAbrbjIXmb0s1KQwS5EkK8bK9uXUqO+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PhgChsRR;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC1F608B1D0
	for <linux-iio@vger.kernel.org>; Wed,  4 Nov 2026 19:45:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BC1F608B1D0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PhgChsRR
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1b244fb7fffso1559749c88.1
        for <linux-iio@vger.kernel.org>; Wed, 04 Nov 2026 11:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793821553; x=1794426353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EhMlWPoz5IUKIlQ1/wDPKCmLchJf0GRtbn42lO+mbmw=;
        b=PhgChsRRxoaFlSlkRP6+eJT4KYEi14DqTMP0leDLu81FxLUk2LAC65QwDPBooqvAsn
         iH6XkP8S1MK/SwZxO3AJkItw8VOGPpqeDmiiYKv7myO0lnlZgnop7KC9K2NAgM6ukplu
         Gjsdpkx1k0Dhr49FqliSxtq+PV7zOW1rF8RqXf/q22186XabS9LOxL3XW958WfiYw+PV
         JBjD6srBvq+hK2XBFDtCmpOIf+gS9iJ5nhxA+IIgHZhp3x3Dcb+TLxzecX64kH4ggJZ8
         fI8gag+0WQBADwjfb6rFBnw2H4YR37v7+5aiBzykie/3yy5MmRaIYgT31jdFJ3lzFtA6
         N3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793821553; x=1794426353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EhMlWPoz5IUKIlQ1/wDPKCmLchJf0GRtbn42lO+mbmw=;
        b=ok1MnTuNmDSmvY71u0JtKlJjs5ghTgfDO3so6QkhqDXX7jz0B2sbj+fjjljU65WsMj
         ngoELbHsImQnhV6k2z2szESlPrgwXW0V9NnoAOYIe4blbtA4VGioTtKLFwffD+PcAl0g
         kkpOtlaMuIw9OaaO07yPhHu7IUpDeyz7B2ujl/+U2rk2XLJFcQv4V5FS9EABJB4nM1jN
         cru+iwJoN1QWD17raJYJg8EWZ+C5Jpf4SxWua1F/tZPEi9SPr/5igxIWbJSoPZWzQW7K
         hb//3fbCkb5uQZAU7i6ck0e1gdExOZgiuAhnOnRjsZrw1eeKn0M1jV98sx9rX1Re3egu
         9xgg==
X-Forwarded-Encrypted: i=1; AKwUvBzt24N1KRliMmFTpML+abxvnkEKdtMUc+AYmYuKluyylbEOUoLpT30ZUDUuIgA0Zm3ZXInqQhrbZVY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8AQo5nShF7poEt39jVPiC2tQaSzf1Io3NliplpNrWVX3de2wlz
	ZJyGtKI1/ZRnAnvApxj7fE53peOvH6OYZRMSqzw1Lp9Y0BwlD6BZpcHFTwUmAZc=
X-Gm-Gg: AYBFou2l9iokC20h8k9635pYaLgrfVFKVDYAWrQpIVHcrlkk9KIAfRW4TkLfGdyhE8j
	l1fHqayC8SmBymUArLf1tgZVlGmCidJg+YekXOdExPyvcMNZ97QzFNUYFP+ZK3Iz0zVirIrGYya
	0EBF6jXDfoCwqkBM6AqA0Dc0foAIZLGOlgyy5K4yIb4DQIXufJ9DJMpIvqYeH8DhZf5yXSowqsM
	/fOY0xh8apPx8FDEVMXX/29lyCt7lQDSOXdhNG5Bn+qGI+7jnFdbpcowE4KxvSHXus7+N1Ps2vW
	aLN80hdR9FSU4IJsy2Tql0XDbY+flOURESptv8XzpnIHjejD6L1XtzypmrqdejfcFCJA7K7iA1t
	w9NeeTF3mZ2BeztM9eIMu83pDIDxlkCCL9EZfQvbbeUOWZL+N6eIkU/BOTB0qNAWbhm+IGTXteP
	ECRWNzfWvygWmatSqHTRuGCJOxxXcMM4KiVA+aM4kvjYNYeXMUbxe9/YVvMx3UGtoYyHaEbpuOZ
	XIcb1pkfrGjfwBFDYChizhQSN2/J4D39D/8ini4KJXzkxeC2RzniYLrD2CoqHWpB2zoyEnk1pCk
	bKNzWTMNQUhW0UWlwWXCPPMW3B0e7ehaU30PCmSrmBLE7jqOHPuqD7oT69A8A3K4gw==
X-Received: by 2002:a05:7022:3a02:b0:1ad:e740:e51e with SMTP id a92af1059eb24-1ade740e699mr23857533c88.42.1793821552953;
        Wed, 04 Nov 2026 11:45:52 -0800 (PST)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.194.66.249])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38a6160sm8652168eec.9.2026.11.04.11.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 11:45:52 -0800 (PST)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: jic23@kernel.org
Cc: alexandre.belloni@bootlin.com,
	andy@kernel.org,
	asahi@lists.linux.dev,
	atharvatiwarilinuxdev@gmail.com,
	bhelgaas@google.com,
	bp@alien8.de,
	brgl@kernel.org,
	dave.hansen@linux.intel.com,
	dlechner@baylibre.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	griffin@kroah.com,
	hansg@kernel.org,
	hpa@zytor.com,
	ilpo.jarvinen@linux.intel.com,
	j@jannau.net,
	jarkko@kernel.org,
	jmorris@namei.org,
	keyrings@vger.kernel.org,
	lee@kernel.org,
	lenb@kernel.org,
	linusw@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux@roeck-us.net,
	mfd@lists.linux.dev,
	mingo@redhat.com,
	neal@gompa.dev,
	nuno.sa@analog.com,
	paul@paul-moore.com,
	pavel@kernel.org,
	platform-driver-x86@vger.kernel.org,
	rafael@kernel.org,
	roberto.sassu@huawei.com,
	serge@hallyn.com,
	sre@kernel.org,
	sven@kernel.org,
	tglx@kernel.org,
	wim@linux-watchdog.org,
	x86@kernel.org,
	zohar@linux.ibm.com
Subject: [RFC PATCH 00/14] Add macsmc support for Intel Macs, replacing applesmc
Date: Wed,  4 Nov 2026 14:45:32 -0500
Message-ID: <20261104194532.8259-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101010737.203951cd@jic23-hlaptop>
References: <20261101010737.203951cd@jic23-hlaptop>
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

> Are we looking at ABI changes as a result of this? That
> tends to happen with split ups of unified drivers and mapping
> them to more standard kernel subsystems.
> 
> What is the plan to handle them if so?
> 
> Thanks,
> 
> Jonathan

Most of these changes now expose the stats using standard api's, so this
should not be that big of a problem.

The worst possible thing that can happen is that, the user will have to
change their fan daemon (macfand/t2fanrd to any other standard fan daemon).

And also, sorry for the late reply.
