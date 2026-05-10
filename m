Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDD2213E89
	for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 10:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778408535; cv=none; b=UB4Na1O7OVIOIbiazMyqE7Zu/+JMLiZYRnp0wh1h2WvAp1Kb/Ubrcs0iIgfku/RHVfiJHu10xZmRjfIuHUXrqjWLhHWLc9JZA28iuoOlJOQfPCiXqTKIdX/D0FtYNvE0Sd/NutDR3BPFEB1Y0p8tFta7CcrltvVe+QoH0fzqeVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778408535; c=relaxed/simple;
	bh=d9f3zSwQstqExosncJd/VgkIXV87HDoVn8XANhCSI10=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RuGajxvQmoNRz52cwWf14ymjT16jsuDt8YIwsKXbu8bsrK2ToyRgf/dFspu+g+jeq+hH3u6ckgQM3am5FlMH/Vsm9X7m9N59eIy/eVLFqtN9UwfvpAvm9zBYTbDRtwcdWVK8a67tHrKy6+HY3sJeh1ehFLuz46tRxeIhltUHIyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PU/XC5ox; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PU/XC5ox"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48e72b02bf6so1225095e9.3
        for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 03:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778408532; x=1779013332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9f3zSwQstqExosncJd/VgkIXV87HDoVn8XANhCSI10=;
        b=PU/XC5oxPMVVcJqJ/L6vFcAQMh3nGk36L6jAyEfzoC3Jl2zxPyYugz6o3PJr+JCnaO
         a+mJnWnk1sJK+eEtO9m5E4mjToD7JEU9vhmhH2zmzSifS24cOkeW2kidQXqF1dxTeA8E
         pycRY6Q0f8OuzVFe1eQ9gwN4LMxvSPunVFY3Bm/GB/9k/ia18M/9dEidLGGrxjQ7LRYp
         0wvkCoryPwgz324wIz4o5lmOx5NVdwYuk88WfN6hQAFz30ihKgxTKEJaxFYkHnO6x6aq
         GKV0ryPHjh4upU7DHh4sMwKQTzDvCLIFyayO5vOFhSlUoJVGqBlJwxgkynMpu2sZ2DWc
         RNBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778408532; x=1779013332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d9f3zSwQstqExosncJd/VgkIXV87HDoVn8XANhCSI10=;
        b=oybZtflHk7gi9R7q1YjBeCRk9CaiIltEQaMWyORvqlzmTvTdNjvW9dmZ36Im2zaudD
         vSd0m44DQ4JIa9/tXhMAKuKct+2v+YJ+dw17GNAmMSkA1AxP1r5mB/u6CpfLuMtY28D8
         c7+Ms9aBoDMWCRwH79/yekXJtzcsH792zGYuSfX1CtvK+7Csuh23kWobve4Bi01UhZYl
         lw3nW0sOphWrzt7opJoKyg/GvtHYUfBixwwyvmvxBUhlcwmjg4Prmnl69SbPPcmLOTUY
         r+BpNfdEKtcatXrNHvYARF54Rr+rb+mI/AIXynmCnsNxN6929vVXMpAzQkV/Lu2x4OKn
         cdzA==
X-Forwarded-Encrypted: i=1; AFNElJ9Zp3Rb/xtXsnm77uqR17YRnc9JQtFnWgJiyts62fGOOaHsP6od8vfP3mBcjzNbsTG5LkKa/a75HPg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3flZywFp3PHpKNjoEBuZOIC+uLzq8DjvnwOO32iOSQrVDTZ3I
	wyiQoUjsm80V08nWQLbagcWhWBxwJl1dMqGIuWXKtYiQwjYYQh9hgxlW
X-Gm-Gg: Acq92OGdx6TxzlgVu1SEz1IfK+UbAgDfaD3kS9u5951DLMIZhEEUcH6hY9irbXtqq5Z
	1FK3AwkHUihF6TZGdzftOoemR5yLF5s71hbyBxqJPNCZZGB4ckkRefRQpMuxILhZbzPHeXECjQ0
	uUfJ/wh86AdA31dDb5kbIo47Uhf+6PWwK15mGqkMZ5DVU+AL5IxsoFEY3LUm23V7vrcdYEW74NQ
	S+GQjLMMq2lO3EYYpFvdFxe95C9g/OYqaygNRHJlnXPhOKBLWdiIZhVMdmWJIsd2D4T07R3zG4y
	jajzD0eQ04EXauS9UWs+7PqMECOHWDXp9Jn564s3MB1hqIeyPYH5RKA30maQgv4/K1RXRD1I2Io
	Op2S76nfvMcwnlCVxG0+HnAcTErwUH/2eCYocxv7CYta2jBi8mzOsjslsyvTdfk/JOXJ+NhoB7+
	AWfNeOIIEPUt1WwF+RF425zToSVXK3nuW5+adKf+eZVnK8Z5wrpZWmOHc=
X-Received: by 2002:a05:600c:8b21:b0:48d:1021:e5d1 with SMTP id 5b1f17b1804b1-48e530bf93emr136116515e9.3.1778408532331;
        Sun, 10 May 2026 03:22:12 -0700 (PDT)
Received: from localhost.localdomain ([82.215.118.79])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e7041067dsm101030545e9.13.2026.05.10.03.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 03:22:11 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: andy@kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	gregkh@linuxfoundation.org,
	hcazarim@yahoo.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sozdayvek@gmail.com
Subject: Re: [PATCH] iio: gyro: bmg160: bail out when bandwidth/filter is not in table
Date: Sun, 10 May 2026 08:06:47 +0500
Message-Id: <20260510030647.2225-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20260510023500.61036-1-sozdayvek@gmail.com>
References: <20260510023500.61036-1-sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I checked patchwork for bmg160 -- no prior post for this fix. If you
remember the thread, point me to it.

Same pattern (loop with 'i' used after no-break) appears in other iio
drivers too. Maybe that is what you saw.

Stepan
