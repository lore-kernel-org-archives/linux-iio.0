Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A40288C3D
	for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2026 11:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782646920; cv=none; b=TYEs/carz+IwNASqqz/bq4sOc9I0L8lMlDwX29BinbrEprpGmhLeJpR8sl+1C2epdRWaYKN35028lUHjma9DbLZ/ZDn861YuLhTMEL3gl9p9SUzIhogiT49rXmDTMUu2kyq/1GiPpiDeyifjsOMyD0XytIsNuJ8OVbohjBdfnzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782646920; c=relaxed/simple;
	bh=SNKJS9yYgXB7bayS24ft+ewfUi6wqyniyes022jUegI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o/T8n6so6Nwl36P5/Q2sL1wt6ElpgG9qnM13VAdjdPLChuWYqN2Y1VuTIzp4xHKANafhJGRBTLrln8RlgJL/P3Xl1omMKQlV04pszW5k+gRyWLN/EtouVrRJBv5bFd+UOEwMj7UWMTRE4kD2s8hRc8b4QH4zfCenZU9Nt9+rVVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBCJlbpj; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBCJlbpj"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-470174001a0so751513f8f.0
        for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2026 04:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782646917; x=1783251717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7uyPAwVyvsUXZcqaFYsRvsgP/pw1303XGcL6NKS2aK0=;
        b=XBCJlbpj8S7OiFguler8bXwauv6laezTIWl6BIC2E2o0uKkjD4zfhGJNpqALr8eBkb
         zmCeuhZd1iE7+dWRy1pQXBJYm7IDBf6UuGTQ34unGohCgGTBf8qAKO6LnMSMBpAg9ynK
         cW25bm2k2vyv50g2KtbJ7PI00vmXahCkdJ4nVutu87OfdregYvICecLJw1VKjgtZcSYF
         ThGbF1EUJH1tZ+TmOh0ueVekDck/649PQpli7F2HMaYxiR4fDg5DOk3CGDPv4ynXE5gm
         aNvaTJf8yhSyuLQWRACCIEQnTaOshXzXk37QHNOLmjZ96ry7p9IxM6pFRMqkvypETfG6
         7WxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782646917; x=1783251717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7uyPAwVyvsUXZcqaFYsRvsgP/pw1303XGcL6NKS2aK0=;
        b=GdhNaA0ulI/JvnEuokll9uMClcQc63sBzpiebaJ0XXPzAjzzTgDwiisKoUvbe23720
         vuBKZCjTstO4ogQkOlWFgBtqREC1v4m5cbXxtwYu2t5wZzu3kIRscxbMCkALP4dTgEQz
         3/yy8ppH6zEXVFdfF0ho3LIiPraxuVeO7ZGQ3G4JmMVgXaSLYreB0TkXwah8vu+QJfn+
         951am7mxZgn5O/rWxmCpL717yGYPSvY9sNoZ5RpHsY4/6MFoCTM2U9U8xfcgo6Hs7cpM
         +Eoyz8s8Gu7gIuGgk82er5N5jbVxtQ34AUPH9JpEgj1OM4xJhiRsa1tcw05y+6oV8Zf1
         OPYg==
X-Forwarded-Encrypted: i=1; AHgh+Ro2GUqg3PsVuuf2Ibtt3iO60CC2NzMLQzA+zeCjOVrpORN/jdpEx/M4BTRDPoiyt9tG2xrb1/O3bF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbNlcphK79MyEHAqCAmwYXe0Z4ePq1AsXMwbxu+juNgck4rgan
	a7TbNyJqZuCaPZyKoS3hR3V5yIecgNqxcT4zTULk0Ou2Pxs1vkmBvitS7dnUjw==
X-Gm-Gg: AfdE7cnKlI2GVIhio0fi5Crxw2kW9CUf42SjrpKlMKbNAwbaXlKxMlRLMVcCzXwRXRS
	DK0hVxIMx3WGSQ1KbU7VW/E3/essGgBwfthJUITsdPNpjuHJnXang0xzv3eKkhhFYIYFzaNWFcB
	ZbRlRhIs4ugGyJlslrHBsP6L+N6UHzFsStPz2iCyQtcujhEqkIPfB4uxdBngxgazz/QXRwOG4ID
	PUxVOMTKAubcnLtEvOgZ8I7JC37L5Usw5aTL3E2gklkaiY8eEnyHyMC+gabqIhYJXX6fHV0dWp1
	ZSRooSluLtr03/9creSN2qAnV+ny/Y0/Si/FvPHpadES0u5EaMOCa3zQkzLnaoguDt3+Bf6pGA+
	ksdTQBqF/QdFjQZLbeZADbzwsU7KQ5V7Ubhm6OQzB0ZtFa5m7hyFHfFagHynlSMHzAD2UZPlhLN
	N44oE2K+uFjuLevjP1F2N2zg5EGHKcrLr+kgx4qCdVsteUZ7p/wUI/JpMdXnyMILln3izfx9BJA
	rcoWnSxi4f95yQWvu4OrcnaX4/swl8o4WUQFY9r9kiY/sjvcD9jFcgtHEWcf10NsqDXkPXhLsjc
	BgkNpYVKyQkYz2Iw
X-Received: by 2002:adf:e013:0:20b0:46d:d693:88cb with SMTP id ffacd0b85a97d-46dd69388f3mr14697551f8f.46.1782646916600;
        Sun, 28 Jun 2026 04:41:56 -0700 (PDT)
Received: from systembl0wer ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46fe25429d5sm19439103f8f.7.2026.06.28.04.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 04:41:56 -0700 (PDT)
Date: Sun, 28 Jun 2026 13:41:54 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Moksh Panicker <mokshpanicker.7@gmail.com>
Cc: jic23@kernel.org, nuno.sa@analog.com, Michael.Hennerich@analog.com,
 dlechner@baylibre.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH 1/2] iio: adc: ad7779: Remove unused completion field
Message-ID: <20260628134154.39236df8@systembl0wer>
In-Reply-To: <20260628071405.51030-1-mokshpanicker.7@gmail.com>
References: <20260627192638.5623df0e@systembl0wer>
	<20260628071405.51030-1-mokshpanicker.7@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Jun 2026 07:14:04 +0000
Moksh Panicker <mokshpanicker.7@gmail.com> wrote:

> struct ad7779_state contains a completion field that is initialized
> in ad7779_setup_without_backend() but never waited on or signaled
> anywhere in the driver. Remove the dead code.
> 
> Suggested-by: Joshua Crofts <joshua.crofts1@gmail.com>
> Signed-off-by: Moksh Panicker <mokshpanicker.7@gmail.com>
> ---

If you're sending a patch series, please use a cover letter (if
you're using git send-email, add a cover letter with the
`--cover-letter` flag) where you can describe your changes in
detail, along with additional useful info (testing etc.)

Nevertheless,

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards

CJD
