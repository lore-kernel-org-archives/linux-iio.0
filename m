Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE051A01BE
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 14:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778682414; cv=none; b=g6rgae2Cp5kVTsjCQjY8QjPDPjlNg/LFI55Jh0quElA/e2h3fZcALaEc0EEI+uYMdA5e2vbXpGbF2wNOdBIOuQA8u9ciTV5Za934kUd8pStQU6MyF6cFuDoibnAfdtsyPvYcjqGAMLQQqHVl6s2ak2MkVfRWoUtZDFG80D3zG58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778682414; c=relaxed/simple;
	bh=43usKQwgDJhhxBpU9LGaTevXnc0colQXUWRKIdd7avg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e/gi4esJHK1Zs8HbwwDp16ZzIy2ZLA2fHDu14PvP9edlGGnXQIKkw0MkxSsoXqMVTTVVjNA6XzLHoF1Erou1klnCHR7E6BuB14g1ydwFMpbMNa15j1x10CUbgqnleGyLh7qtOEJGfpofQd8USWg423wfgNQ2z9SzshMfkPx1UtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3jild4F; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3jild4F"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4891c569cb1so5993555e9.2
        for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 07:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778682411; x=1779287211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=43usKQwgDJhhxBpU9LGaTevXnc0colQXUWRKIdd7avg=;
        b=D3jild4FxeQPXuHb5bKt+qPGIMbt+7grMLaaf6ggWlb2p4eNZ+sbY6c6WRU2HvV+gA
         gi3tAIDoB4Q8D27SCaqS5nd3sO/nJOvjJzleMzeHnpVplzs5jP2nI16ihmyMORgFng1U
         zBZncD9L02fUz4zHzreOVEEx8CrAXhC+DjoJFBayMT5WmRvNR8v/GfZyL3APfH0MMQp3
         MULKks59x0JtU5kkFkuLKcAk8LNBgmwX95NYTc66ixUbbys/SOoWigvU4dd4XHQIKCrx
         PEvrqFqxWlay1jFIhiSEVtQ2+amNn2IiuVMm4fiC6rit/QQ98k6g55j/WkcIVf9aIEgV
         MtXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778682411; x=1779287211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=43usKQwgDJhhxBpU9LGaTevXnc0colQXUWRKIdd7avg=;
        b=f0OPBggE9FVqSVh7tGb/IbOAW8+22SCaYkczjPPsGSpsgAmB420IKrreHJN8f82ba+
         DUQc6pCgN/HSPOgJg6yc9HbirLfRFnSVVe1WP6DmjLwBKVKC7/8eiZMjr0FsL2AjQxxC
         k7RoCotvzzFgwG7g2rIA8GQDExz97cDvJ9bDPIb0iykh7MkRc38ahId32XkEBFPy0gMj
         KVjw+zF+gREKaFWWyXJIeLATginKuq5sXd+sHbLRth37Zq7J/zFx4wn7IBl9amJaax/p
         VVd1Mqgflcs9GUkQH+n47Y0XEIQGhR3Q4VBkY1K6bJomSnXzqV+3t5ZlIvIcvicXuRZn
         /0Lg==
X-Forwarded-Encrypted: i=1; AFNElJ9Df7mNFzzJtr/9FEClHy/M+BImK/pPbUAZugzSea/02j3U35YU3+UwUuhuBW1/Hmwo9v/dVsm68Xo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5uN2nQwWb1bno72mX41V316O9hky11B/aQIs3eURnMXXoOaWc
	WPyk1soMw4DwsSttC5x9fGxJZU8A9JFGfH3iZ1bsDJ0R4NVx8kPz5xQdoywIIB6HWNU=
X-Gm-Gg: Acq92OGVFzebT41TK7DcU4Ygw8eNj+rixJ3UlqxJ8LQMu6FV6RFlXVg7qVfmnxU3a/D
	/w44M7BP8qiqnCC+t5VDa5UZG7Xy33UbLGpSIZOb9klkdtzdWAl7RBjtpaQqwh8A5p0a3RXYWkC
	uazZ7F3ppAhA5T6TWHPGVLDSZYgLuTW/exnoFEpIUKaYN3j+36A5EowUQvaFwSghOaHDtmp2fAo
	6wWZ2nsd+o/XS1QFfu0nD851onPHKtAxnyuEg/oixjwXGTzPCMB7g7y92hnFdbulgXmpnl1esL9
	0nCMQCX5HaOEqRcYT/Pcay8zIrLNvVoswjGE9RdJ9T2iLbE5XjdGchN1PuziUfh4LEHKXCjz6UB
	TqhureUDID9kxQNE7xtwZit21McCJsAuJrUYVU3poedqD2sk7TBE83BtN/5XLxhZ6JskjcmF0Dx
	UJxY5RWr4dvMTp1KegeHymEq7QjPGBwrw1O4z202o77k4Q
X-Received: by 2002:a05:600c:1385:b0:485:c456:5e4f with SMTP id 5b1f17b1804b1-48fc99a0f46mr25896095e9.0.1778682411364;
        Wed, 13 May 2026 07:26:51 -0700 (PDT)
Received: from localhost.localdomain ([82.215.118.79])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fc8d624fbsm183169395e9.10.2026.05.13.07.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 07:26:50 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: jic23@kernel.org
Cc: arthur.becker@sentec.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	gregkh@linuxfoundation.org,
	hcazarim@yahoo.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sozdayvek@gmail.com
Subject: Re: [PATCH] iio: light: veml6040: add suspend/resume support
Date: Wed, 13 May 2026 19:26:32 +0500
Message-Id: <20260513142632.9445-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20260513094536.8038-1-sozdayvek@gmail.com>
References: <20260513094536.8038-1-sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, May 13, 2026 at 19:15, Jonathan Cameron wrote:
> Suspend / resume tend to be a little non trivial to add and datasheets
> are sometimes less than perfect in describing powerdown modes, so can
> I confirm: Do you have one of these that you are testing this with?

Honest disclosure: no, I do not have a VEML6040 board to test with.
The patch was prepared from datasheet inspection only (Vishay Doc#
84276 Rev. 1.7, Tables 2-1 and 2-2) plus the existing in-tree usage
of the same SD bit in veml6040_shutdown_action(). If lack of hardware
testing is a blocker for a PM addition, please drop the patch; I am
OK with that.

> dev_get_drvdata() rather than going in circles. It's get of
> 'implicit' knowledge that works for i2c sequences like this

Noted -- if this stays in scope I will switch to dev_get_drvdata(dev)
in the suspend/resume callbacks.

> Andy pointed out regmap_clear_bits() is handy here and set_bits above.

Yes -- Andy made the same suggestion on v1 and I have a local v2 that
uses regmap_set_bits()/regmap_clear_bits() (and applies the same
simplification to the existing veml6040_shutdown_action() for
consistency). I was going to send it after the 24h wait, but happy
to hold it until the hardware-testing question is settled.

Stepan
