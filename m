Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795769848;
	b=txGQiOMrE9gl4Kpr5NroHi//tY9rhC5tmu695qqwBH0HbuTtIsfHe8mHUIdaCk/I1fa4
	 nOHqFuZV8fuKbqa4It7y6oYA0397eoXIj46qkX79jJVWwdNiVuZM+jb1bCbpfMqwCJX5l
	 a5zWBd92FP4vOI/Wung1U2face839SZ8suTcF51YqhxGFN+a8GFZo9q+lS9qgVYj0mqa3
	 jNKdqdHaNVbkh2vHiiD6/pJbgSFUOSB9cKuymWLhtF5OMH3XZGpgJC26l4GYNUWnswAhH
	 28aKKueQdwS4kR5NrllCtHxFDnjNmfOdYr49VLUHHez068SjYAw5KFBR6vONFv3r5wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795769848;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OnY6t7V3w0nQuA9lKuKMyTP41xIzftjI8cijsOZx7nw=;
	b=1huWVcKQx4h3HW1Uzvf/Uje4QDj8hZY1elmItxnjO947JXz3DjdVEuGBJUYPDEa9Xxut
	 0q7tF1t7gZEj9Boboqk6wEU6LizNduSbi65UsBHRIJ9WdQPChguPMXUKtqe2ECgodBS8v
	 L6e8waaNZPR8xqYXLpuEdMhLSopXXYCRseyg503JFjVj7PsiMFxR+c5PeJr9YQTP2g3SC
	 0/HXA1Sn2JDz+6slD+bG8Sa1OnfebQi6tlvpiBs8beAFAO5846XTFdRg9RB80I/u9thTO
	 k8NUSlz6PdgudSOtr6S1lswXhtJbHFRzEBClarIVkb/lTOc9x8Fw9mdocs42Y1qA3ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q5bG660m;
	arc=none smtp.remote-ip=209.85.222.169
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B565606A327
	for <linux-iio@vger.kernel.org>; Fri, 27 Nov 2026 08:57:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B565606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q5bG660m
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-94961bfe1a0so498774185a.3
        for <linux-iio@vger.kernel.org>; Fri, 27 Nov 2026 00:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795769847; x=1796374647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OnY6t7V3w0nQuA9lKuKMyTP41xIzftjI8cijsOZx7nw=;
        b=Q5bG660mlQP+87sjH3bS5Rn//8Rr0xHy/DwTe10wZL8G7YaIw88DCXLoicoMjtLeOD
         uknEkU31Fh0aF0bc3kWxDYCoHeZtvhGYag1Lf0m/9AvzCfxXjWYeXGHDDAli+9zR/0a8
         qJ4BE3n7WfCVuLBpo9xVo0zsBr4vGv4MMjPpv0558GzebpS3syIqTMEo4rrH6+UL0VGX
         jSKWpq+EJ8JJD2VJexFBByuZyPJ+29qUmQ+2wubo9X5cb41zcvjBoE50+zZLbshF0COe
         icMN1eMs0Kco98CZ/M8nuVWHfD69mNeDwDJYYt4xX+7bKgX21yw+Arlx6YDHvxvI67bC
         3wrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795769847; x=1796374647;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OnY6t7V3w0nQuA9lKuKMyTP41xIzftjI8cijsOZx7nw=;
        b=Em5qu4CcTiMWZQJzi+6/i/BPfRjggBegVy7BPgJyCKZJSHxX/MN9TJebuN2Kdc9V21
         nOjB8G54FPSkt+cyu0Gmi+c74Ysle/Iu3LZo5DPxexrlDR+KtJ/8cmc5qvmj1WOuZOXJ
         VyP3fhSKDknpLV3RIozHzY/MaDRoxsX0ksLu3pYnDt7PTkZDK0bOLHcGZogci6bqLQoP
         U6avLxoYUNHww7vmIwMf862UCOiNs7Pj6SzJEZ7w83zrMFRxseNpDyNVl0SrmUIoj5+7
         m5cvFT2iKi0aMi2mpvYbSVNbGVvuIwZVjzDHnf6Gea+44ydK8U5jPNbOBsxXgIy4KEE5
         Qfpg==
