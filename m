Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E89A3D412A
	for <linux-iio@vger.kernel.org>; Fri, 24 Apr 2026 12:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777035474; cv=none; b=fqUAPLyqoebD0kAz2uCkqI2+HjflrnB0sgYSSyqul5uD+E73xXMsv9Flpharkgvt3dM1yjGbMXgSXbf1yWq1gHoTK7kB0HynbQFgS/gweP8HWC6TgF/ZvI8LtDHhlTJ0IbKtijubnjJb+k8uKE8G0v8Fwz0CAIYahYHzQcA9h1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777035474; c=relaxed/simple;
	bh=hgVrH6KeQFMnKoFzTbNYFnELRSO69bh9cz8Ztyhi7rg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y0CR/JAmAffbjX03GRxjmMj14l8GydhuOBBkdtZUUIA3ypQDh36nPQGd3krtym0jizMGeSAAzxVc+Iz9ALIzcPYtg/ne3r10jVUHct+5XY/NwUGI8Eug2+zhvgJigInlksWbYqRjSJgKTHrDvgkjqqIWe0Q9zmNl1rqzw0J5Xvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dgkmBgJc; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dgkmBgJc"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c795eacbeb0so3393343a12.2
        for <linux-iio@vger.kernel.org>; Fri, 24 Apr 2026 05:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777035465; x=1777640265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hgVrH6KeQFMnKoFzTbNYFnELRSO69bh9cz8Ztyhi7rg=;
        b=dgkmBgJc4kFsfJnyMFnc7DtlhlyzP8oiIZybmPny7rgWnrVqJtCuCOsAOMiiXPkfXV
         GX9PgRNGYXrikFajgfSCd89FJhGjJc8QHse8h8voD0QFoqLrhzlWgZM+IlH2pTwWpno3
         dGOdGqJEYfbVugVgEj6IRDVz+mciBbtaOp4/4V0y6xcooIU8ddu7O705IBpTSY8L6Z8E
         mTZp/wBxmrxVN49kDdub7nJzWQtPaoijPG5Y52TXlUmcSye9X+v1ECiUptOzKR5cteEP
         T4bNISR7rsW8GvSLhBGD9bUFE9haHJRRM9uaruil89kHmzJkMpUgtbQ78JQ9TJcFGvp6
         hMoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777035465; x=1777640265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hgVrH6KeQFMnKoFzTbNYFnELRSO69bh9cz8Ztyhi7rg=;
        b=IACukhoYvEEieF0ZIrXibUECCL3/3NPp7lyPWh6d4Ut1wGK+LK9HSP2qbGiUwt7lts
         qHLz8mwYcafrJtZ3OCybLD9l9XR7TV8JKJ3cXUl4aS/rESiasZx7E2AVS0A0Kr7h1402
         3v2rQew0nvfMPDwIP+5N8ewVpLym+wFw4CCUhaFSu8svRYTIcXRnKvirwNVO0/o0qKE8
         fQG0bb8w6ZNfCmrWI9DV66CuB9KpSXvaOqtXf92L7wE3FhuJkhbD5QaUyWbJsWnBEcnM
         ukNUCN5bPp5HmiVpjG5VHX+Gzo0LOsxaIDryFottLl29N9nwJ6ECC61wi6xdfYx4Zr82
         2TPA==
X-Forwarded-Encrypted: i=1; AFNElJ/upz3xyUQ51QGaEJK3sCWZ5HbIIN7G8sBt8eTT2SfeEhAMcqrZ3Egph09qC0JUkh9+LImWRKGLC5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmL/+kzg32eGl/RbZIx3BDFGgp7DRxQ9AbK/yOak/H1UeF5v4/
	UEFnB4rUwVRTVm9a/yZdtlU9pN4OiLPENElR+aVA/XSp8H14RaW+eRc=
X-Gm-Gg: AeBDievdye6iI7MjODfL/lfrPKUkqUloYmXGgVAF7fXuose/716YcX6j9JAX6jZyGft
	FRixe+g4KC/2I8EAUue+KOG6SCTDa9rGMCIbkGZSSnUo6O9dNzCu2Y94eo1FzPIBlJvE/0acnuK
	WYd7galTJsMnfU5qdhIekeiqUKRTuenFzx9dg4/dN+XAfOnDhemWZKCSE2Nq8FcfVp+AVzNy8PH
	G7sUnT1qS9bxeqBcIBeCYXfz7W0bMktQKP4w5c1pi+VhJtqTnjpx8nTYJjPgovA5Jyd5HKZx5r+
	1XU4PACiZcHPJyFhFqYtPgcKy6gcx+WJFSW+BlTtOyfU8dlUz9/Ps+GxrsNIMCq07kfLzUYfUsD
	rsrniH2QX7Lz0q4tEkBBnsFDo2UuFP6eLnrf6lZ6+Ff2mu7JH8CU64jFfAu9ZVROCs+1vqS1n66
	J8/mkMqP1IcMlEpvoZs6BIlGY96+e3UlkUb/tn49/QqLBbVYEHhw==
X-Received: by 2002:a05:6a21:e083:b0:3a2:e563:82e6 with SMTP id adf61e73a8af0-3a2e5638386mr21615958637.1.1777035465307;
        Fri, 24 Apr 2026 05:57:45 -0700 (PDT)
Received: from nik.. ([101.0.63.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9cbb1dsm25618752b3a.14.2026.04.24.05.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 05:57:44 -0700 (PDT)
From: Nikhil Gautam <nikhilgtr@gmail.com>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: andriy.shevchenko@intel.com,
	linux-kernel@vger.kernel.org,
	Nikhil Gautam <nikhilgtr@gmail.com>,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Subject: Re: [RFC] iio: magnetometer: mlx90393 - regmap vs command-based access
Date: Fri, 24 Apr 2026 18:27:39 +0530
Message-Id: <20260424125739.4685-1-nikhilgtr@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260424114818.1290b029@jic23-huawei>
References: <20260424114818.1290b029@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andy, Jonathan,

Thanks for taking a look and for the guidance.

The MLX90393 does indeed expose a mix of command-based operations
(SM, RM, etc.) along with limited register access (RR/WR), so it
does not map cleanly to a purely register-based model.

Based on your feedback, I will proceed with a custom command
abstraction layer instead of using regmap. The idea is to keep a
clean separation between command handling, register access, and
bus transport (I2C/SPI), while keeping the structure somewhat
regmap-like where it makes sense.

I will put together an RFC patch with the initial implementation
(I2C support first) and share it shortly for review.

Thanks again for the feedback.

Best regards,
Nikhil Gautam
