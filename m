Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBF8476047
	for <linux-iio@vger.kernel.org>; Thu, 20 Aug 2026 14:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787235312; cv=none; b=mqtDtPuyBI61m0ZtZ1ryUPrFEovIRD+nYJeFMyi5txrKlkUwEWOD9hGyrjS/HC/ZhEANLh92jfn90iT679xmjv2lBugMAYA9k9SriZaVjOV47UhwaU1O+/uovQqf5Gn/+ViIbc4Opd30V1aOmaI5HuO94TM107pTsGqjIyQYtEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787235312; c=relaxed/simple;
	bh=ATV2epUgQ//xwLJ6PqHRiWhjqzj70Jrhql9n80f8JHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ttDDsg1Ja378oO5C6TG5dsYskOMWpFRNlEAXz1c+XiXk5UW+lNlg2tqqukYanzDAsMgMxmf9vDX7UxJ9Odf6K8AY8Pz+iWlxuEmi+iaPBoEGJw9b/4uN9+kwvVXDvXEzE2V98aBya089izPh6sSdhnd5OiAH40e04zdPw83tz6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EMLIyI8G; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMLIyI8G"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-936e8bd9caaso187636785a.2
        for <linux-iio@vger.kernel.org>; Thu, 20 Aug 2026 07:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787235309; x=1787840109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lklCbIfFCihf07Z2uWEZysybMb+M24pIoN7/KT/gjMY=;
        b=EMLIyI8G7bfPY00FvfXv8AdPTze6010AcGwBSY74e5MVn4AaQCyWaFMw5fEmfC90Qk
         5Nq4hdG0KLqQ+N01Uulats+102wkqtpOuLdXVvAuTqsNsqV/gDDKSbqsIhwSi+A5OuW9
         XqZFFzsl6d+TVyNtIysuyDfDLU0Bh6e19jCP4yL3E9Qzs5SjsiXVCD28e9sFsAtZtcn0
         RPm7oSH2e4sT70sK44rqV1/x1y04sWSycsxKIJFNtnENoQ+LlKJLSoDcTElQTkkgA4dO
         5drNyK4u63XNdbbtNgFWCa66P/TtSB8ZdJKA4NT0WIDrw0hewm5H4AnAeDxtX/EoELk3
         yPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787235309; x=1787840109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lklCbIfFCihf07Z2uWEZysybMb+M24pIoN7/KT/gjMY=;
        b=IT4Yp61P+s3RZsQUVSwAmDCZWDHtoVhU7ZGx/xRF5qE4mtsopASGKWghzCqQ1DuQ5K
         1/4WcNLtQix5yQB+XJmYSiSYqy8bc1H6c7VXYnzKw6EIX8fTFUKmMh7+1zHkpma/EHdw
         FUeLMCLzRWjR2tJcV/O/u9cIaniu9WtN0nMo5lIxQ0yaI9phWHbA/w11QPeLfa4dv4CI
         KQFFrbhADWraY1HLmTTMjjh1254RfwLlj38BOQ0QDz1bktS1RoODFWKqXti5y5wTmXsu
         HDsCYYNenovpE880t9wzuYXKnjSxqFVw5Q0PatgjDOxiMRmAQx3OepHASSVQ1ORBN0kN
         bklA==
X-Forwarded-Encrypted: i=1; AHgh+RoXv0RmB9wJO3m7fGc+7krXfGOOmt/eSxw7BvcDYkWSbJeQbM2J/9SSRdCqn3HjZTmNbIM9TtnL7iA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxndfIPoy+uvGVf3HwKwCUyM78qeWTXAn8W8utYVQ8WKd8ApDLC
	6nBfC0/k2WvLiqlxq1XXLsaObWfomSni1HFBfqWljNSMFRGw66LQ6Qmd
