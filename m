Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDF93033DC
	for <linux-iio@vger.kernel.org>; Tue, 10 Mar 2026 14:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773153512; cv=none; b=NkPRtGvDAtOOIBCltdh2monBlCbUBaHbxBhazYA0yNXEvp2p0nefcQqndEFfEzD+okgqsbL0wlQuCKUnL1g4CS/4/b2YtuGrDFOeLaHQMwosTPg4ABJdvkFvu/dsQvdIUJ0AonC1QRj3BECP6fIFrhhVHt2tAalLQ4J0BlfnO4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773153512; c=relaxed/simple;
	bh=6l9nEKwrf31Xk/xID4nEKQRvrRWqlWHqJblZDh7N8fU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GZ7eXfSXepDrx7uM/HuvqR490PzR1JIMrQjKelcVCo1EcAA9OTWkRpXXjWH4pLOIf+Ncwrbt+ZzzNdGqyAgX30BWwxMAmCe/CYyHyxoSAsjl4+U+PDxeU0PH9HHzFImDljPL1+Is0dtry4RDO+BCGBc2iI8xeDPaDROStgeC3nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UrL6Iuc8; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UrL6Iuc8"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2ae3a2f6007so74605755ad.2
        for <linux-iio@vger.kernel.org>; Tue, 10 Mar 2026 07:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773153511; x=1773758311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6l9nEKwrf31Xk/xID4nEKQRvrRWqlWHqJblZDh7N8fU=;
        b=UrL6Iuc8YWmka3gXAx2Uyg3lA5TDvmTh7wO6b42NZAV4BLbmPh5z+C0w/CrlI42zMT
         CZIwHF2N2YUND1Y4RO3LCBP8a3r9eSonCbQqeawhGwSp0SuY5nUK/0DcMnOLoWABIPQ2
         1WOGJu8TabYDQrkBNWGCFem3a9o9grRpxapp7sxsOgFpEc934qzPSclHRoVsNpBL/rA5
         jBsg85cLIeg2/B2DlfL5dbcAka07OCn4gSXMow4+3cpqhiMThU/93FkKmDIbbCbTBYT0
         Ab/s+Me9lVODLhS648u0wJSMybih3nYoIH9+WQsKCVLZNUR6bfjZaoDSqzZC4RgEUbhS
         UFiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773153511; x=1773758311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6l9nEKwrf31Xk/xID4nEKQRvrRWqlWHqJblZDh7N8fU=;
        b=ablhSRB2oF5Q/yO/5NRP+D+wKXmHFOzwE9BPP2PWJftw1PuR3ZNx6FxUW3xF+70nY5
         A7g6UwQt+uGUx35gUsn3u5p7xHKPZIw8r6PbUSTLNkT15VijUk8d0bPYnPwEiw7X0Laq
         ffB0e1XIGsyskCNvqG/FWorgc6zsJo6bElLqe8oUS9PqLYSbC8wc8fJ9JYgxaxILihc+
         amM129J4SptNOz4M9815hhNW8cTe1lX05zvm4uY2Xrl1b9SfURPHqc35OSTELVcpe0cj
         cDMr3V0obodmKq4OWNPpsxJkEbCeBRiFym7YOMOs0oqx9H0ElxqIYoZLy59fTaSZJZ0J
         Ctpw==
X-Forwarded-Encrypted: i=1; AJvYcCWKJi+02+1WDBW1nFihOq7NeuR5Xd3wUbDuaDyW6jDqlkWe/pbpIp9ogehWhNrOtocroFwLXhS779g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN3D4+R60hNkFX9DvaTKawXJpBPz2gZgwvQZgaOzQh4Lv4eTXk
	lm20NqcKc4oFd96vP95ALohKucqqj5QloYYlHx85t2gF6RRkGZ7J0L2j
X-Gm-Gg: ATEYQzzwTnMm7KXkwkCVDeP+4NY9yRoPSsdZ32/WyZHgq7gxRTE67elsw5M4/BgCY+C
	SvadjN+lkh7hPh8eayHRkqiQUd8MxMDMzcwkEiAU7iF+HuWccIx9IugaWgmcDoGBEp0n+wJN8j+
	8cvcJVeWFfF93jaqD57ZWPsg8G/Q992fzGov0ak7bQwPhdHt1b+LQeuOI7eUrd+L3VIvPp4kOM1
	BnqTcgHSdZlCA+Y1mwUV9OaDUKVIM6tL3iV67On9BrWsFfN5IfQn6+w+C7HQfziWMc4xgpyulqI
	uY2hPYVFvwBxDRirRbz10sM0/JTSAqyMu8GmzaClzqDPKpjTb3s4jlUJiKoF+7HqwaSZnBSf+A1
	Kk7CzoG1GU3XPduti53C+7tPvvtjNMc62FDkuHf+XsaFvmenqwI67XYP0+c/uYfRRFmKsXtzO3v
	iguLWUR8z/tAXErOy7ww38YcYjq4NC63W5gHrkahl+7ts3ShZzslKVURx7n2d7jkobHAXOkKYPC
	a/69kPFVTf/clULSCkMyCiMbAM=
X-Received: by 2002:a17:902:c401:b0:2ad:9b86:ddc2 with SMTP id d9443c01a7336-2ae82455273mr157415305ad.22.1773153510917;
        Tue, 10 Mar 2026 07:38:30 -0700 (PDT)
Received: from codespaces-717661.3gx5x4kts4veljes22u4ri2f3b.ix.internal.cloudapp.net ([23.97.62.145])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aea542d3easm38711085ad.55.2026.03.10.07.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 07:38:30 -0700 (PDT)
From: ChenLei <feihuacheng@gmail.com>
To: till.kamppeter@gmail.com
Cc: andriy.shevchenko@intel.com,
	linux-iio@vger.kernel.org
Subject: Re: Request for guidance
Date: Tue, 10 Mar 2026 14:37:42 +0000
Message-ID: <20260310143742.57870-1-feihuacheng@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <aa_yTUNAmkOUnN7j@ashevche-desk.local>
References: <aa_yTUNAmkOUnN7j@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>We are already in the relevant mailing list, so if ShiHao wants to work on IIO
>drivers, welcome!

hello,Andy Shevchenko

My name is FeihuaCheng, and I am a graduate student in Control Engineering.
I have been studying embedded Linux and Linux driver development.
I saw the discussion about the AD39113 IIO driver and I am also very
interested in contributing to its development.

Would it be possible for me to participate in this work as well? If so,
I am available to start now and would appreciate any advice or guidance
on how to get started.

Best Regards,
FeihuaCheng
