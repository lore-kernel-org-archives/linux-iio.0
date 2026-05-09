Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C283BD642
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 18:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778352819; cv=none; b=EdaQDcwTI5I9vC8USIZ65FVedPzEkF69u/T1szkRz9w5IM7uwKm/0klMMKGHrk79Hv2cOXqSWF58XoHYE3yRGS+Z/nUyEYaC8rSsdBCcTYxJr4WZU7xDaD4D4G5VKM43xXVqbdaRrB4u7SOfHDIRCzxqvCEB6BPIIiF/sg+QJzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778352819; c=relaxed/simple;
	bh=J2AlLJ0QlgO4HrNQwdah9DkLbK36ByYCwnV9a6bPYSA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h5JSaCQOnjL+1GFHiTk79P5b4jLyanNTNl+DiAlO+MlV0rkHhmLejTSnSUOJ2ytguryeY4iwF/5TBC2Idnf3no97DrvgH6+49R2Mbv/kwVbzeCjGS2n+dAVlEbyF60w7Fig+gHL6sxHS8MT668SfkdTPSTBrcDtayDH2hGVzsVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Giiaccyg; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Giiaccyg"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48e69e60063so1126715e9.1
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 11:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778352816; x=1778957616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J2AlLJ0QlgO4HrNQwdah9DkLbK36ByYCwnV9a6bPYSA=;
        b=GiiaccygNXd8QNwlAEeQKTh2IHZRH4MChaRQxn9tPmpwRT8oyv3bX4FokREckJB564
         T+BzAHbDZirtpOb/6juNRMt5ncUnUjBPVihGCcbpBY9Uq//w/QQ/jrU75QYVaLOir/L/
         ZdEqk5ENgVLiPwysWkKizGgh/gNLGyvacN0W9Kon9jncdZjbOO6WIKJ8UIGd7F/GOzgL
         e1ZdLUdwAqf+tBckGWo3XxO/rHsMlBKZhLhf5vf+aKPA05mjqGMqOLloQokTuixsu7hI
         SJDOhoiKRcNd971I6SfbL0KOj5rtTnMrnkbiOBSUIpjx4qEEyIpgF6oYCkGZkHDF/uur
         QeVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778352816; x=1778957616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J2AlLJ0QlgO4HrNQwdah9DkLbK36ByYCwnV9a6bPYSA=;
        b=byLp9q+9YYY2Ey0zJUWtE73def0++eybAHI7AiLJ66LxvQT5zzfz5tgO8b+AjtGFIm
         h8JLvaOseGeu/fZUgfffbO1CQbKCxLLKe5oica3oX/kLwH5QZSb0sm25ooMWJICM5tAn
         T+bCin/y5eS0Tg8+HD05jryL0DzRXOINYYzgjtwhIWV52iwfEWoYPu3wub/wuEIYlvw7
         up9I4wIOFwmzSYRAWK1eUDUtzcJ+3Kz/i6p7oR41Tt6a3qDB8XuzOaop81OYoJnXkVqf
         D8mwObx4YgkQph6TK96FHcFTpd/E6hqlLo6zMygCELxXzYo4mc/7dXYuXrvFvpPX0adz
         LJrA==
X-Forwarded-Encrypted: i=1; AFNElJ9hn4e+sKuuDI8ITMvv83eXNOcci8LHghw1QDgQOWvN1NL75np3fNZ/kPwLp19UFfYPGcOaGamKPic=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdpEYmXtzkQYjGpvYv6cA8Ka740THOrDOgl8oe7p9Zte/xQOwa
	0MaWvezthPfIHYOGK3UPa3mLX3bLgklBv26ergxeUKiExYe6dPLSz8pE
X-Gm-Gg: Acq92OGjjm4ecButcXHlDB6IYcjH6dMS2TmslCqYzSGvx8CA+9p2P8fe10VMugBAXvm
	iM5YRDGV2mHyQ+lCpi5ZlQkLVzCSatZxbnRiJoZnO7WW7mAfpaQzzvjXc44cmiRSEvBI3KUvxt6
	pKZmptSGt5m9kQpLK7FKGtiuBdiiPcj6Lr2jdGdZGB4/60N0qLuwqMTwWwuuEKahBeivde8C5ej
	lvrbupgEvRMHxfsneHzc7fu7xi8PlZnZbtv5rmxw+Hrf2GG11djEW8mZ/EZgs+NcYwUzz3oXx+g
	k1+jvqClKhNdMf2euEqMCiWApOT5jBO/CH+u5d0y2k5UOo326N/0wL45QutJoC/NIcqLhEu4DtM
	Kal1oXTXUl0pCa3B3q51JlQ8C6JNok7MPyCxz8tEbK5agW9dKwUuNDb8P9REUS6zosToLIEjfSm
	EffAIX7n0YEOIAmnY/ENpZAjlRgAPkrqBQK4hEGgD53J26
X-Received: by 2002:a05:600c:a0b:b0:48a:5391:8424 with SMTP id 5b1f17b1804b1-48e532a4dfamr128155175e9.6.1778352816405;
        Sat, 09 May 2026 11:53:36 -0700 (PDT)
Received: from localhost.localdomain ([82.215.118.79])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e702ec426sm63338185e9.10.2026.05.09.11.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 11:53:36 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: shofiqtest@gmail.com
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sozdayvek@gmail.com
Subject: Re: [PATCH v4 1/3] iio: adc: ti-ads1298: Add parentheses around macro parameter
Date: Sat,  9 May 2026 16:38:09 +0500
Message-Id: <20260509113809.26224-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20260509151959.3475-2-shofiqtest@gmail.com>
References: <20260509151959.3475-2-shofiqtest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current call sites all pass plain identifiers (chan_index,
channel, i), so this is a preventive hardening rather than a bug
fix, but wrapping macro arguments matches the kernel macro style
recommended by checkpatch and avoids surprises for future callers
that pass an expression.

Reviewed-by: Stepan Ionichev <sozdayvek@gmail.com>

Stepan
