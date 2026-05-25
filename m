Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595C43CEB89
	for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 07:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779693377; cv=none; b=R9izJPWdQhkFdrcojxIb0x4mZ6DyUtfHToOlFsDS+4ox/JMGHBPFcRKnvV9oS1mu+QLk/xioAFyG9Mn23jVgl5efvCzc6MOLgnycK9TlpjN/0b9o+YNtTQL8gbe/AKAcXwkk3cLVTCzoPJmeN/8vlqFD7qOcMZw+tSXyr1nXYSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779693377; c=relaxed/simple;
	bh=yb9iCBjubMy8cqbf0mqGvOkZzltsHQjCblbvEcLwPEc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ygx5+KBJcq7hlxi3XFHXDEtPkFEvtcj4ePgRIU7oKwx3hL/B5L6wQ0PDQAgr6jpNwIO7oatefjMltVktX8coqG4Sb9fE8JphDgJOFSXORWX65+nbgeK90LY5MFA+q0ydNPGF7TlHi8X3aFZmk25h+yPTmrRKuvRgsQQaB/FcDII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dknh6AI0; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dknh6AI0"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-459bf19e87bso5346107f8f.1
        for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 00:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779693375; x=1780298175; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BK08x3VsdmyZ4ejRvlhzjQsojnP0aGkq6kwREEPRSvE=;
        b=Dknh6AI0Sb/bzcgxoWXrYojoIihLMj5O4+E5U1hL/jKwDEHYEoPmzYCHy5OzTDGVlu
         yR27Qt8AopL3gYSxVOlZMZHwWOOcTOh0B52HBLwoCYCCvrCi7zj1g+ZLrwXaRGOLRNeq
         3vt8lqAeAzae4ZZ3jk58tP2A1fNMATFXTc+mRVqR8Zad6DMhsVU3QKGZ80iIOqJNq4Ku
         UPzlO73+QydIgcU1GiZvpCvdKz1j9fsW/xZVWTyMeWb1wodhCf24tS3DeEcRCCt3nas1
         nmRFn+kSG2KLXqw+yPSiNl5IjqkgaRWvhQ/f+MU4018dYEIwmqprBr6TeeLy826IlY8V
         9RXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779693375; x=1780298175;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BK08x3VsdmyZ4ejRvlhzjQsojnP0aGkq6kwREEPRSvE=;
        b=cby6lbtcUnKn+sCak+jFOq5fmAdK6D0M7AjieORVVsj2Yz4uwKOoe59md2jm2r/5rU
         dcq15fWAUq3Rz1pBhqvsHzGNmSUfq2FNssWQSPcz6jcTzp1mP9I45MHVSPelazGhX5k2
         4EUAu+GhKOPbCcSEqdeR1Mz/LyUwVIybAD/ZRJmL45iDwVBoOL/ae/l358N9HXNoWIM2
         iFZcU+G6BfIm/mLilC3EL3c6lqhCbD6c/mdtkMlh6TgBAKb94RUBe8BbZAsOFfXKRfrs
         JHYmnZD8eRHnkzUT9Oe6APb6m9eqGobGHB2zS0pQKEixpFlZwR/rcWxTIh/Cd1QN4BBy
         DEng==
X-Forwarded-Encrypted: i=1; AFNElJ9PSGbKQdQAmXKIi74FTHt3IaRxkPUqXYrItshl/dOEivQYuuey9tqkVyL7prSHVw+Fecc72mp85Bs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeyzV3RQwUax4m0AEr2Tqr0FR+WqmUGAFh8de4ZK5SEKc/LwOx
	ptJgySI+21g9T6OZ+lh3sMM8RXjZg+nb7V4Y04pIcdoVFOs/TXo4mgw/vFDksw==
X-Gm-Gg: Acq92OGaFsHng3+qPsQkiapQ7aP6L0wMvFF2PwHsC21IGEtotRvmIqTYJPQI46c8LAv
	UHoHDboxPxf9AWTQvbZDPjfRULPHW7VqFdxP/xUDZIqzAnGrMB9eTIZsGerkbjNkQ/E1c0JXJdJ
	DkumHBuG8KYXmw1K0xU9ZHHUvWU2VKoAWcoSTbtFTfTHluf5hNTuZ7NFFu8XteRLLyjPSS2YSh7
	Jl+H1t+0BKXXiFrsZfzB9dWAyYaoXDbkdEr8U9NR/y9Ga732fIJJbawK83CRwD2LzlvA8S42S2Y
	8dfVD1S1vIkLNPIg2Ngo8lVrwv+hXB5xZ7gLI9id8oVczXNInLfuwHQOtC/cLKV2WyP0Hirn22o
	QBVo6bnIb/AqpqbjMep4fNT1H+zxjr8MxrBA2czCmD2oa6rz3KZzfIj1kubWKKy2LmXzUaUEAIz
	wBiAaahicIzo4VzioM7fm8KuU=
X-Received: by 2002:a05:6000:2003:b0:45e:653a:40df with SMTP id ffacd0b85a97d-45eb38e4d0dmr20990334f8f.41.1779693374740;
        Mon, 25 May 2026 00:16:14 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6c9dd03sm27464361f8f.7.2026.05.25.00.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 00:16:14 -0700 (PDT)
Date: Mon, 25 May 2026 10:16:11 +0300
From: Dan Carpenter <error27@gmail.com>
To: Nuno Sa <nuno.sa@analog.com>
Cc: Olivier Moysan <olivier.moysan@foss.st.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] iio: backend: fix uninitialized data in debugfs
Message-ID: <ahP3O2tQdu4dNx_c@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

If the *ppos value is non-zero then simple_write_to_buffer() will not
initialize the start of the buf[] buffer.  Non-zero ppos values aren't
going to work at all.  Check for that at the start of the function and
return -EINVAL.

Fixes: cdf01e0809a4 ("iio: backend: add debugFs interface")
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
 drivers/iio/industrialio-backend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index 138ebebc9c0d..4763e224ebc6 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -156,7 +156,7 @@ static ssize_t iio_backend_debugfs_write_reg(struct file *file,
 	ssize_t rc;
 	int ret;
 
-	if (count >= sizeof(buf))
+	if (*ppos != 0 || count >= sizeof(buf))
 		return -ENOSPC;
 
 	rc = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbuf, count);
-- 
2.53.0

