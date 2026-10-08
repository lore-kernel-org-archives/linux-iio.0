Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D953876CD
	for <linux-iio@vger.kernel.org>; Thu,  8 Oct 2026 05:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791437222; cv=none; b=lbv763uuWigtD6KZ0dzJbUGEKX3E+qaUGWJyaR/StfBUx/Rnw98uUxTLNTAz54XeFm0bWZ7IKBIvO5TlXnnCD7Vxtkj6itB5zhWis7OGz1O0y5SQsHB8nwRH7zysrVo/7pMLnARYMHz+swIQhP7KYlZ5bI7Fl1JD0r+zi61QRPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791437222; c=relaxed/simple;
	bh=kCpneSjNmiQ+uKN1uru50DEBeDjE1ps61mB5XGB9ArU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jaLFsKQHesTT1ZOSmIY5vcOdciW31h8784NRgwcSBLof5PtoVCMLs2ClfV8lmQj92Fk4bUyIlWmb9wuQzjL7ae31fIEzUBC0o0hjKnIFp+fWBXtVCyG9dPTGCL4zXV2p9akNUoCq2QRRQrkiplJa6oxMlCB7qMKLXo4VFkabTSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rc6h+5Fl; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rc6h+5Fl"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3514e7cbbbaso5323225eec.1
        for <linux-iio@vger.kernel.org>; Wed, 07 Oct 2026 22:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791437219; x=1792042019; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FUiKPJBB/QLn6JR/2soSQPjMVxJQocjLWOUnc2itzYU=;
        b=Rc6h+5FllXUOPPwLUmpupRf3V3Cap+Z+NlqWYXjtEEsSYvjwLbCJGVe+/gLqQqqfnE
         mwVpLga+h3phI1vj3AzAW4Te5qXYCbgIWYFcAQ47YliwLrkqfEM4b+OxJnVhyfvx/m45
         q3T7v7IfML2FNJX+H0ZgViXwdVzx4Cf0WmG8ZYgk0Rhj7b0vk5pG0zPWrMkBcM5mNadL
         mMv8uGV12NRbwcH4I0o7y0TJWoE83stVMiclEqhYiR/YZ7e6hu2VhwI32KDiMDMTGVhR
         AF0yFAw7AvK+vLRNIwGYSo+CuGufuT47B0qHuebAJeELGJ2+FR2LNSlvxaY49nOlBi+J
         hqHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791437219; x=1792042019;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FUiKPJBB/QLn6JR/2soSQPjMVxJQocjLWOUnc2itzYU=;
        b=hCAFODU/1v1SdoZRXJhCOgWq6jgfHYyISQ3pcxVCThidTJyLsm4pSPx0/NGpVe98Lh
         7UEsGvmI10T45XBO3njiqvKBDisHFTom8NveRpQdm6VcMW8Kibg1D5eVK7DC8LH8DgoJ
         GxurLlpVhwWa7e4c67FQaWZ5271IMx4l9/WU+AuusiqyNgrgKfn9Ll7q8y1mklLilbqy
         7DffN5iD3KIevh66HLL2PTaEFaM3kIGMaK0ITCb09kMKnKLT6jxdK/9gcioJJ9Eljz08
         ngzKco9h2ikVjDJ+4UpJPmiItrEQQTxCc6nLVS+gRyM3sjvzuMIKGSkO+Flh9YOYo2Yr
         8MYQ==
X-Gm-Message-State: AFuF++m08dIm523A27TdeGzrnBG990mYWFMOMgnHNNSagsSK19lD/yVi
	nNb3foYiMg3z019WQvnNEB6Q3hJFvK36+Kz9KKqRhDbC2sXWMrHGLOWaz+giIg==
