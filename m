Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866313CF670
	for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2026 21:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792358688; cv=none; b=SuFRoet4c+NiNbx7qiKor/390+eIPvmV1o3i3x+SSRiezBehMa93x2R0qFUkxzxtFH73yWqiagtYHFPrQNQUprjJp63qQi4ezmEIim+l5fsCUPArjOClirx+IEvQlVWnmxefaiXubAutFSmm2rGzHMrWVofumQOWfNngS4IGX9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792358688; c=relaxed/simple;
	bh=I/NvMy2kh9NjYcDpOl7qvqSIY77dP0Ht8OHckCjwHI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T6Su6j+sQuSXhfTb1eZ8MLU5AAa5nGf9/gEWF4rKp6P5WhUR7fi1UVxI4n7Fm5uAZp1e2/B8+bUoCn+iadP8W0AHZGz9Q9DmiX+iqmhVAkIqNPNuNM05gvz509DecMwtUkrTv7UlcxMO/qs6+Fnd12Cnqm/+7IvKi+pLU2yIxKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IuELkrcX; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IuELkrcX"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3ab28f3e4dcso11827421fa.0
        for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2026 14:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792358685; x=1792963485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1HPMK13TgXy3bouQU8dM/uJi5pR0kwrcIJazW24h+v4=;
        b=IuELkrcXcDm8cvSynVKOnrvFUmrAXt38/Ws4AjDC0UD8syCGCY+81/0XtOcBSBJBNc
         wxBze/wNX9dWeMmsAirVATG0Nb/ayK3MJXVf1RUmGik/zrmDyC3zUXyt1LccFwJNZuh8
         +nBD3DR1PIAz7ogRue8Ljnd9tCknCdtILsW8Tb66m+I3WFhzS5IT3Gb55NWpL45aTiej
         48jkP+Z6TH3Yb1fmQMFtijsJ3an1PFnuK751Uq71tLOe4u/pBxLJ+VWfkwrQNW+x8Fvi
         LxeicNlDIaIBmN9q/9muZzC02qdDIfyJHaSSzIEfCEZgyl4w7FbSdouVxod2ooE0IGg8
         nj0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792358685; x=1792963485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1HPMK13TgXy3bouQU8dM/uJi5pR0kwrcIJazW24h+v4=;
        b=xZedqjhxDguN09qj/zz9fBeiz6qxj4MSPZNt9U3MPXNQ/+8JaJTcdSGzwysOEpJ8WN
         VrsYZLnyL/ugRHDjaz2Mg5blKwQy2vDSaT8vvu0ACWznJV5W4PfkjKSutGA5xLSKP4yQ
         b8j8/HSXCAgvlbaRyMYxSDBvZ9HVgPLaChm2a4vJCbbfg+VfzEMd7JY+xqk1cOWWUZsP
         FTyNDb5fkmURaYTYby+vgMs7mZvheJdv5PCtiAgyRCqtr2MKTdo/ikCM0vTXK2dr7Afy
         nIESHJ2zvzVHr436bkDO/biNnKUq+9wbuiXPNNDoXhvAnSofr5fnAGu2+rEbMTQAocnC
         zdQw==
X-Forwarded-Encrypted: i=1; AKwUvByte4uQa4WDCFk2pu2o+VBOpHIUwR5LMU7tfY4H32C4B1QuRlaX1VzzLVy8rpH+WaSHtQXzzEVi3j4=@vger.kernel.org
X-Gm-Message-State: AFq9FYK61Rb8iQ2qc4K+JxEhwR2OIS5C+BNOCoaBT/9cH8y4G7VECd0i
	Qme2fafqfuYd7nFlompHp5wSLCxcuZxXRucx7nrozvgp9cJK8goXEsxf96p8FJaN
X-Gm-Gg: AYBFou05JXHNZ9Om8Z8iSQzQvbP4MS3BsEXWlf4218TRwFvv3IRnBmAbckmGXQ6EAtQ
	z7dRQ8EnarHGCA5taJLVHr8XmUvYjGwemQATzlN0Rij6uwugU7Gk/ek4Qd11kSyD9cORsav9Z/E
	1dFvBaNKhNkxL7KC4m5A/ZB5vjJ0HccMvcPvJkXhpUBLWS0UAe29b2V30PFZ5fhDiNm1F7i+0Il
	J+Hopfj0Opg7bcEiDqH8anV5rvhKEvdWaKZ5i+doCc2rLMxp4Q6wXTbJPgya9MdtkONULtCAmGL
	9QKvG0N8nmoCawZ2GEPB597HS+zenLbi44KbT6u0bZtwjYG7/bd/2ZBABs3bzHisezdNN26LG57
	vsgE73nJd9ZaMk0ZGFtNHO41JsI+uSSgju+q84yT0ZwxP6MEheljcdJ7c7mc4F/u5jerrp7ZcDl
	k+TypYAs0armJLVL/jrb10SMvWCZiAEDzwyNzs8Dz20zFM8Kgyd7ufQGQfjdTmLk8cvZtC/GGAy
	tyoYZBHthYJ4bl/ZyqnjOYlPQpWmL1Mk/kqgZVwQFzIXY35L5Vak90sM31hsMN2liXYpdPbSRSw
	oxRZTLg=
X-Received: by 2002:a05:6512:6c3:b0:5b6:10bc:dc44 with SMTP id 2adb3069b0e04-5be47919a66mr2712000e87.27.1792358685313;
        Sun, 18 Oct 2026 14:24:45 -0700 (PDT)
Received: from yantra.. (nekmmqtaaozvmkd1587-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:5185:c9b3:741a:edb7])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5be4a3fd02esm1582832e87.10.2026.10.18.14.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 14:24:44 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: jic23@kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Bill Wendling <morbo@google.com>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Justin Stitt <justinstitt@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v12 0/5] iio: pressure: dps310: hardware FIFO support
Date: Mon, 19 Oct 2026 00:24:43 +0300
Message-ID: <20261018212443.43473-1-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261011145914.05d1c7a6@jic23-hlaptop>
References: <20261003195012.92948-1-zoone.rupert@gmail.com> <20261011145914.05d1c7a6@jic23-hlaptop>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, Oct 11, 2026 at 03:00:53PM +0100, Jonathan Cameron wrote:
> Applied patches 1-4.   Not this was messy so there was some hand applying needed.
> Please check I didn't mess it up!

Checked, matches what I sent.

> I replied with my view on patch 5 in the earlier thread (just now), but definitely
> open to hearing more opinions on how far we want to go with annotations.

Fine to drop it.
