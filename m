Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6703B47F4
	for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 10:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777284667; cv=none; b=aWu/BEhey++EWR8D8iUlAD22nsg5uBqzbZTazcarbBLkKd+3ocT1y9XZsMkBG8X2JdxQAvolJE54RYorJjepkqbxV79m55WZvbWrbaIRQ39PE7fZimQ75XRdOmfGn9bi2oxIKbcYPflPY1Tvzd3X8yLMR8Rb4kKPw+8twfh2F/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777284667; c=relaxed/simple;
	bh=Wtp2ady5cPGsHqy7Hzx2YKsIfwDLlHsBk3WZ6ydRqls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wi66PO23oWUofhHoV3urtXaBkV8VyoHTeYSPRRxeU/edDTG992UDFeWJgG5ztpRtxxhsweQIeG8oBn3yiN1HASRDCvbgwGn+kwqMN5Brae2BrTS5q2sVPlYburSYtKbgIHcrgG2No8j/KJiVQHPZufZOlJ5h+FtLiqTMpka1B10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQZ/JFJO; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQZ/JFJO"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82748257f5fso5703224b3a.1
        for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 03:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777284665; x=1777889465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aa/YrVOe4CujixvUEtBo8c3EyfQIvCG6YasI2Sa6Euc=;
        b=BQZ/JFJOuLYKGxLbT6CiDCTDKk2Hm3KDcwoXBRfQWiFFXIDy28YZOts4C6Ese1YDWM
         jrgOHixHB+E5NgoKd6kagv3pXEGLrh5Vgq7xzQtbdymqM6XxB+tDWMWap2kuryyL4Mhq
         8PneYxyqMi7xgcfTCEqhb3/KKIxTYlQ1bwM9/hYbV+tUzCXjNyqA16n3e3B8+54OxIsg
         RXTyFoYj01gMoCRgMRhBZKnG1D/wqOPyATicSWwdL9oXFcf0frdjxn48guO5WK+ZKRJi
         e9HSvX9IM5ZCjrhkpt2vcDBZvUF/S7yQg2Y+uRQCB3E4qB6ASGKN5+Ze6l0vwPkn7zrB
         kHYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777284665; x=1777889465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Aa/YrVOe4CujixvUEtBo8c3EyfQIvCG6YasI2Sa6Euc=;
        b=U5H7HGrgKQKN7UqGI60eaXSBpOlDoQKoTiDoE3gqXBquQJPKXUmzOUTwG6JzHbS2OA
         P9K2aKi10djeckAn57GnpjHiY4SPte9/OSQOEl5EK/dWvmw7R4lBbHPOtzetQVqF0RB7
         9TvaGYXhrLQVIZXmuM6g60qswrY9njfybaeF01QTvKBxFcqqRewYRGSpKRXiqRIXuVeB
         FLoDEqFS/tEW38s6DCllHcgDeOXVEkMzCxCEAXeWVuuwJXn4yNGsQ+OGI2gRbCL0tSkF
         pldqMVqwM8NU0FCAhO5VmIkdjhLFK2LmJqdp75VTPh4UdGYD35VCSNGABH32ZVTW+Ie3
         frRw==
X-Forwarded-Encrypted: i=1; AFNElJ9u7FqSIyFj9NPSvovoDFbRxq/tJ72hd3nQFvbAAn8/YqgaxJPxuKEZGgsuJti4vranKNJldh4dZsY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw539HHerzUVVkCry+XdZn+FdGA6J3xw9xU0ecJgoRgSwhYDBh5
	mNyib2Os3od8+y7RIkr77tWo2CRv9u5oWAT3BAoW7/mhfmuoknyqHLHd
