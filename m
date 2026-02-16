Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29012227BB9
	for <linux-iio@vger.kernel.org>; Mon, 16 Feb 2026 00:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771203219; cv=none; b=QpJYaQZkDirfzC3tq3aFsqzr75WyD4+Ic4frm86PjZ6APXv63Po9JQpYJjY6VTJkeG4waBHnkI2CunqCTsAYCfiiioMsPrKoeHU33Ur5cTBKyZ8mufGZxljwxp7exuFVSuiWBLlufkTYeEAPJdZSzJJZ8VFf2b6Iljhp/+n+ckY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771203219; c=relaxed/simple;
	bh=oxukx3aXZJtxy41mS2hIR8r6iPFBXiaBxMRlw3z4/zU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iWU+q9i1t1coBm5un6Jurx4thedRXk/r+AwexQbCg3FtNs2310pS7ESDAs8P6YTfA5j9fscaLjOeoKfR9nKoALMJRmT0CkNJouKzAaivYdaxH7lEDIt0wtP90N/N3ecQ+ztcBJPWvPnMh6j0+3aYXtqZVK/jHVoD1+ima78WtQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHfyBSDN; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHfyBSDN"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-797afd2e872so9832197b3.0
        for <linux-iio@vger.kernel.org>; Sun, 15 Feb 2026 16:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771203217; x=1771808017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1fGnTHu424Ws0rLROKUNRsDwNzGUG6s88hXG+/JXFrw=;
        b=aHfyBSDNLHYYaFcxWJhiKFr+oreGeVQV3Poy8Em/caXlLGJAdWlRuCHxlzprS1e7RX
         zHEtLsHT8u4JaqVg+h0QFqNLoYm8qgtwwsQXGkWy0rf/ShPbroRChBfxTmo3qoXRhbQE
         tHSwXvPKTR2egKrcFIp7b/n8hsyiUQWr4fUw+oll8BCmycEJ5FI8dWYx8ueIbBrF/sQs
         TdwUbRC8slwy2CRD3sKWcLNxg0EFGASK1SJeoMibj8D4NvLuJebMLuKKLCW8fH6KJ88i
         Gk79wsrDDNrCyeeygSJCGY6f9FkLg/pKwY/QaAXtGwC9poZPQFH/n+fH2JzyaDu6KSPH
         4wXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771203217; x=1771808017;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1fGnTHu424Ws0rLROKUNRsDwNzGUG6s88hXG+/JXFrw=;
        b=YyhwMXjZLMPmfcXSQGpHu/OmnOLVPaa8wxskV6M3asxJvfpvsf9XqplPNxR8WFK3UA
         ykKBQv5+YBtF3zPgkin/hvjY4krY6qeSyVk3DerlNLBqacpSAE/A8XEcfIK5EUDD5tW/
         DeU7ug8kkT2Ca1UlVO3Cm08aK2QgE1CLQBIbHxF1D7yDxbX7qAt2S5cq21cIas/xwLxn
         cCyJ2kUI4r8JcIspFpmliVzPQvQLOI+sA8Y2Wu3wl349qFRfk4d6ULpvKwlUkj4L0ySh
         atmSFSvmoTCEbvT35Vt7KU3vFmz6z8oZ79+zAZvaPKHr4HAQWtxDZB74OVcDPtZGHNVw
         OcLA==
X-Forwarded-Encrypted: i=1; AJvYcCXCphbnxYTsxqFtuDz/zyuhzZl0E9vXnx+joqN2h15eHk21cP3qw5YhPk/mWC3ool/zBCmEl+fHs70=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaVkXcV6RyCb+PwJLLNwZQVVyqiVwbsFdAhZTp8srVIbBeeVJD
	EpVs6e8VfUpdqxG2CF7oNqMd2JoI1Sa8Ae2U9CmjauG8u97Z/p3E7439
X-Gm-Gg: AZuq6aJElBCgaS6BCkRCtKb6EVN5mDkQbtSG2B+BE5lZaglpMBrW0Q45kzUC36VTqFp
	5bT7J8GjSdH+eXU6iuhBcENL6ARKh+wGXeq27KupdvEXa132o10Ui65HNJaBxTBcKbE6qOhIgqi
	7VbV06GiyFhpKZMa/eJCECmcnOVx2gZBlCcPKnHTjzQaCoG/6TNsHa0nkCrJR3AqskGO4WL3XEG
	YSyERudAF6sdaoBexgezH2sQ55KbbIbUlu2BPt4ufcuSOwj0uretr1EeW2W1e3oD1imcyAgqZq6
	tZjtwLW34qeikUvLvecqaMhW/LvvLNIHdOTnzpl1aMAAi8qMDtoC0oHkHq7/4RuFoiFyA5kEh/V
	jjEDaO+3hRpQpn9TxyKo4IUaJdHu8S36Wax5dBTQOV+GTP+DNTiTkVBhVctN0uPIU6E/OFhdPrG
	E6sW9I6cSZruwZJWPZsi7beo8bG63fYQT/gOuFb/GCztBj3Yg9Ps2INlW/ENQGfpvttyXAwfF0M
	5ghE2J6aZTRDoOS6pPpqVzEM/PwVorbMnMz3dUNvLs=
X-Received: by 2002:a05:690c:398:b0:795:24db:a09a with SMTP id 00721157ae682-797ac60f4f0mr48038327b3.47.1771203217003;
        Sun, 15 Feb 2026 16:53:37 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00:e3a8:26f7:7e08:88e1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c257ed5sm94797637b3.45.2026.02.15.16.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 16:53:36 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH v3 0/2] iio: light: gp2ap020a00f: fix return type and simplify locking
Date: Sun, 15 Feb 2026 18:53:15 -0600
Message-ID: <20260216005317.11763-1-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 is a cleanup that simplifies the locking mechanisms using
guard(), as suggested by Jonathan Cameron. This removes the need
for goto error paths, making the subsequent fix cleaner.

Patch 2 changes the return type of the helper function to int and
adds the necessary error checks in the callers.

Ethan Tidmore (2):
  iio: light: gp2ap020a00f: simplify locking with guard()
  iio: light: gp2ap020a00f: correct return type to int

 drivers/iio/light/gp2ap020a00f.c | 77 ++++++++++++--------------------
 1 file changed, 29 insertions(+), 48 deletions(-)

-- 
2.53.0

