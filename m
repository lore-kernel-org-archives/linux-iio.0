Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF8843B6FD
	for <linux-iio@vger.kernel.org>; Fri, 18 Sep 2026 12:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789734260; cv=none; b=BFZIXrmGb/7G4uhq8QWRrdloZ4U1qYmbDKCFZ2zp88wNJ/zntRDTHrasO1xePifyNefeKaWgbEQCiNTTd9aqYQSChIgYWE1M0yjwZDkO7TUqZqEynVwGvfunCv/HnkU1tAZeuSmw9rvRwwvKEP9zUtkUAHjq+YF4Chb+i1KW5wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789734260; c=relaxed/simple;
	bh=maSmLJEiVW4orqk/72EUoaWvFnMBkWSya0UZSf7eKGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FilkTXwyTTiQaF7VLo/qLJMKezZrBSohbRQRHgrDKPxekwx/M4q7Pev5y7v5SmXyulwyqS2d8aEp39tHLRJYl5Ho0H3wsVmGZLYz2Zh+5Ueea4Y2lhMBW/mQtOhyIpvK2kLa/vIY8M+3q+b1tyuhvVzumaOMDGqwBqbk04kO+zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VUJx3HMy; arc=none smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VUJx3HMy"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a2ff176d5bso5363331fa.2
        for <linux-iio@vger.kernel.org>; Fri, 18 Sep 2026 05:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789734257; x=1790339057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=maSmLJEiVW4orqk/72EUoaWvFnMBkWSya0UZSf7eKGU=;
        b=VUJx3HMyXCIBk6RYllw3W4Afd2wXncJuwFqMCEHYt603hUoVCZIehk8mbFG7IWspyy
         QExjOhiLNRlarTD/tjJQKy4rGRZueeBrLR86Q2TztpEGLnhnO7QQihtRYqrzv6r6yvyY
         RBkG8bSIWltDa901NGM78nldTm1HzCplU0XztkE65pdt+IKWDMSkY/HQ9k2X17BfXOtk
         GmYqgkbdJN5A7YhhwHyjCZjMsJebdaR+m3qDphgjVoR8iS8TtO2+xffK6Vi1fJOThc86
         PEg4IPW3jxUrMk0jjK7Ply8J5q6Be+U+hGMy0ULcA+m3aawKqVnrITyC0wr1wO6O4MLV
         +pUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789734257; x=1790339057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=maSmLJEiVW4orqk/72EUoaWvFnMBkWSya0UZSf7eKGU=;
        b=kkPXELXLVThwYMa1C3afjSga0JmNvrFVuZmuGJntIlswsDcdgqhepyB0vj+ZudqWx1
         idOQXKL1jRjgzcqnir4WPOozIfZuL2lLyt7YMtxKYM470dhRpYiETX/1FUcdh5EqYkcA
         CzhiIwHayFs5TEGeJAOPnqmy1TpkiwvPdAzHynPYcY/fERz1rvcaB9mOuhtts2t2gJ3z
         IevW8mEBIZ0Y4nyFoPTJJ6QLtiksU56e3iesvMN1MyXXunOYeZT/SclAS76GQKq9obMF
         gSJtUR6kEwDDMxVuNH4OmbR5tqkv239BJuQLqEUOo/MxOzFRe290eDwQYvBdHQeoHPVR
         NOSg==
X-Forwarded-Encrypted: i=1; AKwUvByZZxaMDnw7gf32bYH9YmflSZl5FnYEfeX8/kdIvVAGEqGr3y1Z9dZs85SP5Vr6ZmEu4TQMnE+VG3g=@vger.kernel.org
X-Gm-Message-State: AFuF++nDia/uGd+Ihe4xcs8mq8h+McC47RVC3QFPw52kX8Yt93ZBwODM
	Gc94pYnrw3IGLl9WbanyzvAJne2LWc171LQWXV6rijWtqe6yCesQGsn0
X-Gm-Gg: AYBFou0ZoxOstku8W/leo0qetLNtHsAAyuT655+woNrGQ1a3ahcq4WYD4SMqcQ/UVIF
	c4WQmUahlA+cUncmJqRPBzPrzjQa0Kqwfww9/9O4OaAYV15pQ4IrofdTnMZuf2TZWFSRXM01u0Q
	sleAusbEXw6eKTw0YYUP3uVdMqmPzUQXQdknl0ddvftVanZmJyWa+p45ybLLcQ4njO5SKiU7Yas
	sB06bmvpwzRa+iy5N4Q2FxlZNiXagPygzRRgvPz77dZiBFQ4vX7V697JC/R3lu3zum5LS15z/8d
	P5HISBQFIQiQxsGWhG9zpOo2/7nvCbWyyUb0Tw8kHsg7/N5Z6Q8L2WJrLAScowzD7gwgXKWj4W/
	kRnJsQDcEuixqEdB4O8x5BO0HIv09YOPCb3ezCoXZOj2hI4ah1uBbwOLSJ6ZnfyUQf9DkEu1iQI
	WReITvUOkG4ULoWa7RzuEbllXMbw3IzuooAUD55HZc69D6Lh/EaIMjDmc2J/QBPj4zG4s3K2Zsq
	bv4QSzaI2qjMDmwkXzDgCDM2u+aSVFhKbjTIJNPDiSthwB43WIdzOVX0su2xvL00BNUMyPMNQWu
	dT87
X-Received: by 2002:a05:651c:a393:10b0:3a5:f06c:f897 with SMTP id 38308e7fff4ca-3a5fc0f47b3mr3286371fa.28.1789734256702;
        Fri, 18 Sep 2026 05:24:16 -0700 (PDT)
Received: from yantra.. (dsl-trebng21-58c187-236.dhcp.inet.fi. [88.193.135.236])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a5fd5da086sm4172101fa.4.2026.09.18.05.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 05:24:16 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: jic23@kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Bill Wendling <morbo@google.com>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Joel Stanley <joel@jms.id.au>,
	Justin Stitt <justinstitt@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v6 4/6] iio: pressure: dps310: add triggered buffer support
Date: Fri, 18 Sep 2026 15:24:15 +0300
Message-ID: <20260918122415.375211-1-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178813888150.2788519.17461592150162820073.b4-review@b4>
References: <20260824201203.396651-1-zoone.rupert@gmail.com> <20260824201203.396651-5-zoone.rupert@gmail.com> <178813888150.2788519.17461592150162820073.b4-review@b4>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 31 Aug 2026 02:14:41 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> As this isn't filling in the timestamp, I think you'd be better
> passing s32 channels[__at_least 2] as that final parameter.

There is no __at_least in the tree and nothing in IIO uses [static N], so
it is a plain s32 channels[2].

Rupesh
