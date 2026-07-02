Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D42366054
	for <linux-iio@vger.kernel.org>; Thu,  2 Jul 2026 11:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782992821; cv=none; b=PMM5tYp0WD2yU6iLocJijzhXja8qDp+y4P+xeQfOjMiJnTbHTEhtpu5OoMgRiXrYZXlfmTWpnmY/vCkfsa1RZRX3/INADtXOIVVSPFV6Olw85dfM6G70Eg84gsC8xc2+G/CZXMLToOa0HSOhhtUFAw8AAU81DK+91FzDjxSqZvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782992821; c=relaxed/simple;
	bh=2xtJjB3ZZKrjAyMAS6ay/xaI/W5DMocE6XHz5tCcGWg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MLeBeRMgQ2VxlnzZofKywtSpu1TZgosnnGT+pUCwZg6F8lIFJgT6vBk5vFy5C28YxMRNsgF/y41MAIfW3MkX4D/AtH/Cb5NyEu/rMIoPmH3mgrBtuNz53hwmHlDNIlKk3eXql38jSuNaJhhTPT2tgSkQt7zWT3g7hX03aE4oGKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=of63oECr; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="of63oECr"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-845e47133c9so276317b3a.0
        for <linux-iio@vger.kernel.org>; Thu, 02 Jul 2026 04:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782992819; x=1783597619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O2RcmWOswUXRWl9borRQVOjTHLw4E0Qdw3yPlYqwhlQ=;
        b=of63oECr5iu1s2yQBqGmJN+53pBnY87Iq63yOJcHvPJhxGZ7j7lB3u5wjB2q2lct8i
         +CSTunNBH+X73LdfEajQnIJ21ISqdWOtcefVETzVGoO1Me9+jOzMoZGuyyMMVGwCs6Tu
         aVO0sMEaS+1dmZdI9afOuREZo2pUUnowCPQ2FOG72fkZISbxrPXJdGNxA53dwNw+RkOc
         aDlGo59bsk0H1uTpwY06EcF7V5v/7eSfBX7h4VowlfpH3A5VPRxcfHZlL/L+vZeLDHTu
         snwtk1hxmmE53uW+fHcrRYe6YMcXIcPu3Wa6pg4GKgEWXu5D2R3H6s4wLn75+jGgY8/C
         l5lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782992819; x=1783597619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O2RcmWOswUXRWl9borRQVOjTHLw4E0Qdw3yPlYqwhlQ=;
        b=aKFhsm9oPS7EbETpqfC6rA8remKIwMAs2cC0e8lReASsjjjBBz0yFLH/oWLk9C78Ni
         FW7yycpogTh2kiGr6FRjtVwh9WN7IqR0xXLk+29k+1vR6M8eEQqNS92UwzCjU5dUKCBI
         K8MyRI/bA2Uxp5VERN0JKskEpE01vgkhd5a74+ZIC5OqkN4tjEoop6V+R05hszbrDi4G
         6e979C4U6wqDgISogJwUtDrQ56xkOVwg/musqiznNFQFiDOago75ISb8jqE46CRihjyH
         aUqDjzOoDY0Rj3K6kXVCe82GJfov8mjEu3AuwqNP7LQejd0zTpRiLGg56+5XqZRhup8f
         dSlg==
X-Forwarded-Encrypted: i=1; AFNElJ9GpHb5tJREY8hUlunX/2GY+ErydFla4UtjVbwDL6UQdsFrSkuIUtkddn9g6FF++ONYprS9wJJO3Hw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRMNhgqI+XxrL06fAzbMz5O9nLB1dnUzWt4uc93vfOJN4emuIl
	9yLKbN9GAh4U0vW+KWDp6UigFa0vodFUDc9Qt9uqjmMqmtPd0GwFqHV6
X-Gm-Gg: AfdE7cmxwMeOjEHlDw/9CSFk5RTxTf0/hZpIwSdzlSlvHdt5X+GrmuHauxMDgOAWnOy
	ZY6dPiJYlZRWQxtNkX68vP+JUjT4DltVv1upxM41DzzjRTikjuQhMoYgsCwx9aKLoBtxyuD5X1K
	J5cLa75XST7Rk7qnniJemqBGwe3gzvXAJpBSMcWmOEN9q2QL0MxxkiDkoxXmGPxeBecHjuvmUNk
	WFnp16+fB/u+vnwbs/ACPIZz1demUt5EgLt7xy9FSL0T8EarlYYIS+9LxBrnXoFCG6E5Xe1VbaV
	Df7arTeCWJSnStTAw/MdJyZgp5ausVjMPjWhbx7T4iy024Kkhwud9Ts9vhJiyjXFINwIF+g6N45
	KMr8GXnNM+scxOChYxKNfgHKuBTQN8XT07U3T9dBugVTTnXD9EOfENntFM0vG+5EZ/0ew+oFmk0
	8f+okBRqmqndEj4Oo3lSFatswXItQZgWe7W4yPoO0rBMYq/iW2aaKkIrVzAo0/mOpUFFZk
X-Received: by 2002:a05:6a21:1bc6:b0:3b3:3506:cf3f with SMTP id adf61e73a8af0-3bfd2637e16mr9387392637.1.1782992819244;
        Thu, 02 Jul 2026 04:46:59 -0700 (PDT)
Received: from moksh-Nitro-ANV15-51.. ([2401:4900:c12e:fec4:e7a1:6f69:20dc:cd96])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bb84405sm12313834eec.17.2026.07.02.04.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 04:46:58 -0700 (PDT)
From: Moksh Panicker <mokshpanicker.7@gmail.com>
To: jic23@kernel.org
Cc: nuno.sa@analog.com,
	Michael.Hennerich@analog.com,
	dlechner@baylibre.com,
	joshua.crofts1@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	Moksh Panicker <mokshpanicker.7@gmail.com>
Subject: [PATCH v3 0/2] iio: adc: ad7779: Remove dead code and redundant error message
Date: Thu,  2 Jul 2026 11:46:47 +0000
Message-Id: <20260702114649.9758-1-mokshpanicker.7@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These two patches address review feedback from Joshua Crofts on the
ad7779 driver.

v3: Fix double blank line left after removing the completion field
v2: Add cover letter; send as fresh thread (not as reply to v1)
v1: Initial submission

Moksh Panicker (2):
  iio: adc: ad7779: Remove unused completion field
  iio: adc: ad7779: Remove redundant dev_err_probe() after
    devm_request_irq()

 drivers/iio/adc/ad7779.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

-- 
2.34.1

