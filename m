Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F47035C183
	for <linux-iio@vger.kernel.org>; Mon,  3 Aug 2026 12:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785759352; cv=none; b=LmfezfhXlU6UF+i8kTXNyZb/APRymFX8kjChjD1oGm5fymL7Vh0HkGQz5mwfM7F4VyzrXpfLuw/g+PuAzxK5ncTkQWuGSwrqNoa0RPYCjCRHWM5dZV8vbvW4v+qQ+uzQcJ+/aOC0AliiHO5ObXT03KSSvDbeFFrE+QpMZsQd1Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785759352; c=relaxed/simple;
	bh=AypnRSiwAkayYro+LAwlWcrxfUFRJGWOdqKJuPvG65A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fPeksEZdCg8q66aRNJsUK/EiJH2s7HA/yLCLJ46YZfxpfohoyZhN0lBUcP/+pqzkMSHk6nBD0bWanKLQDowQJLE3nRbIlhY5T6h7g4lIXdV76dtobp6MVZkGWtfkwkEpheGVZEhgapiiQdq2AXCasQSSjVacDTu++HJ5PcYC8QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fjq3UKZs; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fjq3UKZs"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6984169c126so5603667a12.1
        for <linux-iio@vger.kernel.org>; Mon, 03 Aug 2026 05:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785759350; x=1786364150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J7jGnVrkhUBdQhi8KqMqkVbLE/DfcKidNPQcgGoAAGU=;
        b=Fjq3UKZsKsImcpn46JXnS6vIh2v0Qs0sJL1KY8xAm+QE+M61knqQGC3I1NnuzHcBYd
         2tDLOeE3cWFNe4NdmGRbI6iRjsimYnrfwlDZdsLTDL4gXVT6tpoO0aiLaGit/v2jH/sT
         YDXpEB++nhs48KDTBRHaU2kUlfiVeDfZwHbsgzIosTqoaeT0FMBawSSc7UtxopL0bmgX
         F1cgOML/pBftFWf0w/PyJZrhJVBZcyaeKfps/wTAm/SNSawAUBuBrxVvsZm0B1jKAPAH
         EYHJNnuO8nPzf0SsW6s88c97Ht4Jf7EEcihpuP5tRHcf4glaEd+ghZpLeoy6HHjt9JwZ
         584Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785759350; x=1786364150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=J7jGnVrkhUBdQhi8KqMqkVbLE/DfcKidNPQcgGoAAGU=;
        b=UadWFkxXENyEdLV/cMCmNin10u4v3FLuKu3dzS7L8v8xwbN6j/Z0x/OeFl9zca/2q0
         8urWj7Q+0JbG7KxWzG8KkUffad5IzFk5UWrVPVAo+9e5W0t44d70nCKlxT5tM3rOz2r6
         CKFldX50QV/TK/DrwCG9iI7u5+mJyB1jo2fsu5LjUVPaNsvDdIwbeY3f2xt2IJTCHt68
         K23GaOBiYJvPEjPNlY7eqUZCZp5fGQwi9ISb1o/HYQX64nCTnqEoKtW5glmRSpDojHLe
         3HpOLjAgYN740GW3j0C83vzarFu+BkRd3+k/7ZWx+/n1pjOeO5zcV177k2aM6AtqL5Bz
         veRQ==
X-Forwarded-Encrypted: i=1; AHgh+RpbtkSqj+F93VWXBASInSn+yH4SqqVNzraqcWvVt5DnDcmyLcT7w/ggY2i2d1uxxAIfcqkJoYP6jps=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuuXI8UBmBoTywLb7ZS2LqYHB2WWe680JsQeeOhIP3qN25i9BX
	PbKMfQXa0yJqsVTaUrVb2uTydH37emo847KMtF9jL1I97FVuTQRQQxJL
X-Gm-Gg: AR+sD10D9seG+5augI2GdmNAdYK9O7oaU2f0paxQ68txanxuwQFp8xgGx0s7LQHc3K+
	eB57LO4AFDzqXNo6WBNBOnErPlK9Ox336hjTPDZY7BUpBplBhF/R1BXeRryB2p332QRzjf8bDbj
	nZ96y7wfdJX4fg4uDFdoONU0K2GDA7SRRDZ1k602yPxKPpbBhwJG3Oh3EgaGzJzr5tPtkZZuMWy
	VrvGlMkIAa3pnpi5bGTrAu0JsI+d0L06pEej34hRiHOSjBmU+ylpBU/2uWlUY3Prh1peYr/jylI
	cjRokb4pV4mOeKzv5sbZCj4FYAN26EyyaVQTczcg0vvPgGy7zhm7cTA6re4BoI2acxR2mRJZhNR
	LT8Wem0CjGsCCDr3tzod0vKdql9ymvo8GyDr7j9NnPvTrC3knK+OKERv8Ngd60dZbc51RD+LZMJ
	eWFPsLZHYYu1xGfWuxzi66ptdf6co65Wcb5mU/PdnD3BavHqemnTpBcEj/2ShmcEvHc1IH2+3YX
	U+eBhP0Zg==
X-Received: by 2002:a05:6402:13c1:b0:69f:b52e:7484 with SMTP id 4fb4d7f45d1cf-6a0a7cf8d51mr7640492a12.19.1785759349480;
        Mon, 03 Aug 2026 05:15:49 -0700 (PDT)
Received: from fedora ([154.182.126.98])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a09c655626sm6175963a12.22.2026.08.03.05.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 05:15:49 -0700 (PDT)
From: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
To: jic23@kernel.org
Cc: nuno.sa@analog.com,
	Michael.Hennerich@analog.com,
	gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	linux-staging@linux.dev,
	linux-kernel@vger.kernel.org,
	Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Subject: [PATCH v2 0/2] staging: iio: ad7816: Fix DMA from stack and race conditions
Date: Mon,  3 Aug 2026 15:15:18 +0300
Message-ID: <20260803121520.6274-1-abdelnasserhussein11@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <0bde2343-8a70-44d4-9b27-8ce42c099309@baylibre.com>
References: <0bde2343-8a70-44d4-9b27-8ce42c099309@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

 drivers/staging/iio/adc/ad7816.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

-- 
2.54.0

