Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3633E5A2B
	for <linux-iio@vger.kernel.org>; Wed,  8 Jul 2026 06:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783493448; cv=none; b=oOUeNGSQq8p2Tz2t2nbhgMa2HL/OXb1GCN/EOKhgwgx2TEA3zBoP5aPUV1pUKSalFeP0n+qplcwfXNUYmrrt7q22DOmcCBzx1ebMDxhyo8F9PCI/Oxr4dAMttdwNHCfjbiVteKM+YnsOqug764Nd+yddrZrxkFWcHobMT9AiDfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783493448; c=relaxed/simple;
	bh=No5bTpfYJHt7PmnWogaBiYi5lgEwHfU7nto9RHpItjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VD+1TaeflsRwri5fYNnyFVinSH23COSYefhgGhvZDdhpqZnsDG5TNArGbbZ5QkqSkYOhG2/oWKEt8vdSJcF1lg8gPNJ4YB+s+xAfa5BRh1X8E0Ok831it8UM2cS7I80VkA8VJErUL3QxgIEDO6IxFG9mLINwifPMxgfjKHiD1Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6466pOH; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6466pOH"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-69a50b818c8so527117a12.2
        for <linux-iio@vger.kernel.org>; Tue, 07 Jul 2026 23:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783493441; x=1784098241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R75S6JJFoBQDBP3lQt0K+VF2GV+dgULvwWEVOBCtuJ0=;
        b=g6466pOHwc0576e/kdTHW2NwytS2A0EKbocmPJJ8XxFYhySiOGwOXWGAvlvHmDV18M
         mWZVAcgeodGSm9X7ifGwa3SfRilcmMXh8OlzoHGpKMByGR2uypIHyqUHAdW9tkd7P3Pu
         qzrGSF6IAIadQhwS4onzRxrHOXByiuYWvpF6QpXIB3n1Le/cZrA2swFartOxdTow5wcI
         T/zSrBDioRUtUp7aUPMHwa5ScqSxT5qDdo8MRU4NpIXhPuuRaJUtKcoj8cyTS7J/Atf9
         4l/XlPRcEPSy94I4ETiG5Z9rdpxqi6yY0o4sTv/K+apcfg/bKF0672ro/s4uXamaWG1f
         yMuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783493441; x=1784098241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R75S6JJFoBQDBP3lQt0K+VF2GV+dgULvwWEVOBCtuJ0=;
        b=mvcX4Xb63tnoBhNCNXZFSNjOb5V8AuRzqXXF0ibn79TYFGh9sgGw97m/VBz/UansEp
         X3zV0nfAw641JuoQNQBkZLXQIq6PPqzS1Sj19QlJgzICpFt8SjNZf4XN6lnh8XFJk0vs
         ujT30wIAz3SsumeorGZuLMq0RTg7LdfpiAN7WXA1VgV8vsMhnXxQ14MDsDFdDKd4rhHv
         D6qcTAzjsRfncAUEk2bDlLdKFUG0GwdSeEKlm6ajkibB3ekcuT0ZH95+iSJzyRFQKnjT
         UIkIoxQEY3lFEn46RQzUrK4GuEZ5v0eOYX1LwdGAlsSwpg33IHxFgN6BVxMQKxmubwDs
         5omA==
X-Forwarded-Encrypted: i=1; AHgh+Rq9y02CTE1s9xLDEJEEz9UakwnkfVsUfKNa+thjbuG213WC7UwL/iL/CwjrvD962jrqseSgMfd+E7E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6E0lx8U5Wu5VcUvdUtMW7ETW2OmFsf8u4rmN+3GAasNGzuzRY
	gXnHGVCFp4xfyinM6pTZItxbeqHmzJVUZUAePWTTPb27EpO78qcA3V6e
X-Gm-Gg: AfdE7cmcNWmZ2qMS6JMMhkEFB4KE/ywevbexHXnzbMKuvbfEoM1VLvNgdJOQdlGUo7K
	1CJcZ5YQqqPT16laCChLNqLcqrOYIdJHhldpytAjMT4kAatLTzGghqLqJQH87+j3ccSupFW0WSR
	lYJZOI9hNu6cbRV+FOmsDhnI6jPjAysTPMbOGZwrSvsDXkR8419AlfV9d+Eq2cgCePfh/ds7U5+
	d30b8jgUgd6jJEnuuou2ULeZ/0fEQ+YkWvZkWuYUNXfUXcNNEzL16dwXmHrxfe7ZqIB+OEGGBE1
	TfLJnGF/wcse5eujTRQx04d1YN/03lYxLKEinEoKhsBDhUluT0grYHLMmTP4YMJjeRgGWLKNAkN
	BvM0n3SA7zMDxGTalCtD8nzHBZiyw3tG89uiF25MVc+cR2BKzh/02zHSOH3g0nDOLJsjSEZwQFW
	NI7uXPwksAxO+l3rCmlcKF4mWisbPfBd/HR3K00feVZ39dEo+7AmQ34W5qFXGzhzNe
X-Received: by 2002:a05:6402:50cc:b0:698:9251:2f87 with SMTP id 4fb4d7f45d1cf-69ab44b47b6mr348803a12.39.1783493440447;
        Tue, 07 Jul 2026 23:50:40 -0700 (PDT)
Received: from DE-PF5B95TD.embedded.cmblu.dev (p5df027fc.dip0.t-ipconnect.de. [93.240.39.252])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69a19d78a08sm7792403a12.18.2026.07.07.23.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 23:50:39 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Cc: Wadim Mueller <wafgo01@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Maxwell Doose <m32285159@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Rodrigo Alencar <455.rodrigo.alencar@gmail.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] iio: flow: add Sensirion SLF3S liquid flow sensor driver
Date: Wed,  8 Jul 2026 08:50:07 +0200
Message-ID: <20260708065010.89252-1-wafgo01@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260621145117.70b2d50e@jic23-huawei>
References: <20260611132700.671322-1-wafgo01@gmail.com> <20260611132700.671322-5-wafgo01@gmail.com> <e01d100b-9809-4af3-8f21-055f687ca6c6@kernel.org> <20260612184729.795e0e84@jic23-huawei> <4e4ef1ae-62e7-4639-914c-19f49930be02@kernel.org> <20260614161011.7f7946f1@jic23-huawei> <84503093-4bff-4c93-aff8-aa07e1a6a1a1@kernel.org> <20260621145117.70b2d50e@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Sun, 21 Jun 2026 14:51:17 +0100, Jonathan Cameron wrote:
> Ok. We aren't really making progress.  Let me layout the three approaches.
> + advantages and disadvantages as I understand it.

[three approaches snipped]

Hi Krzysztof,

short ping from my side. I have prepared already a v5 with the review
comments from Andy and Jonathan fixed, but I hold it back for now,
since I don't want to change the binding two times.

Did you have meanwhile a chance to look at the three approaches from
Jonathan above? I can respin then with whatever you two agree on.

Thanks,
Wadim