X-Forwarded-Encrypted: i=1; AL+hErHh0uVcA3kRpcOGXz0gP5fE8RhlLLt3Ydt1GAYLLmXSHk7sgZnfM7KE2RRNmYi17aTL3pcOVPP5K/s=@vger.kernel.org
X-Gm-Message-State: APuU4Z9I2m3pqBNtqL4cmbwx1QqJv46Z73MKNvFCDybr5iAg2KFwLdOh
	VoPfhewy8Urihg+SIAp902AgHcuD5+/cGrk8MOmzFaGnnxExd5l9Jp1FRevmrVgh/7g=
X-Gm-Gg: AZFdTZeImiTZapAwD7eylpcR4OpFUvG4a3U6YeuTiQ0hC/PfwH1ALdAT4+smpbqbQt5
	ChC3muaRMzgS51i44wGlMjUfjNWxMyVWGYv00pmeOo73Te+HS3L4gFAmbXXcraCSYrVnzkerhQV
	EA38kpB+bpe8Q2LHwxjJFEobYZk+7Br7rZ4Y16MY0OXydeJrji40tabHTzJxVZJh26C2NSAx17c
	Qdau6k/lWBcSPFoffc0AKwak87JZVi5/sPoxPY0Matg8OVfXUy2BAkcXG1r6UnUa0E49JGiJIdH
	5whwM7G5IGjbSOZ9YjkHkjWdQ+SRXywjoHR1IfbkNYb2xczszq7Hj06CJ2w6Od2G2NSpv/VTkun
	NacHRN8QyFymMJ1qXJXVJMVpqXP+hWDK2abuuh9e4Od3Ve+nW5/eWd0BBd/AnVURU1/WyX6Vrv9
	Q+9pk37nwX6LIcyG1EqRI4sWXBtncsTU61HmnjuCtWy1kOLEeBjh07HzmdbT2FKEnChpOhPUGQG
	M5gUb/9vynRR0A/7fcvJu8GxXs3hxJ1ys4pQzb5c82ZEcMJZ3Pmdx43eo98ZsQw9tVbJVukbdNn
	R6DZzCboenp+vcBO/VMt5LBSySwzsryiEXOwB0Nlo9n8mEH4E9iVCmGj
X-Received: by 2002:a05:620a:6f06:b0:939:2d77:d6a8 with SMTP id af79cd13be357-949ba9f5f36mr4256539085a.34.1795769847199;
        Fri, 27 Nov 2026 00:57:27 -0800 (PST)
Received: from localhost ([2600:4808:5693:8201:394e:8b9f:994c:b59f])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb0315f4sm1759249585a.3.2026.11.27.00.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 00:57:26 -0800 (PST)
From: Marco Chen <marcochen.dev@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Linus Walleij <linusw@kernel.org>,
	linux-iio@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH 0/2] tools: iio: iio_generic_buffer: fix exit status
Date: Fri, 27 Nov 2026 03:57:20 -0500
Message-ID: <20261127085722.126797-1-marcochen.dev@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes a wrong exit status in two cases for 
iio_generic_buffer. These issues were found during the process of 
using iio_generic_buffer in a bash shell script while testing
buffered reads with the max30102 pulse oximeter.

All patches were tested on a Raspberry Pi 4 running the IIO
subsystem tree testing branch with the max30102. 

For patch 1, a normal buffered capture exited with 1 before and
0 after, with and without the -e flag.

For patch 2, running iio_generic_buffer as a non-root user exited
with 0 before and 254 (-ENOENT) after.

Marco Chen (2):
  tools: iio: iio_generic_buffer: return 0 on success
  tools: iio: iio_generic_buffer: return error if no channels can be
    enabled

 tools/iio/iio_generic_buffer.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)


base-commit: 39508411b82d4dc29dd245bb471ec9ecc1111c9d
-- 
2.56.1

