Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB54C3C2B80
	for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 08:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784103083; cv=none; b=crv0XIRxX4YHtQisGmc878F25u7PSWUx8U4AXn2hg9nXOPREjFFB+Ohn2WUdNuLMMm4tqcMQiLNBmYyxnoJGoZ4+WkGoSzBq/CE6VZZ9fM9XDs2r4JmFf41Wo3prXELbpPxjM/obiiMO/NtGPV6a7LS/QdRCoyDbRyXlcDZPz8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784103083; c=relaxed/simple;
	bh=v1VKY3EffdDvVnOSKjraOPTXXHHgByCtxpkOMDUhsmM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KRKbXgxrRPsijA5gHc2ffBCStwF/2mLzUxMjxSP4eXr90TiSKuvwi3dOSblIDZjKV/BnsZFnOeNE1z/Nbs7hX6YrbIjRQggwyE7DgqdevmKdtHE9DchCmICsZX5nOUWAT9bpCOCV4xv9gIVsI/ZEwZMjlqXh9Dr2nDk24CIOaRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jiz8S7qU; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jiz8S7qU"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493b1710405so27593115e9.2
        for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 01:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784103080; x=1784707880; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=g5vj+GIH7jbJ8BHVZT5sX3ucem46R0CpdI8IPEs9c7Q=;
        b=jiz8S7qUrtO4AJrSWoparVpATMjzM4DWHa4QuE4EjzD+6mGaZNX19u4ZfdZDlgj+Bb
         07wfMxZZOwaITAuk6On2tw07/ya8Su2H/pemNJ/xz4jZo02Uo01cYeD1/TqVlPZKMpf3
         oIO7mCQzbk82Ba60WtN1RIy/JMUSQT0ROYuruu3JHURphnDyv32f950dG82UUuYRyWTR
         HHOeC9/BxiR6OgwvMTTUF4Fkm0iORymaAhenuB9Ef7bQqDMshMo4ZSsoYwbmx8qX14/3
         D/b2I71D9pqaFNlujQYvDX1I3fcalXwQvpOehNoXNqh4nk8i5dsDJCInvyRFldbpZJ8I
         U1GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784103080; x=1784707880;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g5vj+GIH7jbJ8BHVZT5sX3ucem46R0CpdI8IPEs9c7Q=;
        b=qLtxL7WKIx/BS8AKxuqcrJJ4xRtlbo5L36RCMLByY9Rdi1OPboQjbTylzJe4A4asbl
         WKyq31OZxXFErGDlUSwkWcxbnx/fxEJ1DWlAvP8tigzWNjqnHJ5b3JRkv9tfAVIulHxI
         mbjIuG0kHqUYxmcuCnbXeMAFWLU4HfF62+uJTOzevC55akQAJgtXEttVtsRQzy1DMY0W
         cV12pHU5YGlalkigYMSr5/syJmR8hhksFD1QNpBHzXllXzf8GCNYI6+PTaDTVtPMMP3d
         t/RCFqVl2/Rrx62jUxUlC4b/uKkZOf4Blm8xP2U8ICBIAQ3HCF39vcraOAM0f0blu90t
         ML4A==
X-Forwarded-Encrypted: i=1; AHgh+RpQ228xpjCeEXZl/3qsO1E8U/Uy3t/Sdvw2RYAedJ35uTHUCew5pjM/L/QjiLP65V+2kQgL2IOcWco=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdmOSRFU+Jg+mDZ5t/PcjRb/1GQDIE1DDSkUFVVcOBnzbbPdVg
	uuNMVIZKaHDJlSLMn45XxwLxH36T2UmJaKEy/XONRtVQEUo5z4C/6kaM0jTCTQ==
X-Gm-Gg: AfdE7cn5K+vR32bVsOwVg3SVLVGp02l8fqltz1/6nI3cDJ6654+6FjMqxA+fuBHAjbN
	45jVAO+TTgow5O9xDW9+CYirYPi3rXfBjn11Rgtz+RRkUdtP/PbuoRpR2fXb2FzYViMQdEqQH/Y
	M6uJrHapfu2g+ympcQJubJ3Ut9eZ8VdQOZARIvu4aK4GRsw8pirc986XG7AsiZa4FGPjyLQD8fU
	z6bJsDzkpBAukYBvHqhy1BckukcK1eWcOpbm1Gi3WmBcsmPcQmxQzP2OOaw7U/dSbYfUH7BXhxx
	zLFPEtF0dz5XlA4LbxkwDpFIeRFWxRck9Owkq+m8NUA100mTC38riCpMugFgs2MBWrYeWP+uGIY
	Yc2G/Rmh1XZ5sV2UY1eP5Ez9d1aThc2AVDntn0sBdXxRvq4KMxAWGaqFXgOCypRTatKjCN1KWtR
	XTFPImzoupDYYGwZKuLQf44WfDNwO7a1gSo3gCrH63RriZP9Izi60asIQP2M6VFs4w4+RZqwwzo
	DbqFRYgbwCaTWpfoO1GW85mTBszNl0xbIPtZtnpdw5IfVBdNcu2Dk6xq9fKomnTjyv0hti21fe/
	ckj/nL8N1Rg237Ea0sfAxAOiEnMHlTSUUi80tGfF33dcMwocP/ZMmXVXJDFctCYv7JLhuIbH+ks
	rpZ9a+1hG/ivuDTyPY7e42xY=
X-Received: by 2002:a05:600c:8119:b0:493:f744:e7d5 with SMTP id 5b1f17b1804b1-49518324f47mr71637325e9.38.1784103079789;
        Wed, 15 Jul 2026 01:11:19 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4953c704bfasm37195675e9.2.2026.07.15.01.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 01:11:19 -0700 (PDT)
Date: Wed, 15 Jul 2026 10:11:19 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Can Peng <pengcan@kylinos.cn>
Cc: nuno.sa@analog.com, Michael.Hennerich@analog.com, jic23@kernel.org,
 dlechner@baylibre.com, andy@kernel.org, linux@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: dac: ad5446: fix OF module device table
Message-ID: <20260715101119.00001b6f@gmail.com>
In-Reply-To: <20260714091846.136278-1-pengcan@kylinos.cn>
References: <20260714091846.136278-1-pengcan@kylinos.cn>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Jul 2026 17:18:45 +0800
Can Peng <pengcan@kylinos.cn> wrote:

> The ad5446 I2C driver exports its OF match table with
> MODULE_DEVICE_TABLE(OF, ...).
> 
> The device table type is used by modpost when generating module aliases,
> and scripts/mod/file2alias.c matches the lowercase "of" type.  Using
> "OF" prevents the OF table from being recognized, so no OF module alias is
> generated for the I2C driver.
> 
> Use the lowercase "of" type so OF-based module autoloading works.
> 
> Fixes: 876d94024087 ("iio: dac: ad5446: Separate I2C/SPI into different drivers")
> Signed-off-by: Can Peng <pengcan@kylinos.cn>
> ---

This needs a Cc: stable tag, perhaps Jonathan can add it when applying.

FWIW,

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards

CJD
