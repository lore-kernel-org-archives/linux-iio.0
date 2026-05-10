Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6867B35AC3F
	for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 08:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778401252; cv=none; b=R1gS7ogVQyjVFuaBACG+a8DOwL2LM97zz9k61Cvqo6eWpJSJerlSocqP436/5ke0nm2Fy7oRffwyAl8ZKCJE/ilJ/xny0U38JSpTlw7DRN23i0QWpygJu7uYOM34txofdvQcKpw2vA+DPd6wME91GE+bPM554gyQH7DoIUdSnrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778401252; c=relaxed/simple;
	bh=OJuhrgxX6cfEWdgdu3hC8oA5PsueyjbFhsX17s+WXSA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fIQ8KH1S8OgdyCMtx4tffAh4YuLljbMC3KfqdUDUsczOMxc8GxjskuLvMI9oSODygbOpUdAjUh7TDeLLVLFsl99yTOWZm3/D9jVHOiV7kN2AnsDPOCQ/QfPPOkaIvNALiVp5wNXtfCbcJdywq8q5xpwVXXy5cDInIhujXTDn9og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HxaL70PZ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxaL70PZ"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48962cd0864so2612335e9.1
        for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 01:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778401250; x=1779006050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJuhrgxX6cfEWdgdu3hC8oA5PsueyjbFhsX17s+WXSA=;
        b=HxaL70PZLcPioLgsYrXv5DHA6mM54sQWld0g0NKCC/Lw7K3rglOyzdMli/fRH0kelm
         NbyKi4em5uVEENEZj7GjrFMJO/t5GABBTvjbttPfsjP5FtBuYqQouHu7KSs7t1nyJc50
         7qqSLDWL3El9MPKhw3kTp1u+7EWemgm1ZeB7WNcNaxkfySY03bPeAaLkMJntSlfP3eJz
         WLGiGHK5bhFt6wO1F4+Omoecvcioa2vTR4lTKCBAUcT9yVuT+HtKvUQpM3s0AuYIMJju
         lM5y1bmlabP0d1ULRk6sFofzAsk5eGgrw5eD06RZt5NAs/MTaPGKxyFZrIe2aK2T3IZs
         z23A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778401250; x=1779006050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OJuhrgxX6cfEWdgdu3hC8oA5PsueyjbFhsX17s+WXSA=;
        b=rhF9Zsrnq4Qi7vsIP7Z3YxO3zDKTp+Hpcg/5XNOzA8J/NVJj0qbHVErpaY/0CV+wMV
         hcVex6lo/MPgUyZ5s4tB4j+pc2QVKIIeNhaRd/VpgTESxZG6MCSTKKrD0HLYAJLOKYvQ
         zwJYYzBkEGXov+VJpf9irJNg2tRr8SltULv4AqrlE05wvGjuQGKv9c9ym5lzbEY/szsj
         RR8Z4Yr1kiB0+WvcGKf8vMMZzURjnNsXx+54Nac63NGkNlDArysbatF9qAvFgyCi9SH0
         AwGRxGcRXN9pnW/elfRaU/BVnw1fQxYjOpMd64DbiaIpswy972XpZfnmubNrXpG6zwJB
         5eRw==
X-Forwarded-Encrypted: i=1; AFNElJ9MoW0hRd2u38fD8lCvLPh/l1xtb1TtrY6mhbQcJmvI9sypeM3nj9o8ADDkLqJLlb+mZWgOg8bjnW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQhQrJLEaA1ebiAMf8WhAaePMMmSNcqu2u8RmFCL3+czXrYvKX
	7TQ+kdjYvp3RRXqSko4SNuQHh3qPqEDJxK9faSwo5rLwYKeXzCLGQz59
X-Gm-Gg: Acq92OECGpKgzY367lepxb4wnCvLw++UMKRyAUWvs5VHZilNNbI8t4tpphDAyku9rsv
	bkJ3m688UwZ52KYDvhz/oUY5yTjrS+BIvbJF40ZIuE89H8RBzNpp4IwSVLRFtfdFo8VaWBsVuhU
	Tc1gC5HS/QfZKF2Dl2BIVLExAPxtz4ob1Ay1L9BXgnHIhb/cbXnr2GPM6GbBxXBV0Po8B4Gsun5
	nav7CVkPz9uf2qn34O6cKOCS1w0xUgzkUEdxmja7HGMADepiptzIj5iwCMqfEilOXS1ZHK2PtqB
	qAvLREryA58FHTCHx0PmIffYkK7tH5S1leTgwCg5NO6oB1oFr7jK+rgNEm/VFxBJkEfVe87Z8Sx
	64aE5lhZW+UAM6sG2h3xbfRkr1Wd5RjiPsw2wQWtuPSXKzNnehnOQ3KzX7zlEKM/86gtygX23+P
	CNLLf/Sq2uHU8cRLoEwa34i1O+3z3HvBqOMrG675iI1EA=
X-Received: by 2002:a05:600c:3ba5:b0:48e:7a10:1f5e with SMTP id 5b1f17b1804b1-48e7a10204cmr20782365e9.2.1778401249517;
        Sun, 10 May 2026 01:20:49 -0700 (PDT)
Received: from localhost.localdomain ([94.158.58.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e702f407asm103595915e9.13.2026.05.10.01.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 01:20:49 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: m32285159@gmail.com
Cc: andy@kernel.org,
	giorgitchankvetadze1997@gmail.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sozdayvek@gmail.com
Subject: Re: [PATCH 3/3] iio: chemical: scd30: make command lookup table const
Date: Sun, 10 May 2026 06:05:23 +0500
Message-Id: <20260510010523.41859-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20260510004244.37342-1-sozdayvek@gmail.com>
References: <20260510004244.37342-1-sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks, makes sense. I'll stick with just the R-b tag for the next ones.

Stepan
