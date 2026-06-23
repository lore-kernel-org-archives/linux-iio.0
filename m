Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0823138B150
	for <linux-iio@vger.kernel.org>; Tue, 23 Jun 2026 17:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782236767; cv=none; b=CDFjoX2l5StLmg7w0D6WmcHRRsm5dNxi1NrKvOx/ive5IMvooI5xHqMR5GBYNoed/x9jYalW+DBKZw8qWLWALmROnhI9dV2be49Gd779LINvI4cRs3T6mgQw3N3XmZFEr3NiKGLfHh5LJk3rUM6J2wBqs7ZUTm5Oc6scAgowFEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782236767; c=relaxed/simple;
	bh=sukjri55wrG3E+ufMA/rcm4a1WNGsJyJAc9J8ENXGGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RJHbJQ4k5BQG3ePaqCGBpJk/s/8ZqYxsnTgv3oAMXm6A1YtH1U2Lqt7NutZ2lxFa4/TLH2fpljbLLepXS07tX2WmrAildKGz+uBhEQKipDs7Vta7cuJN6gDwdH6MnvIVfC2V5A95RtOakguqNkxZKP6jGTYUjT8yTT0s5y36jDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/HWPRaB; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/HWPRaB"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-39957d210f4so1061741fa.0
        for <linux-iio@vger.kernel.org>; Tue, 23 Jun 2026 10:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782236764; x=1782841564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ashQPfCGiqIse4wQBkOHZlZl8A78BpelospgsPbRCuw=;
        b=P/HWPRaBiwh0CwZn2Cy1BobnmxTodW3XLBKu2XJhHPFAHp/GpfEs8/2OjcmzCIFskW
         Yvu8FC7yZb77NiTHmq6bRDH3UxeExLAjwIFHpbtSho3rZv0rWng25Wb7exrr69DlIApm
         dSG3fDdtS6wJXqN5yWjNTchWYwGbdRNCszp3foDT8rvpycX2Rc8K4IcLAduDjUARhWDu
         91hhPktaUkha9ERZ4nnii2goqOgTRR82Iu5INppGPp9rmfu/ehyuFOqtvgEWVxAsuckU
         ro4w6Ibx4jfrQMYxMHkCSFQ8h8wt9QOKmJ/22RbSAKRm+x6pAaNzigYbvYNEjW9lOvbN
         vM9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782236764; x=1782841564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ashQPfCGiqIse4wQBkOHZlZl8A78BpelospgsPbRCuw=;
        b=BcRyvVhx+7ugzQ3ayHjCqB138KvfAn0MUqRr9lhmIWfArHpWplSuEWNQTF/c3k0f+G
         lNUHCAPPrz3DvpfZfzhfzAUacCYJnelcwPUW5gw2Wbcq/83AAOreYWbWL0FJscdJuEgR
         KY8isthFYvEmbncxS9Sx1IHnIcfQ5nCfYEPjtq0MsZuXv6jKP05CvIvXvVEliUEq/9vF
         61OjHVkzhPOZ4KdLG9jAeCqU4lhIMb9bKgoE24QCELNLIZ0MiTc0hr4sq1Y2XKp/8xaP
         bofrSrD/0aBendVPKxI0ZB3YMd04zNjZ5EqXKYTevqrRVN1bZeTvF308uIkVBzrnv+fE
         9mxw==
X-Gm-Message-State: AOJu0YzgM56haBwws51Aas7idjXiq30jlbB65rbdSIi5oXCal8rl+iG1
	cKRdLsLM8pNdnu3ziUVsGpInQel7tNrfPD+Rp8g+bqH52Btpp1bUQYjtFP+ct7MaX1vmJg==
