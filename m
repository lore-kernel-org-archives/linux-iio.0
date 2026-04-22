Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC632BEC55
	for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 22:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776896807; cv=none; b=GBHyXRHfw0Gd7gdwTWJkCUlFSGhNHIrg4Nx7Arzz+Z31rPNi6ud/pQDDmpwVtdjGKHFg4rGlGfBSeUAySvYBfdoisYIbktCswnMc5E2nvU6cMeILKNgjhRBrk2JbBFa9nFx7zagm5Ok19scNIhJeigfc88Zd7glrk6vYIHX923w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776896807; c=relaxed/simple;
	bh=Nd7azzylrJ+N+IDjJAmi7vqKxHXKT3ql+YBNkYbav8o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bjYH/mze9Bju8kwWJakYB5z4+13x3OaIPSYJo3jjSdq15goKwwvog87xQwdoION4qbuboQVf9HpV47m7rRUaCl2VVDcdvuMjJkgt3boQpopkwYgkHfHQtCLsyvmwCS5kEjNQyF8dELO6Un7jcokBc84rODn+D1jwNgwZ3Pyx61U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=APXKLynk; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="APXKLynk"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1279eced0b9so8858720c88.0
        for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 15:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776896804; x=1777501604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PIGgNjgrn3QJwW+SzVSxSfuAniDoI3albKVmYE4aQYM=;
        b=APXKLynkUkKFn0gMjx8FCuGGkYoxAwylrW21GHqZ44UNOODRHGu2+HDCkrRkpiS3bL
         dRgYZsZS2PURh+SK1/2TEDFSWuiEAuwanagFHIAPBCa4S4Em3TIQJt80LAMeVMiZCo4s
         QW5m5tPVHBvcvu0bO1JZMTJvd5c1qRz4KlmptYSrqSGSrtO5t2hAMKr/lFt08aDBxgO5
         T2pZvuiDantkodAtvaEgzGMRFe2K7VudpApLUWYAdQig9tRudQl/dqd9u+xoFqd+nb9A
         fDQC5JH/5O6kD4WR3PKR/9FDnvqWPLTl0GdYmt8axT9BCdhKzIjfY/iJw/frpQBQxi96
         /Rqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776896804; x=1777501604;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PIGgNjgrn3QJwW+SzVSxSfuAniDoI3albKVmYE4aQYM=;
        b=jBcXyWOfoWALpfgyU/Qnbj35eGtcpUlYJvo4JgENmakwdcPye5NLtUqn9f++o0qbbr
         XbAZH2PlBxykybWEbxNr7TsOIFoBfG/xtXMOpKW34PPmOvxXhgyjIPhHhndpPkjtwP6D
         RnN5qlstLHkyQEwPG2RDNeFbM4ib2Hh3TjJC3Jsm7RJkerxgklXof1l1tt5q8o+pr+vn
         mHChtpSvet9RGGODG0rw7DmEfVXGfPi3JwZMU1yXbLHzpM6SglyiMaf1jPZyOFCp/X7u
         gxNvvbD2z7qHMJx/GlDQWvB4Y52/RcLmJNqYJVBenRUpwoyMC3w+ClxcNG0PplzYjZKA
         wkbw==
X-Forwarded-Encrypted: i=1; AFNElJ/1a/QSQeRqkL22RhckmrezdUF7uyBsX091v92q8cYayIBkWTNRs2kgHFUQCVNLiy1IcuIAecX4V+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YysUX0gGsv57NSX90Uw1PtfXGQQ/fEqIYYTwI84+fIbtHj6ePDO
	aB282iHy8XqHDABdVzY9Qoy7Qsg9uWo/EfwXXSHc6b77EuwAhcHzf+ZbmKP2oSukd+o=
