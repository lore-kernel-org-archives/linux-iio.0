Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011A83BE642
	for <linux-iio@vger.kernel.org>; Thu,  1 Oct 2026 11:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790853969; cv=none; b=NVOieBlehTW7ecGB1fEXbqN8saeOnCa6YlstINVv16CsXzyK5VGzXoHqBR0rVT2aiDyqwtOshdAzHR/F8DIfPi+5NzBIyuRv7zXYNFAE1YoDj6u1RM5VIDSfOSJEZF4yY5iGUz8KbIpT9v8UUCUAGI98UOOYm74rJ/X0KAzz3h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790853969; c=relaxed/simple;
	bh=XXJE9lpazIypG2rFZXwci5NBfeM4Y59+X+ByKH1vibk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WvxJJeZkR6EOyZXmSmvInb8+V/kTFwuys9I/o3naY3FKnrnfndHQW5XNpaY8EVMIr+CPsWpNyYuUwp/BRN5WxJrpgW156WG7H4O6iCVivY/fOgrvb5cL+TK+Mm6KnoffZI9y7HMgATlE4s913PuXYsrfprYEAo2SMwRqpZ3zW1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sjOJG0G3; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sjOJG0G3"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5b8f69a0af6so658689e87.1
        for <linux-iio@vger.kernel.org>; Thu, 01 Oct 2026 04:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790853966; x=1791458766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0q1MEXEb22UrsB8iQVi8Js6TB9YSw4vDK0ti4byYbGo=;
        b=sjOJG0G3TgKU0py1mynpA5NVOk8Fopl3FoYPDfi7Nf2OCvGc2jemPwrTfIW4MhvEGD
         R7pzkkDxIaSrFCQGynLmQX0rfBTwDvblmqvqS80bvnjWrRSESYTGs4swg0wuTGB4wDvH
         3bkWaaH528FluGLqVWAFlF09Tu4az827h1nmJ3ybz/kAIymYfAmpRbE+c5tWSzDS0kIK
         qHfFqspCXbbKtvAN9Nn1aB64jiygAMdeKvYsPokNGv+W1/JB0d7ENx6TB0ho3A0SyL6a
         BDJNwTa3JXWHfwwIW1V7DzscEIdy6lCR5adfa47a/jC8C3ly5qqkyrqnFQvvdVxpUago
         Ob7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790853966; x=1791458766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0q1MEXEb22UrsB8iQVi8Js6TB9YSw4vDK0ti4byYbGo=;
        b=Zrt2Sxms/4ZrR1aWnetqtDWszcMAbcGKPbLaK75osZoijk44mdgGAdYCoAAbIeXuep
         cXLUaCgLWJ8VO5FnRYyosQ6Mkxv03UIpWxOPY7PQPcYi6WQ0vw4PgLhyOu3v8IYUAPWV
         BVnlts/A+2DjDrCDmjQHtu459mqdPef8/G1c+u77txOtSuY7uiavh2vABGWYMtBVj3lX
         pWBaxz4Sco4IwxZmU9ue6IXoFuv+DnP1Woyt0F71+tLcztdgR8ZyTx95DZW0fnGUhr6K
         gFkMY2LscwSol8MOhGjcqpc0AJsh6pmq4o4ESHIs+z1iSm7ffFDZRpEVLrXsrNQyeON9
         MIdQ==
X-Forwarded-Encrypted: i=1; AKwUvBwbOYzPYsONPFEQHSmJ1P3zo5LT06RfpV49XTn5UNAOsMomfbrkw3m5znrca6k4I5ObCHDkmP/xyVo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ5XzacJw8QQgAar15yF9R9uHZR2KzE0uBdEDSb23UsF4wVoM9S
	PnzovBMPrNDNqB5Dyd1zqqUzsKfzuBaoBKIr3zAxMFwoxM0HikECvQu2
X-Gm-Gg: AYBFou2/ZyVc7o7kNmvhIvxnGXiTrLt3r30khELD+UCdpWMBIWgenRQ91fOu3uuk2vq
	Am6W20j8e2hFrNHkykSgqW5reXKcVhG2kYIQ7bNXsU4wBuICxXa+R3iXChp3KLKpTqQjvmWb+PP
	qnwgBQznqrUW9IAnsjn43dYFT9JVz796pilSUu1Fd/PoKgEkWPoCY+tMlkTRwgoLunCWehCd7St
	FE0OmP1t6nLVR5pBOEtHblR6rurhiXFKSTSpJmv2xe9pHrj2R9FcL/dNB6Pb65SK7DRL0uqU26D
	F0tXCKfii4ILTP4locEE2torSFHNnvU2FMvqgJhKL50S9ic/6dJybhiJD85kOEiUY0/9ryLGu0q
	S37x+GiuXLC7IvNvo/gbRdai6vLp3Zg5oajhzG78Zw0npJDed5xc37m334GJ/4BC6s0tJikcGh8
	qaKc2Z62R+93ROdu9Gn962cUwaMFO8vFsvEkmnibcd8wJ7WaKOiMghApxPWQNaFBi5aaUjLxGRv
	9TIsiSrb6MX3COOwwsi2mHcSdUYMSYHdwANS4SIo8QOwImRZZAOihXoULM+MbYSWr+Jx9NpFnyl
	SiV3
X-Received: by 2002:ac2:491b:0:b0:5b8:f1d6:554c with SMTP id 2adb3069b0e04-5ba433daf8fmr722764e87.12.1790853965797;
        Thu, 01 Oct 2026 04:26:05 -0700 (PDT)
Received: from yantra.. (dsl-trebng21-58c187-236.dhcp.inet.fi. [88.193.135.236])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ba42fbebacsm649768e87.72.2026.10.01.04.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 04:26:05 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: andriy.shevchenko@intel.com
Cc: Andy Shevchenko <andy@kernel.org>,
	Bill Wendling <morbo@google.com>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v10 1/4] iio: pressure: dps310: read buffered samples from the hardware FIFO
Date: Thu,  1 Oct 2026 14:26:04 +0300
Message-ID: <20261001112604.15200-1-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <arzl4DK8vhP0g8Hg@ashevche-desk.local>
References: <20260930100158.957977-1-zoone.rupert@gmail.com> <20260930100158.957977-2-zoone.rupert@gmail.com> <arzl4DK8vhP0g8Hg@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Sep 30, 2026 at 01:35:12PM +0300, Andy Shevchenko wrote:
> On Wed, Sep 30, 2026 at 01:01:55PM +0300, Rupesh Majhi wrote:

...

> > +	rc = devm_add_action_or_reset(dev, dps310_cancel_fifo_work, data);
>
> Are you sure it's in the correct location?

Yes, it has to run before the buffer is freed, since the work pushes
into it. devm_delayed_work_autocancel() goes here in v11.

Rupesh
