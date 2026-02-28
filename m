Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56A0430B86
	for <linux-iio@vger.kernel.org>; Sat, 28 Feb 2026 20:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772309046; cv=none; b=cfUFghsilpB/cX/+d54T2YrvtwxN+1nIQpX4gP+8VLktF2lZ7OJeoPyu3BFWfz7/9I5OyfLXDJPl3artSeZx6LvR6G+1GkE1sHRMNjBvOQgwPu+7QPYRFAl9oiVNAO0AI0xOGEnnXugiqsUVwRvslA5REdhHQRizkUUsHytrlko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772309046; c=relaxed/simple;
	bh=XR6VB6nJF8YrvnTcNVIaVT4Xgebpbma1v4k6wmlyTok=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H3XHOJnI3UJreFWp30iLlerbbOetomHDYfFaBLNfEux8NcK8mBfb6TuX3ttMipVXaYEe+ilY2uHoSu8tRoHaU98RUJBX9TP+gx8tYmT1ovnBAA4Nlq3BbpsCngtRPcDx6q7VBRzmwKCK+NejJBuKK2tJD5Jhy6mB22YQVrhmkNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=swcClr48; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="swcClr48"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-463208653d6so2543887b6e.3
        for <linux-iio@vger.kernel.org>; Sat, 28 Feb 2026 12:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772309042; x=1772913842; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7RA354iU71vdxVtpuvKh7wmklzvLwNqQbv7Pv/0iW5c=;
        b=swcClr48MmzE91O3+lCFCvVK+w18pTnIWUDCsPG5RRFwOLSs8tPf0leO6S3hEnuZpM
         nXLh9cfsedyIxCOr2Dw9WpdiykGbgSnJWmzejPuYROExOsra6xTEuncVYlB3dEQc/Scz
         057fFqr7rGuKX7UEAMAZxZmpbd81NG2QwXiNNYSO09hEKqT3WlhXOOJ1hq8o08WDKHQp
         SRsq+nGEIKYm3MKmXh+B4w9T0OKmQcBsiru7cWvzgn8HZZ/hF2YxFR5wrg8v3zcT+KuD
         PAUsXOjcafjiJXeNCMIXPPwb5nXGnNfw2BcxPOs6yvTU+FICzqyBCED9wxKXORHMZl2X
         G9qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772309042; x=1772913842;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7RA354iU71vdxVtpuvKh7wmklzvLwNqQbv7Pv/0iW5c=;
        b=HxemUzQUrYbYhicU2Ifljse17UOvRVRdXS0ZWtsW+b8K/fmRCuGoGxdWl5gmTY6hf1
         lRd20PiicO34O+vwleCQPumm7xll2ThrEntQ5gxrpj++keC6UeIakX+xTAUfTOUA4y0M
         uy96scdK+yuSRvLCeomd9MLoKv5Rb5OpbBCzFy7cN45tEkMOLnGUcVysnCyyy9okCRcC
         TlRinMqxOaSyHLEs/w+x3cCLNiqpaAkD2NjE66Xx5Hy3DtIQTCU5PghlWuBkMp3slo7B
         9QiIp/XahNE4hry+GKSujjKOm04T8fnTHjKoFjuyCdgtBX512dmAALmRQ3+5/9e85lGl
         M/Tw==
X-Gm-Message-State: AOJu0Yxsx9ezIaHOBOrm9mBc+6P8o0Tss9lJtumrAF6AsO6nNDPpgQsw
	Zxyda9okclNQFG2t+pDBNCH5KtyQtCsa401ecgdsq6jUPqerdlNcyjXMlChMrLfcQ/Y=
