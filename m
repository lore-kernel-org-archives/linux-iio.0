Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A7A3A3E77
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 13:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778506963; cv=none; b=tVGoEkGomF0VU8EJQXYo9opP9XHESHmRVnDqh8yQGaH7HO93tmREGlXc1ct2dCVku6DPCuozAGzO8iYkv9PXWw5JtQTzUg6AS47Xoc7w1jX83wLRRx880Pykh3G+UtIUW5742XLu+ddNudRssg+AYZ/x0i7Tm0KL1mAcdHgVBLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778506963; c=relaxed/simple;
	bh=Qf5gxuR3HotUQ0B9E3azytIqonBCTUvT+HX/FZzLl7o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AIauvLHcElerYd3dcb5ZQDndlREkP9ai19TyWgH9AtBY+U4D5Z8hNlxK6F7kxsyL2KHDiWM0jRsxH3dyLR4xlxj2xd/hrQKsveB7y2Meb1z511LKphw9w51ysjvwI+caGzVjUbkij7q5hEaJcdBup4elbvzQ1ofdneVsOwVB8HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0D9q7zI; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0D9q7zI"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-445ae03198eso220313f8f.1
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 06:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778506960; x=1779111760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=olQeRAWqJDylx+h7xeAO3j4LCndvV+2rQSJkxcnVqVw=;
        b=h0D9q7zISkrmwUTNb3hqAv/gpekI/zqiYDb1tI45QmXSu4MWDTpjEAQrZa8ImCwDuU
         8Y7JTW58brxb81mPbRV9kgczyFUJTR0sdvIrWrnVhLUURPZNlABKWA/bgONaut5sqRrj
         bIFsczQKw+3fZC9xPXUE2XsGVmJAVIrkJmob2MhStwT7hVlUnkjr2UVYUaHvLdzlPAOS
         pyaS/3ZPMdgqsfToIdoMlHVTX1ey4Xk+oojoN6GtkQH4hFP62cDeHdC/2iziGAwp5KFK
         oOFnOH9WisR790nh7ALnbUNELQN9SVK/6WpBh18hX6xiqlW237zO5sFjjXp6CGn2xDEe
         Qphg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778506960; x=1779111760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=olQeRAWqJDylx+h7xeAO3j4LCndvV+2rQSJkxcnVqVw=;
        b=LT4NGgCzFTeTVtDAbipmf8DpQD8F3m3VJoF7BPBH66r0YyNW0zoM/7sDAt/1zDJmCH
         0fCP3PKOT1jpj5kYX0+dAeKRv6Nf8uix9Ib/vEGihMNLDsbSEr83hUyThn9IeeL84cHA
         QWqlx6TuFuJuYJK5PE5B8IM6L79DN0mMHsJ6RZcP79nio/MKwMcXuIV8IuG0g6AMo6Zw
         eNNuH5CKvEbBwCMw7MB5T8qRB9i19i8ZQjC90BGzg5NcXZrMTwZJC+nuzQ//w9nsgCNx
         ZpnBtWug3HPgZ4qlhFX3jTIfYgbP+jr+4+cSIlQYksjm2y6qVn5HzZLQN2sTrKeCURhw
         FWjg==
X-Forwarded-Encrypted: i=1; AFNElJ8lEHMcrYd1mYRKoxrB5JUKXJfSYr88RGpKAvMFqxtW9ZP0af8+wNMOOLSJN3Ln6UahFmp//wPx23I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyczrE/D+JBrHkY2suqzFx2VXQNjkKsbqkGfmd9EFivpFeEV2ne
	gnpOttTTSfqOSNo+kSQVyA+QRIomQw6WTaRsj+L+dpDA7B5PyutKTGeG
X-Gm-Gg: Acq92OE8D/3qgb4KP7SkGpQC7wlQKNxuEQbkS0gINtYY9/Iclq9UZmFAV6OJqqBqWZ4
	8Els212m1gOF+fySISXJAKwzw9LxEFEvXGhGMVgBaMnaM5Go3I5d/jPqPe+4PV8u/+QJejKbVfP
	tf10MQGjb4lic8sCu6G2+DBW5SkYQvUocU5HZthbUYco7hb6AJ6o9qeBOVaMfwKUc/FfayVGVV9
	5fZ/tMLCfb3/NOvZ9LQym5dRZrB6akoRytKtviKwNWBhaaAWA13SG5Mybq2+K6r5V8eL5R/FfH/
	m+Vyg3t8sh6MLq5HwD0U/g0Mi8kaYPeAt9YyObZ3fRmFyWO/JBnnp0G5qUyWKsRr/oucbx4C6sI
	4Qoeq+0WXKhqU5qwXxstWxI7VvVi6zqXwL2gNA9Pk3VXWk4t05QQnKpfNhYiBUyf9CT/unbvjL8
	3fQyvGh5HxXPGByqAEFyBZ7I6jhPa2kod+MAG6HgxTYN+E
X-Received: by 2002:a05:6000:478a:b0:44f:dcca:77c0 with SMTP id ffacd0b85a97d-4518b1d2308mr11012892f8f.6.1778506960209;
        Mon, 11 May 2026 06:42:40 -0700 (PDT)
Received: from localhost.localdomain ([82.215.118.79])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548e6a6a64sm27007591f8f.6.2026.05.11.06.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 06:42:39 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: joshua.crofts1@gmail.com
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	gregkh@linuxfoundation.org,
	hcazarim@yahoo.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sozdayvek@gmail.com
Subject: Re: [PATCH] iio: trigger: iio-trig-interrupt: use devm_* helpers
Date: Mon, 11 May 2026 11:27:15 +0500
Message-Id: <20260511062715.21-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <CALoEA-wQ_hYsP8iOhHf6yAzpgA-Bq+78bC=BqZdaPcz9bW1Gww@mail.gmail.com>
References: <CALoEA-wQ_hYsP8iOhHf6yAzpgA-Bq+78bC=BqZdaPcz9bW1Gww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, May 11, 2026 at 15:33 +0200, Joshua Crofts wrote:
> I would say that this is a functional change, you are changing
> how resources are managed and how teardown works. (But
> maybe I'm wrong).

Fair point -- the user-visible behavior on success or on module
unload is the same, but the lifetime/ownership model changes.
I will reword that in v2 ("convert to devm-managed lifecycle"
instead of "no functional change").

> consider introducing a local struct device variable, so you
> don't have to use &pdev->dev constantly. It makes the code
> easier to read and saves space!

OK, will add `struct device *dev = &pdev->dev;` in v2.

> If I'm not mistaken, devm_request_irq automatically throws
> an error on failure, so the dev_err() call is redundant,
> just keep the return.

I do not see this in the source. devm_request_irq() in
kernel/irq/devres.c wraps request_threaded_irq() with a
devres action; neither prints on failure. The caller still
needs the error message.

In v2 I can switch from dev_err() to dev_err_probe(), which
handles -EPROBE_DEFER cleanly:

    if (ret)
        return dev_err_probe(dev, ret,
                             "request IRQ-%d failed\n", irq);

If I missed where devm_request_irq() prints, please point me
to it.

Stepan
