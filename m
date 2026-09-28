Received: from mail-oo2-f39.google.com (mail-oo2-f39.google.com [74.125.231.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087414E66A5
	for <linux-iio@vger.kernel.org>; Mon, 28 Sep 2026 15:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790609344; cv=none; b=Vzc8RrwLoWnhpSF2AUfCx0UluBQpsi9FyBhj2OK9kE9WVxl2KIHb08rbaI4hOL96YKSU3X/GlmEHXY7AlbtQsIT8epdBnj4tq8aWQozT4W4fk0RzTjn6Ilx5dmCIbVc2FvrLkiJI3CyvTQjxBHqa36BhZXL05Mzmobr5eaw28lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790609344; c=relaxed/simple;
	bh=PGI5LSsUHdXzEsPU3eTZRxILUn153NxKw3UV6sGM8ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n4nDoK/N0YVKJZc6jwRQyKoVOmBl6C3n5+If8JCa2OXSinJDn4wODFAny4JKW5QlP50JdSvDsaV6hYfbBjl9nym6l7qnpVQ3IZarGildx0QWEZFwzccTUylv0KQxbXfhLg6IfAIX9VAGwS7Z9ku/opI7EFHoT8VIFU+KRwbetQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzBjCjyo; arc=none smtp.client-ip=74.125.231.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzBjCjyo"
Received: by mail-oo2-f39.google.com with SMTP id 46e09a7af769-81c3544e2b7so811962a34.1
        for <linux-iio@vger.kernel.org>; Mon, 28 Sep 2026 08:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790609342; x=1791214142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PGI5LSsUHdXzEsPU3eTZRxILUn153NxKw3UV6sGM8ds=;
        b=kzBjCjyoCw/47E1YHMrj6tz4H4gfSqfH65EZmX7tP8U0J1sPskHtLzLfdhov1nwNnl
         piT5jbYCuVdz2+BYKvLyCeF5ybCko8QZhOavuUNHTsZnT819v1MgfuNTtkMz9gInaJ62
         qN+SjxA+TwuXP4Cia/e8nHwZBZck5jK/YE0bWJ0XmBX9EPdH3bMOjLq0d5zQsuBg35Hr
         FhbQ9S4AfOwAx21gmjwmFf9Ca/6+p2gUw1BYSMvx1WMNEIDay6AU8WfuDBOTE9FllHT9
         DOAKK0eRRb1RI+cwwtD+ewxDhwY0Fkg9IDVijkXKzklhcRgYti69VGuzLQQJVGWsmnsQ
         LtxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790609342; x=1791214142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PGI5LSsUHdXzEsPU3eTZRxILUn153NxKw3UV6sGM8ds=;
        b=qI0XXJZSJvwu+0vuXlNQCzPb+K5BJYe50ISgXKd3c2KU+v7I0OLQ73E1kGog8b5k+c
         JIy3I5nCqUwuAbyISAQs71iJ+x2yGJQTBz5sR56YYYbBqVdCVrREvbP77lhAgtO7YFWp
         T9I7vSTWubjzqimVRtT8RjUZ/WLGbReeQXjL58wrtQ4vXAKfLtPOqu7Ri17m3R6O9IRq
         XvmPoxrsf2MAXSYHvpG9ymMVd9bL10s5vA/mzP6XdQ7hh5pfm3w+k1GsU5Zoi++87Knw
         Hy/+vmu19AAWa2lxauH60NkDpiS7bgR2kil+hIDWI6rUm2rExx2g6/qG6YM0RrvmLMv0
         BByw==
X-Forwarded-Encrypted: i=1; AKwUvBwCS9KdRkqgdEBFcx/77kcbaV+6rNfibkbMlNwPsqqTUt35KtIOhNT2NeqC0F++IopKSVwXOXxhlOs=@vger.kernel.org
X-Gm-Message-State: AFuF++kXhfRQuS3fB71O0n/o2EuqIGIORQDD+jK1XCcKBWZ5L3VW1Cs4
	0QqPmFKXpHQmrk2KGPBPuMPxHrABpYLcIgiEwTdiUvrNuxg52rjMdH0f
X-Gm-Gg: AYBFou2PFmKHLBrAVNaXH1S6xc9QrI9JuN8e+w9gLNQ7y0qfJLx6NQjWpJePmnhr4MV
	NBFNKAC+SV+9r0KTef7WKvpSeKCsXHap1y2dV+hoObWdJVguRmF+79IJlwmwFktTlduEuLA4thc
	cJtgIwTpoIgpSDOo5WtjPOlACyItBpnJXW/Atn1rIaKDm2vqDN10Oav9G0Lf7PsY1STu1ybHVV7
	y81YVpXEteBDvCOmSVvO04TthagK41j4z2kXG9L13eJqh5/sHa04AgHgXaHCw7Lg8GRrmW3a7fp
	0wbQI7SI2w+2PpTwPw6fjCl0Ynw42uV9sEHWp2kclDw3pWlPyATjFLWsGkfBHoAJmL1pseEt31H
	whnPhFpMAS8q7fxqrBCI5P8QFWopLnNCongENDO5iHzYY0P/6uY11xH8v39whfrtn6CGzdW0KGL
	GtDxd+UV4Y4M+uf7zmJtEiVNizC6TyOd/te8Cu/KKMmhDf3I/TZlTPH+ZfNWTCwhzxhbPzyKVsj
	XazU/j84n0fZ1qYSFl25A==
X-Received: by 2002:a05:6830:83b0:b0:7fc:ae19:17ec with SMTP id 46e09a7af769-81783e88241mr15803831a34.29.1790609341691;
        Mon, 28 Sep 2026 08:29:01 -0700 (PDT)
Received: from cachyos-SlimIce.lan ([2607:fb90:9a26:9349::e71])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-81d584f53e7sm1874160a34.14.2026.09.28.08.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 08:29:00 -0700 (PDT)
From: Jared Wuerzburger <jwuerz@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Samuel Dionne-Riel <samuel@dionne-riel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iio: imu: st_lsm6dsx: Drop trailing comma in ACPI match table entries
Date: Mon, 28 Sep 2026 10:28:41 -0500
Message-ID: <20260928152841.68967-1-jwuerz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <aroutl04Q99mqJor@ashevche-desk.local>
References: <20260927220559.24169-1-jwuerz@gmail.com> <20260927220559.24169-2-jwuerz@gmail.com> <aroutl04Q99mqJor@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Sep 28, 2026 at 12:09:10PM +0300, Andy Shevchenko wrote:
> On Sun, Sep 27, 2026 at 05:05:58PM -0500, Jared Wuerzburger wrote:

...

> > Assisted-by: Claude:claude-opus-5-5
>
> Assisted-by: LLM

Thanks, that was the format from an older version of
coding-assistants.rst. I'll use Assisted-by: LLM in v4, in 2/2 as well.

...

> Thanks, but while at it, also switch to C99 initialisers to avoid an additional
> churn (there is ongoing activity to switch all ID tables to use C99 initialisers).

Will do. v4 converts the table to { .id = ..., .driver_data = ... },
which also matches the i2c_device_id table in the same file.

Thanks for the quick review!

Jared
