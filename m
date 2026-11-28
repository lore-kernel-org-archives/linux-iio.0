Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795839705;
	b=01yyJV4OzniCNrUJXKSQnN0zNtDlHrwSsLguxUsjWl7JsuNPN1o8EPxHMWLbazjibqWY
	 CdoCtLOnRMIiTsCfpEy2RrcPcB0AhHc0AiZyhksy6hpZgNgxeuisMeUfH2WX22N1bzsFn
	 DmFpUd9x3XuXZ3M0SKwGCeieu1TAGYcIMDfytZs4r08mCEmfJgkQSzX7KqO6kGxHg0RZS
	 vV4bEHzoik8u/Hv0aQzP7Ij7HhrGeBip5BLUfNAqK6099jWA3Vu3isHDtd948BglGomD2
	 lcLzftcyH+kNoyTkzOHc5YbbnCOpCLVPThAWgxoSBCf81aTP7K0DE+G2ay1qdddai1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795839705;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=uWn6nrSKc0+Vb/G6Fr2yQx8rkkpj2W6aqMJDKCS/joA=;
	b=gdnO2VN+ZQyn95g+FpQvlLL304/efq2wmaphHZGFGX2tTSkWgzWkAt0L2HB3KD44inbk
	 BVrwp2SNl2qMv25L3s+Y5vgH/03aKgBOaKIbQcr8RblILeHOHcIC5ncTgwK+gEIDsAjZ2
	 qwow2D1AQvqPFgDrxRiLcRtBECVIV5UQmxyWmUxlZNVxjOhs90d9O0tHkrB9Qc9/tjLyt
	 vhUugQ+99lALUxy2N75nfhy4qR28+08RTX6RmjQ2qQF5E+Lv4jStntk3T/mM5yfkP9uPw
	 x/aeKFWRlJgh3iEf938E82bs8qTutC82XxVMyboYhh9FyZ1pSM1XRlv2QTbR7xoAWqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GEyEl9ww;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34DB606A31C
	for <linux-iio@vger.kernel.org>; Sat, 28 Nov 2026 04:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GEyEl9ww
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED511F00893;
	Sat, 28 Nov 2026 04:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795839704;
	bh=uWn6nrSKc0+Vb/G6Fr2yQx8rkkpj2W6aqMJDKCS/joA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GEyEl9wwDK6x6dwGhJpmedAX4xkB1HP8Exh2NmEpC5ELas9drmSGYMdv64Cejdxcw
	 qmThoGjyGVat40P0j501HcXFoFYFM+yM0GdSdc31b59zNcmZ/ulUbIPl5WiCTTynfK
	 4Dm4kqYQVkySZBn/5JPaF33YBxKL5Eg+pImgoHG70RWBZFvW6XKiDbzyndwaDu6D1B
	 CAGZpI19dhmaB0y7QoNGLLXll+YkVKoeHikWoas0Lv0XsPIoy3mKlhA/sHyojfFTMH
	 aYh0UHn6evmkyxForv7M894ImS1Y92hPhLgwcBaz208KGSJWIv3W8bmtbbxDPXiMpP
	 jcBRPI5j5ChNA==
Date: Sat, 28 Nov 2026 04:21:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Zhiqi Zhang <zhiqizhangg@gmail.com>
Cc: Tomasz Duszynski <tduszyns@gmail.com>, Arnav Kapoor
 <kapoorarnav43@gmail.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: chemical: pms7003: Reject frames with invalid
 length
Message-ID: <20261128042138.58f1ce3b@jic23-hlaptop>
In-Reply-To: <20261126052717.69095-1-zhiqizhangg@gmail.com>
References: <20261126052717.69095-1-zhiqizhangg@gmail.com>
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

On Thu, 26 Nov 2026 13:27:17 +0800
Zhiqi Zhang <zhiqizhangg@gmail.com> wrote:

> The PMS7003 driver accepts any frame data length up to the size of its
> frame buffer. This lets a device send a frame with a length shorter than
> the two checksum bytes. When that frame is completed,
> pms7003_frame_is_okay() subtracts PMS7003_CHECKSUM_LENGTH and reads the
> checksum from before frame->data.
> 
> Reject data lengths shorter than the checksum before storing the expected
> frame length. Keep other lengths up to the frame buffer size accepted so
> short command replies and compatible Plantower measurement frames can
> still complete.
> 
> Tooling disclosure: I found this bug. OpenAI Codex helped prepare the
> fix, and I reviewed the changes.
> 
> Fixes: a1d642266c14 ("iio: chemical: add support for Plantower PMS7003 sensor")
> Cc: stable@vger.kernel.org

Is this a real fix or hardening against a firmware bug? (So bad hardware
in essence?)  I don't mind hardening but it doesn't want fixes tags
or to be backported.  So either given me more detail on why it can happen
without a firmware bug, or drop those tags for v3.


> Signed-off-by: Zhiqi Zhang <zhiqizhangg@gmail.com>
> ---
> Changes in v2:
> - Accept frame data lengths from PMS7003_CHECKSUM_LENGTH through
>   PMS7003_MAX_DATA_LENGTH instead of only PMS7003_MAX_DATA_LENGTH.
> - Drop the extra length check in pms7003_frame_is_okay().
> 
>  drivers/iio/chemical/pms7003.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/chemical/pms7003.c b/drivers/iio/chemical/pms7003.c
> index c50edb24a..70e7575c0 100644
> --- a/drivers/iio/chemical/pms7003.c
> +++ b/drivers/iio/chemical/pms7003.c
> @@ -231,7 +231,8 @@ static size_t pms7003_receive_buf(struct serdev_device *serdev, const u8 *buf,
>  			return 2;
>  
>  		num = get_unaligned_be16(buf + 2);
> -		if (num <= PMS7003_MAX_DATA_LENGTH) {
> +		if (num >= PMS7003_CHECKSUM_LENGTH &&
> +		    num <= PMS7003_MAX_DATA_LENGTH) {
>  			frame->expected_length = num;
>  			frame->length = 0;
>  		}

