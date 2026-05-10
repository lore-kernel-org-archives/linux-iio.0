Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEDE3822A1
	for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 15:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778426908; cv=none; b=n2KdcrFwStqKyz4BlFLoDLKnC31GVcmWMUCpmtvz/6jjZ4iB4zu3XYPz3VyBBRAYdlJktOfSSlymr2AD67WI4DH9uYgYsRD0tgRlaKRhob6yvQTrXsFcfQN5wQyGJCg0gohtqMLCGlqeZe8Hzyh4axH+sRL5bhr+wNKoari8DbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778426908; c=relaxed/simple;
	bh=dLZ18mgAmZTZhHEMO4l5QNmeKEpLCWNbEzLxX04zrqI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aDZNYidGb57JXnk6PKEUZIT0Pt/vtzvr9uGdZ4HcUeD++B5OvQUGMa45xbo/Dfyon6YvsnVw732EvFMUN6ohDgL1IvSNvUn8DnY/N1rPNGvaDSI+RXeTX/EkJUtayNSULd3OoXwoMTfU+bEXTzbj+jA0Wh8Okc1nx8MFHppmKLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BgvMjmue; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BgvMjmue"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48962cd0864so2922135e9.1
        for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 08:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778426905; x=1779031705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dLZ18mgAmZTZhHEMO4l5QNmeKEpLCWNbEzLxX04zrqI=;
        b=BgvMjmueNlsKY5ztW3Ucq4rz6AkJCLgCJ0NcEE8ErpikXoQrjnAFiwyHTFyi+UNCmP
         lMVlPLOIzUM6Ao/HSC2tXe+eWXtNd3/HSGEPHxEKG6Dd9VqN9C2H77m8PLG3PqYPWMYR
         ESrvh6vU4E9KV/vkN4E3v7TNaoN1yOIVmwkvhDRFuFQNIJnhl4dSIQRJc5MZpc2O7LLd
         U32GZY2BZrrQGb+WIGIHMRnom8nkOkd+PkkIf7iMqV9bZ7woGYCCY9/cczTOoJUC7rgU
         muehCiKdnBjDu6tPOeIvCYmQC++6L5gbZpt8p3nqawHZ/eeDTl8AG2DoeVKipFUO9B1O
         ZXuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778426905; x=1779031705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dLZ18mgAmZTZhHEMO4l5QNmeKEpLCWNbEzLxX04zrqI=;
        b=fOx7zk/Jt+XEsi1edf6KloQBC4EBEX+u9VOdt7MJu7BvO8/6PAnvBomg9I7yOkK7rB
         /TbUxdMyhtd1ljoZoz1PGdLhrRn+BO2a05715drrXnJnf9ryk3jUHbPrdNmmx0wBdc2X
         Xqc5s0+fwO8wmOWM3OlMoygs36Ex0sWoZ2yvmXv12p5LJKbbYM+lazAkOhZhawi5ynpL
         UI11JS5PIOvyn+4Jq3s14atrEHWf/TQwY7Ea3cqtS7B675pVGGoP7x58ohe9VBGqS4xu
         hZSNn2W5/phFQ11qRf3Ndl/85jFUh5DsM9V25OkR7mYZx/in6zj+bLPUJm1jM1SyBurb
         6ppg==
X-Forwarded-Encrypted: i=1; AFNElJ81mBdOYCqv93zexmIK4B28Z7ksTdaRDoT/7GbtItS464DAdao4IB8tzvdjRlUefmrsvSIwxREj9ww=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBzb8vl4UXsoHh9heUpjYMMa9ZWc6gMoRUoskOVbJJCNISoFtx
	YajIVhkcU/au1djUCr7gC/wOiglvB+p/QcYn/bBoS5OTXaSYxt+uVZpB
X-Gm-Gg: Acq92OERJ6ZktJ6t9dXdCHIjzfFTl1p2B3v4AO3UEvPb2LRqsrU8iKVRHVkV3pgXeGg
	B+xFhJsoYACRkn3hIud+UgNffZC0SSbUzhM/huRBDk3VDFJed1xRpCeVDYpdKN8AME84UrlDSjk
	qndc/CBDxM07vjMFfXoMEXMGkoMYbpe3tM5kQUc+XKm/2fSiSv4Xammda5jd0OqBjmcsqa1+oRs
	TSZfCSkNisLkvj4M3Ux2ze13NyxMc0iRE5eXNTgViMd3q7nu+fYtZJK1SEU2uA1UI3embVZzzF8
	NtdBAiBV6iUAjc0Gyci6ucnYxKcHNXe++9KC0GED+R9JmGnTUGNIxEM2Ae57HUGedxmCStldWlO
	rnZIbYM3uNfz39A3xUmbgemrmtt4lGbiNS45AA3hOZJfFWwoXRAjFjH8pqLG7XU4MotwLXms9j9
	H+djr6piRa8G+6kqcvIwmmfOWNHEsh4ziE0iMEv3KGCxL+Cq5zOAhwfWw=
X-Received: by 2002:a05:600c:c4a3:b0:485:c456:5e4f with SMTP id 5b1f17b1804b1-48e51dd7e6dmr174613955e9.0.1778426905344;
        Sun, 10 May 2026 08:28:25 -0700 (PDT)
Received: from localhost.localdomain ([82.215.118.79])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6f9fbf12sm131155925e9.0.2026.05.10.08.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 08:28:24 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: joshua.crofts1@gmail.com
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	gregkh@linuxfoundation.org,
	hcazarim@yahoo.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sozdayvek@gmail.com
Subject: Re: [PATCH] iio: magnetometer: ak8975: replace usleep_range() with fsleep()
Date: Sun, 10 May 2026 13:10:37 +0500
Message-Id: <20260510081037.2480-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20260510071944.56700-1-sozdayvek@gmail.com>
References: <20260510071944.56700-1-sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sorry, missed your earlier post. Please drop mine; yours has priority.

Stepan
