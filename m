Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5933E0224
	for <linux-iio@vger.kernel.org>; Tue, 24 Mar 2026 12:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774354805; cv=none; b=IsJ9Ouw5DYjXkQlQvNJrbD9OvNTYLxOV9kvgKQFbJcic2Clts8zOyIJmHDP8b33pa05iRaKf+Nhl6p/T5fi5FEZNtvlsf/LsN6V3Xqy8XnxVoByuWDkvYZyDaZo6684ehwBiXcl7NEi8KLQrW9Dg/hz2Vnkb/FEhd+oIQ8C8z6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774354805; c=relaxed/simple;
	bh=GuqqBIfeWAwrMihNMcO1RBag4cy/713ffU8ACJsVy8E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QP1Q/11aiUN6RtCiE5v0b8aWoNUi5f9Le80nLrpMrU+GAh2/LOTbxi6PH9lSawqjdNhl7nl8hQ2pQj/rF3C086DRMqMBLBsXZbiumcYu8YdwpRtn7jDhpLldGmOMp+kQOZZDaLsudAGGIIf9mx8D8+FP6zV8QE3ngetzmm5qpvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rvsfnG9u; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rvsfnG9u"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-486ff3a0fc1so33042925e9.2
        for <linux-iio@vger.kernel.org>; Tue, 24 Mar 2026 05:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774354802; x=1774959602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GuqqBIfeWAwrMihNMcO1RBag4cy/713ffU8ACJsVy8E=;
        b=rvsfnG9ut3wLkh5gwA0zQsIVUi8L4jzx/gChLSp5b1lXSwp5e7I68S+DhVv8FnqidU
         1TjgBjvu32+BkTL9Je7oEZbYPHlqBMtFdUdD2Gscrn6jFPfZinUlj5VM1H+ax9OMPIH+
         BhcPynZFiJIwRph2f+okwfMfNWKOPjv3k1R4klP9F/30sZ7CDrnK/S78pmAXZ6H0fFco
         c3JfQYgCIMPPE/JRd8OJI1nKZ3ieGtbbp+Fn/GsIlTc2/38+9DO+TnJ27BIUIYzr9fBo
         vu+r5ZOOCAMFXGVh8dYn2eLaJrznf2ZxaXBYi2OktQiBAIT+2Gvxb8oCTq7C8CWDGtAM
         jcNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774354802; x=1774959602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GuqqBIfeWAwrMihNMcO1RBag4cy/713ffU8ACJsVy8E=;
        b=ksM+7Ko704o0p/m4lywqSevQt0D+zjfxWeFsR+svxKzg4ZWnjYmaGEo4w0RBVfm/Bw
         oHf7IY5eJnuSmk/U5UTD3ySexDA1OcwT6GGmE1JGEXqiqYED7fs/pFqJuegvsA5OGDNP
         5Nk6whVnFru/6wKm2J2tL/R87bsx6R+11QS0wxqhbqqN4IQ5Dfhq9K/3foISkCrwg6Fy
         riLjDgKYE7kAnRf/f25Jw8aVMghx5Yshko/115trewRlQKS6GsN7ef1BoMYGVOP6gjrG
         M1+ijQJHJ6tzazigJdrJVw94N3w6v/1KobUXqz6oC5WGJ1ZyINKT+1Ymub5S5Y96aSXo
         mIDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWR4i1DqfVx6RyT/C3WlQ4zZ/cnrEhoUXXiWt7H+B7w4ulY5hEyfVHcpO+IFfTw+9tO5Y/Ajrukiac=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLwgCjT9ZkrOyGDzmzP7XgQdfjos9QlMyHHHPqXcPpyoRsO27Q
	EOSdqGJ5l67DZG90DFhETyG9vjSOLZik8CVzQYyXwULmBLIgp4zjRvXi3EELKdPFo3I=
X-Gm-Gg: ATEYQzz7wdyRQU0w7RCdz1AR8XD6Nj7p8O6/u70NfmEiOQAbiA0i0ElOjbqzWmPkLqy
	FwfQkheVQoHbQSAYT4yiie2fbPNjByu/IpGGPDV+NQKrTQ5hwWxq/8dP7zbtOaNh/85AO8Dl1fF
	Qnl4WPmJboudoiqqZGLKCmOD52QniPWjpGQ2EenMjFhOBVdQdWqU3gZVcdM4G8SuiBO16a7R226
	I/w8cF79FA2Ynt4uOwhF8eD7frasyv1xtRVTpP7e1zt7Fg378/adqtm0eKQyBhNJ8R7By9fKuWA
	gkGdPSjoEhcD3kIn3ICHTffB2GaQA4hExbVKKV2ym2maiCziFftZ5/7e+Zs7gBTdSuZ2573s9l1
	ctlCdgyUvAjrLGvqW26ZIHOhvO4FEBvb1N19I4RKfcsmyhtIGqbP36nuXsqwTRQIo7kR/rzbDp5
	S4LvmQr1IrB9Sof7ZQK4wDSOjqSML6nFsBZaUcGn3ke4PGcEhOBdIDlRUaHLgLuQ==
X-Received: by 2002:a05:600c:3d97:b0:486:fa35:aef2 with SMTP id 5b1f17b1804b1-486febb5989mr223615895e9.4.1774354801994;
        Tue, 24 Mar 2026 05:20:01 -0700 (PDT)
Received: from localhost.localdomain ([2001:8a0:6c9b:a000:e561:a158:b78:a92e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48710fa0e35sm43400685e9.3.2026.03.24.05.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 05:20:00 -0700 (PDT)
From: Gabriel Rondon <grondon@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-ads8688: use read_avail for available attributes
Date: Tue, 24 Mar 2026 12:19:57 +0000
Message-Id: <20260324121957.75404-1-grondon@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <acJ4sPoX_UqorDXS@ashevche-desk.local>
References: <acJ4sPoX_UqorDXS@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 24 Mar 2026 13:42:40 +0200, Andy Shevchenko wrote:
> This is fragile code (however it probably won't be exposed IRL)
> if ADS8688_REALBITS == 32 this is UB in accordance with C standard.
>
> Also the trick with -BIT(x) is harder to read than simple GENMASK().

Good point. Will rework the expression in v2.

> Do not add trailing comma to a terminator.

Will fix.

> This is actually slightly different style to what is put in the above.
> Ideally should be unified, but probably matter for another change

Agreed, will leave for a separate change.

> Why is 'i' signed?

Will declare as unsigned int in the for loop.

> I would leave this on a single line (it's only 81 characters).

Will do.

Thanks for the review.

Gabriel
