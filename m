Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E20369982
	for <linux-iio@vger.kernel.org>; Tue, 24 Feb 2026 14:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771942318; cv=none; b=fKF16GRGwz5tZ+SVywQY6rd4CVmutJAE0rxiBvN7SQyl19TuZg1IJFJZzraNF30YdMcRefjh5QACFmPB2aiEKet4L3AjVxyqJlBGiofLD1WMYJ4+QO8/GbXHkzTo7N122PXbsy0irTfhEvi1jukxvubTesMmcPmApiZOWhqaE3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771942318; c=relaxed/simple;
	bh=gPeMlKlkLhLPFXTVdb0PzZxfcOOAKUq6PTjWhHjPnPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZI6aqL/BeHOnD0qh7rzDXLZKsrgfIlxa6gZQJ+Wwr3rbgzQ6sDvZSlizvuE2qrIoxghBqdYoqY+vgRX0DyAPTrmGOFPa7JN2iui/1ftNn8i+Lh1MMTuPHW2/Z/bKHZFy2hCPPRqH8TdjszDFFL9B+vmaq6GbJKPwulis/mUWMPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=af52YdOb; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="af52YdOb"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4806f3fc50bso63107175e9.0
        for <linux-iio@vger.kernel.org>; Tue, 24 Feb 2026 06:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771942314; x=1772547114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VfxmIint1teZNykjZC485zz7ZETg4m7E2VcZKNSipf0=;
        b=af52YdObxAquorgUVHwP7qYoeukxysZr01QgE2LzUS2s3KX23Fvyux4SJzpHq+5tXq
         ZknqVbAwSbPnCq4yom5rhRFjg+f0BY2yQy25bcZF9R17+0FfrEuMJVxZkUcSaQzxoKLw
         AAA/t5RnolP/PPzRm0ON1YhBM6SKeuWm4aZHX1ntWtatBGhFgEWir+ak4QbTaqjOCBZk
         sG2sJFYJflqgeYq9ufgc6tXvyZK8li+xYM6QRWMqtTA97srhSoSd8l9W8Aswzt/guKY3
         3riDKlWSiH3PbsvDf0qkqrnbE717uZkEecuujbDoA1nmNFjVsNO2S3YH2uLKWv3YKpoq
         uSiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771942314; x=1772547114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VfxmIint1teZNykjZC485zz7ZETg4m7E2VcZKNSipf0=;
        b=byctmJUNBKiIhObrKK3eftogsi/dfC385zt3uhKRpK0mkxBmudsmdkHqVx8LRgYydl
         2FuIAux2BgzCqdfBFJFheu1Q/WPtCOvv8FTFDwBVbKX5ryv3PQiP4LyTLxrQm1SaYx94
         503CGbXENIPYjhs6BViuL97sMYbKpxTgd63+Nv5s6Abz/X0T1WM7MKvOvSb9azEfFdpY
         149ybkKAPGABBD2U0fj/DWdYeCG6HDpylvUG14EZ1EMObMq8rwd6ZgChbLVIyn9npK7v
         4Gwt84U01QCTvRw1zP2GDTLYp0lmnatRQ3YuWLDbbohfsqHr1UrqD+crMEi3rzCrovZl
         erKg==
X-Forwarded-Encrypted: i=1; AJvYcCXJrCa2VbkNkXXI2g9iBrYe7Cx9hqqbb0aftXUNnYHGU7inAKjFGZpMm42DIPAFu5+2XmPdFLyliB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAy5kIoQ9mXI3kRqIOZKCDqqKrvkejGa+8Xpf99/1QUlkPxwUS
	r2cF4Wmr3ylObQbwbcn3VCfx1Jp6oIYOcsN+f4F7cu586L6kR53byRt/
X-Gm-Gg: AZuq6aLqBTUw0hg1Vn1ad+s3Mv29NlxHBaqQb1KPDSvUivT93G4tEsuwwe4PTBQIOgs
	boy7wAfeK82uqmD6JGU7oE17pFf0606yIR/dPKn6DppSXQeq2q2UvYjqYZfmZu3oa5jV4ejiQGD
	diGfzMlkQYL6gGfMuaCfcXfWPlux+7Zshwp5cQS8ol4vr1TOBJO6ZbY3R+p9EtMcgNRighHaT3I
	3wRTiqu4KMSqOGMwGu3zt+p0sJXUTFEdzePBWV5ESCiT4qnRM8TO/LvT/BXZ0pVIrTkoW8628Gp
	Q/5UN4xDrhkWXZu/p11nTzQ88hCE45HyyYngL+5IeWetykla3XoTZrShw82392kgyr+fKDqrdfo
	Zh9KQLt6HKEOXeZcR7OQ04vPmXfA/bShtdHmv4gGG4m9xctXZDvLEu5cVtZTvhUmTn0Jiyw42KT
	jAFk3MbP4zaKJJrszsTaLwxrADk+voeeI=
X-Received: by 2002:a05:600c:1404:b0:483:ad56:8d16 with SMTP id 5b1f17b1804b1-483ad568e4emr116586305e9.6.1771942314223;
        Tue, 24 Feb 2026 06:11:54 -0800 (PST)
Received: from arch.localdomain ([2409:8a28:a53:6b71::1004])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43987f3ed03sm5456698f8f.16.2026.02.24.06.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 06:11:53 -0800 (PST)
From: Jun Yan <jerrysteve1101@gmail.com>
To: jic23@kernel.org
Cc: conor@kernel.org,
	devicetree@vger.kernel.org,
	hns@goldelico.com,
	jerrysteve1101@gmail.com,
	linusw@kernel.org,
	linux-iio@vger.kernel.org,
	stephan@gerhold.net
Subject: Re: [PATCH v4 0/3]  iio: add support for Bosch BMX055 IMU
Date: Tue, 24 Feb 2026 22:11:42 +0800
Message-ID: <20260224141142.225317-1-jerrysteve1101@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260207151207.0df7493d@jic23-huawei>
References: <20260207151207.0df7493d@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> On Thu, 5 Feb 2026 18:39:18 +0000
> Conor Dooley <conor@kernel.org> wrote:
> 
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > pw-bot: not-applicable
> 
> Applied to the testing branch of iio.git
> 
This patch series commit was not found in the testing branch.

could it have been missed?

Best regards,

Jun Yan
> 
> Thanks,
> 
> Jonathan

