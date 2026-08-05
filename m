Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41DA2E7185
	for <linux-iio@vger.kernel.org>; Wed,  5 Aug 2026 01:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785893053; cv=pass; b=f4HrM5CBxsvl5Ev2M84Ddw4juUy7HM5cVqZdX3TFUxxkeclD16scKUnG9b+BIGHRiMq/aqieXcosIEqT5Oz09jmQd7miTPyZpcAxVoaDSdDrDL0mXg12LdirFehqqHx/m8XxLBKsXm0D0LAmTqi+0fWVxTiErdLOguzQEiJvfQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785893053; c=relaxed/simple;
	bh=tmxvPnC8g8NOlS/WboF/VhTQfeG5R00KcSwfFVREwI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P6dNNaURwd9wPseT4nqT68K0IwTikqTPE30uYu7aVD9Uj18dfrf7wAJB5ix758IwBZ9jBnnYmLxgP2LO4+qbRHLC5rPok68jA+0QFD9cCqHmQ06D587Rq6kOG3RGehvFKYGD/YUlYjzsQcJ4co2EuKPdDhgiM+j9L0lnzA067bQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=frame.work; spf=pass smtp.mailfrom=frame.work; dkim=pass (2048-bit key) header.d=frame.work header.i=@frame.work header.b=pv4BB5OS; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=frame.work
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=frame.work
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=frame.work header.i=@frame.work header.b="pv4BB5OS"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-66892c81725so614757d50.2
        for <linux-iio@vger.kernel.org>; Tue, 04 Aug 2026 18:24:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785893051; cv=none;
        d=google.com; s=arc-20260327;
        b=AzLBA9xRwt4WvGT95xaCRn6RMxA97f3aiJz8+YdGpxuKd0pVMsTjATckVaTg7NrN07
         wJFhz5d9uKe45MXIzIPPEt8iMLWHAPHQK0R2+WCIgYjqw3vJkpTaqBhZfrylW31JyrHG
         fqeU/NUxst4wWMSPyxV/F+gv6HF2Od0HdeGmNQxc7idZwd4X9EslZERGybt0FUeezZ7O
         tsn2P2xM/sksavh1j9vzS4v0pLXdo0UI+7I2hGczKdKuFG1hJ8Td879NdJ8Ix3+Z03/h
         SH/lrvEmg3EXi9xS233jHnWIqnIg+bdo/Lw1ZRXMV+MJLei+tk9WICbuKGOqW7IPydIm
         EzJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=YTZY9qIc5z9CVljfPesZ7wDN4EMIeL5vhxioi/EavNE=;
        fh=MsAvy4PyG+iWuA976aB9yZ8yoWWlYi7J/dGiqHyR4Rs=;
        b=bSaXVwdKWyI486aAbFuyHBY38eQO/GkS3MhrHZd9X+ncFNSOakGDuXewAcYVp9sj73
         8zQlzMRjYYJ4HYkLqiCA0Hah4NdcYuuUzswtNPKDbk5QZKt/CB7Eea3q+7Ba9gFF+kvl
         CDDPJeFmqpnkIX39eGtJKgfenhtUwWQvHWutiQjPEkZmeETNVyljqeRUKPWExszA98zZ
         L0G6rMrfOZRn0sRA7O2HIzatlPaYHkBOs49oQ8bC8qucv4IO5B+BkDRAeMLr1sg8+jxS
         9zAl6Rnn2NAxw3gdgYFRzghIW6C79iGOe2cFUTPT3kXNIRULcXQIv5+k7SwsAaImuy94
         sppw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=frame.work; s=google; t=1785893051; x=1786497851; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YTZY9qIc5z9CVljfPesZ7wDN4EMIeL5vhxioi/EavNE=;
        b=pv4BB5OS/Ri0wgCFSarJUf3N0JOGFZYuXr2xbeR4bvI2W8GArKV3+OsbE/MRw7fc1b
         M2uEqhRei+ktencUNMoi4ipc/Ji8QG4fpQjmKcOiA2Z1BLUosZRZ6kikIiFdxGINFRVM
         huiu5RNMKz+4K3fBpaIsdc+iNn7gpeAsX44fhRlyz6NhEVqS15xmn5DjsTH2zkAmNdA5
         DwIZx8687P/NC4TotAbJtZVqX1vS1CSv7yQEyPJ4tT44FTyfX8Jg8Z/Yo8VEeNUXUcI2
         L4ld3TtADjO0yXbXSbxRTfcJV3x5STVHqjE5DWWlf0oOZoCyMcNu24RBaxsfb1NfsjqC
         LHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785893051; x=1786497851;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YTZY9qIc5z9CVljfPesZ7wDN4EMIeL5vhxioi/EavNE=;
        b=arlqpgMm/KTNIGSYh8UJctAudpghqQ9lN0+qSQN7cAZOkAI3ec1P65ucjmwJ+XbAkf
         eVsf/VAme8GYMVJPeJmWjQWk4JsBTPqhxfvA/+BIarYQrEHuJo2mYFnLbH4j24twqtc+
         FMnRuOLCvFwHNs32TM9wV7Fft9xE8jLINlwvLNnjvhDubsfEy7CkOmutAcTApBMCsj7G
         rdBT/qqheIN86krCxdqGfV2tJU6qQ/CnQi38qP3N7NsL6b/rcrnL81Vf+RrmgLH704Nw
         ckp/pATjjUcW7sTl8w6GRy82HTa7YYxC0bWJrQMRWm7YWNooJogVPhuqaFJO+Wqu7Mux
         6YiQ==
