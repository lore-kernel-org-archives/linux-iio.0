Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D340E37DAB3
	for <linux-iio@vger.kernel.org>; Thu,  3 Sep 2026 04:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788411260; cv=none; b=iXEpvyu00qWCFeEE4OT4Hc/B3+/QQyoDPZEfZtdWxGhg+c5zUCkbK+vekymD/AwRWV6ZJqFN0NLTc7D3W012lqNCMi/whe1GwjJrwcurYSw3JO1bLrLkt9P+B5SFJ2vUiEKPCjClRoVnyZHm2OMgMBoW6SzeAACNYuohGmKp3rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788411260; c=relaxed/simple;
	bh=JJUn9eSW6iCzsykKhT5PAveJpLlBYOP7vUZqlNZQIOw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sG4nznDxPlJWSoQf7H1WR7vHCOv9GCT5MMNBtl6ENVsPEmvFn9F1Pp9InEhKAQf8StM0CuJtUZ4b629D2XEoZKvPkHTn9e2qftntt3HSzWAPB2fgA3Ck0836bdT9paJu3kFLJbmv0sf+s+mvshecWhe1pRBLv1X2nYrZI+nCnlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ly8WPjam; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ly8WPjam"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-395cf2535acso665870a91.1
        for <linux-iio@vger.kernel.org>; Wed, 02 Sep 2026 21:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788411258; x=1789016058; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZqB8DCFwpgRgLRXMAdMRzB8MMQwfmI8qgccWP71X6U4=;
        b=ly8WPjameQbO9OcnfZROAzyUh460e1HmrqM6afXpx5teXp0GmZN8Cuuk5u8qraFy4f
         1WZykdgTqVD37cC8yuq4+46y20CqbFmF47KUSGjyUYcyuaRmJOQ35SFTFr50I52Q4Lc8
         IpMZm4mubputu+stFVcNE6EkT8GKpqb5SE2fLjRPOwBRmSiCrsa1xtdY8mCWYmZ1kTbu
         20RtetdoomJgcFBfZZM4mjEhfGR+mMmavvVYBtTEQSbkwxEZ6XZSbkC23SYm0sHyhFvc
         isNe9souf3PQlHnADT7QzUMPoivkzbwkQ9bynCvGRZZPOPE/02oQAfzKFkg6N9iCKenw
         0uXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788411258; x=1789016058;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZqB8DCFwpgRgLRXMAdMRzB8MMQwfmI8qgccWP71X6U4=;
        b=L4hPOcqG/JeGFn5ANlZ1tkuz+madAPrPASFHv1IUYJQKOaDMspbl9QUqmDjMRjeBH4
         su89E60W1iC4x2GsoFI3nsqrdw5yhg3okDeYanaHA4DWEVwJrkhzj6bGvOABgbZoXcCp
         wjrb9/bJ5XNMbrywTqibXBnT8srQuGNWqqUjod5414Ce2Gix0d58pXZHbmfRARTJ4ogR
         1kqQgixpI141wbnXWAFu8HKXEESdWDw59fOjFvY33qWn+n3Ax78bf+d6VU9oiRs1e/bh
         PWI5u5Jfi1LB35IB4hRoDIo8YyiR3RzoPpfsqgY3rtQCcBMmzfQ+AXnkGl1qD5yYqjEF
         NPoQ==
X-Gm-Message-State: AFuF++nXUkJLCdWDQsw5v3/Ql6lk4jYTLGLNGdK1xTK7cmTUQbu7CnXv
	gQE/uhMgfzw2Hg5N0oYrLTUEwcH8vG3BvbAM7dDrRtVyCMj1GI3UJlxG
X-Gm-Gg: AYBFou0koEJw1arMxBq2wHJ4C4IM7rYpo0vjDw2cfUn1DfNQJZzXWri8yEO3xcGE6lp
	mVfhZQ9g1PUw9z55UVadTkBgWWBZ9IGgfNIvwme7HdqNV5Tu447h14vnUSIgskrUpwGXUTVf7vb
	PZ7Dzb+iD+jIFHobBi4fXuEKjhWjjlkmb9CvlhieQ6P2zC7043RAQG4b3yV0MFsAu18RSvXj+Ag
	XY95yHLKlm6HhZwkmwnehaZLTW/dt3hKUKfCaivvH0kLfKaodLxzMkw6p5f0hN3eWQEEBUONkvR
	kAAp28E+mohS1IldiRHD4cJGjhtLEcvjUmaA5dfhULgGdf/88i6SilK/Ptf0AcV13b6HQPqSfyW
	T+lcgbj+c2T+jXsZMwOt/xB3ieQZ+wTUuFeNza7wmtszzEFuMp58DCO9t+l7VNtXeYILFuRCaSR
	q0mYsJo8QrOK3J2czKfwyH//wLDWDSWYpF9RGZuwPt0V/syHUqxk2HUHGiBNQGWWgW/w==
X-Received: by 2002:a17:90b:2c87:b0:398:ceef:edde with SMTP id 98e67ed59e1d1-39b133026e6mr1194339a91.15.1788411258243;
        Wed, 02 Sep 2026 21:54:18 -0700 (PDT)
Received: from [192.168.20.42] ([115.70.157.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae8f1cf6dsm2300801a91.3.2026.09.02.21.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 21:54:17 -0700 (PDT)
From: Tsz Shan Chan <tsz.chan.dev@gmail.com>
X-Google-Original-From: Tsz Shan Chan <tchan@jacques.com.au>
Date: Thu, 03 Sep 2026 14:53:46 +1000
Subject: [PATCH v3 1/5] iio: light: vcnl4000: use correct channel array
 size
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-vcnl4000-v3-1-5e69c2e715a8@jacques.com.au>
References: <20260903-vcnl4000-v3-0-5e69c2e715a8@jacques.com.au>
In-Reply-To: <20260903-vcnl4000-v3-0-5e69c2e715a8@jacques.com.au>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tsz Shan Chan <tchan@jacques.com.au>
X-Mailer: b4 0.14.3

vcnl4200_spec sets .channel to vcnl4040_channels but .num_channels uses
ARRAY_SIZE(vcnl4000_channels). Use ARRAY_SIZE(vcnl4040_channels) so
num_channels matches .channels.

Both arrays have the same size. No behaviour change.

Signed-off-by: Tsz Shan Chan <tchan@jacques.com.au>
---
 drivers/iio/light/vcnl4000.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 336468d59ea7..cf55fe6afcba 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -1864,7 +1864,7 @@ static const struct vcnl4000_chip_spec vcnl4200_spec = {
 	.measure_proximity = vcnl4200_measure_proximity,
 	.set_power_state = vcnl4200_set_power_state,
 	.channels = vcnl4040_channels,
-	.num_channels = ARRAY_SIZE(vcnl4000_channels),
+	.num_channels = ARRAY_SIZE(vcnl4040_channels),
 	.info = &vcnl4040_info,
 	.irq_thread = vcnl4040_irq_thread,
 	.int_reg = VCNL4200_INT_FLAGS,

-- 
2.55.0

