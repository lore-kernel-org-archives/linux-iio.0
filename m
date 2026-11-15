Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794782304;
	b=A4fWiyIpWGbIFH4H2x1r0pMKucIU9qy17EVupHsGd37SgPLKxgSXAWJyEpHYQgs7+h5p
	 jGZvKc3PwIKJUg2FrHA1oT6SDXsxUw+Fe6iIjN6reUZOk+EELlbG9U7mItImuTGfJyu01
	 5/QcBXJAEjX42N8RwqMroB/aeVy3TJw0FQjkzVKlipqHlDLf3qmeIh6DC+vF4S6gzBuWy
	 E7QpL5CtSn/gCYpoNC/IoAYU7/rjH3moJ4fCTAIxn3nZAaNbX1bak+n6RzikVA5y+JO0U
	 uKh//jJ+iRXl2RUFs8CujZrk/EBDlQrBdCZDvVZafxDAzhn5T2b36aEOX8SufUSO5BA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794782304;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=jP2BTh7rVpWo9Im/wV5enbfenEoL6kTHcUKyx3s6YMc=;
	b=bR1P9OVC+chkBJYDvJX8P/DWG4wnyQ1kezFXkYcvOjvalhg/wqJ6IAETqbMb9z4TERDb
	 efg5Oo6WaWkxMQT0cm7xof0QkiZeMVqidF0hIlzXjS6+IYBkgR8QIAISWn2mUK07yXmC4
	 XufbaE1Y0zIJgtByI7Q0vZBXchXwENQA/Ta7FeQTXGKbMEirN5BqS1B0T5AIcPYSDy17L
	 KsYe/eqfKxkr7MKNLLYo9HDQDULGZ0Nx0svzrmRNqYr4Hbck9eii55X9mDJcpaxf088gD
	 tIUfz+ZpqB9OZip4BgzShtjjACS2MUvppFKb5COoqKwEEzxjniLzC0j1HD9Ucr8NYZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j3lG3ihj;
	arc=none smtp.remote-ip=209.85.167.51
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F7B606A32F
	for <linux-iio@vger.kernel.org>; Sun, 15 Nov 2026 22:38:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7F7B606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j3lG3ihj
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5c158c4c15fso3546938e87.1
        for <linux-iio@vger.kernel.org>; Sun, 15 Nov 2026 14:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794782302; x=1795387102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jP2BTh7rVpWo9Im/wV5enbfenEoL6kTHcUKyx3s6YMc=;
        b=j3lG3ihjCmXBRSjnJqfN6ORSYkKfksPwGSeBXneAiBHnDt/KFj6KriUjeYuN+YiuXs
         K++zqwRNb760hiJ7UBo40cdx23MOLJ4f1kvArUpP358FKJPhYZk7Bw+6FmKzYG/w/DoI
         8r9a+IiyvkRU8BR6uhKUMmLUIr0jnPUncUyY28/0J4JK6wSG7U3pVfMIkUgHCIX0nwPK
         +/wlx0iNi7+k3XCyauiBMkhYq8F4xiN3Z8o/bjO2gC0c5fUQZvPVUY8ycrp/9hlbAzHg
         xi35KmSe/ag7cDkawGFUCb/G4pQzByS0eb1GIxnoPwvB2Wmn9ylnYl6XRcMdnHAf6vdK
         SDew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794782302; x=1795387102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jP2BTh7rVpWo9Im/wV5enbfenEoL6kTHcUKyx3s6YMc=;
        b=KMtY5yerjWC7Ge4nEBkL+vDIzrn3DSF49g7Sq/b27VN5zurWs3LX2WyoiqkfwvSSko
         Auh1SZgCDqVTbWYS2a91Qw+47/pM0v+7WyZIFvNCuC3pNQWcd56bl72OZHNQ7w2TwGl0
         R5D2oDHzzTYFhoPIJXIPE1bgE1Xcp44moPHHJwuVFlp2t0DL2fG1W63CzX/HfNagmeUn
         /gvpb7lP8wrPmrh8RW7GV2Rj7XdQCsuERbLOb9HoRB1HuAofCuM/d1wvmM8CabvMDxuW
         S1nXAst10ZgGWkHA+HwmP3eL3w2UcGTNWo7M5XMGHSj10sFc0jWLJVogqXBFwPnaeSfE
         RqHg==
