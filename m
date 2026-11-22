Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.208
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795382540;
	b=Rp1u4A5B5tNuAZ0umNnsBNHT57e++npiUF2nUkSmYBLSE0wXUu+cfYB5gq3l5CkQnBhI
	 ViZTcJzAxC66P2nWq/3qHUWvcU4wFW2MYu7YUxiCpJdOay8Y64dxQPogTjHkUpeE7YtJA
	 CUzTmyVpc0RUxA+tNUvAdT6Wn66QEHFH6K6EWtF9hrkG9mMJgJ/kI9+rvHSXPRjO/Ixf1
	 aB0iUV2RqgUVGjZeZRRj3uFx/fOSFDjqEKMJXWyb7M3/fWRxc0ZZnhgjkcU3omsHtK20n
	 SqcQJZnE83VmS+0Jf3uqp3gzfIyzW/jvzGHTG3Iwq1ec2qEzMmDR8d+m3kccK/LT3+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795382540;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 MIME-Version;
	bh=4fufsDQ1xvC3zbg+yGa1jsAS5bqwuf7ZledZ5/n7XQo=;
	b=t1zUJb3cGlBev+A9aKqaiJqSjAMci0VPqvBcW68Nl5PBdsBv7db4fLqzwoKpN7wYJJYR
	 66C+dD7pELI/nQFKKLczR07YrJmsO6tRwx0iQE63apODpD7zzrYH658aYYf5vKCp0UoXn
	 zuCy+/fz445weKU0cvYDQe+Wop3KAKdxMQb2LnHVaJL9EeUCQ/eQYgcgAiMM3qHJEoux+
	 jj2vrebS3PJanqYNXi+Q7l4d9Ktg0Bf/+ZbJBbDYjQ4NKNxq1KTgslOYXTyjAgacoA6AH
	 5JhzXGC7HCPzqyAhoQhxeA1J+7cEUE4lf2fwkGQg5LGq90kxtPaY1j3+dMjgZ7/sMmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=JVJPIi0E;
	arc=none smtp.remote-ip=91.218.175.208
Received: from mta0.migadu.com (out-208.mta0.migadu.com [91.218.175.208])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A546606A320
	for <linux-iio@vger.kernel.org>; Sun, 22 Nov 2026 21:22:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A546606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=JVJPIi0E
X-Envelope-To: linux-iio@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=4fufsDQ1xvC3zbg+yGa1jsAS5bqwuf7ZledZ5/n7XQo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795382536; v=1; x=1795987336;
 b=JVJPIi0EDwWXRiH/d2wzluigPGkV5m4LZO+SNnp7wUmcsRtzN71WUg7z+jL6vrjaVv24MJOd
 IDxeYaySdblhDH6wrScbqyy5OJfJ4UmC1jEEqXxB1iusR+lMvpRnFAZmnTaecsgMQBL6QNim3F9
 rayvxA4Y0x2gUBUrCRFnH6lk=
X-Envelope-To: linux-iio@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 71d8f717f0abf706;
	Sun, 22 Nov 2026 21:22:16 +0000
X-Mizu-Trace-ID: 71d8f717f0abf706
X-Migadu-Flow: FLOW_OUT
From: Igor Korotin <igor.korotin@linux.dev>
To: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Alice Ryhl <aliceryhl@google.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Mark Brown <broonie@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Shuai Liu <847807867@qq.com>, linux-iio@vger.kernel.org,
 linux-i2c@vger.kernel.org, rust-for-linux@vger.kernel.org,
 driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Subject:
 Re: [RFC PATCH v7 2/4] i2c: rust: implement SMBus access via IoBackend
Date: Sun, 22 Nov 2026 21:22:14 +0000
Message-ID: <179538253428.9669.5532258807115715261@linux.dev>
In-Reply-To: <20261109155743.83740-3-muchamadcoirulanwar@gmail.com>
References: <20261109155743.83740-1-muchamadcoirulanwar@gmail.com>
 <20261109155743.83740-3-muchamadcoirulanwar@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Reviewed-by: Igor Korotin <igor.korotin@linux.dev>

Igor
