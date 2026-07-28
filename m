Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBE53F6606
	for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2026 13:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785244565; cv=none; b=YMzARLnveqZDl85FJoYygRNXBxNzsIg3QZRhuzj42iAkltlYDbLBH+9j+kIkv9KcKg0t6fqvOWmfH1o3LE5lAsVKl/jpD9UQj7yTg9pWb8vZNVJ0rte5OOsZ54mlF3dOxtOLyrIDKwMJI+9C5HATfqsr52KEbD3UrUdH9M56uw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785244565; c=relaxed/simple;
	bh=cLH93zo8+5LFvseU1ydD9VGz5QwjgSRbVRGQwkX1r9U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mXTllst1mrdZddLpJul3kNfAeC+mm6BKV933uYQX+A+LfckR/+Kw62hiToXTxu0AwuQRSYAD0kTXg/HcSXaN8g77q3bAC/7oAR49S8roy6dxqwiSVkkLHn2iHCMgqwGf+lOsS4KedqHl6rBHcPzi+imc0aNcz/YI6jYzGdg+JB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQKjZrB7; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQKjZrB7"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so27643575e9.1
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2026 06:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785244562; x=1785849362; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NJ8Sz4jZn4MiZdWgUS+toUmyc9X4AmjEUEaGs5iVrDk=;
        b=WQKjZrB7o3S1TXPjgtNoGkBXQhXmqq/Z3QIfkPsGqHVAEzuozPtaTLqSLKumMTmixh
         nPccRnQ4jeKaDs8lXgtCNtqCvpiHcf0WD4PTM5XsTeOcMFys4SMXFNxkmzIvTcSmR98J
         itzJeebwYl1rPHxXST/7FzukBFxIHAQTs7W+pFCQbIfVrCVftIQnBhdlZV/1dS6Eb5Fq
         5kYWMz1Y9y5dqNg6/y9oqxWLoF4olZS1Bo2db9s/KUrzPBatfHY/68WBT4bfgW5Zm1gU
         IzrxZF0QXJd/kfkKIa3SPoThrAUB2LaEhn50ThjAF4n4gTEuC2s0IqybOPsGZ7SDX8yJ
         FaYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785244562; x=1785849362;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NJ8Sz4jZn4MiZdWgUS+toUmyc9X4AmjEUEaGs5iVrDk=;
        b=fe89CmWh0xx0Lietq4ZOdQ2FUhwK4lrFFePOY/UgpDfMHFpS7iqM21dwedHw6Awr5r
         QmakqVm8NDFjWpwaxeq/AQbt7h1n20RVYEFTvl9eGrvmjx3/Lp6/oM/fIBCpUzHDmhRp
         E9axauSEiT6OxMOHlAwvkA6kmj5rfkQGDaFiOklVkaLkkTlrqWeS1W6rZi8mItzws4UY
         QqUYGocTaUIyjBDFRwyH6nfpEvSq1xyJ9SGrpjuimcbLUvp+KvanwWMZsaR4set5WfWd
         xX+GVD+NKsWJi1JAnwIU2va2bdGv5kSt7iv6EW2foB/oFOzsH8qzOnWzBhYZAPIlhW7B
         zAWw==
X-Forwarded-Encrypted: i=1; AHgh+RqleTCznK48sQ/IfCfixsnmkl8DcP10tNAW6XEudeEYnslQ4yCZLD9coZUK0JGX13WGi1EzAM0uciQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/TK4Vt8X/oESZIsm9/MKzbKz7X+7rT8osV1TTx4ePNONEJWap
	N1+j7XzTyxcqiC6ZNuvK1I30AGbkFihRz90NMR6ARMhUPoqM//CSO2rz
