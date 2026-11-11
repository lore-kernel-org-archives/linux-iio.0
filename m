Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.222
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794409108;
	b=uvH8siJGXQtSQhyVOAZqNHVO0VvjDG3h42JuCYwyiiRcBc343SZTgZgHK4S4C5dJ0/76
	 DQMuf1s877hI0EtIdcppiIAOuhqJz/qxve8W29U9wydFeoRCiOjs+UZoXdUcQrKqAsdtL
	 sDNJMos329PSwTt0CYhzGY6OyvdDBha81P1O/+hQlD2o3aoNGP+MD2P6UT5VueYCpvYnf
	 CTrFZ58tE5jukJWxbMFyNdC70PyFbDYxitg6xrBF8bxqftji63NHAEn2sTd53fRKTEqaI
	 0xSljPnEEF7tBoIB8W8mfbDboFWNZZMLaMWS/Bjjm2ULRVvCr7Hr9QRTmsuTEATPjtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794409108;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 MIME-Version;
	bh=byL/9IM6xgjdPi5Ss/cz8AdXkgWexIzqBw9kg9a3atE=;
	b=fXO7VE1JVBP4rpHLEFxBjWLibY3ynWB9wyGO5LA06lJGTpBY+W/UkKlxWIMlIhucRxwA
	 QeqYmlb2w+wAI6PsM+HgsV5nhNnljudZdr5/NoJXAqNgiZFrrvHTAAuY2xY+7oqFC08qr
	 Jwdphm5xVM3x6rx0bTA6SotAtYuIarnUMBYU7Mxcsh9W4mobVE1HO2aZ9svWtSIXCjRJL
	 VDw5EJGUXD+KK3uJM6/BUrw4caYusdHvnTghK1px5mQR3UAedKrCjeqMdnCeqxwujSaLf
	 ASQQz3O8WI/4b5zUJXZR5GRIdUxdNuhql/7Hr9Ng9r8w+wuyoNQLfPIphuGaqgTT6/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=bT+MHnvQ;
	arc=none smtp.remote-ip=95.215.58.222
Received: from mta1.migadu.com (out-222.mta1.migadu.com [95.215.58.222])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2CD606A88A
	for <linux-iio@vger.kernel.org>; Wed, 11 Nov 2026 14:58:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B2CD606A88A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=bT+MHnvQ
X-Envelope-To: linux-iio@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=byL/9IM6xgjdPi5Ss/cz8AdXkgWexIzqBw9kg9a3atE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794409105; v=1; x=1795013905;
 b=bT+MHnvQe9RepUohkjLvksKWNYTiu9JXdRJihGeN0HMqqisGTdqqZcz1xNgKsA827RcFkb63
 WWt7b7ifDkmoOv7E7hf3vlPcmr4Ka76BCwQiGJ5voaBXLUz/iOaS6VnoGyAitgfo1xVgJYMgtDC
 SYvUJDspR7Ee94EHcIQFUxyg=
X-Envelope-To: linux-iio@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 36196609946a065f;
	Wed, 11 Nov 2026 14:58:08 +0000
X-Mizu-Trace-ID: 36196609946a065f
X-Migadu-Flow: FLOW_OUT
From: Igor Korotin <igor.korotin@linux.dev>
To: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
 Alice Ryhl <aliceryhl@google.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>,
 Brandon StJohn <branstj@gmail.com>, linux-iio@vger.kernel.org,
 linux-i2c@vger.kernel.org, rust-for-linux@vger.kernel.org,
 driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v6 0/4] iio: position: add Rust driver for ams AS5600
Date: Wed, 11 Nov 2026 14:58:08 +0000
Message-ID: <179440908805.1963.3189482737225975976@linux.dev>
In-Reply-To:
 <CAO26r3RofEz-YCnaUfTTb+7phdEzUqG5iwVObuho_EgW5Ep44Q@mail.gmail.com>
References: <20261016154819.17936-1-muchamadcoirulanwar@gmail.com>
 <CAO26r3RofEz-YCnaUfTTb+7phdEzUqG5iwVObuho_EgW5Ep44Q@mail.gmail.com>
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

Hi Coirul,

Sorry for the slow reply. Co-developed-by/Signed-off-by is fine with me
-- your call either way, I don't mind.

Cheers
Igor
