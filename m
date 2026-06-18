Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9B9319851
	for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2026 23:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781824581; cv=none; b=Tv2EF2v8dDZsI7zFObO8Uzq4DMO3QrUzY5TK7iAuxgvDT08FNQsY5xtKmG1iaY4CQfqZ3PwkOEJerK7UygisW1zwJAux10dYhx7+4QAPA9uUXG9khx+alM/09CQBOVvFMN5c9IEZw9S7FO7/uT6mcXaQuKiYkGv4ZksYiHZqjPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781824581; c=relaxed/simple;
	bh=zSGRFUVOU8zQtcx19C4wVL28VpBiSDZFK8EqrqcNFgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JpiJCW7jfWueVayyuvWXWSF1qjTnlMpBe8pDkSPNM0dXfy1vbxr8t6VJsmytnTz11cXv8nCFidjeLTEumPQTYG2Wo6m2ri96K+/u3fl2OwSc3bPJ2ypZVNAiV3aiFXGq5vP4Jy0O3zZTeEXZ6bVwgCE+2NcV+jz5Sx9hG5GoDIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WD1CtNwB; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WD1CtNwB"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8453f568e84so1347915b3a.0
        for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2026 16:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781824579; x=1782429379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VxhULN7pXGfzm2jQKbaoM/DnrHazh2JiPRhvIPUp90Q=;
        b=WD1CtNwBUo+eypslL0Qsd/+Km+MDAUAUgqjQ73JpstzJvXlYnoWVC4JJZ+oicOH30w
         E120HJONWd0HzR5bA8Yq5UOkd7RwSKzZlQUAtp+UDAtI374qoOXCvE4dxdYgyP+uGh9G
         sdBv0AP52XSXANaY1Urx3dgLTtBrNB3jXF9V3UJWphOEpl2L/Y0QCWLJgIGe9RQC11m6
         IvIKNZ1VJ0PX8SJZkr9zL/iwzp5/a7pFhpFQbnGdB73ZFMANV5H2QoMZ6pc/ycAdfFGH
         OWBGb+uxfxwyFiJepQe4woFDBigx24uzo8NG4IF9Pln5wchaYJyBUBNjhiVYfnZfk7yi
         pPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781824579; x=1782429379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VxhULN7pXGfzm2jQKbaoM/DnrHazh2JiPRhvIPUp90Q=;
        b=elU9r+w4plVIQV21p9VB0VTjk5g+BxGzC2IF0Fj8OoUps8rGFzeCHPynqcktoPAVuV
         djqx4kLYfalrm1MBHkcddPZD7wx8qLoPr2Ygs2OHUOiMPJNC0iOoPyKoFvBEhi1UNa9+
         A33C9wF1X98SH5JRjH6S6CvyPD0qXu/KHo5On3SjLgwqTVORdG9CuaI7IGcwJPyzeJ4W
         TNTfa88TSeZG1kMy4hXqn1p9d49gEPi0KaI//T6BVowrg2OenPHxbH+sWnsFuXMKHS59
         BL477PPLNUUOWsHE+SMwWHmOq39lOjVOT2RGI2SG5wPcCiJKn5cfGO/iVZhg64q+Pprf
         ppZA==
X-Forwarded-Encrypted: i=1; AFNElJ8iuG2H5Q7r9h7DDzcMZ0nijwdJ7D3IiiIAkdU0IeAI9WJ6AJa5CxRn6EnS+4PC3/gM4tHrVSz8znY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3Bq54AvU9WfhEoiSthXAQQZY1ZOz4x+tXEjF9/m+vb+kcpZYK
	X4lt4iplkbum/14mPDCNy2ZSU/Vg0pYdCQikHeHXSwEiP6S+o+skxj8r
X-Gm-Gg: AfdE7cnq4SScbJTHZfJBziHBq2o8bBjXChakERyWiTOTimRk7OxV2gRqEoE7KoDtqTb
	wPjkW7jxCowiQpH5MhISSw1pJ8Z8ovG+l+s5USm/3Vm2TnLTUpM0sSzQ7hE3t/pJg1tCWzpSQdy
	ebRgfVF6pRDfbzV3GsJ51i1/xcdKYDtvVamVO5u3fDvf3FglS/PbnqqUWrIBSwBxZdOqqT/nrQH
	hJ6Ycstb6u80va5UaeQeFACeaMZrMUd/5XUOwvsrPQAokcn4aL+MWdfxs2J8mAJbd8QRkhJoyUA
	jgMofT+ISkcjojxabv8WNFEkpdIZRwbRGnzPwKOinHq/ejQ9ykSCjqKsfjpkS1puwEQcGrD6H8A
	i6Ts9S84CmUKg0/UfV5DX7WzuV74FLGI1OQznlqQ7MHJjNBhN9cxjjQsSjV6HCCS02oWcXDNhuy
	4BmZKaGdQzo04zQST7KRG/BRzQgsxhWb11WoeevJ9BLM3cGr9kBO/ewdENWMo7vJNqmD92zM1sA
	tMh3tCd
X-Received: by 2002:a05:6a00:a221:b0:842:5564:2e2a with SMTP id d2e1a72fcca58-8455604de2bmr64217b3a.6.1781824578618;
        Thu, 18 Jun 2026 16:16:18 -0700 (PDT)
Received: from thorfinn ([2401:4900:8836:4853:aa0f:55df:e7d8:852f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845537fa3e9sm225135b3a.39.2026.06.18.16.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 16:16:18 -0700 (PDT)
From: Prashant Rahul <prashantrahul23@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: Shuah Khan <shuahkhan@gmail.com>,
	Prashant Rahul <prashantrahul23@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	linux-kernel@vger.kernel.or
Subject: [PATCH 0/5] use dev_err_probe for probe time error
Date: Fri, 19 Jun 2026 04:44:33 +0530
Message-ID: <20260618231543.413771-1-prashantrahul23@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616130612.73122-1-prashantrahul23@gmail.com>
References: <20260616130612.73122-1-prashantrahul23@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using dev_err_probe as it simplifies error handling and ensures consistent
error reporting.

Errors are logged when enabling the regulator or adding the cleanup action
fails, but not when buffer setup fails. This adds that missing log.

Prashant Rahul (5):
  iio: adc: ti-adc081c: use dev_err_probe for probe time error
  iio: adc: ti-adc084s021: use dev_err_probe for probe time error
  iio: adc: ti-adc108s102: log buffer setup failure in probe
  iio: adc: ti-adc161s626: log buffer setup failure in probe
  iio: adc: ti-adc0832: log buffer setup failure in probe

 drivers/iio/adc/ti-adc081c.c    | 6 ++----
 drivers/iio/adc/ti-adc0832.c    | 2 +-
 drivers/iio/adc/ti-adc084s021.c | 3 +--
 drivers/iio/adc/ti-adc108s102.c | 2 +-
 drivers/iio/adc/ti-adc161s626.c | 2 +-
 5 files changed, 6 insertions(+), 9 deletions(-)

--
2.54.0
