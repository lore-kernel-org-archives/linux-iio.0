Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E703E1723
	for <linux-iio@vger.kernel.org>; Sun,  6 Sep 2026 10:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788689237; cv=none; b=tYn+VLKcoXFQXa2CIym+he11lQQNYxbY1pDlMhfuRm789S3YQjo4ftSKPgUJg3V+4jSOo9DY3gOwWEzW5tkQK/VYxOn7ozvgpMnmH1MS0YhzPYTuGbExSLeWUJIusQ4DDTZmHWOEK1Y3Y3DF+SqluISfy0rUnU6Xm0fpw/+5kLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788689237; c=relaxed/simple;
	bh=zdPwZrvfJK7MzyGkqu9cVdFV8gXhIeOCnL3vxgmUvv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MN2QQPEEkfdLWcYeXQo1741MtbAotQx7q9LGJ+W8itC8gBzDgniB4wmQRU0c4bxLN8eSANFyeIwy6NOonTdrCYIGnjumUOnCy+WndcMrdMuWoFL7DG/qj8TAPw6HGnspzWEyK1cqw0KnIzZjgiau4fUwSKNkfNdxRKdPJJNGDjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lF3g+X7I; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lF3g+X7I"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5b28c91fba5so3105995e87.1
        for <linux-iio@vger.kernel.org>; Sun, 06 Sep 2026 03:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788689233; x=1789294033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+3ouU/PkVGCvjpETYDZTI0h0W7DBwEzUInQxKxjqn74=;
        b=lF3g+X7I4MJQO3LpzEx4ezUBBEPff8jVBGvMBGuxW1/NGtZgfeI5enbPFouTUHw+Zb
         7Gnki5fWEiQR9FG38y9A8sdltFQL3MvjZfr7IPyKUVLHW7Qye00B8Cv+s4OgMH1Fp7e1
         rP04tVMpRoctJRQSdDIHhL7U1Jfakm43Tlhy5ELsya/LFhPfFlIq8mQUu1dCIN7jVcx5
         jpQO27gya1uZoP7aC4lISdjNFEc1D3OZamhRwS4tVtD+KEzuLJ/HEXUzJZcEz0aoBuza
         k7uHg715p3QcvgY4OFX98cj2mqboUE7r11s0pb9JKjUFKfj8Z2r16P3gnE9VoOuLbaww
         jKwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788689233; x=1789294033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+3ouU/PkVGCvjpETYDZTI0h0W7DBwEzUInQxKxjqn74=;
        b=OrKfiMyOHNdbelRSVtzAuewh5x234NKcHD1wPGUT/RrC65DyZqrQjh4gbUzXhY6jLZ
         tsThCH3bBAjn7t8J69y/+DTX6/eg0CJR080lggr/tT6iZ7bYjePaeDetn7KQT7WXwZY4
         7iiwCX9+50+egiogxBm+yb3OHh4TyTNVsZvg9pv+f5b0Mi0ixsP6I2L/7h7EF18CticL
         T9ZH7Src4FgiZRceNt2LjvhOt+oIVaDNQLZRNqna3O0xMuDl3nhRbxsIomWsAD5D4Q9V
         sjquqL0p2R0BBmjMcdJ16yIEBdcOBHqQLIlRdBSADgBGc1S5qiEKPCfOfbio6WT/Mzgb
         IYgw==
X-Forwarded-Encrypted: i=1; AKwUvByZhV7CDe9q5hFpjfeeQ++gLabklDpusnVPbUrnAuQYgwRaSpMRNrj75wSLu8evR5FzdZNLviF80LI=@vger.kernel.org
X-Gm-Message-State: AFuF++kDCs5kicFWQzpv/f2233u39d54ygayrnoCANknWQGK9O+BkkTv
	DjULGZ9JsYALOXAdij5GVgirJMPpsWt8mRjsxLjQxhtLso4mj/K1FSts
X-Gm-Gg: AYBFou0f8SEjKTz42gEAsrwqd3X2a40OFFEGFbgytsgg2376L7mGz+CDMY2hEBt1FGG
	s0BEAed7d53CJT24xkum8CV/fXcaKsNFeFFqPDUCNIIhpB8b4yMdDRfXQTzxWx6g0+q3iJILw2p
	n+XrQB/KfsaamAv7q85BnuGNc6tIhpZsrlvYyk33SlXAjWO6rqJ0WxifAX+VKDYz49ZB9Hf6LQR
	o7QkwPYoPUyiIQMKq+TjP6TXleukZrGzI+/L84yeBUjn5SQEFm2WqjG+cVISR59ZKyzXjWHSE6B
	bJKToNsF8S/4c1nVcnaSVWuF8xrxsQqxqfA9XSq0yr49UNLUAImZUI6uS9Qt0X0wmZj++4O08Fp
	y1rogVxP5MuUNhvHxmZt2XOsqH8jZ7P7uWoQQ9PWzzf3Nbau3k74XXqx80QaqZpZnZx1D4KkZqR
	I5lyYa8CpvftwxOAL8Q3jtdrKw43nP8bj+L4diKLaX4/lx9b8Sgo8Gp5EuO3/GJNDSYrnUp2itl
	tzWnvowmZ0afNVgJbJrfmb726rmK59m2m8MXZlPTggKhhLIAbxDOUWPb0kqkDYHaNk8CQ==
X-Received: by 2002:a05:6512:3d02:b0:5b6:10bc:b863 with SMTP id 2adb3069b0e04-5b61768ca49mr2220492e87.17.1788689233221;
        Sun, 06 Sep 2026 03:07:13 -0700 (PDT)
Received: from yantra.. (dsl-trebng21-58c187-236.dhcp.inet.fi. [88.193.135.236])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b619820db9sm1486211e87.54.2026.09.06.03.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 03:07:11 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
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
Date: Sun,  6 Sep 2026 13:06:53 +0300
Message-ID: <20260906100707.435298-1-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ao1bBFkLXIIgNl49@ashevche-desk.local>
References: <20260824201203.396651-5-zoone.rupert@gmail.com> <ao1bBFkLXIIgNl49@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 25 Aug 2026 12:06:12 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> Hmm... Is scoped_guard() too bad here?

Jonathan asked for the plain form on this handler in the v5 review:

  It isn't necessary to use guard/scoped_guard() for all locks in a
  driver if they actually hurt readability.  I think that is the case
  here.

So it stays as mutex_lock/unlock with the goto. guard() is kept where the
lock runs to the end of the function.

> Side note, at some point makes sense to move from 1000 to KILO.

The site above it is pre-existing, so both should move together in the
cleanup series rather than leaving one spelled each way here.

Rupesh