X-Gm-Gg: AYBFou15FbGDrKY4DdSzAGFJ6IKTTySOm5NFL7R+7Mw901Wc6y8P4y2XJFp3zUncbFZ
	3+74Vmz4OBJ2Gv+8KiubMIRml5auFkBScFYRVxqNhH5rqNpXmaWQagwMqCkRplCVHyAK5oUY7Yk
	HZw3Umv7YCueOQqYMBztluPspT7xBri5rrJh5RqJcU8z+IgD/Otp6AG+75gnMgh4SL9FWEsMlIN
	c/+iB8l/FAJO9c+OzQ5THXk//2F717aYJGpxSBblaPGenMW+T/oO/sdf7Fg1ogjpyz2P/qs13Tz
	7lEEpXNL4qxPzTuX8DTpnTtr/3wrjtg6oCbyCnV/dk72cxsVkCav9cbeMHm8PdUn0KfPwAvXr1F
	G3hf4dlsSyY0ouwAhalLP/tQLG3pAd71xa16HRjZGjH6v8aIuOvT+0/4F8I8Lv4/AvyAaHCCemC
	atkJNa+rOxEGshERM5Tdvk8oKkGCojkewh12/kRhS9NSO2D2Zlx9MYeSlitu9TnTRdDFj95KbXN
	R4K
X-Received: by 2002:a05:7022:112:b0:166:780c:60b6 with SMTP id a92af1059eb24-166780c615amr1618720c88.9.1791437219119;
        Wed, 07 Oct 2026 22:26:59 -0700 (PDT)
Received: from localhost ([2804:30c:96c:bf00:7844:c38c:894:4054])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-16168f586f8sm13933072c88.13.2026.10.07.22.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 22:26:57 -0700 (PDT)
Date: Thu, 8 Oct 2026 02:27:15 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, nuno.sa@analog.com, andy@kernel.org,
	dlechner@baylibre.com, marcelo.schmitt1@gmail.com
Subject: [PATCH v1 1/1] iio: Allow device drivers to specify IIO event unit
 type
Message-ID: <e359fa003ebc61c8b0e37ba9810a04c70e5a300e.1791437050.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The IIO event ABI documentation distinguishes between interfaces that
handle values in device-specific units (_raw) and event interfaces that
handle values in real-world units (e.g. meters, Joules, lux, etc).
However, the IIO event code infrastructure had never really implemented the
bits to distinguish between those two types of interfaces.

Because distinguishing between device (_raw) and real-world (_input) units
only makes sense for value and hysteresis info, only add complementary enum
item for those.

Users of the IIO event ABI should, as much as possible, match the event
unit type with the channel unit type. I.e. device drivers that present
device-specific raw units for their channels ought to also provide event
interfaces that handle raw units. Conversely, when IIO channels provide
processed (_input) data, IIO events will generally be expected to operate
over real-world units as well.

Complement the IIO event info enum, allowing IIO drivers to specify what
type of event info is used for their event interfaces.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
---
This was originally a patch series [1], but the suggestions provided back then
allowed it to be greatly simplified.

[1]: https://lore.kernel.org/linux-iio/cover.1768759292.git.marcelo.schmitt1@gmail.com/

 include/linux/iio/types.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index d8944c9e5e90..bf03eb498753 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -15,7 +15,11 @@
 enum iio_event_info {
 	IIO_EV_INFO_ENABLE,
 	IIO_EV_INFO_VALUE,
+	IIO_EV_INFO_VALUE_RAW,
+	IIO_EV_INFO_VALUE_INPUT,
 	IIO_EV_INFO_HYSTERESIS,
+	IIO_EV_INFO_HYSTERESIS_RAW,
+	IIO_EV_INFO_HYSTERESIS_INPUT,
 	IIO_EV_INFO_PERIOD,
 	IIO_EV_INFO_HIGH_PASS_FILTER_3DB,
 	IIO_EV_INFO_LOW_PASS_FILTER_3DB,

base-commit: 04434a1d0f311d76b1f15fa987918b471a0b8c6a
-- 
2.53.0

