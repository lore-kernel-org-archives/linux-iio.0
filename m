Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F853C73E5
	for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 17:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779040576; cv=none; b=aPeL1nsh9AMkuhTv3JMRdHVHxP822sm8Q/GduFl9f1CdPoUspoEd67UsfH5S+JnQJg33VbJtSWnHDU4ozZie9st3QQhDcjhsjGicGNenYkf8Jh19PSA04eYwGQnJMVASRC2y9XjPTleQnAfU43LMgqqg7mBZS5g7d3YNXd63Eys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779040576; c=relaxed/simple;
	bh=fmoS8JMk0Lj10vQXkFNeX0oc0mZfbAfDYXE5mBenn5E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MmdFaB0fPhx2khf9dgYI2KSIr4/56uinjTH8IQ8RN1//w8TlNHTBzL2u+c6UYuz6QgZVxB3Fq7fMoXZgYyaI6MvBm9M428ob1xWKh9XNSz9X9/GMGaZPjAGuzdezf5EQvtW/ZrBhGA8qfYocLH5GcoGY/BYj4z9sJD3wvnJJZKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LyWQySti; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LyWQySti"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4891cd5927dso2077775e9.0
        for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 10:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779040572; x=1779645372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fmoS8JMk0Lj10vQXkFNeX0oc0mZfbAfDYXE5mBenn5E=;
        b=LyWQyStio8kI77UhwkZ1NZKmvZ8ZnM0cH8+o+M2vyaoldWv2JfA8KnsuT+I55i+Qfg
         aLXMRBoGZkhipD7wbjjpfMU6fqHIi/IuWcW3eXgq6i9V5WwjfaQTrQuEe/NkQfriRFvP
         VTeBxszuUeHprCyNHfVu16dm3WFWcFCdQUwbAwhUMgmv+Ot5xkDZGuKirOEt4J6Qbby5
         HeRoS4wzWWkX+HGsHiCLmJ8yphQzBK7KwvCOmTN2fRxZ9oKlGZn74FAi8gQdaXA5XXup
         rtaMIG1qbrt02Mr/2aFrztpCgKKDRxf73hTOxPI5tfJyKAiGIr4VJJYj+qhjJX9K+RR2
         RICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779040572; x=1779645372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fmoS8JMk0Lj10vQXkFNeX0oc0mZfbAfDYXE5mBenn5E=;
        b=b7sH63lnxfZvXw2aKXGJmj0wxTl+soV3XKcIhsCgFcB2E3PtBda55FwgDobrvVZJmw
         zz3UdmowJ62SLCTDmGaYugqDpZVe7G++ULxpQLD26si97Z0aeLcvGldnta4tW9xaZAff
         MC3o5QfQ/+QRToh+8E7y6K/tpudOA63ySUp4f5kTLeU6JTKNdAMEDK+jMCIicI9KdLFA
         oCYXevUJ3FqIfqVz8W6jOPT9SiH96xxIxKLtCosz2Z+UBez2YwJbnHW8iQPlPScrD4iR
         NzOlN2KWJkO4Ih5hYZZN7U7hCSewZKZ4UzZhUVwovdJlxvDIoFoYWyt5aX8PuLuLoTfn
         UCSA==
X-Forwarded-Encrypted: i=1; AFNElJ910ObUDY3RDcfJhUVyO1EUisaVo67UTuP6at8GdekBtAsmougqOWxDc0thrkj9orI2MopLlI+72ks=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFj1Ak/jLtvECsJdZ4a+QC/GdXwH8zsLJBHHaC0VKKbSu92zNv
	zUKCabVlnfyADn0FVqg7rB70lxDA5fbFS7bfK3/iQVyI9xIl+/ik4vt9
X-Gm-Gg: Acq92OFS+Zqn7eNjlY+SV+jcJ6SEigv37vufu18nKC8tdxu1KDnlmySr8tdT9M6hm2t
	T7nmJMCCAVgZ+beQinh12NAo4qp8c93fshiONLFa2/xTAfpvB+BN0hLHC8RvABpw92paGen8vDv
	vDwk5Ij/KgVbPrDO5zd9jjI3+Cv/+/31SsDALVJH5BUP2YZ7tNc+09bUGN76IlHiWHy5BYKvJhI
	rY62HfgNzHVqUKE0DxWDB/QmhagOM6BTrGk+vwzusTpYlQCsgz5OErdBlV5y75lqdvlU4iemaz6
	+uIL/xb18jXZQKgpho4BPmjQyavDaCYfKkkOdH5RDoXhsm+XHQTquoIlckUT5QvkBP+s6VYeW9D
	800Y4q4d89ISlC1nSu8C3DtfQwL7RxYLucwFjfnGMfib2Xa7vmIlPiSfzAkl+98+Iv3jSPJ3J2g
	nRaqfxTumt2h7DTzQJWwVlkDajnLRr99acSXZdcmZKqqOa
X-Received: by 2002:a05:600c:3ba5:b0:488:7e7b:dbc2 with SMTP id 5b1f17b1804b1-48fe61f7b16mr110487595e9.3.1779040571760;
        Sun, 17 May 2026 10:56:11 -0700 (PDT)
Received: from localhost.localdomain ([82.215.118.79])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe6b60csm86459105e9.6.2026.05.17.10.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 10:56:11 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: dlechner@baylibre.com
Cc: corbet@lwn.net,
	skhan@linuxfoundation.org,
	jic23@kernel.org,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Stepan Ionichev <sozdayvek@gmail.com>
Subject: Re: [PATCH 1/2] MAINTAINERS: add match for IIO API docs
Date: Sun, 17 May 2026 22:55:57 +0500
Message-Id: <20260517175557.2019-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20260517-iio-doc-triggered-buffer-update-helpers-v1-1-7f00d4188f6f@baylibre.com>
References: <20260517-iio-doc-triggered-buffer-update-helpers-v1-1-7f00d4188f6f@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, May 17, 2026, David Lechner wrote:
> Add a match for Documentation/driver-api/iio/ to the IIO subsystem in
> MAINTAINERS. Any changes to the IIO API documentation should be reviewed
> IIO folks.

Reviewed-by: Stepan Ionichev <sozdayvek@gmail.com>
