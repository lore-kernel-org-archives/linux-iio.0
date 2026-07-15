Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E3343C04C
	for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 10:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784110256; cv=none; b=JtFNzxLZTTlO62qLmawx45GzlArn3tb+n/JB2SyXIKMrnj9jN6YJt0PBtpDo861rsIWIgm+ZhIdWRELu9Vbu0FGBbNttcMiyJOTvN3yr+e77q5e9DfGfB8tnjphTaoE+DGYwsIR9KuUa/9NocJHZrNqJz6QV5WkayWN3sdAEkcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784110256; c=relaxed/simple;
	bh=JfYz53bJftYARTtQYbhdqLN88JZ2JOJLHjD7XhU/M28=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=krHuNqe4kYrlKidP1wCYcJDYeuu6US4cBh6N9xTVX3Tp0ZRK9Z2BDMopl0m8pUyIoTmkwy3U+7We7oqPguAys0JMmiCsLveFKhJ8CePHhMijV+BSULeEJeyTrfqLE5Y4gfYYWehUXmahp2Bt9d3yix1JW5zHhlvw9bsLQr7oZok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gsgTIL4z; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsgTIL4z"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38e041ea211so2601080a91.0
        for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 03:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784110254; x=1784715054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qXsDMJk4sPduicJj2EHttKleB6YVypYjBplsn4iN7vc=;
        b=gsgTIL4zwpApVfT6HCU0JKqVU+0QY8d0qYYGeA200W+gN5NfyuMbVYbjufWuo9RSZ3
         tvP4CmCzTTsNb/GPxtOaeN+58CyR67kaic9bNgmg08SQnAGD9QYp5ykCfdCj1+MbIhC6
         zKO3T9NA8XjWelrKKgYIfQa6CP+BGFRl756o/E3fZoOFvP+NnoXce4QZtgKN+WQLPDOk
         bmpuksMkd1r5abRUNs1K+zN8NTRrYiMFxB7syV4VR9Zf9qOysrRiyg/Yy0tUEIWnEl7i
         zu8PZyjKEb+32vvku+L6YlPSi1ovc7J92vXGb1qn1qUrNNLdfd0xR+CIYTRPq2UnnyrN
         29/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784110254; x=1784715054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qXsDMJk4sPduicJj2EHttKleB6YVypYjBplsn4iN7vc=;
        b=VMn7hgE/8q0dj7lJlYPMJ419B41Qqbs61k0B9acvXGFZ+t7PvYZ4aMcLtUtGqFR7Hc
         0m0caMhnRVB4ke/RdI5Va8wdmh8fH+/bk62vtZdJkes4+D7czQps3aoQqSNrAhZeDzhk
         yve7CeFbOd04pcOiig+drT3ZU+r7lvVfMzXEk6OYqL4SZazqodmGsMO/VdvkFTUB0k+l
         m+lqnqxEGQ2v0yTne9ZkQIDTHzcxlTmRdrL9sy+x8JwpU1qfG9XbbtZI//P0BMhzcwxf
         Ts0kiRxNclp/a359KJ78LTsQy5h2kEhH6N7FmdTRks2yNit2oSia85MihSxOGHmi3kK/
         HDzw==
X-Forwarded-Encrypted: i=1; AHgh+Rq6L9SWp/m0w3X5oz5wxVSqyjEZm9SbrhDADxFKxw9gHZtdM05s0ZQHZo7WATXJvb62qDe2YGnARxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLmagx4fTJJgW+Lb++/F76J3aJNsqH7qjnwBKcnc56kLz1+J/3
	GzD1PsRInmryJPhraXjIgUv97th6CAD3f+SaMy5TdPUTN4PWCbQbqWRK
X-Gm-Gg: AfdE7ckJIwjaFt9LzRqXCsp/GGrk9cwtkGY/QwjHbaQjNqniHNomS6+u7y7ocDjr1Mw
	a69FPshT14GyqWu5YwLrHNbHyNqv82aCw0SA5LNcTKMXwZjhBo+qIRszxGNKY/tvXoJCYkqfKFk
	vIDMaxDeRonwJ2en3iEzF0fAh/o7kVlsjw+kLOP8YUGcDRp1oo/0fgK+cT0/3OppYRpVQ2qhuyh
	QngzmzNNU2GnY6akhjkJnQluSVfe9aM5A39WWUG8hM9hvS9lMxLNfK8drQKjLWj1cyxbevqET3Y
	i5X/JBC9QAAAty2uQNC08vw9qFLG4eKg7Bx2b7CslkLmag4ozPnqhn41rax8GsFnmB9jeRqYy8m
	tIgkdpU9hJstK7fyNxkaNN+EzK7cHQrCfA56qrk81MVnavuoQ9HXKOfT7INKkTR6cgGjoYXo6Fq
	eez/sW9ZMFHjXGOSAuj166t8mYUJqbxNRPdjoVcYTU
X-Received: by 2002:a17:90b:2544:b0:38e:408:9d7d with SMTP id 98e67ed59e1d1-38e1af44e01mr6101942a91.36.1784110253968;
        Wed, 15 Jul 2026 03:10:53 -0700 (PDT)
Received: from primary ([223.181.23.34])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3119c2a7bb5sm62079757eec.25.2026.07.15.03.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 03:10:53 -0700 (PDT)
From: Vidhu Sarwal <vidhu.linux@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Per-Daniel Olsson <perdaniel.olsson@axis.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	Vidhu Sarwal <vidhu.linux@gmail.com>
Subject: [PATCH 0/3] iio: light: opt4060: Fix integration time, pointer type and error message
Date: Wed, 15 Jul 2026 06:45:41 +0530
Message-ID: <20260715011544.281148-1-vidhu.linux@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes three issues in the opt4060 driver, all of which have
been present since the driver was introduced.

Patch 1 rejects integration time writes with a non-zero seconds part.
Previously, opt4060_write_raw() only considered the microseconds
component, so values such as 1.000600 were accepted and programmed as
600 us.

Patch 2 fixes a pointer type mismatch in the call to
div_u64_rem(). This is a type cleanliness fix and does not change
runtime behaviour.

Patch 3 corrects a error in an error message that reported the
wrong threshold register when a register read failed.

The first 2 patches are similar to recently submitted patches on
it's sister driver OPT4001 [1]. 

Patch 3 is specific to opt4060.

[1]: https://lore.kernel.org/all/20260714113134.3445-1-nikhilgtr@gmail.com/

Vidhu Sarwal (3):
  iio: light: opt4060: Reject integration times with a non-zero seconds
    part
  iio: light: opt4060: Fix pointer type passed to div_u64_rem()
  iio: light: opt4060: Fix incorrect register name in threshold read
    error message

 drivers/iio/light/opt4060.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)


base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
-- 
2.53.0

