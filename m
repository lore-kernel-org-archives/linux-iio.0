Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852E641B361
	for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 12:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777380411; cv=none; b=Tv4t1DSJXPvcF2FNNGXkW5+cnYbP0v6faFhMQWSMiuuBcrcBCGeOoMuh9XaUZ0rAi4xhzob+h+GfSsZpmcblePrPIoKjO5LIcK1YdAiA1w4xxnPyhKz8MjniVgmhfhVgU5NAigh0cJOPf1SEOrKZ0I5xxZz9OP+BimYZdVYWny0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777380411; c=relaxed/simple;
	bh=qXWvLFrVuKWOBW2pcZQhwtDbG9cDzAI52pDnhk2glsE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K83/BVpIJC6u9KS1FkFbWFFrtZ3VnMwtO2IY/0sap2sIfjMI/+iaXe7qryF/7H0KFt52Mp+kfFoTx2dIVR/NAT9mTHg8rtMmi7yrUG2Y39YAM1+/IWclHNh6czquLO6TvegenLKYnfAQ/2WFwfXYruW/Pc2BHTQ1JXwGdNpa/iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oFcACVPF; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oFcACVPF"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-479ef2b7979so5275616b6e.3
        for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 05:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777380407; x=1777985207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ToBwHoXJwZlCxVtdIewDU7S2LH8f7E9EYRhrN9/3Z4c=;
        b=oFcACVPFgIO9hnRAym+C4DBl3TyL1Xt5HJjKpxm9ephqfCq6qRjdPnrHgw++1cm2ZP
         NwfvRlsOr+yS1+gxZysH/t0MoESGelfqo8z8iGBliI1RiHG9CWTFpeJSqP+0vDlMzY/g
         XYImc4jiESuZkChCwDm9putF8PHUAqC3C2T8WCwmSHIYvOBlodIECPm2x8X94VXZihKs
         eRBmvh9qDAUFUE5UsIK3IsdOgst8tPpoE9U3Vs+7QCqGqa4Tq6uWe22XPf2HwmLrYxKw
         GnQP5sIxxWiv/IhYxz2Kh9SaO676tPMfey4jiC3HKQbz0rmg9HQHicT34uuMQJGsIt0r
         Tf/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777380407; x=1777985207;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ToBwHoXJwZlCxVtdIewDU7S2LH8f7E9EYRhrN9/3Z4c=;
        b=K4zLD3od6lFOeohqU/B8uJ0Oqlx78MDDxABLREKaK5cOIZ2YVYsqxLuwTdXpLtaI43
         Rt8JBsmdkrO7mDdiIwMALGSYM6SLao1SDgduLJjWWdsDQ9ROETrBYnMmfYJQKRTXS8A0
         Ld6C70j4cvjyBRRJmVY9yv2ExE0VcCQB6N5YIygsfy0TZv6uyWcp8JAOAfdqzUxobuis
         JRo/2leNA1sfjRo/T8uZoATAMIkSN2luwBt/I0fGnL8YjhkwQqJCjtEyIwU9+z6LISGZ
         o5egVqlcMR2ge/rgW9wsquU9ThMPcWsqDmjPzIdja5u3x7+XwqdP4WXSqgxdaH1A0L0R
         26Ag==
X-Forwarded-Encrypted: i=1; AFNElJ+XrUWK9GLJ+AZesWuvMpTOGkSHTvajex+MOTu10Dp8t9BTPVEkwHGNkYzNJHB1OW6LU+6bZlyOGPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD5yKW6LtHOXyxBYC7+VuciKuCPNt6etXiBq96iahh5k7lnpk1
	5wphzmjQ4YIRINv8c0vWxg+GhtcEGhHwZkc9A5iLKwmRx3yk0RKxWfps
X-Gm-Gg: AeBDiesHY04PdfMX93zC2MdKui2eZfqbeD2VEL2KOZ8rvIY2z1AAs7ITRAPzw6tm7bX
	yWB2hEM+6XyDA3oUaY+Dfm2dv6Y8R/vbxyMENjGOPV711j7RoMmaxKZ0AItJYpR3XIcmJNVDM7w
	Ez8dbCmYLMOx2eDTDlkpN+o1HSrlKz5EesEIEJAsk/kbC5RtkwCz36Gr+bRca5DljFn9TUZp45m
	RVdbtqSPSpdD0levrW6kFBDHc6KZ7/nIPbyMYitGq4gPsPOWBslb0yog3G1f5S/uESWNAhySEly
	neRL3PRkhY2qnuR9nFBnFWiWN8cj7Gk3PZjal0GzvpLf+Q0cWjIzIG93v+5tm9j/247Wvw2XAe0
	ISsgCZwJuNPtLEoakXp9dIOGsDxA+XRpt+fFS98eG7YoR3ue0GJpJWOLtnJwiOYeJI980Xx1DuZ
	P9h1w7wjWyNg/Ij/gAGSQtZ8pYW0Q4mRdgqklBBO8TttsUbus9IpdNeygqmD7KURUdSjTLRtoGp
	9v30pg=
X-Received: by 2002:a05:6808:4fe0:b0:475:be6f:aa with SMTP id 5614622812f47-47c28e8701emr1487727b6e.19.1777380406655;
        Tue, 28 Apr 2026 05:46:46 -0700 (PDT)
Received: from linuxescape.lan (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7de986a5601sm1683041a34.19.2026.04.28.05.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 05:46:46 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: songqiang1304521@gmail.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] iio: magnetometer: rm3100: Modernize locking and control flow
Date: Tue, 28 Apr 2026 07:46:40 -0500
Message-ID: <20260428124644.49707-1-m32285159@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The goal of this patch series is to replace the manual mutex_lock() and
mutex_unlock() calls in rm3100-core.c with their more modern
counterparts, guard(mutex)() and scoped_guard(). I've also done some
minor cleanups, removing what are now redundant gotos, and enabling
direct returns.

Following feedback on recent commits, I've learned that it's a better
idea to split changes to be more atomic, and I've done that here in
case any particular change *somehow* causes a build regression. The
changes have been test-compiled however, and according to make, smatch,
and sparse, should be sound.

=== Changelog ===
v2:
 - Added small style fixes per Andy's suggestions (Adding blank lines,
   moving an if statement in a scoped_guard block).
 - Switched out scoped_guard() for guard(mutex)() in certain commits.
 - Fixed error in commit 4 where deadlocks could occur, as goto ignores
   __attribute__((cleanup)). This has been fixed by the above.

Maxwell Doose (4):
  iio: magnetometer: rm3100: Use guard(mutex)() in rm3100_read_mag()
  iio: magnetometer: rm3100: Use scoped_guard() in
    rm3100_get_samp_freq()
  iio: magnetometer: rm3100: Use guard(mutex)() in
    rm3100_set_samp_freq()
  iio: magnetometer: rm3100: Use guard(mutex)() in
    rm3100_trigger_handler()

 drivers/iio/magnetometer/rm3100-core.c | 63 ++++++++++----------------
 1 file changed, 24 insertions(+), 39 deletions(-)

-- 
2.53.0

