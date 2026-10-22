Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792687515;
	b=Y9kbKUXU5YCU05Az9p+FX/IHkNDmKcONnS6GlncpjanZHLEWlS6Up/EBw4heyuTkDaGq
	 wAM5LbYIEhp3eUTfi+gRVnjbgpkXmksI9eVbKZwh1bBHPQ4XjQlYuUjYkWgTnLjsZJi7l
	 mlnyFxkli16/cbzjgHQ2i+a6TTvGv5CC4VC7ExzVALJ/FaMG9zTN2v4wZ5exX5Y1yDY/7
	 ZACJn8TU2YhRaq8Ycp/78KR/FBXa5HA/Ax/dEbS3U3KCUGzJjyLvOixxvmd0IszObawls
	 /AUDzAaiZ7xUNJsMNogArOqjqy7yoM6HEjHA8/Z/CfIAQ9G3jpvFxQ7wb86c3jfneXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792687515;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=JGlsLpHXpIQv7tIcULxVWCH8ZJux0WaXSvk5ybBuhZc=;
	b=gA0/6ZiQLeeJQYGgOJnqRHtjdyyEPugr7czS6/mCoj/3kBT3pLjU85R6WuLuiGHNSYZL
	 0Qeef7OF/KXL8ryzC7Ro990x0bYltKBoLNIGgj/1IyGzoKt6ckVaF7EQifBHpHseD2dmz
	 QD93GgzFNkdB7T+hcGGJY+ppf1dLHz45aVlWV+UWfEDTt71Hagj+Abw25Py4nz3b+4PJX
	 q8+lKgzgOAyRD7VZNz4eAUVZGnjz/XT+qTOievDMwv6JbkNPzT/dn/PSaj1LT8v1Owfey
	 gM4mkkF4BZA478mdgPDDR+bBiGbAZUix2xNf0PqF0kxPLMJqNc39OsAFrdSf6XqUSxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hDtu2ixz;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDB1606A322
	for <linux-iio@vger.kernel.org>; Thu, 22 Oct 2026 16:45:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BDB1606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hDtu2ixz
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-14394530ec6so2836941c88.1
        for <linux-iio@vger.kernel.org>; Thu, 22 Oct 2026 09:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792687509; x=1793292309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JGlsLpHXpIQv7tIcULxVWCH8ZJux0WaXSvk5ybBuhZc=;
        b=hDtu2ixz0cDU2WZXnqEshmApKOvlvhL0y69OjIS2JLtfncARrSsFgB7cDWWjdAMdis
         8Jlo6uuFiIw0J3N6w0F1QV8L570p5992RVkE3gO2Va+q8g8h0m+FLkV4xqCsxvz0+6WZ
         mA6+KueiynFUe9HZ6QMSXSGYIAqw99fHuNptzqIivawOap1LLeoD7FPmyx8KOAnM8mZI
         8TNkNGz5z26g1i2LpITPtp/CuRfeW9ts3XjNn/MseStMm3psT5MK16d89wegUi57QZ1k
         r22u0XKZimFkE/E/83b1hmBxSrmlV0ElEhm8lhvVHRXEp8wzcnIpVTvKAvPx1iVngjI2
         j+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792687509; x=1793292309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JGlsLpHXpIQv7tIcULxVWCH8ZJux0WaXSvk5ybBuhZc=;
        b=pWMJvm4D+XkQiTOmm7H5uSYK7lJRofHIDaD4QqVdsnHYQCk6dbkAiAqo2LrI3vBNav
         XlItFtQPL7HxTG+Yb9xtLzmujS4jiAel58bk3HoaRmpawbbT9RAx4UQmXOQVaCIc04M+
         KJhyO/2PCUx/rbY9bcQ8wUpb/SsLmCmjOj7XlkosPa3QRUm9a8jni8yC9zOCPOq4SVd7
         ghHNvfLsv4DtcBMaHnAp0BYf2ZnYOxtVPZSUWuhGdOEXL+EY+hzjgr6qXD5z3kFhxmpi
         uMG0jqRsDdhe7dDL97gECC8eyFPd2oL95Ulpa8lMN/TpsQ0cXjmGKFO1MNLHzwOEriiy
         /aOA==
