Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794862433;
	b=zWj+tjy6gVgcXbzB+8Ig4jF6ePflKnYo6yMeHsX/xgaegtDHfe6I5bI3l2M316qP/gkC
	 eaOOv56jQ2pUoBHH2iIeicpR8J0McTCZEmN4dNJr4XrNacI/3UYzl1c09WHMz/VBRBbiX
	 DLqATESYogG+1Fgjabh5mP9t5Ugx2W3OarpIp885eFoqtLwl42pFCkNOB/BmO388yJ2fY
	 qSoCoRzX/vWwTibxroLql0wR3kn/fBSm//CiJ3wN2uhH/YgAPC6zaaFzb1p7cjnu5ppYE
	 +9HCdERfjOXA13k4E1t1qzQ4gg18WxD7PYm06Bqa1XN8ftuetTSmCLK8kixy6VlzdzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794862433;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=oLtriKjTvSSHrsef7Np3jMgnZ+Hl7Owr5a+y0JpAEig=;
	b=h0Utpj7Y+342luymAMocjghB7wccUMnzZ8lWoGtUcCO0THPN2YqyntM0nSqOXprTiHPF
	 af4gUExWCuPSLiQc4AO4mrVpqWV8PPd9Ps2/GZVZO76fW8M+kZMloRhu03VrrtHOceQxs
	 A4vV2nQIApE/ZvQlc91Lnaf5eCltasetM5cSwVUQ4S8rPJlkn5QdwY6QONLmGWFctBpvN
	 Ah9l3jyEIYubcHyZpDEh0fMZMbZ465N+1wXurtCmMmqGatvFC5I8lbznL3MP723L9i5Xb
	 yOtqJ2IHSZEh/4QUf6oNE7hWpWGASXTRAfjhQb/k0M1ciW9eH2x4Hx7eBJyO8mHfJrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TJ7Y3AFN;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240C5606A88E
	for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2026 20:53:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 240C5606A88E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TJ7Y3AFN
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1b3beeaf6f9so4683573c88.0
        for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2026 12:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794862432; x=1795467232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oLtriKjTvSSHrsef7Np3jMgnZ+Hl7Owr5a+y0JpAEig=;
        b=TJ7Y3AFN2mQOWIbXoIbygcGFIeOTdYnH2URceY/WJFdyf+bMQD+mYAJIrRPC4h3YfA
         NMBXffUDVPbIjQ709/3XtATSDVDATK0bIbHk5ZfEvXiUuxJMnuC3EYOmP6lA66PsPhg+
         MWRzqrEWfZ4RrYPDdbJ+5R4qbNXHYp4AIVsds/1QyGChOpYdEtyHJp2HAEuSEa2Oii1q
         rAoufgP1M0G8/XartnNVQ8c5229Hniax2Dn4AY9J8U4fcfzd6qRxfVus+elB7Zt5Ke1v
         AXQJVBt6rCbWmiWa1m8Xah/lP+l7bHVEgd1CcAuZH4H5cYWee0CoV4CsKt8vC7+4F/UI
         AjFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794862432; x=1795467232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oLtriKjTvSSHrsef7Np3jMgnZ+Hl7Owr5a+y0JpAEig=;
        b=LSlvlLBGcrehjLo2foScUtuVLdUM1NfUWJj+BVNVmY+bUD8htqo5KwRoEUAvvptxAa
         kZ0hKh2n039Q8MTGs00IB9mOtCngaFrXxpc1+rd3zb7LAXUE8SvBk5I2GTD3IQ7fia2U
         IpczbaoB6mkSZc6g/kIymnAmh5nDlg6cvagizv5vGhYSuCFJ351EYH1t+PYlH5BobHU7
         +L06G/+5huic+wBakdXwUF56xK3pK3uCIY2Dvl5Y+UGL8ZzBqqxmEBi95XC4dNY9CiHf
         fXeqrU3vNVgrrjjKyxS9M11AL9+K3es4NvJGemdF/I6bEwLBx+URiTl0uB6hgDQhHLl0
         zWiQ==
