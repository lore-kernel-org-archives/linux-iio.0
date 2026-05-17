Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7E830DED1
	for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 07:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779003523; cv=none; b=ZPA42LLl7JCEI0Jxi/kIs4S/5GGaVx3xeIm3CzEZuj0bsrjcmFlA4ggdIJE7wMRZUt1x5Na/rlS6otS/8p8L1AM1IlAA6NkexmmVnnId2UgdMTts7hEC0UQ6bdFoO6Knt9mCiTXSKcPU9ofvEstzMmJTcMBRopFmjVLq6zyPwSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779003523; c=relaxed/simple;
	bh=+bAYzSMtgGe6jAWIBLroL6sWqUmQ3b+44DTNSpTptZE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ln3O5c+X50ExC499UFUqmkVF835V2MrIHPO/w0JN0NtVS2mNI6GeWOybmk/nSS69i3b7daybt0rpbmYyeiUwD51GGz/KFt9k0OwIQHFaCmtB2wmqEgF0jvcGYxjOqQV/Y7nbXkdD841E23zwxnLcZgfZKslS6xz+qCbzgfJEsXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eqZ1jV7o; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqZ1jV7o"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-45e5f81074aso45176f8f.1
        for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 00:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779003520; x=1779608320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yz7DhL9krHcmEm4nIRswzkcLhOJC+H+xp62jTsPy1Ss=;
        b=eqZ1jV7oEY/CbSqWC0AC3UuyML2oEzHqCF1Y2bWRLrFECUpcoSGI9XVJLPqI7GfILM
         jcP6BX21/Q7UINbqhlbBtxV3nlPtjOyMTG0yRtke4Pj3kexwHeemWgAMCKqGSL7zHfab
         CkKu4zbCOrNuGX1rrgMRwuMJGu9KfUg7b4kMph1rIKxPe5dJIve2iUIPqjeM9icrhzK7
         xKZmH1jCZO8HssUmcCJGGnPb83o+HboMDdkCDlYifjig0bjJfonJgKt9WuoAUnTDhO7k
         qE0V2sx55oAM4B7lmLJPNBOWVTK5cWzw4VL54kU4/UvRfORcX6wByiZ0haKyIn1pQ2hx
         Fq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779003520; x=1779608320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yz7DhL9krHcmEm4nIRswzkcLhOJC+H+xp62jTsPy1Ss=;
        b=Bc6yNJ7t9NsMxauau1KBuyA5Vd8rP6Lk0dJcdqaPw+ua/nQmATWFCbbEf0Hek2T20v
         OrlNSrwt+tQ0yO9KRV19vVudEBpQWYlDXteNT269+HZ6nnkMbR9HekNjj/4dRHVmE9KN
         tVrFZVNhlpnqTlfT19dM6qK9TR7juFzAUFxfALzEVfFR3k3qphqRqhUYF7o5Hs4Iumy+
         HOt71eFQtrpnVc2pB6k6x9bWMsvOPXI2o5LFhukE+fL9DxdEhanoCyy6l0UMCzpMmhTO
         Q+Lu/80IdixzH2JIH+rLbhS/Oaot6CSH1f3kX9bQvTcqBZfzvPNzBb9+Q9ux3z7b+Vih
         elOA==
X-Forwarded-Encrypted: i=1; AFNElJ9K6NSJ04JdfLFjDXMiDF8xJlPhPds1wV7x8GiVkzx7OzRNCyqFrMZ3UvrTa5jE415eTs0uZdKYMIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIu6+w28LCJXMlzQGoPd3rBnoKVmEsmZDYV0T2Dhkh+7ksJ9yV
	rPafk/qb1FKdLjwBHUgmWHU2ixMF7ccq+qy2hXzC2C4LbmIT3zrK+nYU
X-Gm-Gg: Acq92OHA0YDS6BtRzXC/A+FvYOr5jdDpZdNBb6uAXGU3JwPLf3iIGYfdzDJ7Q4V1BVP
	NeyusufjzR84oEFySQLSmrgmWsBf9nlNzjH1EVeYE5Jg0BOYDqgHV+vb9vyf35/gVD6RRpB1MSj
	Ik8D0p+iwDpRaRSGj5eI7jKJ6hU+40NLAAwfCuFLdtIny7A8abgLCK+jgEPMM7kVwxl+mmKObco
	HCjlxFO31R3H/sfVZ6Gue7XqSSxEN6PxAJ8zCI9LndkN8t/XvUgCu7FBEU3vP0bXNC1VJ/P9IIa
	cUL2AG53e/5rNMtAooRiQ+v1zOHnjUWDt81K8evmOXBTJSW0fsbmoiAYxmYyiu3//C7htXqptiG
	N2R0rFEJk/cDjxOW1ZW/z/TEj1/HO8qBqtPubjUbHCpVspMHWlno3bzJizDH/3o5vwwetG1gaZT
	pN9F0gZgXK+5kCDgXyN947BpphmtELuMxESN5z4WAs2bYWa3bINjqRepo=
X-Received: by 2002:a05:6000:4404:b0:45e:73a2:3093 with SMTP id ffacd0b85a97d-45e73a230eemr634420f8f.4.1779003520494;
        Sun, 17 May 2026 00:38:40 -0700 (PDT)
Received: from localhost.localdomain ([82.215.118.79])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe248dsm27487015f8f.30.2026.05.17.00.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 00:38:40 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: salah.triki@gmail.com
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stepan Ionichev <sozdayvek@gmail.com>
Subject: Re: [PATCH v7] iio: humidity: ens210: Extend I2C functionality check
Date: Sun, 17 May 2026 12:38:22 +0500
Message-Id: <20260517073823.1280-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20260516173148.3209f7fe@jic23-huawei>
References: <20260516173148.3209f7fe@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, May 16, 2026, Jonathan Cameron wrote:
> Sashiko pointed this out... Take a look at definition of I2C_FUNC_SMBUS_BYTE_DATA
> and consider if the line above makes sense.  Check for other instances of
> this.

grep across the driver shows what actually gets called:

  i2c_smbus_read_byte_data       -> I2C_FUNC_SMBUS_READ_BYTE_DATA
  i2c_smbus_write_byte_data      -> I2C_FUNC_SMBUS_WRITE_BYTE_DATA
  i2c_smbus_read_word_data       -> I2C_FUNC_SMBUS_READ_WORD_DATA
  i2c_smbus_read_i2c_block_data  -> I2C_FUNC_SMBUS_READ_I2C_BLOCK

i2c_smbus_write_byte() (without _data) is not called anywhere in the
driver, so the WRITE_BYTE flag in the current mask is dead. WORD_DATA
asks for both read and write word data, but only the read side is used.

Minimal correct mask:

	I2C_FUNC_SMBUS_BYTE_DATA |        /* read + write byte data */
	I2C_FUNC_SMBUS_READ_WORD_DATA |
	I2C_FUNC_SMBUS_READ_I2C_BLOCK

Stepan
