Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45F74766B7
	for <linux-iio@vger.kernel.org>; Sat,  3 Oct 2026 19:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791057019; cv=none; b=LRfgJNgjRpOr/hhUpDfvXnBABQwrDalNJmJO7/M89J74V6741BKmZlXQ+UxBWRDRdhHXqqja1425gpE/PQUyq/utOvH4fF7AoaDuYwG9oLtxU+cpsmOsy6cFcAjDwlQJewPlchbgWrPZ1kEFrG1n026kk6F8SAh4G3wBId/sxKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791057019; c=relaxed/simple;
	bh=eeV3CiqVqLEdOwuQRHoVaunyWI6kSVjOdbtx1bppoXU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mg3dI1E7itQO5CY/VqNcnHvsk9K62alyprSlyK9Dc7Z07NTvYYSh/S6ZwVCwFn/DIqS2nOpkOrEw/Q4qKTRMtz/QaCCSePMdXz5oijXwpKMqPPTqfKvX1ZUPwxha9TwqIxT0reNzLt0LhQtaHvZd8QUQdTKmJaHT/hvESjyGciI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJmKk69L; arc=none smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJmKk69L"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5bb5d3229d1so402432e87.0
        for <linux-iio@vger.kernel.org>; Sat, 03 Oct 2026 12:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791057016; x=1791661816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2xA2NLj6ds9nMunLFHFPpvFZmRFdu7AG9PlEOdmxqkM=;
        b=lJmKk69LRIJ85rXdJwFQ3y6XDaIgHGod56sCfNmWn30exlxNi61mAi9gusmZK7lOtE
         aYHvu+Ypps0c6ytsTzVyONePavNIOLZs4DOsGgQWSZOuH87VFSBZTwEAvYyhULADlxS8
         trtDmc0cdS6D8eQbTdDscfpFEDur3Z2nF2Cj9Z9WISByHYHHo3Da4VU+LV+rrdsEYt2H
         bj4etLNzwYHMIz+vAxUcjLyi4vH4prDBD4QdYws65BlSCf1JAkrdOSdh1KlIzo4Opi+b
         ty7Bso4oSwiV528uJxDBti/AGlZbDKD3m365pTPC0gE2bhDmmpmjIzp523chtA92ePPz
         zuwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791057016; x=1791661816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2xA2NLj6ds9nMunLFHFPpvFZmRFdu7AG9PlEOdmxqkM=;
        b=0EE8ao2mMwmL6vA7KZ95f52SUikpGz4DKk9tI2dqhQUcTkNuKqS5roZ2p64QhbTh46
         JAClFqz8zRK2agbQCrBpJFk8JJr+bQ4hOKi6i/nPRdLqPT4LCCyX/MZYS3Svkg5mg7DI
         gOtRzfH5dck6L9zBaqtDkyWzG2G178kVGi0Sm/zCFOwzu7+EIP0C/rDnrNLe9xOQR+g4
         jeh/nWAIMC9Ye7O+1R1UCIhiaxmmbZJ+JPG1WNmc1xVzavZCkRWSIfvFaZ449HTGehz5
         z/KORjKksFnePlPGY46Ba22sCKklCUKPlomCS1kXsfbopcbytSKrVumsyeRU08sQ4oiQ
         sFJw==
X-Gm-Message-State: AFq9FYLqxIrVNfAkIGGNAwZKMPDaLCz3/vYdqDIMPBfCdss7y+Mv9i3c
	v0tW9Utljy+PMtBRnSlcLyxl0GmVmK27z5XHNPIDYfHIyMPkEu8ZUQ3mTSxaZNJp
X-Gm-Gg: AYBFou2aehGb//brK0qat05LGAIe5lDTbSr1Xotk/jNtINwzdSL1zZdDwNcoEiO32/L
	JHzcbOMghhEV9RzE0SYs3tJP0BJoFL5KNcRwYztYQWiTLm+PK6xesk2cEYb40jvbO70T/OkaINN
	E8cgOyMP6MJ1TQt+in65YUMF3csQ6zHy6DqRTNYzirYeQjWrfCgkERXqaAih3R9nOLkNGBUi5vy
	HNJi1Xz816Ht1dqQCkrKl3k2AYk76fFi6HLL5TxVOsWO6+QlZJl/Mp/k+6nCxR5F5wKM/v2Oeee
	WF7vH9DhGEWXtOLHmwbqOi45FyCuIWmKh8OyI5JKpsmHP0gr1PlnBW9IHVA35X6cErdbVddmV9h
	bdbZdE+K4u/PiDgjglucRXu0wWl4w3TUIm4wXOpfrSpzr9AkO3AwERac/x32BZF8OM9Mxo8DtZb
	1EoOPOXIWmNUYel2V3ul5uychPBJCs4YNC9fuMn5k2ov7X40GacJVfiJrRmiS0LngwEYyjcqHWA
	IyDAmYThj2Noiu/SBHluYmZ/UbhNVfOue6mjXBZVodLH7vWLlFug4etBA1n5FcvPumI+QI=
X-Received: by 2002:a05:6512:340f:b0:5b8:f333:db97 with SMTP id 2adb3069b0e04-5bb86e73f99mr2404170e87.0.1791057015678;
        Sat, 03 Oct 2026 12:50:15 -0700 (PDT)
Received: from yantra.. (dsl-trebng21-58c187-236.dhcp.inet.fi. [88.193.135.236])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bb7c7abdbfsm1762608e87.65.2026.10.03.12.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 12:50:15 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	Bill Wendling <morbo@google.com>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Rupesh Majhi <zoone.rupert@gmail.com>
Subject: [PATCH v12 0/5] iio: pressure: dps310: hardware FIFO support
Date: Sat,  3 Oct 2026 22:50:06 +0300
Message-ID: <20261003195012.92948-1-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rest of FIFO series, on iio/togreg which has 1-6 and 10 of v8.

Since v11:
 - patch 1: blank line, Reviewed-by Andy
 - patch 2: guard() in postenable, setup moved to a helper that kfree()s
   on error, scoped_guard() in fifo_work, loop counters in the for,
   ternary on one line, two comments trimmed. The first loop in
   fifo_drain keeps cnt outside, it is used after the loop.
 - patch 3: signature wrapped
 - patch 4: drain comment and commit message trimmed
 - patch 5: Suggested-by Andy back, assert in the new helper too, still
   optional

Pressure overflow fix is now at v4:
https://lore.kernel.org/linux-iio/20261003185716.32732-1-zoone.rupert@gmail.com/
Patches 1 and 5 conflict trivially with it. I can rebase on whichever
goes in first.

Retested on DPS310 with BeagleBone Black. Lockdep run under QEMU.

v11: https://lore.kernel.org/linux-iio/20261002072526.250081-1-zoone.rupert@gmail.com/

Rupesh Majhi (5):
  iio: pressure: dps310: use devm_mutex_init()
  iio: pressure: dps310: read buffered samples from the hardware FIFO
  iio: pressure: dps310: derive the drain interval from the watermark
  iio: pressure: dps310: implement .hwfifo_flush_to_buffer()
  iio: pressure: dps310: assert the lock at runtime too

 drivers/iio/pressure/dps310.c | 441 +++++++++++++++++++++++++++++++++-
 1 file changed, 430 insertions(+), 11 deletions(-)


base-commit: a3b3580713f3ac5a32dc2874ee546828977a1d68
-- 
2.43.0