X-Forwarded-Encrypted: i=1; AL+hErGdHqlC9vv+PcOiJCtPzV4zq4YkdOGWbaZdOWsL4hcnfgwuiAMd4agYgQGD1+x/rxNLMYzH7Nt8Lso=@vger.kernel.org
X-Gm-Message-State: APuU4Z+UiCbKWEp1j4k/StHftmd1wifoAmQ3728HIbko4TWtizL0tb4a
	xXm/vh7k8vFeTYTGAPRp8MclTt9tBfxWfkgPk+EVV6PgYUKqe2Wm7v0+
X-Gm-Gg: AYBFou0ityneN5j2jIvQPcS9/Axn3zC5tgIjzDJGYRuAGEoiP9EKe3VgM77/p/67RA+
	8RyBavKuxLbW6tVF29THp6y2aP1V7BS6/X8nG45IccNN7ymo1HGZwWoW5LhnQ8uKptjBJHJScu5
	M+3hNa7QK5tTJLtVVMEzlSUZlI5MF7kNdpcNJvHEz/Gwsecl/wVcYiCuuFyyGkgjIoyrZFrTzO8
	RVQBGWWOEDOVjkBxLlE4B3n+GwAbTvnOiP0ZZcMJn0U0USqLwvza/eO+4fe1C5UQh1dcyx4xdNI
	d9NJfHcVCn9LgOkEDe6JhgUXx9OQQmKRjUDV1rTKK2gU1sKjry4QS53YejkWQw7H5jojyA+tjf9
	COdXJXJ29WbYeggrluPHr620she1kx/sRmEquPrqkXKMCZofa0LXwJeB5GNF3VYoIOiXZIgdoVD
	plw5o1q5hEsEV/yibE2PHsIXrQjXo/sPNYKbRj+mP/lB5q9WKs4P5OSt2AkpyqEIA+VhLAhr6tJ
	flJPJv5znpTfSJfJVoAAMMkW6Yzxsn+fyEzOrMli5O+KhqjSwvagCZ93fl8APZTuw+NuCXcMZgf
	anyLUqBMQfe5XVmLuTG7Lo6Zo2bxmrBidmRNxV/KrhXade7brKixsd5L259hhI1H2sYvY0U6kqR
	DMuNZMRAETAvbumX2A6+8/9wxIeaI2kw82kM0mTCCOMKbHQb31uaF6FWa1OsSVP4HiprBCXulcn
	hajH0CNvOMakKIt2yRMasBF5p22czPKIH2ov07+1LL4g==
X-Received: by 2002:a05:7022:286:20b0:14f:8d59:edcc with SMTP id a92af1059eb24-1b5030d4057mr11251768c88.12.1794862432024;
        Mon, 16 Nov 2026 12:53:52 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b524049e0asm15293497c88.4.2026.11.16.12.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 12:53:51 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Stephen Boyd <swboyd@chromium.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH 4/6] iio: proximity: sx9360: fix hardware gain encoding
Date: Tue, 17 Nov 2026 02:23:12 +0530
Message-ID: <20261116205320.26070-5-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116205320.26070-1-kapoorarnav43@gmail.com>
References: <20261116205320.26070-1-kapoorarnav43@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sx9360 PROX_CTRL0 gain handling was copied from the original sx9324
driver and has the same bug that commit 108e4d4de2b5
("iio:proximity:sx9324: Fix hardware gain read/write") fixed there:

  - The gain field holds ilog2(<gain>) + 1, with 0 reserved, so a gain
    of 1 is 0x1 and a gain of 8 is 0x4. read_gain() and write_gain()
    use ilog2(<gain>) instead, so every gain is off by one: writing 1
    programs the reserved code 0 and writing 8 programs a gain of 4.
  - SX9360_REG_PROX_CTRL0_GAIN_1 is 0x80, which sets the reserved bit 7
    and leaves the gain field at the reserved code 0, instead of
    0x1 << 3.

Semtech's own SX9360 driver (shipped in Samsung Galaxy kernels) decodes
the field the same way, codes 1..4 as x1..x8 and 0, 5..7 as reserved,
and programs 0x09 (gain x1, bit 7 clear) into both PROX_CTRL0
registers.

Use the same encoding as sx9324: add one when writing, subtract one
when reading, return -EINVAL for the reserved codes on read, and build
the default with FIELD_PREP_CONST(). SX9360_REG_PROX_CTRL0_GAIN_8 used
by the range check in write_gain() becomes 0x4 accordingly.

