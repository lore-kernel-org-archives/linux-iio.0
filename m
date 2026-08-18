Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500B035959
	for <linux-iio@vger.kernel.org>; Tue, 18 Aug 2026 15:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787067701; cv=none; b=cDK8iAgoMazK5PruDsuYnc61BzesWWIFevZFl4dGlD1Ixsuq13LX0CjmeWI3G20YM1c+gVDz2iWvIQKao84+sZ/crFx285hIahvBXDwKD0SrJMOrRzUPLyeoToGhf/BQv9CadyISLmQJqgDqwHQphtQMldQdtOxU8hplZwvJBt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787067701; c=relaxed/simple;
	bh=eDFzL+tYtYMYYZGsZcDZMDCJSCuvu2IeifwfVInrCQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JFUuZgcY/NAeFTVWY9TU0pQ3KNX7vtrvjqY2ceN3TBEy3XcXTl7lRmPeSJNC1sCf2+ItUAkgSFPxx/bcHKj70J2lsRdCzOATPR03SnAl7zepErIMiz55OFwh3Bjn9AbhqebJ2CPWQvGXkjwX4dnse6en+R76fQ82qyVqGj7JIOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b4qVpyTr; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4qVpyTr"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4998590d392so49820235e9.0
        for <linux-iio@vger.kernel.org>; Tue, 18 Aug 2026 08:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787067698; x=1787672498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eDFzL+tYtYMYYZGsZcDZMDCJSCuvu2IeifwfVInrCQc=;
        b=b4qVpyTrnPL3gGNf7HT//GTcirMXv3b9CTB5uIPdevdQMALwi4rPfXU4U9kqwDByU9
         0Ob7Uz7TBEY9e4y+89aRaqODd74qIaYhI++NEKkYCvVXFWTrbd6uuc+l5RvB9bbPs8p9
         HzFj9arHQchrYYzBYZ1vd8QTavDbu6ZrX6kQkqmPCyEYqTldHCVNCUPouvyrTX7XldhE
         dVN31qOiekzH10N8BNXRIt0pX33BLzgs4e9Xi80k9riifj7/Y8xvUC0Ab8xU846l8qB/
         hyFDGBpvm7YyA5SWgbrSLRS09jSl6z8sry++3q/6mbHVvZFK42k6q9eeYWp50TxGwOeJ
         17Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787067698; x=1787672498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eDFzL+tYtYMYYZGsZcDZMDCJSCuvu2IeifwfVInrCQc=;
        b=GSll4aa0WGqHexTZJ/ScKVgWwFhRgs3s9HZXIGj4rnGE1AYGZaQqgTyAKvt1hRIpx2
         QlpqA9sN3N3BZCDDDSD8K8GA8qN2glorV36kn4NT89bbp+6ul87aHz4hU9E5hUWVM3oX
         ZeibYvRofRax4zoJsH60xUY2FzlFl0kZd75rxZ+YReKtira9uVEVTRt91oop80nGg1OE
         4iJzggAGWoPz8SkD4mRnp2VuDrY0pS+Ws/uvqt+DpEvLoqaXLHZtw0sjOBtZU9f+qO5d
         v0dsfFKApHRIeLhaYvmqcEwqAHS52JFybFmILm+IkCBfAqbb592yXoj99g5ThRiZ6p1q
         jpxA==
X-Forwarded-Encrypted: i=1; AHgh+RqVw6tweSRMHvBezmo/kjnH8GAMMb8E8uCp6b2koAhoOjepDNgxQYBzuxCNqoBqXjtblHaZj4ZSAAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHMLCoB5mLZKsyiH3yI0QbEcEdv8rkU2l8/HZkSOQtHMKbr7aA
	3EG/Zc/W8mLM/hwvHJfBucW5PBAFaPd0llnAkLhY0S840k4e2501hLbA
X-Gm-Gg: AR+sD12nLLcmX+1HjRSxYs6aNQbeAiHnBLMvPpGVKvbF+FtYreUnRrIdb51sdZjHTlc
	sAhmmOoz7ijU6bCQQsslNXTN9efwrsXKW2zKKyqOj4YOzU2fChpg0P/cZOXL89dPlg5n8e6j9wk
	IxUuEaXUpVZzUz6gLdunQ1SJlFDuvXWgpH+oLhklA4OHHrU0hVyaVHB19HK44e2nWJoP/VjJ43+
	jJv7nbVGgAWYgND/vZ5VfGy3NOFNW4dPdalyAO8CGffHkzZosyM5yTZ6UB0AbMt+1z9w6n4Fwfs
	AXHtGhI+9wCO0pgp3a6K8/bPUZ2EVSZed9KeLIsz0v3MfgQlAymkWhdxYGINf6cJy7vYGb/sGsm
	QgG6bMZ14ZtTlzI9TeBrVfCJnMFpWue/S8xkcxLyjC8gXFX0mZhQJAJ1K/GbrOhN63/QwB/H4iT
	CJ2R2TF4EoytEWvo8nR8QKpRYpYf2UBXs74r0KKJBEQWHTt6twCiQZCJbRCsG3gntimH5O2xtye
	5HqSv7rnOOIMS3RdgK0uSpttDWR2A/V63dZi13jojG4
X-Received: by 2002:a05:600c:1d0c:b0:493:f140:c3fb with SMTP id 5b1f17b1804b1-4999fb3953emr157757745e9.7.1787067698131;
        Tue, 18 Aug 2026 08:41:38 -0700 (PDT)
Received: from MacBookPro ([2001:8a0:6c97:6700:51db:1c3:6be8:694c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49996188217sm576560375e9.13.2026.08.18.08.41.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 18 Aug 2026 08:41:37 -0700 (PDT)
From: Gabriel Rondon <grondon@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	andy@kernel.org,
	David Lechner <dlechner@baylibre.com>,
	"Nuno =?utf-8?q?S=C3=A1?=" <nuno.sa@analog.com>,
	Stepan Ionichev <sozdayvek@gmail.com>,
	Maxwell Doose <m32285159@gmail.com>,
	Yash Suthar <yashsuthar983@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] iio: accel: bmc150: use guard(mutex) for mutex handling
Date: Tue, 18 Aug 2026 16:41:35 +0100
Message-ID: <20260818154135.3324-1-grondon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <aoMrJvd4oSj0HgN4@ashevche-desk.local>
References: 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Aug 17, 2026 at 06:39:18PM +0300, Andy Shevchenko wrote:
> Not directly related to this change, but even in the original code what is
> protected here by the mutex? data->scan.channels?

Agreed it is out of scope for this cleanup, so I left the scope unchanged.

Honest answer: not much that is obvious. data->scan.channels does not need
it, since the triggered handler is the only writer and the core serializes
it. The accel one-shot read is already gated with -EBUSY while buffering, so
bmc150_accel_get_axis cannot race the handler. What is left sharing
data->mutex and still reachable during capture is the temperature read, the
bandwidth get/set and scale set, and the event config. But since the handler
is a single regmap_bulk_read and regmap already serializes the bus, it is not
clear the driver mutex guards a real invariant here, and it may well be
vestigial.

Dropping it is a behavioral change worth its own patch and testing rather
than something to fold into a lock-syntax cleanup. Happy to look into that
separately.

Thanks,
Gabriel
