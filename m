Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260D23D9DB8
	for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 12:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779279686; cv=none; b=Ix/97fiu+Ycr3n+1AvCWe36vXc/lJk6K/EUwiGAp5TWOG9vbrir8YU5inrw8H6B0tmEoFPU+jrcTrYmmUM5o0OSlC/piHHpBjtVyJVbQLTqUIUC0H2O4QmB6raNhRef4W0hwA8dnkeLzWjbXCXhFcqn2NaxbN5xMHqIThIYJhUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779279686; c=relaxed/simple;
	bh=TAuvyYudARAkHTzjpNfFTMQwQ0je0Xwjq+y2av6CwfA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TET9R85SNPIrcoNIyEHevyaXWY54csIrRSPXaq1kiCFhd7lwrYzfohc+F625JlY92JD+jbZctDVMqmYrGbea0nGJsHtdgy+GdrEZRV3ftsXxvKNHgzrGRc8bNwVReXyx9aaeen/vA6Vr54dKC4anjxCtvfk+xqom03gok2rLXtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cQuMx+EF; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQuMx+EF"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a41a9a97d3so404098e87.1
        for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 05:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779279682; x=1779884482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TAuvyYudARAkHTzjpNfFTMQwQ0je0Xwjq+y2av6CwfA=;
        b=cQuMx+EFM/zRlyfW4cTOuepY2VLcffe0ShuUtfSxbRyBiO2BmsXpzdhguGgZnysQdY
         SrYrPxPg1R2ToilX6x7NMBBy7ccVtgDVgPJo4I1V8+fXgMIdXUl3n6G4lrRiYWQUOHFL
         q7tHG9gWc/NdWeZUgNFGflrbYjb9lngwC1xu4IUeIscS7tO0UROgnnGP6vem2gg2RTD+
         /yPl0liIykDW4ewxQMUBmU938nk2eOokjRipvfvq2CRSQNJZcCGLhECxiM509GvE8EhQ
         LghUpA3pI8HSOOc8tEmr5iM0Pi8z45w0IrDQX/m5q9ZprJYbs8FUBPhz1yn3Hy3xYkvL
         hm2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779279682; x=1779884482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TAuvyYudARAkHTzjpNfFTMQwQ0je0Xwjq+y2av6CwfA=;
        b=J5iEkDdbU6CjblhgEiETy7tyrm/qK1G6D8NjEMSxgGiTilfBjhw8ifKr840S+D17Bs
         QVYtdJNhf0ktcMsN9sdJ8EASNpjXl0+P+eF2hQj6W7QiPXeY36ZIZ41oXxBdAfeO+y6G
         egrYxvQ7Y9INzgWLyzMhypwWuYKG4pn3CnUs7N0BxXU5pzDs0Ha21YEqyx3yDsV4tnrh
         y4BbuQB+Qed8sjRqq/MZTpSn1RRFRzBzVNdXM+If9Hl6iAe36dGbT2tKJDKGtTZ+GnbX
         4S/7ZDf9Iy5n4T/HWgroo31hvv7ORmL1JP8nfFkR0oxcjBIPqNh7NMxwk3rx6MpKgNfm
         Hhzw==
X-Forwarded-Encrypted: i=1; AFNElJ+mIJLYTsckrWT73L5u6GJdT/4ooC2Nxps7hghzoJEix6OGaxDr5ml2+Hdf6yRA2aSdT0KDO7U/fHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFFCqAOMRQbLfSNgwMqv/rtb8oDf4uBQGPSYVR2a7+0Wm892j0
	X/n1NiWidszS1+11tu6E0gRB0bq37jtfi8RjtPYph5DOj+0yVA0Es4zN
X-Gm-Gg: Acq92OGiMGwMLEOyOxXAFbxgFuO9dYagRNAAuBjCqeEdRj9MdceAqm5UhriIYTssIQn
	70zz+1AEGWxRpG6C3sQCH7gTo4qxp2JewfHGHG1z9h6zllZSEeRaHAADRwyAWzKZbWFgrJV/KhJ
	Eq4JOSr92hU2EvbFmMMLxgewT26SmpfA0EoQ8PAyKWxDUv5ioWjMh80+ZJheXdSmGTN/dT/cCzG
	Bh1TyAbfcJPWIVJ9rvOTiJhKpK2EpHrQk6IDKES4lfmnfa/+rJ23Ji8Aaga2HOidhwmlI9WKcsz
	2AlDuL2uws5kj1DKaadBfwNiigHI+Ehhh4wRJBNXNMALYZH1deUDwkStP5fIDBrXL/UlyVi1O+Y
	Q/kHaOKKAKl1UFnCLLhxqmsmqlFJFfbbDoAtUWnpdgkUdRuzGio/t7dW9gEvoeu1DVLzTjz0BGp
	5w6fBlYyPCQWr4ZnT+iPb7xpxvBs9deP3ClhRYPL9CJWQlLRkF0gZLnQNwNA==
X-Received: by 2002:a05:6512:2241:b0:5a8:6f8c:24b1 with SMTP id 2adb3069b0e04-5aa0e619d83mr3072457e87.1.1779279681780;
        Wed, 20 May 2026 05:21:21 -0700 (PDT)
Received: from localhost.localdomain ([213.230.116.218])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a91dfda34bsm4889977e87.81.2026.05.20.05.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 05:21:21 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: u.kleine-koenig@baylibre.com
Cc: jic23@kernel.org,
	gregkh@linuxfoundation.org,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Stepan Ionichev <sozdayvek@gmail.com>
Subject: Re: [PATCH v1] staging: iio: Use named initializers for struct i2c_device_id
Date: Wed, 20 May 2026 17:21:05 +0500
Message-Id: <20260520122105.15299-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20260519140624.1585534-2-u.kleine-koenig@baylibre.com>
References: <20260519140624.1585534-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reviewed-by: Stepan Ionichev <sozdayvek@gmail.com>
