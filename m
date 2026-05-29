Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C8F3BD642
	for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 09:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780048685; cv=none; b=f9M36LiCfEQrxmcGAaz9VF8yQqJB83ALjMLbZwmK//odeSy6fqzm/Q0eqEdlPz76BEh+KhD62WG3qooq1nJCYqGmimMcucYqF3GSnERBfnEvdmAlqUSWqBZRLzpYsvDMYoYHUCgmGMGR9ks4skpKHwP60AhckF5M+1Pf34FGnps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780048685; c=relaxed/simple;
	bh=EsX8BJXonXmxKe8VeJHaPTpWzq4BxTNfxX+5jJKa5G8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TQoXIyqHnMDgARzHa+1JYtunDqsTt1nevYQyGgodazo8n+XgV1slAt0LypTdy6mYIroDTN9ATmEgsrhEOMGnyYrhFvrW6hzAIzhGh98MrBjL6td8hvE5b6KpsoXlbTdGkq3lhDpe7t1+7O/OQUGSbJJloD/wTi/I3ey+BYmwNwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GSwGWEK7; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GSwGWEK7"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5aa5a77c07aso46348e87.2
        for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 02:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780048682; x=1780653482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EsX8BJXonXmxKe8VeJHaPTpWzq4BxTNfxX+5jJKa5G8=;
        b=GSwGWEK7Pxcyza63CU7yu3vXJKHF0aN7OPcXu85WuP3WQaGzUXhG9J4KsEtPpAIRNq
         K48TLYCYoK3BPtbeH2zG60PSKp6ygm8RXCggw0aRx47YS2UOTALhrJqoO0vJJ7OHyrOR
         T/oOIBmh86r66MaZ/WbZTD43J26bGjzd1TC5y+f8r4r6CkoQnjIQdeOpKoydqnny5jkl
         yubMZ4NYx7DuZDPo4kwVtzCDZ4PCwEDMbRMxxlTCzXrED0tsam+kh9Mx/xUmKISiCknP
         qSDilqRTFMroz58ZRozmQh99Tdz9MZi9UjCbyKD09ARK+Bl3o0qqvBv+vkZ6BNVGgSpT
         6pLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780048682; x=1780653482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EsX8BJXonXmxKe8VeJHaPTpWzq4BxTNfxX+5jJKa5G8=;
        b=li437+ct+CbCmuGofXitSpDkSes3PpxsFcr8t9W587ARXWBOzXNSAziawkXZyw68Hj
         Rj/dh63KUqPuwbB0GinlpEwXLQw57xPyFpJe5cmZITHcbtYIo7UbmzlrdTcyvoajm1aG
         uvMzESCSRTLC2xlq+OsBfSBKt7wL8V/DZhNjsvpNIRvP/RBB1AdwbMLVr37VWfkvdDd8
         qAlD3GWszM8zxS57/HPQv9ylQ4Q/nO94clNl3zljR6Vze0pOPzCNEYNBt+jLc9uRmhSc
         ZoVTXQXF9pibQGWdDnFXbYAt4OYhFJLRqhNy9YJy4pSgGe61rC/JXU89t9216QXSV8yq
         e0Uw==
X-Forwarded-Encrypted: i=1; AFNElJ87vLJIhiKeQ9BFK3f0IbmqTVazygVbHxHstJTgn40DTbu0iVn9fV4O9bDtpNJNDTLqfp/1C5wwPa4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8rRl4Tm4z83Efrl7qqSz3H2dHytwDimOyD4hIYwwXAbxWv55x
	uHo0vn04/9vibMutnVc2Ji8MfrMrft0AKnYmTmHZd+mKQPXg1rkZ9q98
X-Gm-Gg: Acq92OF9hvZKc0XzedjlI7YyRRyGXElBz+vIkfKN1twU7hFbucYW/yCtsq+rw1kheg5
	yXuJMynJNuZZiQQ7BLMVu44DlY1iVAl0COpRqbVnsfPy95iqkAMTqUmh5QjfQnaLQypCVFbFmRC
	aYTQ1gbkLIbyXtEoGUQJadjn9GcS8b0288eZsyln+hqCMAu7P1Dmh5mMOt0+gVVmrCw15pqiDLb
	cCxkfrF+rebI3QwNxDf/IDo7yAJFywn3eMoi9Hm6N23nzT4VhHcrod0hpwPMuxyTZHwJ1moyvMV
	eb+YyzYRsOgoH9yI/UKJAC0PFfCmBWrXcvwZQA1h7nIycJDf8vRNGj3TRg8IshBTxnhNwXTZy50
	J8y6otMtHDkIRSZyHTWKhan3UrhaWVqDY5+QzRo3dcjzkHUbtQJCdsHx3LLFuIGj6xmcA4t/J0g
	qraUmOZT7J9TwO9OUmoEdS24p8onVetm2LIWb1EjJTUKNTPH97vZuyc00=
X-Received: by 2002:a05:6512:3996:b0:5a8:7218:47b9 with SMTP id 2adb3069b0e04-5aa594c30edmr331032e87.8.1780048681807;
        Fri, 29 May 2026 02:58:01 -0700 (PDT)
Received: from localhost.localdomain ([94.158.61.193])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa5b79f6absm167299e87.84.2026.05.29.02.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 02:58:01 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: andy.shevchenko@gmail.com,
	wbg@kernel.org
Cc: m32285159@gmail.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] counter: ti-eqep: balance pm_runtime on devm_clk_get_enabled() failure
Date: Fri, 29 May 2026 14:57:55 +0500
Message-Id: <20260529095755.2533-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <CAHp75VcKEDjzUs4wrErGHAXOPEJ6GRge0A_LHra-Gf7k4e-X5Q@mail.gmail.com>
References: <20260525152137.7428-1-sozdayvek@gmail.com> <CAHp75VcKEDjzUs4wrErGHAXOPEJ6GRge0A_LHra-Gf7k4e-X5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, May 27, 2026 at 10:29 AM Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > I'll revert for now. Would the proper fix be to replace all
> > pm_runtime_*() with their respective devm_pm_*() calls?
>
> Not all, but the ones that are opposite to
> pm_runtime_put*()/pm_runtime_disable(). It should be done carefully as
> well as PM runtime may be required before final registering of the
> device to access the registers (I haven't checked the driver, so I
> don't know if simple use devm_pm_*() will be enough).

The eqep driver has no runtime suspend/resume callbacks - it only
resumes in probe so that devm_clk_get_enabled() and counter_add() can
reach the registers. So devm_pm_runtime_enable() plus
pm_runtime_resume_and_get() before the clock get, with a devm action
for the put, keeps the device resumed across registration and unwinds
in reverse order on the error paths and on unbind. I'll send a v3 along
those lines.

Stepan
