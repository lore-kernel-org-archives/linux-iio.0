Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939EB31280D
	for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 23:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776467157; cv=none; b=gGEyFHtgwxPHszwDxGh8VfpJt0TRIyzZnlzoeq59XCN15V59+bmVGe1lELsjAh5l37EWSHzQNvCBInpfq/uA5W1CpGf5IwfX9GJwxZ853UgUwmopARbj1s3+yMZX/wjg6lw+d7tutWbzO2ZJ0x/t7m2ITx0geO7GLPZWU2fCQ1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776467157; c=relaxed/simple;
	bh=bnmHaJe8QWE1jsWEm1hh6uAMBtdwAAo32rr18B2LXWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B2NbPuyCSUQhHvfBDx3SdQlqVMAWLlRlhi0U6ik7MUjM/+ylOr54hVSCwPSaU/znUcWirdR8T0IaiuH5jg5EWjviaHJXQsvjEzD2ACU76KHTtXnznWG/O2Hh2+0Nw94eyXPnByK3OlYKh9cavKciLwu1B0RoRPvRRXgq71E9slk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=lo1hHcoC; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="lo1hHcoC"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2ba895adfeaso1499122eec.0
        for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 16:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776467156; x=1777071956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BIT22lpBhdrkSsKE5y6HFSbXhz+lUiuwd0sLknwDGlc=;
        b=lo1hHcoC6l1+rLw3HS9fVLIhF9ut9fK1oUmiBnTxtV5cV6chgk5ykYi8+iuJgPe878
         BZoguEp7zQLlNMOFMpw/kkbvztE0aD148p0+D0Q0dE+0PXCbke/HMcFvgPUAi1rBlx7p
         k/ixQPTrAJCQi2NdOVinyyVxTgG7avX/PWmYTy3jLvik5CT4tlPu0XsJUWxRHV00gXs3
         Iplxeo8sTB+1Kz1w/+Q1Gej5SxQAsmnZihC4NFOL64a8cCbEskGOFzvSTDKaSxun3PAl
         7aCbW3PtuJF9OaMxWj9KIhcM565pdAsb25tRiExIixN6XlDv3BKSypfBlutwBm1Vm1EN
         bDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776467156; x=1777071956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BIT22lpBhdrkSsKE5y6HFSbXhz+lUiuwd0sLknwDGlc=;
        b=cwxe+l84/4GCDCIkKQdJ4U5XpzM1NVc1ikhI2tnwFl8UWy7NKljEl7zRB5keSS7PCn
         6+xHzHXqwhe381Chf/rMfgYctxgJJgdXQbx/+1aQ2FD77wQvFZ/i5cSgXKw7H5J9pR2f
         FS2TLNjfIgkvsN/NhrkfmCpTH/Ax9pK6++gnCGiur5yGpd5CWzrKoTZkEy0vR03KtUkQ
         RqHNlBXaUF/M/vPNkkjlvOpmSUeVgvQTenDdG6Ym9fwjTeTANoKF70ZINdR2VHoHIEns
         g86B4Z/RaVMPGkMyBTb/xKfO+xtIXT1xfxGVbc2Lue14AyMc5WSTscaEOcODPLlera7+
         03Hw==
X-Forwarded-Encrypted: i=1; AFNElJ8iLz9qbBEgklClTpn9sgacDpgc0EQPzfK2miQYlYGEFJvq2zzyN+3M0gSj1T99RGykboTnw7LFoP4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe5qcrfniM32sN4ONxZ994bHhwQaONlXAEYMt96fdbGmwsn1kS
	aNcwlilrZVhAvJsq0ybZnPH6XyVbO/lEDsNVn2aMwexC4KhDa6YuZyNFTb3RECqgC70=