X-Gm-Gg: AeBDieurP1S3bOIXt42r/70PzdTgkxRfKx8ocl2IRBqnqUhm2Id3MGnu4HcbiN4uVih
	BaJ9ySF238RcCho6QSyh6L7JIjpCIxRUMGMJ5dBLceeI0yUAqNHWOeJrYnihu6+M8d/FaNH/KbK
	yl5IfbHl5Xu130jeDRx78V9Tk07pCNbuXiCiSwKYJ4wo3HbXO+i9+gk3uKksLUGrlzC8zdEvDbc
	0vW6KIJImwUVxtZ9LGCa5GNrpww40PGnspK0wJDvk7dQxWS8upchuB8xdhTeZsUxBwXu19yrV/t
	jLP2fxn2x4jGRBX3/F/erN7nUzlF58aNaGqbeK5NjauEiZHR06/4szzHL6gxLw6WZfRMC7/aW0n
	uvRr+az8Qz3UqalD/m+ODb+wHdO05it1BlmmoH4xEuP63Pv8Hrcm6QhuRw3PesYB3M15D4wxhkA
	jr+WYltYfuiFub5jstcQ6+kpYdmZEOTUSZO4JSHDnwhgSQNJnlm/OmIhvH
X-Received: by 2002:a05:7022:60f:b0:12b:ed30:5a32 with SMTP id a92af1059eb24-12c73f6e183mr12484905c88.5.1776896804277;
        Wed, 22 Apr 2026 15:26:44 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:190:8d7a:cdbd:474a:802:34b])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c837f7feasm26293952c88.0.2026.04.22.15.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 15:26:43 -0700 (PDT)
From: Gustavo Pagnotta Faria <gustavo.pagnotta@ime.usp.br>
To: andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	nuno.sa@analog.com
Cc: Gustavo Pagnotta Faria <gustavo.pagnotta@ime.usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH v4 0/2] iio: adc: mcp320x: bitfield refactoring
Date: Wed, 22 Apr 2026 19:14:11 -0300
Message-ID: <20260422222553.67660-1-gustavo.pagnotta@ime.usp.br>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series refactors the mcp320x driver to use the standard
Linux bitfield API and sorts the headers alphabetically as requested.

Changes in v4:
 - Separated the patch into a series (Patch 1: sort headers,
Patch 2: bitfield refactor).
 - Fixed style of MCP3550 comment
 - Avoided variable reassignments (foo = bar(foo)) and used explicit
temporary variables.
 - Replaced boolean casting (!differential) with ternary operator.
 - Fixed line length limit warning in the mcp3301 case by introducing
temporary variables.
 - Fixed placement of RX data extraction in the MCP3550 block to
strictly follow the descriptive comment, as requested.
 - Link to v3: https://lore.kernel.org/linux-iio/20260422030846.45317-1-gustavo.pagnotta@ime.usp.br/

Changes in v3:
 - Removed wildcard 'X' from all macros (including MCP355X -> MCP3550),
using lowest part number instead.
 - Separated Tx channel masks for 4-channel (MCP3004) and
8-channel (MCP3008).
 - Added comment explaining MCP3550 Data and Status bits usage.
 - Replaced be16_to_cpup() and be32_to_cpup() with get_unaligned_be16()
and get_unaligned_be32(), moving them inside the relevant switch cases.
 - Fixed accidental removal of '~' operator in MCP3550 overrange clearing.
 - Link to v2: https://lore.kernel.org/linux-iio/20260420215021.14112-1-gustavo.pagnotta@ime.usp.br/

Changes in v2:
 - Sent previously as an unversioned reply to the v1 thread.
 - Fixed typo in author's email address.
 - Link to v1: https://lore.kernel.org/linux-iio/20260420212405.11789-1-gustavo.pagnotta@ime.usp.br/

Gustavo Pagnotta Faria (2):
  iio: adc: mcp320x: sort headers alphabetically
  iio: adc: mcp320x: refactor driver to use bitfield API

 drivers/iio/adc/mcp320x.c | 89 ++++++++++++++++++++++++++++-----------
 1 file changed, 65 insertions(+), 24 deletions(-)

-- 
2.43.0

