Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B744C0425
	for <linux-iio@vger.kernel.org>; Fri, 21 Aug 2026 14:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787321167; cv=none; b=US+D4FYvX2rOdHFm3DEPvkFLHE53g0SzQLIB4SW8nC8hyKNoQK6H4aHFQi0yMhiaKjlwt/FAId8vCmQ5VwMkudedCTVRy5D7hRz7yyXtJhJTQON7eJa27yCPRkGtVPt3QNqR1SPFbHy9iZvSy0AsQx13TcMrQnraGvtzmBhaev8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787321167; c=relaxed/simple;
	bh=pcfJ/3LskojaaUGgdCajL/g45ro6XHBxMEZHa9hKon4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XdTOgbfazB53r0c2REYMVI6eH4nerqj+PbtVwVxOD0Bn9ZKHJH+qp7Ak37dnXz641KhB6/10SxTcJfEYdhELe/ZkYVLkJkwP3dlCFCRE1cHWg058lMkq+FOnB9JuZgdM23KaveMsyBlSajtCLRNITJCx5MyHnzDZP4kt/Vvg4B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sEZarZWh; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sEZarZWh"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-499acf0fb55so5620175e9.3
        for <linux-iio@vger.kernel.org>; Fri, 21 Aug 2026 07:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787321163; x=1787925963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pcfJ/3LskojaaUGgdCajL/g45ro6XHBxMEZHa9hKon4=;
        b=sEZarZWhbwplvrfm75T4nu/J2CJowI9F2kHL968xnnn3VZXD555iubxYTSkrQqH+1U
         BXYEDKiFnqswgqZxicuPKwpNnprNVaFl5bzz7s/fPpF9PMPhH54ul1AxIy5aoDAE3k6n
         Oh/IE1QN4KtdZa/7La8nSBPZoEsSPwCmJEZoNhwbq5RqsNgeFzN6ziXtzVMAmPCsgdOi
         UTzsDgcCmtFEzFmJmLIdGyJR0KRairWWMBVIMeQMF6izCl/9o5fpS3+86lIGHQ983s5m
         zuBC07uA0R/rdDczl77Qn3+Ged3ornYMrqQTCvHgvpKVMFCbm43pBUnBGlpWWSJMJ1C5
         gV6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787321163; x=1787925963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pcfJ/3LskojaaUGgdCajL/g45ro6XHBxMEZHa9hKon4=;
        b=kaM+64dfozhcx+EPGprsOrwAFAg1eVwHMG4OPqfOYVxlogk2TfQd+TJxeWTD11MEfA
         GLgSRKsUUghvA5z2D3lNBl7lAXaONVb2+frv2mEpiRdDVYUuGQlTcM1paoY+lpnU05Dq
         95pIuBO3adzumSjvQTcksOItw7W9E3/DxUkyr7RC88iI5oIRIAw9rOzol89KryThmmK7
         NfFdvgTN99WtFINQpphI7RrhzKRAhXM881QQQOfIDbdbeWfcBy4YLmCC9eZDSU5Ci+OS
         M5SOisYJVziuQR/jPpQtQnIAmeBSGrdWdynKEq4eS++iGS5wgaF+nnlOCuxbdC90aXaI
         2ojQ==
X-Forwarded-Encrypted: i=1; AHgh+RqlDXislGusNMGGwD7CvAZyTPS6ndF5Boce4HcMX5gPsgQiDpP2QQ6Z7013DE/6+WXwVXsYnC8GN7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYseYOSVlJvqRJOwKoNs1Un8jCSObHouwNe9tYxO+Bvq8p816B
	Y8XN7ic63m1YMfhmTSH5+dGM/iJtMS0R84xYh1RCD/aPTwEoO1XHYzCI
X-Gm-Gg: AR+sD10bnqt8mkxhEQxXruOrz7BCgncHeq9vpyyhRdJsuzmvr+ToHwOTKIsEMnHkG6q
	Gd7Th3PB9gB0xbX9Aj+v+APkWEcUjVc8gBFHVcOk/i5JsxyqZV0L5sJXcqPw94Fri/L6y+jpNua
	R//wNXK+4euV7yfNVk6tji4e8QE5tvP2+e6RKPjSx6f675kpC4Le1d6YyChjtey2P/M7Sg9Wlti
	kP7zX79E/ahRg4MzxuO/2jFg5NqiE3ewbmC9DcMkX5vBGt3UJ15m0mFRRl4g882YywoagMguWT9
	lyq1scjmN7XDypOdMgVyi3MycbKf/PFpg29uaW9zjX4/z52fLd44qRdPcjCTCOgXjgDMNz8OZCq
	SjkLPlQpCchjkpL4pZ4R3oHaE+XupzhkhKEtd2oZd9N6bX5+sLmZeoUB/PzsB4DroZjFLaLf5zm
	aor1qmO5BZu5L5/bj2lA+bvoyedULXLA2mugRgjm9KJMpIQYtimMNA4RCMa1mo9brFhIbdoupVd
	KkmlbwcfnveNyH0+FDD5xzY
X-Received: by 2002:a05:600c:8108:b0:493:a966:d5b5 with SMTP id 5b1f17b1804b1-499b82f40b6mr113096785e9.2.1787321163184;
        Fri, 21 Aug 2026 07:06:03 -0700 (PDT)
Received: from fedora ([105.74.130.192])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b9111a5fsm28637435e9.12.2026.08.21.07.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 07:06:02 -0700 (PDT)
From: Taha Ed-Dafili <0rayn.dev@gmail.com>
To: andriy.shevchenko@intel.com
Cc: 0rayn.dev@gmail.com,
	Michael.Hennerich@analog.com,
	andy@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	krzk+dt@kernel.org,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@analog.com,
	nuno.sa@analog.com,
	robh@kernel.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH v5 5/6] iio: dac: ad5504: introduce local lock to protect state and spi transfers
Date: Fri, 21 Aug 2026 10:05:46 -0400
Message-ID: <20260821140546.96474-1-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <aohTG8UxkmHSUzzh@ashevche-desk.local>
References: <aohTG8UxkmHSUzzh@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This part is not needed to be under the mutex. So, first convert the
> input, then acquire the lock.

Good point, will fix in v6. Sending tomorrow to leave a bit of room
for any other feedback on the series.

Best Regards,
Taha Ed-Dafili
