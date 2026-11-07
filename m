Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794092112;
	b=G18qWguf2ZYVRd3rA854DV73aJPsTOEOfMw8PhrcZUgaMuNoxh6+fFMK7eIJlNF/Ru6X
	 ZIx7nQy1QQcH0/NrxlWj4g6R6jjI4HZzqFbOy0zH9o7POFadQ3EH4DRHbhx0VRjinQvAh
	 kOKakknX1HDnHXlI2gKat0j+W6TUMP04lr7+85jsvfNQ63eYe2C4SycnU0S3cNzIRAmg5
	 CbHcYObzoTArPNUL0XW1aJQYjPUqtvGF2r6agQH42eE7NMX9b0NFhzgXjFwAu7nBwEK16
	 j1cNLtxgVYjj0VedDJN0z2Wjtbo4dsixrwgRsoNhyk5iJm6uBXsaK3UHt6lgNbkfsLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794092112;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=eGQMwyj4Cnzif3yTvdGIjkxyu6q8LZTjgfilMPMZYIQ=;
	b=nlp97eOid+3EykbOkqDjYImqhbHb7GtqGX/V4+U/nl2ovklKXG1UtI13/wzgBnPLyZPe
	 r914iXTvTkvJHWx+69Nthegai/LQ+Jd79BN6F72Kw7Trtk1OYaQ4Gbrhtg/Ppw/qlUjMC
	 dXJV022xwpPff/5HWvrkUGc6HJd7GClmucHrFC6BXwaQDU9YZKsPZswo1QAYQVFES8ezB
	 N2ij++QpOCcVgdGG1cT+0+dWE3u61GMBImf2QCtp7cs84ldMt9x8XjG02A+a90YlC6DU6
	 YuTR/ZHW4huMwsOVHuCiX1Op2Oj6aVFBvrC6mQhf6JN1+YHlc1yBy+TSTfpZWaQVRUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hFRfNoYV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB347606A326;
	Sat,  7 Nov 2026 22:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hFRfNoYV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE1FE1F0089F;
	Sat,  7 Nov 2026 22:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794092111;
	bh=eGQMwyj4Cnzif3yTvdGIjkxyu6q8LZTjgfilMPMZYIQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hFRfNoYVnMZSHgwcYPJMZFrAP5fqUcbmV2TuL0nsEdZqHm9V8voIKBcrViLLgiAhe
	 xaF4itrXsJiIxniiiYkO9l9Py4ImGG3EbYD4lWXjWqPfPA8eVWYWPA/MmNakfpj8Fz
	 3Mu9U1IS94aAaT0w9Obb/gDVUqo4FknCbj5APOVtDgT0iOxsxAaz6/FchK5loM+q+p
	 MBvF7ZaHUK66BFl1RKxCdwloG/nLD/pQ2IK0P9T86pp3l/4qniamwrBq+LDvPEvHim
	 Y39lLgCsY59sM0VEApZOhytBUji3+PLhhKKyw7Z9xeZLJ12DtXxbJ84Jif8PawYbG5
	 iIsOOEObwAK2A==
Date: Sat, 7 Nov 2026 22:55:04 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Raffaele Tranfaglia via B4 Relay
 <devnull+raffaele.tranfaglia.gmail.com@kernel.org>
Cc: raffaele.tranfaglia@gmail.com, Rodrigo Alencar
 <rodrigo.alencar@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v3 0/2] iio: test: iio-test-format: char format test and
 overrun checks
Message-ID: <20261107225504.46217911@jic23-hlaptop>
In-Reply-To: <20261103-iio-test-format-char-v3-0-d44074ecca70@gmail.com>
References: <20261103-iio-test-format-char-v3-0-d44074ecca70@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 03 Nov 2026 21:17:06 +0000
Raffaele Tranfaglia via B4 Relay <devnull+raffaele.tranfaglia.gmail.com@kernel.org> wrote:

> Add a KUnit test for IIO_VAL_CHAR formatting and, as suggested by
> Andy, make IIO_TEST_FORMAT_EXPECT_EQ() check that iio_format_value()
> does not write past the formatted string.
> 
> A NUL character is currently emitted as is, so the attribute reads
> back as "\0\n". The test documents this behaviour; please let me
> know if it should rather be rejected or handled differently.
> 
> These patches were written with the help of an LLM-based coding
> assistant, which I used to draft the code and commit messages. I
> reviewed and tested all changes myself.
> 
> Tested with KUnit on arm64 QEMU.
> 
> Signed-off-by: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
LGTM.  I'll apply this to the testing branch of iio.git.
Still time for more review and potentially tags though as I'll
probably not push that out as togreg (which linux-next picks up
and which is supposed to be more or less non rebasing) until mid
week.

Thanks,

Jonathan

> ---
> Changes in v3:
> - Reformat IIO_TEST_FORMAT_EXPECT_EQ() and use a local variable for
>   the size (Andy)
> - Link to v2: https://patch.msgid.link/20261102-iio-test-format-char-v2-0-926100689e62@gmail.com
> 
> Changes in v2:
> - Drop the Assisted-by tag and describe the tool use here (Andy)
> - New patch 1: poison the buffer and check that nothing is written
>   past the string (Andy)
> - Add special, non-printable, NUL and out-of-range cases (Andy)
> - Link to v1: https://patch.msgid.link/20261025-iio-test-format-char-v1-1-e2c208f90e87@gmail.com
> 
> ---
> Raffaele Tranfaglia (2):
>       iio: test: iio-test-format: check that nothing is written past the string
>       iio: test: iio-test-format: add test case for char format
> 
>  drivers/iio/test/iio-test-format.c | 121 +++++++++++++++++++++++++++++++------
>  1 file changed, 103 insertions(+), 18 deletions(-)
> ---
> base-commit: d1425b382b9cc5bd19223fad8ba4a8af3dbe1305
> change-id: 20261025-iio-test-format-char-8a17fbf9a201
> 
> Best regards,
> --  
> Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
> 
> 

