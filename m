Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3236309F1D
	for <linux-iio@vger.kernel.org>; Sat, 30 May 2026 20:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780173759; cv=none; b=jvC9uJgyVVnHTfhUz0aYZSYI0lKAa5uqsvAsJvu+uk4goaVWU3dTV6YOsgn14V0K1RRnfw3LAbVdtHhs9MaYl3lqaUILo/xVStiDkNtCV93N6AN1XPCfiJs7BVbaIWRecpUHGYmW/SAZWQDLDZ/GLGxa8HJJduQw37jLm4OKTdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780173759; c=relaxed/simple;
	bh=KDqS8NPvm8aGs667rglnWKtU/gMbWc/vPY3gTgnjW5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j1joCHIDdrxneCyHoVwCnNMB+XbM93nZGKj0Fa/5MHwFi/iLDXW7Q7vHyPz8ca1rq9o+LIVxQ6Z1vasZH+YZOOxZwFzNxsfL5hqZH/torcBIWxRqyg/rk7RSt9I/tmwD9rPYZdl2LReJXUTlBA63V6NK2u2VX41MgrglKJoyENc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zynyk60F; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zynyk60F"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-45ef1198766so1002707f8f.0
        for <linux-iio@vger.kernel.org>; Sat, 30 May 2026 13:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780173756; x=1780778556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDqS8NPvm8aGs667rglnWKtU/gMbWc/vPY3gTgnjW5Q=;
        b=Zynyk60FQhYqdVI945DHww/l/Lu9rSnvmBPC/4g4/yK/4WPS4acIV5swUNlkLWdBZG
         3C2PeDioPNsARdhSxQNoZzBOpgY/gRhu9W2eVyVoaySY/yGogklsUAbKt7dt1yL7FZsS
         ZaD6NDmZHsNl/DavD0HLxxHJggCjodgfIivQe1/HpXjaHSkPFdnhucyI7Tf9+zEb+fa9
         UjZ98kjzTNoQTgWABXOAU+yczV8T7zIJyLbRo7e5s7rAAunG/SJQ/YtBg0jkTI6g9TZ1
         9wwmpLBXr17NRphYHuJmiC5BgtzUen3DoZPFZf5xsrqrx7dI96CQj63FHvkhKtYxCFx0
         QH+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780173756; x=1780778556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KDqS8NPvm8aGs667rglnWKtU/gMbWc/vPY3gTgnjW5Q=;
        b=ZS54QAVgtYx01kqmXhyFAF7qHV1o9hiYEhwSkg0PlCspF1rszO6yPm2g5uIqxxOOew
         pnh5gLZpmc2ejZDTQaysSzeVAv4E9Sw9vvuDy4PdS2IK9JAPstJAHyspADzX3bAgxgJE
         YHRMFrh1P8q/+bJDa5oVXtGqAmfYm7r3bDq3wbH+9sMrlOyiyCfY2obuInVk4ZaPrrpU
         nce08dDMbOnCz5TDTqmG6mc4T0dPW1OxP8mG3O0Q0WQ4GoZZBt9YR7hkcR/mnFfR1XvH
         gV9iuvRpaqshJVell3PWRAfiRhjEtvhSUEZEFE3PZG72pBWmrsSfwcDskZlTczlvHm69
         HJ0A==
X-Forwarded-Encrypted: i=1; AFNElJ97PymuOVacEkEJNVqFwd3Gd/hahLDrRjDYOv5oNtxZC7GICAthqC+w83dYozs5zN7meYwhdZNjG3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL3neDpwLCXbYgqMaX39+YwIThD0JLKwnPEr5Jw62n1tH/cltU
	efG8yiVUKV0BpHyjaAHtkSELpjIiTVsrabOSfethewMdFqnrOjbIJSDw
X-Gm-Gg: Acq92OHfFeNIskbQoiXYHs6zciujmi32ttFuCA71j4shY3pSaYsmKxm0ojwDK5u6G3E
	ZOcrhrwvYJbMd8aWWzV6FyttdEJcJ2gWPxH/0r3/3lQBU6Uso54E1SPZzOyLrkVArde1JpUfdyH
	5TcJgFIw4wUDWEGMR4jMfQrBjy/Fimjvs+jIGanY5bTIowneTwXpnaH13Dln+g4xQ7O/Y5vBJhJ
	s5/O75GxCTOfxjDPjGMYYJrlc7Q+s4linjLRbjPnExlp/v7dktuoY70l2KKSdS+uXpodFMdPO5n
	CniIJAcwvX14iXNM6CCMOGlYloJZj7SwehQGrcxg1CnhNq5Y7zV61WcgacYT0szy3ajLf3C0a5N
	MuGMC2mD9hrtsziffeffdFlS7XNcy8oM6G+c2kCZt5OqMedypfzCczCoOTae6vuwwOfzyq/zlA5
	ZG+Jx2+TE1D8y3PMr51w+K2tIx4g==
X-Received: by 2002:a05:6000:2609:b0:43e:a8d8:f3dc with SMTP id ffacd0b85a97d-45ef1347c36mr12253410f8f.13.1780173756298;
        Sat, 30 May 2026 13:42:36 -0700 (PDT)
Received: from sefo-laptop ([2a02:8071:50c5:5c0::361b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef356a4c4sm13944636f8f.31.2026.05.30.13.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 13:42:35 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Wadim Mueller <wafgo01@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	David Lechner <dlechner@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Maxwell Doose <m32285159@gmail.com>
Subject: Re: [PATCH v2 0/3] iio: flow: Sensirion SLF3S liquid flow sensor
Date: Sat, 30 May 2026 22:42:04 +0200
Message-ID: <cover-reply-1780172247642400420-wafgo01@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260528111414.5866b0e4@jic23-huawei>
References: <20260524205112.26638-1-wafgo01@gmail.com> <20260527184257.141635-1-wafgo01@gmail.com> <20260528111414.5866b0e4@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 28 May 2026 11:14:14 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> Please don't send a v2 in reply to the v1 thread. That's a good
> way to reduce the number of folk who read it plus end up with a complex
> email thread. New thread for each version.

sorry, will not do that anymore. v3 will be a fresh thread.

Thanks,
Wadim
