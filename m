Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3206D473C73
	for <linux-iio@vger.kernel.org>; Fri,  7 Aug 2026 14:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786114784; cv=pass; b=jlpgvAJHEKF0jxAyeRfwM94cZYMqaRt5TKjIMkjuGO2kU8rFC0AFuEGHqN9FJAXKTcdL9REXDzSCbiRAMkbOlwe+0d5EN90m+D9G56Lul/g+fwbQgt/vaoqH026g3lbSu3lbwE6xOXYp/YqMFvGeL8aIVQuW8ZD2CyNyoWNBqfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786114784; c=relaxed/simple;
	bh=xiCyyCPNr3j/Fz69nw/KXTS38YFdFe2m+B+aVq83/A4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pFabT5k4kM8i4SQyQzLxC0GmEJAeZtHOCpVO+WK2mMcfBbZj7AFEUbH4e6kEtLmtiWrZZwOUaVtOxD4qGrPnBVczKhdKa9FOStrBgFx0/006alrYM6UtRhELOgbNHbjtszfVXGnmJYduOn8AteFxX3NXNDjoxhZdV1J6zF3c6vA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4IQT4xH; arc=pass smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4IQT4xH"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49558ce01afso25259855e9.1
        for <linux-iio@vger.kernel.org>; Fri, 07 Aug 2026 07:59:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786114781; cv=none;
        d=google.com; s=arc-20260327;
        b=kq9tm525Er0v3uS6naeNpIR5AskDzOVvw9+aHLqBg31lvrgw56O34ltpQnlxAlKM4m
         bm8ZT4ffsM73cxx1Zy7+1b94aHeMOSeuAvcn6VkMCLUc5yqtU+Kh9RUloG/0ZLmwqXjb
         OleiLwkgmo9IlZcAvWQkK7mZMuvrisKHTPnWkaG6Ce3Q3Zk3W/6oALF5ofR4LP0MkhXC
         W6Z5w/9Bo1EzGDoaZGbZ1kPJCrM08yF30bcRR/Ke97oSzSArPnWlGVJlb3d/WLB79mKt
         /CdPnNNRxevTSzTncYQaWohR5YEF6NYdrQvl9n5LthFdG0xbe/XnkICxiOfYdg9QGQDh
         XQng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=xiCyyCPNr3j/Fz69nw/KXTS38YFdFe2m+B+aVq83/A4=;
        fh=LTgSdX6jdX8xypdkW83jDjNFLwWEyOUwM3f1rgPb4HQ=;
        b=HHmqRLP0PdHPaXWGt1aiaUWEpFcFzX/8mkp4p/Cmymm10Sv9NimJfauuvGb8GgARAh
         jgtYybf12W81CRGX81y0Q45oB6xqEGA3FXeIHmikvqdYDNe8lb7hewcwgtVmIWFa1kA2
         oIHdSmfHLSrxWEAZVFyra5DwPOAiRp4ghkbbjTnK7mAKgUJy7ue1S2xHQ+K14XiF8Ih8
         L1/9AqOtxP/liMLUGNbytoIyccm4bpTtIObkziuuEaF3siutfwj6g7pPtEz5fmuT1MGR
         oTSqGwyFnCRbqCT6xJsz+eRaX0BSQ8XJE4hh3Af7PBlGtoc3RdMYP64UAwBv2k4EGOmp
         qaKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786114781; x=1786719581; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xiCyyCPNr3j/Fz69nw/KXTS38YFdFe2m+B+aVq83/A4=;
        b=O4IQT4xHUhMnBgHTNq7+MzM8G4TopZ1MOXJM7DowREPUHEhFDAioBLqRh1bBDyzb6S
         H7Fn2ABm+IFkXsNNKlcutdJH82NooVAMawNy7uWVGmRXBr+zAYLA6N8Y9ccsS83XGoBi
         IlnuFulnU/GxHa/ye6U6vEWYEfmONeXNJle7oVor4jg4EYoTlfY9jsNgOeDXuSoxxgLo
         4ptQ1eMspK+nLYO04jU0vLhBTk54kDnYSWmmON28oRmQ+5F68x9U4xAkl0qszmd32jGc
         0T/TFS7TJ682f69qpnGwyaE360IPV/UT8rJ3ltmEBq1U6t++vAIhtihiBlbhWxbnsrS7
         TXMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786114781; x=1786719581;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xiCyyCPNr3j/Fz69nw/KXTS38YFdFe2m+B+aVq83/A4=;
        b=FCtbt91MGbwmu+fOjc+/FqZZQg+9aMycIfz79gaaot0ItLZcXNiiVvkLudOhBgYLWE
         wBfOMY/wmElHuTBedSlVlIbt0zib0SlAh2yGkrLtY9RSiFZbxd+SQ69BLkL0gNEugkrs
         6rifOtCUTKxgmex7osIBGyS5++JlW2TDbGUK1f+VtV97cUnUx4DKLPg1XbpD5LiJ5Pk9
         QMyHTfageqO+SfuuRJjpTIwc5z+KiJ3y5Iv1LoGWJgLjQnrGmx42X60uJIo4B9oxNtAv
         /93iuGI9VdMF2+N1m0RGBnIDcG7Q3xfqNm4wgkvsW6r5p1xJ7E4vPBa04QqAMXGwt56Z
         Pjlg==