X-Gm-Gg: AR+sD12F+OfWpauLc4InFebiTE+qteZBAAbbZiWN1dCQWKRwWuonGwC4g3iTrc56VRG
	R3F2Ad2wp8+q4Jlfqw85jdyLQZ4DQ3YN6n+GJawOZfrCRo2mKb5UfCxnAwPjUM/Yx2WRQ1zAh5V
	P8GJS0N3Twlcq5uOsluwON+3Cn77vcBmENNPnlvTG+MoFWnEKq/rmuQLVhWMX4JIkKjtGRo1K8d
	emrWjbLpnJ9YrIfZjVGIcL9hh/DPLs8OXrnfcZRD0l8aQTma8PmbWBPCkize7YlGgO0cEteS259
	TD+LvhEQv0xz/5VSgZttNkNdetFW70nKC/IKQEHiaHrRupH5j0V8czJPRUIKV6U6tCb3YprfjxJ
	cfdlwXOi6JOY5ZjekcYTGu4792Xa8TpiVc3QXRlfgU/H89Jmxlddi1sqjbj8ex8GmuLBUaHqYX0
	Qmr334a03U1sQ4u/24h/d5sS2gTcDE0ZJoafPvMLDs0CSys0Tta+xPZTeOB6jiS13JjY+R/INyG
	FABIyC1ywu5dHvoJ493L7MqOBaQ6Ud+Tyhe0F6tjB1k28tJR0/hUy2jawFuWHFcW+Us1yP7Nycv
	Fl6Hbpr4sTSAU3x2NyFWsTiBp4yy3GmWsIO8qnVqfsiC5XAbgO8DzyKoi0MuY4JczjHpab4++TO
	+Ntoa1BEivc2x
X-Received: by 2002:a05:600c:1d04:b0:495:4e12:6ae5 with SMTP id 5b1f17b1804b1-496c6571d21mr26130575e9.26.1785244562007;
        Tue, 28 Jul 2026 06:16:02 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496c44af19bsm74777785e9.3.2026.07.28.06.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 06:16:01 -0700 (PDT)
Date: Tue, 28 Jul 2026 15:15:59 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, devicetree@vger.kernel.org,
 conor+dt@kernel.org, robh@kernel.org, linux-iio@vger.kernel.org,
 jic23@kernel.org, andy@kernel.org, nuno.sa@analog.com,
 dlechner@baylibre.com
Subject: Re: [PATCH v2 2/2] iio: dac: mcp47a1: add support for new device
Message-ID: <20260728151559.000067ef@gmail.com>
In-Reply-To: <20260727184226.DFC1E1F000E9@smtp.kernel.org>
References: <20260727-mcp47a1-add-support-v2-0-d4591a2ce69e@gmail.com>
	<20260727-mcp47a1-add-support-v2-2-d4591a2ce69e@gmail.com>
	<20260727184226.DFC1E1F000E9@smtp.kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Jul 2026 18:42:26 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Potential off-by-one in DAC scale calculation denominator.
> --

Responding to Sashiko's comment.

> --- Patch [2]: [PATCH v2 2/2] iio: dac: mcp47a1: add support for new device ---
> commit 38bec2fbb020c3f749c52a26e5cc3e78e72eeaf5
> Author: Joshua Crofts <joshua.crofts1@gmail.com>
> 
> iio: dac: mcp47a1: add support for new device
> 
> The Microchip MCP47A1 is a 6-bit volatile Digital-to-Analog converter
> which communicates via I2C.
> 
> > diff --git a/drivers/iio/dac/mcp47a1.c b/drivers/iio/dac/mcp47a1.c
> > new file mode 100644
> > index 0000000000000..140e93ff2ba01
> > --- /dev/null
> > +++ b/drivers/iio/dac/mcp47a1.c  
> [ ... ]
> > +static int mcp47a1_read(struct iio_dev *indio_dev,
> > +			struct iio_chan_spec const *chan,
> > +			int *val, int *val2, long mask)
> > +{
> > +	struct mcp47a1_data *data = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	switch (mask) {  
> [ ... ]
> > +	case IIO_CHAN_INFO_SCALE:
> > +		*val = data->vref_mV;
> > +		*val2 = MCP47A1_MAX_STEP;  
> 
> [Severity: Medium]
> Does this code use the correct denominator for the scale calculation?
> 
> Since this is a 6-bit DAC, shouldn't the scale denominator be 64 (2^6)
> instead of the maximum step value of 63? Using MCP47A1_MAX_STEP (63) here
> introduces an off-by-one error that could cause userspace to calculate
> output voltages with a ~1.5% LSB scaling error when reading the sysfs
> attribute.

Yes, the max amount of steps is 64, which should be passed here. I'll
add a separate macro for this in v3.

-- 
Kind regards,
Joshua Crofts
