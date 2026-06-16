Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC90F43D4E8
	for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 17:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781629706; cv=none; b=BQgNA8R+4kGxNLmLMQk/zXrzSQvRz2JL08M0CJd84Daw0jIpSj16kq62HSQaraLYQ9tHgBmLFhHUT7Iv2V5e9rdVWCC8nPziFtIn28m20uVnW9JJlbLNN4tfnZsOzjSY6aYnwa3qr9mby0VqJoNTyWnlZnuBpHBfe/pHJorghJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781629706; c=relaxed/simple;
	bh=hIVAgng/TYV8XeMpkj8veRVy9egiQ+an5HytAJJXVSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QU2cat/6Di7uA/GIYjR7FrgneH4S3ehEg2k0hWsoQ92SW6ukX4tjBLCG6jfuaRvCls1sRpmVnPGcOQLlUQvmBG7PpGB+WqwPCYD7RN+wFn9XfYk9cXm8rKKPx2v30iMninMOGPoGd1V8eRvk5LU2WZAmVmIVf7Tp8xMv70k6M8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DSEfRt8P; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSEfRt8P"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so33884455e9.1
        for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 10:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781629704; x=1782234504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hIVAgng/TYV8XeMpkj8veRVy9egiQ+an5HytAJJXVSA=;
        b=DSEfRt8PysBVMR3ZwcJqWh3wRoZFJthmpgsQECjWlS43DbWKZb87Y35W8/s1UqBURj
         GW7ML6Kv8IIyYudvhiU02ojnwVPw/9crxBj8MpzRqsWt9TZ7wdqjLU6w7lD+YOo43TzG
         FfQs2FXzSYc/8OhlHeF3pjRxBrcVv37RNfMuyinqMVNTuztQgOeZ30GiLSps3lUmeU2G
         qeJNu3m1s8KVkoXNPIl2MPa7FoZoGlGPndALc4Z6TQKyawPdFGcH1LwiXULAgJjs+QhB
         P/z62Pz+MZB0bSdC943DNFrIqaR2S/ssBFZhFw394EgZz0BfFkt47Oezd2ApUtgaY6o3
         lZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781629704; x=1782234504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hIVAgng/TYV8XeMpkj8veRVy9egiQ+an5HytAJJXVSA=;
        b=WwBxysCG7dZeYSrP+PSTz/WPuSkIGVDIbyKakT9m+iqtW9/kSGh/njCPKXNNFWfWb8
         mBvsbHJm+BvF337zYuJFyIhyXJkRtZ6QggZmZPdeFVV70omqBq1+sWtsJ+tiXvl61xTz
         d5BzCUhblMQBsrLMWBXqI5GSX5jxYRiLKljauQsoiSU6d9Rl9Xg7gbxo/ccPifxHmb9G
         69tkxZ9xEx/0WlnvsGdRrW2E6zkOf45nD/x2e9VA0p4AXO9/WUfvhiDg15IRhy6HmKJP
         vps+QvJpMUyTz3YakcijckR91NTJKmbHH8xXtqVjdejTJnVDOH+ZAq2zNcO9rEuvQuMm
         TFDA==
X-Forwarded-Encrypted: i=1; AFNElJ/o2DuFQyp0UDxSzPB1IrMiYMX/R0CYZrnGG9umbRtz02UAYgSwyP+ZuujgxOXZOvrEZTUPw/M2CYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaW8IOTBTE2FnyAstqq6yQ3mrkKuSkYh15XHItcoXJCtxdGNrY
	wuif7+km6VWn3m+mfvHt0VX+bSjJf2RfUiy4nnUq1SjQppfqHmsLr5+l
X-Gm-Gg: Acq92OEJ1DZgYCcd9D0uIf5CALIAZ6sMBNcC2REaXFll/qtR1B03jkcpOWUID0ToXMZ
	VmfcSFySBwwJBbOL0sPhO6LLtPlqTGpamqJS0j+ZJNmBtaBKN6rytnc+scLU1hxkXDb2doB8R+9
	ZQKnfCEqOp0XnapRfK/4QLv3v1ACFggIoq3P5j6srVdgh4o29c/NwEmqpwyHGMzi5+kp9xZq77D
	s4jEsHnxSFq25CWRN4sdArKlgliPvH+2ZuG+rLx9djXS388R8WT5nmMynr9ghtE7ZY85R5fbGcL
	azgVTgurgWu52T9j960EhuV10U+CXQL5J5IRhT9hEJF4XO2vb7yX4mLABVNhdnLtBVM+4XL2NNV
	ivR/939QAyWZdu1FCTiehpJF9zq7//UO+LKUXk/N+KOlzi4yEZ5+SqObufmXnLFKgOV/rClRFl+
	dnJhw6BYOeXyPbJVSzy9tuOWw5SANRrjhsFRwqoe9G10TePxzMkJr6rMlwzsjLDJ7hybot53Yec
	yuQrw==
X-Received: by 2002:a05:600c:a148:b0:490:44eb:c1ec with SMTP id 5b1f17b1804b1-492333dafe8mr5220315e9.27.1781629703867;
        Tue, 16 Jun 2026 10:08:23 -0700 (PDT)
Received: from arch.lan ([91.230.98.156])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922fa97a07sm155456995e9.14.2026.06.16.10.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 10:08:22 -0700 (PDT)
From: Tomasz Duszynski <tduszyns@gmail.com>
To: andriy.shevchenko@intel.com
Cc: andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	m32285159@gmail.com,
	nuno.sa@analog.com,
	tduszyns@gmail.com
Subject: Re: [PATCH 0/2] iio: chemical: sps30, scd30
Date: Tue, 16 Jun 2026 19:08:13 +0200
Message-ID: <20260616170813.47806-1-tduszyns@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <ajENLm7tnjdtEhJS@ashevche-desk.local>
References: <ajENLm7tnjdtEhJS@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> On Mon, Jun 15, 2026 at 04:58:24PM -0500, David Lechner wrote:
> > On 6/15/26 3:04 PM, Tomasz Duszynski wrote:
> > > This series replaces old email addresses with a current on to
> > > make sure changes show up in my mailbox.
> >
> > Would be good to add a .mailmap entry too.
>
> You beat me out to it, I was coming to comment the same.

Thanks for catching this, completely missed it.
