Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8E823E25B
	for <linux-iio@vger.kernel.org>; Fri, 14 Aug 2026 04:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786681891; cv=none; b=SMiZ02G2t4cwWxoSgKeuq+Ie3qZENDZt4v8oZrJsbWaM9YeF9z9YRzp4JBoc/HhlFRp64XuvNnSSyFWuea9085xv2BIU4FdfkpRJ0AMZEbXbPql6CaHJsjPqVjN4ieUCSD1jt6jMorF45vPjZFoOKlA8U4zivnAoaUJWq/IpRV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786681891; c=relaxed/simple;
	bh=c3DRZX6A6ujbhHk0RR88rGvb7dnMUGViYYhXXdejg28=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AYuh0lyJQ/nDfH0oC2zneSIAxRRf04HzgjOL9AwJrGVLc6bDuFpcCWEoumiRwAngL8TxuZtPSSPPo8t9W0OFyuA5I7bG3sopXjBLF8gVNke8D95agzDo0/DOC2tAGjwCZMYtB+yF8w5jpVx7e9HwrmyjzCid79vdvWj1DLOJKK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hy3W8JN5; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hy3W8JN5"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so622545a91.0
        for <linux-iio@vger.kernel.org>; Thu, 13 Aug 2026 21:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786681890; x=1787286690; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gUfcPE3MIPdF38dpS9oTzmQ7oAgUxQgvZuNHQtltU3I=;
        b=hy3W8JN5uCX1K4f8I8JUSwGFV7vEA5E39OJc3j1+4UMNieMAzGPIIZerMcXM4IWAGV
         hJlNesZIEDvD5J24+etliRGD0XKPD5Bjn3clRI1III6o3py6f4lMAyE3orTnXsmtSd/X
         Hd6ufbFdG6qjV67fVM5m6GYZo243hBnZfYx6NilbiOZOeiBF2fm0kSwuoEUbu4WwUnpU
         NP35KNOSfmbKlmAfEvz0YEV6G0MuB9S26oC9UBwFgGbKjrqntRozF5LZVusYLZggbHfv
         cla3UIxd/0EXtqnvZ2E5ffttftMAYZzddz7TwJxx2REm8z+xhZPMqZo2hAuHKMIcbs/Q
         WXjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786681890; x=1787286690;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gUfcPE3MIPdF38dpS9oTzmQ7oAgUxQgvZuNHQtltU3I=;
        b=NqFxhRLhEyrUKTQh+9fWioCgygU2cFCq8/z0HvXXQpUoai6IAOldhCxBpSjSN3B4bc
         m0GlCXTlQW0O+LRxBTJm7ky/Ki6gpYRTdtxrsFsim3KLINE1AwsrlqgRNAeaGpHsoeEt
         sdvhnbLV5xc6jCb34Qy8zP28xxm4MCiPYAXa8WddWXN9u4SdHyNZMpUKQh2mS1beQrDg
         Pk6ZRjip5C8Oo0+xJ/eJltMs+TpTp1nyySmPaXblXsvDXWYmqzQDN08SjOeELvles42k
         BAsSkbjHfwIKvGSFbqdhhz/ZxygKG++M11QU467WZmUqjoPybWbxXUDusfsTHnRwU5+z
         cSdA==
X-Gm-Message-State: AOJu0Ywww4fGkeDerVIlA84ZFQBbZL4pWS4wczHEDI7fGY1qA0mPt+8W
	mtZmebCE2YHg9dPB/3VVSqK4Wai/MlnsgcWxB6IDpxb0mRWGoXkIsLaITmepjQ==
