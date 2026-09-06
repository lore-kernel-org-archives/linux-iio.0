Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAE737F304
	for <linux-iio@vger.kernel.org>; Sun,  6 Sep 2026 10:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788688979; cv=none; b=CtQEO//OUBlWzh0FP9XXm2l0FSx56h4tIa/SUZwVwrY6K8T1tQjPlfJMjwGJqkQC5d8ptdpxVJM4zUr4Ea/qXoosehrtqHnetAWGGeCbpKw1FimcZjYCiCvNa0vghJla7yXwNLT4v3ArwtQ1D87PzebBJWFk7HE0d7WFZleDqv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788688979; c=relaxed/simple;
	bh=IC1uCXmtgjcrdcBjucQzryI874h8wBozNrYWy3lJKGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OmBp+rHoYitZXOoqCeyfx/Levljj+YDDRVX+r7ayGm8FTuymY2Cv8BCamRakU7igAS8ULoylDaX/Dm6dS8GL7TgaTvq5pZHPx5YIpTw3DdrjXFPekK0dGZ9r80ELpy0R1YYHDAp3i9HyDkCJQEV/Ty3XgtGpUlY80gBqs3uRLsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ha71Tm7b; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ha71Tm7b"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5b4a95ab94fso3534400e87.0
        for <linux-iio@vger.kernel.org>; Sun, 06 Sep 2026 03:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788688976; x=1789293776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OiR9dFdTiyluo58cBb+DtMhNZ/Aaatk8gf6hWN59PoI=;
        b=Ha71Tm7bjnwpIzeUJZEVlTdekh4E41/dKZDdyapR1wtad1OOl4747RePRQJRQaly8z
         0rn8Ja/2tVoaxRmG3TEY4yjM/2Pon2GBAWG/GYky26k2pDEfyDdlmtW2Obz9zNxG3JDn
         /TL2fXFE2rCBNXEqW70HsHchHTcmm7HpOrOWAWp0X1yyXwYtdLIWStPl70NmBigKxPOG
         DV0a0Dn34ivkpZb6CNog/zSUq11IX/tzy88aSqRyNx6vrG2vyicMFNTXvyvFZlNeD5D/
         wRblDpEdWfvtcO5TMx8ag00bmogKMy1PeZNUxPsHwoiBykaxetln10ixL5D4YFsrGprh
         tvEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788688976; x=1789293776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OiR9dFdTiyluo58cBb+DtMhNZ/Aaatk8gf6hWN59PoI=;
        b=ZQ8lsAkoxZdxt+4pl+5hYfnNdKjTbgJpgtv+958htlrAsPmlrc6W/SlxEFOLmeUv8K
         g9JbJmsclbqbXz1r+i429cJBhStAIGB5voTUXghq32BYY9u15P9vup/W42s0sBXwhbr3
         uO/G92gTpeaPzfyKUOsAwHg7n2zNSkQxMVTpHd5M8MqFrzV3VOh9zyVyCpaGgRIJiekm
         PiH/jmbV/Vko6/YiQbR5KTlOx5haxX916zmNNUEj81U6C2TPan8ulXtKn+qm5YsMm/bT
         G0+frSEUge9RBDtpYWjYgTfZbfmOMByAMUiYlhTEP9+QNxNQ5ITnOM0CqXClj9pv9OLy
         bpxw==
X-Forwarded-Encrypted: i=1; AKwUvBxWTqfwNHAd3QBdj1kPzglntgI08ZtEyUvb7sCo6T4uWfohzJym42bZoyFPmnMuY2n/HgajIF19pzI=@vger.kernel.org
X-Gm-Message-State: AFuF++mu7D+U3tux/9OEpQzML95pR1GRFyvjPLHAmw+5SaHsKWArIq1c
	lXfq5plYAI02pGb/RcALSNERV5JiCmFRHAlxTydOXhPGrGHQmnuizTsL
