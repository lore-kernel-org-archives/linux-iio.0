Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D5D3ACF05
	for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 11:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781609135; cv=none; b=rBNOxHQzUqGogx+DQkaspRTwoCA8G5b4FM/B0dqDd9KXYqOaBY8CdOnkSS9gcrhuq3S2kud6wr0SWB7COOTHRwu06m8Z5nif0dvoPC/jHyVS4fZlrfgxz5iC60HaCbISrpKI5KwDlKWHw5S1propB++qGyM3FzgrVPHcY4/nQyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781609135; c=relaxed/simple;
	bh=ECMwHKtAiyNXfUrFF+LYm4sx9prpztojl119lYHCGNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qjNqu0/eczp0K82F8n5AcAT3rO5S+owhLZWQ0w+bKLd3g4kIJwtVc3sHUOpGLAFtvRKYwq90tvmWGHSkBJHcsNQvGzCQmgocCI5kqXHGoJzkmpU9VhxbVtlWMio4hdERf+Zu3ak2+NQXNXhkTfNHOi3vnSEznjUJM7LrqqNGM9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxdN+kj8; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxdN+kj8"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-36bcf3d2565so3147203a91.3
        for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 04:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781609133; x=1782213933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z2yz8714NsuBQvwVd42mQ2uSLMv+5B9q5jhqtgjgTt8=;
        b=cxdN+kj8ImO8nKZ+ca64mgOmpYAL5ZoBcHOoOoVN4axWXzGzut1lLfs+acaCl5JAxe
         3iG9dGWa9w+Ecp15jB1jI092tSnVMmWX18Nj+RUsblgqWqQpg6asW2sKlFb1wFj1j+95
         DR+H4dfYZ279w+2VLsxsVs2YV9krK/EH8ECZ+BQE9LYyigAxhgkCHqtL5UiuySOkDWyM
         DSlaz/E0GhlA2/o9o+Dwj5ismBeoAhgKVjg7UFnZhM2+eZjoxoq4Qewv8mgJZ0Kcuj+d
         0QFABMPdZzvrf4/tWJJsiOXKA6Gde5wfRUsojc9K6Av884CGfpOmiaqZMZAbhS11JbyC
         B6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781609133; x=1782213933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z2yz8714NsuBQvwVd42mQ2uSLMv+5B9q5jhqtgjgTt8=;
        b=VlgB+Zmg8fL9jNhbUEPNhU0dVgIwDyybiC31t0fjz5NLKo3enzNESSo2izecLhyMDa
         ilen18MPy+38KcvaP4Kso5/LPrwVWJkzEaQ+jCVIok8reUUBFvhZlMSIlK5dmwy5j5zZ
         5M4K9dTqGZ0fA+BCg1YmjTW6RrnZv50+wyf8Drlvu5J5JMfolw8mSavfrHHE3VWV606r
         Fjl7m5qA+W4qVEToyLfv+tQMAkkhzp4QW9lwXiRzCsPQZA9btoJN0zv7i89QUEUCzGq7
         JvNYHj9pj1k4Iu9r17xDiLrgMg+DEDBQUO1JisOeJCv0yWPvJ9AD6KTdJQC2bksDkfc7
         XcdQ==
X-Forwarded-Encrypted: i=1; AFNElJ+9NSoEic5O1SVplnz9XlI0Z0IrIGxufD+nwuMaXanJK4lMdRVHH7/37zfR80kbu7nkdyo53i+Ee/0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxofywoc3TCGBSNEfu2v3o8rX+CcbfK+2wk9Zfgs89oxv116Vrp
	iOgyOeY6C2uTNeyV2Vl/dZ3XUwMA3qY2aqG4i9PxbjuNpBY/+icDNHHs
X-Gm-Gg: Acq92OGe4vU0l6YAZpo8zJd1u4BoFbU5n8ld9i9NerzH2LaeJUxqGCxGxOsdj8EoKc3
	cw0dU16Ozix5o07m8+aLYMR94TZQRc47Wl+FhLj1lQm5ilw/Gx793PzHWQkZ2ci+Kx6rxrGVIzd
	Z60xSIzV5xTBP4B9ngNVKiszav/1vo5y5OMnAIClEikltaSpQXQbHHujeRhNjGCmPURqWxZgWWY
	P+bEDP0OWsZCNDXA96OfFs2xd5SAJQAqutrO3qnU60YGKy5HcUr8RE8PLUJxX2Jag2fIKm0Y44b
	wTUBL2AgnEWi1bV7rq1ueU0jigi091NVBHFQg38EW/TlwahGb7b6H+gw0s//gdVso5c5rDJg85+
	JnXJU2846ZY/om12a+RsyDJRM2XmXTOgRJ5juxeRSy9/t5osUED5zDM9HqrvylKU3m5IKB/E6Wm
	emyjDunDHwT7a9eiOCgf3iv72ccKK8l1lXEl0jTF3sIHB3
X-Received: by 2002:a17:90b:2d4b:b0:368:ed26:15b2 with SMTP id 98e67ed59e1d1-37c2bc65207mr14848486a91.8.1781609133304;
        Tue, 16 Jun 2026 04:25:33 -0700 (PDT)
Received: from yash-Bravo-15-B5DD.local ([14.99.167.142])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c866519f0a6sm11137535a12.22.2026.06.16.04.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 04:25:32 -0700 (PDT)
From: Yash Suthar <yashsuthar983@gmail.com>
To: andriy.shevchenko@intel.com
Cc: Achim.Gratz@stromeko.de,
	andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nuno.sa@analog.com,
	sakari.ailus@linux.intel.com,
	salah.triki@gmail.com,
	yashsuthar983@gmail.com
Subject: Re: [PATCH] iio: pressure: bmp280: return on runtime PM resume failure
Date: Tue, 16 Jun 2026 16:55:25 +0530
Message-ID: <20260616112525.12497-1-yashsuthar983@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ajEkPFyOJAI_TO-5@ashevche-desk.local>
References: <ajEkPFyOJAI_TO-5@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for the review.

> No, here must be a blank line. And so on...

> Also possible
>
> 	ret = data->chip_info->set_mode(data, BMP280_NORMAL);
> 	if (ret)
> 		pm_runtime_put_autosuspend(data->dev);
>
> 	return ret;

Agreed, will ship in v2.

> Why this change?

Fair, there is nothing to propagate, will drop that change in v2.
The intent is to use pm_runtime_resume_and_get() instead of
pm_runtime_get_sync().

Sincerly,
Yash Suthar
