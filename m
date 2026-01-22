Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4343A3CB6
	for <linux-iio@vger.kernel.org>; Thu, 22 Jan 2026 22:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769120561; cv=none; b=M7CYK3b8gRGVJRw2Qsvw0czktUo3/JQ+2SmneXzMzY/o1TQ4H/n5l71eqK2AsjOC6iHC82mn46RVpvcv7szOvcsqywDcBP/qC5Q8XnbZurf0RXz3PJHrh1w7GAKW9VGkq/m4KEiRGpR39hH36g5juNzicw15Y1mS7t3KaNUlLws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769120561; c=relaxed/simple;
	bh=v8li9rEEOi4RxbsVCtE9cbtgvcBBy/CLG+X+vCFd4VI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=jDkHdMqJ5zQtGJekeyKwDuNiMJXjOq8yZk6+j/joYzqgiEkrjkGxHKNT1YDhne/CFnQmFTZPfw71fXpS3WnTPbrL7xdotGiKNo9CifIuaTFMFvjlQWQZ5Kl6Y0a3tixPkmwsh+VJHvF83PlFfToJ2HOXf1dCQ+gNAmghWaXL4s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F44XcQuR; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F44XcQuR"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-93f69720a7cso852411241.1
        for <linux-iio@vger.kernel.org>; Thu, 22 Jan 2026 14:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769120549; x=1769725349; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iga57dbeE6nIO6l3TfOl2awwaa5/FxEDkOD4DnDDCnU=;
        b=F44XcQuR1PpRjXp0W6mc1AJQJdVz6gqWm82LGgTMctLTPFpi7YXX2TEc3VAe104+Ge
         QKN71DZFhRK2PoEXdFLiQJiyRZe+3M2JEr1dqwbTtRYMNGh7Touep50TZzshIMhYIUf3
         IMjU0w0wlKVa2NBYiC2NhjQwkAWd5MBNCvuhWpVl5n7I7BevZh6PYhrrDZs3wevYyCVr
         mxt1xSlBakohgT8xm/p9e50L5jZygf0JgOkoYa/a9c1lMK+bAv2eFOGLdMa8f77S7ISu
         J1w7W44y5GSWbj7KeQswz6F9KUPFzVd3h00azAEV34XVx0waHPEcFjIEuaBFlxHqbANU
         QzBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769120549; x=1769725349;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Iga57dbeE6nIO6l3TfOl2awwaa5/FxEDkOD4DnDDCnU=;
        b=UZfrwBISGkN1mRGhYNBNX3R6yJDzk5lXMSCdRoH1l39o66HdEYm6M2h6ImkUzcYkNL
         XJg3jUPQM9/qturKB8p6vWKbkrLRiGMRgLKD8Yf33R1VNzNGCe5egre1v5HIPjKa0FIu
         DyX/WgJ5BcMzLfZBnWpjE3aPkKUs5SiQAesXa9HblCazYlFSKmPabF+ztF9uHl4k7vYH
         B4T0H2+a0bG7cylYRI6SG6VpcRm8XMqbUXrYJWalOSkWYn6tbeuqMuxWmzsRgcJpTaiq
         ZVmgX3KAf97976FHgVyLUqXXtasZnE+yI6HQVvsoGtJ8i2/lcFztiZQ0Rn6k0V5pVtSQ
         uSsg==
X-Forwarded-Encrypted: i=1; AJvYcCWlDYAgbCu6O4Pt3Qf5wKx68hsMlePHq+DcKkiX1XjEbSMOSBGJJ2NYasCFcqW64NbLoA9jZafLfAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCtHocbaKwr/uT8xAbdbAbzJo8vE68Gkd9GJRG/UefWmwngo5C
	cnYrm7lhaB5HimANx8BcQ9XY5lCO1k8KRxWE7Yt5u+anTgOnZh5eKcFD+ldY3A==
