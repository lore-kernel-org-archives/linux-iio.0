Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3AE38BF76
	for <linux-iio@vger.kernel.org>; Thu, 26 Feb 2026 08:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772094339; cv=none; b=WtzJgY1z+hIRsh/oq5rxWdjRd8IN/ItHs8NDHu8qiLMaByLqIqwjO4BlbSqaK4x4ZegU5uiOwE4Y01iGlUuqEech0Zlkh28Y2tV58PVybvrQqRk2obl8eJZlxx75UvREnMcNLnJ3is3FabQXVf8YR+ScX1WFf/0cwg1JYSiYnPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772094339; c=relaxed/simple;
	bh=XIwS/j6OrQcSxL2M4z+3WsXzvqEIK9l8BmiQ7ezW8Cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TyKjWTpt8xqjIeXj9O0VxQKtY9YKRFPnhfY8o1+B0pi/yOUsqJY3Xn93RRqyuM6uVJ5iTOeZIDVwM6TaTPR8QRPvcY3SPDY6RqapZTv+TeutTj2Op4tm/8FqVmsk5OY36NWaDkhjhrO6OFv3EYrpN6sFizBzvXspRfBbKE+VMzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fnwduvEP; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnwduvEP"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43638a33157so494389f8f.1
        for <linux-iio@vger.kernel.org>; Thu, 26 Feb 2026 00:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772094337; x=1772699137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XIwS/j6OrQcSxL2M4z+3WsXzvqEIK9l8BmiQ7ezW8Cc=;
        b=fnwduvEP2Xm0RD6HDuPmGyUS6qxBT/40ju2d72GzrJCv2aSTZW4Y4WHQOWShSn6IOE
         NZA0PKdCEIqhVhUUO4Mze61RuO9yrkdp6RbkEzO1JieO8DJh4w2KFjbvLr9SeD+ZSEwD
         lrS30Hkw+rVM5NW2WEuX3MR/UsKdgu/Gf11wA0ujRxBxDGOk5pkMzHt9998C4E1Dtvr9
         7tN95MLs7YHIDKckpsmjAk+CnjJCYklNNQG6VuFXW/erKUJyH+PRjvnE0CixREc2taLn
         YVN3AbwTTWP479wDXZgmg+T6mFAfyeU/uxcctTF74KM1mqjK0khIu+GjH/7a8KyLxGJ6
         hCOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772094337; x=1772699137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XIwS/j6OrQcSxL2M4z+3WsXzvqEIK9l8BmiQ7ezW8Cc=;
        b=Meax4LIq1HfO6LTF+ooK4ymHd4leI/go4U3MPwuzz05EmhFgnVKvGfZNiFPZZNzFu/
         8DVo9bNkPDxrWEuhx47uMnYoZv7vTd1keT1wZvnQ/A4Cm2UQ+Mv0SDXglDPjyf/HD1bt
         vKirzx9rAkn4jUIlLq/xMYP+VLteIt3YZeht4cfyo02QAWKz7JF2CFYURuROEPiyYsiG
         ofnW+ATkj2i5IN5w32oe+5+Gxq6PB7LlrzhhttkD2fwLDxT6hbAYbkXNtz405ToE+U5Z
         V7VrSn0XGPVctFhu11TsyUusbwstqBaJTN5k0Q5sAE9IgMx4/ny2bpkjYBNadMLgBhCM
         oZ9g==
X-Forwarded-Encrypted: i=1; AJvYcCWQlXdytuewmKoNCI/DLCjlnbAKXT9EvTpvyGJtDvsw8ICrL4wO58cJ8Ei3jQ21ZQHIDxzYtUrkt8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSHqDuelAKu0jR86cf1fCk5Dim8GPWsMEL0Odso5c1OW/tcb6g
	m8pJFs/gTTyCyBkORl+oQdsBuSrSosGkUfQ0hwGtT00Y1ANi3RvBVdhi
X-Gm-Gg: ATEYQzwwAVuaz19gyR6Vc3e9dwJBwYB9xX0/AgWdkxnR6aXqpTQ74Cswq+w2wXk3dJF
	air5QFyz4Cg268fswIdkFRyL33gIMAJguxf5CNI7IfLVucJbWpocekf6gtg6WxRmCzxQMViqQh2
	DInJMdj4Ll6Zx870nh4t/2taTJsqSREsdMHw7gM1FjUMmMB8hhNc4DDUbh7Oreb/ynC3TR8UHGE
	gjONx6d4iu9VfOfx6Vx8BBYxe7yNWDU8aSlX9nvqtPa5okOawV498Bora31yJ0XstVPQeTZffrW
	AY6nFDSQvgQ3VJrAT6fCDEvlLyL7rs1gtNK3ELcgsDDrmgSOBdtO4ol0OWmQ6lIYCeVJBfovf8f
	xbOx7p7vqXD1x61BGZOYBXGO2rUQTTRXJv3k9cHqeFwL5cdUmSnScjefrjaUgF8z/SKYsz8zQwq
	eX27D/z59m
X-Received: by 2002:a05:6000:4007:b0:430:f301:3e6c with SMTP id ffacd0b85a97d-43997f30fb2mr2644203f8f.34.1772094336607;
        Thu, 26 Feb 2026 00:25:36 -0800 (PST)
Received: from kimsufi.. ([2001:41d0:303:6f54::1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d4c60bsm38896093f8f.27.2026.02.26.00.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 00:25:36 -0800 (PST)
From: Ruslan Valiyev <linuxoid@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ruslan Valiyev <linuxoid@gmail.com>
Subject: Re: [PATCH] staging: iio: adc: ad7816: add timeout to busy-wait loop
Date: Thu, 26 Feb 2026 08:25:35 +0000
Message-ID: <20260226082535.69503-1-linuxoid@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aZ_9x4q5BZRJi3ue@smile.fi.intel.com>
References: <20260226052615.65734-1-linuxoid@gmail.com> <aZ_9x4q5BZRJi3ue@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, Feb 26, 2026 at 05:26:15AM +0000, Andy Shevchenko wrote:
> Have you able to test this?

No, I don't have AD7816 hardware, compile-tested only.

> Have you investigated the code? It was an atomic, now it's sleeping.
> This is a huge behavioural change. See my first Q.

You're right, the sleeping change was unnecessary. ad7816_spi_read()
is only called from ad7816_show_value(), a sysfs show callback, so
it runs in process context. But for a wait of at most 27 us per the
datasheet, there's no benefit to sleeping. The atomic variant adds
the timeout protection while preserving the original busy-wait
semantics.

I've respun as v2 using read_poll_timeout_atomic(). Also fixed the
commit message: v1 incorrectly said the original loop treated
negative gpiod_get_value() errors as "not-busy", it's the opposite,
negative is non-zero so the loop treats it as busy and spins forever.

Ruslan