X-Gm-Gg: ATEYQzzNy19zUZSvfL7vXiw6R2/UijkNndQ68powzVc/luoUPoX0noCCMCPheRqtLRq
	61mfIq3T9JKELmzNf9xP/nFZMhdI0O834Y4Cj5SclOQVWvzz4TU8iUiJ4KtbKziS6JJ1TVF6jU6
	frQFeNmhxBExKoanrU4Hs8YHnUU0VZQeIQEEWyoGxbq2ButRCltiIMhO7AZie2DSA/afLwpdXGT
	kEJpXUc9XxKzriDktKsDCJW6NzYk/+iCB+A54VYRs/Rfpc1KXNwtvU26t9TQ2yT1IXRZX1Iu5lz
	VwhJDyr67qMzrQS+nzC8LFubkTPjna0K3gJJ3nxOt3HbZkRGJa+IRCaYmMk2mCiJSDnjq+5BCFX
	a7HF3O/RjcFzfUDRUTGOp+O7uGZPRf9jxlj8AmBLebDW03N5fR+7g+vL2o3Qs8d9Wa0TxgO2ceV
	aBYMd75NYnCF4oE6PcQhZfv/QUqshp
X-Received: by 2002:a05:6808:6f93:b0:45e:a1e2:2808 with SMTP id 5614622812f47-464be9e264amr4592348b6e.27.1772309042658;
        Sat, 28 Feb 2026 12:04:02 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:1031:c44e:9f1f:17c1])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4160d2cf00fsm7579785fac.20.2026.02.28.12.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 12:04:01 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 28 Feb 2026 14:02:22 -0600
Subject: [PATCH v2 1/2] iio: add IIO_DECLARE_QUATERNION() macro
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260228-iio-fix-repeat-alignment-v2-1-d58bfaa2920d@baylibre.com>
References: <20260228-iio-fix-repeat-alignment-v2-0-d58bfaa2920d@baylibre.com>
In-Reply-To: <20260228-iio-fix-repeat-alignment-v2-0-d58bfaa2920d@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-input@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1688; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=XR6VB6nJF8YrvnTcNVIaVT4Xgebpbma1v4k6wmlyTok=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBpo0oj3aPK6TTibAywCpnnXbphM5bdQhcyMCAKB
 SO0lC7iiGqJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaaNKIwAKCRDCzCAB/wGP
 wLj1B/9HqCuuUKHXKZFQAMuLL2CVLsEKFAPI9dc2LA9n9Z9xSKLtDQRcABPPYz0zos0H0iSqtXJ
 3tgqd/k+NH29iprDIwR8g3gs+mRNDZ/kGTiTNgjQzZpbsylIeXDceSeYi9kj+H5d142Ge7rXK1d
 6nLXQj5c7OEsZ/k7kN9HfIJGs1+G9KXupeWGz6y1Tb/yopXgvjZ6088w43HAAnRqehkwzWSB2pe
 05nAae1116lUUbHRzUBpBYozfYwWEaM7U0nHiQBgZy5vuiaVMjOYBaGaoMjf+AwKhjO81Eekiwi
 l0rxaP/6geEzi+bP8jpazjvkmVoc7n1J9fCP4ObrWQm2w++o
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add a new IIO_DECLARE_QUATERNION() macro that is used to declare the
field in an IIO buffer struct that contains a quaternion vector.

Quaternions are currently the only IIO data type that uses the .repeat
feature of struct iio_scan_type. This has an implicit rule that the
element in the buffer must be aligned to the entire size of the repeated
element. This macro will make that requirement explicit. Since this is
the only user, we just call the macro IIO_DECLARE_QUATERNION() instead
of something more generic.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 include/linux/iio/iio.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index a9ecff191bd9..2c91b7659ce9 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -931,6 +931,18 @@ static inline void *iio_device_get_drvdata(const struct iio_dev *indio_dev)
 #define IIO_DECLARE_DMA_BUFFER_WITH_TS(type, name, count) \
 	__IIO_DECLARE_BUFFER_WITH_TS(type, name, count) __aligned(IIO_DMA_MINALIGN)
 
+/**
+ * IIO_DECLARE_QUATERNION() - Declare a quaternion element
+ * @type: element type of the individual vectors
+ * @name: identifier name
+ *
+ * Quaternions are a vector composed of 4 elements (W, X, Y, Z). Use this macro
+ * to declare a quaternion element in a struct to ensure proper alignment in
+ * an IIO buffer.
+ */
+#define IIO_DECLARE_QUATERNION(type, name) \
+	type name[4] __aligned(sizeof(type) * 4)
+
 struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv);
 
 /* The information at the returned address is guaranteed to be cacheline aligned */

-- 
2.43.0

