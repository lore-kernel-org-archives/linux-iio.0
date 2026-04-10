Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053D837C11E
	for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 10:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775815940; cv=none; b=Akd/5M8cBRT4IgoJ54bwfTWoRLvc6ZsZrrTscOMwR1RsRpy+zNLQ2tIGV23Gx3n4pk4mMi+GcZ9mglT87IZWAYFnIPwvWnxNR6BFXeXxW3pr/GTrmi1I9cfRY8XeW9YIneHIQ34LKsiDzhIV7UUhcW0t/V2Vd3WXyxWUBqSDie0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775815940; c=relaxed/simple;
	bh=H0fXTkWi3cEW1grzTO2UpwdTEZU5njLYXMU7g8OxhcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=N9bov8Pmzx8wb6aSPu1EUFKIh0RnCxTHEaF3CPWeOVEIcVaObZ77OJhqhvdyya95UOWWXSvfIcwQcKaKGYO4RSB7SF8rhIaDBm80UpoN2ASudmF8345IQ/nGQxYL+JHTKPxrzE5nCbyjLxN4gXxuwzMJylv5yQ0Mv7PQH6n/XJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGEwk05u; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGEwk05u"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4888375f735so18246625e9.3
        for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 03:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775815937; x=1776420737; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2joo26VZqK/l7L0t7ywj7SByOmdQBrAhyw+E9lx2JP0=;
        b=gGEwk05u65i7OyrFU09sm3cibL2EYJ3yVES5ZR4aCtwm+o5T5hvE1D/aFwqvuDvoto
         6x4+Q6rCSxgCNbNIxyyeON19h0981U1gOM7HMkqSpIANW9XKHNFLUgvsz1/mu/65+N6M
         SyiIjbVLPi2FJyfxp7M5tv5qnLXcQHvCiIFCdrIUcmM1+v+l1QsobnglzCazgoUqIRZ5
         sPm6/x5vQ/wFZB/ub8OAPxIm9D262LqIplHmSIw2bMLDfAYzx+Eah9zAcRFGh1JU68xi
         Dpr4GiuPbeSYD+S5S5MKr+OvZN0mdqIl2qC+sAbeBJdf2MAtLx5P/QI05FylJN6Z1xcw
         AxnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775815937; x=1776420737;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2joo26VZqK/l7L0t7ywj7SByOmdQBrAhyw+E9lx2JP0=;
        b=ku2isFu5ARsjs6xiCbKiW3vhwtGeqPu+gZmp7FlqR6L8C5B8j8v9xK1v50wcf/NfsL
         rUZZJgqcSWtf8gSkuzw+pHpKKaaeV13nQkvkDGExdAk6K4K/BT7KxvvXmV13cdsRj1PA
         /I9aVOAye8pS6N5TBhtS9y4UvIrJbrTPkQdoiVa858pxR2Mm4IdJeY/uPM3uw+nrwO4A
         SBF6qwcgBC6+5NQrcWOp6TmsGsMxVT7p9iCWMh0yOtdxWD3y62X5ADjr2OGhQoQORvnd
         FbIfnKAg6uXRdHLqOZe204TJ2YThkFgzxVqg4nLxpYQwVBa5yUD21NOqHbC0TP0YJ2eO
         OFpw==
X-Forwarded-Encrypted: i=1; AJvYcCVcMhbGdcc31m/RYj9W1fTDIpY9JK9ZncCaXokPWEYoqQ/uPXFUhRZ6/7601odoM2Nj/CDAVq9Pk1k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/HlI0Ac5yLWD+ppw0uliluZ3Zo/2bzI3lqQNcK3k254Zg5T+W
	3IgqbKScISpWen9Xm3ugU4NEunBF8bdTCSb+SH777noGqT/zS1ccixyt
X-Gm-Gg: AeBDietfA0l1rtcgy8XrIU0sPTZuGtDkwviXezhAv1VLPbSaotm4rzKYrYy06bTN2Os
	UBGUCNpe/PwUi/eSHi7/kWCF2qaDiIvsvCoSHDetY2v0YJRBd6aMIul6fBM3VSas+RY71EptJBT
	3Bdm5xgTzJv8HjWL6UqJGzSOcTqfC6H3EbZtrCFF51XMMTzIpZ1yWaKuh4pS+FpctU6s/AA1vXA
	FoUzkjoi+gqKlgt5KOKhnroVjAvCvcBBzkjLx0hb2Id+fmW4g8yjI3D7xxrvZiT/LHpuUCSa2OS
	LMR34AXwvRXlID/fNsWBo5GhQ9c1N9fE+WzJXx014fWDmOXHAU5QV3myN2rZeGb2AmLAw10kmmV
	dQjbk/HIlnv1+cjjdspya165aaMZYuuv/curU86l8GypLKmjQ8hxxIoAxTMiN4eoSCSGjKBaoib
	FEZ8NEHNYYx/KqnctnR9g=
X-Received: by 2002:a05:600c:a109:b0:488:b239:77ec with SMTP id 5b1f17b1804b1-488d683d510mr22075085e9.17.1775815937325;
        Fri, 10 Apr 2026 03:12:17 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5b3cbb2sm63943005e9.13.2026.04.10.03.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 03:12:16 -0700 (PDT)
Date: Fri, 10 Apr 2026 13:12:13 +0300
From: Dan Carpenter <error27@gmail.com>
To: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Dan Carpenter <error27@gmail.com>, linux-arm-msm@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] iio: adc: qcom-spmi-adc5-gen3: Fix off by one in
 adc5_gen3_get_fw_channel_data()
Message-ID: <adjM_ZXs9IoIYjyN@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The > in "if (chan > ADC5_MAX_CHANNEL)" should be >= to prevent an out
of bound read of the adc->data->adc_chans[] array.

Fixes: baff45179e90 ("iio: adc: Add support for QCOM PMIC5 Gen3 ADC")
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
This email is a free service from the Smatch-CI project [smatch.sf.net].

 drivers/iio/adc/qcom-spmi-adc5-gen3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/qcom-spmi-adc5-gen3.c b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
index f8168a14b907..48c793b18d11 100644
--- a/drivers/iio/adc/qcom-spmi-adc5-gen3.c
+++ b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
@@ -482,7 +482,7 @@ static int adc5_gen3_get_fw_channel_data(struct adc5_chip *adc,
 	sid = FIELD_GET(ADC5_GEN3_VIRTUAL_SID_MASK, chan);
 	chan = FIELD_GET(ADC5_GEN3_CHANNEL_MASK, chan);
 
-	if (chan > ADC5_MAX_CHANNEL)
+	if (chan >= ADC5_MAX_CHANNEL)
 		return dev_err_probe(dev, -EINVAL,
 				     "%s invalid channel number %d\n",
 				     name, chan);
-- 
2.53.0

