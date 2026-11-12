Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794521155;
	b=wpkvjPPkxJWAHUygmGnuvuUICwdyHhwEc90jQFmhtGS4IUmyYfnEHYn9nxfhRfaUytMz
	 JsLrzYf8tHJG3tjqLds+etxLhRZWLCb2t+cNV2xOQ4U44r3COTPxC7pxXsKcFlqZrAYV5
	 gMcHKrpVxR09GYhH3wvySh/SCBNCZK602WijwTGQIs6YiA73jNdUBd9KMN2CUP24im529
	 PKpirm/lKHTHcbn9zGuMgynd7Xoi0MqZBb0u75nxZrveBE83JhcVgZQ6Eza5vi3GbB9fJ
	 AQQVAN76GcrvghHI/FPdx3oF9yVNg2+CfjNEkEv+CXjBYLk6PtSy62s+nEQb6TlwTBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794521155;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=gS1rjdMlRb4/K9zyYzLkZk0j6UEfbGKlcQ3VHcPrCP8=;
	b=G7lcxptOA2EmU0Yw1rRZhYcdMYy2bzSX3sxFbEDKe54X7ezQRIhIgyTEZSA5czUy7xfj
	 2EXruMvQwlzKi4dg5iIIcFxxxGvIcnL+Pnp+xNty205sUUHckDwVHmNyg0Va2PzZbRcFF
	 ZXgMLyhs96n/AwX4qn62hfxHjFfDmwsZWGzd4206ywbKlfpcgg4ZBKgEIAcv/f6G4IF1o
	 QVdoSgvR0ZyVeTuUP+eqoLPELg3Aaye8OF3CX5qibhMxP6pq0IELi3GNxAnmFxRlY7rq7
	 rAK5ikyPAlxf964nJcTHhKn81LRskFo95oetXZFujZOwm6ZP9zesLbWw/Fuj6vszhNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sbr9LbjB;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038C5606A31C
	for <linux-iio@vger.kernel.org>; Thu, 12 Nov 2026 22:05:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 038C5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sbr9LbjB
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-36fc0a3fe93so679468eec.0
        for <linux-iio@vger.kernel.org>; Thu, 12 Nov 2026 14:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794521154; x=1795125954; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gS1rjdMlRb4/K9zyYzLkZk0j6UEfbGKlcQ3VHcPrCP8=;
        b=sbr9LbjBPYV6M2I9MIvUhdctg7bsyrPjWmfMyEcbLDk87qf2gDMyTY7lS4/coaDAof
         BETIZZlIq6qyNptH8aATXZ1QMTPELfib925KGYgmWhPm1chcuZpyxDGK29DobMHwR5Fg
         2S+QB9CzEEl7YKwBFnvKMhXIhw+OLIMYV27ItpSWjELzKD6dMmsGCrK8bQBAFQjSlL5N
         Kt+Zm7kh1h7BB9LjvaiJMj2kx4kKnMmMkFjHCA0SiWtSxsHeuq4eQYyEKlim7bat/+xk
         1Vbb8wO1q8OPdQkdjW4LSb9H2rc4RA/eFicN5CooSQnKPIODHA1x2/2SmoM7T0Lnu0JY
         2mlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794521154; x=1795125954;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gS1rjdMlRb4/K9zyYzLkZk0j6UEfbGKlcQ3VHcPrCP8=;
        b=o2cbTZcU5LhZsiCKN7cuhNxZqHGiQwhrEQA9nrgpKmCkRYujNxB1Z6vSahewd6j2jR
         bHiETSys1LWp2cTK43jH6Kj2Zbx/zhTs/3eoldZ3KAfrfJjLfvGeMTJ+bRSRn0aMPJ1X
         G8F6qwL8T3Yt8m1cScrMlHOKRMlJxgfrgQEE96xYWjiDVTX6RDUdfq1p7bzhUErCi/n4
         vehAwcUitMehWkGXjYOFSrJ04iahFkDGnMy2CPYMETmHFNIWnbE8nPTAL6A5Y6lnNddg
         UL0Gz6jsNhlAgLd9xqmkXyp8RLEU79uW6SMqdlTxBEAMo3ng/CUPR+Ty9xLdO8r1q/h/
         0qyg==
