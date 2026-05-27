Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD288428822
	for <linux-iio@vger.kernel.org>; Wed, 27 May 2026 14:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779892527; cv=none; b=nBiBSyoWLm+hXo8TZPDFKj/VrT40r9imYeUTrApo8JhrZyt7F+24sNKWAPkvNdvMrdggVGR/u7q3eo6U5+bKc5Q6e2dPGPVrS5bUllHWY+yXUvOPf9HpzaHCN2hkuYAEqU9j0SCX94dIKlWySAHzPa6NbBxmPupY9pdp0iqFZv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779892527; c=relaxed/simple;
	bh=WTcPO5jx3m8I3dAcwWfqNAsiqQwEq6XdVKR3O/E/HPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R3NyhBZvRvKbZFQmoYqndbyF5C6M+7MEczQET/mhfwF5/Tx+pf05lVx16w+A0XMbAKYI28API+Urn6qR8dc+Qmzncc5lkLQE0DwcojWETLzZnJvyd58lWYdjsBRp5g6+S3D2Ub1DoVc/BzETIBYVby+keskxY9bPYvlOU9nH/K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nS6EeIFz; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nS6EeIFz"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-441209fb77eso7310162f8f.1
        for <linux-iio@vger.kernel.org>; Wed, 27 May 2026 07:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779892524; x=1780497324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mGLUdia9Sn33UtIAjIRo2viP4FX9Z32Gv1ySJx1Aq8o=;
        b=nS6EeIFz2mphXjAba0hsnvpPilXsQFyq8V5Cv6k20E93+3vK/fNGaaWQSibUZTNNyr
         NpKlXTSoeh96uEID4c20on51llVXZbkfs94N7cJyyLT1G+DAHsAb9BAnY1JZEsIfNgvu
         PtL69EY0qz9kVWbXQFPlZ3wOjDAdLVF7+NTZR65qZuP22D7c4Xud8grECU2dH2/n4UKq
         ACrF6mk7MbQbiTLYhdL80bnwzVq5cM3yxFa6QNe87lwDtSIzEIPlewhrKMriqZBbQnAz
         XxetIqi6e0Y/HqmsLjbzNl2oTCp9MPUg6KIquwQUyAJeNYdupb5x8emvFMYtk3ykhpOy
         sjbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779892524; x=1780497324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mGLUdia9Sn33UtIAjIRo2viP4FX9Z32Gv1ySJx1Aq8o=;
        b=EsGayI55FjfDSaVR91Q9MJ3GdFy516UcA7dJgFa8kKKCCCav6eVv0923a9rTQuzXQE
         hKWrOweRbd0XC1qx85vSTZmB/XT8zBX3maF/N8nUQK1OpOWKGDisrdChovMNud+H/Gmy
         aVQHQOgVUCRX9VbpVjyIbQ4Y0RU06+eix/iPXXcqa7JKpz3FRXdufwlVqneyL6eViKzX
         WeradkVEjunLRz/0b+ssWvu20ezzKdBDyuqARi8IiENRDVYjW354vwgTCAa3px0oosjF
         BQjq+fb6MSc8x9T6ujXXh/h2AEdw4v41MemfZBEKs3GgIjNNWZfQpXvPbaC4y5gI3uWy
         i5Hw==
X-Forwarded-Encrypted: i=1; AFNElJ+kKS8kl4RB8CNxPckv6Krh8o5lX6C2HrLya+X+JdeDFvvSmjEaUjlOuVqP5J3tRej6MAZOBmQdK6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqGv/neYS0WxvvsrkSuXjfqqEZWxUfVtvZkaVPMNE6kjZ+aRci
	8NBmcbag5yuoFcFIkB99Agjh00ULxW8Jc6a1Qhz5IUjABT70dt11EyV4
X-Gm-Gg: Acq92OGewRKUdEsRcdYk2IR/EQUJw1Ba9GL5MvbN7wL1xzJ8M0UIVQGT0Mq/7jba439
	rK/mQX9aXZ22BWxr57dJQay3G9T8S0sRAYOiCDLGzJKvpjrdYoquZD+W5uoTF8RWt5MmetOpete
	rb8nbLCv4OkykLXO3VLQJZaY97JQkbF+aOp6dDcf2ifdLdgOcwOW+kgFalHlCenpz0+CmCRU7yR
	Fe47l4OSR8vDuFJnHLLBv4VMEV3jEuBuZ6MmWe4m00Zp/rLXdjs1yBmWY6agxV7XMx3luk1fOh3
	Ddl4EpCa5rH8vPhkxdjje+ptk1B3uKMb7hL8HEudopZcKe6/Z0kHRTGBOvAKWp/e3csKI9pfdJs
	pftn04Aqjuy3j0fR7JfLObacg6m+O0j27+2VVHnWlGz1HxWd1QgK/tmf6nAg7BW0MsVcAETQnb5
	WHNeQFBoR2YL1HNY0=
X-Received: by 2002:a05:6000:26c4:b0:453:9897:76aa with SMTP id ffacd0b85a97d-45ea31a36d2mr42115457f8f.21.1779892523971;
        Wed, 27 May 2026 07:35:23 -0700 (PDT)
Received: from sefo-laptop ([2a02:8071:50c5:5c0::361b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb5584b8sm6239763f8f.11.2026.05.27.07.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 07:35:23 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
	lars@metafoo.de,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	jdelvare@suse.com,
	ak@it-klinger.de,
	linux-iio@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 3/4] iio: flow: add Sensirion SLF3x liquid flow sensor driver
Date: Wed, 27 May 2026 16:35:04 +0200
Message-ID: <20260527143515.102794-7-wafgo01@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260526170618.14f45e2d@jic23-huawei>
References: <20260524205112.26638-1-wafgo01@gmail.com> <20260524205112.26638-4-wafgo01@gmail.com> <4349f634-dd7b-468a-912c-5ceb8a283954@roeck-us.net> <20260526170618.14f45e2d@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 26 May 2026 17:06:18 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> > > What does the "X" refer to ? Why not "S" ?  
> 
> Absolutely - no wild cards in file names or indeed in variables etc.
> Just pick a part to name after.  Wild cards go wrong far too often!

Done in v2.  Renamed everywhere: slf3x.c -> slf3s.c, SLF3X_* ->
SLF3S_*, CONFIG_SENSIRION_SLF3X -> CONFIG_SENSIRION_SLF3S,
MAINTAINERS and binding titles too.

> > > +			dev_err(&client->dev,
> > > +				"unexpected device family 0x%02x\n",
> > > +				buf[SLF3X_FAMILY_BYTE]);
> > > +			return -ENODEV;  
> 
> Similar to below. This can't be an error or we break fallback
> compatibles in DT. There are historic drivers that do this that
> we haven't fixed up yet - but no new ones please!

Done in v2.  Unexpected family byte and unknown sub-type both
go to dev_dbg() now; the driver keeps the variant the compatible
/ id_table selected.  Only CRC failures and bus errors fail probe.

> Given the need to support fallback compatibles from device tree we don't
> fail at all on mismatches as that prevents use supporting a new fully
> backwards compatible (other than IDs) part in older kernels.
> 
> Whether a dev_info() or dev_dbg() is appropriate for such a case is
> less obvious but definitely dev_err().

Went with dev_dbg() for the unknown-sub-type / fallback path -
silent by default, discoverable when chasing a quirk.

Thanks,
Wadim
