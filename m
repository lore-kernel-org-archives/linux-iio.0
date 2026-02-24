Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2E713C918
	for <linux-iio@vger.kernel.org>; Tue, 24 Feb 2026 04:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771908537; cv=none; b=GnGKIIV6e0+QEiBuPihJzcQR8ozEbAhuT+rw2BMK4rbTfO+ChNN9XvClLe5HGYoy5/ydX3w4KwUFhz1mT9M76S0sapr5Jfqa3m5Gwo8sZTUasjD+mylR6ikD7JlYqP5GUKvNVS406CwH+/6t5982e6IEunUCk+IEJvAEcys+JDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771908537; c=relaxed/simple;
	bh=IphyDIitCw1kE3a0TX5MD+mLftcNLY0JuKxu5X04Fpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lPyzHkhhfBSGPpUALEyt6Xr3St8Y3O5BxSp3UC5j1kSNSm8LxwHUx3zYbObvX/9rcGN8hTFThAlIzCfu5T8BgA+n+YBmf/VuWgWoRO4fKZfj1zRrC+Vxmmpg9ZieH1kXm9swlFUDigzqLv+LlcQM12i5DOwDMEnsrCGh5J3Gqb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HfESV5k2; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfESV5k2"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-436317c80f7so4052238f8f.1
        for <linux-iio@vger.kernel.org>; Mon, 23 Feb 2026 20:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771908535; x=1772513335; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IphyDIitCw1kE3a0TX5MD+mLftcNLY0JuKxu5X04Fpg=;
        b=HfESV5k2LaXpL4Nf0BzkdWAAN1KwvgGY4Pauc9tJvNw1RbuYikViIT7KKDPhF5Do89
         KSgtdfrCWSwF4+Tilw7hlVnTS2s1bIECH7+H6xbPMm93igRWZGM2XCw/7K+ZtzmFQcZs
         gu6dMb//Z9mfrX5FH/9L76dStBU1EODYjPq+01si5HGQOJur4M3+D9xXTdMoTAn6wktV
         00qhb3JDqF+2KhpSWai05JqFgijt/UxJq7ALxcDryt+pkx0e7k7hZ+i7aDABcOCXjekl
         4Fvzbl7WCLozGlnCDyNS6aypqCFDSVrdlEOiwIz3lzLq/NisUaB200Wmyx/eYaP7jrWO
         FzKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771908535; x=1772513335;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IphyDIitCw1kE3a0TX5MD+mLftcNLY0JuKxu5X04Fpg=;
        b=M7KC1w0PJA1DmWWm3ldfjynCjb5G7V8DjARc3Ov1Q2XE7QzPrZxIVVGgmHw1S5KtYe
         j7uokYliIg1qwx46A7DaYu1aZgMsZ5fNdLe9tCduhARC0GnlUsiya3VAofzL/CNdKqsM
         rbMyHaiatiS8+lHv5KPcVjkLJn7bLN7i7LeCDsXGf1iOs8kydaNDwtixH91oo47JHiXc
         lbaA5o41rZZzmyTOk7wwT8doRNnoZIeaO65B3xrRfK+354vz49Ybx7g75cp2HJFqRJAh
         8tXN+6M3nNCZt/qzkV+Np1I0/5XzxTosBnD1iqJjXDgwyxkhnEqDBttE6rQslvppjJth
         pAJw==
X-Forwarded-Encrypted: i=1; AJvYcCUPCFMOFTvl+BugTS5NiVTKAVswQ/rBFOnsUpzTIsC7UEuGcBgb8OYQUj1eqApArxKtUvNY46qkT/8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+uzdAEAYBN5QyIbR3w2UuVtElgVxEFEmCdFU3E7lA86OgAy7t
	vT9hJBKWu/tQkBn3RLLyc+J26O3dgp69Qtm/mF5OxZFxEuEubVnL+U6v
X-Gm-Gg: ATEYQzxRTjsxoPqnusPMiuTL8hj655BqaKRc6/Qz8/jlRJSjHxrTYXNDX6YNWHtSBaw
	6ClideGsNHrL7gPqY8id8mSN7+G0hH0Obtf944sG4CHZbtTHGvB0CaDVMyKXaKrIKssDj/B4Yv2
	8VqDFCWJWHcbdHU7FV31BOMX14qs5pGlxYsTgE2a8vg8IKwtyJnZI9phY/uF6ELFchGjMHvC3VE
	ivjvpQegU30/oU8jMU1TjKUNhO8fegqK178eg9pCVt1wYz9wEMMGegXHoQLa6OtxmBXHKI2QpSd
	xauylm06yQbDBPMrJTeRiWmi0XpaCTPFUYB1/CodnGpmW2JGFPQ1YIxKxmOZeHcVA4TZCxoRskj
	+sZaGu156rmUGH9qske2JXhcgETl/XVl0x9AgOvZYN1CEiNTXuWKGw5aYNGIFD/QyBAWqT08wT9
	otCwX0IHHXTq5b
X-Received: by 2002:a05:6000:3103:b0:437:6bda:d979 with SMTP id ffacd0b85a97d-4396ffdf07fmr19850683f8f.27.1771908534623;
        Mon, 23 Feb 2026 20:48:54 -0800 (PST)
Received: from pc ([196.235.37.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970bf9f77sm25585997f8f.5.2026.02.23.20.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 20:48:53 -0800 (PST)
Date: Tue, 24 Feb 2026 05:48:51 +0100
From: Salah Triki <salah.triki@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] iio: core: Clean up device correctly on
 viio_trigger_alloc() failure
Message-ID: <aZ0ts-tUTo3DKp00@pc>
References: <20260221073301.105080-1-salah.triki@gmail.com>
 <e49877b5-2a8d-43d5-9f8b-de37cde9cdcc@baylibre.com>
 <20260222162043.1791ab3c@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260222162043.1791ab3c@jic23-huawei>

Thank you Jonathan, David, Nuno and Andy for the feedback and for applying
the patch. I appreciate your help in refining the commit message and the
guidance throughout the versions.

Best regards,
Salah
