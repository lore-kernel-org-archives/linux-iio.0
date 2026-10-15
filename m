Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C4D4E8E19
	for <linux-iio@vger.kernel.org>; Thu, 15 Oct 2026 09:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792055286; cv=none; b=pQX4UzIL0RmR4MnzCGW+Cug3X25FacZkqFycmhgyPGakdYEdaEJ8FwZ+b+7Ka4RklPvq7MuOgNy4Q+BNpweiWxJztuka9pftFinM3QSqTvX7ya9NOCJwQjH3Bbi+/MSXCpYokQQwZQP11y2NDlf5HWCnhnAffcyti2zaF2UoMCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792055286; c=relaxed/simple;
	bh=UmmPnWITwwuejqvLNFKB87tCxE8Nz/bViqOo4tLzpFc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ensj9v02PrzHEnyGCcGj754gpqTQIKt2W14qAeTSLUC+0nAqxZUYshSsGaNe0DcX3gxnQaWn5E/0FH+eH4Ko6eWdvZgeGvaPIwzJ/uiUfv/cjjDAoRj2kwC4zdxl9QBbG9xk/XafDh+VrFAG2SbFoU7VVt0UYj1Tr1xysy4Q3X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pK4ofho4; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pK4ofho4"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a16c1608faso65452445e9.0
        for <linux-iio@vger.kernel.org>; Thu, 15 Oct 2026 02:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792055282; x=1792660082; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dWuTpLIpZhuW1BW/fT7Wvm1TL1EsBWcKdEk29mnqjRw=;
        b=pK4ofho46P4msiRi/9IXCc+n/FoTtM8TupKGpNUsJRhOc/Y4ApHZJZqewVyOeN+m70
         z8bTsxCsrygkDMKS3UY9LTdxI1CgTfY0yu6ytUcQ3XXMVVvex0CjGYCEGZ6mjptryW8t
         aJznWkifTpiS/OV68duMk/AeYLOw25+woyyhE+lr6jHr6yP3gRLc+O5QXUmkBTUctwHi
         nhUmG0uGI0mxWjeOgMlW9G1OKpvKBwvNbFG2v1pJ/wFBYd7XMhqMP9K2GvOgb4md/xwJ
         KdsFsXTRD6n2BsDv9X88eJoHUKvMdmLJ9cosKZza+ovfaRuUIAREyMTRnaC68i4oGowR
         hT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792055282; x=1792660082;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dWuTpLIpZhuW1BW/fT7Wvm1TL1EsBWcKdEk29mnqjRw=;
        b=gxeEl6Aq1RGEFsNUDwy5wHFJacyco4uwln8bV8IWolqoUri/GnKIdiY8fbpPT+BT2h
         FlhiKpNNlIuwJKAMkCpex8BJGhToeGCcoo56nATh7PaZHLAtd1vylBuWUoneNd8fOWHT
         ZO2GFNO0fJ3RSd6I9m4s4obQH9LpN1IIa6VCVBgrpZc4Ewfnuc0dSKtaXC7dWEzsf8fZ
         3YXaE6s3EN3FGuuk2mB9kgnCQOQI6BAxofygwmO2p5RvpxzP/gi8Iuxr/ehc8o83UU7m
         GAZ0xW8JtQQG8CPDJuF0ipn4pVLZbLDuCSap8No17tMTg8hIlVMe9by4jh0ITGUdrJh5
         +28g==
X-Forwarded-Encrypted: i=1; AKwUvBzmkY4AeF1ImI5NWOJJJ5PFYYj0y3+tS0cBOhNbquQnebNU0WVz6jxTi+v8tW72dDL+UH316gbmvWI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKtLUiS+RrwnBG3tB9D38+7LThAVPMdkNfTVEYn3tQFAdUZPWXl
	+Cr5JH9Wvn6fQ+OHJMQGepsd6uDhJtU//ZUw1vXkzY/I//R7bKlPfcui
X-Gm-Gg: AYBFou3c3HAvaAoyE0ZPxHpMH6G3lYRQsxfoH38uoD73GVbXuqqyWXJEBdSLOQXjI3v
	BKfq3hlwIt2pUEfT2/oQoqo/M6RLmGaVhTTBaU5XlkKz/UkbdixwjC6g2yQxsiS7d+uCem0YzQY
	kwPV57/Q0lxGPBxXNSwVFmojYleRANzEuZVclYl7YSeAkrhVKCwvoa8JKV5esVt3yHYucNsdUvr
	4FkDm87bH7cl4Qw0imL6hkTrWHhPIYEB7dIx+gGUB/5QB05j63ms63NHh1twGnZ3Jt2161bYV0p
	bNi0Ym9j7I+Ea4aSNmMrJp8IF22dIkv7UVa6OcBw0SGPHvcz05KUojoZ6hqOmRaAm0q8L7T9Nz/
	kaElptXAhoGhQCsQcTl+upoN9kOCTNzWyqxcVPJ98yEmRdLxABicg2Duymhk1tprgFZSTUishb/
	u7fXu8rxUTM45bFSke1wJloGXeDuRPcYH7nZk+FbbRLYtukbevcOusiFeP4fJHKDULB6dzElP+5
	38BXzS2w6lcmoZmpXO3tMHQ6Hx2IrzTAtBPuRK3KsJflSuu7HjghIPUWTctCZRZ/u95z7/O64qo
	XhJDHVPdiAU9EeQXw/XNjyhFyWA1eqZAqwuLDq85l9uW1NjULpfTMl5h7acb387Mir5t4kHgcrC
	CcZ0RUa0k/+yYcNWh1MABUz1ZbFi5KCPRkMi2F+/PVBfYuDxJjhim14Ju1qbOVjDBuXNhHvMVq+
	pe5jM2iw==
X-Received: by 2002:a05:600c:16ca:b0:4a1:877b:d4e0 with SMTP id 5b1f17b1804b1-4a18dcc911fmr255389955e9.12.1792055281754;
        Thu, 15 Oct 2026 02:08:01 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0ac52d3sm17292841f8f.43.2026.10.15.02.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 02:08:01 -0700 (PDT)
Date: Thu, 15 Oct 2026 11:07:58 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Viral Patel <viral8854@gmail.com>
Cc: Dixit Parmar <dixitparmar19@gmail.com>, Jonathan Cameron
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: magnetometer: tlv493d: fix magnetic field scale
Message-ID: <20261015110758.00002539@gmail.com>
In-Reply-To: <20261014-tlv493d-scale-fix-v1-1-69a722176c06@gmail.com>
References: <20261014-tlv493d-scale-fix-v1-1-69a722176c06@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Oct 2026 23:07:36 +0530
Viral Patel <viral8854@gmail.com> wrote:

> The TLV493D-A1B6 datasheet specifies a magnetic resolution of
> 98 uT/LSB (0.098 mT/LSB). IIO reports magnetic field in Gauss
> (1 mT = 10 G), so the scale should be 0.98 G/LSB.
> 
> The driver currently reports 98/1000 = 0.098 G/LSB, which
> under-reports the magnetic field by a factor of 10. The comment
> also gives the resolution as 0.0098 mT (9.8 uT), mixing up units.
> 
> Correct the scale value and the comment.
> 
> Fixes: 106511d280c7 ("iio: magnetometer: add support for Infineon TLV493D 3D Magentic sensor")
> Signed-off-by: Viral Patel <viral8854@gmail.com>
> ---

Good find.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