X-Forwarded-Encrypted: i=1; AKwUvByg8GgQyv9tSID81aJHBS+KniR6qPgbJRRYMOG6NfxeXmvJTcybU+nmI+K+R/PHNwqQN1VHnYiDPz8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKrRHSrYcm+3TZLbfcuuF5D/sJnTfWNF7M642wPJN+zjBxzSKve
	e9KbvsotssqWEyCwmx0VLAfDKNReXDgSc97nx1k8TiMMHRNx2mLTf9hw
X-Gm-Gg: AYBFou0WCvaYlZnM6QcEIEI/BXnSFwR06AGbf1Oe4pxCL3koIsnX1v0dxSvYtyszd53
	NSdxrVUlDZrmMn/Erj3UlVz+7M4PXw/ROrrDGgFMacv5mMxKS7KTnvo/wCbgY7aKJNNgcBFqRMu
	Yw3uNSGVWjILBhR/2TvNmObxAK9XIuKpAYikhyNUNq6sAsvsTbXZG+gEaIAl47JN2niCo434yCZ
	EC867EEy1i+OV06wE4L0LJZtfxtJov/ifiO7JsXeSu+LzfjYmoVIfDFmQxVAInVDrA+wBcl/e6E
	jlqhFffS64TGpa6Ud8BLOoRpPdn5ala/90lAVDzAmYrCxmVfzBtcew+ILM9HRbaInazaTxKWNx+
	hgL1g7bpQ9ujnY4YjeermPMCooBCuW0TU5QY+Dh6CsWGHnnRgVSSbJDTtFyBnTIyn5p45M3E7Ik
	ANXHRnPJ3pJW9sSPtBht4i4HMn4Gpd6TvDX5Goh0We0B1WpNFZyxS6QVKTEtAu+5ZZ80aZAdVq2
	VL4lMtnuxoISZBE3q+n9PkQLVjkWnSWla10u/IxUTbuv69xbS20K6avrPkT59H6MLfmkv7XYJdA
	+nDLK57QtQ6L/HAE0fBQOpACSUTRSvvkx90SnL/326szZw3N09Ryom/1UCaw0KKzZlaIPHTT2RY
	sMbI+DfwAZL4=
X-Received: by 2002:a05:7022:3c84:b0:168:6ad8:e89e with SMTP id a92af1059eb24-1959ae11b35mr22548c88.45.1792687509046;
        Thu, 22 Oct 2026 09:45:09 -0700 (PDT)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903a180adasm15841782c88.8.2026.10.22.09.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 09:45:08 -0700 (PDT)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: sx9324: fix out-of-bounds read of scan
Date: Thu, 22 Oct 2026 22:14:52 +0530
Message-ID: <20261022164452.201416-3-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <ato8fTSWub91Fy2R@ashevche-desk.local>
References: <20261021225417.626946-1-kapoorarnav43@gmail.com> <ato8fTSWub91Fy2R@ashevche-desk.local>
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

On Thu, Oct 22, 2026 at 07:40:29PM +0300, Andy Shevchenko wrote:
> NAK to this hunk.
> Homework:
> read my comments regarding formatting such arrays in linux-iio@ mailing list
> for last calendar year or so and summarize the idea.

Understood. I'll go through your comments on linux-iio about formatting
such tables and redo the array accordingly in v2.

> > +static_assert(ARRAY_SIZE(sx9324_scan_period_table) ==
> > +	      ARRAY_SIZE(sx9324_samp_freq_table));
>
> This is fine, but I would dare make it a single line.

Will do.

Thanks for the review,
Arnav
