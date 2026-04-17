Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E94523C51D
	for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 23:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776467152; cv=none; b=UvqBT2eNo/JwBSfiCPWNfAHdJjx+zXM8D//mFFERw3y7MlAmCUK/dkPNPCO2LLGV2WvegsLfOXLSu/cT0HAxMUPxNHkpONJdQAOGeqk80TKC0Vv4CcetZ+zmnMNuWk/GquOB0soQM5fSa5DRP+pRTqesd6aRhKlWIekiyjGTJs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776467152; c=relaxed/simple;
	bh=omTniV8JXzC+vG3kze6wDU7VSrYs9h/RuQnAUdgIDmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hyW+LF4KyyEj3chyes0HSrCrpNt6upizuqENsdOzGgDpFDV4xFNeBBuh6frLfacX+bxdt9sU8x7GdLeh5UM7j3oFNWRH01Ovbkhjr77TMtWZJ4TaULGmn91w0Sla0bVHVQCm9MlWuk6JEb2T0VRfA2nfTixiEhXvrsbN1LkRkqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=UTD+EXZV; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="UTD+EXZV"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2e221a71e19so1172599eec.0
        for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 16:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776467150; x=1777071950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X2t4MxwK4lBjxVkBWmRszaAq6lQWckN59/yHcFZNNFM=;
        b=UTD+EXZV7l+GVhgQtna292ygx8srElFuz59De5LwPa+rc59cS4OwZgt3ROsrbZz32V
         p8SQL4lsMQNyrENUKLluC6XgFa2IbzH+0qXn2M3u/7x9H0alIFgOVQm9U2CG3flvN1/W
         YosLY8ATC+g+SsH13i59gOt5d9gIFnHjcKn+yGWE9+hcFM2RPD9o7ozFu+zP0uTPmdp6
         MSwtt968kC3VFS5h7PrNVhDrbZSiIZoMlfBIbhmgWjBVbAM5p+SFN+pP+usdYalWw9uU
         snskl+a+GYLKNPFBvdiXRY27Hhw7yMtVGLfEGHxeCfA917jjm2ucBUpGGL2DVFtSWSqa
         bMZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776467150; x=1777071950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X2t4MxwK4lBjxVkBWmRszaAq6lQWckN59/yHcFZNNFM=;
        b=AZR1r9lIJ+oKOT52UE9YoQnUSYGQyj8tPC9adXuYtYXiQDCwWUvp/YFicpetr24BO1
         DLLjoeb6pmM3gNElQNOGsBqsSheVMvcaiql7WSjBcrsejixfKpBBDiUj3GOdlAfbXogA
         LpuOJEVLQckSuGb10HP7dx60r34GgXo+D0n0bkxgi670z7SyewUGyeN3g/kbLow5cW88
         7GuLxtmP9l18cGgfSJNN1Nrqjd4brzhwqzfpXYSZR5bTXk7lvP8/eGHbKYRWw5uz828n
         SteEL3I7DSbN8SWSBts8J1LvxKYyDLnHR6dRtDD9QLvSpnpM5cU413sSgZWIvK01IEux
         lskg==
X-Forwarded-Encrypted: i=1; AFNElJ9uP0L1c8PZaVA6t2RXkiF3mMlUGiFbQoStvKCfQ6I1QEJ2sKgXqxNUVav1eXoTX39fp8ehfR7UuEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHKHonud0owIjlx1VAZt89Hr7iIaR1H9da/ixAhebr1jLcN4co
	rQGGdIsEvaWLdZILsyw8WTSYwcKdG9s6a/RAGLkXJZ8b0Wl5WVWOGpbyfyz/L3uK3v8=
X-Gm-Gg: AeBDietw5qHx6LZrVr3UnM4RQMjM97W+zNdItdv8cFU2j6iU3aEjLdMR/R7rixeU9A2
	o/B6z23LN9R34S735dYCqTk3tiHB/XGhOUJxQW8krsX7Ht0Xw/Dkg0lQq/FwJZMjSO1ge/VN94d
	1OU33YZo57+D7d/KFPlB8zmGqefnt6dYyPxrAcyliFzAIL9u8gTzgAiYx1VeN8xD77uyxyuTaRT
	MOnxc641JmZSoq0u6BRrctc5F0hj1LRFGUBzFhb+9/5sn2IHY0XKGQhNjVovXElW3973Iok95V4
	/B1E0PJ1aOUZfxlK3yy9ve5D6VURPRrKMNRt9kGYhlntoAUnKjrWWxezKwGz4D6lUUzMKoiIJgE
	XYeqjTsG48qCSee9oGYhVi2HfrIB1YqlcQMZMMicdPaGIYBdWIM70v+raLUPurTgN2M/e+AUu7A
	jQm6lnys0u6dMo9sBjnd13Q0M6CoiU0UNe7PZS/g==
X-Received: by 2002:a05:7300:7491:b0:2d6:4297:5fc7 with SMTP id 5a478bee46e88-2e4872fb657mr2487132eec.25.1776467149547;
        Fri, 17 Apr 2026 16:05:49 -0700 (PDT)
Received: from natalia-pc ([187.116.73.68])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53ccce440sm4117637eec.14.2026.04.17.16.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 16:05:49 -0700 (PDT)
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
Subject: [PATCH 6/7] iio: magnetometer: HID: Replace method magn_3d_adjust_channel_bit_mask()
Date: Fri, 17 Apr 2026 19:58:49 -0300
Message-ID: <20260417225959.16688-7-natalia.andre@ime.usp.br>
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

Replace method magn_3d_adjust_channel_bit_mask()
with helper method hid_sensor_adjust_channel_bit_mask().

Signed-off-by: Natália Salvino André <natalia.andre@ime.usp.br>
Co-developed-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
Signed-off-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
---
 drivers/iio/magnetometer/hid-sensor-magn-3d.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
index c673f9323e47..48a968b3aebb 100644
--- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
+++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
@@ -132,17 +132,6 @@ static const struct iio_chan_spec magn_3d_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(7)
 };
 
-/* Adjust channel real bits based on report descriptor */
-static void magn_3d_adjust_channel_bit_mask(struct iio_chan_spec *channels,
-						int channel, int size)
-{
-	channels[channel].scan_type.sign = 's';
-	/* Real storage bits will change based on the report desc. */
-	channels[channel].scan_type.realbits = size * 8;
-	/* Maximum size of a sample to capture is u32 */
-	channels[channel].scan_type.storagebits = sizeof(u32) * 8;
-}
-
 /* Channel read_raw handler */
 static int magn_3d_read_raw(struct iio_dev *indio_dev,
 			      struct iio_chan_spec const *chan,
@@ -418,7 +407,7 @@ static int magn_3d_parse_report(struct platform_device *pdev,
 			if (i != CHANNEL_SCAN_INDEX_TIMESTAMP) {
 				/* Set magn_val_addr to iio value address */
 				st->magn_val_addr[i] = &st->iio_vals[*chan_count];
-				magn_3d_adjust_channel_bit_mask(_channels,
+				hid_sensor_adjust_channel_bit_mask(_channels,
 								*chan_count,
 								st->magn[i].size);
 			}
-- 
2.51.0