X-Gm-Gg: AYBFou1sUfNDKIO9KaCKOHPmRWOrfBkbSh+j0PtZueMkKeo0J/X3AQsTjNmG/TIbgeG
	M8EMWs/Bakz36I5Pb5kEVWkx5uM4lNQojGwXLL3lphCtSsfrznSb2eC8Q8r3aJLAHX+9+9B2yQJ
	YHeDzYJDgRtvYHw5iHlvpxR1mFOdwFxjtrKRpqPZ5TwrZQwqfKG/aWJgV4/gZkYesqJdqgxdTmj
	j1rhO+NJrldu5QoM0A/W8+wfxROqCp6jF9StmpbCAM1es3tOwyvLa5C/G9aRtOyAPrfaY/LpqDd
	ebBRJWnWU799xTugbhWZxqnuSHwXJKI0ZwkrrfMqQuDh3ewg00wdCn3jwLZrdJ9gFbanNYYV/A1
	Q4ifBPIJ3OW+Ke0LfBQd+W+tR7a+L8zc95D+fYTZO/qdzFLOz37t9qkUwBYItcWOnEdo7le8y39
	bf416vQwZzop/NxD7fE7ZniRoj30DWps0naFgTp9AQejXlu1eKkB2nJlkDrvypgJOMYTbjhBEtz
	2jq9chpppFXUvht/lFH/qTFQYt6nf3vXff80H5S8suTKom9HBGUpvm7uRg=
X-Received: by 2002:a05:6512:104f:b0:5b4:a798:2630 with SMTP id 2adb3069b0e04-5b60e6a536bmr3218881e87.3.1788688975659;
        Sun, 06 Sep 2026 03:02:55 -0700 (PDT)
Received: from yantra.. (dsl-trebng21-58c187-236.dhcp.inet.fi. [88.193.135.236])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b616700006sm1548665e87.57.2026.09.06.03.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 03:02:54 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>,
	Bill Wendling <morbo@google.com>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Joel Stanley <joel@jms.id.au>,
	Justin Stitt <justinstitt@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v6 5/6] iio: pressure: dps310: add hardware FIFO support
Date: Sun,  6 Sep 2026 12:45:04 +0300
Message-ID: <20260906094622.433243-1-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178813888151.2788519.16547013180884814648.b4-review@b4>
References: <20260824201203.396651-6-zoone.rupert@gmail.com> <178813888151.2788519.16547013180884814648.b4-review@b4>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 31 Aug 2026 02:14:41 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> Dropping data rather defeats the point of the fifo.  Can we avoid it
> by holding them locally until we will definitely have seen a useable
> temperature?

The temperature is dropped too. dps310_fifo_drain() sets fifo_temp_valid
only in its second pass but returns at "if (!scans)" first, and FIFO reads
are destructive, so a batch that pushes nothing loses the temperature it
read. With pressure enabled, only a batch holding one ahead of a pressure
entry gets through.

DPS310 on a BeagleBone Black, pressure only, 32 Hz and 1 Hz, 3 s per trial:

  watermark 1  (31 ms drain):   4 of 6 enables produced nothing
  watermark 32 (484 ms drain):  0 of 6

Other runs gave 3 of 8 and 3 of 6. Silent, nothing in dmesg.

Seeding instead of holding, one temperature read in postenable, fixes it:
0 of 16. But TMP_RDY is cleared on read, so after a sysfs read the seed
waits for the next conversion. Buffer enable took:

  temp 1 Hz:   661, 781, 802 ms
  temp 32 Hz:  148, 151, 151 ms   (period is 31 ms, so this is the floor)

Timeout is 1000000/rate, and on timeout dps310_ready() reinits, putting
PRS_CFG and TMP_CFG back to defaults. Not something I want in a buffer
enable.

Hold across batches as you suggested, since a 31 ms batch usually has no
temperature in it at all, or a non-blocking dps310_refresh_temp_locked()
seed plus a validity flag?

> For initial patch just reject starting the buffer if timestamps are
> set to be captured.

No sanctioned way that I can find. buffer->scan_timestamp is private and
kept out of the scan mask: active_scan_mask reads 2 with in_timestamp_en
set, and validate_scan_mask() sees the same. indio_dev->scan_timestamp is
reachable and iio_enable_buffers() sets it before postenable:

	if (ACCESS_PRIVATE(iio, scan_timestamp))
		return -EINVAL;

but it is __private, used only there and in
iio_push_to_buffers_with_timestamp(). That, a helper, or drop the soft
timestamp channel for now? Triggered-path timestamps are real, so I would
rather keep those.

Rupesh