X-Forwarded-Encrypted: i=1; AHgh+RqLpGuP71Lih1cjLMXVd3H5rQ7Pw+UK5gzs3RY+mYW7oUleQno6wLDZeeirLDJVYLjYrw/jQl7EqSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzINtYe3lhiXYjXuWIN3jbkQ5LBjMNwXtsvcr7Dxe/ESvN4CnfP
	nmSDVZmAD3/bQEqf15+mgEN6YbtcPbD3ynTQJKgIUSyOThi+3ZReNAqzfUmiYQmZxRFtMtk5Mcu
	WzVOaxNF4szC8mEVOFVw4qzcoEZjAiog=
X-Gm-Gg: AR+sD100bT/DglFf63qE4KLGfW0gG/kkjQIT/EN6SDSKXtHj5Tczf6Pjvzx01fEnns7
	QjTU5kTqvTkoQNtGS5mmn4eZhblT/487XUwtlBQkSyNmxfVvjSXCo6f+WcrrAmL7b0XiDrLYW1h
	njGuPZLa4Z+fhNn/mw2cYv6s9dsc222aAfhtOM5itHwiTxbc9pc9BmAhRmkWqcuQvk0CyERW2ih
	EgdaLG5yaMUuOPp00taHjNVl0yFS5m5IfumE7PVho1PhfXkYh0CtPNzgrZJLzSwmJ+Y8WY+GUoP
	jst+0OIiERoqWMQyNiTSHq5H1HsqDJzF7sLbhQowePJJa9lyq/j4yi1d/KHZwSeKGC0RwJtMD66
	uSeQvnQfaKzhA1HCdsxo2ewauAa1PTSpiiKph6teHs6ZEksLHawub7r4MxuawctScCb5XXiSTTM
	z0pTj6f9QvoHoM5lE60r6wXGpvVK/l8cSJrGYcvA4zAbSnip2UDCUocOGYoxtStdY2n1sXHFYQd
	HezgYdx2LGlbq0a8VCz6gqZDprEqnk5BYBcs+iT
X-Received: by 2002:a05:600c:e549:10b0:495:6934:414c with SMTP id
 5b1f17b1804b1-4994e7df489mr257307965e9.19.1786114781504; Fri, 07 Aug 2026
 07:59:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807135105.2175-1-danilsirin24@gmail.com>
In-Reply-To: <20260807135105.2175-1-danilsirin24@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Fri, 7 Aug 2026 16:59:29 +0200
X-Gm-Features: AUfX_mxbGVBtf9RlXvabsAZ92vfGpY-lrKRwIAwL4o6sysYMwzXzDnLIi2D1egI
Message-ID: <CALoEA-zR7Z75k3uNRD_Swqf7G0+mYmFkPfXTJ5O-mBr6_iu8qA@mail.gmail.com>
Subject: Re: [PATCH] iio: accel: mma8452: add ACPI match table
To: veeenjoyer24 <danilsirin24@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 7 Aug 2026 at 16:11, veeenjoyer24 <danilsirin24@gmail.com> wrote:
>
> The mma8452 driver supports obtaining chip-specific data through
> i2c_get_match_data(), but only provides OF and I2C match tables.
>
> On ACPI-based x86 systems, compatible devices such as the MMA8653 are
> enumerated via ACPI. Without an ACPI match table, the driver never
> binds to those devices.
>
> Add an ACPI match table mapping the supported devices to the existing
> chip information structures.
>
> Tested on a Bay Trail tablet exposing an ACPI device with HID
> "MMA8653". With this change the driver successfully probes, reads
> the expected chip ID (0x5a), and registers an IIO device.
>
> Signed-off-by: veeenjoyer24 <danilsirin24@gmail.com>

Please use your real name in the Signed-off-by tag.

Kind regards,
Joshua Crofts