X-Gm-Gg: AR+sD11TDDBkjEzaA8jdUp5McHkWz/JZj+8jCHHnTHNGK8EU7WtYct/3HXetbm1d49c
	TyjHSNXCbtrguQyu8bAvjAKTVWnj6VZD5al4jaEFLVkVmHEWjTz6mA2pk0FCQol77ONL1+cHPaY
	H2/RVRk7b/7+/rrTYrX8j62HBnGbsbmA9hUPwErDSbBcjp3iKqQkzyIe4IC/M8FY2BRsxUeEGeN
	+2CnJyXD5p/4S3wv2/fUB32gt5B4FaSW2f1CjLk75CSTr+7aJxWaXl31+3CiO59ij7P0xuU+LBh
	MyrN2kyfQeleP8fRAIq/Eu6JOPttSkD8zlSW7YpC9VZIer+428e1Jhw4Rhbskke8ErZr+T8ss2l
	t2GzI7HXeJUWyKfVnhmSROkKGOysGgSWpJK/sS3tq++66aztG74qEFJ9HPaO218twwn9jHD1aOK
	G3GEkSpksI4wU4LM50r4rapy6YYDXOJbqw8DmYZL+eqHW2FTwRk0iV9lXv25nELdeFLdS6eTZ9I
	zV2QkizhMV+InzpGOtKKbTH8q/ftTbQzFAdoX8=
X-Received: by 2002:a17:90b:3b8c:b0:37d:ee77:78ac with SMTP id 98e67ed59e1d1-3933bd0c331mr2508028a91.19.1786681889624;
        Thu, 13 Aug 2026 21:31:29 -0700 (PDT)
Received: from [192.168.20.42] (115-70-157-242.ip4.superloop.au. [115.70.157.242])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1413887ee65sm4238288c88.10.2026.08.13.21.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 21:31:29 -0700 (PDT)
From: Tsz Shan Chan <tsz.chan.dev@gmail.com>
X-Google-Original-From: Tsz Shan Chan <tchan@jacques.com.au>
Subject: [PATCH v2 0/2] iio: light: vcnl4000: support shared IRQs
Date: Fri, 14 Aug 2026 14:30:41 +1000
Message-Id: <20260814-vcnl4000-v2-0-9b771290cc1d@jacques.com.au>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/0XMQQ7CIBCF4as0s5ZmIBasK+9hukAcLEahgiWah
 ruLTYzL/+XlWyBRdJRg3ywQKbvkgq8hNg2YUfsLMXeuDQKFxB1Hlo2/bRGRoSDeW4WkUEK9T5G
 se63Ucag9uvQM8b3KmX/XH8L/SOYMWVcNe5Kdkr04XLV5zJRaE+6tnmEopXwAWRbVq6UAAAA=
X-Change-ID: 20260810-vcnl4000-02e19f70e706
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tsz Shan Chan <tchan@jacques.com.au>
X-Mailer: b4 0.14.3

This series contains two changes for the vcnl4000 driver.

Patch 1 makes .num_channels match .channels for vcnl4200. vcnl4040 and
vcnl4000 channel arrays have the same size, so no functional change.

Patch 2 adds shared IRQ support. It changes the trigger type from
falling edge to low level and adds IRQF_SHARED. The IRQ handlers return
IRQ_NONE when the device did not generate the interrupt.

Signed-off-by: Tsz Shan Chan <tchan@jacques.com.au>
---
Changes in v2:
- 1/2: Clarify in the commit message that the channel arrays have the
  same size.
- 2/2: Drop IRQ trigger type checking and use IRQF_TRIGGER_LOW directly.
- 2/2: Check the interrupt source bits handled by the driver.
- Link to v1: https://lore.kernel.org/r/20260811-vcnl4000-v1-0-50e7fb657692@jacques.com.au

---
Tsz Shan Chan (2):
      iio: light: vcnl4000: use correct channel array size
      iio: light: vcnl4000: add shared IRQ support

 drivers/iio/light/vcnl4000.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)
---
base-commit: 3d6d817622b0a9721e3cc404df3469171582be13
change-id: 20260810-vcnl4000-02e19f70e706

Best regards,
-- 
Tsz Shan Chan <tchan@jacques.com.au>

