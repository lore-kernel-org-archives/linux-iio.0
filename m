Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563C73FAE04
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 14:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778508004; cv=none; b=FWdrAJwp6zP2JPYo3H/0/XGOij4dXUXqk2SAzxW7T96W/yF91J3zA8G44NNpyFKnUXAet8k4Px0rKOhLfXYfNdVwtvvYk7MLE3s3Gn78kOPdaycF2zfJ03kn6JPIwT+zdK8nwQHlsPjqFs6xyaoW3iIzQFHpRO6hcakr8NQfkY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778508004; c=relaxed/simple;
	bh=wW893V/CQyQqOqQAjqp+mreHP2BQLDBYviEpWQ5ykFQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uf5CBpSNm7l1uKEa/jgMJmSvTHMjrucjXUjE8P2SqEUCMQpe2xgFwlUQ2qwVfHQV7Yp+44NrOv9VMmD27pMBjghAw+jnD5EZ41ERWYT3fTmu/sPSOS9Do7IXs/l4WhWTvyJwsdWkmGh2mmgVn0L76hA9UlkdZJoTC2jHrsdBfPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RRB5Ppa0; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRB5Ppa0"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-445ae03198eso221840f8f.1
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 07:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778508002; x=1779112802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wW893V/CQyQqOqQAjqp+mreHP2BQLDBYviEpWQ5ykFQ=;
        b=RRB5Ppa0FIg937bRMuXZa3FI2SoRB/rFvnBPpkZvCtwdUhNdp3cgiKZwATG6Aw+K6U
         NMkwBN6bNccdOnyzO73y2ljm056NViyuBeoBEtg/5zi0vboqFlaL3J9kh+79zkW9WEaG
         sA+iNHJH8pw46NCRERm9SQpyAeiJF/ynjYZ8+COZd0lr/ZaUVtONVqL5IYWMZgS5trPg
         LC5iRmcJKDb/JUI4yJ7+IX324pj0V7kX2M6JSGq+U0f9MAVrk/IPtZksqeHIvOBO14JO
         BaNTsL5Mna2ovV62El7md9RpwXARk795BYVIog+3alJUnMPpH3HsXKRX2+lVFOKiDNYo
         HRtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778508002; x=1779112802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wW893V/CQyQqOqQAjqp+mreHP2BQLDBYviEpWQ5ykFQ=;
        b=lpX0bIZQuplPExQnv1/07yJX/b3eK9FMzZ3y2Va2AZfx5Ocr782iutGneaf4ZXFhQt
         Sl8S0EzQ+DOMAepCCjtIp5l0fyyD73voRFTuqY0XuspjG/YqcRiuNJuAFUepzq1fqkAX
         z/pR54OVc4EfCTbKRySWsqTgFARUW29pERTJu11SmzvQJeF3a64IO/uuRmBWXr5V8thM
         vfeUpi7DEUViPgpnZpC5Zy9jPJvJEkOZEIaIHzACuZFN8dcO61oGuvyk0CXBKQ/ZEi+S
         RGMPfdXeUZ8CwhBw9RdUuRiK3Y8TcRYnF2Cy8g3i23Gho2dyZRIfSinX7td4yRyHbVOb
         CdZQ==
X-Forwarded-Encrypted: i=1; AFNElJ8UxsPHGJnkFTQYrGdxZrQQodXrRmUbSdIv/dDkLpvLYke8mRsmt2eVjpbxUvwhQg1zR6FJy1Mn2U4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcGYNT3JLeKtlIyevcHEFPQ4uoSXnWwiz/57jQQGM059yJgdIL
	4JsaUl0wNIUUNjLoYDT/MRpCR25DSQbrEacpbv+CT2K9U8eXyzuoNqsN
X-Gm-Gg: Acq92OGX6i9yFDwB+JgrB/H0mF/014y91uIPg+//XVSGyi9SIHjyx3iV1vDzuXMv98k
	PSaexhsnmBfSZhbDplD55Spaynk6SGdOnOM1z3aVvkPja/dUz6riuCKNHUU3qY8aHKDl/UHM1J3
	fYNHNuPW8t0Yf6d/JDg20yP1VUv6QivXWXTU1dIlRV3k02RLSDmE8EHR8kaulAJtoAcP9gYrFEI
	t7MB2+eLFB81W+Y2vZ7sWTUjT+WL6aYPEQt7AXH24pTSUMj9UoI18YiBS12yS9G461eE1M8b1cK
	GsD1McgLysHvRdzLZsinLAmDlpmKQuBaa72197oIXSOL5Ln1Gyf02WupQwPJxkGtCjhJNwL+q5K
	CljEjaZOf3GMPPGSL6LbT2ahd7VGVCwjn328CuSg1+9p4aiKM5VUDs7DuVlcAbezz4ICud2k5o9
	TpoOhaGS89CssQEknglg0ID9VZBnggnB6fM9Kch+3fLmZl2Ze491L11A8=
X-Received: by 2002:a05:6000:2b06:b0:458:3bdb:7eb0 with SMTP id ffacd0b85a97d-4583bdb83abmr2538689f8f.4.1778508001701;
        Mon, 11 May 2026 07:00:01 -0700 (PDT)
Received: from localhost.localdomain ([82.215.118.79])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4549120eb95sm24953238f8f.20.2026.05.11.06.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 07:00:01 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: joshua.crofts1@gmail.com
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	gregkh@linuxfoundation.org,
	hcazarim@yahoo.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sozdayvek@gmail.com
Subject: Re: [PATCH] iio: trigger: iio-trig-interrupt: use devm_* helpers
Date: Mon, 11 May 2026 11:44:30 +0500
Message-Id: <20260511064430.1731-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20260511060732.7728-1-sozdayvek@gmail.com>
References: <20260511060732.7728-1-sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, May 11, 2026 at 18:54, Joshua Crofts wrote:
> I know they might be trivial changes, but please slow down when sending
> new versions - I didn't even finish writing a follow up message to you and
> already got a new version in my inbox. Ideally wait at least 24 hours before
> sending, thanks.

Sorry, you are right. I will wait at least 24 hours for further
review before sending the next version of this and any other
patch with open feedback. Noted for the future.

Stepan