X-Gm-Gg: AZuq6aL0PfWlon3ZwASlzhSnoUjb8Z54aomhF3yZPqBmoaNL7xW7HbT11N0F0S+eMSl
	mFTKUrsqgdKA4fG7pGQe9UIgD0F/XrY419/MvecznpsJnfhlL55B/5VsmEyPOLBkb7wMoA8YZw/
	DVVDmG2zaleeZ/LSWh/fqBQw+iFQwkghpEiPBPJrq+8E/q8sR3zUEfCndFg7HH+pacJyOG7Dflk
	qwekvaXapBooZs3cYCa7eMWhlMSJakEtJlEfhJHysC/aWyXlTlpHgz3zkzqfXZobKKUGFvex7R7
	vaCpZesW1Qgq+liBuNEJQhC2owMLFH0zva2sda2mWpk6hvoRT5zbPNM3PEY9K9ZMO7VjMQLu2D0
	MKQB8oQnjKGz94mvo7ZEzWb4wMSOm3+iWJbj/A8q5WHr0WSWMii7tNfnBzz8vJEK9SjafLv7m1P
	i092dsOd8=
X-Received: by 2002:a05:6102:f14:b0:5b2:d28a:8937 with SMTP id ada2fe7eead31-5f54bb13469mr433935137.12.1769120549446;
        Thu, 22 Jan 2026 14:22:29 -0800 (PST)
Received: from localhost ([2800:bf0:4580:3149:c903:2904:3cc3:8b4c])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5f54d3d8225sm149921137.3.2026.01.22.14.22.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 14:22:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 22 Jan 2026 17:22:26 -0500
Message-Id: <DFVGW74ECJL3.1238NAUKM1U4B@gmail.com>
Cc: "Andy Shevchenko" <andriy.shevchenko@intel.com>, "Lars-Peter Clausen"
 <lars@metafoo.de>, "Michael Hennerich" <Michael.Hennerich@analog.com>,
 "Benson Leung" <bleung@chromium.org>, "Antoniu Miclaus"
 <antoniu.miclaus@analog.com>, "Gwendal Grignou" <gwendal@chromium.org>,
 "Shrikant Raskar" <raskar.shree97@gmail.com>, "Per-Daniel Olsson"
 <perdaniel.olsson@axis.com>, "David Lechner" <dlechner@baylibre.com>,
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, "Guenter Roeck" <groeck@chromium.org>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <chrome-platform@lists.linux.dev>
Subject: Re: [PATCH v5 5/7] iio: light: vcnl4000: Use IIO cleanup helpers
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Jonathan Cameron" <jic23@kernel.org>, "Kurt Borja" <kuurtb@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260120-lock-impr-v5-0-d4d22347041f@gmail.com>
 <20260120-lock-impr-v5-5-d4d22347041f@gmail.com>
 <20260122191252.320750d4@jic23-huawei>
In-Reply-To: <20260122191252.320750d4@jic23-huawei>

On Thu Jan 22, 2026 at 2:12 PM -05, Jonathan Cameron wrote:
> On Tue, 20 Jan 2026 01:20:45 -0500
> Kurt Borja <kuurtb@gmail.com> wrote:
>
>> Use IIO_DEV_ACQUIRE_DIRECT_MODE() helper to automatically release direct
>> mode.
>>=20
>> Reviewed-by: David Lechner <dlechner@baylibre.com>
>> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> Given sparse doesn't play well with this stuff, this is (I think) more or=
 less expected.
> drivers/iio/light/vcnl4000.c: note: in included file (through include/lin=
ux/iio/buffer.h):                                                          =
               =20
> ./include/linux/iio/iio.h:687:20: warning: context imbalance in 'vcnl4010=
_read_raw' - different lock contexts for basic block                       =
               =20
> ./include/linux/iio/iio.h:687:20: warning: context imbalance in 'vcnl4010=
_write_raw' - different lock contexts for basic block                      =
               =20
> ./include/linux/iio/iio.h:687:20: warning: context imbalance in 'vcnl4010=
_config_threshold' - different lock contexts for basic block  =20
>
> Hopefully it will one day catch up or we'll move to an alternative for lo=
ck checking.

Yep, sadly it's to be expected when using cleanup.h stuff.

>
> J

--=20
Thanks,
 ~ Kurt
