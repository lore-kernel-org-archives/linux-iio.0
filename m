Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739432820AC
	for <linux-iio@vger.kernel.org>; Thu, 23 Apr 2026 01:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776907241; cv=none; b=P8RzhmfWxhUbcLMeuENaQulsJppBPseSBBYVlfY8KFUClHGxfYofThAqEmIThnaBiCfyEBPhhzcSHuyNwJ7Xygr/EcWMOur+aZRVWaH39h7+J5p6pGTOZdNVY/tWdIwTCXAxJHYEZBrK9e39iMgDcWPgEQWiXF20aI+BIsn5dBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776907241; c=relaxed/simple;
	bh=oK8/YyZlzxWNKx7QHqN2JUwOuHqd9lqaJ014pWskVOI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aI535jLszL1bAd3+UUU2SHLJIcDtKB708fb3HId4C7tzLwUg+19L2DDnb5GPKaqI3tx6NPqxxXb3XF5fwx4arSFYn1HruyGQ8SVEY1izfLG0t0qRJmEUZ/CXTQwII0LWF351Ypds/zbBTuuwDBPK4PdtwmBhFJOnPOuPX/as9b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=Cv3lJFDg; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="Cv3lJFDg"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12c726f46baso7558666c88.1
        for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 18:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776907238; x=1777512038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3wn1Bi8zHMHEE9lzFz36oYXmtJkWvnscqpI2VsHr4rQ=;
        b=Cv3lJFDgAH2qrDFCCfqfXQZleQjzxrugLPPgtrYIDY+GQcLVrWBFasVtaPt8dyifCx
         gitMALLGXBWsaxX4Aza2CA9jmDs1W9d6McIOaDjqjrxWBWyI3jW/93xyJ465vumOQUkC
         VZfTEN4b7IHVAecw6KDLELWAJh1M3wxODoTcL3YBjGUzES2TjpoDeN6t82Wrv7gDre4O
         bp5UST6JZOdTVD9ISioeJJLK8Yk0BN57lKJBMxMAGtYke730MkR55anzco2AJ5wygEhK
         T1M267DoYmsR2e7CSPVwr+76oW6N2zpWG4x+/xaxLFsqF7dOEFW1X6ZyuzsBdKTuduyE
         dYeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776907238; x=1777512038;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3wn1Bi8zHMHEE9lzFz36oYXmtJkWvnscqpI2VsHr4rQ=;
        b=LnwS2rYWjkkd96B9Sz8L0DnM17cASJqWLvflLLBrC615qGTuK+aqLOrbv0QFJkFMSC
         qAU4FU3TNpRLK7HJyuLI7Y4yc48x5lvUdvmeKHL+Vh7yyAnvuEpKyOQ457mkuaLNAMF+
         nYRzZ/OMOE8r1l8LTaGKGUEpwgk5nGUDf/a5w0IXp5YLXPs8rRnCcn2AGdY9axorzpeI
         FP8e8y3plH/1iSpcD3V2QEpsJg3j4PQ/sPDSxYn15PL9TGtL20PRsKjxHIJSn3bhTPIt
         xecpQVKxOMx7aaEh9LmHfoq+8ZtfUG+smn7UvKxcrHBOEUIum7vcpWhACJrvqqZMH8WR
         shYw==
X-Forwarded-Encrypted: i=1; AFNElJ+7kNR9biEfvvXXDvoEf0So5VAM6VeGDNe5UNhhGqoeRIS7vSzwehtSfo+WVdxnZLtrWGZKDR8kecw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPda4yb9kue8OTZAsseQImtF0docBow0bZUzcCq2rI21CLg4qz
	sqBBYlBs2wbqCzuJvAyFOuesCJvPPIkHhO+btTyTaX4WLYZrhBYVoQiTFUkMGi/jmUKP9NA24kN
	ujlSc
X-Gm-Gg: AeBDieu3VLxtb+R1v4pCOtjfksLuzYPw6r+g5DwbiS1N+G0iMsDMr4Vs0ENqKmjvIUc
	42nUlj9LLVKOCxkBBen3z02WyDz8zF74/d2ppyJ5aTpXD58Uz/bozAKrbVUzwQhDJrscfLieuX1
	/FgF4xCPLpfXsHQ1/6pb3MAilCclBuoj9tNMAFp/M25aa1xaFv6Aya94SJbjTbRXDyCooSW8f89
	uQOyu2aV4+sp1g81QiUO+o8jnaRJGkqma9LspQ3IsRlcvLjIvTxG/D3NRs8CH658ON+V8adIekK
	zuINDZpDrBL+ul9qYmLSWH6nVP8ks/v6UxzSzBxLtHehyHAf87DOPSDwx/IorcDvchd1g/oF++G
	Ya5x5S6CBjXZGzjsFg2rA/GNKSVMhBdpfSbKRv5tud7vvqoiHWVhuU1gov4aNy/iiWc5bj1OoEL
	6iCsyBCVYmuDsD62BH/1sWtAnDHJw7ClSCuSyPdwCT8IuRug==
X-Received: by 2002:a05:7022:458d:b0:127:5c3d:bd95 with SMTP id a92af1059eb24-12c73fa2c95mr13683903c88.32.1776907238509;
        Wed, 22 Apr 2026 18:20:38 -0700 (PDT)
Received: from localhost.localdomain ([177.81.10.105])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c919266f6sm18139235c88.1.2026.04.22.18.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 18:20:37 -0700 (PDT)
From: Felipe Ribeiro de Souza <felipers@ime.usp.br>
To: andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	nuno.sa@analog.com,
	paul@crapouillou.net
Cc: Felipe Ribeiro de Souza <felipers@ime.usp.br>,
	linux-iio@vger.kernel.org,
	linux-mips@vger.kernel.org
Subject: [PATCH v4 0/2] use guard()() to handle synchronisation
Date: Wed, 22 Apr 2026 22:18:29 -0300
Message-ID: <20260423012011.41001-1-felipers@ime.usp.br>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor ingenic_adc_read_chan_info_raw() and replace mutex_lock()
and mutex_unlock() calls with guard()() in drivers/iio/adc/ingenic-adc.c

Felipe Ribeiro de Souza (2):
  iio: adc: ingenic-adc: refactor ingenic_adc_read_chan_info_raw()
  iio: adc: ingenic-adc: use guard()() to handle synchronisation

 drivers/iio/adc/ingenic-adc.c | 56 +++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 26 deletions(-)

-- 
2.43.0

