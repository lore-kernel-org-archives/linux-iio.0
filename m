Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6806F3DE44B
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 08:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778661253; cv=none; b=fVibHGldQ1VxxiYmlg5OR7SwWzfzzAokP/gGZs950EHx54UrwhZ6ObTn0SVdGapoCFx/Dp44YmWT9Gsj/nMKrDhHGK32/JxTne0JWkcfHBtmuUG39QoTqTYnlewAfRwEkhacTa5Yk00aW71N/kL9xgC+igubzn3ebc3Sw8FRnIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778661253; c=relaxed/simple;
	bh=OrIAJGsFuBQiGgUsDd2CSgMI5mNp/5mAvXSnocVoF3c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zb6Ht5S1JyXN6/ECaW3qCW32uOVEKuYZCHvyjXIExPgawVlVfhOkFIyyPr7GVy2w4na6l3zl9kTf/7n10egRrH3+2SjMpTnOFsQLs0CSyiTiHkaqt9kfo4rQBQKfBe0jvQ6sB49hlkWjhNl2SVEjIe7bZk9Y073p8DEmO0uWgCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QDI5kLvG; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDI5kLvG"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-44a7c719151so626616f8f.0
        for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 01:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778661245; x=1779266045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q1TXpP8EWw3w0nxfBveD4rpPSB3AQWGhFzMn2wB3t7Q=;
        b=QDI5kLvGgELEILoVN3AKrxzKacKR9MPFBjvThIYmuMZnqysjBJEuiT8tCRSuR3JtVA
         w3qsae5bU/tD53uIONHDzjw9hIwd+A8R7/YyE8rZRkEuXnk0wAqBKJI5GowqKsqC8Dud
         w/v748OT9Lqlz62w2yYKP0a7sHQrHSeEIc1xLe+a7hiWByogtLOBbaHW9UI4bk2JNeAE
         C2BGaI9ut3JaiwZ1tyUWsrOYT4w3YgC+6KgciuwpjCR4HERrjLIvEMB4r+NGrue7ucRf
         wTPngmjBBkdzF5A7G7s8LYHbOQnUkVKd+szJEw5m9vu4qAnRkuWvgoBtjb5tNkesgc7g
         sCtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778661245; x=1779266045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q1TXpP8EWw3w0nxfBveD4rpPSB3AQWGhFzMn2wB3t7Q=;
        b=W49gMk+Ltuk52bCMCA9KqwfbV6jhUzZAJuhDE/q8UJHFCxItQkZBSPnUt8a2FNR2S6
         319PiLqBRihi+OTiIJisnZJWiNGWrsbbicjdkFNhR+k0tdKeRa71PE2DsH4Ui8gTbUVX
         /DZrwbjQwu2wPmnLV0Xv2uGV8jJB0djZ0mMlVAsDaqbbFJ4+9uya2UNdNLd45AbmnZ9z
         79Mz05YNNXCsPTdXw6gF35OIJOEAhKGpYuYyRqOvIlBHdUFEC8e/b8Zc3rVI3neWa3Is
         gPvpgmdEt1E6XlKUeZ9DKp11qU5f4hJ2dBWoSh/umhHWqB4hco0qPrLoGH9OZHUSNZdN
         4uBg==
X-Forwarded-Encrypted: i=1; AFNElJ+Rm2nCNxbHXKo1H0XCLr/qWeVn4XjlfTB1ddLHFYiYyI1QBbd5s2cVevvbq6RaTB4LkFTaFU4B8Z4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhZebpR3rSSWRR663PX8bWUH9k8BKouBmu+hi+XTfkr0kx2f1c
	vdhGpDiZ0HDsBh6d+AMb/Hs8mcP4xZRkTLgSYXgQsv5JOg//W8brhXbI
X-Gm-Gg: Acq92OHiOoRZpvxydLuwsl92kVRA+e99MVpqkUOtaNNS0cowZbkuYosKC70vohGeBc1
	k7mUwov31rF9gmYPWvNUmKhdBW1CysrMeU+c4/ugk11VzCmrHYr/ORY7Mln0pkPgwdM2bez0AW2
	msAX0579hX/Cl6oZ7mTW7VWE8JD2vgeP+I+o0pRVxUFGOFU4T7f5yvLuR6zCiLdEUKcpwaT+J7u
	FF88dc1p65IiXOiCXniWphbXbATI6zgr8Kku9wiTMEBw49FGWoMS+SW+g8C/QcfBzimg1n1/gRT
	N9TVPdGkUcdUlV3zTbw1287BJnXTiU0UBrjzlEgZ3+CurYAm/TjGoSXsa471tQBy8yHtu/Qaibt
	v6aiA5QjAK8takQJGqkLyn+SoAj63zDXX33Q/TLcGs6B6VMDkCm9sGdFc47wHr245unxv+c4//h
	gPaWydSfxcmmbmmwgskIzI058Jt0uLHZ+7ab1Vz/hy1rGV
X-Received: by 2002:a05:6000:2c12:b0:454:454a:4cbd with SMTP id ffacd0b85a97d-45c5b5f69f9mr1664293f8f.5.1778661244540;
        Wed, 13 May 2026 01:34:04 -0700 (PDT)
Received: from localhost.localdomain ([82.215.118.79])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4549120eb95sm37750863f8f.20.2026.05.13.01.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 01:34:04 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: jic23@kernel.org
Cc: andriy.shevchenko@intel.com,
	joshua.crofts1@gmail.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	gregkh@linuxfoundation.org,
	hcazarim@yahoo.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sozdayvek@gmail.com
Subject: Re: [PATCH] iio: trigger: iio-trig-interrupt: use devm_* helpers
Date: Wed, 13 May 2026 13:33:42 +0500
Message-Id: <20260513083342.764-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20260511060732.7728-1-sozdayvek@gmail.com>
References: <20260511060732.7728-1-sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, May 11, 2026 at 19:56, Jonathan Cameron wrote:
> Silly question for you - how does this driver actually bind on a
> modern platform? That is - how do we get one of these?

It does not, as far as I can see.

Grep across the mainline tree:

- The string "iio_interrupt_trigger" appears only in the driver itself
  (drivers/iio/trigger/iio-trig-interrupt.c:101 — the .driver.name).
- No .of_match_table and no .id_table on the driver.
- No platform_device_register*() call anywhere in arch/, drivers/ or
  board files that would create a device named "iio_interrupt_trigger".
- No Documentation/devicetree/bindings/ entry.

So the only way to instantiate it on a current kernel is an explicit
out-of-tree platform_device_register("iio_interrupt_trigger", ...), and
nothing in mainline does that.

Given that, please drop v1 and v2 of this patch. The cleanup-for-its-
own-sake is not worth the parent / sysfs-hierarchy change Andy flagged
when there are no in-tree users to validate it against.

If at some point a user appears in mainline (DT binding, ACPI hookup
or a board file), the devm_* conversion can come along with that work.

Sorry for the noise.

Stepan
