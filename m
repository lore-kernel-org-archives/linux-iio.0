Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D868437BE8A
	for <linux-iio@vger.kernel.org>; Mon,  2 Feb 2026 15:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770046214; cv=none; b=MSF1kbvn87Osf48WyRbAAp2V8fG9Rgz8mgq7zIGHXLMdyRdg5JAj33lUi2MQUa3nVSj6GPZ8hMbCR5pzEFLcRl9RQBmdgad4v1BwTHyReCWmE3QEn+tX8Q8JEqJroNRIc9k4q2fRhssPbw2Lz2jpM5zK+ysVaK4zPRxH4Pf53RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770046214; c=relaxed/simple;
	bh=2k/8afkIWZSdo5QciZuWLdMGT4c5f0pC782XI+ZtzX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B1LFq4rR9ekTjQhHlmUiC6uhp8X2am/aaMV9GpKRQ69tQKOPcT7PvgjUC0JggKG4UQoM4hiWN/ZCx3rSKZxRLYmo8B38qY1Uz5ENxqELCK0NEk28unJA0Z6OgNrafwsh+LEbwbmprHVZ24m+UJE1WnSNPihUC1zxQJzNFsamOF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cqf31olL; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cqf31olL"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4359a316d89so3473009f8f.0
        for <linux-iio@vger.kernel.org>; Mon, 02 Feb 2026 07:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770046211; x=1770651011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2k/8afkIWZSdo5QciZuWLdMGT4c5f0pC782XI+ZtzX0=;
        b=Cqf31olLhPIvPianEIQCbpnC/6hFeOVEgBOcZVobl6/XNsiAiy7iEMNx954WGA1SB7
         jc7UsQT2IXBjAjCvVERBdyWvx+MCQInqiqRH8CCZsIkmFNw8WYOuzW1elrlWFlYz73cM
         0eZYQ+mRKshrcSWkbu0J4f/YXfkY6C+8ljODwRupLIcNhHcywSeSnAT4v/NfdbwL2zMs
         pZNc8TXDBz4T4zKOe5iDy1LTzj1Mn3T7Bc3gJxaEc37XxUVW72jcbfJBHLPV9axR/qS0
         tOH/Ld1SwOTH/XYdxtFTm2RXSGeOvK6c/JsVACgHiiqVGexH8lCDnGHd582Z/Luf5Im7
         jSEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770046211; x=1770651011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2k/8afkIWZSdo5QciZuWLdMGT4c5f0pC782XI+ZtzX0=;
        b=u9j+iHM24NAA/+8Ef519JFBN1vFpjG7uvbXx9eMXUmz/r5d5hhEWnffPmvu2OhxAeW
         IXTWE3fsK9uoJ5bvyItjqbsyYsuHGeDkB4m2c4iBzaRWeo+rMyuQUFHEudjmS7Sx/He/
         C+2/Ye3nTUilsLopM5dAoOqtyEMQZj7ZudM4DihWb7bGqv+1rwGiLdvHMkz+II1XFdYA
         9wjzi9M7xtoQz4+puOd7kwE+EbB1Gl7tYVppARPEdZSLQ8s0tP3AP4+EeWLkBcEALeDL
         thC7khaihbTotKspuVkybEQOrcEiVLFsUo4RkmK01Y9j+F24cyhLe8c/2jhuhVw4nAh8
         n/1g==
X-Forwarded-Encrypted: i=1; AJvYcCX+ahO6JCQ/IAlWFh2XVoog81Tr74pOj3mgP4207rKfVYcvimctZc9ONErfrNEKqYa/wLBWHBtBHTo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz11wZQqAUfCdsF3BJr0KrDGb94vvmKptxw7zuiDgnLDusYWI1T
	XRXwWoV0SUHihhzS2p/QWgL3aaNmlyKrpqUt+LECMqAacjP+UcxqHPXpRb2s/w==
X-Gm-Gg: AZuq6aJQxjiYewXaoWBqXrQvXHedTE+LJuMmNTzlOQ9ZoU0M0W4CyCGkj7D8ucxtlaM
	XyylceR0g0lR4eIpv1DOT6aXZzNC1tyYoqqBF/XYJyzotlctEAH71vLnziGfmxLLhhMAlez37EQ
	0Ca6CTfv/gGdWSJb105YfuoTR77GuFhsdWmboMrmBKsxikR7PtH+bbRrqCKCFqhiPSN4jzeYbhu
	kFlS+1GTDeL3/7G5jWisXjD4XUL7A/Zg7QVGa6CztwIgsU85m4ZMMSIgxmnd7HPTAVJypZI0RXk
	TBUBfISIwaeC2zdSf3eWklhoTHX91+5MMR9gL18jptsOhRVWVEoS+Oa9rymj5Fo+yNwCa+WP7sm
	Oj2bCV7XFi8fbt1xETMyz5S4tNr+HSgVE+8JhYxEmQN9wmW8X3ENLOIYZ5QlsaloS95GQzJduCg
	aLM2F1tdbuD0289ZJl84DWyDf7xeC1DC6eLdp0djr716NrSzpW8Iknf8Q7
X-Received: by 2002:a05:6000:1861:b0:432:8504:befd with SMTP id ffacd0b85a97d-435f3aa7441mr17364642f8f.32.1770046210971;
        Mon, 02 Feb 2026 07:30:10 -0800 (PST)
Received: from DB-VM.1337.ma ([197.230.240.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e1353ac2sm47269977f8f.38.2026.02.02.07.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 07:30:10 -0800 (PST)
From: Taha Ed-Dafili <0rayn.dev@gmail.com>
To: rdunlap@infradead.org
Cc: 0rayn.dev@gmail.com,
	Michael.Hennerich@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	dlechner@baylibre.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-doc@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel-mentees-archive@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	me@brighamcampbell.com,
	nuno.sa@analog.com,
	skhan@linuxfoundation.org
Subject: Re: [PATCH v2 1/4] docs: iio: adxl345: fix typos and grammar
Date: Mon,  2 Feb 2026 10:30:08 -0500
Message-ID: <20260202153008.16588-1-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <6cee15c9-13d4-44d9-bbb2-4a7a53fe23f2@infradead.org>
References: <6cee15c9-13d4-44d9-bbb2-4a7a53fe23f2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for the catch, Randy.

That makes sense; I'll revert that change in v3.

Best, Taha
