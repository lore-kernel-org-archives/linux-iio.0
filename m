Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FF43446C0
	for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 12:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779022088; cv=none; b=bv52phqD2pNne4rh0gyLLpXIoeNLBwulW0eFz8ZYb8Mz8QUGaFf2oHyYfPfrFn+imXS51ubSkMlMTFxHGI1jyRyMFr6xktHw/pmre/dAonNqpJtheQRZnpV8FOv6MxaQwKrAXaBj+gncDRUOjy5N1A3Oin5nU00hPHLEUys9LKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779022088; c=relaxed/simple;
	bh=QIMYDqaUPvZ5gEkG+tUeWfErizFJS0HbMQl832Kp6Q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kr7a3nFtoM4B/j+gf8EAJ19yy27mqOLtgsSIgflovLHLni6/4sGgglHLnraGAgb43kaNv+zU/jYV0RRLCPRU2qd+HvVV/JVXSCHJ4lkHKZeY0qdDXYgpjaL+w81ArE43JZ6N2yYdDBATSyb2UsedUylohGo8PUph+zYpFbLOFzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XAkJ34gX; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XAkJ34gX"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a4113ab355so1751032e87.1
        for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 05:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779022086; x=1779626886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QIMYDqaUPvZ5gEkG+tUeWfErizFJS0HbMQl832Kp6Q4=;
        b=XAkJ34gXHslNZ/50OfirvIwIW8xlkhzRfH2qNbzpPR/grAqrAE9ZFyNfk/aoSnGRNR
         EFJCVaQ7PKGLa1553/0+1DSWyvLQlIV0k5bGyY1BLPJQgwYhUvCYAcM/LA1B7zI+LraR
         XRavvBkxov3Wy8J5T7Qq51PLhLV5BXsQYT5z89H1yPsjcbAS/leA1QeuHbdzq1V+fg7I
         JrfJan9Y5ZBQTTRqwrdY9W++e8VrGCYMWDnvI8C1VkRJ5r6gsw5OyFGEMurdv0P/JgeA
         FJEsgnVbTiCM0nftexdnLJI3hTU3snOJ6bgc+xhyC+4oF5Tm4DqZava3snYViIyRfoji
         VVpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779022086; x=1779626886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QIMYDqaUPvZ5gEkG+tUeWfErizFJS0HbMQl832Kp6Q4=;
        b=BEobtHKFxtMq63aoMT0ol0FBJbKmH9C9hQ02G/eOuLSDBvzeSK7v+bDwrUB0usO/U1
         DFiwmKv68ta1zf9gP5Za6RmoblAoWbNeltUpyM8eJlcdL6SN+35HTMbeKYKBokWOB3OG
         3fyc8CoBQowQZbFFKvKWlVfxosGrYvK2yXB79ENZY671AHCYfO7xk+K2+IyCNIsYYbsU
         BLEY4CEM2XUGKpRh+UZuYI7FErBC7yQJzObwJd4A5ibG4se7a0W/Y2AEznOnss3vCaww
         4DNH/UfKMpPVTLPxv1wHZ/xTThrPq/1byF9pjemkF4muqv6z+GMv6d9X6cOcQJGa1JTn
         w36Q==
X-Forwarded-Encrypted: i=1; AFNElJ9eHMfxEglasgrgRr7qmwuQR/KaQj1KAKhvaiNWfEIEFRwBRyDl97xbDzrWyRr7C3o0EGLfwiy0mCU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3uuJoSLrTSXxDJ34N1pW06Vanq/qKBs1ZR/tcY047+3DYFFGe
	YJuBqSoiE2Mx77ErxtEUiqQ7ByEQJZ31wNux6tCkCPyqUqZmYuPqBAWl
X-Gm-Gg: Acq92OE4B3KRZaeRcvJEEr+SiJWByMDAC0RRO8UZC7CxqM0yizynsGXOcZP6cTue5Xp
	4mYI2GONN1ddGNe9ylCwcg1y2vLRYwH9Y4Lph+qOWyqqvJaBDrl57h7Ak8cfcMG4FikjsORfP4h
	fYJG5UjdSJdZwwlpPdWGwbqXZUO03KFSKwkLle3ktd6vUD2bsf44XFr/4kOvLwSDydbTyYudxir
	GgeUHrKv086DtJHCPVvGgdTFc6/xohwSXCp9fuqtVyvGFOFUC1jFPeHDdS/u1jSVpREVdFGUqUl
	7lSxsn02A6OtVONkYS/Y+rpKzZZDaWV57MnbAoNKwmjzwxxglFo/gNt4648wUPVW5lv6FlftnPl
	E9bWDdLSyF9GoisHsAiIpcu1fCzQTRv0l2a/+RQiKUhhZ4vdh8+KCZRnUlZZJI6AEQXiJfanCgb
	TITYTummZM2V2O65TegMCVa0/nuG3H2zg0TDp6zj8NacEucILmV8s+hjR1vNUXNkxnQU7Q4b6Je
	S4=
X-Received: by 2002:a05:6512:33d2:b0:5a8:afc8:c37 with SMTP id 2adb3069b0e04-5aa0e60128emr3166874e87.4.1779022085321;
        Sun, 17 May 2026 05:48:05 -0700 (PDT)
Received: from Shofiq (87-92-218-151.rev.dnainternet.fi. [87.92.218.151])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a9164cd939sm2713984e87.70.2026.05.17.05.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 05:48:04 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Md Shofiqul Islam <shofiqtest@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] iio: accel: adxl372: Add timestamp to FIFO data
Date: Sun, 17 May 2026 15:48:01 +0300
Message-ID: <20260517124802.2261-1-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.54.0.windows.1
In-Reply-To: <20260517123059.49570d36@jic23-huawei>
References: <20260517123059.49570d36@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Thanks for the review Jonathan, David.

Understood — I'll drop this series. The single-timestamp-per-IRQ
approach is not correct for per-sample FIFO timing, and the complexity
of doing it right isn't justified without a concrete user need.

Will revisit if that changes.

Regards,
Md Shofiqul Islam
