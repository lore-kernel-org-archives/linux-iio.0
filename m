Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569BF366542
	for <linux-iio@vger.kernel.org>; Fri, 20 Feb 2026 19:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771615747; cv=none; b=KUDT5gEmzPYcgt3WlPo0ggf2SxnzCR/kPjhb7jWTkXFSDkgSEjZ+CzEM+CKLiWyCXIB6WycsKE2ZrV8j79ot9kwx9cgfHMv6Ez37PQbFwUTURF139ninLnV7DwLHFBR7iuGrzEj7wzbjMmbLYh94bX4G9KYpU8Y3+wGjHaCXxlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771615747; c=relaxed/simple;
	bh=ndBy/UTl8yqLz2FYSmSDbHs5J3U/slvt6uXC0nIf+aE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UAiGqY8WFr/FpyoyYtfZRYACqv9bgn8BJZ+biz/yUTkHITyPc1jbi9SC5ERDKF733AJs7VRjyW5VZRGQprYWTs7IxW/wFxUQgHZWQq208lNU/OvC6fVWUQvnGnuM2IiAXPWadZ8lsIsMe8zP9dev5nGndtjcCzvPz8TgHOWUFTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kLcsMzso; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLcsMzso"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8cb7edbcde6so205324985a.3
        for <linux-iio@vger.kernel.org>; Fri, 20 Feb 2026 11:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771615745; x=1772220545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ndBy/UTl8yqLz2FYSmSDbHs5J3U/slvt6uXC0nIf+aE=;
        b=kLcsMzsokRJDVoF7f9BR5AUB98vaHDPawErYrEf5rCkLVvRj6HdNuXuUnSw2zb6aqj
         5a5B5nOekvgVVzWrgxYICEuu1/C87IY7SPzsJNVrP2mZk7pY0b11G9Ux5dtZ9XZPi0GO
         JSqineIp8lHcLTsgOj4n0aQfvBuBtHSaXc4IDUGDm3tsyY5YMesu4TqtULx0jMRP51Mr
         aSo2FMh5hgd7qbM453+ezeyZxBejm2IMictnS5oKx1GitURiRuPSmtVhFEr9fySijzU6
         Fri2sWpGc6ftk4B+I1f6RazvIftheeqL0meSx4LKR1vTCNjQZBn4eqGyfBrePmfPKMti
         fi9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771615745; x=1772220545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ndBy/UTl8yqLz2FYSmSDbHs5J3U/slvt6uXC0nIf+aE=;
        b=SVMKrXIridL7knqOrbdp0CMpO+IAOFVATLpovUeMNBWJpVRlNZuAxkLHKWJ6i9aPzQ
         CRKk8chPMwcDsM3WY4nP+SzODsuHUPljqE+dNMWJ0CaobPV5WbyPAFtKAJQrGbPv8TQ4
         ZVCxt1VuHfvdVn9lnrbuWNtJZSNM7UR1SydDQiLCej7BHlPIVsT3XCO+gL6k+pb322yG
         teci5b8Zn1jyIwR88uIbSDHprceSrkzGzhEJjzHF7fr4NjBxrurJj6VacW7CwL7WItG8
         Twm8z14nZlc4bg+TK7HQsC6v14lxdhScTU1/TIWyneIqtb+4eik1LN9GTO70BHxug0ai
         NpdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBTlz5D4vryC7bcb498S+DEiAwIRxsSSfgu3tRSbj+NfdRtI/uk18CC79fbIOE1la9KfmpjuvTUaM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo9NjqPE0aiJg3/CAyqpQGtzuVKDqWeHaLYdjmtAg0RVC/CSx7
	G6Gxr65DHuMJ0HMAe8qBhXAOP7IXNLKt+Uw4eIlZcglC9KbCTeFHNK0+HJaROA==
X-Gm-Gg: AZuq6aJoWKmYWpB1FJKDvNgvgdaDbqOm9qtQKqBSlZAYDNqFVc042xVNOdIZTu1f+cV
	CnubD0TMuNqfWyK4e5E0L9Km8K5ifAoCvvTDH+vUJcI8G4aUmtA1t2QQ8Nt0hVgmubWOPVnJRYy
	v7w6tkaRQJkWt5UCWsI6fIaEoF023dXihJkM1jDCr4k0keu96w+ki1xOpXQesLcMt1WsB+supAN
	ZaNnVex/5toJfZi0dNcJ++0bfTOJT2i7VeUM3BABip1XdmYPFqN8KuNoGCnGT5LD4wlD38F1aOa
	AZ9l+QUcWsVz8KfhMJC5B6PIvmKJaO0pbhEiMg/vRj0pr+ukTlhb0is0ZcdW3//picXo86bLt3c
	hLUz9jYVJPfiOFgKr9rNMuMTSiiSGyRitKrC9IuDwGRtIFocIntJRyBSxHBhAyLGM330d7hKHe8
	D+wgwqYAk1ZNs8Mis2UlY6/JHCtmlAy0E5ljX25Tx3osZd4de3CL2dUcqpacoFf9w6twVfKE5MY
	3y55cNLhWBghbrpLyiFXQ==
X-Received: by 2002:a05:620a:25ce:b0:89e:b0bd:ced9 with SMTP id af79cd13be357-8cb8ca67641mr80753985a.43.1771615745126;
        Fri, 20 Feb 2026 11:29:05 -0800 (PST)
Received: from Mac.home (bras-base-ktnron0818w-grc-05-142-198-109-43.dsl.bell.ca. [142.198.109.43])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d0729a3sm23068785a.22.2026.02.20.11.29.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 20 Feb 2026 11:29:04 -0800 (PST)
From: Neel Bullywon <neelb2403@gmail.com>
To: jic23@kernel.org
Cc: andriy.shevchenko@intel.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/3] iio: magnetometer: bmc150_magn: use automated cleanup for mutex
Date: Fri, 20 Feb 2026 14:29:00 -0500
Message-ID: <20260220192900.79326-1-neelb2403@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260220103429.22c9eeca@jic23-huawei>
References: <20260220103429.22c9eeca@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I don't have the BMC150 hardware unfortunately, so I can't test runtime PM behavior changes directly.

For the v8 of patch 1, I see two approaches based on the feedback given:

Andy's suggestion: add a bmc150_magn_set_power_mode_locked() helper to deduplicate the lock+call pattern in remove, runtime_suspend, suspend, and resume.
Your suggestion: move the guard() unconditionally into bmc150_magn_set_power_mode() itself, which is cleaner but touches the runtime PM locking that you flagged as suspicious.
Given I can't test runtime PM, would you prefer I go with Andy's suggestion for now, and leave the deeper runtime PM cleanup for a separate series if someone with hardware can verify it?

Or if you'd rather I take a shot at yours with the read_raw() rework you described, I'm happy to do that — just would need someone to test it.
