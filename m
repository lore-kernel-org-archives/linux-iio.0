Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADADE1F7575
	for <linux-iio@vger.kernel.org>; Wed, 17 Jun 2026 17:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781716923; cv=none; b=F2KCOTrbMnWi9K0rRASeC9jPNxxVfnZUJp/PIUruuBNwUaoz/6CdROXe8DCqxHHNmbvbEfIeuk7HxfB54rO/x9tvpml7XC2OZdYxOcR41tmOUJti5jkiFRla+1WXdzkGzKwY5bNvBTyCCeW/I6YeH3YtLgQwGcGQgaDBXpjf4Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781716923; c=relaxed/simple;
	bh=nnM/S1R4rKpH1+wV0/liEw1dNg7Y2Hxyi6xjB1LV2ns=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hlQ/xYmVmqAdF/IaPEnQNwlPChyHH35BKO4h4RdGq/9ta3SMkUfX93oqSoDqHHftCnVxk4IYDoyynYJhDvev86QQ9zU5Ezk+DetjYiGJDt+zN8XgT7Gv7J22JTm605M/gs3HRyRA1Pzk2eJNunx51yolEZXBHGrt83fdd0zcK/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EGDG7Ejp; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGDG7Ejp"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-45ef779c1c2so57938f8f.1
        for <linux-iio@vger.kernel.org>; Wed, 17 Jun 2026 10:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781716920; x=1782321720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ERVZdm55pkIPEdYAAr8ruNQ/an9OLjCevtho5Y613Ks=;
        b=EGDG7EjpVwcn+ssotvujNbITGQNIEpvTGaZVX68ZRqR+KzQeYegwoLUvbsFSsi5H4g
         pFsw8RqUbbRkHsy0VcV+6h3RJgBSJGVcIbpC8yfOypoCPQwWMsLS+87OOtKx2oBKw55b
         rC7dP7Z7TJ1fNJqufYxNtFYu+MMuG0DEzyNwzg3414MCTFMXTOQIJ7FjkQDAQuOxW7AA
         s2WfA3Dd42SgUAKyAQdm4J4rNLAL/NiE09jLCVVW0EKgb2z1/uYI8MwLDkE+aTjJe+SB
         1K3CbV0tSzJcF9czmqxrrQPVl/MGXy3Dc4070JVTHsv+StYKFZVCBq5jJYBpwGtDfWcA
         QvyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781716920; x=1782321720;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ERVZdm55pkIPEdYAAr8ruNQ/an9OLjCevtho5Y613Ks=;
        b=sCanBzAnaqkiVuSig8AoILc3RWwj8cKCef37xnNpkxK4NVnOtF9DBxYpmnGQL2pdNp
         u1/lLzmZ37788082l28iPi8shMfWRt1JSE8uzawqHuwcCYfSfTvc9uOboyKYRUcttZWW
         atW/UKpxzmosfZinHSGKpCAsZPuqh6vuCHKUdU3bLp1kRsUAxa7Zv+5nrfbWRk5l3Tyi
         o5K5SBjCxPDCVpxSLMuEqk7gX2w4HmHMii29GgFNqDWNHqR20wntZKKFq1gU45031piy
         WsN5Mt1ctaBV9EVYVYJGI5PX778m/hc5XP/Hk9hmG11MgKCBQ7Wjz85jt0MtsOnBsWRp
         aqGQ==
X-Gm-Message-State: AOJu0YxgogwDh0C/4HVpwijsHoEwoFpueSw3tK2iqBJVpbq0WJxTpHCx
	l4+zUadWLGsf6CMwd6NkaW4THKe409lNAcNXoR4aHGcAz2lwUbLXygoL
X-Gm-Gg: Acq92OGQgrK4PfUNmD9nrl1FCm0UMXLlUx0R3xGAncBA1RtIGL1rAXecKG1Xd62Gxsp
	D3F9Cqq62rtfJGm+9tcDIuWTI1mOQK8tZ7Gc/pa5wSTpLcJiOcc0D+uFHQbbw43ToHM8TUN2DqY
	MuKxj2UU4gNG0C87ptezvMOozZJ8U2cuTlE5DSYsaQYxTRVXvGSBCXRvt4dSIdRi1YGzROvv/Z1
	bvnk7HjQMQmAMAwuWmkQBEMbvNlqGxYWS7bci/x2UA+HA7Haeh5wONLuQIhelPHqCKYR7V2Tr+c
	p7/WJRS+u1/iiPEd7wDeK1lSKc59FdWO1aHnHRZ68u3cn21Wjj3v5xyCJKjQf53yiK9mxdFNy3D
	PG17/8x73z/wxE94LVpx+tg/TUTJriF1eNU4h2Wq7xH8BhRMbNADpI3SjPFwZpBOXWfGgZyU27i
	6PdKyRzY7SjzSqPYLRryGPRPryYP4uNKlvGkKmvdwZnZM+OyJBBxkLlC18OicEfu9ESD0=
X-Received: by 2002:a05:600c:6a87:b0:492:37b7:6077 with SMTP id 5b1f17b1804b1-49237b764dfmr10426425e9.8.1781716919868;
        Wed, 17 Jun 2026 10:21:59 -0700 (PDT)
Received: from arch.lan ([91.230.98.156])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49236860482sm20000675e9.0.2026.06.17.10.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 10:21:59 -0700 (PDT)
From: Tomasz Duszynski <tduszyns@gmail.com>
To: andriy.shevchenko@intel.com,
	andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	m32285159@gmail.com,
	nuno.sa@analog.com,
	tduszyns@gmail.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] iio: chemical: sps30, scd30
Date: Wed, 17 Jun 2026 19:21:37 +0200
Message-ID: <20260617172138.114572-1-tduszyns@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series replaces old email addresses with a current one to
make sure changes show up in my mailbox.

v2:
- add missing mailmap entry

Tomasz Duszynski (2):
  iio: chemical: sps30: update email
  iio: chemical: scd30: update email

 .mailmap                            | 1 +
 MAINTAINERS                         | 1 +
 drivers/iio/chemical/scd30_core.c   | 4 ++--
 drivers/iio/chemical/scd30_i2c.c    | 4 ++--
 drivers/iio/chemical/scd30_serial.c | 4 ++--
 drivers/iio/chemical/sps30_i2c.c    | 4 ++--
 drivers/iio/chemical/sps30_serial.c | 4 ++--
 7 files changed, 12 insertions(+), 10 deletions(-)

--
2.54.0