Fixes: 1cdb4c47f7f5 ("iio:proximity:sx9360: Add sx9360 support")
Link: https://github.com/TeamWin/android_kernel_samsung_d2q/blob/master/drivers/sensors/sx9360.c
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/iio/proximity/sx9360.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/proximity/sx9360.c b/drivers/iio/proximity/sx9360.c
index d102e20d4084..9ba967a33c98 100644
--- a/drivers/iio/proximity/sx9360.c
+++ b/drivers/iio/proximity/sx9360.c
@@ -64,8 +64,9 @@
 #define SX9360_REG_PROX_CTRL0_PHR	0x40
 #define SX9360_REG_PROX_CTRL0_PHM	0x41
 #define SX9360_REG_PROX_CTRL0_GAIN_MASK	GENMASK(5, 3)
-#define SX9360_REG_PROX_CTRL0_GAIN_1		0x80
-#define SX9360_REG_PROX_CTRL0_GAIN_8		0x3
+#define SX9360_REG_PROX_CTRL0_GAIN_RSVD		0x0
+#define SX9360_REG_PROX_CTRL0_GAIN_1		0x1
+#define SX9360_REG_PROX_CTRL0_GAIN_8		0x4
 #define SX9360_REG_PROX_CTRL0_RAWFILT_MASK	GENMASK(2, 0)
 #define SX9360_REG_PROX_CTRL0_RAWFILT_1P50	0x01
 #define SX9360_REG_PROX_CTRL1		0x42
@@ -289,7 +290,12 @@ static int sx9360_read_gain(struct sx_common_data *data,
 	if (ret)
 		return ret;
 
-	*val = 1 << FIELD_GET(SX9360_REG_PROX_CTRL0_GAIN_MASK, regval);
+	regval = FIELD_GET(SX9360_REG_PROX_CTRL0_GAIN_MASK, regval);
+	if (regval == SX9360_REG_PROX_CTRL0_GAIN_RSVD ||
+	    regval > SX9360_REG_PROX_CTRL0_GAIN_8)
+		return -EINVAL;
+
+	*val = BIT(regval - 1);
 
 	return IIO_VAL_INT;
 }
@@ -612,7 +618,7 @@ static int sx9360_write_gain(struct sx_common_data *data,
 	if (val <= 0)
 		return -ERANGE;
 
-	gain = ilog2(val);
+	gain = ilog2(val) + 1;
 	if (gain > SX9360_REG_PROX_CTRL0_GAIN_8)
 		return -ERANGE;
 
@@ -663,9 +669,11 @@ static const struct sx_common_reg_default sx9360_default_regs[] = {
 	{ SX9360_REG_AFE_PARAM1_PHM, SX9360_REG_AFE_PARAM1_AGAIN_PHM_6PF |
 		SX9360_REG_AFE_PARAM1_FREQ_83_33HZ, "afe_param1_phm" },
 
-	{ SX9360_REG_PROX_CTRL0_PHR, SX9360_REG_PROX_CTRL0_GAIN_1 |
+	{ SX9360_REG_PROX_CTRL0_PHR,
+		FIELD_PREP_CONST(SX9360_REG_PROX_CTRL0_GAIN_MASK, SX9360_REG_PROX_CTRL0_GAIN_1) |
 		SX9360_REG_PROX_CTRL0_RAWFILT_1P50, "prox_ctrl0_phr" },
-	{ SX9360_REG_PROX_CTRL0_PHM, SX9360_REG_PROX_CTRL0_GAIN_1 |
+	{ SX9360_REG_PROX_CTRL0_PHM,
+		FIELD_PREP_CONST(SX9360_REG_PROX_CTRL0_GAIN_MASK, SX9360_REG_PROX_CTRL0_GAIN_1) |
 		SX9360_REG_PROX_CTRL0_RAWFILT_1P50, "prox_ctrl0_phm" },
 	{ SX9360_REG_PROX_CTRL1, SX9360_REG_PROX_CTRL1_AVGNEG_THRESH_16K, "prox_ctrl1" },
 	{ SX9360_REG_PROX_CTRL2, SX9360_REG_PROX_CTRL2_AVGDEB_2SAMPLES |
-- 
2.53.0

