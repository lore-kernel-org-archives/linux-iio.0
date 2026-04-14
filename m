Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83FD3D6685
	for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 10:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776162831; cv=none; b=qSELFtnUAkXgig3voKyZVbWvDZiNOUVwHZZrCF4gc7mueC3VBCNGLC8CqzXjqRCkFkmJbDNqRw6rH75GcjQkNIU2U+A9oRdF/WgDKZhDt1jOh05sHgA0EwVMVhPo/7FqGlo9cb742wpV2OH/QnmbY3NYpsyKUWsH6tMEGuXPIa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776162831; c=relaxed/simple;
	bh=TOvWs37tY6i8lBY3sUkbSokLpBjo0fqBA3WxP2Qt7fE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O6BvpJAEbh97Zp7V/TTMHiX1vFqo2BJCI+Wl1Sl2+VDE1e1iHbxpb7O+Aalx9dlh4dINrRiMY/vikVShjdQ6WBEx6b6INYwVvbooOw7eM2F7zWiMRS0zvE+7sbdTU22ixzf27y2GMLp4bSWROz0OuUhPkMifc1wuPAndMAv5g/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=pa/XgAdc; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="pa/XgAdc"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2d8fa0fadfeso1014007eec.1
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 03:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776162823; x=1776767623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KeHPQvcdCQ3nvg+KY/rV/Tln29SkakA7HHIFRcYo3eE=;
        b=pa/XgAdc9PjvSD1P1QNibXjNticqtbxiP4PxPA6HhRcVgF6qAcTkKFVCsyA5DTxthA
         jjjF4rQSQAj/bwol8vcrmuQ3DAgXDn3/xds1qWzUZLTlg8y5tzGci3SHSUP0TS/XZMSD
         srXlK546yCMZUzJaS3dQQsXfqQBpxIVbO/kHGec4mlAo/FF8Kq/gJDEryX0wrSv3Pddj
         wzlktlMK/LLErZXTyHbOYof//gsi3cu2n+InM50T+Qag/uSIEjyIw2mj0fGOHbCUZlnp
         UJMP0qo0oNK8V3vvi5G7a+xLWwvP04XevW95hnd7qex7E51KwbWaDOt78XtsJto3dVgH
         JC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776162823; x=1776767623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KeHPQvcdCQ3nvg+KY/rV/Tln29SkakA7HHIFRcYo3eE=;
        b=HIKdVh+Jc5/psThzwCgy2cJKhbnCtL4lxXWgBAgX9j86SctcrD7e8BUgl0LNy2Rg2a
         3HSVaGBITb8ZDmiQYJnsHT3I8MYxJ7F9rg1V1kmcGrFDo4QUELG1LvCXAc81jKaWVVP0
         J0cZ1V+H1VMS3kfCvFowviSEMb26wNhurnIUR6kkYYxpwir7hoKl70/UDXnlcE9P1a9W
         kKcp81KLbsrUx9vzXlef8+jQzwgKMUAOUgPSKMJb+iB08lzWbrM4ds0AtmyIbldTVgro
         EdZ6lj09LS1OZfSvfL96VDXHbZJeRgI90YKYtZ374wwqkUStDC0GhnFERg7zgN1N+694
         ZoFg==
X-Forwarded-Encrypted: i=1; AFNElJ9hKfsWY3NJ6ElIIB7jarBjZB+XGBRcNibk737C4K/hCycxulKZ/E4Lak4vVFRgGdCcY8pOIVUkMY8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm7YkOcmluyX/H+qNFKwB2kbXUlIZHE7Lu75o9JBZq07Ua6py1
	tm2a9lMwPSYiraxq18tVmIQ3SVEQ42eeyJMDBe70GqfQ1RGyxk8oOByx7AdyRw1eLgo=
X-Gm-Gg: AeBDiet6qQ/fD3O7U6XiW2TqePZNsy8Y8g7HK+ZWsoNdBg+qVjy25Dn3gs4fJg8LEtf
	Dv0yYsohFbTPdkVUBP7oY6ZvVXyWpOoNxH9R0OQPMsiLfORZEqADZKv5m/w6x8dSfad6KRSKbXm
	wFFoot2CpMCxqun79Puf87eNmKCZt4Fm5XHyv4QoOJWQcZGaQjwmOWGoUlDgRpIHttN9WIPtm95
	FQFP+/e7D52/fm5yFHtbU7RFfRFoPbBWCKusCUx05pquJN6MpWoBoq5FR4qgktXYXw7fDA3PiPt
	DitJdyJtMpZlh2MDs/d8Y5T5uiOF1rcNrKsdJKxXja1mRKJfKJ70oStDpRTwVZ5rdSJp4p9v5yC
	H1oaGvoQo+ao+4VRtDfQV5M9hb91M5MziiDjmwWa/pBI/g0/iALdeIR099nt8YgtV5XLHbVb+jS
	EIf70t/qfajaqltbECjWz6vYm+vSQFoLtqiygG0pZ64j3uFvA1fTKrxNy7E5ulK7+/55I/V8QcO
	GvSdE0HMIYnWOD6T3/0H2NLdsjTfGC9omHuhj51dNaZk4At6Q==
X-Received: by 2002:a05:7301:2b07:b0:2dc:5d20:c163 with SMTP id 5a478bee46e88-2dc5ebd1395mr1174530eec.6.1776162823340;
        Tue, 14 Apr 2026 03:33:43 -0700 (PDT)
Received: from gui-host.Dlink ([177.33.104.190])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d90ae89e49sm8735499eec.31.2026.04.14.03.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 03:33:42 -0700 (PDT)
From: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
To: Salih Erim <salih.erim@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Michal Simek <michal.simek@amd.com>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Guilherme Ivo Bozi <guilherme.bozi@usp.br>
Subject: [PATCH v2 1/3] iio: adc: xilinx-ams: fix out-of-bounds channel lookup in event handling
Date: Tue, 14 Apr 2026 07:29:17 -0300
Message-ID: <20260414103316.18455-2-guilherme.bozi@usp.br>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260414103316.18455-1-guilherme.bozi@usp.br>
References: <20260414093018.7153-1-guilherme.bozi@usp.br>
 <20260414103316.18455-1-guilherme.bozi@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ams_event_to_channel() may return a pointer past the end of
dev->channels when no matching scan_index is found. This can lead
to invalid memory access in ams_handle_event().

Add a bounds check in ams_event_to_channel() and return NULL when
no channel is found. Also guard the caller to safely handle this
case.

Fixes: d5c70627a794 ("iio: adc: Add Xilinx AMS driver")
Signed-off-by: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
---
 drivers/iio/adc/xilinx-ams.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
index 124470c92529..f364e69a5a0d 100644
--- a/drivers/iio/adc/xilinx-ams.c
+++ b/drivers/iio/adc/xilinx-ams.c
@@ -871,6 +871,9 @@ static const struct iio_chan_spec *ams_event_to_channel(struct iio_dev *dev,
 		if (dev->channels[i].scan_index == scan_index)
 			break;
 
+	if (i >= dev->num_channels)
+		return NULL;
+
 	return &dev->channels[i];
 }
 
@@ -1012,6 +1015,8 @@ static void ams_handle_event(struct iio_dev *indio_dev, u32 event)
 	const struct iio_chan_spec *chan;
 
 	chan = ams_event_to_channel(indio_dev, event);
+	if (!chan)
+		return;
 
 	if (chan->type == IIO_TEMP) {
 		/*
-- 
2.47.3

