Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB943DDDB9
	for <linux-iio@vger.kernel.org>; Sat, 16 May 2026 15:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778945069; cv=none; b=ZPxUumo0UEdWk/4YiTUKrdfxMGIrCHHJGLv9ub2okBoF2QZZQwuXvGDbqhbhq3xkrGgyRe+fLvazCyigzWebrr54rkdiuFD4SQJQb9VZEKnOs96dUmHTYcz/uBaDQS3cXfa05Y8kIFcbbzrDyXy0EmPIKuyQocrCEfw9XUkwT58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778945069; c=relaxed/simple;
	bh=eZHMgflYalIsjtZ2WOJburKc123thnpbUEtTwaGBgu8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fiJBbTXY4rAAuNA47Z+dO8g0d5doO5OMeg29MabC6nkQFFnNqUE0wAf+Ug7SqHYVaWSPdzAgowL9DE9hQW5Pm8a+EnnBjHs0ojxxpx6HFbrq8HHvY6OSAIhvEMDic906pPguIaKkghtlZp+tOVx1uo71vEKmGCr9iepyzejvFcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MWE43EJO; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWE43EJO"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-44b729aa7c5so38585f8f.2
        for <linux-iio@vger.kernel.org>; Sat, 16 May 2026 08:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778945066; x=1779549866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eZHMgflYalIsjtZ2WOJburKc123thnpbUEtTwaGBgu8=;
        b=MWE43EJO9wy8MhUmeHORZ5MMLuTVD5nEnlWG934J5kyMdXCjIQovIJU2kxZlo8QK1U
         NUjyq9oWmvEOkhP5P94UjeUsixYe46Oa8cdEdzyiZpmkGc7zG9SxEQbDrf5K1vx+kjZg
         WYP+LPLHZ4nc+dn9z9pE7PIf9s9x+riTw30zxg5eF+wJ6vNeTSnWev3gTtx6JYwnNyyV
         /FzhipgqeUsUWNC58fB0vr2+7vlggCNpfHsxKvLMBzgsT2zLew7BY/Y+zos1FhUkrAPw
         zWJuqnJSkJdKlZYaasmphlC2z5v4Cw8lzdjqm0V984ETYm0P8IYYfrneJoyL1zfbdztj
         Oi7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778945066; x=1779549866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eZHMgflYalIsjtZ2WOJburKc123thnpbUEtTwaGBgu8=;
        b=UzcQAuHhhjS6K5wLaD93lW3a4iu2+5T1cxcX1JidaTvcLNhU7asTEeosZnx94ih7jM
         xvG3VttdnZQLoVqvmQuuJ1s3fTdUpDx6PqPVbABjvVVlOE2BNvCUyBvJASo7DqaIwH1p
         aJ4p5Rk3HW7/kZJoMHgU+IvphOeJE4FESpSbUSQFnJdet8BnuRu4KAXNcIgzxyXAbaJr
         PxauLOC7ZybIEE7QR951mrpF4Ixb8x8Z5Ndjc9NTWnEgUzJiZGqiPXY3WkRYMSqy02uN
         nkvrLGyJ98rkgI3yoBWUCLSMxpaUxhMfC+9iSRRx4irV1dZJEjXkOVHkdVCjd7ypZ/4r
         ISRg==
X-Forwarded-Encrypted: i=1; AFNElJ+dXJtO3b55M2KPGZAdZ8ARG5IbBQmvWM1A0bqe8BYhFxX9x7upegh0UUpRepnZ4DfwMGzaYg7onRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpNbwJm4gBUI3ukgMC3zXQLknAxRwkMTAYrddnZIc//bO3yjBM
	VJT6yT3d+miVOxDSxOJvUckBa7rjx8ixL9zYaN3fpen7UJarZuyAta6a
X-Gm-Gg: Acq92OFVtwnhI17zy6njYSMFAYsLW207CFkaLeAHVAc56qzjkRVeTPDf+WsQPriykhA
	vZo985lHZBUrz4Qd5olIhbLtnwkeFsyZ2EcDpAnjnxZKbUTWEApoYDQtmU15VzGLGxf62+jCqzK
	WYJODmHY4qxd8D6CRIzQ23VcC7mCOePCaOwBRGOfu3r6D/2AdFaOct9JEDKfwk0WV+8FtMGxiuu
	U5IR+1iWgJPRgo8yDEOuzO71j+nv85FQSgdvO5a96/bicR9E9U5eOOc/vP8rYtpRhmcFEIutMeh
	NdW4CkFGwDKpqNFNjHAtym4px8VDzsjl40nRE78fz/gZyAjr0CQwHz8NjWJJ8ZtXUjRv1DtREMA
	82KqMDo2Tw4Ild05ipNqhYOQJyyDJMrzYltuUWYmhNEuk8bhEEzZd9GzXFm7IiJXzq2f4mEznJz
	Wrrtf/7alTZeHvPTa0I9cRC6h/Sr+nu2sjeWD7dCaUvhLcej7ZL7NP24uB
X-Received: by 2002:a05:6000:2c01:b0:452:9709:40c5 with SMTP id ffacd0b85a97d-45e5c595659mr5586882f8f.1.1778945065853;
        Sat, 16 May 2026 08:24:25 -0700 (PDT)
Received: from localhost.localdomain ([185.139.138.68])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e767cb9sm22223739f8f.2.2026.05.16.08.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 08:24:25 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: dlechner@baylibre.com
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stepan Ionichev <sozdayvek@gmail.com>
Subject: Re: [PATCH] iio: resolver: ad2s1210: refactor trigger handler
Date: Sat, 16 May 2026 20:24:08 +0500
Message-Id: <20260516152408.2047-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20260516-iio-resolver-refactor-trigger-handler-v1-1-25b11ba0155e@baylibre.com>
References: <20260516-iio-resolver-refactor-trigger-handler-v1-1-25b11ba0155e@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, May 16, 2026, David Lechner wrote:
> Refactor the trigger handler to avoid use of goto in a guard() scope.
> Ideally, we should not be mixing goto and automatic cleanup.
>
> iio_trigger_notify_done() was not part of the critical section anyway,
> so is not moved to the new function.

Reviewed-by: Stepan Ionichev <sozdayvek@gmail.com>
