Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6550C394793
	for <linux-iio@vger.kernel.org>; Sun,  2 Aug 2026 10:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785666949; cv=none; b=A1XopkjgciREzxmgQ+piJs9p7nGTymgnuyUgR3XWuG/bm4ATnmdJ/5rye/AL/qvuc2R+mNLLqbH5Ebm9R0bzn9Y2kF5aIEh2VgDBrtnqnrvRmOUptzBhAU8zHQmQQ0wK2a2Iyi/sj9/5bUBs1a7GKoJeRnA8RqrcO3+iVhgRdcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785666949; c=relaxed/simple;
	bh=t35LtrHrvAj+5G4uXnmpwWQkMKS7VxycgcaRFW924P0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UUIdw7DZ+PYJfm7q+5JdcbIeIH3mT+nKCBOmVmI2RaTEFrRZw4hevNAqnoKGMI85ngDC0ZyUiOQtDlwSM7QEgSOEhbszrREG9cnwcCePDmTyTvWuJWFFkIKsnKRoIo6FYQpD5ZhvtybtsJLUAdsz6wa8k/jPW2L0jgJCB9ETjbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQ1FiCIe; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQ1FiCIe"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso2299870a91.3
        for <linux-iio@vger.kernel.org>; Sun, 02 Aug 2026 03:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785666948; x=1786271748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t35LtrHrvAj+5G4uXnmpwWQkMKS7VxycgcaRFW924P0=;
        b=jQ1FiCIeWtJn0QX/apwMRy8XCeTGpwvmbmTk5QrkTSjH1H2pf7t9ZHUPhSX59xqBz2
         GwkMyi3Lyjew3iqsHMJdCJuydZ9TjSl/DlrAgc82IYa54eIDoOLaTf2M2C9oejW5PtMx
         DA8YtFW/WgTENm12HGf86GRi03X9B3gzydTwO827jXOUZA64SdoyXNGFV8truAuIFl2U
         7V7RM2mcPkJZeWafksGGdLLv9tyTsSpdFee9DN2qH2utD/85E6ToLZzqb6PNys1UjdsX
         8kIBqpc1PDKaq/w94e6VKe2KffIA66rbf6rAM6M269shzZFmYqNlWgE9Bfd4nRRH1K1m
         hd7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785666948; x=1786271748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=t35LtrHrvAj+5G4uXnmpwWQkMKS7VxycgcaRFW924P0=;
        b=KuJf6N/IXkzq6nru5ZZ4CSPVUa+tj2XEDAr/Ek+8NyETUN0U0HF0DZe8FXEs9QNSSP
         nhOPehn2FF67IOzyIwnPCwSj2pPml/4472NzeUwYxh2BBLYpWyjBe2CSm8PcRumgx5Qb
         ZWv+x6bqMVS2PIrktUyAhFDa6/wA1JYcb2d8FgXWbVQ+DDt0h9mSU/65BP0znqKA3Pp1
         Ec7bRKbiutTw6bOHoRxcSpVbhVhhnbYLuxEfCiJUkgpH38i8/50MZysZpbxgbOMdFO/l
         zSOGqQPKGgOEwi9koRPhdb7hFIXKNg4Zfr/1MWrEgPBkzMVOFhFAIzNkLZWAlNyaXhAr
         lDGw==
X-Forwarded-Encrypted: i=1; AHgh+RrQqoL+VcxOPabLyyMOcXJHazSH2MDpbcepzXuLXm+ByCUSzl5DNNl6XcY8LAT3Xia0tD3uU0NI4/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR2L/4dMi1WZ3aAtm2smrZXrfFoOiMjaN2LjQnxOI5L12lrKSZ
	3b6X1J2aQkBZtFdek9uvdp/Wm5sXcTsrBjmt5tt4IlrOqcS7M1z6Wdts
X-Gm-Gg: AR+sD12dPljgPDnVEKQAxB4GUlJNW5tYbM40abwv55I6yv7pmL1cBvFeuHp9rUywU5O
	AeVLdhkCcEORZErcOgn+uwm+M6zWbXK52Un9mIKIT3stOHtnfKj2JdKZHHb1i42s2BVQ9x9qSgx
	x2r14+ywsSEazLrtXF3wVyZtkaIYAFdIDTB66J35F+f418kATlaU2SkgJ6IscCakXSKVscFfEN7
	E65hloNT2oyRuPxj4B2D6dRsAWXEQzmVbCM9ZZSdQcsVs+GIQfDrJPaom8/kcums1sxFmq31fsz
	HnklWM3o7OIS0N39hpokXh9UEAdBTRAy5EdygRvW1g10RjvjrBTZ0iOWo9XmYrPCdGBCboEgsFY
	ZoLL5VLp6rL4O7IaggQxmRSdwuWL1A3MhcVVlCvcZAzZ/vHg0NSH9Ez+MqIM+71729XmM1NFemr
	8QHKGL4dB78h7uBnU96fftKMHW+jRD22sKoUZivKp1BP744gUQgqSXVZQ5cfg=
X-Received: by 2002:a17:90b:3a43:b0:38e:679f:3b2a with SMTP id 98e67ed59e1d1-38fbc4dd615mr5362391a91.30.1785666947686;
        Sun, 02 Aug 2026 03:35:47 -0700 (PDT)
Received: from ubuntu.. ([2405:201:8026:213e:a836:ada0:6830:9b96])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab13255esm18687092c88.3.2026.08.02.03.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 03:35:47 -0700 (PDT)
From: mdshahid03@gmail.com
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Joshua Crofts <joshua.crofts@broadcom.com>,
	Broadcom internal kernel list <bcm-kernel-feedback-list@broadcom.com>,
	David Lechner <dlechner@baylibre.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Mohammad Shahid <mdshahid03@gmail.com>
Subject: Re: [PATCH v3 3/3] iio: adc: bcm_iproc_adc: Convert probe error handling to dev_err_probe()
Date: Sun,  2 Aug 2026 16:05:20 +0530
Message-ID: <20260802103520.114582-1-mdshahid03@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260802030433.696454fe@jic23-huawei>
References: <20260802030433.696454fe@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohammad Shahid <mdshahid03@gmail.com>

Hi Jonathan,

Thanks for the detailed review and suggestions.

I'll address the formatting comments in patch 3 and also reduce the
unnecessary churn in patch 2 as you suggested.

Regarding the suggestion to convert the probe cleanup to
devm_add_action_or_reset(), my intention was to keep this series focused
on the dev_err_probe() conversion and submit the devm-managed cleanup as
a separate follow-up series, since it is a larger refactoring.

Would that approach be acceptable, or would you prefer that the cleanup
be included in this series?

Thanks,
Shahid