X-Gm-Gg: AfdE7cnkwwWApR7PNEO4hAmTU75qy8eSN08GFDQ45I1kt6InHcwxbdXz2OM3Ka3nNBR
	G75VJQVsSPSVzs1275Qe0fZcxDK8FOkWg9+KRT/ryuAQr6fp4v1TYOjcr2ECPNmBT3JvMZhUF5y
	xz8TbFHRoq74TAy2Bv3r4mccQKzp8+shL1+nZULf0r27yVb9ayZcanLJYWlYkGoXyuVFOpTbTxm
	RaKzPHV5WX/1MH1ZZhbRY3ukw+65pmh/KZ7CpE+QD6AcemTbCn18AkwTRx8tTSeG4grxsxAuLvi
	B9So+TAUQfjJ80qlLZ6sAQgW2hPApdb1i3OjhTw/L8H281RiVjgof51wUOda/QN9/KoodegB5lD
	EFNs42IlY/NqmZ9M92Dj4mkToQ1bfNfjIPPzGJ37K2DMlpagGQfMPqToXi6YZjdXToUBTGLMBWb
	fSI8Fja01Shw9eh1xbwYRiF3TYRF+wGn0Jc+QnlGo1gihnbw==
X-Received: by 2002:a05:6512:ac3:b0:5aa:63c2:2cbb with SMTP id 2adb3069b0e04-5addb8161f0mr1182005e87.9.1782236764024;
        Tue, 23 Jun 2026 10:46:04 -0700 (PDT)
Received: from Shofiq.home (87-92-251-137.rev.dnainternet.fi. [87.92.251.137])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3999afc7005sm27198651fa.13.2026.06.23.10.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 10:46:02 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	lars@metafoo.de,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: [PATCH v4 0/3] iio: health: add MAX86150 ECG and PPG biosensor driver
Date: Tue, 23 Jun 2026 20:45:57 +0300
Message-ID: <20260623174600.17100-1-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260623155556.13701-1-shofiqtest@gmail.com>
References: <20260623155556.13701-1-shofiqtest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v4 (addressing Sashiko review of v3):

- [High] Fix optional regulator probe failure: treat -ENODEV from
  devm_regulator_get_enable_optional() as success (supply absent,
  not an error).

- [High] Align fifo_raw to ARCH_DMA_MINALIGN to satisfy DMA mapping
  requirements of I2C host controllers that use DMA for burst transfers.

- [High] Disambiguate FIFO empty vs exactly-full: when wr_ptr == rd_ptr
  with OVF_COUNTER == 0, consult the A_FULL interrupt status bit to
  determine whether the FIFO pointer wrapped to full or is truly empty.

- [High] Remove iio_trigger_get() in probe: the incremented refcount
  leaks on the error path when devm_iio_device_register() fails because
  iio_device_unregister() (and its paired iio_trigger_put()) never runs.
  Users set the trigger via the current_trigger sysfs attribute as normal.

- [High] Assert SYS_SHDN in chip_init() so the LED drivers draw no
  current while capture is inactive.  set_trigger_state() clears SHDN
  when the buffer is enabled and re-asserts it when disabled.
  read_raw() wakes and sleeps the device around each single-shot read.

- [Medium] Replace IRQF_TRIGGER_FALLING with irq_get_trigger_type() to
  honour the interrupt trigger type from the device tree; falls back to
  falling-edge if the DT does not specify one.

- [Medium] Add .validate_trigger = iio_trigger_validate_own_device to
  prevent incompatible external triggers from being attached.

- [Medium] Fix per-sample timestamp jitter: anchor timestamps to the
  A_FULL IRQ capture time.  The sample at index (A_FULL_SAMPLES - 1)
  corresponds to pf->timestamp; samples accumulated between the IRQ and
  handler execution receive future timestamps, eliminating scheduling-
  latency-dependent jitter in multi-sample drains.

Link: https://lore.kernel.org/linux-iio/20260623155556.13701-1-shofiqtest@gmail.com/
  v3 cover letter

Md Shofiqul Islam (3):
  dt-bindings: iio: health: add maxim,max86150
  iio: health: add MAX86150 ECG and PPG biosensor driver
  MAINTAINERS: add entry for MAX86150 IIO health driver

-- 
2.49.0
