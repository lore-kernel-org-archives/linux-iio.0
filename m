Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60012328610
	for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 16:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779035639; cv=none; b=h6uZg/8Npizz3bY75PafMb7AMA+BQYwg4zqKnvz/13GyIvD0WyoC9XvFUGJifR80kJO/j2BFx2SNoxIw1q2lcT6bwjSSBr2Y4LxkepzlJFUCYNxd4cC5BVH2E/tchsTdcF5HW3mb3T5rRMRL63C271Q/aavV8KIVP8LUBBU8e2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779035639; c=relaxed/simple;
	bh=vxYJ1EoUv4O0XxXUOWDu+mlPan3ee45WOs5kfsA2tyU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U0maTXzDSDJiWb1gyjdDbVwoFP5VUsn5+2hME4uAT7tm9yVgSIymDMyuDl0NHuohKGCi/br/BqcN7G0lrU4bWIqUUy2QgJ0WgX6qi3pfU2N/J1lwaaCMrz18WArGF2+fp+wsyeSYYO2z2ut50tAqDoGfEg132+EJRjUlLtJnWQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q0UNLXHu; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q0UNLXHu"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4889d0a9df0so1505555e9.3
        for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 09:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779035637; x=1779640437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vxYJ1EoUv4O0XxXUOWDu+mlPan3ee45WOs5kfsA2tyU=;
        b=q0UNLXHuX1vfV1qjyfrbPlAScnmiBiCHNU5YsB7dMei6XztVnFyESODC8plinTBsYO
         wjy9ZsSKhk+uhNzlKlui1Eyxgn532ykJVfgI4+RsxINXANH7g/lV3nHmSnd1J+aNIc0K
         /2jmHwpN1d1MImCNuTDngLPJzclb8nHbsHRg0S7kFni0MYIrxpTCBqeH2s9pI/6vQfI5
         BsRgg82CTAIvuc4HCWSJkEKsYPOewAZtTuxtjIvCBYeUPvmejvK/O2gVItFRIs4ultgg
         oijpk7UIS+uGZ/V6F7r50jhA3YlkRBD4uBY6qrxdCMhuPW0/scf/+bHEI/CeAhm0oOW0
         rGtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779035637; x=1779640437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vxYJ1EoUv4O0XxXUOWDu+mlPan3ee45WOs5kfsA2tyU=;
        b=N8X5JfP0ROGd3r72w6HLKGd8Y1XeBg8YOrc7hABmSh1WLA4ROjlIDgR9WbLMYIpTBW
         0BAuRrh4Ig4YmXdGUm+Gu560LyXbRIHvysi3DVQb1I0dxUXhFScGpAvF6HpA+6WjzKm5
         W3JGcJtlwzjp8D5cQ11N7ZfcHgFZKiYP8ea5363fXD6PsVsiD4zP93y4o10bUY3cK65X
         6xO65KEb/ESbGLfEQ9aTOFaDdzpUeK5D1mQaWgnhgqodGInl9w8OlOhMcpDwvrzl7CyR
         EGXFMLFAdxgIHhPbV4v/2oSFqGASNfcTCtLNSaPe/58vDKvtXbXI8DJ3969wt3PsBCld
         sL1Q==
X-Forwarded-Encrypted: i=1; AFNElJ+zyu2Tfof7UTBqUwE4Za++TYM81vTLrRYGc2xF21W7Sh4QNYmPFJS8zZMxFg5ci/F6PWULCCoXsT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR50FSrHk4PPJTNNxtEaG4XjrsGq3/9z/jkfuEz6ut20Umpwlb
	2PLA6pcMaBbcZmmIbJLC75HVV/RfkxvM14ISHtc/vq6GySAG1B5PqLlY
X-Gm-Gg: Acq92OFSyG5VLsGMnat5130pN3L47BO5WEGL8CwVlnQtaDK6sLeBBunxaodrvzr+eEt
	WzOEFjnwzP5oY16TugqrCuubLcPbb/uEAVgP0KzIU5cueAihI6cWYKlteyImFLCrkz4fQNJ1nuj
	SSJuzLtHyLvLp4SrHw3iPsbY2CD0zB4ZthmwHqgJudcZbs7XMdnPzctWhZlOGv1sF2j58Oa3Hqi
	j3gKCMwfFsZ4mmiVkBS7Fr5mMdvP0NxGKlIWMTCUdDgtFbD2ZyK3ZciYACNEenXJ81toXA6F6ZJ
	g1AbWqReHaMX41eMjUH796MpVEUqmHlXk3pS8/lco3yhFbjQYGLFEtI3nDZVACnWyYh1Pou2M1k
	0TNJCpv5RjJfFYayuyRkm8Ww2kqB6pf7pgXfXsTiPuKpfcLN9s2a7feZ4B1Xi8jrbSx/DqXSWuf
	Z41UbvH2TVemowbBK8FMMs8hCZDcC7SKo/jYK+qerHTmFo
X-Received: by 2002:a05:600c:c177:b0:48a:56d4:7274 with SMTP id 5b1f17b1804b1-48fe66423ecmr84053575e9.3.1779035636690;
        Sun, 17 May 2026 09:33:56 -0700 (PDT)
Received: from localhost.localdomain ([82.215.118.79])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe78aadsm60608145e9.29.2026.05.17.09.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 09:33:56 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: jic23@kernel.org
Cc: daniel.lezcano@linaro.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	gregkh@linuxfoundation.org,
	hcazarim@yahoo.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stepan Ionichev <sozdayvek@gmail.com>
Subject: Re: [PATCH] iio: adc: nxp-sar-adc: notify trigger on channel read error in buffer ISR
Date: Sun, 17 May 2026 21:33:43 +0500
Message-Id: <20260517163343.1225-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20260517163111.469-1-sozdayvek@gmail.com>
References: <20260517163111.469-1-sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sorry, sent twice by accident. Please use the earlier copy
(Message-Id: <20260517162346.189-1-sozdayvek@gmail.com>) and
ignore this one.

Stepan
