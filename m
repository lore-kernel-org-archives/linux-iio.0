Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D271FBC8E
	for <linux-iio@vger.kernel.org>; Sat, 27 Jun 2026 17:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782582020; cv=none; b=oK/ITTXnYsYGrNfQB8xHOE/jfgIQGbYaz3BpYKOUBAmuQSozFSObQ2dVjbWTM1p/1XDPmawrKi78UCDU6IO12Uy7oa+wLnJvWnLMm3msQ2zvtsCkKz0JTNvpFdwMrR01HkPz5eHM2y8oFRfpqsPiS9r70tHETg0Vf9vOFEwK2WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782582020; c=relaxed/simple;
	bh=sH/OE4OZLnWemRgst6ORI6Z6Hzc1AeRnqslsUYw+TDM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GAjZrx+SHQhepxyfaz0J+kWQhLGpORwRwrYLN4yF9u3RvvMFZJinq+zxhwGa6lrct68P6kiiV17LnsbS94FyT0zvf1m2acZrd/TY2gZ+kgo1i4Tch0ecxh3tQ7yb/VJxSM4SdJDfwhX+sAkkrbSifRkhC5KVkdI0+7GGo4goEWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bYF1Nlq0; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYF1Nlq0"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-493a440bc10so1801545e9.1
        for <linux-iio@vger.kernel.org>; Sat, 27 Jun 2026 10:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782582017; x=1783186817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QLaUaEkMKqRuJ0ujKAXuF+B/7pYGukybQE5NVej1Dbk=;
        b=bYF1Nlq0fVstjOj5ZapTOrHb+X0dsWw1xw1tn04aYGcx9FgUY2gyAAQn7eM8dZqEYP
         v93O9c3oqMp7oj1nMzijCOvszQcBy70jQyMYfBqGRS0C3NDYQtK4CHxREl2F1/8AtUlY
         GWhxWTsIwgqpGZ5op8iLNz3l1PmmcHt6Dw1/sWCsazwtIOj72HJXaRvyM9pJL6AnorOw
         CHmBEPOlDW3ClnoPWH0reS+58UZJWtwHAxcUIl0uMB4BMoaWLqi17OoyNpocEKAwihc+
         dDu7rK+NNjAPS9gI7OeXJI3MKhIRKuit2F0rkZGQIVKzKUQZQjEUFIjmwtSCKTatO0Zn
         nL4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782582017; x=1783186817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QLaUaEkMKqRuJ0ujKAXuF+B/7pYGukybQE5NVej1Dbk=;
        b=nPvhfPc0QIXRfX+O4+HB/Cmwlha8/4GtJqAcOsf0ICJKYb7t/rQ6UpHurHr9BlFpdZ
         ETHWyIvA6MWMNl7P8Ug/wz59ajF6n50uWoEW+nvIMIRzT5s+VheKXI/ZwZVIWVXZM1Lx
         Hm9cdRRuouK1ksU0xFQiJZ9WAuC86c+qxynnYqwcHZOdhmjXylWv79Vj+2i+yZseW776
         7pk/3K/VF3tyQR9XRNzxiE1c1PD6flCA3dHmc9GXX3j5DWyNV7pCj4vw7kkX4Bk8on/R
         gcS3UyQqZ3WdW/v9guh5TDh4TxXTkT5xA6w6UzqzSdXJEbL4y5tG6nwUyzxrg6LceeXj
         GPVA==
X-Forwarded-Encrypted: i=1; AFNElJ82IYG/LyDkRV2mySjTLKQe9t+L+VsTPORSVBgE4XIkHdZEbxpNWmCOGG3ps8SnYhfNRUCKaZEBSo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMlCel1JaMQeoH6EfF2XmK9AQsC0DlvCmH2nlE3znOMR0s8Bq2
	5J+qYYej0X6Aj1vGy1jp5LggocaAwqXLGXF4n/gbjulpDrhYQvXu1xQPPyfTXA==
X-Gm-Gg: AfdE7cmNBQQUnZvWc5xOxaFKp/Wq0xUOVKdtqAk6IqPicTXPJ2TTKra7vC+gUbWURHB
	K4gp6iWDKx8Ikh5LFrEpopX02WsBH1wnv5CiCLIfN5ZkGBtp8eQScbwXRErK9/MhrI787d8yMXO
	SYdPnv0Ir+AUBOhnzqxZjbozM/9g2FRLaP5RpDyR7co1z1cE4zHGzeqdq8HAb6sFRN27NJcCye7
	d1HLShiwEwKDzCJ/+fvjSQgrFtm4xAEro4nzhAcVCu+8kAt48uTQam0jqI4+T9CUybkCBmDe+oJ
	Xj1kjAitpkK0v8qyDu4DmI7Bh0QyjR432tX3Lnl5KxBsY8FjeWMStKkvP7w3/vMXPCll8lrLIq/
	g4axMwITOKZkt5Q1qrMBJXv0SRfHNY2rlYF4b6k6U3pHOxoKsvr3a2vY0bgBsV0zpjy5EePrSdI
	cPeE+pCRnb+32nzqXVAnBqmLc518EQgNBpQnWtV0z5PphsB+iJyb6MMTh6vcdG+6rghlWUwjthk
	miQH9nBscbyHbth5pHb+tb5vsBCrJ1eZPGDZPtMdPBOzKO9kcJ4AdNuqMaRins5wqjlgAzgWebM
	n0LbJQ==
X-Received: by 2002:a05:600d:6447:20b0:492:259d:567 with SMTP id 5b1f17b1804b1-4926689869amr129421395e9.23.1782582017046;
        Sat, 27 Jun 2026 10:40:17 -0700 (PDT)
Received: from systembl0wer ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4701835b625sm10378043f8f.36.2026.06.27.10.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 10:40:16 -0700 (PDT)
Date: Sat, 27 Jun 2026 19:40:13 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Erick Henrique <erick.henrique.rodrigues@usp.br>
Cc: jic23@kernel.org, andriy.shevchenko@intel.com, andy@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 2/3] iio: dac: m62332: Clean up header includes
Message-ID: <20260627194013.56ba5e36@systembl0wer>
In-Reply-To: <20260627132530.96680-3-erick.henrique.rodrigues@usp.br>
References: <20260627132530.96680-1-erick.henrique.rodrigues@usp.br>
	<20260627132530.96680-3-erick.henrique.rodrigues@usp.br>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 27 Jun 2026 10:25:29 -0300
Erick Henrique <erick.henrique.rodrigues@usp.br> wrote:

> Follow the IWYU principle: include specific headers for the symbols
> used in this file and drop the unused slab.h. Add array_size.h, bits.h,
> mutex.h, pm.h and types.h for symbols that were previously pulled in
> only indirectly, and add mod_devicetable.h for the device ID table.
> This prepares the driver for the guard(mutex) conversion that follows.
> 
> Signed-off-by: Erick Henrique <erick.henrique.rodrigues@usp.br>
> ---

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards

CJD