X-Forwarded-Encrypted: i=1; AL+hErFSuN9764p8K0UkI8ope3b7KLlmBNm67/axMrBKjfjUFcLXoZWFZCLwZrOMXGrUlYOW8WOU4dOW56g=@vger.kernel.org
X-Gm-Message-State: APuU4Z9fCKCm5zPMJkcorlTyULpTULBN+eJ9D0lG+X8Or/OtaEiUoKlh
	2F/NyK4bPEBOHpupyrqKppxcXJEJ6a+jRYJmpTyUaHO6E5nCoJfI3FdC
X-Gm-Gg: AYBFou367DykujxdQCZz4MxZxwqvV9qPCFW+xyw/9byu5P8TaUti518yVdd8O1xS4nw
	yDCL8KtcAuhB7MU/PWiDghzUuSHkE3oKHOXCRBuDUn2AmXFMDKQ6c7uBsdBfP28c9mrorZ+4Ptg
	N9G92ll1Q/p2SdZ3HIPbVOt08txdUklzhbGoGRL5F3WbHVCx/2VpfBaWxtF11BVkZix46+tn/03
	m7A1b62sTXKElh+jlNfu9qIAozhvliTGzM/AY8MAE/9zbRE5gmbvYUD3kANB0xSE56gMQhtuEzY
	nOnEPQ5f5FPyNMDit5X/DZYn8oHxV8XXghHC+aeGOO6U8q8hb1ismEdiLYEXGzML1ZjUEuQoKr0
	GaFLTvldBozCPqMqVfE8unlLyJJsEbyEUTYunKWZloQviu7OqItloTJTFWQCtOKLCoIRyxmy+Lb
	sps2Th7hFk/tt2ucWNoJoOBCf89f7ylKzbIKeayOOeyVcu1ARnPyDdYGjKlOpRU3ccC6rRLUkyu
	ZskBq5b4OpXlbaH1Oumt1nYVtrW3tMWBqlOFgaDfG1dfy1q0WrvX/3u4fLXLnPW7tsbilxRUMls
	s/pxDqZCQbjrLlBkYRyzeMG9zW82cEsNra+k5w239UKf8N/I4nkiKbru9vnf23TBmos60+8+giW
	vQrQVM0rZx09G1Ql/uLwwpaUVP6eU/tU1wH9CFqI=
X-Received: by 2002:ac2:4bd1:0:b0:5c1:4817:2c03 with SMTP id 2adb3069b0e04-5c164ebe9cdmr3717369e87.36.1794782301710;
        Sun, 15 Nov 2026 14:38:21 -0800 (PST)
Received: from yantra.. (nekmmqvelexmc8nt5ae-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:dce3:b876:6f6e:9706])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c171357477sm2759609e87.74.2026.11.15.14.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 14:38:21 -0800 (PST)
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
Date: Mon, 16 Nov 2026 00:38:17 +0200
Message-ID: <20261115223817.10568-1-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261115203150.7faed0b1@jic23-hlaptop>
References: <20261113230241.82046-1-zoone.rupert@gmail.com> <20261114013817.476f8fb9@jic23-hlaptop> <20261114083525.11972-1-zoone.rupert@gmail.com> <20261115010203.2a939bd6@jic23-hlaptop> <20261115183949.11591-1-zoone.rupert@gmail.com> <20261115203150.7faed0b1@jic23-hlaptop>
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

On Sun, 15 Nov 2026 20:34:11 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> That all sounds good.  I tried to apply it to the testing branch of iio.git
> but I'm getting some build errors (+ a load of fuzz). I guess this
> has dependencies that I'm missing?  If they are fixes, then I may just have
> to wait until I can merge back into my tree (after they are upstream).

No dependencies. It is based on fixes-togreg. On testing probe
hunk no longer matches and with fuzz it lands in
dps310_fifo_interval(). git am -3 gets it right there and it builds.

I can send a version on testing if that is easier.

Thanks,
Rupesh