X-Gm-Gg: AeBDiesZC+HWkkrdg/wH11FuabVh5xV0a41RM9AMRDsm1B0pskvv3fjs+VpQlOLy35K
	lSl0qPnDgrTcFdbKLm7WxFu0IY35oBTfJ3Scm2alzEqwwk5Crb6hMiBiO/JGrbD7zJ13Qdj284d
	8K+kvw04detvitHWGniKGQRRR3NACwAfJ44SkAmW/gHIeU/sDr3JLlbCzBboXa98Sb4dqokyBzu
	dR4BfssKI5VrgJnMPq2qRpRnI+56ZSTxZVLPK/xDIkqjAH1bEUnDIGGu9WEd+2fhbGgxv+mi03o
	IVwTed65iS2bJ3KhLyYJl8l1BH4HNU1476I29qOr8c8yHk4iTEkpo1olt8LMkCVtpRL19YpavD9
	GgpnSPHtFkGR/BNd5I8P2o723uP2HaDPZd/Qp7vHERZ8pY99RpD5+r+x5Dj5EJ1UiyyRLB/GEqM
	V/sGmjikzh/o29Lm20WQ7EARYo0ebXOKJbNb5Alg==
X-Received: by 2002:a05:7301:4593:b0:2c1:558c:16e1 with SMTP id 5a478bee46e88-2e464dafabemr2362824eec.4.1776467155749;
        Fri, 17 Apr 2026 16:05:55 -0700 (PDT)
Received: from natalia-pc ([187.116.73.68])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53ccce440sm4117637eec.14.2026.04.17.16.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 16:05:55 -0700 (PDT)
From: =?UTF-8?q?Nat=C3=A1lia=20Salvino=20Andr=C3=A9?= <natalia.andre@ime.usp.br>
To: andy@kernel.org,
	bentiss@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	jikos@kernel.org,
	nuno.sa@analog.com,
	srinivas.pandruvada@linux.intel.com
Cc: =?UTF-8?q?Nat=C3=A1lia=20Salvino=20Andr=C3=A9?= <natalia.andre@ime.usp.br>,
	Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>,
	linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: [PATCH 7/7] iio: pressure: HID: Replace method press_adjust_channel_bit_mask()
Date: Fri, 17 Apr 2026 19:58:50 -0300
Message-ID: <20260417225959.16688-8-natalia.andre@ime.usp.br>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260417225959.16688-1-natalia.andre@ime.usp.br>
References: <20260417225959.16688-1-natalia.andre@ime.usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Replace method press_adjust_channel_bit_mask()
with helper method hid_sensor_adjust_channel_bit_mask().

Signed-off-by: Natália Salvino André <natalia.andre@ime.usp.br>
Co-developed-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
Signed-off-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
---
 drivers/iio/pressure/hid-sensor-press.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressure/hid-sensor-press.c
index 5f1d6abda3e4..3d609436a85a 100644
--- a/drivers/iio/pressure/hid-sensor-press.c
+++ b/drivers/iio/pressure/hid-sensor-press.c
@@ -53,17 +53,6 @@ static const struct iio_chan_spec press_channels[] = {
 
 };
 
-/* Adjust channel real bits based on report descriptor */
-static void press_adjust_channel_bit_mask(struct iio_chan_spec *channels,
-					int channel, int size)
-{
-	channels[channel].scan_type.sign = 's';
-	/* Real storage bits will change based on the report desc. */
-	channels[channel].scan_type.realbits = size * 8;
-	/* Maximum size of a sample to capture is u32 */
-	channels[channel].scan_type.storagebits = sizeof(u32) * 8;
-}
-
 /* Channel read_raw handler */
 static int press_read_raw(struct iio_dev *indio_dev,
 			      struct iio_chan_spec const *chan,
@@ -225,7 +214,7 @@ static int press_parse_report(struct platform_device *pdev,
 			&st->press_attr);
 	if (ret < 0)
 		return ret;
-	press_adjust_channel_bit_mask(channels, CHANNEL_SCAN_INDEX_PRESSURE,
+	hid_sensor_adjust_channel_bit_mask(channels, CHANNEL_SCAN_INDEX_PRESSURE,
 					st->press_attr.size);
 
 	dev_dbg(&pdev->dev, "press %x:%x\n", st->press_attr.index,
-- 
2.51.0