X-Forwarded-Encrypted: i=1; AHgh+RrvN1FEYikqIWyMC7ULhRw4M81x3qyYll+lYuLNQsRuMXbmuUA3Vi9FVYC9VNqTsND4t9dqxx/IGJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyagfVoePMnLqZ4+9vHqOHjqzB1q7MfTa9eo7C6V2JXOAjeRLAb
	XhxQGr74B2271Z5s+QcZgpCssMT9StKti8JONADPpDSXR95/Yuh+HrgQ1YDTrSnZ/t46VTnYKPZ
	8XNPiTHHcBOneorV1W7JfHiuCFVl/HXkITK430iGoSQ==
X-Gm-Gg: AR+sD12oKeOhhT056lNPqG6iMlDDsO6efriVdT+iSRD67jDiRtr7rY0VwAj0//mWcV5
	jAEH/he3DNjqsoNR/WL7s8WgJbmiyOhJZHHWe0npIcoods0C6HALdRVrEyN795ATD/GmugSWboK
	HJEHYO7A/UgZ0XtBDGRMs6HDIAbOlai6mIpcDG7adzmu+Nby+G4M76+NZpaZEAMTodc+Ml6KdwP
	aY4uv67mMx1Is58714+Hd3ZEDlVjpYgTjKegGpisWJvtGCkLQqS0Xumi0nX6FUTf2LSaPF8vuGa
	TS/Axyi45P1CSPg7GjyFbNraJqau35WinulOeJxlriuJYj1HbSbzOsRYVY2KJ3wZSCik/6xrhCN
	QzHXBBQW/C5HLkSbA40P0ePi90kS2nNmbz71Awh+EImUkwSRm7VCggabiO4U=
X-Received: by 2002:a53:de46:0:b0:668:8bca:3c41 with SMTP id
 956f58d0204a3-6699aa07c2bmr1434552d50.17.1785893050757; Tue, 04 Aug 2026
 18:24:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723-chromaticity-v1-1-5ef5746ace2a@frame.work>
 <b6e684365758146193421ac3a36b58d55af77691.camel@linux.intel.com>
 <20260727221338.29f1da9b@jic23-huawei> <CAAjcXz45hB7+4wns0L=2VKeAeq2UaPhwHa11vPgFJux7Q1WLRg@mail.gmail.com>
In-Reply-To: <CAAjcXz45hB7+4wns0L=2VKeAeq2UaPhwHa11vPgFJux7Q1WLRg@mail.gmail.com>
From: Daniel Schaefer <dhs@frame.work>
Date: Wed, 5 Aug 2026 09:23:34 +0800
X-Gm-Features: AUfX_mzowNSw8oJ_BWsMvsuBfDPCC2ZoMA7KG6a59qc4VajLvGMGgnsWHW0O6FI
Message-ID: <CAAjcXz5Y7W69LaUsFg323rTsd7waaSnLkD=dJYJvOCwPV2Apmg@mail.gmail.com>
Subject: Re: [PATCH] iio: hid-sensor: als: scale each channel individually
To: Jonathan Cameron <jic23@kernel.org>
Cc: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>, Jiri Kosina <jikos@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, =?UTF-8?Q?Sven_Vaink=C3=BCla?= <sven@xn--vainkla-r2a.ee>, 
	linux@frame.work
Content-Type: text/plain; charset="UTF-8"

>  I'll queue it up on the testing branch of iio.git but more eyes welcome if
anyone has time to take a look.

Sorry I'm not sure what that means. Is the patch applied or
should I send another one with commit message update?