X-Gm-Gg: AR+sD13gn8qv6tEIbcvzb6Kn8pn0/IxxPUNv/cRM//d6MhZT3mr9PtKBPTA8lN0t2VU
	A8UQJCDd2yBqRdy5uRxoVz0/EZ2ZPqp44D/wCKzxuJeHpiqFX+qllkBwkdU64nO1Q4uOX+38fai
	3LWpsx6flvYVPJ6oZm7LZV+QZrlaC0VlCIze40iXLcDpJrkJAHxf1Rcz5h+9gDyUCQojwv6aXBj
	k3+WsoXjCRbejTCZS+lMRSmnD81162fb28dIFtQF3uwaXYlTQZBB+xUYw5Y1TTgEL6Uxk8JupnO
	0J6BDtUhixqT+pJtXB2Z1sKMUuPngjFW832X5Zq2OwtS1xWOIcyDbaZP56bX0jfLe022v5oANWi
	wv7LHpGdu4c20DcTzu+HaKapO47YRVfuNMsHTguPHSBwzmDj4ISysJL+eXgWqJrn52bfcfDSWO2
	6QpjUnuUABzz4lSeTBFvLdm8K5/aurY0QwaAxZ/Qqc9Kr0s0vWiyH2UCCOG+bGwVJAbR3ICiesy
	zlIErcvLncw
X-Received: by 2002:a05:620a:4613:b0:92e:4799:a808 with SMTP id af79cd13be357-9371e7498f6mr1087729185a.40.1787235308842;
        Thu, 20 Aug 2026 07:15:08 -0700 (PDT)