X-Forwarded-Encrypted: i=1; AL+hErEwOh3ttuR+NU7LF3USBPRUaiYynwxCzr/heUna/Nc5ESo/UeUwNH8d7yDdblLzHx8QyqvYQSqqz4U=@vger.kernel.org
X-Gm-Message-State: APuU4Z/6fTiXjSyO+q7IXBZV9CLb76zN+VLAfXF51PhACNtjgFBlR+4N
	xLqtXUU8u/xnOO/T/WaOMr8KRFzYNUEerUa5RvzMakLaOokVLheKX0ZX
X-Gm-Gg: AYBFou1mHNiotfdGuGTt0xxMsGcQMLdAkFc/CJtQkjjfWbnkwlLWelzCfj61HPA5Xi6
	1JHqwoOgqm7Pm+CTYVSzM0eKiOBCIeaz9kcEQx1Twx4guCiubupa12ObrU8EhnWJG0nic9p1pIf
	qU8+ZNJ69VN9AKMTABUGfHXe1yi1TbUT1CQX0mm8yIR0jN9JUY0yDzQSLl4g9XE1tq4LVCAMHpe
	uIZrrBXGD4d0S4qqK3ecvpAL+WmvuMpbyjWjB8ifuZORO9xqu7oTUOaR607xcNI/F27ffGXPz9N
	6adlwXFQYaCmk8n2/LOFH1AiU/9J52JogFvq5UK/+2c2SkpZfB4XuFlBMnZrhDqTXMX0C91qskg
	Z8aEe+/hZvxKQQihpyZ9CBRnQ4YO2Tmfi1D0bJ/yO3JjUf27xQ6fjU2oR1Q3MkCTnFRv+n9sdRL
	NR8UKkUXZf559v9mnw6+2SYjMXvQxWEY5LKS+l/mxOuvGaI42jljl9huBJWE5+/96iVOE+yh7eT
	+f9d23wLu/zrkCfQG0pdvBgHu9R3pQSz+9S83rCmbV0jU0Abnt3YbbN5JrtbG5RMeJa8JhEIC+2
	sLsjYfG8AeKcxsLBJ5rQpLNmccELwlIohDe3MyjP7YBAhZBTc3heUrFIVM/EEEeRDFzTvilX6w+
	z9XwuzVMgB/vdKgMVhuwAFyechoYkII62ytnEA3ROqUnznjcooAnD3xVBCePKR3hT8LeLpK51wY
	o0PC/RWp+JOcp0sp+CPbhnIblsYfWfgjsB33Cfywu0gg==
X-Received: by 2002:a05:7300:d0a2:b0:36e:ff7e:e57f with SMTP id 5a478bee46e88-3796628f98fmr454214eec.19.1794521153797;
        Thu, 12 Nov 2026 14:05:53 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3797f98b9b2sm428304eec.6.2026.11.12.14.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 14:05:53 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] iio: proximity: sx93xx: keep the IRQ balanced across suspend and resume
Date: Fri, 13 Nov 2026 03:35:47 +0530
Message-ID: <20261112220547.508369-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261108012904.4555e72b@jic23-hlaptop>
References: <20261101102518.22757-1-kapoorarnav43@gmail.com> <20261108012904.4555e72b@jic23-hlaptop>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, Nov 08, 2026 at 01:29:04AM +0000, Jonathan Cameron wrote:
> All 3 of these look fine to me, but given they aren't totally trivial
> I'm going to leave them for a while in the hope someone will test at least
> one of them! If it looks like that's not happening I may pick them
> up in a week or two.

Please don't pick these up yet, I found a problem with v4.

Moving disable_irq_nosync() to the end of suspend leaves the interrupt
enabled while suspend holds data->mutex for the register writes. If the
sensor fires then, the threaded handler blocks on the mutex, and since
disable_irq_nosync() doesn't wait for it, it runs once suspend returns,
against a paused sensor. Sashiko pointed this out on sx9310, and sx9324
and sx9360 have the same pattern.

I'll send v5 that calls disable_irq() before taking the mutex and
enables the interrupt again if suspend fails.

Thanks,
Arnav