X-Gm-Gg: AeBDieuzSMyDIlo3+9X6gW7f8DrbMVKwqVuVwQD2c8bZDvOm9gHEG1YgNPljHZ7N/a+
	506fUnBH3L3KJZ+qB/sBv62J/mH0G88599fYdYQORAH3tzOzEWLcdd6ixyEMWxm8sEgR9wiW5LM
	wLS5QZo8pIewf4EXzaNN0K8yZ8LbjIv19WHdhyUsoqQzxQ1JReJltRSmPmRnsnqKnuOPs2q8ORC
	kbljIhlGIdt7cfPI+61GaIsLZPsq+t7EX/aS8FawWcuJuwPXww3zfDoV4M0qM8woUI0lyhIABq/
	TB2akqbsl09QgKJ18EuHEnU1+OwWnII/tD3BvxdLSKFn9DAqaj3qEeOzniC467E4iHzpOpxbt8T
	htUOkglDU8fdoykmfNi4yk606X/jKOY1zyo7Htmqe7ZwLVqZoG1PLBvaBEB6aQPjsVIOOoi/5aM
	ElsogXxc6E95lrr0uL+TSeozhozJ0WkuB43fZboGO/OtmMdG1SCG1z0JYimcOspohdUaJ1l4jP0
	AxkcwSwRCuTxCCtUw/Z+O0PUczV3ecK3UTkA33uagKoVfV1pqraX/2Vtvqi
X-Received: by 2002:a05:6a00:1bc6:b0:82f:684a:84ea with SMTP id d2e1a72fcca58-82f8b50fb97mr33817544b3a.13.1777284665432;
        Mon, 27 Apr 2026 03:11:05 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.. ([2405:201:31:d016:e577:22da:dc9:7f6c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ebba485sm39534225b3a.38.2026.04.27.03.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 03:11:04 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: ak@it-klinger.de,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 6/7] iio: adc: hx711: pass iio_chan_spec to hx711_reset_read()
Date: Mon, 27 Apr 2026 15:39:37 +0530
Message-ID: <20260427100950.33936-7-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427100950.33936-1-piyushpatle228@gmail.com>
References: <20260427100950.33936-1-piyushpatle228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change hx711_reset_read() to accept a const struct iio_chan_spec *
instead of a plain integer channel index. This lets the HX710B support
patch pass the full channel descriptor (including chan->address for the
trailing pulse count) without adding a wrapper or a separate code path
for each call site.

Update the two callers: hx711_read_raw() already has the iio_chan_spec *
from its own parameter, and hx711_trigger() passes &indio_dev->channels[i].

No functional change.

Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
---
Changes in v4:
- New patch. Split out from the v3 refactor patch as requested by
  Andy Shevchenko.
---
 drivers/iio/adc/hx711.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
index 8e77978f062b..dc6703ead8a0 100644
--- a/drivers/iio/adc/hx711.c
+++ b/drivers/iio/adc/hx711.c
@@ -264,7 +264,8 @@ static int hx711_set_gain_for_channel(struct hx711_data *hx711_data, int chan)
 	return 0;
 }
 
-static int hx711_reset_read(struct hx711_data *hx711_data, int chan)
+static int hx711_reset_read(struct hx711_data *hx711_data,
+			    const struct iio_chan_spec *chan)
 {
 	unsigned int trailing_pulses;
 	int ret;
@@ -278,7 +279,7 @@ static int hx711_reset_read(struct hx711_data *hx711_data, int chan)
 		return -EIO;
 	}
 
-	ret = hx711_set_gain_for_channel(hx711_data, chan);
+	ret = hx711_set_gain_for_channel(hx711_data, chan->channel);
 	if (ret < 0)
 		return ret;
 
@@ -296,7 +297,7 @@ static int hx711_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_RAW:
 		mutex_lock(&hx711_data->lock);
 
-		*val = hx711_reset_read(hx711_data, chan->channel);
+		*val = hx711_reset_read(hx711_data, chan);
 
 		mutex_unlock(&hx711_data->lock);
 
@@ -387,7 +388,7 @@ static irqreturn_t hx711_trigger(int irq, void *p)
 
 	iio_for_each_active_channel(indio_dev, i) {
 		hx711_data->buffer.channel[j] = hx711_reset_read(hx711_data,
-					indio_dev->channels[i].channel);
+						&indio_dev->channels[i]);
 		j++;
 	}
 
-- 
2.43.0

