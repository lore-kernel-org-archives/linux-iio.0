Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00979307494
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 17:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778519811; cv=none; b=FW7m0rzo4J8gznGrrmyZPe0ZV7xx8bayXlW9qNTO6/zREp3e3tQDgqI0Oge79wKOUqP5ZdlHzlAZWBfxNgZFipKgS8hYwJcBXTEH82u2jcYMji6I4IoG5Aeqx/VpBSX1bhQdW24Ds4FJQFc4tU+pQcZl58ouUETf7AKgSwSL/DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778519811; c=relaxed/simple;
	bh=BK9GLd1UwSB3+W8RCUzeo0etgss621SAoE+XytNw0yM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L15m+lKbWolxv5dqVMGVe2GdFS3clrN1zYpr+Z7kAp2HLgJ5THcSsTL7J+pWh9hCFT5j3nwQoFRbvfBmHryYrn8gFw9mBua8z1Xc5dHHiuO8ClCzzCgpH6iYdZCSEathO1ysZzCpltQ3n/yQ8SbhP2ACXQqvBrc0V6BDShpg9s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDkPyhBW; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDkPyhBW"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-366375c43c2so2556582a91.2
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 10:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778519809; x=1779124609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=stMxmINA3VCiziLw6MUjzC5yUO3BG/atHh430opIYqM=;
        b=VDkPyhBWzIaFfjYpGh2Pp8k3bFHaY8D96/lLdPH7sAB7J5pADSL6Ez5rIgDbsHblQN
         b7VJ6GTq6jABeF9x5YtBOEdJ0fQW5v2H31F0NSqWEyDPevVvMrSbe+H//d5Slc5tC558
         frzP2ZmmlvkJUyITA1tvao49Ng79Tbll2shRx+WANe9XMiS+7pBsVVJ7GLuHd+AcWYEC
         gYWgo4bl7BAcWiYWdzPzE+OIEQu8uqWhzAcHAG23WKBziJT35iB+OIy5O6N5Ge7b7fVx
         QnzaP9F2kWx2VBQLamKnyXiCOMYaTROup2ckGa7iRYfnLKLlzeSPMid5+DyG/81ArajC
         AwvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778519809; x=1779124609;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=stMxmINA3VCiziLw6MUjzC5yUO3BG/atHh430opIYqM=;
        b=pDkq95D8P9EpO6ZXIeI9aXkKIR9/pqN+qS3tunYRbpiqixbdakluC40Rviu16X/aI8
         J9V17zMrCd5YuSk+Jmny3CfJvK0DFebbzinCa64c7u/PVrh3KGiiuSp3MEFnqUzMp96f
         0J0NxQ0DBwJDFso/pKDsxAW3N/p42Ruxb/uKBgwE4Y3rYUX+1f+/Uze/OFGsYPJWnXw6
         hK17D5g+JWHv+m3ghPJaZl/7Id07Io5dtGUoBDvjaSFwsmpxulenILpbxKC2etvZWk6w
         Soe1VfxOvIe+8SQktZxgEE1+LYts4JyprExK6DHQGvPGuadZUdbzjzD4WIKppBtTugSe
         u/Mg==
X-Forwarded-Encrypted: i=1; AFNElJ/hV2FtUh9fhoCdmzeFj6ZEFKY3AmJl+gIaPg/AiS0SI+a7cS+q86JoM6wt7nyD2To2RlbSCW/OrbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNNvNQLEe20V0ip15hBPzxMjkD5b9Bbacrg/0mG2rprzGg8459
	O40ZLYqWGSszlJDUecQ8ao/6Dtv7hsQ3caVh3OMEQbB9hXeIjuLOw1Tw
X-Gm-Gg: Acq92OEESbnbK+e5r15aeSD1xqcN41FBW41O0XTIt7Anlbb8E2QtwsLIvOwAhDdkLdL
	Dr2YuLRVjlsCOZqgbBAQl53K0jvhrI79QfptTRS3qVXtuK7WyYeL6yzI7bE7S9Ayg867/FxZwZV
	kuDlfWTBcTypQZkyBrpINwPEA0sJSAi+ntpP0sz8opdXjHoLF0NuRYTOcM+7DAnD1R9uduEup4X
	vdgd/YX4bQvFsm438nZwRHaOJmHkraKPBloM6cHMyId8qh1122uWt80cz8vvCOpED0p6K5s9XfJ
	sJIH5cAQnhzoFIVSub1R05Wkq4EX1RN4ebQEu7Asw3DIf2a+4LbdDw2+mdJzgJurnzuktZD121v
	t8++RLunX7schtoVg4HjJZXe2Le49hpSNlWxNqztK3oGu6CHe7GooCZTLQNZo9XhMPUwLzchNra
	lXSsThGx2PAxMA5pMZxfF7vimHP3Wr4gynrRza37xfoKujnFmx
X-Received: by 2002:a17:90b:582c:b0:364:7a37:4066 with SMTP id 98e67ed59e1d1-3664ccca676mr14075564a91.14.1778519808919;
        Mon, 11 May 2026 10:16:48 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367d660b9d7sm8315004a91.17.2026.05.11.10.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 10:16:48 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org,
	marcelo.schmitt@analog.com,
	nuno.sa@analog.com
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	sanjayembeddedse@gmail.com,
	linux-iio@vger.kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/2] MAINTAINERS: update ADI IIO entry and specific IIO maintainer
Date: Mon, 11 May 2026 22:46:41 +0530
Message-Id: <20260511171643.3173872-1-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Hi all,

Following suggestion from Jonathan and ack from Nuno, prepare change
to add linux@analog.com list to has always valid coverage for ADI IIO
drivers and add Nuno as maintainer to oversight the same.

Additionally, following confirmation from Cosmin and Marcelo replacing maintainer in specific IIO drivers.

Changes in v6:
- Following input from Marcelo and suggestion from Jonathan,
  instead of dropping IIO driver entry replace the maintainer
- v5 link -> https://lore.kernel.org/all/20260507175132.3063161-1-sanjayembedded@gmail.com/
Changes in v5:
- Add Nuno as maintainer for ADI IIO entry
- drop entry where there is no active maintainer/reviewer
- v4 link -> https://lore.kernel.org/all/20260430190642.3434650-1-sanjayembedded@gmail.com/
Changes in v4:
- Use ANALOG DEVICES INC IIO entry to catch all entry of drivers where
  there is no explicit maintainer then drop that redundant entry
- Prepare series of change(s) as suggseted by Jonathan
- v3 link -> https://lore.kernel.org/all/20260421165856.2245598-1-sanjayembedded@gmail.com/
Changes in v3:
- Following input from Nuno and confirmation from Jonathan,
  replacing domain specific maintainer with mailing list.
- v1 link -> https://lore.kernel.org/all/20260418211336.1800221-1-sanjayembedded@gmail.com/

Thanks,
Sanjay Chitroda

Sanjay Chitroda (2):
  MAINTAINERS: Update Analog Devices IIO drivers entry
  MAINTAINERS: Update maintainer for IIO drivers

 MAINTAINERS | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)


base-commit: fb1a945cb96b8314c41e1b71fdc3297fea9cdb64
-- 
2.34.1

