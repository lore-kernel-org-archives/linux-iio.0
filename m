Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE2528C840
	for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 07:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781854294; cv=none; b=epDkTu4e/E6jDQtzGW0rOXYFXTt/3W0/ZwWECaQAtkSx6Oyh33NRqtIr/nU5L/ICmjRacVxMgri9xqxWL0H8/gOo3uCy6/48OsAW//rzC9ZWOQ4hClBgDSQERm5CRYgRUybL7nwyb/YfYE/4pJLb8zSlWZUPCoNQxic9ewmEd6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781854294; c=relaxed/simple;
	bh=YXyJiYzz4DqYrwejEWOZ65sUYcIqTnLtHo3wWMUsv3E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ore8Ie3hRe1T4iLnxT02nkbkIPp6bPQ8m9/UUnMRtnKoudvLbLyHRaHZpzdbt0EKDMrm2OFRVvLs6k8TVwfKFBqfc084RNH1s7PEGBOGdMlJ5nQRUWbL8wYsGtoHGLWUzZ7Dm8uCKeD7qTl9GOQYo8QBpYg6yH00J7iI+VYePrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jh+qrkTs; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jh+qrkTs"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-45f3cf907ceso906322f8f.2
        for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 00:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781854290; x=1782459090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hyg6BNi9mbPB4UC4lAnngTZ2/nQI2FdipIrBmsS7u6Q=;
        b=Jh+qrkTsRBYLg6GqlsFIxADbxeVcX86PJrI7ye0xC2gQdjT6cq+28gP4up69Ulbe4f
         YkC7TIjW9h6w8OZ/T9CeGO9G3wDRYRL2CKKwTpY+KdJ0xKv1WqI4vQf4iSjuvI6N1FfO
         PgGiF245abBBtEKjKP9Dlen8JEEJathZ9l+J2SR4knycsh50WSQ7GiZleY5XNOK9vSMM
         wv1pVRZWrpzkC9MS0f9K12hrbASiGWBAvsuP50g/hcUtbfNI28uFsz5WWl/nFkzt7+VN
         pgWJhoC6OTMzvNY49DASiCkVo7pRXdWjmuRMtdjIgAcB5zEVoBqBiHaepRXMiX3OliHZ
         vg+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781854290; x=1782459090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hyg6BNi9mbPB4UC4lAnngTZ2/nQI2FdipIrBmsS7u6Q=;
        b=V4heQi20QGxqjFgmzm6Jwpw4gpiBuPydIw7v5jd6OVZYroA25OP9bFxPWmI04yY5ae
         NNPdVsRnQH3l+JFJyW2dcYycR0Nf8PMd8EahRkaNxd53kV9lnyD/B3xZGbhqOwOkPafv
         vPSG1K96fJwlWhx5kn/9LysucxzBDZQH3xcB2c10Sb2PrmPHcP7ixbU2nQv/1w85YOod
         ZYYPLyNprx80sz9vDeTodfvfkkdl6sjeSH1NV3D+Bava3+7cIndjJ0TyyhoOKf0mAzSC
         qOUwxNBtRBJwABX0Wu514GMoeGHla26mwc5qYKtP1hK1sBieC4FIGKTVYY0LRva3Kkzl
         cUgg==
X-Forwarded-Encrypted: i=1; AFNElJ+llgcFzHMRRskH5gF06BkNNzW5YBRX+/J5LVAm+igVYK7Q9DfSvm3vaORGbEaYnpUbKklXQcCAemc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQnjKZ/woA8bm4DBdc5/4yuE5vZNrJrDt2KwmQiKnIiNI/KDKb
	pkTn8ez6DgLJ25I6hAQwgWdyR9KMGPtqru2qlBGbk5WHGIfHJhiCy5tu
X-Gm-Gg: AfdE7cmVrXlrK8Ws2IGovKbo1StO7avFkI2n1Imqe0NHKDeDrvKC8DfyPB6QT804Td6
	xqG5BwJ+pMX/HJWp4Lzx/FvxQvKHfxsT4BnF3QkGtpyCLAaASW1h5ZeqOsTcNe34LJAhqz3Fa0c
	GOc6M94Lfz0/vwbQfvWNVvXKtvEkW6mOqwK+7mhp/JmIO2j1Aw3cV6KbktIbuWkUgpxNMugjhV3
	OXXBOnFde1ucPH4xp2+/h9m6MHw1HCS5CusJzNr9NyQAs9fyKU0osj91ZaBwLlfmbwSmWbjoz8g
	hEpigZic61IiAKTIL7ENw2DMSjNiwE8pIayaaO6DR6Ru4TLtk9FL6SYrao+uNJkuVBLT3Y1mIVo
	Sc1rsdwc8ei0LMJa4lPxKIKtnhzy0HDbtqw3uEKvHifh0lY6a42c0Y9jV16WlmKJ88ocxkFV73g
	+/veCC0sqf7dTrpJLiKYL6qci7F4b6vTmQZEF2NyZHJr0iSXMeTIdqVUqqaNG/dpYdizvFce15B
	zI1KV9f7T3L3JNfl+XARaVmN/NNEUlQKcBQTCirsTFEu7s7l7DaewxTt7eMlqn206tnicK9FBkp
	qkNmGG9cMjjgneZYuvc8+qW/j+COacMwc1OTR5sbRoTh2yeNEQEbFZY=
X-Received: by 2002:a05:6000:2884:b0:465:81cb:bb20 with SMTP id ffacd0b85a97d-46581cbbe76mr1761403f8f.9.1781854290194;
        Fri, 19 Jun 2026 00:31:30 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46508a0546fsm5526505f8f.2.2026.06.19.00.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 00:31:29 -0700 (PDT)
Date: Fri, 19 Jun 2026 09:31:29 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Caio <caio.groff@usp.br>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: light: tsl2591: replace persist switch statements
 with lookup table
Message-ID: <20260619093129.00003800@gmail.com>
In-Reply-To: <20260617164258.9007-1-caio.groff@usp.br>
References: <20260617164258.9007-1-caio.groff@usp.br>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Jun 2026 13:42:58 -0300
Caio <caio.groff@usp.br> wrote:

> tsl2591_persist_cycle_to_lit() and tsl2591_persist_lit_to_cycle() are
> inverse mappings of the same 15-entry table, duplicating the same
> pairs across two switch statements. Replace both with a shared
> tsl2591_persist_table[] array and simple linear searches, eliminating
> the duplication.
> 
> Signed-off-by: Caio <caio.groff@usp.br>
> ---

Alongside David's comment, you're missing your full name in the
Signed-off-by tag.

-- 
Kind regards

CJD
