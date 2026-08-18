Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5606D24BBF0
	for <linux-iio@vger.kernel.org>; Tue, 18 Aug 2026 21:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787089885; cv=none; b=EDr1cIPePkJa5B5Ma8q5KqlwY0wHk85+Vb48WoNoXmSHRaP90k+kmb5Lrm/t/sD50N/orL1qbqWGC6CJ4R8scIGnLeqOu21BP3ukQPew8v7ts772pYqDlQ6rXFIIL9fRFcpHK5BUqm+7gKP3GnNcGidE4WCfopveO+ypgsqu/uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787089885; c=relaxed/simple;
	bh=btVpLO5n64WRWMho6cW3+pfoernh4+S1cMEU8koLgv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HVEdOo6S5AbF61ms974/TNl1KFZXXV6XmfFJ8JGhAH1//IowJYkWusOdzTAMGhG3r8CFfqQcyxpzdQ/syicZ1Rn1EJMRZtLFSebHlw16KgaTU1yeHJ/FgYOF7NFDV4BVeqanhCTFg5ln37Hhqjn7LlNgOgAMcV7oQq3JqNzJ5MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ms3O3dSS; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ms3O3dSS"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47de0093c42so242598f8f.3
        for <linux-iio@vger.kernel.org>; Tue, 18 Aug 2026 14:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787089882; x=1787694682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=btVpLO5n64WRWMho6cW3+pfoernh4+S1cMEU8koLgv0=;
        b=ms3O3dSS6s243v9XvK/leb6IqQACkexPTfXSE+Hjh++V6YkSU4MpBl4g+FvAVyc0eE
         18K2x8IvMuELqAbhLt58wmmIxWjSvfVyHWiUCc2efPGG/D1F8fnwSwhmLQn/mU2VQITz
         lOLtw4WFNNmlX5XrimS4BkxHVc+Qj22A5obMqw5QUUSeqPtyUPZjbc3jD8j2dbJAyvsi
         K9kANMoM631r8If7b+NWcrjiblH/Yha08PCVfR+zMUCgS4eTGvOlBc2z56fV47fFiex2
         1aumBQ8OfZ01990ED5hooA35qM2L1PMHeJo9PHEotPRf2dBbno9HbXpWQnXHK4Mq5FBQ
         FmGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787089882; x=1787694682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=btVpLO5n64WRWMho6cW3+pfoernh4+S1cMEU8koLgv0=;
        b=fxnuUF1dZSa3F3frxjwcDWS8Z6KcoCcK5Z116Eqqido/03CChFq5I3cJvwZo6l9sEo
         mp/9edRXuc5e7CiI9C4oSQRgw8xX+3FaQhynNcVFAQhjjkBMrzy6902y5KcUVIQ1pQUU
         LDGYXjPPg4V5sN+ADFyfee1dW0mcaqclBUQcBMrUCt0BkJaw/0Ht7WiVnmhpbbe/fdq0
         WsrWQ2I0ptqLZd5FTabuZ1ofdVHDAESO0hzY55rp7dxjxqpgDf9ggs+nP2rvx2z79Tij
         pARrh4ChWZj0Yy0H1ev2Och537U9xmzIyLwlLxFcaxFwOLV1lxE4RXCjhhI0+0rqgG01
         B8cA==
X-Forwarded-Encrypted: i=1; AHgh+RrdNdU11NeKv25I3d3AxiYQJ/Ggi2XXwDSWODR7v/LDMBDoyoeBuI+b1Rnck+O9mWYGAjFD9r3Q9fU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWiCQzxONHk/PdD8hMNiPYypnPED7WCsAr5dF5DF9b3qqULW2F
	IQN5mA8D/TYoRUXNtEI3hdCcGguggY6TUrz8BhYVuszDh0T22LoIRXKP
X-Gm-Gg: AR+sD12Up3ZbZJEx1pHbsh+5NRJZq08+LLQ6+ZjPATP0RHk2E0dUIetSxggL85FH0nz
	Q3pZDzoPHb06EiAM2/BVP1IJ5azFPYi6QFCKASseiFrk8BLPTZfvm5H60TjHbdlWquTyM3GOYke
	9qqkIh4L6KzLILnx37npG+ceOmT2/KqRVUEWkp9RS3srwZ3WcfKCEynQMAj83S+O3iwvdJO4dUZ
	xVACmDfNfXD+NPBPCwQxxU7Mm9jMWQHLGGP3CVi1wGsxxWjvvjfgaEdDmzfXmEJc+Ub8Ubqbxe9
	RXHF7l+2lm7jZwhooDl26R3A594lc0k4GTsXeiU//0HSFrAcWvKv8GgkXL8Fs0pABR26OsYHbMN
	pBS3MKl/MyHsRT9XA1IKOTE3t2qLz9i6tK5QPjWjc6zwmQrXvLegitFyLJ2/bUGcF9Um2Lahl5q
	ViucFdBSXHPF3H6TYvsrIpoO6fGeIAgm2mJU88Wb77oQLw/r80GmOoZA46YqWG5n3+Qy5X0Y/AH
	jWkL80JmFUtpJGh6twHLJS61+X9muUos/glpEZP86Ef
X-Received: by 2002:a05:6000:2209:b0:47f:f002:3652 with SMTP id ffacd0b85a97d-482b07f22c1mr1494212f8f.12.1787089882349;
        Tue, 18 Aug 2026 14:51:22 -0700 (PDT)
Received: from MacBookPro ([2001:8a0:6c97:6700:51db:1c3:6be8:694c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14c3775sm160541f8f.26.2026.08.18.14.51.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 18 Aug 2026 14:51:20 -0700 (PDT)
From: Gabriel Rondon <grondon@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	"Nuno =?utf-8?q?S=C3=A1?=" <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: kionix-kx022a: use iio_push_to_buffers_with_ts()
Date: Tue, 18 Aug 2026 22:51:18 +0100
Message-ID: <20260818215118.52664-1-grondon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260818171657.7c1af7b3@jic23-huawei>
References: 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 18 Aug 2026 17:16:57 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> Why do we have both scan and buffer? The kx022a_trigger_handler()
> could just as easily use scan (which is the cleaner solution here)
>
> That leaves get_axis which uses st->buffer as well. Whilst it is a little
> ugly, that can just use the first channel of scan as well.
>
> If you are happy to do so could you make that change as a precursor
> to this set?

Happy to. v2 splits it into a precursor that drops buffer and routes
both the one-shot read and the triggered handler through scan (moving
the IIO_DMA_MINALIGN alignment onto scan), then the conversion on top.

Thanks,
Gabriel
