Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883C8CA4E
	for <linux-iio@vger.kernel.org>; Sat,  3 Oct 2026 19:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791054682; cv=none; b=ZNjH/pCvKbptIjWiS+F3/qeHv2NPSvSegqOycAvSxNob+LRQECttI3S1Vcy7VdglBSgkjTj2MKqukHjMfZpsiWBY0fpV/6VWEpvpQMchppka3/9CcC1K9EYJU1hTB7hIhmQ7BGSFxSmFWxLAQvovb+7/j6+x6IYbAZKADD/pz1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791054682; c=relaxed/simple;
	bh=fbyGV63fwXkPEJ1aVy/GDfNe2j2MUoamF77AMyyYKHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bhHiTsMOJ/xGQKqBjihUoPdW7HU2sF8C+J3U5A936H1Q3FxsztiWs0RzVQTxTuB5lpqkhVnfWOLuD3DPPk66oYFQdRURZh4xX//dp56xGFmgtujRrycBeYyQxmVNi7nb0MGCqmFquCSD51PcJyjIOwRmkTOI95BvK0jVj7B2UD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FG7I/IPz; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FG7I/IPz"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3a4a82aa383so5957821fa.3
        for <linux-iio@vger.kernel.org>; Sat, 03 Oct 2026 12:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791054680; x=1791659480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fbyGV63fwXkPEJ1aVy/GDfNe2j2MUoamF77AMyyYKHI=;
        b=FG7I/IPzKBRQfk/7m3EhddmaK0x7zIuXBGUtP/LGHkyPe+iE6kEPkSPlroRP14HvgU
         OiFmA8jhGlDs7qs1qurG2irhfWVI3j5KVRaHjHtmgzgOH6tYLykI8ZQFcNbPr/G3ir70
         jbHu4SI3Y8KvjP62H3Cq0iAbZnF2EZ29vMfe0w5b8aNtO98L03tQYT4HIT0al5JQBPQ6
         Qkl950HpQC89FASdTYY/vUAM7aV6DQFxjiBR2ZX8ac39GMqYWdR0j+ZUe0DWK4WCIJg8
         XCj/cd4s7iPMv4zdtwD4jXvOJz52ExOpou1l0+cF/ZwcmBonLNXaXPqiU83FL9VT0YrD
         DqPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791054680; x=1791659480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fbyGV63fwXkPEJ1aVy/GDfNe2j2MUoamF77AMyyYKHI=;
        b=rfPdZ8k7M4kujcYHwnkuzu6hcn67TLAI4HYb9o770A3bic2iZ23p5O/ItEiGiP1nh6
         EoRDbopGUHTotrEyMaF3hbzuRB7vJSaKC4aEYLE0+gGhikqyr2ip2qtJKPnt4m8MZeqY
         KZRuDlUKlzYHRM+F2NFGa9tf1zn2hVcC/lxOxlWUNlHEmX2/giOLi/ZmuUXHW/lBaKC/
         hBg4Uhy8m31XCUj2XeJFBOkBfSdAB04ZLJizJ43g+QpD8MzIVK2EtbPOi/ZlgUoJ0FHu
         +FPP63QqVKGEpG4KxJbDZp5CZiomHMmbgRTekHVghfcvcB8ZKJnsixtAy8FhyHg9kiAj
         V5RA==
X-Forwarded-Encrypted: i=1; AKwUvBziopv9vxdoeJkqPfFrwl9ufLAX/q36OTW+eZ9A7+wzVhKkKBJgszKzrPEyKnri3UykoornSGOL6Jc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLsU57QAILKZWPsXTpi5EowGbCOLi3Z9KCbwYO0YSZ+dX7MKFpd
	oxZhqJt0uvSPwca/d4KR7AT1BiyDz7lLPUyfo3Cq4ZZW6YqZJE6mPkp3
X-Gm-Gg: AYBFou2L33nhO9qDmA92T4EW9CrEWk4TIjmt8lT92nPkHQFW7n93wDafb/qbcDTl2l6
	FBULkX1i0X6ppIFG5gr1Tcqyw64ZyERmI6wBAzSXwvaKNuwOg/MWbZQkt0THGww+FXxBId2upAW
	7smje+EVRjvUEt7YNCZDEYveVOy9yBw8Zf828vsyGpW0huEUb/nlmMf/ysS9iH8Fl1VrN1nUFms
	B8aGYE/StV0uDSPBNkmiPMzM8VtO46WGpE6XeGdYwQ/X6C7M9etVK1ai+xPL/HnDrz+1kv13U6X
	JmG1+mjQlclOmqogHnckV8YaR74FUR8pLYg8g9J1r9OsEdkiaCVBRCWEoFxG0avdBTbfO8G/k5+
	OHKcb3DWN3oz4PyphuArDwG45LwckygNMrEXOx+AqQLnF7BnLef7JOpwvw2gCeJdWifQppP26kj
	Efalz55pXBVLJ2IOoU+hbXj9BrFpblU8c2oFXF85DM+Z1YfFseM2gu6QBr9bFt488EVI/e5ey0r
	AnrHc94k4AFjAUsOZiglwSG96vyYtoq64Ura1etUudcdpO5S8FlvEEi0ojfXBmS6XcaOw==
X-Received: by 2002:a2e:b8cb:0:b0:3a7:8294:caac with SMTP id 38308e7fff4ca-3a97d7e9d13mr1971021fa.3.1791054679482;
        Sat, 03 Oct 2026 12:11:19 -0700 (PDT)
Received: from yantra.. (dsl-trebng21-58c187-236.dhcp.inet.fi. [88.193.135.236])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a87e2f826dsm23626371fa.8.2026.10.03.12.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 12:11:19 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
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
Subject: Re: [PATCH v11 5/5] iio: pressure: dps310: assert the lock at runtime too
Date: Sat,  3 Oct 2026 22:09:26 +0300
Message-ID: <20261003191058.35287-1-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ar9j0O7DdJ7O1DVk@ashevche-desk.local>
References: <20261002072526.250081-1-zoone.rupert@gmail.com> <20261002072526.250081-6-zoone.rupert@gmail.com> <ar9j0O7DdJ7O1DVk@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Oct 02, 2026 at 10:57:04AM +0300, Andy Shevchenko wrote:
> On Fri, Oct 02, 2026 at 10:25:26AM +0300, Rupesh Majhi wrote:
> > __must_hold() is clang only and does nothing in GCC builds. Add
> > lockdep_assert_held() next to each, so lockdep catches a missing lock
> > too.
>
> Suggested-by?

On v10 you said it wasn't really your suggestion, so I dropped it.
Happy to add it back if you prefer.

> But we need to hear from Jonathan and others if they like these annotations in
> a mere IIO driver.

Agreed. It stays the last patch in v12, so it can be dropped on its own.