Received: from louisarchdesktop ([2601:184:417f:5ad5:c570:9008:5a2b:8db7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9372059de87sm372738085a.47.2026.08.20.07.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 07:15:08 -0700 (PDT)
From: Louis Adamian <adamianlouis@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Louis Adamian <adamianlouis@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/5] iio: pressure: ms5637: Add per-variant compensation
Date: Thu, 20 Aug 2026 10:12:20 -0400
Message-ID: <20260820141224.23730-6-adamianlouis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820141224.23730-1-adamianlouis@gmail.com>
References: <20260820141224.23730-1-adamianlouis@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, all sensors used the compensation for the MS5637-02BA. Add
correct temperature compensation for MS5637-30BA, MS5803-01BA,
MS5803-02BA, MS5803-05BA, MS5803-14BA, MS5803-30BA, MS5805, MS5837-02BA
and MS5837-30BA.

The deprecated meas,ms5803, meas,ms5637 and meas,ms5837 compatibles
resolve to the -02BA variants. This changes the values that meas,ms5803
and meas,ms5837 report.

meas,ms5805 now uses its own constants, correcting its readings. MS8607
gets its own constants struct. The values match the MS5637-02BA ones it
previously shared, so its readings are unchanged.

Signed-off-by: Louis Adamian <adamianlouis@gmail.com>
---
 drivers/iio/pressure/ms5637.c | 376 ++++++++++++++++++++++++++++++++--
 1 file changed, 360 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/pressure/ms5637.c b/drivers/iio/pressure/ms5637.c
index 359f3a8e79b2..81b87b79e011 100644
--- a/drivers/iio/pressure/ms5637.c
+++ b/drivers/iio/pressure/ms5637.c
@@ -223,51 +223,395 @@ static const struct ms_tp_comp_consts ms5637_02_consts = {
 	.press_shift = 15,
 };
 
-static const struct ms_tp_data ms5637_data = {
-	.name = "ms5637",
+static const struct ms_tp_data ms5637_02_data = {
+	.name = "ms5637-02ba",
 	.hw = &ms5637_hw_data,
 	.comp_consts = &ms5637_02_consts,
 };
 
-static const struct ms_tp_data ms5803_data = {
-	.name = "ms5803",
+/*
+ * MS5637-30BA compensation constants
+ * Datasheet: https://www.te.com/commerce/DocumentDelivery/DDEController?Action=showdoc&DocId=Data+Sheet%7FMS5637-30BA%7FA3%7Fpdf%7FEnglish%7FENG_DS_MS5637-30BA_A3.pdf
+ * Pages: 8-9
+ * Sections: Pressure and Temperature Calculation, Second Order Temperature Compensation
+ */
+static const struct ms_tp_comp_consts ms5637_30_consts = {
+	.press_scale = 100,
+	.high_t2_multiplier = 2,
+	.high_t2_shift = 37,
+	.high_off2_multiplier = 1,
+	.high_off2_shift = 4,
+	.low_t2_multiplier = 3,
+	.low_t2_shift = 33,
+	.low_off2_multiplier = 3,
+	.low_off2_shift = 1,
+	.low_sens2_multiplier = 5,
+	.low_sens2_shift = 3,
+	.vlow_off2_multiplier = 7,
+	.vlow_sens2_multiplier = 4,
+	.has_vhigh_temp = false,
+	.off_t1_shift = 16,
+	.off_shift = 7,
+	.sens_t1_shift = 15,
+	.sens_shift = 8,
+	.press_sens_shift = 21,
+	.press_shift = 13,
+};
+
+static const struct ms_tp_data ms5637_30_data = {
+	.name = "ms5637-30ba",
+	.hw = &ms5637_hw_data,
+	.comp_consts = &ms5637_30_consts,
+};
+
+/*
+ * MS5803-01BA compensation Constants
+ * Datasheet: https://www.te.com/commerce/DocumentDelivery/DDEController?Action=srchrtrv&DocNm=MS5803-01BA&DocType=Data%20Sheet&DocLang=English&DocFormat=pdf
+ * Pages: 13-14
+ * Sections: Pressure and Temperature Calculation, Second Order Temperature Compensation
+ */
+static const struct ms_tp_comp_consts ms5803_01_consts = {
+	.press_scale = 1000,
+	.high_t2_multiplier = 0,
+	.high_t2_shift = 0,
+	.high_off2_multiplier = 0,
+	.high_off2_shift = 0,
+	.low_t2_multiplier = 1,
+	.low_t2_shift = 31,
+	.low_off2_multiplier = 3,
+	.low_off2_shift = 0,
+	.low_sens2_multiplier = 7,
+	.low_sens2_shift = 3,
+	.vlow_off2_multiplier = 0,
+	.vlow_sens2_multiplier = 2,
+	.has_vhigh_temp = true,
+	.off_t1_shift = 16,
+	.off_shift = 7,
+	.sens_t1_shift = 15,
+	.sens_shift = 8,
+	.press_sens_shift = 21,
+	.press_shift = 15,
+};
+
+static const struct ms_tp_data ms5803_01_data = {
+	.name = "ms5803-01ba",
 	.hw = &ms5803_hw_data,
-	.comp_consts = &ms5637_02_consts,
+	.comp_consts = &ms5803_01_consts,
+};
+
+/*
+ * MS5803-02BA compensation constants
+ * Datasheet: https://www.te.com/commerce/DocumentDelivery/DDEController?Action=srchrtrv&DocNm=MS5803-02BA&DocType=Data%20Sheet&DocLang=English&DocFormat=pdf
+ * Pages: 13-14
+ * Sections: Pressure and Temperature Calculation, Second Order Temperature Compensation
+ */
+static const struct ms_tp_comp_consts ms5803_02_consts = {
+	.press_scale = 1000,
+	.high_t2_multiplier = 0,
+	.high_t2_shift = 0,
+	.high_off2_multiplier = 0,
+	.high_off2_shift = 0,
+	.low_t2_multiplier = 1,
+	.low_t2_shift = 31,
+	.low_off2_multiplier = 61,
+	.low_off2_shift = 4,
+	.low_sens2_multiplier = 2,
+	.low_sens2_shift = 0,
+	.vlow_off2_multiplier = 20,
+	.vlow_sens2_multiplier = 12,
+	.has_vhigh_temp = false,
+	.off_t1_shift = 17,
+	.off_shift = 6,
+	.sens_t1_shift = 16,
+	.sens_shift = 7,
+	.press_sens_shift = 21,
+	.press_shift = 15,
+};
+
+static const struct ms_tp_data ms5803_02_data = {
+	.name = "ms5803-02ba",
+	.hw = &ms5803_hw_data,
+	.comp_consts = &ms5803_02_consts,
+};
+
+/*
+ * MS5803-05BA compensation constants
+ * Datasheet: https://www.te.com/commerce/DocumentDelivery/DDEController?Action=srchrtrv&DocNm=MS5803-05BA&DocType=Data%20Sheet&DocLang=English&DocFormat=pdf&PartCntxt=MS580305BA01-00
+ * Pages: 13-14
+ * Sections: Pressure and Temperature Calculation, Second Order Temperature Compensation
+ */
+static const struct ms_tp_comp_consts ms5803_05_consts = {
+	.press_scale = 1000,
+	.high_t2_multiplier = 0,
+	.high_t2_shift = 0,
+	.high_off2_multiplier = 0,
+	.high_off2_shift = 0,
+	.low_t2_multiplier = 3,
+	.low_t2_shift = 33,
+	.low_off2_multiplier = 3,
+	.low_off2_shift = 3,
+	.low_sens2_multiplier = 7,
+	.low_sens2_shift = 3,
+	.vlow_off2_multiplier = 0,
+	.vlow_sens2_multiplier = 3,
+	.has_vhigh_temp = false,
+	.off_t1_shift = 18,
+	.off_shift = 5,
+	.sens_t1_shift = 17,
+	.sens_shift = 7,
+	.press_sens_shift = 21,
+	.press_shift = 15,
+};
+
+static const struct ms_tp_data ms5803_05_data = {
+	.name = "ms5803-05ba",
+	.hw = &ms5803_hw_data,
+	.comp_consts = &ms5803_05_consts,
+};
+
+/*
+ * MS5803-14BA compensation constants
+ * Datasheet: https://www.te.com/commerce/DocumentDelivery/DDEController?Action=srchrtrv&DocNm=MS5803-14BA&DocType=Data%20Sheet&DocLang=English&DocFormat=pdf&PartCntxt=MS580314BA01-50
+ * Pages: 13-14
+ * Sections: Pressure and Temperature Calculation, Second Order Temperature Compensation
+ */
+static const struct ms_tp_comp_consts ms5803_14_consts = {
+	.press_scale = 100,
+	.high_t2_multiplier = 7,
+	.high_t2_shift = 37,
+	.high_off2_multiplier = 1,
+	.high_off2_shift = 4,
+	.low_t2_multiplier = 3,
+	.low_t2_shift = 33,
+	.low_off2_multiplier = 3,
+	.low_off2_shift = 1,
+	.low_sens2_multiplier = 5,
+	.low_sens2_shift = 3,
+	.vlow_off2_multiplier = 7,
+	.vlow_sens2_multiplier = 4,
+	.has_vhigh_temp = false,
+	.off_t1_shift = 16,
+	.off_shift = 7,
+	.sens_t1_shift = 15,
+	.sens_shift = 8,
+	.press_sens_shift = 21,
+	.press_shift = 15,
+};
+
+static const struct ms_tp_data ms5803_14_data = {
+	.name = "ms5803-14ba",
+	.hw = &ms5803_hw_data,
+	.comp_consts = &ms5803_14_consts,
+};
+
+/*
+ * MS5803-30BA compensation constants
+ * Datasheet: https://www.te.com/commerce/DocumentDelivery/DDEController?Action=srchrtrv&DocNm=MS5803-30BA&DocType=Data%20Sheet&DocLang=English&DocFormat=pdf&PartCntxt=MS580330BA01-00
+ * Pages: 13-14
+ * Sections: Pressure and Temperature Calculation, Second Order Temperature Compensation
+ */
+static const struct ms_tp_comp_consts ms5803_30_consts = {
+	.press_scale = 100,
+	.high_t2_multiplier = 7,
+	.high_t2_shift = 37,
+	.high_off2_multiplier = 1,
+	.high_off2_shift = 4,
+	.low_t2_multiplier = 3,
+	.low_t2_shift = 33,
+	.low_off2_multiplier = 3,
+	.low_off2_shift = 1,
+	.low_sens2_multiplier = 5,
+	.low_sens2_shift = 3,
+	.vlow_off2_multiplier = 7,
+	.vlow_sens2_multiplier = 4,
+	.has_vhigh_temp = false,
+	.off_t1_shift = 16,
+	.off_shift = 7,
+	.sens_t1_shift = 15,
+	.sens_shift = 8,
+	.press_sens_shift = 21,
+	.press_shift = 13,
+};
+
+static const struct ms_tp_data ms5803_30_data = {
+	.name = "ms5803-30ba",
+	.hw = &ms5803_hw_data,
+	.comp_consts = &ms5803_30_consts,
+};
+
+/*
+ * MS5805-02BA01 compensation constants
+ * Datasheet: https://www.te.com/commerce/DocumentDelivery/DDEController?Action=srchrtrv&DocNm=MS5805-02BA01&DocType=Data%20Sheet&DocLang=English&DocFormat=pdf&PartCntxt=MS580502BA01-50
+ * Pages: 8-9
+ * Sections: Pressure and Temperature Calculation, Second Order Temperature Compensation
+ */
+static const struct ms_tp_comp_consts ms5805_consts = {
+	.press_scale = 1000,
+	.high_t2_multiplier = 0,
+	.high_t2_shift = 0,
+	.high_off2_multiplier = 0,
+	.high_off2_shift = 0,
+	.low_t2_multiplier = 11,
+	.low_t2_shift = 35,
+	.low_off2_multiplier = 31,
+	.low_off2_shift = 3,
+	.low_sens2_multiplier = 63,
+	.low_sens2_shift = 5,
+	.vlow_off2_multiplier = 0,
+	.vlow_sens2_multiplier = 0,
+	.has_vhigh_temp = false,
+	.off_t1_shift = 17,
+	.off_shift = 6,
+	.sens_t1_shift = 16,
+	.sens_shift = 7,
+	.press_sens_shift = 21,
+	.press_shift = 15,
 };
 
 static const struct ms_tp_data ms5805_data = {
 	.name = "ms5805",
 	.hw = &ms5637_hw_data,
-	.comp_consts = &ms5637_02_consts,
+	.comp_consts = &ms5805_consts,
+};
+
+/*
+ * MS5837-02BA compensation constants
+ * Datasheet: https://www.te.com/commerce/DocumentDelivery/DDEController?Action=srchrtrv&DocNm=MS5837-02BA01&DocType=Data%20Sheet&DocLang=English&DocFormat=pdf&PartCntxt=20000979-00
+ * Pages: 7-8
+ * Sections: Pressure and Temperature Calculation, Second Order Temperature Compensation
+ */
+static const struct ms_tp_comp_consts ms5837_02_consts = {
+	.press_scale = 1000,
+	.high_t2_multiplier = 0,
+	.high_t2_shift = 0,
+	.high_off2_multiplier = 0,
+	.high_off2_shift = 0,
+	.low_t2_multiplier = 11,
+	.low_t2_shift = 35,
+	.low_off2_multiplier = 31,
+	.low_off2_shift = 3,
+	.low_sens2_multiplier = 63,
+	.low_sens2_shift = 5,
+	.vlow_off2_multiplier = 0,
+	.vlow_sens2_multiplier = 0,
+	.has_vhigh_temp = false,
+	.off_t1_shift = 17,
+	.off_shift = 6,
+	.sens_t1_shift = 16,
+	.sens_shift = 7,
+	.press_sens_shift = 21,
+	.press_shift = 15,
 };
 
-static const struct ms_tp_data ms5837_data = {
-	.name = "ms5837",
+static const struct ms_tp_data ms5837_02_data = {
+	.name = "ms5837-02ba",
 	.hw = &ms5637_hw_data,
-	.comp_consts = &ms5637_02_consts,
+	.comp_consts = &ms5837_02_consts,
+};
+
+/*
+ * MS5837-30BA compensation constants
+ * Datasheet: https://www.te.com/commerce/DocumentDelivery/DDEController?Action=srchrtrv&DocNm=MS5837-30BA&DocType=Data%20Sheet&DocLang=English&DocFormat=pdf&PartCntxt=MS583730BA01-50
+ * Pages: 11-12
+ * Sections: Pressure and Temperature Calculation, Second Order Temperature Compensation
+ */
+static const struct ms_tp_comp_consts ms5837_30_consts = {
+	.press_scale = 100,
+	.high_t2_multiplier = 2,
+	.high_t2_shift = 37,
+	.high_off2_multiplier = 1,
+	.high_off2_shift = 4,
+	.low_t2_multiplier = 3,
+	.low_t2_shift = 33,
+	.low_off2_multiplier = 3,
+	.low_off2_shift = 1,
+	.low_sens2_multiplier = 5,
+	.low_sens2_shift = 3,
+	.vlow_off2_multiplier = 7,
+	.vlow_sens2_multiplier = 4,
+	.has_vhigh_temp = false,
+	.off_t1_shift = 16,
+	.off_shift = 7,
+	.sens_t1_shift = 15,
+	.sens_shift = 8,
+	.press_sens_shift = 21,
+	.press_shift = 13,
+};
+
+static const struct ms_tp_data ms5837_30_data = {
+	.name = "ms5837-30ba",
+	.hw = &ms5637_hw_data,
+	.comp_consts = &ms5837_30_consts,
+};
+
+/*
+ * MS8607-02BA compensation constants
+ * Datasheet: https://www.te.com/commerce/DocumentDelivery/DDEController?Action=srchrtrv&DocNm=MS8607-02BA01&DocType=Data%20Sheet&DocLang=English&DocFormat=pdf&PartCntxt=CAT-BLPS0018
+ * Pages: 9-10
+ * Sections: Pressure and Temperature Calculation, Second Order Temperature Compensation
+ */
+static const struct ms_tp_comp_consts ms8607_consts = {
+	.press_scale = 1000,
+	.high_t2_multiplier = 5,
+	.high_t2_shift = 38,
+	.high_off2_multiplier = 0,
+	.high_off2_shift = 0,
+	.low_t2_multiplier = 3,
+	.low_t2_shift = 33,
+	.low_off2_multiplier = 61,
+	.low_off2_shift = 4,
+	.low_sens2_multiplier = 29,
+	.low_sens2_shift = 4,
+	.vlow_off2_multiplier = 17,
+	.vlow_sens2_multiplier = 9,
+	.has_vhigh_temp = false,
+	.off_t1_shift = 17,
+	.off_shift = 6,
+	.sens_t1_shift = 16,
+	.sens_shift = 7,
+	.press_sens_shift = 21,
+	.press_shift = 15,
 };
 
 static const struct ms_tp_data ms8607_data = {
 	.name = "ms8607-temppressure",
 	.hw = &ms5637_hw_data,
-	.comp_consts = &ms5637_02_consts,
+	.comp_consts = &ms8607_consts,
 };
 
 static const struct i2c_device_id ms5637_id[] = {
-	{ .name = "ms5637", .driver_data = (kernel_ulong_t)&ms5637_data },
-	{ .name = "ms5803", .driver_data = (kernel_ulong_t)&ms5803_data },
+	{ .name = "ms5637", .driver_data = (kernel_ulong_t)&ms5637_02_data },
+	{ .name = "ms5637-02ba", .driver_data = (kernel_ulong_t)&ms5637_02_data },
+	{ .name = "ms5637-30ba", .driver_data = (kernel_ulong_t)&ms5637_30_data },
+	{ .name = "ms5803", .driver_data = (kernel_ulong_t)&ms5803_02_data },
+	{ .name = "ms5803-01ba", .driver_data = (kernel_ulong_t)&ms5803_01_data },
+	{ .name = "ms5803-02ba", .driver_data = (kernel_ulong_t)&ms5803_02_data },
+	{ .name = "ms5803-05ba", .driver_data = (kernel_ulong_t)&ms5803_05_data },
+	{ .name = "ms5803-14ba", .driver_data = (kernel_ulong_t)&ms5803_14_data },
+	{ .name = "ms5803-30ba", .driver_data = (kernel_ulong_t)&ms5803_30_data },
 	{ .name = "ms5805", .driver_data = (kernel_ulong_t)&ms5805_data },
-	{ .name = "ms5837", .driver_data = (kernel_ulong_t)&ms5837_data },
+	{ .name = "ms5837", .driver_data = (kernel_ulong_t)&ms5837_02_data },
+	{ .name = "ms5837-02ba", .driver_data = (kernel_ulong_t)&ms5837_02_data },
+	{ .name = "ms5837-30ba", .driver_data = (kernel_ulong_t)&ms5837_30_data },
 	{ .name = "ms8607-temppressure", .driver_data = (kernel_ulong_t)&ms8607_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ms5637_id);
 
 static const struct of_device_id ms5637_of_match[] = {
-	{ .compatible = "meas,ms5637", .data = &ms5637_data },
-	{ .compatible = "meas,ms5803", .data = &ms5803_data },
+	{ .compatible = "meas,ms5637", .data = &ms5637_02_data },
+	{ .compatible = "meas,ms5637-02ba", .data = &ms5637_02_data },
+	{ .compatible = "meas,ms5637-30ba", .data = &ms5637_30_data },
+	{ .compatible = "meas,ms5803", .data = &ms5803_02_data },
+	{ .compatible = "meas,ms5803-01ba", .data = &ms5803_01_data },
+	{ .compatible = "meas,ms5803-02ba", .data = &ms5803_02_data },
+	{ .compatible = "meas,ms5803-05ba", .data = &ms5803_05_data },
+	{ .compatible = "meas,ms5803-14ba", .data = &ms5803_14_data },
+	{ .compatible = "meas,ms5803-30ba", .data = &ms5803_30_data },
 	{ .compatible = "meas,ms5805", .data = &ms5805_data },
-	{ .compatible = "meas,ms5837", .data = &ms5837_data },
+	{ .compatible = "meas,ms5837", .data = &ms5837_02_data },
+	{ .compatible = "meas,ms5837-02ba", .data = &ms5837_02_data },
+	{ .compatible = "meas,ms5837-30ba", .data = &ms5837_30_data },
 	{ .compatible = "meas,ms8607-temppressure", .data = &ms8607_data },
 	{ }
 };
-- 
2.55.0

